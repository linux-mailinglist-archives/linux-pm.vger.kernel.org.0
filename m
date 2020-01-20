Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AE142E11
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgATOwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 09:52:21 -0500
Received: from foss.arm.com ([217.140.110.172]:33072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATOwV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 09:52:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2545930E;
        Mon, 20 Jan 2020 06:52:20 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71C33F52E;
        Mon, 20 Jan 2020 06:52:09 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
Date:   Mon, 20 Jan 2020 14:52:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117105437.GA211774@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,

On 1/17/20 10:54 AM, Quentin Perret wrote:
> Hey Lukasz,
> 
> Still reading through this, but with small changes, this looks pretty
> good to me.
> 
> On Thursday 16 Jan 2020 at 15:20:29 (+0000), lukasz.luba@arm.com wrote:
>> +int em_register_perf_domain(struct device *dev, unsigned int nr_states,
>> +			struct em_data_callback *cb)
>>   {
>>   	unsigned long cap, prev_cap = 0;
>>   	struct em_perf_domain *pd;
>> -	int cpu, ret = 0;
>> +	struct em_device *em_dev;
>> +	cpumask_t *span = NULL;
>> +	int cpu, ret;
>>   
>> -	if (!span || !nr_states || !cb)
>> +	if (!dev || !nr_states || !cb || !cb->active_power)
> 
> Nit: you check !cb->active_power in em_create_pd() too I think, so only
> one of the two is needed.

good point, thanks

> 
>>   		return -EINVAL;
>>   
>> -	/*
>> -	 * Use a mutex to serialize the registration of performance domains and
>> -	 * let the driver-defined callback functions sleep.
>> -	 */
>>   	mutex_lock(&em_pd_mutex);
>>   
>> -	for_each_cpu(cpu, span) {
>> -		/* Make sure we don't register again an existing domain. */
>> -		if (READ_ONCE(per_cpu(em_data, cpu))) {
>> +	if (_is_cpu_device(dev)) {
>> +		span = kzalloc(cpumask_size(), GFP_KERNEL);
>> +		if (!span) {
>> +			mutex_unlock(&em_pd_mutex);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		ret = dev_pm_opp_get_sharing_cpus(dev, span);
>> +		if (ret)
>> +			goto free_cpumask;
> 
> That I think should be changed. This creates some dependency on PM_OPP
> for the EM framework. And in fact, the reason we came up with PM_EM was
> precisely to not depend on PM_OPP which was deemed too Arm-specific.
> 
> Suggested alternative: have two registration functions like so:
> 
> 	int em_register_dev_pd(struct device *dev, unsigned int nr_states,
> 			       struct em_data_callback *cb);
> 	int em_register_cpu_pd(cpumask_t *span, unsigned int nr_states,
> 			       struct em_data_callback *cb);

Interesting, in the internal review Dietmar asked me to remove these two
functions. I had the same idea, which would simplify a bit the
registration and it does not need to check the dev->bus if it is CPU.

Unfortunately, we would need also two function in drivers/opp/of.c:
dev_pm_opp_of_register_cpu_em(policy->cpus);
and
dev_pm_opp_of_register_dev_em(dev);

Thus, I have created only one registration function, which you can see
in this patch set.

What do you think Dietmar?

> 
> where em_register_cpu_pd() does the CPU-specific work and then calls
> em_register_dev_pd() (instead of having that big if (_is_cpu_device(dev))
> as you currently have). Would that work ?

Yes, I think you made a good point with this OPP dependency, which we
could avoid when we implement these two registration functions.

> 
> Another possibility would be to query CPUFreq instead of PM_OPP to get
> the mask, but I'd need to look again at the driver registration path in
> CPUFreq to see if the policy masks have been populated when we enter
> PM_EM ... I am not sure if this is the case, but it's worth having a
> look too.

The policy mask is populated, our registration function is called at
the end of the init code of CPUfreq drivers. I will check this option.

> 
> Thanks,
> Quentin
> 

Thank you for your comments.

Regards,
Lukasz
