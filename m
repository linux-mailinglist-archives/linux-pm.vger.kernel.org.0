Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F55117279
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 18:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIRJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 12:09:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54016 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRJE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 12:09:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so88715wmd.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ea4/PrZomre2i6zXGutNZcRSd2/RfVCGFIF5aKKigpg=;
        b=G89bKlHTuIczjERUM7QoxO9gQNhhCJDzRyB73CspgjnYN17lwJLCyIpIsTJ+6oCYCh
         kMWAkZtHWnoro7FaJEYnANtUpg61L+NyU1lcpEpjb56VzXYNOSvcx5/i4eBYSwMrprGC
         YEEWuCa19HV6p8zlpHXB6pkendQRqg1IM9Pxamz1mVs6esNBVyDM+CPBVXR8g/vVHcGM
         OkRN+RffI5J7kn0Cn40HcOGbVtb9YUR3hU4Hjf+2kZZ/DXTCKHLOudrTXVhShPC26g60
         ZJdnFc3xDF0g2xUs7ZuUdMgHK3TEn14Fybrrd9EFF54cUi2itgoNyB5BJQD9vOvUnp/T
         J1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ea4/PrZomre2i6zXGutNZcRSd2/RfVCGFIF5aKKigpg=;
        b=AavDHZ5Xrz2J6Q+lOeShuIuJHRI9sZ8WRxt61WiyqqJI0NCaIOOZixixPr209DUJdy
         7+pHjGUvnT7WRQtsmMF6RY6Ln6o1MaDTAI+sfHxqKpSOEtffNjz1e0YGFwbXADuYZgTs
         1yCW3dK1hkvF3kwlDiwx6FlAdgzexQJaau4jX0ZDJjvXVQQEbz4nfUIUe4DOe129ABr7
         V3kdjakIl3eCGyauL1DDRduJ8ymH2RtmnQ3xuvzqmqH2MdVSxgQexfHRfJ/WlK6I4g4L
         W0CBouFXVemCBzYgyBavAT/eG3j16jBiWrczdoVT3zm5hcmODV3MXmZybugwQtEMoR0D
         XfTw==
X-Gm-Message-State: APjAAAVBYpfzT0olYmY/iTnWeOwvDXfyw5qnIhBg72Sb6C8hEHvGWHx+
        OlFXxM50IGcVUujbF9TF9vwAH0kTmtU=
X-Google-Smtp-Source: APXvYqweu5sJJ/Vw8xl26KkVBRmHTsmcoLCvukjF1nH+mx7H5AW5d0klOdHvbnPnd8IRnvy/l2vH0g==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr94947wmc.6.1575911341704;
        Mon, 09 Dec 2019 09:09:01 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id x6sm468505wmi.44.2019.12.09.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:09:01 -0800 (PST)
Subject: Re: [PATCH] thermal: rockchip: enable hwmon
To:     schaecsn@gmx.net, rui.zhang@intel.com, edubezval@gmail.com,
        amit.kucheria@verdurent.com, heiko@sntech.de,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191118052413.D729B6E85603@corona.crabdance.com>
 <20191202145256.78AA06E85603@corona.crabdance.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e3b6e675-14de-d020-48f4-a8ed877646ab@linaro.org>
Date:   Mon, 9 Dec 2019 18:08:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202145256.78AA06E85603@corona.crabdance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Stefan,


On 02/12/2019 15:52, Stefan Schaeckeler wrote:
> Hello linux power management mailing list and others,
> 
> New month, new try. Could someone review this patch, please. I would reall=
> y
> like to see the Rockchip RK3399 temperature sensors hooked up to the hwmon=
>  API.

I don't know what is happening but there are some spurious '3D'
characters. Please fix it, elaborate a bit the changelog and resend.
I'll review it.

Thanks


>> Enable hwmon for the soc and gpu temperature sensors.
>>
>> Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
>>
>> ---
>>  drivers/thermal/rockchip_thermal.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockch=
> ip_thermal.c
>> index 343c2f5c5a25..e47c60010259 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -19,6 +19,8 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/pinctrl/consumer.h>
>>
>> +#include "thermal_hwmon.h"
>> +
>>  /**
>>   * If the temperature over a period of time High,
>>   * the resulting TSHUT gave CRU module,let it reset the entire chip,
>> @@ -1321,8 +1323,15 @@ static int rockchip_thermal_probe(struct platform=
> _device *pdev)
>>
>>  	thermal->chip->control(thermal->regs, true);
>>
>> -	for (i =3D 0; i < thermal->chip->chn_num; i++)
>> +	for (i =3D 0; i < thermal->chip->chn_num; i++) {
>>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>> +		thermal->sensors[i].tzd->tzp->no_hwmon =3D false;
>> +		error =3D thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
>> +		if (error)
>> +			dev_warn(&pdev->dev,
>> +				 "failed to register sensor %d with hwmon: %d\n",
>> +				 i, error);
>> +	}
>>
>>  	platform_set_drvdata(pdev, thermal);
>>
>> @@ -1344,6 +1353,7 @@ static int rockchip_thermal_remove(struct platform=
> _device *pdev)
>>  	for (i =3D 0; i < thermal->chip->chn_num; i++) {
>>  		struct rockchip_thermal_sensor *sensor =3D &thermal->sensors[i];
>>
>> +		thermal_remove_hwmon_sysfs(sensor->tzd);
>>  		rockchip_thermal_toggle_sensor(sensor, false);
>>  	}
>>
>> --
>> 2.24.0
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

