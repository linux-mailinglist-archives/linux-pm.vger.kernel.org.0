Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5E365E42
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDTRMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRMY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 13:12:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497CC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 10:11:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso8675261wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myKHdFwpoKzTsa/Xj/reG757o1iV2SMy+GaKdMs9Nd8=;
        b=hQHBRzGD5X9iOOj5IVE4mokydlp7T0xfd7ChDgBDkNYY4MCnQAJeQg/PHmxBWanvja
         00QmxA7BkxVDfgr93keTS/uw4qbx8AG2JSFPhutLrohZUHSql9j2R870yOiHTLTyRUPb
         6uwpLkbb/IxA1xVIE3w8hBj36CbBFwqpya1/YJMmog13WApw6hZU0qMkukzzA2PRiDA8
         DqSBGt5SjrMz9nd4L6lpa3+QwQ0RP2rZhDijHnQE245rFLz/7ogYogpiCO3HIqPPDkC6
         ZZna3bf5YMufluV+tJNBZrusL0P5eoBuALbGEVIDvkQxCu+TyZc5rMP5eAmQJCoDatHY
         fmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myKHdFwpoKzTsa/Xj/reG757o1iV2SMy+GaKdMs9Nd8=;
        b=Y2pM81VY4sXDyh2AFAqyv25VlB0iRoViMuyOYnrfm/QZG8PbjXQ/wzx4nylIis8SlO
         SsaCemxWOh15eLZeIb9HdHiQpdC6CPMXwsGgHhzsbwVxX3qrsyPRo+lkgwTqyeeX0/sx
         Ekd3n7jWWYRoHCZmSS8Cb42P7oYEpdAjP9NiqvDHXG3riT++Z+/tRgloEBLEMeadMwcE
         Vbsb02HM6h2nPrvyRKOfjpz0PudWemPmv+AsqXVGlD/jGBVDVpy2ydCq5yrhjLgU2e13
         Whcw74kvrbX8kuuz3cDLx4H/xJUt1r9WK4l6EhY0Kp9JOF1i7Yn4bpAt3tYvA09qU/dm
         p75w==
X-Gm-Message-State: AOAM5339xa31/mKYcYA5YAFIE0pOPW9VlG3NFY8PjBkhQNlokXrdnEuM
        6X+9j53tmubMiyv0rhqzW/aAgQ==
X-Google-Smtp-Source: ABdhPJx0F/M9jruFk1OxQ7jSDx6lUsEzt5yTN43x0G2gTHn74JFGNoDHbnW3xCYETr//yRba4NP8jg==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr5602279wme.68.1618938710867;
        Tue, 20 Apr 2021 10:11:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id l25sm4014033wmi.17.2021.04.20.10.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 10:11:50 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210420155410.132141-1-linux@fw-web.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <34942537-79f4-bfab-43cc-7af100d0a433@linaro.org>
Date:   Tue, 20 Apr 2021 19:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210420155410.132141-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/04/2021 17:54, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> add HWMON-support to mediateks thermal driver to allow lm-sensors
> userspace tools read soc temperature
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
> ---
>  drivers/thermal/mtk_thermal.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 149c6d7fd5a0..32be8a715c7d 100644
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
> @@ -1087,6 +1089,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_peri_therm;
>  	}
>  
> +	tzdev->tzp->no_hwmon = false;

	^^^^^^ you can drop this line

> +	ret = devm_thermal_add_hwmon_sysfs(tzdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
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
