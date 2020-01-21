Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B46143926
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAUJKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 04:10:25 -0500
Received: from foss.arm.com ([217.140.110.172]:39822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgAUJKZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jan 2020 04:10:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707D31FB;
        Tue, 21 Jan 2020 01:10:24 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5023F6C4;
        Tue, 21 Jan 2020 01:10:17 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, kernel-team@android.com
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
 <20200120150918.GA164543@google.com>
 <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
 <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c9910c74-ab47-0c78-a1c7-4f3978e1dd09@arm.com>
Date:   Tue, 21 Jan 2020 10:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/01/2020 19:38, Lukasz Luba wrote:
> 
> 
> On 1/20/20 6:27 PM, Dietmar Eggemann wrote:
>> On 20/01/2020 16:09, Quentin Perret wrote:
>>> Hey Lukasz,
>>>
>>> On Monday 20 Jan 2020 at 14:52:07 (+0000), Lukasz Luba wrote:
>>>> On 1/17/20 10:54 AM, Quentin Perret wrote:

[...]

>> It's true that we need the policy->cpus cpumask only for cpu devices and
>> we have it available when we call em_register_perf_domain()
>> [scmi-cpufreq.c driver] or the OPP wrapper dev_pm_opp_of_register_em()
>> [e.g. cpufreq-dt.c driver].
>>
>> And we shouldn't make EM code dependent on OPP.
>>
>> But can't we add 'struct cpumask *mask' as an additional argument to
>> both which can be set to NULL for (devfreq) devices?
>>
>> We can check in em_register_perf_domain() that we got a valid cpumask
>> for a cpu device and ignore it for (devfreq) devices.
>>
> 
> I think we could avoid this additional argument 'cpumask'. I have
> checked the cpufreq_cpu_get function, which should do be good for this:
> 
> ---------->8-------------------------
> static int _get_sharing_cpus(struct device *cpu_dev, struct cpumask *span)
> {
>         struct cpufreq_policy *policy;
> 
>         policy = cpufreq_cpu_get(cpu_dev->id);
>         if (policy) {
>                 cpumask_copy(span, policy->cpus);
>                 cpufreq_cpu_put(policy);
>                 return 0;
>         } else {
>                 return -EINVAL;
>         }
> }
> --------------------------8<-------------------------------
> 
> It would be a replacement for:
> ret = dev_pm_opp_get_sharing_cpus(dev, span);

True. But then we hard-code that a CPU device performance domain can
only be a frequency domain (which is true today).

The task scheduler (build_perf_domains()) and thermal are already using
cpufreq_cpu_get() to access the cpufreq policy. Now the EM framework
would too for CPU devices. I assume that could work with a couple of
adaptations in Documentation/power/energy-model.rst.

BTW, there is a similar interface cpufreq_get_policy() in cpufreq.c
which is used less often?
