Return-Path: <linux-pm+bounces-13372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F89693B6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E9C1F22243
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A81D1748;
	Tue,  3 Sep 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4mSJLz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E91CF28D;
	Tue,  3 Sep 2024 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345216; cv=none; b=IGm20OTWznVrhw54sDzdjRlGNejiFgmZkxHOAna3NA3Nr+9//GHhY6KbLVORISTz+XuIEflKTi83mVrWet+l/AbUJqFCMJiqX+myzsimRjGEGChar9QFTUcf5XFRJwkXr+ilODnOE139uKZZ42SBpGA0GytoKpi8cjyQEjSZYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345216; c=relaxed/simple;
	bh=/ETU4Zg+gZbDCijJZh+v1f83eNoEuhOTttHyhGA5MI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgPsGPG8y6htRaysziXVjyPMkzAUIAaICszRdk0e+/DxzVBx85vY5n9QwVBTtX6cXHM/Et1h0tJKrXUkMExru4nbwUJC68g7WHRr6qdTxzZtkR1nX7eIwrUMAtZxOuzqq0WOZsocX94Khj4A/E8a09mFzadn8egVnf50KsfiuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4mSJLz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso42364555e9.1;
        Mon, 02 Sep 2024 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725345213; x=1725950013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jkw8wh5XcYHCUVel8oCflwMwuY/DKbg13rPtqVXJAM=;
        b=kF4mSJLzE80eg3sHEiRfo5vjydzDDPoOZtaI8fKNZK7hg3k3p34gVm/y5u9ZX4BmQe
         +JpfmqsX9250F2XzHLmJZMFvnqmRvVlygGg9/BmFj14meD2uJpW170SGnLEXTbXiG7CB
         11DqhiIQuCTuWF/T9HapKrAuyrqmjtzFG6J39IlRiOvUCAbrvNY3wkLq5SihuUMBX7I6
         TvAfopGCvjn2LlyOwIwota3+3OWby8Z/HWIHMGabsRCnfxQahCDT7sO9e33FbNNkx3y1
         iR1gz54y9La4HT+g9wySH6qReM7qa65QYk6NsLh7uQInrvCEOvy4aU6qbl0KD5uWrtwB
         U3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345213; x=1725950013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jkw8wh5XcYHCUVel8oCflwMwuY/DKbg13rPtqVXJAM=;
        b=o7+81WF5VMufXso4PexAXHlOOiP722M/mdnFJB+fPA9VBVl4/ZXwH2+vqx35AiBp63
         /sZsPFbfBasA2jiyEgnX8S5DpsyiSXk481UTezvLzfNNO+Hg3gEUDIbi6lnPOeFfb04P
         fB2fArMojF/QV8xZgQzzhOK+8hXbdDVsqjoj1FkfYHyZhGKo78z8682Al9NO5EqHZ6t6
         38O7YGjiD1VVZrF1MTU2hTVn6zT6O/Rya06KkJW81Jo6+xWH44/wlWcNH2fgz0e4cTB7
         sENAE4o1XSR94jeX35STYxJyAEvegzRDccNMFr/+GHmg/m5FbuXrlIga2yqrrxLdO7d1
         mQSg==
X-Forwarded-Encrypted: i=1; AJvYcCU8n4ShW+dkbcJ9ooJAlcNdAxNW0sv1n1dV2rd51t4oq25Kd9fxdqgrabi81vuC8g1gTE2hoPhcc1cmMYM=@vger.kernel.org, AJvYcCWqOn5AwjMAAU2wOXom+bLojLg9OnHgFuP9hjvtnBR7eNyNQjpOw9mP9ACGPWA/HjwkL5U5nfU9UGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqvtbmsLf3/92ejuIHSZ68tbkl7wu5DVEGHJIMhUGAB++TCtE
	sy/grBunPrTplja6z5ECjkVrAT0pOPN814/1wf9Ikq9k1E4oMaTtfVC0Tg==
X-Google-Smtp-Source: AGHT+IEkCFuBfPSKgwsHbasQVM89OhrDkrPZn/oya7O3TwEC75nr81BWBc7/oAXhGnZajgDC873NWQ==
X-Received: by 2002:a05:600c:3b97:b0:426:59aa:e2fe with SMTP id 5b1f17b1804b1-42bb01c2071mr110788775e9.19.1725345212412;
        Mon, 02 Sep 2024 23:33:32 -0700 (PDT)
Received: from debian ([2a00:79c0:634:9a00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb2dcsm160157605e9.1.2024.09.02.23.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 23:33:31 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:33:29 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: max1720x: add read support for nvmem
Message-ID: <20240903063329.GA222264@debian>
References: <20240831182145.11589-1-dima.fedrau@gmail.com>
 <01020191b4bc8ff0-e7e8d909-4802-4076-9caf-cee0296fd10d-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020191b4bc8ff0-e7e8d909-4802-4076-9caf-cee0296fd10d-000000@eu-west-1.amazonses.com>

Am Mon, Sep 02, 2024 at 09:55:42PM +0000 schrieb Sebastian Reichel:
> Hi,
> 
> On Sat, Aug 31, 2024 at 08:21:45PM GMT, Dimitri Fedrau wrote:
> > ModelGauge m5 and device configuration values are stored in nonvolatile
> > memory to prevent data loss if the IC loses power. Add read support for
> > the nonvolatile memory on MAX1720X devices.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > 
> > Based on:
> > 479b6d04964b "power: supply: add support for MAX1720x standalone fuel gauge"
> > in branch for-next
> > 
> > Changes in V2:
> >   - remove function max1720x_remove and use devm_add_action_or_reset() to
> >     unregister info->ancillary to avoid race condition during module remove
> 
> Thanks, but the transformation is quite incomplete. You probably
> should have a look what device managed resource actually means :)
>

Yes, I noticed shortly after sending V2, that I missed to remove all
i2c_unregister_device calls in the error path. Already prepared V3
handling this and also the missing header "linux/nvmem-provider.h".
Thanks for reviewing so quickly, I just hoped to get away with this by
sending V3 before you notice. :)

> > ---
> >  drivers/power/supply/max1720x_battery.c | 220 ++++++++++++++++++++++--
> >  1 file changed, 205 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> > index edc262f0a62f..d27c94bdb835 100644
> > --- a/drivers/power/supply/max1720x_battery.c
> > +++ b/drivers/power/supply/max1720x_battery.c
> 
> [...]
> 
> > +static int max1720x_probe_nvmem(struct i2c_client *client,
> > +				struct max1720x_device_info *info)
> >  {
> >  	struct device *dev = &client->dev;
> > -	struct i2c_client *ancillary;
> > +	struct nvmem_config nvmem_config = {
> 
> As noticed by the build bot: you need to add this include for the
> struct:
> 
> #include <linux/nvmem-provider.h>
>
Will fix it.

> > +		.dev = dev,
> > +		.name = "max1720x_nvmem",
> > +		.cells = max1720x_nvmem_cells,
> > +		.ncells = ARRAY_SIZE(max1720x_nvmem_cells),
> > +		.read_only = true,
> > +		.root_only = true,
> > +		.reg_read = max1720x_nvmem_reg_read,
> > +		.size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
> > +		.word_size = 2,
> > +		.stride = 2,
> > +		.priv = info,
> > +	};
> > +	struct nvmem_device *nvmem;
> > +	unsigned int val;
> >  	int ret;
> >  
> > -	ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
> > -	if (IS_ERR(ancillary)) {
> > +	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
> > +	if (IS_ERR(info->ancillary)) {
> >  		dev_err(dev, "Failed to initialize ancillary i2c device\n");
> > -		return PTR_ERR(ancillary);
> > +		return PTR_ERR(info->ancillary);
> >  	}
> >  
> > -	ret = i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
> > -	i2c_unregister_device(ancillary);
> > -	if (ret < 0)
> > -		return ret;
> > +	ret = devm_add_action_or_reset(dev, max1720x_unregister_ancillary, info);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add unregister callback\n");
> > +		goto err;
> > +	}
> >  
> > -	info->rsense = ret;
> > +	info->regmap_nv = devm_regmap_init_i2c(info->ancillary,
> > +					       &max1720x_nvmem_regmap_cfg);
> > +	if (IS_ERR(info->regmap_nv)) {
> > +		dev_err(dev, "regmap initialization of nvmem failed\n");
> > +		ret = PTR_ERR(info->regmap_nv);
> > +		goto err;
> > +	}
> > +
> > +	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to read sense resistor value\n");
> > +		goto err;
> > +	}
> > +
> > +	info->rsense = val;
> >  	if (!info->rsense) {
> >  		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
> >  		info->rsense = 1000; /* in regs in 10^-5 */
> >  	}
> >  
> > +	nvmem = devm_nvmem_register(dev, &nvmem_config);
> > +	if (IS_ERR(nvmem)) {
> > +		dev_err(dev, "Could not register nvmem!");
> > +		ret = PTR_ERR(nvmem);
> > +		goto err;
> > +	}
> > +
> >  	return 0;
> > +err:
> > +	i2c_unregister_device(info->ancillary);
> 
> devm_add_action_or_reset() already unregisters on failure, so this
> results in a double unregister. Please also simplify 'goto err'
> with 'return ret;'.
>
Will fix it.

> > +
> > +	return ret;
> >  }
> >  
> >  static const struct power_supply_desc max1720x_bat_desc = {
> > @@ -299,20 +487,22 @@ static int max1720x_probe(struct i2c_client *client)
> >  
> >  	psy_cfg.drv_data = info;
> >  	psy_cfg.fwnode = dev_fwnode(dev);
> > +	i2c_set_clientdata(client, info);
> >  	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
> >  	if (IS_ERR(info->regmap))
> >  		return dev_err_probe(dev, PTR_ERR(info->regmap),
> >  				     "regmap initialization failed\n");
> >  
> > -	ret = max1720x_probe_sense_resistor(client, info);
> > +	ret = max1720x_probe_nvmem(client, info);
> >  	if (ret)
> > -		return dev_err_probe(dev, ret,
> > -				     "Failed to read sense resistor value\n");
> > +		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> >  
> >  	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
> > -	if (IS_ERR(bat))
> > +	if (IS_ERR(bat)) {
> > +		i2c_unregister_device(info->ancillary);
> 
> This is also already handled by devm and must be removed.
>
Will fix it.
> >  		return dev_err_probe(dev, PTR_ERR(bat),
> >  				     "Failed to register power supply\n");
> > +	}
> >  
> >  	return 0;
> >  }
> 
> -- Sebastian

Best regards
Dimitri Fedrau

