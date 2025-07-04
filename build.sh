echo "==================================="
echo "Initializing Repo and Cloning Manifests"
echo "==================================="
# Removing old manifests
rm -rf .repo/local_manifests

# Initialize the LineageOS repository
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs --depth=1

# Clone local manifests for r8s
git clone https://github.com/exynos990fe/manifest_r8s.git .repo/local_manifests

echo "==================================="
echo "Running repo sync Script"
echo "==================================="

# Run repo sync
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

echo "==================================="
echo "Setting up Build Environment"
echo "==================================="

# Source the build environment setup script
source build/envsetup.sh

echo "==================================="
echo "Applying Repopicks"
echo "==================================="

# Apply specific changes using repopick
repopick 419347
repopick 435574

echo "==================================="
echo "Configuring Lunch Target"
echo "==================================="

# Choose the lunch target for r8s
lunch lineage_r8s-bp1a-userdebug

echo "==================================="
echo "Navigating to Croot and Starting Build"
echo "==================================="

# Start the build process for r8s
m bacon

echo "==================================="
echo "Build process completed!"
echo "==================================="
