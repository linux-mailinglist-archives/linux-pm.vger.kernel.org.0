Return-Path: <linux-pm+bounces-9769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB1912B1F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5285B1F29711
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499F15FA65;
	Fri, 21 Jun 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7ypmpXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80210A39;
	Fri, 21 Jun 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986641; cv=none; b=FPHYBhw6hWtFeE2LKhfWhWp9y+fSXvzQIZmiJkYT/SQ1lrzX+Q4RSCDdGgA9c7CTWFIcRZH3LmkevxqYXQm0LbRF9DAimi9I27ZmBnJrB8YYVqSQMp7wBERd58rwnrBflBjBTc7Q635JMcBK90oLBIgu6XFD51K91LKvh/k2nM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986641; c=relaxed/simple;
	bh=+Fxx6Sx301djtEaBC0yUcjU4BqsqCf6HkSgOkb8DcPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svshcKo8c+MxLPHCIOLnbRti5/LUfsoclwMfD9GEZ9ekOs5mAR5TUFD9Tf650KnUkHJkkEZgT8ORlGxJN6HPohMw++rPy9vsEueKY2DBoQ91ZTuTzAC8GC7iPX7un6QEE9LTUv5ds2h8iJN51e2cjPQVvBz0ZawdBo3zaX7cISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7ypmpXw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718986640; x=1750522640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Fxx6Sx301djtEaBC0yUcjU4BqsqCf6HkSgOkb8DcPk=;
  b=R7ypmpXwXDNF/p83FdyaLh/0g1cjCXj/G8OtzvvNbC1JSH38s4/ptFDa
   7LPQKSni8OKTwdKlvj7UyqUrSOyz/TrXx0li2RftArLNumEVFuyUVrFqS
   URcdzQlRDc2isPbEXgzHLFn6fcePTSPb5wuQpk/WzPA9bVf4tgDC2++sS
   T0ElcqJ5mW5yuHDr/VLacLsaAioQylEidDui7AmZu3vnUrZTnmzU2NFXO
   wk8JqMWVFmBaaGBs9oX1XOnuqwP1TozEIGW1/NzcQckpzo85/j2OmNFDl
   31suEpE7tvQyCW3sWEQVJTJ4Zw4aJoUi/leRwM/jhRln4SPEXwroNiCLN
   Q==;
X-CSE-ConnectionGUID: VZtd603tSmKnAux4yErCcA==
X-CSE-MsgGUID: QmJwelXgQBKrlOSc9xRAUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16156307"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="16156307"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:17:19 -0700
X-CSE-ConnectionGUID: GMnlQ7Z/R/acySIjDxt19w==
X-CSE-MsgGUID: 1L4S/m1VTmS4FwAsgUW4jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="43077647"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Jun 2024 09:17:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKgwn-0008kC-2J;
	Fri, 21 Jun 2024 16:17:09 +0000
Date: Sat, 22 Jun 2024 00:16:38 +0800
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
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 12/23] mfd: Add new driver for MAX77705 PMIC
Message-ID: <202406220025.tZN8mAeW-lkp@intel.com>
References: <20240618-starqltechn_integration_upstream-v3-12-e3f6662017ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-12-e3f6662017ac@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6906a84c482f098d31486df8dc98cead21cce2d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20240618-222456
base:   6906a84c482f098d31486df8dc98cead21cce2d0
patch link:    https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-12-e3f6662017ac%40gmail.com
patch subject: [PATCH v3 12/23] mfd: Add new driver for MAX77705 PMIC
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20240622/202406220025.tZN8mAeW-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240622/202406220025.tZN8mAeW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406220025.tZN8mAeW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mfd/max77705-core.c:20:
>> include/linux/mfd/max77705-private.h:243:26: error: 'MAX77705_USBC_REG_END' undeclared here (not in a function); did you mean 'MAX77705_PMIC_REG_END'?
     243 |         u8 reg_muic_dump[MAX77705_USBC_REG_END];
         |                          ^~~~~~~~~~~~~~~~~~~~~
         |                          MAX77705_PMIC_REG_END


vim +243 include/linux/mfd/max77705-private.h

   216	
   217	struct max77705_dev {
   218		struct device *dev;
   219		struct i2c_client *i2c; /* 0xCC; Haptic, PMIC */
   220		struct i2c_client *charger; /* 0xD2; Charger */
   221		struct i2c_client *fuelgauge; /* 0x6C; Fuelgauge */
   222		struct i2c_client *muic; /* 0x4A; MUIC */
   223		struct i2c_client *debug; /* 0xC4; Debug */
   224		struct mutex i2c_lock;
   225	
   226		struct regmap *regmap;
   227		struct regmap *regmap_fg;
   228		struct regmap *regmap_charger;
   229		struct regmap *regmap_leds;
   230	
   231		int type;
   232	
   233		int irq;
   234		int irq_base;
   235		int irq_masks_cur[MAX77705_IRQ_GROUP_NR];
   236		int irq_masks_cache[MAX77705_IRQ_GROUP_NR];
   237		bool wakeup;
   238		struct mutex irqlock;
   239	
   240	#ifdef CONFIG_HIBERNATION
   241		/* For hibernation */
   242		u8 reg_pmic_dump[MAX77705_PMIC_REG_END];
 > 243		u8 reg_muic_dump[MAX77705_USBC_REG_END];
   244		u8 reg_led_dump[MAX77705_LED_REG_END];
   245	#endif
   246	
   247		/* pmic VER/REV register */
   248		u8 pmic_rev;	/* pmic Rev */
   249		u8 pmic_ver;	/* pmic version */
   250	
   251		u8 cc_booting_complete;
   252	
   253		wait_queue_head_t queue_empty_wait_q;
   254		int doing_irq;
   255		int is_usbc_queue;
   256	
   257		struct max77705_platform_data *pdata;
   258	};
   259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

