Return-Path: <linux-pm+bounces-32086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB810B1F8A7
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD77317B207
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6A22FF2E;
	Sun, 10 Aug 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DQxdilTd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044E19CC28
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808473; cv=none; b=QG9zbYm7qk/+Tq2qw0h3LZBsyXDrDtMJSOk74OKeuy8u8eUTR+plWMZheds0v55j3kdfXqhS60YTLOo1JOjYNFVureFLa8wKRxhCyEIRUB4MeXLs4Ym/fzqQy3ngwxTqVdoyp1ou/53XmTNyJ+5qlVfRKDFdc52oOhGM1Q7mmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808473; c=relaxed/simple;
	bh=dagAYUKfMf7MQB3tjh0eU5W/hnyL6zIsoo1NhGvUigg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpWfxmh1kdEQZ7H5+0axE0euBPLSbiktNslEANxUeIfuGfMMmjo88MUMsssSxokbX+BIfZnnmMKBHlMX++uZTlQ23HdXWwSfPfwXjl2clSESSvbHL3DPVzYYbXUsLaylmiZlUPmxRuEF8xYOOesGVOdS0JpOo2PJN05XPeugO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DQxdilTd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so5415633a12.3
        for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754808467; x=1755413267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sC8ppSX1H/0TCM/Y3FF+igzDwHvNt7j5FKY8GrjOIKg=;
        b=DQxdilTdy7VTW3wQiFxUXJ4/o5yAvKO6L20sAYRURUdpsoPabe9Wmgad7FkgzrcKVO
         PrJutt/t627s8WKngiENHad6DMnNYyQkXj/MekcMGG/9BZpvofcS9GxKeUx2Igiw1efu
         wAK+wxUB0veaNSpVgzD6BHQwD8L9wXgMYXNBObRMtnC8JOzbBn/k1frO3BzHvE9H6w2g
         GqywEEuBOjYik8fHcmz36tZADocyZjJXY5tFBGDR3uJkqdCCLyJeq99FWQn15X/DwBW7
         JvxlladAmIVmqLb/htNsOFcpa2bi4noZ382DYsKPmr/CUlAlLVCfc4Nm+L7uXUGv9PtS
         bsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754808467; x=1755413267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sC8ppSX1H/0TCM/Y3FF+igzDwHvNt7j5FKY8GrjOIKg=;
        b=WRcz0+zjaIeelZFjbh7iM5I1tWLXToJEbvYFcHQodOLf5yJN2WS5F4OZbEM9MyikMP
         kQwPTlkKZb9Yy5e8YS6dn8A5hSCPnwfGEda0z+L0WzaU5oQKL1QvQ4gjhXpd4z6I0yyY
         xuvfVW7KqieudK0d7BK/3kxBAt6Inlo/Adki2iVPpc4IU4FVRVMEUVp4lXw2DVhB1UIW
         dxzM5XdACINXSsBJyJ8o+yO+/sQIi9P2b61giI/YbFwIfE7VFSrOHwSo1yBADPy35Em9
         G9ft+7bh3DNqGgWcbUpQdYmGC+5lDBHWxQVSFXrmNLj5TZ32XOzVzqMAotKXm+dqLKzT
         juJw==
X-Forwarded-Encrypted: i=1; AJvYcCWLmmt3lBS0Cd0KnFlqMN+BR43uZCZouEqtdqIf7I5JVve+hf//tHc4ABeML3VWu7kI3lYs0jHTMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sMJrIZ4cY0HnaQ2V/oEajsh18wh0+6D5gHDQd96Nr7katHbR
	znY5pfmq8f5vklQAXH7pH+CaLN2hmHPsGlBQzOIX5bJQvAkNQMN04RzXTAipyuEJCRk=
X-Gm-Gg: ASbGncsSzFytzGpDPaPJ3M15KX/zZa7L4BLivgXmr8mLwPGcXrjDNuhvhPQ9BfyCfj+
	9bFZrcscPgw+LEv8plxXu7kQlCqXxmCE5unx+BmpkgjZhOn9gi2CO4v6iZoBA4XdNlg3/iJ8dKp
	U6Zrp6muICRIiAFLoHgRBs83pih3DiVLNCs6la0Cmf4JQwb8R4Td98b2oludcXgkryk8AcqLmjv
	udfEl9GkgFL/kYD6arr/f1XZM5GuGtq+zkSe1OANuq2p8mxuCXs/4itVrbC3vSP45Q0clVqZ70G
	wr4ZgW5G+f2t4LjWWFXQpUjClOvUuV/OEfTVqZFktO4FwDtOLxTvL9njh3qwEaP/0Ps2JvwSZVW
	Y85/UPE678+kE4j6uLx+DabqEGhN+flymK3dNoBbwow==
X-Google-Smtp-Source: AGHT+IH/7dzLzWQyWlGILSjoAFS8eflMGUJjXYYLSezW9ohIbVGYZPagLxPqBOuF4SYx6XNBcYwt7w==
X-Received: by 2002:a05:6402:51cb:b0:615:c767:5ba1 with SMTP id 4fb4d7f45d1cf-617e2b661aemr7951088a12.3.1754808467315;
        Sat, 09 Aug 2025 23:47:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm16219007a12.52.2025.08.09.23.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 23:47:46 -0700 (PDT)
Message-ID: <1cc60291-194d-4d8c-ad0d-f83651ba4fc5@tuxon.dev>
Date: Sun, 10 Aug 2025 09:47:44 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] thermal: renesas: rzg3s: Add thermal driver for
 the Renesas RZ/G3S SoC
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
 <20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com>
 <20250705120617.GA671672@ragnatech.se>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250705120617.GA671672@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Niklas,

On 05.07.2025 15:06, Niklas Söderlund wrote:
> Hi Claudiu,
> 
> Thanks for your work. 
> 
> Sorry for late review, Geert only alerted me to the series a few days 
> ago.
> 
> On 2025-03-24 15:56:59 +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
>> the junction temperature. The temperature is reported through a dedicated
>> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>

[ ...]

>> +static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
>> +	int ts_code_ave = 0;
>> +	int ret, val;
>> +
>> +	if (priv->mode != THERMAL_DEVICE_ENABLED)
>> +		return -EAGAIN;
>> +
>> +	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
>> +		ret = iio_read_channel_raw(priv->channel, &val);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ts_code_ave += val;
>> +		/*
>> +		 * According to the HW manual (section 40.4.4 Procedure for Measuring the
>> +		 * Temperature) we need to wait here at leat 3us.
>> +		 */
>> +		usleep_range(5, 10);
>> +	}
>> +
>> +	ret = 0;
>> +	ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
>> +
>> +	/*
>> +	 * According to the HW manual (section 40.4.4 Procedure for Measuring the Temperature)
>> +	 * the computation formula is as follows:
>> +	 *
>> +	 * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
>> +	 *
>> +	 * Convert everything to mili Celsius before applying the formula to avoid
>> +	 * losing precision.
>> +	 */
>> +
>> +	*temp = DIV_ROUND_CLOSEST((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
>> +				  MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
> 
> The issue Geert points out, can that not be solved by holding off 
> converting to MCELSIUS() to after you have done the calculation?

This method works as well, but at the cost of some precision. As of my
experiments, with it there will be no temperatures with .5 Celsius
resolution (e.g., 50.5, 51.5, 52.5, etc) reported.

Thank you,
Claudiu


