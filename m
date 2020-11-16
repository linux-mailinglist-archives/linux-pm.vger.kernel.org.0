Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6D2B3EC6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 09:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKPIfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 03:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKPIfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 03:35:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D4C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 00:35:10 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so17707270wrx.5
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3pLQC/E5zB5lHnw308Bcg98VJGiT9RpVsUiOih9/i8=;
        b=ECuwEu2z5NQkl9XD/uIQNc7drJbCBnA9T6Jhd+8IuKy47G6yRS/B4Sp1n1IWo7isCd
         Ja88GvjqLYVcdE5vaykbBqQISw8Wj4Nqs41hh3epIoDRBcLtePYgUwzJZo8IL2+V1KJQ
         oLtAM6VXD+M0lSdDGsj4goty3V+9M4HW8s9qq87yHliXs6/sU9JZKDGoBpUA+P83JA2b
         fpv4x3K4FdVPVDIhpjzw6wnLjxnVSD8tPcdneZTwLJtddCOuDOjaP0YCvj2jc6RW1T/V
         RaF3Nyp164Y+0ukmFmNFFeSBmIXntx1erabf5Lm6pehCgC1pBNDnLorFuiXGemK9Ppk2
         1REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A3pLQC/E5zB5lHnw308Bcg98VJGiT9RpVsUiOih9/i8=;
        b=B4NeDArA120xDcx7X4S3npnFy+XCzUI8rmn+SgnA2bOheAI5z+6s95iwOqhx/a8RA8
         Rvh+self/E4u2Tb18zTjSpknBDXc1uM4uxuu+uAi3nMGvTkWUuEqshNaTiJucm82aU6z
         FMc+ipFBAriaIlaE/W8h/G5YS04CwcyLZq02WXCQlSFA2h/OAvMvYobAOgufgOO64Ure
         6D4ber7TosE2XK0tBQ7Mgolz+Fsx2TXoqlgLSF72yDiY6mqyV2xqbiC91lWqPH8gANDl
         d7VN+S9N9feRKZGt9suROZQaJtyXvfk+MVvk1sa3gZPpRVGL7hGQw2vqRFw/X8EM1CFB
         1MDw==
X-Gm-Message-State: AOAM532zMB6hYtRbbU0oQLuU9hjuxrepbnEOl4kxF3PI1DDCKW9sgdLF
        tNIAuBknfw3OrGs/7/I6NjgUgzs8JYBFgU3w
X-Google-Smtp-Source: ABdhPJx1lgl6O2HAzxIH+t/WRfKoER3eQV93iwgUAIxHNkqTbWLjhz3SuYVVhlGh1jBKfoaRy8jS7g==
X-Received: by 2002:adf:82ca:: with SMTP id 68mr17334331wrc.332.1605515709540;
        Mon, 16 Nov 2020 00:35:09 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb? ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id b17sm21712152wru.12.2020.11.16.00.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 00:35:08 -0800 (PST)
Subject: Re: [PATCH] thermal: amlogic: Add hwmon support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        glaroque@baylibre.com, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
References: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <13c3b1c5-9c06-d663-47ae-5ccd8f87fe57@baylibre.com>
Date:   Mon, 16 Nov 2020 09:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/11/2020 20:06, Martin Blumenstingl wrote:
> Many monitoring tools read the CPU temperature using the hwmon
> interface. Expose the thermal sensors on Amlogic boards as hwmon
> devices.
> 
> Without this lm_sensors' "sensors" tool does not find any temperature
> sensors. Now it prints:
>   cpu_thermal-virtual-0
>   Adapter: Virtual device
>   temp1:        +44.7 C  (crit = +110.0 C)
> 
>   ddr_thermal-virtual-0
>   Adapter: Virtual device
>   temp1:        +45.9 C  (crit = +110.0 C)
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/thermal/amlogic_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index ccb1fe18e993..dffe3ba8c7c4 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -29,6 +29,7 @@
>  #include <linux/thermal.h>
>  
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
>  
>  #define TSENSOR_CFG_REG1			0x4
>  	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
> @@ -287,6 +288,9 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}l
>  
> +	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
> +		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
> +
>  	ret = amlogic_thermal_initialize(pdata);
>  	if (ret)
>  		return ret;
> 

Thanks !!

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
