Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51824F0C66
	for <lists+linux-pm@lfdr.de>; Sun,  3 Apr 2022 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbiDCTto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Apr 2022 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiDCTtn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2022 15:49:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB173617D
        for <linux-pm@vger.kernel.org>; Sun,  3 Apr 2022 12:47:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn33so10429534ljb.6
        for <linux-pm@vger.kernel.org>; Sun, 03 Apr 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3BLlZN/iz8XPjy6oSw05iCfy8dDSlEO8RF0mBJgJOmo=;
        b=UrKHFPa6a+5vvyVP03+tJngoSaAF9vmhpzlFgb8xhYEsT+EH/Y6XwXpltrlMBRbKEG
         NhFr0RC5qKZoEEUMmKTYVeEl6cUcsNSRwvASXAhpfHmCCuqRctrMBcRwvMslvj/kGz8Y
         OYaR8hT5w0tTpNJpOgyGI7IDnDsjXVTbrSrkCULep3MuGZxNZHc6NO+9wbFSlPFqLjpO
         kOznuh/BpskIJTlLQuZiKQYfCBieBTfkWweMZZGKRc6bHSbgqMv6d57XKFgGqLFbMBZJ
         IcRaRUg2vTLp1wb8UbguXFcuMqaQryNKAV7ZFoe28oCt2wQU1LMiVy9juqdf5o+PD54S
         EEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3BLlZN/iz8XPjy6oSw05iCfy8dDSlEO8RF0mBJgJOmo=;
        b=VHSvh4alBp8bvFqP6oFx2nxikzkx8WECN04o+0M3jvokvKIFc3LAhmAJuesWWzinbV
         hN1OSNjk7+yVIwfDPzLOzpM6zkuplSrnNOOjoo6rCK2w1IWQiD0wWM7Gn78wQVLNhv7x
         hEUqpehTxcVcj4/oQmE9N+H34ttD3xNz6oeTLz0rxmLs2LfVqwEfOGPnS0BAJUvx0gDm
         PZHA7xGIVvRHXgZoPCy7MQZC9BCvAvudLmF237RqHfvUwHAZQbG0ChEBL5Y8W+5ryrAE
         L15S/XtWY9CVt6DUZvsLzvk8TzZEItG/JuU/SNlG+SHVK1ZvUsbR2Tk7SeZ06qc6FcRn
         748w==
X-Gm-Message-State: AOAM530AO0WuQJ619sH3/naeE/Gwl+r9uRBdNyJCuUQG+wIp5hlCvNyL
        sEw77n4dX54ksjB8AIVftUPKzg==
X-Google-Smtp-Source: ABdhPJz5IdaW3ib4Y0utH6Y7dfWTWGrXH0DvP3n+LIOxFESERzrYLzPSG+LZGBiWPuKNMRFhGJokyA==
X-Received: by 2002:a2e:b741:0:b0:249:5eb5:341f with SMTP id k1-20020a2eb741000000b002495eb5341fmr20118233ljo.424.1649015266640;
        Sun, 03 Apr 2022 12:47:46 -0700 (PDT)
Received: from [192.168.0.103] ([217.71.236.77])
        by smtp.gmail.com with ESMTPSA id b24-20020a196458000000b0044ab702b6acsm903597lfj.238.2022.04.03.12.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 12:47:46 -0700 (PDT)
Message-ID: <879a93aa-0b81-cb7c-3e4b-8e7da3ffed13@linaro.org>
Date:   Sun, 3 Apr 2022 22:46:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220401071424.2869057-1-vladimir.zapolskiy@linaro.org>
 <20220401071424.2869057-2-vladimir.zapolskiy@linaro.org>
 <Ykd7kwxwTxFjiNT0@ripper>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <Ykd7kwxwTxFjiNT0@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On 4/2/22 01:24, Bjorn Andersson wrote:
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
> 

To my knowledge returning IRQ_NONE assumes that right the same interrupt should
be still handled, either by another interrupt handler or by the original handler
again.

I believe here there is no difference in the sense above, since the interrupt is
not shared, it might happen that the check is always void and it should get its
justification, and definitely it's safe to omit the check/return here and just
make another poll/irq enable round, so, as the simplest working fix v1 of the
change without this check should be sufficient.

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
> 

My understanding is that non-EPSS platforms do not specify a DCVS interrupt
under cpufreq-hw IP, if so, the interrupt handler is not registered and thus
the check for non-zero reg_intr_clr or other interrupt related registers is
not needed, please correct me.

> But according to the downstream driver, this is supposed to be done in
> the polling function, right before you do enable_irq().

The fact about downstream driver is true, however I believe functionally
there is no significant difference between clearing the interrupt status
after disabling the interrupt as above or right before enabling the interrupt
as in OSM.

The code above is simpler and arranged in the most relevant place, to my
understanding is slightly more correct, which is also proven by the testing.

--
Best wishes,
Vladimir

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
