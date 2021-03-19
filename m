Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A341DE4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSNMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhCSNMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:12:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229BC06174A
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:12:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z10so2730887qkz.13
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+fWO4Wa4J/MjEIX6MtHgXnTBL0daD6nOFXcsG5rZ5E=;
        b=whYMkM1Kw9ejBOhhiybyihLYyAlHTjngNDpaBr7xS1VELCGaE2Jl7PhFnwpQx7/32j
         Qhci3G5jOocPAw64DgjWIDAbggdXKLRmnVTNgCurG/4Q/L0LxJNLaqgFeManGLdK19xP
         alXNxhut7Jul9JWQDDgmS4TLVXORlBf/oTW/XBGmk4FFZKAgfNrbqZzh78tR9pqKHdvd
         j6GWKlZMvAposB1Xprzk6+moVZd+2UlrqQMbRXZi3UkeR2o52hckETQSef+wCJ2CKO8J
         pJYd6DKzZv51CBXDjb027gAjQItmtNzGE+H18G6qizm747hxYHp9eMWXKNerJBVTblPl
         dNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+fWO4Wa4J/MjEIX6MtHgXnTBL0daD6nOFXcsG5rZ5E=;
        b=R4aB9zaNsBvdNWCvO9QLu1roAiOrB/uA5l8/A4Tb8fff4PRqNbmXBYptiCdpchXVpP
         r9Bw3P5+xioYFissH6DR4sPTb6ddyYeKzW86L8vS2IMkW5JW+GpmgrJ6KflFMop7sX83
         MavrLw4U9Yh6QBqZahQvfHFPltxa43p9svKWNBwF+MTOg6IfhaVc1n9l4+UAMZWZhm0r
         tnH5jt82c1ARnd/D3uteQlmnJRdWOp0gVRzmahixbXhBaYVhPP9HFyzuS/r43JYvnKgN
         JHTieJcdfWjNnXIB+a4tDlb4Wp0qP/GDkI1Iox1yXlMdZcBZJqKA0U3V264QhSFO3COl
         P8MA==
X-Gm-Message-State: AOAM531CLQf8h6txhNZBPrH7RExbfDi1XUYoy+FsA6YPSAovphzuXybI
        02T54kpQWWGaOz4j4L+sTX3bfw==
X-Google-Smtp-Source: ABdhPJyW1YeWJ48Lqbk5Lh7sGZnCPwo0t00/uUtLgo8zAZgPMUWmJ80N6Ci1shInqypKPZfh1pxWQw==
X-Received: by 2002:a37:a2c8:: with SMTP id l191mr9362412qke.413.1616159549179;
        Fri, 19 Mar 2021 06:12:29 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 84sm4639116qkg.8.2021.03.19.06.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:12:28 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v11 7/9] drivers: thermal: tsens: Drop unused define for
 msm8960
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
 <20210319005228.1250-8-ansuelsmth@gmail.com>
Message-ID: <f510946f-23f1-bda7-0701-870b1494bc35@linaro.org>
Date:   Fri, 19 Mar 2021 09:12:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319005228.1250-8-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/18/21 8:52 PM, Ansuel Smith wrote:
> Drop unused define for msm8960 replaced by generic api and reg_field.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Thanks for the clean up!

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara

> ---
>   drivers/thermal/qcom/tsens-8960.c | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 8c523b764862..31e44d17d484 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -10,8 +10,6 @@
>   #include <linux/thermal.h>
>   #include "tsens.h"
>   
> -#define CAL_MDEGC		30000
> -
>   #define CONFIG_ADDR		0x3640
>   #define CONFIG_ADDR_8660	0x3620
>   /* CONFIG_ADDR bitmasks */
> @@ -21,39 +19,19 @@
>   #define CONFIG_SHIFT_8660	28
>   #define CONFIG_MASK_8660	(3 << CONFIG_SHIFT_8660)
>   
> -#define STATUS_CNTL_ADDR_8064	0x3660
>   #define CNTL_ADDR		0x3620
>   /* CNTL_ADDR bitmasks */
>   #define EN			BIT(0)
>   #define SW_RST			BIT(1)
> -#define SENSOR0_EN		BIT(3)
> +
>   #define MEASURE_PERIOD		BIT(18)
>   #define SLP_CLK_ENA		BIT(26)
>   #define SLP_CLK_ENA_8660	BIT(24)
>   #define SENSOR0_SHIFT		3
>   
> -/* INT_STATUS_ADDR bitmasks */
> -#define MIN_STATUS_MASK		BIT(0)
> -#define LOWER_STATUS_CLR	BIT(1)
> -#define UPPER_STATUS_CLR	BIT(2)
> -#define MAX_STATUS_MASK		BIT(3)
> -
>   #define THRESHOLD_ADDR		0x3624
> -/* THRESHOLD_ADDR bitmasks */
> -#define THRESHOLD_MAX_LIMIT_SHIFT	24
> -#define THRESHOLD_MIN_LIMIT_SHIFT	16
> -#define THRESHOLD_UPPER_LIMIT_SHIFT	8
> -#define THRESHOLD_LOWER_LIMIT_SHIFT	0
> -
> -/* Initial temperature threshold values */
> -#define LOWER_LIMIT_TH		0x50
> -#define UPPER_LIMIT_TH		0xdf
> -#define MIN_LIMIT_TH		0x0
> -#define MAX_LIMIT_TH		0xff
>   
>   #define INT_STATUS_ADDR		0x363c
> -#define TRDY_MASK		BIT(7)
> -#define TIMEOUT_US		100
>   
>   #define S0_STATUS_OFF		0x3628
>   #define S1_STATUS_OFF		0x362c
> 

-- 
Warm Regards
Thara
