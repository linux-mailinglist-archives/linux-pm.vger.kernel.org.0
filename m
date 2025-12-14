Return-Path: <linux-pm+bounces-39491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCFCBBED5
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F793006F5E
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2B30CD83;
	Sun, 14 Dec 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ2rHpi2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E8F513;
	Sun, 14 Dec 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765737128; cv=none; b=c01oSL/1HwPPwOaA6Lu7ZrSDsAXhkjOFfPBH7dDzLQWxxkob8TJ5NX2rzd8B3DBj2OP6tEMt9mQ+OtnozvjEzfb1GRuUa0yGjZHeMYRqMh1mF+egYK2WOLKE5LKJdeNfw75JpafxAkRGVgixl6+WhTSs6DZe0L1dxmbdSP+oR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765737128; c=relaxed/simple;
	bh=WgOGe7L2OCVOgby1b4QhmcN6LWs44YBwJ/drtIaxxIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwIX4ppI1dFay83yfKx4lcaY3L+/ZR0Z+35UlGHDyFqQNe/61uV8kf6kI6y9N7Y6uIQ8W8LIxORRbFe5G6zfo6ed3eSniSI2aWAC7R7KgmgTNbGXwPOrzgWJ4gpwd0V7bdgn1pGZOZmz9EYSOPa5foPP0vymVuCPMMFNwReWh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZ2rHpi2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765737128; x=1797273128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WgOGe7L2OCVOgby1b4QhmcN6LWs44YBwJ/drtIaxxIM=;
  b=AZ2rHpi2QxlnGGtnrQ19GbhDSdGI35s6bRAHZD3IoyBjsQu5QSBfbABn
   3zJ/c5XuTLdzDDe7Lhn0NTU16iDCTa4qTeAgoppBXtP4weJx2IFRucki9
   UE8xaLhmDN1B/wOQkBC+ESX16Tja8JjfnPMb+/mzIXmbZuvgn+l5srWoZ
   LmZwiFKVH1ezWUwo0mQhDDlaGJDU4xyoLsDFga7QxnC9vvBLfRlWVJIUE
   5v2cefUkSX4xB1lpRqb2xNHuvnEx9Ljd8+Pf3uyMxH2bPlxsWhIUx8hkw
   GhYx6gIQl4HpOpFWkPW6zsGi9VOz9k37k7mACaXWBgf9roK1pYrUKGggZ
   w==;
X-CSE-ConnectionGUID: waUAXo1FR0GqrJMZjOZ3fg==
X-CSE-MsgGUID: vIjzOMu4Ryy2rEbzVGSfVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67592594"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67592594"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 10:32:07 -0800
X-CSE-ConnectionGUID: qNWkF24JRwmzbtpgj9c7uA==
X-CSE-MsgGUID: b7nI40f9QM+hjsbE4j0Z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; 
   d="scan'208";a="228614307"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Dec 2025 10:31:37 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUqsY-000000009Gn-35kv;
	Sun, 14 Dec 2025 18:31:34 +0000
Date: Mon, 15 Dec 2025 02:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Koskovich <AKoskovich@pm.me>,
	Sebastian Reichel <sre@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Koskovich <akoskovich@pm.me>
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: respect cell size for
 nvmem_cell_write
Message-ID: <202512150225.njZvGeNB-lkp@intel.com>
References: <20251214005903.2802724-1-akoskovich@pm.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214005903.2802724-1-akoskovich@pm.me>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.19-rc1 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Koskovich/power-reset-nvmem-reboot-mode-respect-cell-size-for-nvmem_cell_write/20251214-090110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20251214005903.2802724-1-akoskovich%40pm.me
patch subject: [PATCH] power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write
config: i386-randconfig-004-20251214 (https://download.01.org/0day-ci/archive/20251215/202512150225.njZvGeNB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251215/202512150225.njZvGeNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512150225.njZvGeNB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/reset/nvmem-reboot-mode.c:32:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      32 |         kfree(buf);
         |         ^
   1 error generated.


vim +/kfree +32 drivers/power/reset/nvmem-reboot-mode.c

    18	
    19	static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
    20					    unsigned int magic)
    21	{
    22		struct nvmem_reboot_mode *nvmem_rbm;
    23		size_t buf_len;
    24		void *buf;
    25		int ret;
    26	
    27		nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
    28	
    29		buf = nvmem_cell_read(nvmem_rbm->cell, &buf_len);
    30		if (IS_ERR(buf))
    31			return PTR_ERR(buf);
  > 32		kfree(buf);
    33	
    34		if (buf_len > sizeof(magic))
    35			return -EINVAL;
    36	
    37		ret = nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
    38		if (ret < 0)
    39			dev_err(reboot->dev, "update reboot mode bits failed\n");
    40	
    41		return ret;
    42	}
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

