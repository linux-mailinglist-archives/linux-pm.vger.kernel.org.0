Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01F41E0CBE
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbgEYLWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389897AbgEYLWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 07:22:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A58C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 04:22:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so4604695wrp.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iBXFsq/YRJNCwLhfCmeFdcjlel1EZijBKcYLRzOu38Q=;
        b=gh/9+Yv09sgbbtm3vqifgn2cPo3AJETQ4e9OZBODF204Lf4iGD8nsJqV4WvCsTgazk
         tcXETVo/y553zKNDOEa7REnmLWD7PguAm6tPteMqfHl2jFxSEGBexwggMjO0ydFAePUK
         B/Y83qEZoSvtMsAcKkZdzgOLIdsvhZRogL+Kn8FGa9VtVG012fC7yFS6yxnCau6/H3E8
         URhZVGk2iN3e4nxqQ4EHWonIjP1NFtZiXJEBjCVMtAW9UMP8oR5qCb/H82/KHZYquEyX
         0Vgw4bcLCm8FI8XnFP8ECKzzzkt8QzHENhpyOXi1aNPcyIgEo9BemP145SqWODRQziiW
         pg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iBXFsq/YRJNCwLhfCmeFdcjlel1EZijBKcYLRzOu38Q=;
        b=ZGVxZSPDM79a47Vribayt9bKYEnn/uWkLU64VIKVWby/CZE8JNrTLDRHEBpe4VXTyU
         hAVlx8mW2pv006MUN2sd1eNKtb6ohpbJFKEZQQU/B3j9186ugWZP+0RdPjYIOL0cfnAW
         QRZeavQDRD7HmfNB79CGWbJd/VhCs+NoF58UrFa0WPkoaLlOmT9oI+esqZtSqlDFSTzq
         jBe3uY7+Lk4WUgWsKun0aR81cVGgPkYdswrntpXsRzxs0B1ofMf/MFA94wpFG7PWM19z
         ToIPIC23zowXzqwANW4jbb0JyfBfScCrnSRlwmhgpgd13p+v0Vra8pHGcHLhl9dafgVF
         lHfQ==
X-Gm-Message-State: AOAM532Zz7HNJWyMEofdh/MITQa/sGFUinQE6Nx28ErGPO9Df3VUrwAe
        pMt0GMtnqMZJvAFf513/Ww8D9w==
X-Google-Smtp-Source: ABdhPJxFakP7sz4ZuenT+NK54SgLAYXWUyk7vZJB0US30kWhTl7TSWqOox/0c5EB1TWVM2hSe/YQUw==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr14590871wrq.218.1590405766298;
        Mon, 25 May 2020 04:22:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd? ([2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd])
        by smtp.googlemail.com with ESMTPSA id 30sm3905659wrd.47.2020.05.25.04.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 04:22:45 -0700 (PDT)
Subject: Re: [PATCH v3] thermal: qoriq: Update the settings for TMUv2
To:     Yuantian Tang <andy.tang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200525072106.12993-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <24d2d2c9-0f30-743b-dfe0-6acd2d3de367@linaro.org>
Date:   Mon, 25 May 2020 13:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525072106.12993-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2020 09:21, Yuantian Tang wrote:
> For TMU v2, TMSAR registers need to be set properly to get the
> accurate temperature values.
> Also the temperature read needs to be converted to degree Celsius
> since it is in degrees Kelvin.

> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

[ ... ]

> @@ -202,6 +213,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> +		for (i = 0; i < 7; i++)

Please wrap this litteral 7 to an explicit constant name

> +			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
>  	}
>  
>  	/* Disable monitoring */
> @@ -212,6 +225,7 @@ static const struct regmap_range qoriq_yes_ranges[] = {
>  	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>  	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
>  	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
> +	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
>  	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
>  	/* Read only registers below */
>  	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
