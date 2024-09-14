Return-Path: <linux-pm+bounces-14214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE9978D6D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 06:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E111C1C22299
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 04:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CCA4369A;
	Sat, 14 Sep 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPuQqJbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE792E62B;
	Sat, 14 Sep 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289509; cv=none; b=QSKtfkLueyMcTMlnXBq7ubzyrrYCTEVzMaDfpMYs0/oQsFZJacgRTK+LQK+Lg3oifEryxF4eolY8E39rNszIFzCRaZntbdNKMCpvygCt9X2+GMZFAZ/PxtSzBDni9WK7Fu3Kq8qoYYiA2qIGzYt+3duQ90BbIJjx+NFxwaAd0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289509; c=relaxed/simple;
	bh=d/8X4Idqvm5bT+suEtQZD2BhDw8gn9M8PvI/hQGY6LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtLkLwO5JU1Jroo3P6B8oyhYTbySnIl3oEsHX3A1Vzx3F1FzqnGjXL8aCwQ5U5+9L/7XdxdX0Pm6KSqyTmaOpTNmZqqrFnbAryaMvsvMBSaMybaRp0Is/nAHLmzfkng0cW3EUIEzUzq9ZmhKj8aeOIwPA7M8E/osrqWO0VqNN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPuQqJbL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726289508; x=1757825508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/8X4Idqvm5bT+suEtQZD2BhDw8gn9M8PvI/hQGY6LQ=;
  b=NPuQqJbL1UinnKL7GiUD7+uEIPbeU1hEIlLu3yRmnxlISYjW6gsxRdgE
   WSxwFK3sSm9iVV0l5tGH+Xkuuu+WQ77d1qYljuyPbrdBT3+PqfamUpadg
   ROipLNnxGVkt2jkgzMjWudzqH4xeHhp0yWUIaddK2gvG9cS083/M64lml
   Ol3C2Z+O11912d6qXjpK7ndGkwX2H7816b+RSuWWJnyWArhKMK7dKXU39
   wOaWf9EbCuNL6f6nXTWJGYArD6DBZiuCUVYyt3L4EO+B+fpe7g5oimds4
   1EmSVtAhPDTYJfdAgNZmw7yqcbov1CFti9ht9D/C/6OFXFrDWKgSuBMnv
   w==;
X-CSE-ConnectionGUID: xt/i6EuaQymmgDhLE+iyiQ==
X-CSE-MsgGUID: AB/TWMl2QVqy3T6BAyP+Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25323649"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="25323649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 21:51:47 -0700
X-CSE-ConnectionGUID: cRIVJ7dhT1GeBL0U5a6Y6w==
X-CSE-MsgGUID: k+X960AwScmh1lLLeEIj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="73317504"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2024 21:51:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spKkz-0007NQ-2n;
	Sat, 14 Sep 2024 04:51:37 +0000
Date: Sat, 14 Sep 2024 12:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Simona Vetter <simona@ffwll.ch>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/27] gcc-sdm845: Add general purpose clock ops
Message-ID: <202409141246.H3882zgF-lkp@intel.com>
References: <20240913-starqltechn_integration_upstream-v4-3-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-3-2d2efd5c5877@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5acd9952f95fb4b7da6d09a3be39195a80845eb6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20240913-231027
base:   5acd9952f95fb4b7da6d09a3be39195a80845eb6
patch link:    https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-3-2d2efd5c5877%40gmail.com
patch subject: [PATCH v4 03/27] gcc-sdm845: Add general purpose clock ops
config: i386-buildonly-randconfig-004-20240914 (https://download.01.org/0day-ci/archive/20240914/202409141246.H3882zgF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141246.H3882zgF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141246.H3882zgF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/clk/qcom/gcc-sdm845.c:291:9: warning: braces around scalar initializer
     291 |         .freq_tbl = {},
         |         ^
   drivers/clk/qcom/gcc-sdm845.c:291:9: note: (near initialization for 'gcc_gp1_clk_src.<anonymous>.freq_tbl')
>> drivers/clk/qcom/gcc-sdm845.c:291:21: error: empty scalar initializer
     291 |         .freq_tbl = {},
         |                     ^
   drivers/clk/qcom/gcc-sdm845.c:291:21: note: (near initialization for 'gcc_gp1_clk_src.<anonymous>.freq_tbl')
   drivers/clk/qcom/gcc-sdm845.c:305:9: warning: braces around scalar initializer
     305 |         .freq_tbl = {},
         |         ^
   drivers/clk/qcom/gcc-sdm845.c:305:9: note: (near initialization for 'gcc_gp2_clk_src.<anonymous>.freq_tbl')
   drivers/clk/qcom/gcc-sdm845.c:305:21: error: empty scalar initializer
     305 |         .freq_tbl = {},
         |                     ^
   drivers/clk/qcom/gcc-sdm845.c:305:21: note: (near initialization for 'gcc_gp2_clk_src.<anonymous>.freq_tbl')
   drivers/clk/qcom/gcc-sdm845.c:319:9: warning: braces around scalar initializer
     319 |         .freq_tbl = {},
         |         ^
   drivers/clk/qcom/gcc-sdm845.c:319:9: note: (near initialization for 'gcc_gp3_clk_src.<anonymous>.freq_tbl')
   drivers/clk/qcom/gcc-sdm845.c:319:21: error: empty scalar initializer
     319 |         .freq_tbl = {},
         |                     ^
   drivers/clk/qcom/gcc-sdm845.c:319:21: note: (near initialization for 'gcc_gp3_clk_src.<anonymous>.freq_tbl')


vim +291 drivers/clk/qcom/gcc-sdm845.c

   285	
   286	static struct clk_rcg2 gcc_gp1_clk_src = {
   287		.cmd_rcgr = 0x64004,
   288		.mnd_width = 8,
   289		.hid_width = 5,
   290		.parent_map = gcc_parent_map_1,
 > 291		.freq_tbl = {},
   292		.clkr.hw.init = &(struct clk_init_data){
   293			.name = "gcc_gp1_clk_src",
   294			.parent_data = gcc_parent_data_1,
   295			.num_parents = ARRAY_SIZE(gcc_parent_data_1),
   296			.ops = &clk_rcg2_gp_ops,
   297		},
   298	};
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

