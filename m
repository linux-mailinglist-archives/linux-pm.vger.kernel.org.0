Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F074F14F1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiDDMg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbiDDMgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 08:36:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC04275C0
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 05:34:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q68so664461ljb.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ymmdaZ9ag/KbyUT2AA2pYd23UzF6p1u5S+K3tUsMVzc=;
        b=IzaE0n0FaQpM5p9P9AfnkThA9e4CxrrbmRBeB4s2BiBSCXG1rcC8ge9NQehY6R9cnw
         rBABhfokCBbogkHAFF8zGEQKPrfEjcS2bWrHfMNHE94BUTjJZax09Dh8xhdiBQbhDPBS
         ULby4QmBePv0aHAxCt+4S2Q7PgK8bg6lyI/RgrdX5a3k16FaVDaqA87eDUOxmukKiTMX
         sNnnagVfZOzOhNvuN8CRsExU3u31laJASLKOuFbBtF2UjL+9iEZV+NN070MF+y8J+Edk
         EdielVhWytWZldnHTS/bRT66q7gxSCdA7o2UliRV2/wSG83yIRMcl2+IoyVcfn8QYj0Q
         DsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ymmdaZ9ag/KbyUT2AA2pYd23UzF6p1u5S+K3tUsMVzc=;
        b=DS+See/3ah/eUYUpVI1bLFAg7VSm6YWr9HrNhefoyHRbLe0RgB6NWOxOZpxDFCyc4T
         Zr7dtyITOxZhWL+T/7vOUP4OPzHiKFoh0bJzp66Tg4HNts2s/CKXxiETzkUsfZPvpUCV
         MnDrya5oboQzbkqJm+8QIvKrMUH4kuMnP5mcnUGvW8EooAe+gjf4z5WFaZAvrzIGLn6J
         Ic6Wx8/zmpaPNtLHBBipRT2sHEuAig/xNNqA/ZJVG2qeihQaDUFOVBp2jUpvFLw8tzcR
         Ud6OBglZ6dpI87BdyXnXB4mEysdaqWKaygl2DUU7mRqx+Uha6L65rbIQoc//n/nMViOZ
         NxGQ==
X-Gm-Message-State: AOAM533pksILCYKBl+Ww50x46IQcXDskVgYXpEHg1ky9dENikX9UEOWF
        w8dkw+214e8WEEd1iz9e4IUXAg==
X-Google-Smtp-Source: ABdhPJyy7QFvQqfT20vdzM6US3LYJIxObR57gm9VJM2knlpLs4Yl8qA3YBA/p46TAjBW6DZ9zvW0wA==
X-Received: by 2002:a2e:874b:0:b0:24b:41f:c2fe with SMTP id q11-20020a2e874b000000b0024b041fc2femr9352350ljj.302.1649075667257;
        Mon, 04 Apr 2022 05:34:27 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f26-20020a056512323a00b0044a6d058d37sm1121984lfe.262.2022.04.04.05.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:34:26 -0700 (PDT)
Message-ID: <3c7b7b39-8886-9221-3f2a-a4b26c62c405@linaro.org>
Date:   Mon, 4 Apr 2022 15:34:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220401071424.2869057-1-vladimir.zapolskiy@linaro.org>
 <20220401071424.2869057-2-vladimir.zapolskiy@linaro.org>
 <Ykd7kwxwTxFjiNT0@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Ykd7kwxwTxFjiNT0@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/04/2022 01:24, Bjorn Andersson wrote:
> On Fri 01 Apr 00:14 PDT 2022, Vladimir Zapolskiy wrote:
> 
>> It's noted that dcvs interrupts are not self-clearing, thus an interrupt
>> handler runs constantly, which leads to a severe regression in runtime.
>> To fix the problem an explicit write to clear interrupt register is
>> required.
>>
>> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> ---
>> Changes from v1 to v2:
>> * added a check for pending interrupt status before its handling,
>>    thanks to Bjorn for review
>>
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f9d593ff4718..e17413a6f120 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -24,6 +24,8 @@
>>   #define CLK_HW_DIV			2
>>   #define LUT_TURBO_IND			1
>>   
>> +#define GT_IRQ_STATUS			BIT(2)
>> +
>>   #define HZ_PER_KHZ			1000
>>   
>>   struct qcom_cpufreq_soc_data {
>> @@ -31,6 +33,8 @@ struct qcom_cpufreq_soc_data {
>>   	u32 reg_dcvs_ctrl;
>>   	u32 reg_freq_lut;
>>   	u32 reg_volt_lut;
>> +	u32 reg_intr_clr;
>> +	u32 reg_intr_status;
>>   	u32 reg_current_vote;
>>   	u32 reg_perf_state;
>>   	u8 lut_row_size;
>> @@ -345,11 +349,19 @@ static void qcom_lmh_dcvs_poll(struct work_struct *work)
>>   static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>>   {
>>   	struct qcom_cpufreq_data *c_data = data;
>> +	u32 val;
>> +

Following the discussion below (regarding reg_int_clr), the driver 
should also check that soc_data->reg_intr_status is not 0.

>> +	val = readl_relaxed(c_data->base + c_data->soc_data->reg_intr_status);
> 
> Seems reasonable to read the INTR_STATUS register and bail early if
> there's no interrupt.
> 
>> +	if (!(val & GT_IRQ_STATUS))
>> +		return IRQ_HANDLED;
> 
> But if we in the interrupt handler realize that there's no interrupt
> pending for us, shouldn't we return IRQ_NONE?

Initially I wanted to agree with Vladimir. However after giving a 
thought, returning IRQ_HANDLED here can hide other status bits being set 
(e.g. on the other platforms using EPSS). If we return IRQ_NONE here, 
we'll get the "IRQ: nobody cared" message and will know that some bits 
from status are unhandled.

However, a separate thing. We discussed this with Vladimir. I agree with 
him that this chunk is not directly related to the fix for the issue.
I'd suggest to split this patch into two patches:

- writel_relaxed to clear the interrupt (which can be picked up into the 
-rc branch and into stable kernels)

- a check for the GT_IRQ_STATUS which is not strictly necessary, so it 
can come through the plain -next process.

> 
>>   
>>   	/* Disable interrupt and enable polling */
>>   	disable_irq_nosync(c_data->throttle_irq);
>>   	schedule_delayed_work(&c_data->throttle_work, 0);
>>   
>> +	writel_relaxed(GT_IRQ_STATUS,
>> +		       c_data->base + c_data->soc_data->reg_intr_clr);
> 
> And in OSM (i.e. not epss_soc_data), both reg_intr_status and
> reg_intr_clr will be 0, so we end up reading and writing the wrong
> register.
> 
> You need to do:
> 	if (c_data->soc_data->reg_intr_clr)
> 		writel_relaxed(..., reg_intr_clr);

I'd second this. Despite this chunk being called from the path in which 
reg_int_clr is always set, I'd still prefer to have a check. I do not 
like the idea of writing to an optional register without an explicit 
check (or without a comment that this function should be used only when 
reg_int_clr/reg_intr_status are defined).

> 
> But according to the downstream driver, this is supposed to be done in
> the polling function, right before you do enable_irq().
> 
> Regards,
> Bjorn
> 
>> +
>>   	return IRQ_HANDLED;
>>   }
>>   
>> @@ -368,6 +380,8 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
>>   	.reg_dcvs_ctrl = 0xb0,
>>   	.reg_freq_lut = 0x100,
>>   	.reg_volt_lut = 0x200,
>> +	.reg_intr_clr = 0x308,
>> +	.reg_intr_status = 0x30c,
>>   	.reg_perf_state = 0x320,
>>   	.lut_row_size = 4,
>>   };
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
