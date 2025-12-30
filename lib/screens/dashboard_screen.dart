import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:kisanagi/services/crop_service.dart';
import 'package:kisanagi/services/disease_service.dart';
import 'package:kisanagi/services/user_service.dart';
import 'package:kisanagi/theme.dart';
import 'package:kisanagi/widgets/weather_widget.dart';
import 'package:kisanagi/widgets/crop_card.dart';
import 'package:kisanagi/widgets/recent_scan_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserService>().currentUser;
    final crops = context.watch<CropService>().crops;
    final recentScans = context.watch<DiseaseService>().recentScans;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back! 👋',
                    style: context.textStyles.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    user?.name ?? 'Farmer',
                    style: context.textStyles.titleLarge,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => context.push('/notifications'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.horizontalLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    const WeatherWidget(),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Crops 🌾',
                          style: context.textStyles.headlineSmall,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            'Add',
                            style: context.textStyles.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: AppSpacing.horizontalLg,
                  itemCount: crops.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) => CropCard(crop: crops[index]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.horizontalLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Recent Scans 🔍',
                      style: context.textStyles.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    bottom: index == recentScans.length - 1 ? AppSpacing.xxl * 2 : AppSpacing.md,
                  ),
                  child: RecentScanCard(disease: recentScans[index]),
                ),
                childCount: recentScans.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        icon: const Icon(Icons.camera_alt, size: 28),
        label: Text(
          'Scan Crop',
          style: context.textStyles.titleMedium?.copyWith(
            color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            context.push('/community');
          } else if (index == 3) {
            context.push('/profile');
          }
        },
      ),
    );
  }
}
