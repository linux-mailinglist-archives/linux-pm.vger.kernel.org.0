Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45D2143190
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgATSiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 13:38:55 -0500
Received: from foss.arm.com ([217.140.110.172]:35624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgATSiz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 13:38:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D770E31B;
        Mon, 20 Jan 2020 10:38:53 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B943B3F68E;
        Mon, 20 Jan 2020 10:38:43 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
Date:   Mon, 20 Jan 2020 18:38:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/20/20 6:27 PM, Dietmar Eggemann wrote:
> On 20/01/2020 16:09, Quentin Perret wrote:
>> Hey Lukasz,
>>
>> On Monday 20 Jan 2020 at 14:52:07 (+0000), Lukasz Luba wrote:
>>> On 1/17/20 10:54 AM, Quentin Perret wrote:
>>>> Suggested alternative: have two registration functions like so:
>>>>
>>>> 	int em_register_dev_pd(struct device *dev, unsigned int nr_states,
>>>> 			       struct em_data_callback *cb);
>>>> 	int em_register_cpu_pd(cpumask_t *span, unsigned int nr_states,
>>>> 			       struct em_data_callback *cb);
>>>
>>> Interesting, in the internal review Dietmar asked me to remove these two
>>> functions. I had the same idea, which would simplify a bit the
>>> registration and it does not need to check the dev->bus if it is CPU.
>>>
>>> Unfortunately, we would need also two function in drivers/opp/of.c:
>>> dev_pm_opp_of_register_cpu_em(policy->cpus);
>>> and
>>> dev_pm_opp_of_register_dev_em(dev);
>>>
>>> Thus, I have created only one registration function, which you can see
>>> in this patch set.
>>
>> Right, I can see how having a unified API would be appealing, but the
>> OPP dependency is a nono, so we'll need to work around one way or
>> another.
>>
>> FWIW, I don't think having separate APIs for CPUs and other devices is
>> that bad given that we already have entirely different frameworks to
>> drive their respective frequencies. And the _cpu variants are basically
>> just wrappers around the _dev ones, so not too bad either IMO :).
> 
> It's true that we need the policy->cpus cpumask only for cpu devices and
> we have it available when we call em_register_perf_domain()
> [scmi-cpufreq.c driver] or the OPP wrapper dev_pm_opp_of_register_em()
> [e.g. cpufreq-dt.c driver].
> 
> And we shouldn't make EM code dependent on OPP.
> 
> But can't we add 'struct cpumask *mask' as an additional argument to
> both which can be set to NULL for (devfreq) devices?
> 
> We can check in em_register_perf_domain() that we got a valid cpumask
> for a cpu device and ignore it for (devfreq) devices.
> 

I think we could avoid this additional argument 'cpumask'. I have
checked the cpufreq_cpu_get function, which should do be good for this:

---------->8-------------------------
static int _get_sharing_cpus(struct device *cpu_dev, struct cpumask *span)
{
         struct cpufreq_policy *policy;

         policy = cpufreq_cpu_get(cpu_dev->id);
         if (policy) {
                 cpumask_copy(span, policy->cpus);
                 cpufreq_cpu_put(policy);
                 return 0;
         } else {
                 return -EINVAL;
         }
}
--------------------------8<-------------------------------

It would be a replacement for:
ret = dev_pm_opp_get_sharing_cpus(dev, span);

Regards,
Lukasz
