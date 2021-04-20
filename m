Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB63365888
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhDTMHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhDTMHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 08:07:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E8C06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 05:07:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so8685796wrg.7
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdjavbbnG38i/vDHVgTWk3tsDsi63+Qg6p2AfSLSokM=;
        b=RWbQtV2xG8MQvtq5DQkUl4ClHY7MHwzMjFdlaJqjkzqrAzQwu0/vhsDJPHDqrWrzt5
         yxeN4ErznjF7lzZ7E6ugBbEg0SJpEQIk82KoadIqfB/JmGZKj67z/BO2MzI9GKu7xfSV
         KJkQtAf5s9TAz7ovZgbghlQKOn/zO8MjUjWXh9fG2YiGmYCYRFxclYfFKLXmB3xr4/Em
         XsU7bkCfjSEAX0buiKDTgIv9ChpTTY2YpHcnisji9/5nbaNkKwqzj1UPQzFExpqZBrdM
         Q2IgIZF1W3H4ZkQJsUhlXPG4zF7ly8p0rmCSMjkRm+gyz2ruVW8Ysz1BuNn2Uioz8mWg
         0Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdjavbbnG38i/vDHVgTWk3tsDsi63+Qg6p2AfSLSokM=;
        b=W6+bB1P913bctoIssTAXfTDnxe24uJ8F10SQdl2IAb3yUqiYwx4SMPPEh99UEiXNcb
         O9l5qiRGiPC8dxYh/vDIrt3mmri/Br3nF9OMrDNV3Z+lT648ZInSCTRer3sPxy9FzuhA
         CosxhmvxeTQo9fnQT9Y5YYP1oLUsMWijDpJjr5ipgvDrXXk3y1yiAyQZ1lmoSNQzqgTE
         hXItkrqEqUUhWCBeadoQGVQM98eM1Xoo4rk7psY/fcLzGKtXh4L+rQRtp1gPh8E1LMdX
         yuQmiZZoqyP3OCoc6sqjXHJZ+iPlRf0sVd46TQCGzR3M6b7dxHMFHwyPVgXDo3s1WrrU
         Adqg==
X-Gm-Message-State: AOAM530tZQAz9nFmswkzAeJfZrAxQBOiMzEl+JbdNyS+O1EpYqwzqVBx
        xhWtqFcyBfi1EVQZr03knPFrjg==
X-Google-Smtp-Source: ABdhPJz9J06FgmbJBAc678ICMLMmla+1EpbzsDA86Wii4YsPgv6y7FvJ0jnuRN5ZORqgbcqEgWao9g==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr20088833wrm.32.1618920438781;
        Tue, 20 Apr 2021 05:07:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id b12sm8989862wmj.1.2021.04.20.05.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 05:07:18 -0700 (PDT)
Subject: Re: [PATCH] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210320080646.49615-1-linux@fw-web.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org>
Date:   Tue, 20 Apr 2021 14:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210320080646.49615-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/03/2021 09:06, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> add HWMON-support to mediateks thermanl driver to allow lm-sensors
> userspace tools read soc temperature
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/thermal/mtk_thermal.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 149c6d7fd5a0..e22d77d57458 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -23,6 +23,8 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> +#include "thermal_hwmon.h"
> +
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
>  #define AUXADC_CON1_CLR_V	0x00c
> @@ -983,6 +985,13 @@ static void mtk_thermal_release_periodic_ts(struct mtk_thermal *mt,
>  	writel((tmp & (~0x10e)), mt->thermal_base + TEMP_MSRCTL1);
>  }
>  
> +static void mtk_thermal_hwmon_action(void *data)
> +{
> +	struct thermal_zone_device *zone = data;
> +
> +	thermal_remove_hwmon_sysfs(zone);
> +}
> +
>  static int mtk_thermal_probe(struct platform_device *pdev)
>  {
>  	int ret, i, ctrl_id;
> @@ -1087,6 +1096,19 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_peri_therm;
>  	}
>  
> +#ifdef CONFIG_THERMAL_HWMON

No #ifdef in C file.

> +	tzdev->tzp->no_hwmon = false;
> +	ret = thermal_add_hwmon_sysfs(tzdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +
> +	ret = devm_add_action(&pdev->dev, mtk_thermal_hwmon_action, tzdev);

devm_thermal_add_hwmon_sysfs() ?

> +	if (ret) {
> +		dev_err(&pdev->dev, "error in devm_add_action");
> +		mtk_thermal_hwmon_action(tzdev);
> +	}
> +#endif
> +
>  	return 0;
>  
>  err_disable_clk_peri_therm:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
