Return-Path: <linux-pm+bounces-9338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86D90B320
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBA1C2263A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BB139D1C;
	Mon, 17 Jun 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSl1+QeL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E05139D0C
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633267; cv=none; b=JS0CBCiE9NeF/IQFwlugfu57dYE4M/dAW0HheQmZakmgtKvGUJ9LHzWvP3A7hMF2E4eDwQjoBm6aclXMKX0HKXy/+pvuD+mbkTwU6LII3eSEiaV5bK/A82Y5ZPeeK+6Jkhb86YLslwo1RMO9fIGm4hENavGtAf0iaxcsjWGj6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633267; c=relaxed/simple;
	bh=gTaVRInUM5Dk+G0y4kJvxr34Ay3xC6qugD0PHbnJD6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oU0C1h0fu3mFkVMYY8Ilr9oq8pkst0s0tLUtQACSq52NZPKeP7XnVFiQ9cNgwx3MJGrG7cxVE08EodW4OMcMCrNG0Lsqof8Sxxwiga2mCHqc14HfznFWDEEEbDX/6fme6IPYLYocDTuTxFv1hnIripb/GRsTfux/5TCwYTPsqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSl1+QeL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so43214731fa.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718633264; x=1719238064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exNmLeQ/1saUICwG+i10ZbiGFu61QQGdsTZZy7V7AmA=;
        b=vSl1+QeLmXxICiZ68G/dl9zWRbYd3IPB+tKMulXcWTRZjyeUEMLitMUmTgzHT0IopK
         rHdls6Ce/NOFUAd4kYB6dzn+bUgTWv5yNKxMQ3HozAjb5eZZ7y0+qWhWUQaika1E8BwA
         V94LTzqPUJPEOz7OLMOyavta4angbxvn02h6CM/gM26J9UGV72em+KX1rOMjXYN9udL3
         TDx5zjM3lImyPe3ZjmZJhS4HRcawTLJvguzQrYdT367EGneizMeHEa8zevhxaplFI6b2
         d/VS8XjF5gYL5jngvT9WnAlbuGM4oHijEPmXI4pMHAMxORqAHPuZAaxgqGvoRTt7k97P
         tKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633264; x=1719238064;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exNmLeQ/1saUICwG+i10ZbiGFu61QQGdsTZZy7V7AmA=;
        b=end43SkZ6sgMdu3Jg7E4UrHzi12m8VwA80c38HzQ/Y9j0NeSHW8npw+sIEAqkhOSl1
         ifM1wgZHNwReNEpPEMcokydULuVk+8vN0F69CNE+n/DD76ZC3OY7o2HrnBo2LZCtbe/L
         8JtxAJr3dQK9znG4XgSKqeAiW/aOeQgBfLQ80h+ti3PmCNIyafNXRvwNXFM8uYwn5FkE
         xoE1vGmADZI0Y5UyF7QfbobJZMB8FX+43N1cdz1ozlnwSwkpSX3eKs7KKKcgYITrbROX
         Y/HX4JptoObbnEpzSfNpz6vlJirg40nkuZfq2RtWNl61zdPQIgQiV038tpAdMXoqczpx
         TN4w==
X-Forwarded-Encrypted: i=1; AJvYcCVWDf9NCKwbAnvPozz5jbfi6GfLCwBJHFM4kwmq8OzxUtNmHPfSaA4wVcQCGOGFyNylWSOo9OdHuuZuEpwhHMXqmpZlaIBjz1k=
X-Gm-Message-State: AOJu0Yx8lMR2PJK2fDQ+P/vBO5zJHvtOUKT3LgM7HXdy2Yyt0gM1nyCx
	OlcgZLDCnn9eGIPzs1d0U+05sH1vJslLB2mUWQ0eMK8NtlnEkseFZV0F04MZlKE5OGV3sAjgq22
	Z
X-Google-Smtp-Source: AGHT+IFQsaa8hu5ihcOpX77WzFDdvfqH0xHmzhwYvaZnRHLXsr04EN96LjycixPt/HX3eDQag2dJ6g==
X-Received: by 2002:a05:651c:1a1e:b0:2ec:eee:f19e with SMTP id 38308e7fff4ca-2ec0eeef77fmr74104111fa.37.1718633263311;
        Mon, 17 Jun 2024 07:07:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c70sm159742255e9.30.2024.06.17.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:07:43 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:07:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <f37587e6-bed8-4d91-889f-983bef03cde8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615203352.164234-3-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/dt-bindings-power-supply-add-support-for-MAX17201-MAX17205-fuel-gauge/20240616-043602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240615203352.164234-3-dima.fedrau%40gmail.com
patch subject: [PATCH v3 2/2] power: supply: add support for MAX1720x standalone fuel gauge
config: nios2-randconfig-r081-20240616 (https://download.01.org/0day-ci/archive/20240617/202406170040.gxB0dYxg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406170040.gxB0dYxg-lkp@intel.com/

smatch warnings:
drivers/power/supply/max1720x_battery.c:285 max1720x_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +285 drivers/power/supply/max1720x_battery.c

134a669e205435 Dimitri Fedrau 2024-06-15  251  static int max1720x_probe(struct i2c_client *client)
134a669e205435 Dimitri Fedrau 2024-06-15  252  {
134a669e205435 Dimitri Fedrau 2024-06-15  253  	struct power_supply_config psy_cfg = {};
134a669e205435 Dimitri Fedrau 2024-06-15  254  	struct device *dev = &client->dev;
134a669e205435 Dimitri Fedrau 2024-06-15  255  	struct max1720x_device_info *info;
134a669e205435 Dimitri Fedrau 2024-06-15  256  	int ret;
134a669e205435 Dimitri Fedrau 2024-06-15  257  
134a669e205435 Dimitri Fedrau 2024-06-15  258  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
134a669e205435 Dimitri Fedrau 2024-06-15  259  	if (!info)
134a669e205435 Dimitri Fedrau 2024-06-15  260  		return -ENOMEM;
134a669e205435 Dimitri Fedrau 2024-06-15  261  
134a669e205435 Dimitri Fedrau 2024-06-15  262  	i2c_set_clientdata(client, info);
134a669e205435 Dimitri Fedrau 2024-06-15  263  	info->bat_desc.name = "max1720x";
134a669e205435 Dimitri Fedrau 2024-06-15  264  	info->bat_desc.no_thermal = true;
134a669e205435 Dimitri Fedrau 2024-06-15  265  	info->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
134a669e205435 Dimitri Fedrau 2024-06-15  266  	info->bat_desc.properties = max1720x_battery_props;
134a669e205435 Dimitri Fedrau 2024-06-15  267  	info->bat_desc.num_properties = ARRAY_SIZE(max1720x_battery_props);
134a669e205435 Dimitri Fedrau 2024-06-15  268  	info->bat_desc.get_property = max1720x_battery_get_property;
134a669e205435 Dimitri Fedrau 2024-06-15  269  	psy_cfg.drv_data = info;
134a669e205435 Dimitri Fedrau 2024-06-15  270  
134a669e205435 Dimitri Fedrau 2024-06-15  271  	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
134a669e205435 Dimitri Fedrau 2024-06-15  272  	if (IS_ERR(info->regmap))
134a669e205435 Dimitri Fedrau 2024-06-15  273  		return dev_err_probe(dev, PTR_ERR(info->regmap),
134a669e205435 Dimitri Fedrau 2024-06-15  274  				     "regmap initialization failed\n");
134a669e205435 Dimitri Fedrau 2024-06-15  275  
134a669e205435 Dimitri Fedrau 2024-06-15  276  	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
134a669e205435 Dimitri Fedrau 2024-06-15  277  	if (IS_ERR(info->ancillary))
134a669e205435 Dimitri Fedrau 2024-06-15  278  		return dev_err_probe(dev, PTR_ERR(info->ancillary),
134a669e205435 Dimitri Fedrau 2024-06-15  279  				     "Failed to initialize ancillary i2c device\n");
134a669e205435 Dimitri Fedrau 2024-06-15  280  
134a669e205435 Dimitri Fedrau 2024-06-15  281  	i2c_set_clientdata(info->ancillary, info);
134a669e205435 Dimitri Fedrau 2024-06-15  282  	ret = max1720x_probe_sense_resistor(info);
134a669e205435 Dimitri Fedrau 2024-06-15  283  	if (ret) {
134a669e205435 Dimitri Fedrau 2024-06-15  284  		i2c_unregister_device(info->ancillary);
134a669e205435 Dimitri Fedrau 2024-06-15 @285  		return dev_err_probe(dev, PTR_ERR(info->bat),

s/PTR_ERR(info->bat)/ret/

134a669e205435 Dimitri Fedrau 2024-06-15  286  				     "Failed to read sense resistor value\n");
134a669e205435 Dimitri Fedrau 2024-06-15  287  	}
134a669e205435 Dimitri Fedrau 2024-06-15  288  
134a669e205435 Dimitri Fedrau 2024-06-15  289  	info->bat = devm_power_supply_register(dev, &info->bat_desc, &psy_cfg);
134a669e205435 Dimitri Fedrau 2024-06-15  290  	if (IS_ERR(info->bat)) {
134a669e205435 Dimitri Fedrau 2024-06-15  291  		i2c_unregister_device(info->ancillary);
134a669e205435 Dimitri Fedrau 2024-06-15  292  		return dev_err_probe(dev, PTR_ERR(info->bat),
134a669e205435 Dimitri Fedrau 2024-06-15  293  				     "Failed to register power supply\n");
134a669e205435 Dimitri Fedrau 2024-06-15  294  	}
134a669e205435 Dimitri Fedrau 2024-06-15  295  
134a669e205435 Dimitri Fedrau 2024-06-15  296  	return 0;
134a669e205435 Dimitri Fedrau 2024-06-15  297  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


