Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5D6C3060
	for <lists+linux-pm@lfdr.de>; Tue, 21 Mar 2023 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCUL1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Mar 2023 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUL1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2023 07:27:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995C4783E
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 04:27:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so58282487edd.5
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679398063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghw9ZOYCO8p5X8MZw35JfRmw8QR/Co7FvKY0kNpiVmg=;
        b=Y0HZjSxpyalb6EJExgDJdAmTI+KnEyQM/8q//l2QvvYM+JP1/ReYVbQh3hNy/Uq9ds
         rl2YLQGpRMLxM8tRXIIdW3gy1rNPFCAF+J8haTxxc+PWpfcGZ8fssvS2z4tIf/VbZgUM
         8GHcby76RecYrnz3f3Lof//qIpqYJbVdP4vaSBUAb4D6+zCb/UdEMesPWj9VEEE00dhb
         gCHPv0q3ZrR/Wd8EIpgfbKD55226zj5ef4Rx8Ahx7ZFoE+WpLJfrBiGJQwLyKTIGAnYK
         JLSfhGFxEK+KFvbXJXxbsrUSAhciovj+tbi3w/KKBwbc60A9VL+UWuknrQKdKkzoWLG6
         Qdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679398063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghw9ZOYCO8p5X8MZw35JfRmw8QR/Co7FvKY0kNpiVmg=;
        b=K4ztQmshAkQaUhTj9lpvM4BlZ3JsuvkkZclOg8xdoEV32Dk+K4APmGfgYbjeDPrBpK
         LkxOOg9Sgr3+JrFD9F8JLCim4ZV+0wz1WDkgNJfNzL2TrJzxXtS7HH7L4Up9cIhI4ZoE
         MBdGy1yyoehPlRzBObvWcUs8ZScjnGlzPg9+UHiX2MjV9Ph8IsTNI5+uZfETbsBJ0kPb
         eqGaI4H2nOk8wkOXOuJ88+sGg0ERcafjRxaBftta8swJJMZH4urNUxBIenuD8wYokof1
         ffgEwKJyQV+7UrG42IfPogCmX9KGCJuNHayiY7q7VEOb8xXWfIM6R1tBJvPuTnuIyJL6
         HZ6w==
X-Gm-Message-State: AO0yUKXoOFuLgUW+sGRq7fyGxgAmZ670JTZM+Y6Pb0uIWoy2EhbnxaoT
        VAE4Vu8vp3iFoZU/CEt4qn4FOw==
X-Google-Smtp-Source: AK7set90T2W503PVRuXveaJoEM/exHdqXIVgfTzqo0hhs8/pVFAPVwJ8LkBECNAen5qiKGG/4QsE/A==
X-Received: by 2002:a17:906:60c9:b0:931:b2ae:116e with SMTP id f9-20020a17090660c900b00931b2ae116emr2083370ejk.64.1679398063687;
        Tue, 21 Mar 2023 04:27:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id kj2-20020a170907764200b009324717b9f3sm5128403ejc.71.2023.03.21.04.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:27:43 -0700 (PDT)
Message-ID: <3e227a63-a45f-8c20-f697-b263121ec173@linaro.org>
Date:   Tue, 21 Mar 2023 12:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
 <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
 <20230321105734.Z7F3Uvf1@linutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321105734.Z7F3Uvf1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/03/2023 11:57, Sebastian Andrzej Siewior wrote:
> On 2023-03-21 11:24:46 [+0100], Krzysztof Kozlowski wrote:
>>>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> @@ -390,7 +390,16 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>>>>  
>>>>  	/* Disable interrupt and enable polling */
>>>>  	disable_irq_nosync(c_data->throttle_irq);
>>>> -	schedule_delayed_work(&c_data->throttle_work, 0);
>>>> +
>>>> +	/*
>>>> +	 * Workqueue prefers local CPUs and since interrupts have set affinity,
>>>> +	 * the work might execute on a CPU dedicated to realtime tasks.
>>>> +	 */
>>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>>>> +		queue_delayed_work_on(WORK_CPU_UNBOUND, system_unbound_wq,
>>>> +				      &c_data->throttle_work, 0);
>>>> +	else
>>>> +		schedule_delayed_work(&c_data->throttle_work, 0);
>>>
>>> You isolated CPUs and use this on PREEMPT_RT. And this special use-case
>>> is your reasoning to make this change and let it depend on PREEMPT_RT?
>>>
>>> If you do PREEMPT_RT and you care about latency I would argue that you
>>> either disable cpufreq and set it to PERFORMANCE so that the highest
>>> available frequency is set once and not changed afterwards.
>>
>> The cpufreq is set to performance. It will be changed anyway because
>> underlying FW notifies through such interrupts about thermal mitigation
>> happening.
> 
> I still fail to understand why this is PREEMPT_RT specific and not a
> problem in general when it comes not NO_HZ_FULL and/ or CPU isolation.

Hm, good point, I actually don't know what is the workqueue
recommendation for NO_HZ_FULL CPUs - is still locality of the workqueue
preferred?

And how such code would look like?
if (tick_nohz_tick_stopped())?

> However the thermal notifications have nothing to do with cpufreq.

They have. The FW notifies that thermal mitigation is happening and
maximum allowed frequency is now XYZ. The cpufreq receives this and sets
maximum allowed scaling frequency for governor.

> 
>> The only other solution is to disable the cpufreq device, e.g. by not
>> compiling it.
> 
> People often disable cpufreq because _usually_ the system boots at
> maximum performance. There are however exceptions and even x86 system
> are configured sometimes to a lower clock speed by the firmware/ BIOS.
> In this case it is nice to have a cpufreq so it is possible to set the
> system during boot to a higher clock speed. And then remain idle unless
> the cpufreq governor changed.

Which we do not want here, thus disabling cpufreq is not the interesting
solution...

Best regards,
Krzysztof

