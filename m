Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB54EE897
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbiDAGow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 02:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiDAGo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 02:44:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6ACDEA2
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 23:42:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k21so3121315lfe.4
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AT43KlTmSMUYUPB4960PYkQfxgIcSiLD8GFROuSjwE0=;
        b=nVsZdk/Y11tzUBrC6arb/AK6bg1nrd8OsKuWnJmx/1xFlMGzuo8VzdAibfJZel5rAM
         epmSUpr+OuxOSBtZEDILtxakEpVzkBc5VibfULtt+OXpBBONQcOUBa+AYrB6VqxwROGV
         RQDLnvfy46Nk4dT5OB4tIMfI9TqIjr2jFsmlSiHs+dtvDOR81Sba3IMCeZzZ8XWc6GeG
         9LJRwL7kIHi2G0GrAhAeduu3bsxpbw0l2AxHh3/6VS5qoIgifZUt6qzXeMxmYQBUPPy8
         BhcY/xk/d4htIMg55iKOmV+6tDU8GGznfe5xUJhjK4z5aqf2bX0J4ED50Ueg75L7J38k
         96Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AT43KlTmSMUYUPB4960PYkQfxgIcSiLD8GFROuSjwE0=;
        b=RSNJcdnOkTQJ3ExryC0lyzzuHUZBE3tJr6Bg7e/QpwvMGwZCqApV25jP1Ol+3Qu23A
         IgbxXeLZ78M0zy1tztcVaHoVNq/tDAzO6B/DuI1P94Sgr6mzvR9L+fT8AlCjctFwnJpG
         kMc0ZgIN1/vkPdYNNoOi2FFvNKXinVS7dLSDwGtIrCp/1+/pVlC3vD6U+ATlK86dzBY7
         GOZgcZCQr30VkQy2vT+S2JZDuEA8lx9E/1RQGmBBCWbvb/B+O7uVW1Fr9/KvMcfHTAcW
         dSEH5wqSZ0I/CrrTPofBZVFHV06Wd6ks7k2+91ELnYzDRjv64C9XhoY8ogJClfMrTneU
         QqUw==
X-Gm-Message-State: AOAM533MZISrSDPADFCHLJ4TCqevQqA9PEZlRlLrOv1kW6PGuE2BFn3I
        fvEiwrKm0IX1yPTOHnoccIySRw==
X-Google-Smtp-Source: ABdhPJxGrIScS+Hf3znm5KgNNtFTLmY1IPLCS3INnxFEDnWk9A3SUw+tTqCo9RvXoGIYU9EWdofjHQ==
X-Received: by 2002:a05:6512:22cc:b0:44a:1097:b5 with SMTP id g12-20020a05651222cc00b0044a109700b5mr12932161lfu.659.1648795351568;
        Thu, 31 Mar 2022 23:42:31 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id e14-20020a19500e000000b0044a16931c7csm147562lfb.97.2022.03.31.23.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 23:42:31 -0700 (PDT)
Message-ID: <1869255f-919d-c1cd-2018-476071620ddf@linaro.org>
Date:   Fri, 1 Apr 2022 09:42:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
 <20220328112836.2464486-2-vladimir.zapolskiy@linaro.org>
 <YkXzFLqPHybqAXJ0@ripper>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <YkXzFLqPHybqAXJ0@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On 3/31/22 21:29, Bjorn Andersson wrote:
> On Mon 28 Mar 04:28 PDT 2022, Vladimir Zapolskiy wrote:
> 
>> It's noted that dcvs interrupts are not self-clearing, thus an interrupt
>> handler runs constantly, which leads to a severe regression in runtime.
>> To fix the problem an explicit write to clear interrupt register is
>> required.
>>
>> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f9d593ff4718..53954e5086e0 100644
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
>> @@ -31,6 +33,7 @@ struct qcom_cpufreq_soc_data {
>>   	u32 reg_dcvs_ctrl;
>>   	u32 reg_freq_lut;
>>   	u32 reg_volt_lut;
>> +	u32 reg_intr_clr;
>>   	u32 reg_current_vote;
>>   	u32 reg_perf_state;
>>   	u8 lut_row_size;
>> @@ -350,6 +353,9 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>>   	disable_irq_nosync(c_data->throttle_irq);
>>   	schedule_delayed_work(&c_data->throttle_work, 0);
>>   
> 
> This should only be done if reg_intr_clr != 0 (as it is for OSM).

thank you for review, but I believe here the status shall be read out from
another register INTR_STATUS rather than INTR_CLR, the bitfield is the same.

> Other than that, I think looks good.
> 
> Regards,
> Bjorn
> 
>> +	writel_relaxed(GT_IRQ_STATUS,
>> +		       c_data->base + c_data->soc_data->reg_intr_clr);
>> +
>>   	return IRQ_HANDLED;
>>   }
>>   
>> @@ -368,6 +374,7 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
>>   	.reg_dcvs_ctrl = 0xb0,
>>   	.reg_freq_lut = 0x100,
>>   	.reg_volt_lut = 0x200,
>> +	.reg_intr_clr = 0x308,
>>   	.reg_perf_state = 0x320,
>>   	.lut_row_size = 4,
>>   };
>> -- 
>> 2.33.0
>>

--
Best wishes,
Vladimir
