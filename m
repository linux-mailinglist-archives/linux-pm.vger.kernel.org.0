Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD94637E1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbhK3O4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbhK3Oyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 09:54:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A4C0619E8
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 06:49:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so45053968wrb.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 06:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s2eKkqM93pTCqI0flyd+QKXwBKFF09Co9VXceYb5vOU=;
        b=y8N3zc+RnFywthqp6AcvkyenI/QwIzof9Y3i2FqwvFj2ACrLRsiOoprA/wDNkJuXoY
         xlQyPqHKvLmm6ON4UM3QVVm46Blxnvxp6TyR0z6acITx5daHJUHfq7LE4L4f//bVNNKt
         USx3BTpcDRbPYVEQz+mCGnGWV2V6Y6CTkaMncxGk0ojxn1ivLPTOA1zg6U1qqT+0ppOX
         SI24+T1J0lfM4bnn/mafNhwPPd7zXiLBDVNCcid8HSQ4ExCKFqxCZrYvCmZiRBFg9udA
         sxt1NMlmel8kQ6o2HtcehuQe7GsL02iiA7SJm9wJXlSewEohoM+PKh3FEcimB90ecluT
         rbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2eKkqM93pTCqI0flyd+QKXwBKFF09Co9VXceYb5vOU=;
        b=cw6yVO7CA+GV46OVPAuqsdkPnhd8s0CejFaLpglEUNVqw/aXIQNWhqqquMJz5mkK2d
         JvH4PbiuLRPKrFAP6653kV85AGhsRYHINuFim+o95tUTDuTHYHHrMvSG0GOYwAUi6dX0
         JMAbKohOTrfTqvXxfrVFqGrLQq6RDoi/mq7UDviNvXS6Lpuz3Tm4DgZo8wJireoxNPtH
         hVLnNO8L5RfovbYOefEs4qscOFUdlyIJJhn77ep2pV+hxZfaGUkWP9GUajqQYtbJ0o2K
         Hs18tyzKG8ijfWi4IOhfBoZqIIUMF8if84toZIIMKRFbGr8ATraZmhjtg2Yld0LXjgfB
         +LFw==
X-Gm-Message-State: AOAM530spV1aesW+eN6D8J69wihHdlksOrcXonRuFCHx3yeeUvc4NNHR
        UGZC6pnEE3SWISjRSl1pLCufyg+r9WgpJw==
X-Google-Smtp-Source: ABdhPJwOAMZOTn3bTK7JQ/C8x1h9NaShDU1Nd8P7J7AbuYiZ7ueAF5+SUaf/VlUZ1zjlUe80l+aQXg==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr41622680wrs.272.1638283790684;
        Tue, 30 Nov 2021 06:49:50 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id r8sm21078592wrz.43.2021.11.30.06.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:49:49 -0800 (PST)
Subject: Re: [PATCH 1/1] thermal: imx8mm: enable ADC when enabling monitor
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2786750e-0556-a1b8-e464-30de05ce7cf2@linaro.org>
Date:   Tue, 30 Nov 2021 15:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/11/2021 12:42, Alexander Stein wrote:
> From: Paul Gerber <Paul.Gerber@tq-group.com>
> 
> The i.MX 8MP has a ADC_PD bit in the TMU_TER register that controls the
> operating mode of the ADC:
> * 0 means normal operating mode
> * 1 means power down mode
> 
> When enabling/disabling the TMU, the ADC operating mode must be set
> accordingly.
> 
> i.MX 8M Mini & Nano are lacking this bit.
> 
> Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Often this bit is set already by the bootloader, but in case this is not
> done, the file /sys/class/thermal/thermal_zone0/temp will always return
> -EAGAIN.

Does it deserve a Fixes tag?

>  drivers/thermal/imx8mm_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index 7442e013738f..af666bd9e8d4 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -21,6 +21,7 @@
>  #define TPS			0x4
>  #define TRITSR			0x20	/* TMU immediate temp */
>  
> +#define TER_ADC_PD		BIT(30)
>  #define TER_EN			BIT(31)
>  #define TRITSR_TEMP0_VAL_MASK	0xff
>  #define TRITSR_TEMP1_VAL_MASK	0xff0000
> @@ -113,6 +114,8 @@ static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
>  
>  	val = readl_relaxed(tmu->base + TER);
>  	val = enable ? (val | TER_EN) : (val & ~TER_EN);
> +	if (tmu->socdata->version == TMU_VER2)
> +		val = enable ? (val & ~TER_ADC_PD) : (val | TER_ADC_PD);
>  	writel_relaxed(val, tmu->base + TER);
>  }
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
