Return-Path: <linux-pm+bounces-8141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81128CFC83
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E6A2834F3
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34C138493;
	Mon, 27 May 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QVGLzXtk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318106CDAB
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801060; cv=none; b=guADSLSPNPg8POjFBWCqBSUd2CFyV12WK5GeeqhrVlgsue9P0zy4om/4kcyJPyruQl1h3a4o7u0rMmry+VFN2qK512J7JZR/78A0U9Md0qHOBJxEws9772mbFGTg1IGvKKOfwfrGRGQ/W2btei4/fi2pKboveEnmNqyhPE2B4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801060; c=relaxed/simple;
	bh=TxO63w8D2p8noAFp5GouE3gvIZzsMALJAEUvuR2DPU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnE5Or5L7nqGg7BtFXOlNxzrA4I2OljtPKkpsdlxrXh7S4Bx2QIAKaBugYOboSXf0Xf90bIAG6xIlZyLrhnsXhYCfBqHVgKeue+JJ4POb2cW9iMrm+uvhsYCIBH3HrAdIt+/aJOcXfwgEx7FpqAjI7WhaKpEP1hxL/9OSxaU/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QVGLzXtk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso49469641fa.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716801055; x=1717405855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQAdgIOQukEfXwjNGbipvur9+Z8l8KEKtuZqCxNPM88=;
        b=QVGLzXtk6t0Ta+eKYlDsu34L3z1c/WEFIFdwbTGJVbpgUkJb9OYr1JsYvax4ByYd8d
         nI18oXej3P0y5Rd8Ctt2QcGmE+Xts9rWcX20WmILoZQTevCOBKuqMPcSY9PlUCDUMHMD
         WRjMIOb75XIcBow7ieGuxqZLoiH/qp/ZB56XnZQPqAM2vcFTp8PffdALI/HEAU79ORD6
         g6sOIjKKdtDAIbmU08i6R0yb0WuF8/4NaL5IVZvCG11JRi94b4aOMWxquAhAXIyEh39C
         Cdvitib0k2cUkwM6OdfMK4iSrKSKS2GmijJVnKzyrYUjKboZVXhWLR25pQ3wBHwEfOWf
         ToVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801055; x=1717405855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQAdgIOQukEfXwjNGbipvur9+Z8l8KEKtuZqCxNPM88=;
        b=C6hDxLa41R6ojJ2qL2REh/UWDiP4+k8KG44fD8LfAWy1KbpOtb/zyw5BtEbRlfROWk
         LcYAHEB2q97D60645FpR2hLx+d2oRRiTATJh7c7k0BNDHk01ZLTJxEwDwwaedIsx0bHQ
         1A/bSUM+fCguURavVrsYJJpyPcNwLF1z0Ln5DWWeCTuYKzXhpFsvmnSkXcQt3Bh3TGl8
         tlZWvythhH7tw0mD6w8BkXhC22Xfuf93hQG8eGQfKQjfbasd78tRK47JLgNw+rExBY9b
         +zljWIljk5vyH6kqL2DSEM+c7EufzZk1I4kWX1ZZvAyCBqA/k4LVAjaHRw+q1zpSZS0b
         bO0w==
X-Forwarded-Encrypted: i=1; AJvYcCXNBf+l+x2krQ3EHnNLvUMCBCUAv8JOeSzWEYRJX/s5/XefOcXLPP+CLKNytHqsFnO/ErQEK0oHU2AXue+VVtMuOCdlLnZRxlE=
X-Gm-Message-State: AOJu0Yx5Llfkv74PHGkhfJF5sk85oeGoI3VBqmWr+wyEi6rX+FAJ1MrE
	InFJ0C2nNeCfJ5aneJWYTpkbzY6dTBkFujgW3i4JbR5jmy5QFUhp1Qkt7PT19cHx0ZZBcTNOPZQ
	abNU=
X-Google-Smtp-Source: AGHT+IE/XwhKrN+XuZVHuMIdiI6Yz8L2JavsRfmxvWtsUhZZt2NJ/SSG65g2ImH0JWmyID54LGpqBA==
X-Received: by 2002:a50:c314:0:b0:579:d23a:1990 with SMTP id 4fb4d7f45d1cf-579d23a1b41mr2344508a12.11.1716801035026;
        Mon, 27 May 2024 02:10:35 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d0b02625sm1538415a12.9.2024.05.27.02.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 02:10:34 -0700 (PDT)
Message-ID: <a2b06a40-4689-4fa9-90bb-9d34311d4221@suse.com>
Date: Mon, 27 May 2024 11:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: axp20x_usb_power: Add support for
 AXP717
To: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, broonie@kernel.org,
 lgirdwood@gmail.com, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
 <20240522230132.364915-4-macroalpha82@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240522230132.364915-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.05.24 01:01, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717. It does USB BC 1.2 detection similar to the
> AXP813, however it is otherwise very different from previous AXP
> devices.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

> +static int axp717_usb_init(struct axp20x_usb_power *power)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
> +				 AXP717_ADC_EN_VSYS_VOLT |
> +				 AXP717_ADC_EN_VBUS_VOLT,
> +				 AXP717_ADC_EN_VSYS_VOLT |
> +				 AXP717_ADC_EN_VBUS_VOLT);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This is a bit silly.

> +}
> +
>   static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>   					    int intval)
>   {
> @@ -307,6 +417,20 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>   	return -EINVAL;
>   }
>   
> +static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> +					    int intval)
> +{
> +	int val;
> +
> +	if (intval < 3880000 || intval > 5080000)

Do you really want raw numbers here?

[..]
> +static int axp717_usb_power_set_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return axp717_usb_power_set_input_current_limit(power, val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return axp717_usb_power_set_voltage_min(power, val->intval);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;

This is also a bit silly.

	Regards
		Oliver


