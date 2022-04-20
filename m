Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1C50909F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Apr 2022 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381836AbiDTTpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Apr 2022 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381829AbiDTTpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2022 15:45:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12917E17
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 12:42:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so4887811lfb.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=KGEWr83fJYFid7HWR+gaLqhOcbvATV54UphhKwf+0mE=;
        b=e2gOEvq1RFDOO6FwvKal/ZpYI85ugMK8iGAshs3JVuf/8EiKqeFH59u0p2do4bblAz
         pe4KkeRiHOc2uHz4+Wy0P3m8iQOhRf7iLWjsTyRmginjSMujFbDRxuD9jLxoLlWHW2N1
         Tm5zfx92xYQojlugU7Qt2ihIFKd5BJ4JHYDMIcYtSq7KyY2Oy9WS7wksnqhvHNM0oUwu
         IG0zaj/qdPelW09MbB+xbKie7MPaTmeS9i9+ofsX+osJitvJib6b0mxMrLPAg8OHhdQw
         jqMkTt3j6Q19kfF209Y2VBS6g6DmNQu4ZdPpK5tx5tYGPuNyiNKWDBU1eIVHMlzWevEp
         BfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KGEWr83fJYFid7HWR+gaLqhOcbvATV54UphhKwf+0mE=;
        b=zjMb9vAS2bkz3XoMhfJ8x+wXCqVrcU1Ok3Yxc7k0RZoQqh3sbzoWup7H5gra/pceir
         bqEcDbjxrWNZPLNNnACCNYPoKrr1yC6sKAl9VJCIiIDzcS9EE77jxFC228R40EEuRU2W
         ZJZHgefEBnfcCqRVAjbiatKJOwhmWDMFw92OizcGnHc8/wVF/AucKbwx1wCv22A+oQ8T
         Pl2jqZpdDHOSYbtlwaeHscD4E1G5JC/mJc/iKzT2fa2U979szV8ybFMYpjmem93P8QqT
         dJhAP/lz/PBsZYKp3WN1B/NkCLO6qEBNv5Ym4nuhV/PmNTY83wYh2Z77iowEQSos8s5i
         D+hg==
X-Gm-Message-State: AOAM533/B9961fiDIfUFPcD8xMagSErsVKM66ksSQzDTLXqpdlEheH20
        826MY5itsw16tFcm/Z0Veulczw==
X-Google-Smtp-Source: ABdhPJykuczOT2qbM+Dv4wRIhlDo5bRAaW6Uu4X2ORIz9VPuXTm20EmJ+Kehy/f7V+xOj+Fk9vdCVQ==
X-Received: by 2002:a05:6512:3192:b0:44a:78f2:500b with SMTP id i18-20020a056512319200b0044a78f2500bmr11507019lfe.434.1650483763507;
        Wed, 20 Apr 2022 12:42:43 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id p25-20020a056512329900b0046bc5c83fb7sm1918563lfe.148.2022.04.20.12.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:42:43 -0700 (PDT)
Message-ID: <c2af9682-f773-8530-9262-edea1dbe595a@linaro.org>
Date:   Wed, 20 Apr 2022 22:42:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Content-Language: en-US
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220407200919.3054189-1-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20220407200919.3054189-1-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn, Viresh,

On 4/7/22 23:09, Vladimir Zapolskiy wrote:
> It's noted that dcvs interrupts are not self-clearing, thus an interrupt
> handler runs constantly, which leads to a severe regression in runtime.
> To fix the problem an explicit write to clear interrupt register is
> required, note that on OSM platforms the register may not be present.
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
> Changes from v2 to v3:
> * split the change from the series and returned to v1 state of the fix
>    by removing a minor optimization
> * added a check for non-zero reg_intr_clr value before writel
> 
> Changes from v1 to v2:
> * added a check for pending interrupt status before its handling
> 
>   drivers/cpufreq/qcom-cpufreq-hw.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 0ec18e1589dc..0253731d6d25 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -24,6 +24,8 @@
>   #define CLK_HW_DIV			2
>   #define LUT_TURBO_IND			1
>   
> +#define GT_IRQ_STATUS			BIT(2)
> +
>   #define HZ_PER_KHZ			1000
>   
>   struct qcom_cpufreq_soc_data {
> @@ -32,6 +34,7 @@ struct qcom_cpufreq_soc_data {
>   	u32 reg_dcvs_ctrl;
>   	u32 reg_freq_lut;
>   	u32 reg_volt_lut;
> +	u32 reg_intr_clr;
>   	u32 reg_current_vote;
>   	u32 reg_perf_state;
>   	u8 lut_row_size;
> @@ -360,6 +363,10 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>   	disable_irq_nosync(c_data->throttle_irq);
>   	schedule_delayed_work(&c_data->throttle_work, 0);
>   
> +	if (c_data->soc_data->reg_intr_clr)
> +		writel_relaxed(GT_IRQ_STATUS,
> +			       c_data->base + c_data->soc_data->reg_intr_clr);
> +
>   	return IRQ_HANDLED;
>   }
>   
> @@ -379,6 +386,7 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
>   	.reg_dcvs_ctrl = 0xb0,
>   	.reg_freq_lut = 0x100,
>   	.reg_volt_lut = 0x200,
> +	.reg_intr_clr = 0x308,
>   	.reg_perf_state = 0x320,
>   	.lut_row_size = 4,
>   };

I believe this fix of a critical bug is intended to be included into the next
release, could you please share your review? Thank you in advance.

--
Best wishes,
Vladimir
