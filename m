Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45487C6DD1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjJLMS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjJLMSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 08:18:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF993B7;
        Thu, 12 Oct 2023 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697113131; x=1728649131;
  h=date:from:to:cc:subject:message-id;
  bh=79e5ZRtlnk/fUnsfvf3b1MWhOqkUYVPkc3a6XJjE18U=;
  b=j1+NmTjtlaJQQnwQRwfl9hHGpo7D1gmjMhwCkpOu6kl5CN3DZRtbvYUb
   eVe6Y23T3g6VV1qccKWZykwe0xASROREnFyL4O0pW5s6fvi/WmKKwNnlH
   U58OJp74l3fBOvgqGGjF6mfGZ5CPUwAtEtGV8HDetpVoS8lbAokkvBwb5
   RngrqQyePWi/4V/87QOPPfQUBSq8/3Q69pmHOx0CPNiGqRiUop79yRe0O
   YOHobO+bymOEzvL/G15olOldwAFx1X9YL7jnRIAb3ByXU9zUDU7A4Iv8q
   TrgEQfBjpTXBuiF5ORlaNykkeL5VqrgjqceGqZkyx+FD4Axn30KTBpe/g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364271541"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="364271541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898088566"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898088566"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2023 05:17:02 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqueN-0003Qf-0u;
        Thu, 12 Oct 2023 12:18:47 +0000
Date:   Thu, 12 Oct 2023 20:18:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2228a4b78d695e08b4f653c9c1f8d9e8bebc5a97
Message-ID: <202310122002.TjZEPm6H-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2228a4b78d695e08b4f653c9c1f8d9e8bebc5a97  Merge branch 'thermal-core-next' into bleeding-edge

elapsed time: 1202m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231012   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231012   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231012   gcc  
i386         buildonly-randconfig-002-20231012   gcc  
i386         buildonly-randconfig-003-20231012   gcc  
i386         buildonly-randconfig-004-20231012   gcc  
i386         buildonly-randconfig-005-20231012   gcc  
i386         buildonly-randconfig-006-20231012   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231012   gcc  
i386                  randconfig-002-20231012   gcc  
i386                  randconfig-003-20231012   gcc  
i386                  randconfig-004-20231012   gcc  
i386                  randconfig-005-20231012   gcc  
i386                  randconfig-006-20231012   gcc  
i386                  randconfig-011-20231012   gcc  
i386                  randconfig-012-20231012   gcc  
i386                  randconfig-013-20231012   gcc  
i386                  randconfig-014-20231012   gcc  
i386                  randconfig-015-20231012   gcc  
i386                  randconfig-016-20231012   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231012   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231012   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231012   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231012   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231012   gcc  
x86_64       buildonly-randconfig-002-20231012   gcc  
x86_64       buildonly-randconfig-003-20231012   gcc  
x86_64       buildonly-randconfig-004-20231012   gcc  
x86_64       buildonly-randconfig-005-20231012   gcc  
x86_64       buildonly-randconfig-006-20231012   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231012   gcc  
x86_64                randconfig-002-20231012   gcc  
x86_64                randconfig-003-20231012   gcc  
x86_64                randconfig-004-20231012   gcc  
x86_64                randconfig-005-20231012   gcc  
x86_64                randconfig-006-20231012   gcc  
x86_64                randconfig-011-20231012   gcc  
x86_64                randconfig-012-20231012   gcc  
x86_64                randconfig-013-20231012   gcc  
x86_64                randconfig-014-20231012   gcc  
x86_64                randconfig-015-20231012   gcc  
x86_64                randconfig-016-20231012   gcc  
x86_64                randconfig-071-20231012   gcc  
x86_64                randconfig-072-20231012   gcc  
x86_64                randconfig-073-20231012   gcc  
x86_64                randconfig-074-20231012   gcc  
x86_64                randconfig-075-20231012   gcc  
x86_64                randconfig-076-20231012   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
