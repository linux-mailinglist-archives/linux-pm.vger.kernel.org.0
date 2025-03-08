Return-Path: <linux-pm+bounces-23676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3991A57C38
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1963AA332
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CB1D8DFB;
	Sat,  8 Mar 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHLx5Ipn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF4158DAC;
	Sat,  8 Mar 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741453649; cv=none; b=bMRy450VIzRORa83vmQNRDvTS85pRMBxeEDr/rP4lzQ1nmOToR6XmLi3UowGh6gLmJqk0vWnkCeW5DPQL0qm7JqfEtVq/ckVFGVaDKCwyopGyCNeMHyidOOegs9x8mDplU3lIKVjLTEw2uZxf+cFv5YtQAE6tcjp71F7ivjlafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741453649; c=relaxed/simple;
	bh=XEORLPQvUAU4keZvxERc+zQuOffs6Mxlu2m+3zLqodM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwGYJOPTx3FeGziN13/0G4m37asfIL/o0LIj757dcTNOn8Q+Afban6dxT6qWef1m32O3/03jbY5mc4ZP7NaRKVwsilR9lwhUnctNz9RdBSvSmDugjEYDZF5fihiEEyY/w8QG+Y/B7f7BtQVwu7plipSGQfYtm+0W0q8JFo27Ukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHLx5Ipn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741453648; x=1772989648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XEORLPQvUAU4keZvxERc+zQuOffs6Mxlu2m+3zLqodM=;
  b=oHLx5Ipnubj5lRRZ6F9xWJ5vjl8L295goDuompxje1+IhqXet8IHCsIk
   PouSUgBP2NJfcuzZ5DCYv6RhroGgwDerTiR7crLAp2MC1GqGUMOfyw4HZ
   Xb1GtG1UhM6rizPqOJh4qsJBaHI8wXXQpGv7RndDRHIVcCGijwOsBY0DW
   bn1MdDHUQJP2n4MJ5k4xv0eMOpNe23H2ZR8gcNuas/vQpjH6T/Rq4ss7X
   TiJ55+TRNsO/DCwb2Esi0zTl2Bqv58o1ni5/lVvLD3i+92vs+9pGE+9vL
   tzyRtQ793RaIeZUgtQoiqr26ei6moocqpsO1uQsIZbK0I7ZuT6qTpE+XU
   w==;
X-CSE-ConnectionGUID: gSFUFcl0RXihnNqWw7XIkg==
X-CSE-MsgGUID: KYVp8W+kRWKZaeo9l6hd0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42403066"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="42403066"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 09:07:27 -0800
X-CSE-ConnectionGUID: Zz8zced5Tj2Is/vg/g/nJg==
X-CSE-MsgGUID: NosHEJTbQB+TMr2B1FVgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="142818194"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 08 Mar 2025 09:07:23 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqxdx-00027Y-1R;
	Sat, 08 Mar 2025 17:07:21 +0000
Date: Sun, 9 Mar 2025 01:06:39 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v4 4/7] nvmem: add support for device and sysfs-based
 cell lookups
Message-ID: <202503090029.GNYIypVB-lkp@intel.com>
References: <20250306093900.2199442-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306093900.2199442-5-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250306-174233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250306093900.2199442-5-o.rempel%40pengutronix.de
patch subject: [PATCH v4 4/7] nvmem: add support for device and sysfs-based cell lookups
config: hexagon-randconfig-002-20250308 (https://download.01.org/0day-ci/archive/20250309/202503090029.GNYIypVB-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503090029.GNYIypVB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503090029.GNYIypVB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/rtc/rtc-pm8xxx.c:10:
>> include/linux/nvmem-consumer.h:115:20: warning: no previous prototype for function 'nvmem_cell_get_by_sysfs_name' [-Wmissing-prototypes]
     115 | struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
         |                    ^
   include/linux/nvmem-consumer.h:115:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     115 | struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
         | ^
         | static 
>> include/linux/nvmem-consumer.h:197:22: warning: no previous prototype for function 'nvmem_device_get_by_name' [-Wmissing-prototypes]
     197 | struct nvmem_device *nvmem_device_get_by_name(const char *name)
         |                      ^
   include/linux/nvmem-consumer.h:197:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     197 | struct nvmem_device *nvmem_device_get_by_name(const char *name)
         | ^
         | static 
   2 warnings generated.


vim +/nvmem_cell_get_by_sysfs_name +115 include/linux/nvmem-consumer.h

   114	
 > 115	struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
   116							const char *cell_name)
   117	{
   118		return ERR_PTR(-EOPNOTSUPP);
   119	}
   120	
   121	static inline void devm_nvmem_cell_put(struct device *dev,
   122					       struct nvmem_cell *cell)
   123	{
   124	
   125	}
   126	static inline void nvmem_cell_put(struct nvmem_cell *cell)
   127	{
   128	}
   129	
   130	static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
   131	{
   132		return ERR_PTR(-EOPNOTSUPP);
   133	}
   134	
   135	static inline int nvmem_cell_write(struct nvmem_cell *cell,
   136					   void *buf, size_t len)
   137	{
   138		return -EOPNOTSUPP;
   139	}
   140	
   141	static inline int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes,
   142					      size_t *bits)
   143	{
   144		return -EOPNOTSUPP;
   145	}
   146	
   147	static inline int nvmem_cell_read_u8(struct device *dev,
   148					     const char *cell_id, u8 *val)
   149	{
   150		return -EOPNOTSUPP;
   151	}
   152	
   153	static inline int nvmem_cell_read_u16(struct device *dev,
   154					      const char *cell_id, u16 *val)
   155	{
   156		return -EOPNOTSUPP;
   157	}
   158	
   159	static inline int nvmem_cell_read_u32(struct device *dev,
   160					      const char *cell_id, u32 *val)
   161	{
   162		return -EOPNOTSUPP;
   163	}
   164	
   165	static inline int nvmem_cell_read_u64(struct device *dev,
   166					      const char *cell_id, u64 *val)
   167	{
   168		return -EOPNOTSUPP;
   169	}
   170	
   171	static inline int nvmem_cell_read_variable_le_u32(struct device *dev,
   172							 const char *cell_id,
   173							 u32 *val)
   174	{
   175		return -EOPNOTSUPP;
   176	}
   177	
   178	static inline int nvmem_cell_read_variable_le_u64(struct device *dev,
   179							  const char *cell_id,
   180							  u64 *val)
   181	{
   182		return -EOPNOTSUPP;
   183	}
   184	
   185	static inline struct nvmem_device *nvmem_device_get(struct device *dev,
   186							    const char *name)
   187	{
   188		return ERR_PTR(-EOPNOTSUPP);
   189	}
   190	
   191	static inline struct nvmem_device *devm_nvmem_device_get(struct device *dev,
   192								 const char *name)
   193	{
   194		return ERR_PTR(-EOPNOTSUPP);
   195	}
   196	
 > 197	struct nvmem_device *nvmem_device_get_by_name(const char *name)
   198	{
   199		return ERR_PTR(-EOPNOTSUPP);
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

