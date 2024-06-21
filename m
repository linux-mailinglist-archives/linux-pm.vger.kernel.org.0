Return-Path: <linux-pm+bounces-9792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D061912E9A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722882812D1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E217B42D;
	Fri, 21 Jun 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD438gxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED66374DD;
	Fri, 21 Jun 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002072; cv=none; b=BBHlsu0jM+YChzzUaavtuVJTh3upLdoUQgIp22Jaxwd5Wz6PaKsDQ3p47FLaA0jM1LBfzdZq/IC4q09/WdYGjzYkGn+FKA8tkAS2YhCN+kdMLBZdJiBkFHvxfIoihdnPOynNQGZfIZQWnvb4iRt8KakYVZ9lZXaRd7stzVVfQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002072; c=relaxed/simple;
	bh=g+pouUiiT7AeZC4HcBnx+iVl1hBdooJPKlXz8f+L6E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsjS2X85DUtmnvoWYWtmGJZ4y/2gicBuG3/nKMCwPbCW/u/W5HoUVVd6Q5fIWoWzCnfLBVYDTGYMjqSE7D7Jkonq0vxFC4rpoXccPBA+Us5XUKV8EFtNT0OIznZuWXGN4sH0QQ4P5ebgP0dvYUnO6QqGHhMGj0s2DZXAEQFlnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD438gxj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719002069; x=1750538069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+pouUiiT7AeZC4HcBnx+iVl1hBdooJPKlXz8f+L6E4=;
  b=SD438gxjfaW0H6Ot29Y7gVWTQfsjT7ugHgQL5YNXNfYpGc4GF5TqneXN
   q+PV3Dubj5Ses4G05Iod2ROHaONSjMu/fuvcAjk6nWpVJ0ViXbhtEXViW
   uSOZdRIJUkzodAC2Ezcqt9twg1Wk63Zy0IRVOWxa892rRi6beYh+p3u4i
   zFYpTzhJgMl9eBzzZzuc4eg9nsf5t7dkwTE6g2hpf9jhgeNEomolpniip
   quXHH/PlFiY4u6tZLM2TprIxymZxLaJogiS2FkOTl/J5kH3QHg2PNtVS9
   Li5xAiJV7G0VS5gJIQJA8b7M5LZCbqe+FWAvmjGimrnS1YZoxiULTlX7p
   g==;
X-CSE-ConnectionGUID: 87oLkz+/Qy2juagB+ZP4yQ==
X-CSE-MsgGUID: gCrQrSrTSlyTaZvLL3d9RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16285626"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="16285626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:34:28 -0700
X-CSE-ConnectionGUID: vjURhEvVTDqAJ4kaNuOtEg==
X-CSE-MsgGUID: LfHac5txTsiEbj3rI22Gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="73910113"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jun 2024 13:34:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKkxf-0008za-1z;
	Fri, 21 Jun 2024 20:34:19 +0000
Date: Sat, 22 Jun 2024 04:33:31 +0800
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
Subject: Re: [PATCH v3 17/23] mfd: add s2dos series core driver
Message-ID: <202406220455.UpxNyPhg-lkp@intel.com>
References: <20240618-starqltechn_integration_upstream-v3-17-e3f6662017ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-17-e3f6662017ac@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6906a84c482f098d31486df8dc98cead21cce2d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20240618-222456
base:   6906a84c482f098d31486df8dc98cead21cce2d0
patch link:    https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-17-e3f6662017ac%40gmail.com
patch subject: [PATCH v3 17/23] mfd: add s2dos series core driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240622/202406220455.UpxNyPhg-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240622/202406220455.UpxNyPhg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406220455.UpxNyPhg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mfd/s2dos-core.c: In function 's2dos05_i2c_probe':
>> drivers/mfd/s2dos-core.c:88:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
      88 |         int ret = 0;
         |             ^~~


vim +/ret +88 drivers/mfd/s2dos-core.c

    79	
    80	
    81	static int s2dos05_i2c_probe(struct i2c_client *i2c)
    82	{
    83		struct s2dos_core *s2dos05;
    84		struct regmap *regmap;
    85		struct device *dev = &i2c->dev;
    86	
    87		unsigned int reg_data;
  > 88		int ret = 0;
    89	
    90		s2dos05 = kzalloc(sizeof(struct s2dos_core), GFP_KERNEL);
    91		if (!s2dos05)
    92			return -ENOMEM;
    93	
    94		regmap = devm_regmap_init_i2c(i2c, &s2dos05_regmap_config);
    95		if (IS_ERR(regmap)) {
    96			dev_err(dev, "Unable to initialise I2C Regmap\n");
    97			return PTR_ERR(regmap);
    98		}
    99		s2dos05->regmap = regmap;
   100	
   101		if (regmap_read(regmap, S2DOS05_REG_DEV_ID, &reg_data) < 0) {
   102			dev_err(dev,
   103				"device not found on this channel (this is not an error)\n");
   104			ret = -ENODEV;
   105		} else {
   106			dev_info(dev, "%s device found with id: .0x%x\n",
   107					__func__, reg_data);
   108		}
   109	
   110		i2c_set_clientdata(i2c, s2dos05);
   111	
   112		debugfs_file = debugfs_create_file("s2dos05-regs",
   113					0664, NULL, (void *)s2dos05,
   114					  &s2dos05_debugfs_fops);
   115		if (!debugfs_file)
   116			dev_err(dev, "Failed to create debugfs file\n");
   117	
   118		return mfd_add_devices(dev, -1, s2dos05_devs,
   119				ARRAY_SIZE(s2dos05_devs), NULL, 0, NULL);
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

