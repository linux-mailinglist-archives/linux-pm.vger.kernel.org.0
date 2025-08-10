Return-Path: <linux-pm+bounces-32084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CBB1F89D
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91B53B9BCA
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C732248BE;
	Sun, 10 Aug 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H+ZolKtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD921E0BE
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754807772; cv=none; b=tFjzcZXp6vRmgTuboJHxaL4LVNwiTN+G92Bd32KosUtJw2lscWXKjdHrsHIQrDkUYnDE6nZRA50bATAsBUlJE3HJ+U5inXZV+ootYf0eQ+m7WQnXL1ObhtyMSHQMTZ0wt0HZ0JYlF5LE6jEaLjwQn/aUzcdXKSWF6YCTG7z79oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754807772; c=relaxed/simple;
	bh=dxYJkPeB4UxLDG5tXiuCB4IDTXdl3DcJy1aWU+3GruA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjlaIz3WLO/NZgK4UkqpOYoFhQo3p9zUen8YFOfl6MR4N2nMLmmoWMj5Gfc6FqG06ViXx2aeIgDoPnBl0wTYZtB3qZM6eJoKizV2ELdD4Cx0NN47rKHrT1RDl9upxpVSEDUlPAOj/aQM4DMwO5ygfqC0yJvY6xZorraeOPfCSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H+ZolKtp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so3624607f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 23:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754807769; x=1755412569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enK6t5KGIg+LruZrfThBHUu3Mt7qcO2z+leeT+ugu7M=;
        b=H+ZolKtpo3Y1RSHPNtgszjhNSsRwsnSNOUrxoGi8YnLHvzMaf2aanlVkunZgJhQXdC
         hVh3w/Oxukbd6m7cRRV8L4t7mNyeAPl7peXNHrxwMNnM2d1ptkznlzxyRCVTFXudTiy8
         ttDs4W/bvKEM+qddZyKZKDYXCaD02QmTc+fNN+jH3WGJe4CP3DZJxioiDDyFymyhH3+J
         0D+K+nbeQ8xDEZfKpHCmOq95EOoIgxX/hE1j+GYDPyRmwaccF4v6bV89d0SQ07SMmmyX
         tVcccxq0jx5sF7BbQfw5I1NKmJLvSASUTy66OPycNKdks8czNvSsAzl2gKTentve9URR
         QX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754807769; x=1755412569;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enK6t5KGIg+LruZrfThBHUu3Mt7qcO2z+leeT+ugu7M=;
        b=vC4GZVL99/aARb0wjBQUt4PQRNigxz03KcBaqZQvX31/Zf2vF1kTyRhQ8iQClf9w83
         Oj6EFBBqHi+9fXs+Bwgv2QqHDl/KRbrjhL0M2a49JH2Gl8xzJu7m0jtdqiciUZevBiZc
         R5kYsjh6LJ0LalNoIv0wNHVjc5p2swzO91f8awu7t8AAYDZ3lxpM55HdpvhAs+3XZ/0a
         j96nH7FQKvUjL+tO8Ya1LtQ7V9olukKT9fTLWpDbdycjk8hYK52jesFcMyjajNK0d4gV
         lCsW4/39TPKznx0GRkWhhwh0cYPbDpvvQcpei8FB8O/+6cgiYaFnGGjeSeze+npDT+2z
         kPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qaWEJvzREg7kOPXddql5yd7tiZaOpWs+clhAmYb0ZFdMrEa3FvPYk/18VJDyTjtj4fCajfuqxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmQ5JcuWUHWc7IPLf1D1An0HpOxkE6Ov7cINmb3b/JFkaXRCB
	nXAbZgZVvoxkRBVl3KCPs7wgaJextcO969UCdm+PWo6PtQJILdZiHWPJDjwjlcWsvbU=
X-Gm-Gg: ASbGncvK2oS/FI/atmmmlgF9fh6R++Fp/VMuR8/5KyjFF4nYlsHqr9S7GoA1nj4LJUT
	5fL1bBA5SGgeVDntYkwJz/6x26q7NjlFSQ+7aWtfX+NxZJ3HsgWlJ8jy+de5QH6JnAYOir0EWWE
	ftxKPU5DO38nGYnUL4JWdxskIYhD7Mk5k9m58rACB7HSaqpKfCHQKv8chwJRKNiFypA/LRwCbZk
	6DLimvCydVq1N4aNNcx7TI+XSse/sDv90YN3wXmKQhvoeNvpcDxHx2KBykhL0YeagilFhTu4BcB
	o1rnvxWIdLsA4etWiHRGx/tPRmpLzQsEbLqRCzYddyi4c32xFM+y/+Sigu9BgbNP4J7OhBoOqRY
	RnME4xIFkE7ysgFGQr+g/D0HJntuSBks+oO0jTBt7JQ==
X-Google-Smtp-Source: AGHT+IHmNQ00RBKMICMOm289G3m3lvi/tK0YBzD0KPkGdwuOB4ix5SW7xxWMXMIQt9BAVjaFLPdtNA==
X-Received: by 2002:a05:6000:420b:b0:3b7:9b58:5b53 with SMTP id ffacd0b85a97d-3b900b78614mr7383299f8f.45.1754807769119;
        Sat, 09 Aug 2025 23:36:09 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95f4sm36052015f8f.23.2025.08.09.23.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 23:36:08 -0700 (PDT)
Message-ID: <8963764e-0948-4f11-a907-de74b0f8ba3b@tuxon.dev>
Date: Sun, 10 Aug 2025 09:36:06 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] thermal: renesas: rzg3s: Add thermal driver for
 the Renesas RZ/G3S SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
 <20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUUNFo4pqbXh1xMatsv7T7cnq0SmDxM_o9em0=gpurdCA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdUUNFo4pqbXh1xMatsv7T7cnq0SmDxM_o9em0=gpurdCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 26.03.2025 15:26, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, 24 Mar 2025 at 14:57, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
>> the junction temperature. The temperature is reported through a dedicated
>> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - drop the runtime resume/suspend from rzg3s_thermal_get_temp(); this
>>   is not needed as the temperature is read with ADC
>> - opened the devres group id in rzg3s_thermal_probe() and rename
>>   previsouly rzg3s_thermal_probe() to rzg3s_thermal_probe_helper(), to
>>   have simpler code; this approach was suggested by Jonathan in [1];
>>   as there is no positive feedback for the generic solution [2] this
>>   looks currently the best approach
> 
> Thanks for the update!
> 
>> --- /dev/null
>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c
> 
>> +static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +       struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
>> +       int ts_code_ave = 0;
>> +       int ret, val;
>> +
>> +       if (priv->mode != THERMAL_DEVICE_ENABLED)
>> +               return -EAGAIN;
>> +
>> +       for (u8 i = 0; i < TSU_READ_STEPS; i++) {
>> +               ret = iio_read_channel_raw(priv->channel, &val);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               ts_code_ave += val;
>> +               /*
>> +                * According to the HW manual (section 40.4.4 Procedure for Measuring the
>> +                * Temperature) we need to wait here at leat 3us.
>> +                */
>> +               usleep_range(5, 10);
>> +       }
>> +
>> +       ret = 0;
>> +       ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
>> +
>> +       /*
>> +        * According to the HW manual (section 40.4.4 Procedure for Measuring the Temperature)
>> +        * the computation formula is as follows:
>> +        *
>> +        * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
>> +        *
>> +        * Convert everything to mili Celsius before applying the formula to avoid
> 
> milli
> 
>> +        * losing precision.
>> +        */
>> +
>> +       *temp = DIV_ROUND_CLOSEST((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
>> +                                 MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
> 
> This is a 64-by-32 division. When compile-testing on arm32:
> 
> rzg3s_thermal.c:(.text+0x330): undefined reference to `__aeabi_ldivmod'

Thank you for reporting this! I'll switch to div_s64().

Claudiu

> 
>> +
>> +       /* Report it in mili degrees Celsius and round it up to 0.5 degrees Celsius. */
> 
> milli
> 
> 
>> +       *temp = roundup(*temp, 500);
>> +
>> +       return ret;
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


