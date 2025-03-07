Return-Path: <linux-pm+bounces-23635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477CA56B2E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5DF189C3A6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7321CC7E;
	Fri,  7 Mar 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzUfUaWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7021CC6F;
	Fri,  7 Mar 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359890; cv=none; b=EzA9h0eyuF3WeqmRZNxwLfp8I0JbslbRjWnyMRQOyazBZzKeorMerH0aAacBgCqvNtHOdb8MLPAgpdwN99ucRwO6EOAUjGyeHNz+NLLHjvFrCnRUUD7IkU5++PO0h5euFtCfPNxY/P53Z/Q4tByKPJvZjjwn7bauksDKyiWCiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359890; c=relaxed/simple;
	bh=WIO25UZyxl4aeXjXSMtUYiMd4bqWAzaD/w30AClH/n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW5TTWdNZDVArX0nVjIZ2vLjVu0M236RZ6Tk7//hRlaSpT1dPEPgnHavz4z3feHDgRagYSMvuvVC37wPZ57zEUmA6DE/OR4N3LH0hKx0j1yq4X/HJ8GHFTOQ2bnJjBQpZmWrjbCScX0taWET+mZo6GhOt3+UfxJbfcWnJr7s9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzUfUaWk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741359889; x=1772895889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIO25UZyxl4aeXjXSMtUYiMd4bqWAzaD/w30AClH/n0=;
  b=MzUfUaWkIm3zW2VaDlfvcXYqSGoEY8HscmcbMtUBcoIM8LO1G1pDBx5Z
   epbCEXPiOm4whwCaUQASVsn8hv9oR3WNTzxlo7+Vb2m69tgzkpVYwjfxf
   TWyi1jPau5C3j1sM66hdfDh1doC3Fgyn7V8TPE/4i6v62LC4Y9w/BvTmc
   wpdSD6DFdnT4b7SYggyyINeTTfd78tLMC/0uG2ijK73hmQEOMxCMa0hgx
   cU8WmGa8/jdUVhO1uqV/Sn+KHEY3dBGevXFCPwl5DqFEcTHVKFoB3SH16
   +pD+68Xy4aSXPKCiTEHovjkGwh8o3xcIIvYHWRIYhf91H9VIoqnsr5V6s
   A==;
X-CSE-ConnectionGUID: Fyooo9VnQ4iZpUQN2oTdNg==
X-CSE-MsgGUID: QR0N00QYSy6eDfoH3slWTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42608984"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42608984"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 07:04:35 -0800
X-CSE-ConnectionGUID: tQt0L6i8Q+qcvH3YuYOKrQ==
X-CSE-MsgGUID: addakMZvQS+KAu/AKEkO+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119283192"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2025 07:04:31 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqZFU-0000c3-2M;
	Fri, 07 Mar 2025 15:04:28 +0000
Date: Fri, 7 Mar 2025 23:04:19 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v4 4/7] nvmem: add support for device and sysfs-based
 cell lookups
Message-ID: <202503072216.f6lwkxwJ-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250306-174233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250306093900.2199442-5-o.rempel%40pengutronix.de
patch subject: [PATCH v4 4/7] nvmem: add support for device and sysfs-based cell lookups
config: sparc-randconfig-002-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072216.f6lwkxwJ-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072216.f6lwkxwJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072216.f6lwkxwJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.o: in function `nvmem_cell_get_by_sysfs_name':
>> phy-mtk-mipi-dsi-mt8173.c:(.text+0x434): multiple definition of `nvmem_cell_get_by_sysfs_name'; drivers/phy/mediatek/phy-mtk-mipi-dsi.o:phy-mtk-mipi-dsi.c:(.text+0x2a0): first defined here
   sparc-linux-ld: drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.o: in function `nvmem_device_get_by_name':
>> phy-mtk-mipi-dsi-mt8173.c:(.text+0x43c): multiple definition of `nvmem_device_get_by_name'; drivers/phy/mediatek/phy-mtk-mipi-dsi.o:phy-mtk-mipi-dsi.c:(.text+0x2a8): first defined here
   sparc-linux-ld: drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.o: in function `nvmem_cell_get_by_sysfs_name':
   phy-mtk-mipi-dsi-mt8183.c:(.text+0x470): multiple definition of `nvmem_cell_get_by_sysfs_name'; drivers/phy/mediatek/phy-mtk-mipi-dsi.o:phy-mtk-mipi-dsi.c:(.text+0x2a0): first defined here
   sparc-linux-ld: drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.o: in function `nvmem_device_get_by_name':
   phy-mtk-mipi-dsi-mt8183.c:(.text+0x478): multiple definition of `nvmem_device_get_by_name'; drivers/phy/mediatek/phy-mtk-mipi-dsi.o:phy-mtk-mipi-dsi.c:(.text+0x2a8): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

