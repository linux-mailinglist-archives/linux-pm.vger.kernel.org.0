Return-Path: <linux-pm+bounces-27412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A70ABD94A
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E127171A82
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8B242D6B;
	Tue, 20 May 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjbayfgG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3570241CB7;
	Tue, 20 May 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747545; cv=none; b=anehZ2DH9dDae8/AEZqThQGWiRFLzaZTZdDLUfizZURkTkQikagXwelIfjSUxRITmPtLxsDvt7UzJzOKESUZADmQe13EfVSWk35C4t5L1VnYXPZdL1XOFFRZCN1/WXRsbwIptFWPG1qCHkG/lrWTFUhRhrPeaYl1NDai29uY064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747545; c=relaxed/simple;
	bh=Vlg+ksR4kbGxDH5TVycRqZ2M05YaHWKfcCfoLOKIauc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS9IqSi7sM1o09dw3M8Uxr7UlVqLFWSIk9/Ud/XUdKexNnMeEaP7z0g8VwMCoUZMdQ0x4RxdvTBgNwl+f1i7f1eRO7ye+LVvVto5J3dOQ2IMSEq6eh82eGFiKgV/v/+L3DpzxbnZ+jOPnL+YVFhWXGYnX16ayMTQxld1w4rqZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjbayfgG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747747544; x=1779283544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vlg+ksR4kbGxDH5TVycRqZ2M05YaHWKfcCfoLOKIauc=;
  b=bjbayfgGbf8gIZOs+0pAg3nNiIXlksCLZcxN0J/ZUkQmvaU4fR9CUCOK
   oOCDZBnD0oy9aE48nLbg8EV2nK1+Rv/yhDKnp4GHmiLC0JBkM0T4hBEv6
   D3FmVPJ0t4KwsjDVR3jbgIKviQF4EqEY4WYeQnY0qZPWjLMPeuefI7YFe
   czfkCOAUS9DaWQuqoI8xACN6PEiG3nrppbJJzrl0tBAArLMweSGAgq+99
   MMP5VUOpUJsNbT4g5uOdVo+2SVvPJ20+iBGH1FyXniyp5mjjGzyjS7Qzn
   t2zwAniYXiwG4M67Ha18X5pZEonBtKlfbwRjxL96/ZkWwegonpo+0S2JW
   g==;
X-CSE-ConnectionGUID: L4vEb65tSeeYu45Q/UW7cQ==
X-CSE-MsgGUID: IAtS7ls7QJC7sLs+kpKWWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="72195739"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72195739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 06:25:42 -0700
X-CSE-ConnectionGUID: dA8v2aV8SI+BI/ngkGniiw==
X-CSE-MsgGUID: /YkhpMmGTLKtZuUTsXFTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170704890"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 06:25:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHMyO-000McE-2O;
	Tue, 20 May 2025 13:25:36 +0000
Date: Tue, 20 May 2025 21:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-imx@nxp.com,
	linux-input@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 5/9] mfd: pf1550: add core mfd driver
Message-ID: <202505202005.snxGxund-lkp@intel.com>
References: <85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b1d8766052eb0534b27edda8af1865d53621bd6a]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode/dt-bindings-power-supply-add-pf1550/20250517-030259
base:   b1d8766052eb0534b27edda8af1865d53621bd6a
patch link:    https://lore.kernel.org/r/85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode%40savoirfairelinux.com
patch subject: [PATCH v2 5/9] mfd: pf1550: add core mfd driver
config: i386-randconfig-r072-20250520 (https://download.01.org/0day-ci/archive/20250520/202505202005.snxGxund-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505202005.snxGxund-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505202005.snxGxund-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/pf1550.c:234:34: warning: 'pf1550_dt_match' defined but not used [-Wunused-const-variable=]
     234 | static const struct of_device_id pf1550_dt_match[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/pf1550_dt_match +234 drivers/mfd/pf1550.c

   233	
 > 234	static const struct of_device_id pf1550_dt_match[] = {
   235		{ .compatible = "fsl,pf1550" },
   236		{ /* sentinel */ }
   237	};
   238	MODULE_DEVICE_TABLE(of, pf1550_dt_match);
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

