Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD35BB332
	for <lists+linux-pm@lfdr.de>; Fri, 16 Sep 2022 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIPUGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Sep 2022 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIPUG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2022 16:06:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B197B9411;
        Fri, 16 Sep 2022 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663358785; x=1694894785;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VwaTlTJBVVv07UusDTC05D7hwHhcnsqfYzaVzoJAAYc=;
  b=PI+dxi90Nm4Lr4G7ubg7w0J1MrO+w+BU0Pxl3+pywegPCio/p8fsmr+m
   mosad6z0RfCdDn6FXmFFk6KOzB0g5WxARF6/kooNaYvJSvpX7nb5/+zek
   0rFIFM2MekEHWLPoYj+ZoAVroBOql4LYl5/PfWJSUmJbnizeGi9HfvU79
   OlMEmxtIv43gG5RjyU/iaHN3IOe/PqpZlhLkQlK4Zp0y3Rx9tU/yDlYav
   ls53oCU23HDdJ6gOzNLAerEqPKMyzyWnK0Uk4xvKUyanjjGrsp2394M0E
   h3YqhrA2evXmZfd2xdH1/3bqK9UBY9DsJ0RV815wXQzjtC3WnaD2hkh8R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325347196"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="325347196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="650981444"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2022 13:06:22 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZHbR-00027G-14;
        Fri, 16 Sep 2022 20:06:21 +0000
Date:   Sat, 17 Sep 2022 04:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 d5538ab91d3a9a237805be6f8c6c272af2987995
Message-ID: <6324d739.Ulh6jXX5QoKvYKlU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: d5538ab91d3a9a237805be6f8c6c272af2987995  Add linux-next specific files for 20220916

Error/Warning reports:

https://lore.kernel.org/linux-media/202209162214.LZFXhn2B-lkp@intel.com
https://lore.kernel.org/linux-mm/202209150141.WgbAKqmX-lkp@intel.com
https://lore.kernel.org/linux-mm/202209150959.hEWCNjXH-lkp@intel.com
https://lore.kernel.org/linux-mm/202209160607.sE3qvgTy-lkp@intel.com
https://lore.kernel.org/linux-mm/202209170126.OGPr2Nd1-lkp@intel.com
https://lore.kernel.org/llvm/202209161913.VNdFWG7o-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/clk/xilinx/clk-xlnx-clock-wizard.ko] undefined!
ERROR: modpost: "dm365_vpss_set_pg_frame_size" [drivers/staging/media/deprecated/vpfe_capture/isif.ko] undefined!
ERROR: modpost: "dm365_vpss_set_sync_pol" [drivers/staging/media/deprecated/vpfe_capture/isif.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "vpss_clear_wbl_overflow" [drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.ko] undefined!
ERROR: modpost: "vpss_enable_clock" [drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.ko] undefined!
ERROR: modpost: "vpss_enable_clock" [drivers/staging/media/deprecated/vpfe_capture/isif.ko] undefined!
ERROR: modpost: "vpss_select_ccdc_source" [drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.ko] undefined!
ERROR: modpost: "vpss_select_ccdc_source" [drivers/staging/media/deprecated/vpfe_capture/isif.ko] undefined!
arch/arm/include/asm/arch_gicv3.h:18:41: error: implicit declaration of function '__ACCESS_CP15' [-Werror=implicit-function-declaration]
arch/arm/include/asm/arch_gicv3.h:18:55: error: 'c12' undeclared (first use in this function)
arch/arm/include/asm/arch_gicv3.h:19:63: error: 'c11' undeclared (first use in this function)
arch/arm/include/asm/arch_gicv3.h:21:41: error: implicit declaration of function '__ACCESS_CP15_64' [-Werror=implicit-function-declaration]
arch/arm/include/asm/arch_gicv3.h:22:55: error: 'c4' undeclared (first use in this function)
arch/arm/include/asm/arch_gicv3.h:22:62: error: 'c6' undeclared (first use in this function)
arch/arm/include/asm/arch_gicv3.h:29:63: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
arch/arm/include/asm/arch_gicv3.h:35:63: error: 'c9' undeclared (first use in this function)
arch/arm/include/asm/arch_gicv3.h:44:9: error: implicit declaration of function 'write_sysreg' [-Werror=implicit-function-declaration]
arch/arm/include/asm/arch_gicv3.h:48:16: error: implicit declaration of function 'read_sysreg' [-Werror=implicit-function-declaration]
arch/parisc/lib/iomap.c:363:5: warning: no previous prototype for 'ioread64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:373:5: warning: no previous prototype for 'ioread64_hi_lo' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:448:6: warning: no previous prototype for 'iowrite64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:454:6: warning: no previous prototype for 'iowrite64_hi_lo' [-Wmissing-prototypes]
drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead
drivers/scsi/qla2xxx/qla_os.c:2854:23: warning: assignment to 'struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
drivers/thermal/thermal_helpers.c:79:6: warning: Redundant initialization for 'ret'. The initialized value is overwritten before it is read. [redundantInitialization]
make[5]: *** No rule to make target 'drivers/crypto/aspeed/aspeed_crypto.o', needed by 'drivers/crypto/aspeed/'.
s390-linux-ld: (.text+0x24a4): undefined reference to `ftrace_likely_update'

Unverified Error/Warning (likely false positive, please contact us if interested):

ERROR: modpost: "devm_ioremap_resource" [drivers/crypto/ccree/ccree.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   `-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|-- alpha-randconfig-r014-20220916
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-buildonly-randconfig-r003-20220916
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-r043-20220916
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm-randconfig-c003-20220916
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c11-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c12-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c4-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c6-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c8-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:c9-undeclared-(first-use-in-this-function)
|   |-- arch-arm-include-asm-arch_gicv3.h:error:implicit-declaration-of-function-__ACCESS_CP15
|   |-- arch-arm-include-asm-arch_gicv3.h:error:implicit-declaration-of-function-__ACCESS_CP15_64
|   |-- arch-arm-include-asm-arch_gicv3.h:error:implicit-declaration-of-function-read_sysreg
|   `-- arch-arm-include-asm-arch_gicv3.h:error:implicit-declaration-of-function-write_sysreg
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a003
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a012
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a014
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a016
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- ia64-allmodconfig
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   `-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|-- ia64-randconfig-r026-20220916
|   `-- make:No-rule-to-make-target-drivers-crypto-aspeed-aspeed_crypto.o-needed-by-drivers-crypto-aspeed-.
|-- loongarch-randconfig-r022-20220916
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
clang_recent_errors
|-- arm64-randconfig-r012-20220916
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-function-apply_alternatives_vdso
|-- arm64-randconfig-r013-20220916
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-function-apply_alternatives_vdso
|-- arm64-randconfig-r025-20220916
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-function-apply_alternatives_vdso
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- hexagon-buildonly-randconfig-r002-20220916
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- hexagon-randconfig-r015-20220916
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- hexagon-randconfig-r032-20220916
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- hexagon-randconfig-r033-20220916
|   |-- drivers-media-platform-mediatek-mdp3-mtk-mdp3-comp.c:warning:unused-variable-mdp_comp_dt_ids
|   `-- drivers-media-platform-mediatek-mdp3-mtk-mdp3-comp.c:warning:unused-variable-mdp_sub_comp_dt_ids
|-- i386-randconfig-a002
|   |-- ERROR:___ratelimit-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:__per_cpu_offset-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:__phys_addr-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:__ubsan_handle_out_of_bounds-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:__warn_printk-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:_printk-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:cpu_number-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:kvm_find_user_return_msr-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:kvm_spurious_fault-arch-x86-kvm-kvm-intel.ko-undefined
|   |-- ERROR:smp_call_function_single-arch-x86-kvm-kvm-intel.ko-undefined
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- i386-randconfig-a015
|   |-- ERROR:__cpuhp_remove_state-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:__cpuhp_setup_state-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:_printk-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:boot_cpu_data-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:cpu_bit_bitmap-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_msr_probe-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_pmu_register-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_pmu_unregister-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:x86_match_cpu-arch-x86-events-intel-intel-cstate.ko-undefined
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- powerpc-buildonly-randconfig-r005-20220916
|   |-- drivers-macintosh-ams-ams-i2c.c:error:conflicting-types-for-ams_i2c_remove
|   `-- drivers-macintosh-ams-ams-i2c.c:error:incompatible-function-pointer-types-initializing-void-(-)(struct-i2c_client-)-with-an-expression-of-type-int-(struct-i2c_client-)
|-- riscv-randconfig-r033-20220915
|   |-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-get_symbol_offset:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_markers
|   |-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-get_symbol_offset:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_names
|   |-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_names
|   |-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_offsets
|   |-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_relative_base
|   `-- ld.lld:error:vmlinux.a(kernel-kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_token_index
|-- s390-buildonly-randconfig-r005-20220916

elapsed time: 720m

configs tested: 62
configs skipped: 2

gcc tested configs:
i386                                defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
s390                                defconfig
x86_64                           allyesconfig
i386                          randconfig-a005
arc                  randconfig-r043-20220916
i386                             allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
arm                                 defconfig
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
arc                               allnoconfig

clang tested configs:
i386                          randconfig-a002
riscv                randconfig-r042-20220916
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220916
s390                 randconfig-r044-20220916
hexagon              randconfig-r041-20220916
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
