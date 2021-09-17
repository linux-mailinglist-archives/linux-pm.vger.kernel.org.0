Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB440F486
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhIQJKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbhIQJJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 05:09:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C95C061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 02:08:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so6998998wri.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/I1Tt1HzjsE75nZdTSIEAGwCXwh62BBwx+UsI2exLfE=;
        b=g7vbAOuYwlGhiAw9321uxYSPDO4QmS+BNVRgg54rzvRGqw2zAa6COxOrt0WHHGiqd0
         uM7aePVxRjSQYOkyW4FSx/bmhcVAO6vFcYS1WtWCF9EYw37AiDrqya4pk0xAU/KaevQd
         c5CcGZQo68v6rxSMr0qrq10qIYGCwbWSxQrc3nL1WaJMA1ENNAgpln9Is4QrBoAJDqO+
         EqtnQ6Nwv29l0rGeSFmwg9e0WocgUqP04KB1yW/l5hhyuucSmsS384qOrgse9AxGGj1R
         KEeMdQiRrkTv9PSZShGqhWuQpBySfM8970yf8/fjidJmqn6gcAjaKv+4zHDxfY3h/B/z
         ThLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/I1Tt1HzjsE75nZdTSIEAGwCXwh62BBwx+UsI2exLfE=;
        b=1JIpaWuBnLlYKHGeGSr9KF3iHUihhFFCqeO+IArKiEcf6y+NAhsgpgNC74lIDg/FTm
         FHI2+SfR1Y/Woxfjjq5m6brFqIvKYLHvEHYNX4ejcYdjw9PeuE1tkfdi2JuIEZ0ha3py
         9TIK/2S0rXUqfKibRGj1ymBmOIWjSpX12zQQ8YecNBEYF7b7Ff2a+1KL5jSpPhav6qbd
         mzbVIicsoxI1bpZCKAzA65EadcjDC8caI90VU3/diRVMkUbRNcrzcD3buvt6MNGfWW26
         aF4u7HtZXa/2vOintNXiRMDQHPNub96lD/Zxfw2kxPwTAzMPQ+NZ0cy4Y/sw7+KlxFZe
         eUVw==
X-Gm-Message-State: AOAM532jgnaPrbjKGvRMlCPZo1UjrCWVQjw1A4/+ZQr+k5LI7lMTxxqL
        Qs8gPiuXDaHNCNOXK0+NsuzB2A==
X-Google-Smtp-Source: ABdhPJwUBCGdpmC3bQGNPhpHns+vpWRXUWfkWp9nmnSGcm2X6UWVp0FLYQO7wVAmPuVCIOurE3k+IA==
X-Received: by 2002:a5d:6dad:: with SMTP id u13mr10421628wrs.55.1631869711923;
        Fri, 17 Sep 2021 02:08:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cf95:6508:8470:7171? ([2a01:e34:ed2f:f020:cf95:6508:8470:7171])
        by smtp.googlemail.com with ESMTPSA id y8sm5986742wrh.44.2021.09.17.02.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 02:08:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drivers: thermal: tsens: fix wrong check for tzd
 in irq handlers
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>
References: <20210907212543.20220-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <95c7a633-144c-917b-376f-636b904f8b73@linaro.org>
Date:   Fri, 17 Sep 2021 11:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907212543.20220-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Applied, thanks

On 07/09/2021 23:25, Ansuel Smith wrote:
> Some device can have some thermal sensor disabled from the factory. The
> current 2 irq handler functions check all the sensor by default and the
> check if the sensor was actually registered is wrong. The tzd is
> actually never set if the registration fail hence the IS_ERR check is
> wrong.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 4c7ebd1d3f9c..b1162e566a70 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -417,7 +417,7 @@ static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>  		const struct tsens_sensor *s = &priv->sensor[i];
>  		u32 hw_id = s->hw_id;
>  
> -		if (IS_ERR(s->tzd))
> +		if (!s->tzd)
>  			continue;
>  		if (!tsens_threshold_violated(priv, hw_id, &d))
>  			continue;
> @@ -467,7 +467,7 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>  		const struct tsens_sensor *s = &priv->sensor[i];
>  		u32 hw_id = s->hw_id;
>  
> -		if (IS_ERR(s->tzd))
> +		if (!s->tzd)
>  			continue;
>  		if (!tsens_threshold_violated(priv, hw_id, &d))
>  			continue;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
