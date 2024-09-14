Return-Path: <linux-pm+bounces-14215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6084978D7A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DC5B21340
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49525570;
	Sat, 14 Sep 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLv+Vh6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14914199BC;
	Sat, 14 Sep 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726290770; cv=none; b=ekDjqycMR/MpHEDkeWM2zStbsPjuBvhCEbsKN1nMlir2taYl78OtP2pihSyCDxk8VpiKkhDiMMY+nFxFQAqrTdNwedyvMgWjB92WwDIixbarxzOiFrxrpk7zzoD1dLwPKRrL5R8+w5Uw9FWmeiTrI+xsqyiZmhDoDlvrbXlkdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726290770; c=relaxed/simple;
	bh=/HB28poQFqti82eKAs8KNttYZol5FFOa8Hcja/yKtL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox4PyJ3aWXDJrix6eFFFh42ofwuiFkdSZ+25YVIas35MdlrNzxQzYJcW2HlXRpu7hxI+nH6QoUccdA/IAAK00l1ZkQVP85yhLJyXR6eiza1GM8MwrgOl4fBBaNZ3L5+I0cXnehr6Qfnrifx1rQxQbIH0MOj9oaOqqtrfbocU1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLv+Vh6K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726290769; x=1757826769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HB28poQFqti82eKAs8KNttYZol5FFOa8Hcja/yKtL0=;
  b=OLv+Vh6Kh7SzTrYSEexJPAZ4V/og19giFKa5PERf/gSx6D6AhlSj2Z8V
   YN477blbVKgtjahRWb9iNK8KgQw4v5cqKCboTiegbEVot+KfbGghHL5/U
   66FG073UOUdww/zTWn1Z/jTs3YRxpn19J5ssPSfqGE9M/GHdJGn2kRpk9
   StIM/RQudgO0qYgX+k3krLM5eJao3sSWrMZzdAknKcOoVE9NrKKchmYp2
   D+Ni1TnJr2fg50GT0z6Qc5KHGTZ0wtN45ANCskICfyFbEr/Dl3VTJpeCQ
   HKuS7k1uBK/VIR/x5P7L9TqXeerXKtyMR2OZ82yRyp493cW9tGcWSxGd8
   Q==;
X-CSE-ConnectionGUID: lHa43aCLTFiSyLgv+NGwKQ==
X-CSE-MsgGUID: DGVWiKjPQwy5kmisw1ZJeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35874422"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="35874422"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:12:48 -0700
X-CSE-ConnectionGUID: 9kMl8jvvTEqx02Vo7dS9nw==
X-CSE-MsgGUID: gDe/TK+gT7mkd/ggLB2mrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="73322579"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2024 22:12:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spL5K-0007Or-2w;
	Sat, 14 Sep 2024 05:12:38 +0000
Date: Sat, 14 Sep 2024 13:12:20 +0800
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
Subject: Re: [PATCH v4 11/27] power: supply: max77705: Add charger driver for
 Maxim 77705
Message-ID: <202409141322.ptabmnJ9-lkp@intel.com>
References: <20240913-starqltechn_integration_upstream-v4-11-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-11-2d2efd5c5877@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5acd9952f95fb4b7da6d09a3be39195a80845eb6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20240913-231027
base:   5acd9952f95fb4b7da6d09a3be39195a80845eb6
patch link:    https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-11-2d2efd5c5877%40gmail.com
patch subject: [PATCH v4 11/27] power: supply: max77705: Add charger driver for Maxim 77705
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240914/202409141322.ptabmnJ9-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141322.ptabmnJ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141322.ptabmnJ9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/supply/max77705_charger.c: In function 'max77705_charger_probe':
>> drivers/power/supply/max77705_charger.c:523:48: error: assignment of member 'irq_drv_data' in read-only object
     523 |         max77705_charger_irq_chip.irq_drv_data = chg;
         |                                                ^


vim +/irq_drv_data +523 drivers/power/supply/max77705_charger.c

   497	
   498	static int max77705_charger_probe(struct platform_device *pdev)
   499	{
   500		struct power_supply_config pscfg = {};
   501		struct max77693_dev *max77705;
   502		struct max77705_charger_data *chg;
   503		struct device *dev, *parent;
   504		struct regmap_irq_chip_data *irq_data;
   505		int ret;
   506	
   507		dev = &pdev->dev;
   508		parent = dev->parent;
   509		max77705 = dev_get_drvdata(parent);
   510	
   511		chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
   512		if (!chg)
   513			return -ENOMEM;
   514	
   515		platform_set_drvdata(pdev, chg);
   516	
   517		chg->regmap = max77705->regmap_chg;
   518		if (!chg->regmap)
   519			return -ENODEV;
   520	
   521		chg->dev = dev;
   522	
 > 523		max77705_charger_irq_chip.irq_drv_data = chg;
   524		ret = devm_regmap_add_irq_chip(chg->dev, chg->regmap, max77705->irq,
   525						IRQF_ONESHOT | IRQF_SHARED, 0,
   526						&max77705_charger_irq_chip,
   527						&irq_data);
   528		if (ret) {
   529			dev_err(dev, "failed to add irq chip: %d\n", ret);
   530			return ret;
   531		}
   532	
   533		ret = regmap_update_bits(chg->regmap,
   534					MAX77705_CHG_REG_INT_MASK,
   535					MAX77705_CHGIN_IM, 0);
   536	
   537		if (ret)
   538			return ret;
   539	
   540		chg->wqueue = create_singlethread_workqueue(dev_name(dev));
   541		if (IS_ERR(chg->wqueue)) {
   542			dev_err(dev, "failed to create workqueue\n");
   543			return PTR_ERR(chg->wqueue);
   544		}
   545		INIT_WORK(&chg->chgin_work, max77705_chgin_isr_work);
   546	
   547		pscfg.of_node = dev->of_node;
   548		pscfg.drv_data = chg;
   549	
   550		chg->psy_chg = devm_power_supply_register(dev, &max77705_charger_psy_desc,
   551							  &pscfg);
   552		if (IS_ERR(chg->psy_chg))
   553			return PTR_ERR(chg->psy_chg);
   554	
   555		max77705_charger_initialize(chg);
   556	
   557		return max77705_charger_enable(chg);
   558	}
   559	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

