Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1339F89F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFHOOW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:14:22 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39818 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFHOOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:14:21 -0400
Received: by mail-wr1-f52.google.com with SMTP id l2so21780027wrw.6;
        Tue, 08 Jun 2021 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QN+EdKzoWLP2CkjUZ6p50v7bzf6RSbEoChR/qB42S2M=;
        b=Y0ElOsfMlfn3oQVhrjMka5+BB71sz0UqnqGojDryyCKaNV4tvyv5lXEUdW7+Ve0p0j
         gyJ6YSW1nZ05z0+pdsY3GTSyHNaSSdN4/Ab1N+6+5P7P1NcT0Zh2VyIwxSxDybZRrs7x
         +Nr/NCN4a5ekwZ9xtNRJm9PwJHQHSu3/xMZLPbZRU7KTGaocWIqOHRtA5Q2pmRx0Q5e1
         MJE348wtJ/nYwf1z/OFORnPQcks3uvNX18SKP3cW87D5hAMWsK6Xp+3zgaU1a0cw09Xv
         BThBW7Ufue7YQlpHodp/24H0cK6dEi1pnNFOfUt3Rgcbk4nAJtqGCrmq3RweXnsDM/r9
         n/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QN+EdKzoWLP2CkjUZ6p50v7bzf6RSbEoChR/qB42S2M=;
        b=ptSSSYfkRbR+Mx9UP2rRb+mQAVZHi8uO/7R36ItHmLmcTvAMIoFeF+ux4ZP4BlixtV
         IN1f4j2n2CAPqx0rpm6HS7JyY349SRL9/zIHfMzcESmSGCzKRbS3mPiRLipYN/BEe4zX
         CH8jUnRDcVNUNKsgC8MrkFl+96HwL/+59rY1zAYA2QQz/wkk4CmkMwIF2cdof/6KewfA
         MTFUmpX1jL9+aG7L9+IkOW7aXIR/mOSdHtB6XrDf1QiQhzo5EslAIa8G89Gggg559dEx
         cXKbOA0cvS82ndh9/0OwtOJZQ8zpzwvF011j8NRDOLMngbd+zeOP8GixMEN6AZQasbhS
         ePsA==
X-Gm-Message-State: AOAM532TpsDTXYsofJyZrz0yjTAg8bS4AyfZdib4vxZzhDrCew6bEcJj
        g7LxXurA8JHNlkfG3RMCv+cw0a5lWWBmIw==
X-Google-Smtp-Source: ABdhPJwqR8NMrIwZzkzg1wJTkhrSFvimCcaJhT2bLhkbvZckf6DyzC3fxY9/pwgERvcsc68jdjXVkQ==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr23222967wry.395.1623161472462;
        Tue, 08 Jun 2021 07:11:12 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id n9sm18534552wmc.20.2021.06.08.07.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 07:11:12 -0700 (PDT)
Subject: Re: [PATCH v3] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210420172308.134685-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e164df94-ef34-8560-ab8f-f0519d632b22@gmail.com>
Date:   Tue, 8 Jun 2021 16:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210420172308.134685-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20/04/2021 19:23, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> add HWMON-support to mediateks thermal driver to allow lm-sensors
> userspace tools read soc temperature
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3: drop no_hwmon - now really, sorry
> v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
> ---
>  drivers/thermal/mtk_thermal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 149c6d7fd5a0..85964988684b 100644
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
> @@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_peri_therm;
>  	}
>  
> +	ret = devm_thermal_add_hwmon_sysfs(tzdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");

I think dev_warn() is more appropriate here.

Regards,
Matthias

> +
>  	return 0;
>  
>  err_disable_clk_peri_therm:
> 
