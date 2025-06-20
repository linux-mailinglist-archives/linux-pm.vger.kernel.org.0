Return-Path: <linux-pm+bounces-29122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039AAE11DC
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B424A1E8C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 03:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75EA1E376E;
	Fri, 20 Jun 2025 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7p+CGN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795E1E0083;
	Fri, 20 Jun 2025 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390408; cv=none; b=Th4MR7X9k+uqRH9vbB/px+6GaC7JuabQCuzz1aS6NEWlQemQYRhPE81e+TotpfqZtqg3nfJL5x3xWuWwQIZ077m4tqTVLCHHoFx5HK+Iy1dwnj0vQ9x4cK63VPnAl6fQJXXrUc4MoYCAFzwPhh1OiiNbNo3p7r3EkBmX3T2Xq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390408; c=relaxed/simple;
	bh=7b4Zgn39nbR0MuT55dc6lDAmtx2/UCmMGXfe6j+aHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDMzZSsP9mmep/+ZmiqgckpqyUttWURRV/Nr1fQIlaeZO1SA7xZHK49lK5Vfsl+HQWO5m7HOUwQGaz48Chsa3BB1SLbhuTEK+M+/ZLXQTe20lmBMmpD9JIfXgcx4QCWWYk3YsfngvObR/l6/O1WmcmnWyCZTDWo+53WEe28kxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7p+CGN3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750390407; x=1781926407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7b4Zgn39nbR0MuT55dc6lDAmtx2/UCmMGXfe6j+aHDM=;
  b=b7p+CGN3iZaohOfCj0jSyx5BmVs0qUlVWt74ZfAf4rsTplvghF6j00OI
   GpW+qSCNdFauqBBKxVueNCc7NWx2E/BIpfwpBZEE9bRbZqGw97vJzNaaW
   N7Dxj9d1ibKkb9E3ya8T47nrCCcXbtIx0TiJxWZjuX4IG+N+uZa8AllvB
   p8qIP0vSrOcAXC1am0LiOVE8kSDqkmz90OyizTfvuUZDRzNqr5gZdgNay
   HDgpbYC5NUMhH4nv+Sn0Nxg1R7VugFCexlllCA1DQgUKu2/zKtVs0uH8j
   DDSS8CkJMps1CAqRql3WQVXAPTapBMN4xKaqG1jcf6oBAyF+ptWl8dodb
   w==;
X-CSE-ConnectionGUID: PGxJWrsqQPGaCPwXiRs5ng==
X-CSE-MsgGUID: o46eXinqTou3R6l/IkgOPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63692003"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="63692003"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 20:33:26 -0700
X-CSE-ConnectionGUID: LwfHEg8eS0iD8pPsmJpIWA==
X-CSE-MsgGUID: j7YO7yV7TuCOk+Ncl9X9mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="151105039"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jun 2025 20:33:20 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSSVB-000LLC-31;
	Fri, 20 Jun 2025 03:33:17 +0000
Date: Fri, 20 Jun 2025 11:32:51 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 8/8] drm/imagination: Enable PowerVR driver for RISC-V
Message-ID: <202506201103.GX6DA9Gx-lkp@intel.com>
References: <20250618-apr_14_for_sending-v5-8-27ed33ea5c6f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-apr_14_for_sending-v5-8-27ed33ea5c6f@samsung.com>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4774cfe3543abb8ee98089f535e28ebfd45b975a]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/power-sequencing-Add-T-HEAD-TH1520-GPU-power-sequencer-driver/20250618-182429
base:   4774cfe3543abb8ee98089f535e28ebfd45b975a
patch link:    https://lore.kernel.org/r/20250618-apr_14_for_sending-v5-8-27ed33ea5c6f%40samsung.com
patch subject: [PATCH v5 8/8] drm/imagination: Enable PowerVR driver for RISC-V
config: sparc64-randconfig-r121-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201103.GX6DA9Gx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250620/202506201103.GX6DA9Gx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201103.GX6DA9Gx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/imagination/pvr_mmu.c:57:3: error: #error Unsupported device page size PVR_DEVICE_PAGE_SIZE
    # error Unsupported device page size PVR_DEVICE_PAGE_SIZE
      ^~~~~
   In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:390,
                    from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/memory.h:19,
                    from drivers/gpu/drm/imagination/pvr_mmu.h:7,
                    from drivers/gpu/drm/imagination/pvr_mmu.c:4:
   drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l1_entry_raw_set':
   drivers/gpu/drm/imagination/pvr_mmu.c:577:50: error: 'ROGUE_MMUCTRL_PAGE_SIZE_X' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_SIZE_1MB'?
         PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
     *(volatile typeof(x) *)&(x) = (val);    \
                                    ^~~
   drivers/gpu/drm/imagination/pvr_mmu.c:574:2: note: in expansion of macro 'WRITE_ONCE'
     WRITE_ONCE(entry->val,
     ^~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_mmu.c:577:6: note: in expansion of macro 'PVR_PAGE_TABLE_FIELD_PREP'
         PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_mmu.c:577:50: note: each undeclared identifier is reported only once for each function it appears in
         PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
     *(volatile typeof(x) *)&(x) = (val);    \
                                    ^~~
   drivers/gpu/drm/imagination/pvr_mmu.c:574:2: note: in expansion of macro 'WRITE_ONCE'
     WRITE_ONCE(entry->val,
     ^~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_mmu.c:577:6: note: in expansion of macro 'PVR_PAGE_TABLE_FIELD_PREP'
         PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l0_entry_raw_set':
   drivers/gpu/drm/imagination/pvr_mmu.c:741:24: error: 'ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_1MB_RANGE_CLRMSK'?
              (dma_addr & ~ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK) |
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
     *(volatile typeof(x) *)&(x) = (val);    \
                                    ^~~
   drivers/gpu/drm/imagination/pvr_mmu.c:739:2: note: in expansion of macro 'WRITE_ONCE'
     WRITE_ONCE(entry->val, PVR_PAGE_TABLE_FIELD_PREP(0, PT, VALID, true) |
     ^~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l0_idx':
   drivers/gpu/drm/imagination/pvr_mmu.c:1713:9: error: 'ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT'?
            ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT
>> drivers/gpu/drm/imagination/pvr_mmu.c:1714:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^


vim +1714 drivers/gpu/drm/imagination/pvr_mmu.c

ff5f643de0bf27 Donald Robson 2023-11-22  1696  
ff5f643de0bf27 Donald Robson 2023-11-22  1697  /**
ff5f643de0bf27 Donald Robson 2023-11-22  1698   * pvr_page_table_l0_idx() - Calculate the level 0 page table index for a
ff5f643de0bf27 Donald Robson 2023-11-22  1699   *                           device-virtual address.
ff5f643de0bf27 Donald Robson 2023-11-22  1700   * @device_addr: Target device-virtual address.
ff5f643de0bf27 Donald Robson 2023-11-22  1701   *
ff5f643de0bf27 Donald Robson 2023-11-22  1702   * This function does not perform any bounds checking - it is the caller's
ff5f643de0bf27 Donald Robson 2023-11-22  1703   * responsibility to ensure that @device_addr is valid before interpreting
ff5f643de0bf27 Donald Robson 2023-11-22  1704   * the result.
ff5f643de0bf27 Donald Robson 2023-11-22  1705   *
ff5f643de0bf27 Donald Robson 2023-11-22  1706   * Return:
ff5f643de0bf27 Donald Robson 2023-11-22  1707   * The index into a level 0 page table corresponding to @device_addr.
ff5f643de0bf27 Donald Robson 2023-11-22  1708   */
ff5f643de0bf27 Donald Robson 2023-11-22  1709  static u16
ff5f643de0bf27 Donald Robson 2023-11-22  1710  pvr_page_table_l0_idx(u64 device_addr)
ff5f643de0bf27 Donald Robson 2023-11-22  1711  {
ff5f643de0bf27 Donald Robson 2023-11-22  1712  	return (device_addr & ~ROGUE_MMUCTRL_VADDR_PT_INDEX_CLRMSK) >>
ff5f643de0bf27 Donald Robson 2023-11-22  1713  	       ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT;
ff5f643de0bf27 Donald Robson 2023-11-22 @1714  }
ff5f643de0bf27 Donald Robson 2023-11-22  1715  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

