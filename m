Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70AB45E79D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 06:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbhKZGBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 01:01:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7444 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345845AbhKZF7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 00:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637906195; x=1669442195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GYNL32o6Hn6Ik+B1j/3VlrFdmKQ3ydSTnL023Sn+wi0=;
  b=w1jb7n7HET5jPBPK4nzgkW6tCORn89KJ2MB36P73W9Bh7RJ/4BjcxvEv
   tfNpjqVcT6x+p4iWbxypHjuQFcgE0e0VyxLpe64/rYcQym0WkY3w4iijj
   zzOKh1DUtxP1uT9c79IjmSR9VusTqZ3K72OCl//ZhjYrvxIFOPhWElP+1
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 21:56:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:56:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 21:56:33 -0800
Received: from [10.216.32.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 21:56:28 -0800
Message-ID: <4427fe8d-c96d-d1f7-3ef2-674000b61b93@quicinc.com>
Date:   Fri, 26 Nov 2021 11:26:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <quic_lsrao@quicinc.com>,
        <rnayak@codeaurora.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>
References: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
 <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
 <687d97b6-347a-92c0-34ba-00331dfb6c82@quicinc.com>
 <0fb74083-e378-e1b4-624b-4f2076f237df@linaro.org>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <0fb74083-e378-e1b4-624b-4f2076f237df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 11/25/2021 10:56 PM, Daniel Lezcano wrote:
> On 25/11/2021 15:13, Maulik Shah wrote:
>> Hi Peter,
>>
>> On 11/25/2021 3:21 PM, Peter Zijlstra wrote:
>>> On Thu, Nov 25, 2021 at 02:44:36PM +0530, Maulik Shah wrote:
>>>> Export cpu_idle_poll_ctrl() so that module drivers can use same.
>>> This does not seem like a really safe interface to expose to the
>>> world.
>> Thanks for the review.
>>
>> Keeping the cpuidle enabled from boot up may delay/increase the boot up
>> time.
>> Below is our use case to force cpuidle to stay in cpu_idle_poll().
>>
>> We keep cpuidle disabled from boot up using "nohlt" option of kernel
>> command line which internally sets cpu_idle_force_poll = 1;
>> and once the device bootup reaches till certain point (for example the
>> android homescreen is up) userspace may notify a
>> vendor module driver which can invoke cpu_idle_poll_ctrl(false); to come
>> out of poll mode.
>> So vendor module driver needs cpu_idle_poll_ctrl() exported symbol.
>>
>> We can not take PM-QoS from driver to prevent deep cpuidle since all the
>> vendor modules are kept in a separate partition and will be loaded only
>> after kernel boot up is done
>> and by this time kernel already starts executing deep cpuidle modes.
>>> Surely the better solution is to rework things to not rely on this. I'm
>>> fairly sure it's not hard to write a cpuidle driver that does much the
>>> same.
>> The other option i think is to pass cpuidle.off=1 in kernel command line
>> and then add enable_cpuidle() in drivers/cpuidle/cpuidle.c
>> something similar as below which can be called by vendor module.
>>
>> void enable_cpuidle(void)
>> {
>>          off = 0;
>> }
>> EXPORT_SYMBOL_GPL(enable_cpuidle);
>>
>> This may be a good option since we have already disable_cpuidle() but
>> not enable_cpuidle().
>>
>> void disable_cpuidle(void)
>> {
>>          off = 1;
>> }
>>
>> Hi Rafael/Daniel, can you please let me know your suggestion on
>> this/similar implementation?
> Did you try to use the QoS latency? Sounds like it is exactly for this
> purpose.
>
> Set it to zero to force cpuidle to choose the shallowest idle state and
> then INT_MAX to disable the constraint.
>
>   cpu_latency_qos_add_request();
>
> Hope that helps
>
>    -- Daniel
The PM-QoS is not helping here since all the vendor drivers are kept in 
a separate partition
and will be loaded only after kernel boot up is done and by the time 
vendor kernel modules are inserted
takes QoS, kernel/menu governor already starts executing deep cpuidle modes.

kernel start (t0)---------Menu governor loads (t1)----------vendor 
modules loaded (t2)----------Usespace ready(t3)

Untill (t2), its only core kernel/android kernel which don't have any 
vendor driver which can take QoS.
If we take QoS, it can be taken only from point (t2) but CPUs still 
enter deep idle state between (t1) to (t2).

So to prevent this passing "cpuidle.off=1" or "nohlt" in kernel command 
line can keep deep cpuidle states disabled from boot up and
once vendor modules are ready at (t2) or (t3), it can either invoke 
newly added enable_cpuidle() or cpu_idle_poll_ctrl(false);
to comeout of polling mode and start executing deep low power modes.

Thanks,
Maulik
