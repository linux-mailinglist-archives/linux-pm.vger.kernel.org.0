Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AE44694F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 20:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhKETyP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhKETyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 15:54:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BEEC061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 12:51:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso11937998otg.9
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zab+Ou5F3dW/0ZI0DKEFUpycAWNeYtpXPO2oI479330=;
        b=KcqJhLbaoCexVm3KDkroByaRJ7lHmAQeK3eocFyPKufdbpWkkF77OSWmTJyBmS4EbW
         jHHIb/nS3qCIIQwDjMapXNFrnyC/hUn1srD0MPGA/r8t7N140uA/WfyrFVyPQrscIlrK
         SLs3vNwYKoGgwgY0XbZgmpuEl536B//TmdSAI5h3Gju5uF+CWwC1OuizoRA2WzzHRty3
         he5j3o6H+9b53pBIiQ4YnU95WWl4344y2vlMiLw8mFtWXblOATFL4nRZEjpfhG9VCLAk
         8sI6rr6dNaNn4JyPLsFtYt/iLwpTxF+JcmlmuxGKJoBL+q133GpWmDx9ylayRNipwLRI
         sypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zab+Ou5F3dW/0ZI0DKEFUpycAWNeYtpXPO2oI479330=;
        b=EHGUDUgmLxR4E/cDS3XWI81mc6S0/iodnNUd7SPxXfN6xXfydyukxazH3dzvi4QfnQ
         N7JmO21OozthKF/PeB0ijQJOfSbY2y/E+mMU1HBwiOaqnNuUfXsiPx76nvnzA2808wkK
         WWcDD9fV6W5grG01HE7JbF0ArCENACZhZ8Yy4tVZBbgboOgoVNTm0mNn6WOIk2KmGaq0
         2ONyE1MvMuyod58skgCgEmZ3Rpe4xv1yX5aMuAhN7W+7JJnIdiDGVXhtLU2mQ1wFfZyD
         Suw2OiSHjPuXsZtbpo5ukDCHHFXU+BVN2HBMBE+vve9o5iWXyxCPzXPw7HMX3T3CgjHx
         JXlQ==
X-Gm-Message-State: AOAM531iU0MlqlPeH8FLiLdWwk6FqCb9NFt/SMvCh+R9H7HsjXdcFr9q
        Wb3GVD+rhwjP3x/LrUqF/1Z8Pg==
X-Google-Smtp-Source: ABdhPJwwcJebiYj6bzdtbn3M7TB4ZyB2aAPZl+DRYQNGGHgqlwqzd2M4WHSiZ8HTWqu9YZ27mLAikg==
X-Received: by 2002:a05:6830:91a:: with SMTP id v26mr31093705ott.313.1636141893687;
        Fri, 05 Nov 2021 12:51:33 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id x13sm2664707ooj.37.2021.11.05.12.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 12:51:33 -0700 (PDT)
Message-ID: <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
Date:   Fri, 5 Nov 2021 14:51:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
Content-Language: en-US
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/5/21 2:18 PM, Thara Gopinath wrote:
>
>
> On 11/5/21 1:33 PM, Steev Klimaszewski wrote:
>> Hi,
>>
>> On 11/5/21 11:26 AM, Lukasz Luba wrote:
>>> Hi Steev,
>>>
>>> On 11/5/21 3:39 PM, Steev Klimaszewski wrote:
>>>> Hi Lukasz,
>>>>
>>> [snip]
> Hi Steve,
>
> Does your system have enough load to hit the boost frequencies ? I 
> don't think this patch should affect hitting boost frequencies as 
> there is no error being returned from topology_update_thermal_pressure.
>
> The warning you are getting is because you have boost frequency 
> enabled and IIUC lmh enabled and thermal pressure framework bails out 
> due to boost_frequency being greater than what is available in per_cpu 
> freq_factor. This is because we do not recalculate freq_factor every 
> time boost is enabled / disabled. IIRC there were some discussions 
> around rebuilding scheduler domains and capacity with user space 
> changes to max frequency but it has never proceeded much. Till that 
> point, I think the right way, is to check whether the new capcity 
> exceeds the max_capacity of the cpu and if yes use max_capacity in 
> lieu of new_capacity to calculate thermal pressure.
>
Hi Thara,

I should definitely be able to push it to 2.96GHz, however I'm simply 
not getting it at all with these patches applied.

So, I'm currently compiling multiple applications - alacritty 
(https://github.com/alacritty/alacritty), and zellij 
(https://github.com/zellij-org/zellij), as well as running pixz on a 
5.1GB file to compress it, and throwing in cpuburn-a53 
(https://github.com/ssvb/cpuburn-arm) and I'm simply not getting 2.96GHz 
at all.  Ever.  I don't normally try to push it that high, but I wanted 
to see if we could ever hit it (the system was also never going above 86C)

analyzing CPU 4:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
analyzing CPU 5:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
analyzing CPU 6:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
analyzing CPU 7:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)



After removing this patchset, and rebooting and just compiling zellij:

analyzing CPU 4:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
analyzing CPU 5:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
analyzing CPU 6:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
analyzing CPU 7:
   driver: qcom-cpufreq-hw
   CPUs which run at the same hardware frequency: 4 5 6 7
   CPUs which need to have their frequency coordinated by software: 4 5 6 7
   maximum transition latency: 4294.55 ms.
   hardware limits: 826 MHz - 2.96 GHz
   available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
   available cpufreq governors: ondemand, conservative, powersave, 
userspace, performance, schedutil
   current policy: frequency should be within 826 MHz and 2.84 GHz.
                   The governor "schedutil" may decide which speed to use
                   within this range.
   current CPU frequency is 2.84 GHz.
   cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)


>>
>> Thank you for the fast response!
>>
>> -- steev
>>
>
