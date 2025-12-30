Return-Path: <linux-pm+bounces-40045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBACE9CC1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1BC03011B10
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC797236454;
	Tue, 30 Dec 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKOqd7B4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53A22B8C5
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767101764; cv=none; b=a+tVVNw7xLDsTmt7V4mUCOxdJgvOuibIGKVsBqD3WZ+6USUVmzaMnNRAYplVxx0cOf/1OpyFJKMVGEgd4opVCKcbW0wjLz5n0/3inTreD4Z/TijhDKxPCCgopulpGN2xFRNdii5nxICOGf8CoGaZaz+eT4Cz9j55bvoioa+wdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767101764; c=relaxed/simple;
	bh=whRaztirvx5Wyh80MSX+DutYWxXqcp9XldzpUIBN9zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL9ocQPV6eWApZVTJAXkogZ89G/ixCOj9PmxmfLXvQizftCGVnbVFznNOS/IEeeb8TFpk3KZs6dNvG9qIKQ7GfpUbtJymIVFx864/uv5AFXSfPV0l7SpEaCdcjU0CZAsuJ7uBdbAjgZd5P8PdxPisurN7fOF8EVD+nddGVZ5cYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKOqd7B4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767101763; x=1798637763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=whRaztirvx5Wyh80MSX+DutYWxXqcp9XldzpUIBN9zk=;
  b=cKOqd7B4ify/4oy22atg9aYnDU2tzUTmScn6TVCs4e5aKJRhttkUU7Fi
   UdXIP6j1Zk05cAzoeao8hkPhg0bSlaOweLaOH3JrRKOf4mn00ge03FRYP
   0urVqrm0t+eSS/PJr1FDSvF+x4ZEEpCbjgswZ02aXPNVviKEawn65Fgy3
   kwdUUaoVojf6xFI2Vo9F9BvOAU15X7P/HoxxzlBnX15ByaTHShv+fuWiZ
   gv8IdQaqem+5/tSqEI4POxMiTHRKiJ2ci11KUj7LtQn3R2WIVv3ItMQND
   w/GOAE3Kgjlrwhy7izeJ+QRsow2SK5fkSB0IfR4nfVc997lBWocHnz2dp
   g==;
X-CSE-ConnectionGUID: jv3TeRHVSbS1HwjnF5AUbg==
X-CSE-MsgGUID: 80MZblQzTcmmDakg/KtDFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="79809530"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="79809530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 05:36:01 -0800
X-CSE-ConnectionGUID: ada3EXIlSHOIL18jvWVdKA==
X-CSE-MsgGUID: E5snTTCFSEymNkXU32GLZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="205734082"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Dec 2025 05:35:59 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaZtE-000000000P3-2Vow;
	Tue, 30 Dec 2025 13:35:56 +0000
Date: Tue, 30 Dec 2025 21:35:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	tzungbi@kernel.org
Subject: Re: [PATCH] pmdomain: mediatek: Break lock dependency to
 `prepare_lock`
Message-ID: <202512302129.BjTBw9E6-lkp@intel.com>
References: <20251229043244.4103262-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229043244.4103262-1-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.19-rc3 next-20251219]
[cannot apply to amd-pstate/linux-next amd-pstate/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/pmdomain-mediatek-Break-lock-dependency-to-prepare_lock/20251229-123525
base:   linus/master
patch link:    https://lore.kernel.org/r/20251229043244.4103262-1-tzungbi%40kernel.org
patch subject: [PATCH] pmdomain: mediatek: Break lock dependency to `prepare_lock`
config: arm-randconfig-003-20251230 (https://download.01.org/0day-ci/archive/20251230/202512302129.BjTBw9E6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512302129.BjTBw9E6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512302129.BjTBw9E6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pmdomain/mediatek/mtk-pm-domains.c:1304:12: warning: 'scpsys_resume' defined but not used [-Wunused-function]
    1304 | static int scpsys_resume(struct device *dev)
         |            ^~~~~~~~~~~~~
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:1285:12: warning: 'scpsys_suspend' defined but not used [-Wunused-function]
    1285 | static int scpsys_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~


vim +/scpsys_resume +1304 drivers/pmdomain/mediatek/mtk-pm-domains.c

  1284	
> 1285	static int scpsys_suspend(struct device *dev)
  1286	{
  1287		struct scpsys *scpsys = dev_get_drvdata(dev);
  1288		struct generic_pm_domain *genpd;
  1289		struct scpsys_domain *pd;
  1290		int i;
  1291	
  1292		for (i = 0; i < scpsys->pd_data.num_domains; i++) {
  1293			genpd = scpsys->pd_data.domains[i];
  1294			if (!genpd)
  1295				continue;
  1296	
  1297			pd = to_scpsys_domain(genpd);
  1298			clk_bulk_unprepare(pd->num_clks, pd->clks);
  1299			clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
  1300		}
  1301		return 0;
  1302	}
  1303	
> 1304	static int scpsys_resume(struct device *dev)
  1305	{
  1306		struct scpsys *scpsys = dev_get_drvdata(dev);
  1307		struct generic_pm_domain *genpd;
  1308		struct scpsys_domain *pd;
  1309		int i, ret;
  1310	
  1311		for (i = 0; i < scpsys->pd_data.num_domains; i++) {
  1312			genpd = scpsys->pd_data.domains[i];
  1313			if (!genpd)
  1314				continue;
  1315	
  1316			pd = to_scpsys_domain(genpd);
  1317			ret = clk_bulk_prepare(pd->num_clks, pd->clks);
  1318			if (ret)
  1319				return ret;
  1320			ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
  1321			if (ret)
  1322				return ret;
  1323		}
  1324		return 0;
  1325	}
  1326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

