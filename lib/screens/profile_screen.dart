import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:kisanagi/services/user_service.dart';
import 'package:kisanagi/services/disease_service.dart';
import 'package:kisanagi/models/disease_model.dart';
import 'package:kisanagi/models/user_model.dart';
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserService>().currentUser;
    final scans = context.watch<DiseaseService>().diseases;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context, user),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user?.name ?? "Farmer"}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Phone: ${user?.phoneNumber ?? "Not set"}'),
            const SizedBox(height: 8),
            Text('Language: ${user?.language ?? "en"}'),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Scan History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: scans.isEmpty
                  ? const Center(child: Text('No scans yet'))
                  : ListView.separated(
                      itemCount: scans.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final DiseaseModel d = scans[index];
                        Widget leading;
                        if (d.imageUrl.startsWith('assets/')) {
                          leading = Image.asset(d.imageUrl, width: 56, height: 56, fit: BoxFit.cover);
                        } else if (File(d.imageUrl).existsSync()) {
                          leading = Image.file(File(d.imageUrl), width: 56, height: 56, fit: BoxFit.cover);
                        } else {
                          leading = const SizedBox(width: 56, height: 56, child: Icon(Icons.photo));
                        }

                        return ListTile(
                          leading: leading,
                          title: Text(d.name),
                          subtitle: Text('${d.severity} • ${d.detectedAt.toLocal().toString().split('.').first}'),
                          onTap: () => context.push('/diagnosis/${d.id}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, UserModel? user) {
    final nameCtrl = TextEditingController(text: user?.name ?? '');
    final phoneCtrl = TextEditingController(text: user?.phoneNumber ?? '');
    final langCtrl = TextEditingController(text: user?.language ?? 'en');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
            TextField(controller: langCtrl, decoration: const InputDecoration(labelText: 'Language')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final updated = (user ?? UserModel(id: 'user_${DateTime.now().millisecondsSinceEpoch}', name: '', phoneNumber: '', language: 'en', createdAt: DateTime.now(), updatedAt: DateTime.now()))
                  .copyWith(name: nameCtrl.text, phoneNumber: phoneCtrl.text, language: langCtrl.text, updatedAt: DateTime.now());
              context.read<UserService>().updateUser(updated);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
