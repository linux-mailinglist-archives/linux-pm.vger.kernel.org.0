Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2C1B5F28
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgDWP2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:28:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgDWP2r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 11:28:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B5E031B;
        Thu, 23 Apr 2020 08:28:46 -0700 (PDT)
Received: from [10.37.12.89] (unknown [10.37.12.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E87B3F6CF;
        Thu, 23 Apr 2020 08:28:21 -0700 (PDT)
Subject: Re: [PATCH v6 03/10] PM / EM: update callback structure and add
 device pointer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-4-lukasz.luba@arm.com>
 <20200423132243.GA65632@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <245720a0-c812-ccc8-235e-6eed6f216e4b@arm.com>
Date:   Thu, 23 Apr 2020 16:28:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423132243.GA65632@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 4/23/20 2:22 PM, Daniel Lezcano wrote:
> On Fri, Apr 10, 2020 at 09:42:03AM +0100, Lukasz Luba wrote:
>> The Energy Model framework is going to support devices other that CPUs. In
>> order to make this happen change the callback function and add pointer to
>> a device as an argument.
>>
>> Update the related users to use new function and new callback from the
>> Energy Model.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
> 
> [ ... ]
> 
>> +static struct em_perf_domain *
>> +em_create_pd(struct device *dev, int nr_states, struct em_data_callback *cb,
>> +	     cpumask_t *span)
>>   {
>>   	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
>>   	unsigned long power, freq, prev_freq = 0;
>> @@ -106,7 +107,7 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
>>   		 * lowest performance state of 'cpu' above 'freq' and updates
>>   		 * 'power' and 'freq' accordingly.
>>   		 */
>> -		ret = cb->active_power(&power, &freq, cpu);
>> +		ret = cb->active_power(&power, &freq, dev);
>>   		if (ret) {
>>   			pr_err("pd%d: invalid perf. state: %d\n", cpu, ret);
>>   			goto free_ps_table;
> 
> Why are the changes 'cpu' to 'dev' in the patch 4/10 instead of this one ?

The patch 4/10 is quite big and I didn't want to put also this change in
there. I thought for readability it would be better to have a separate
patch with self-contained change (or I got your suggestion too strict).

In this patch I just wanted to show more precisely that this function
callback 'active_power' which is used by 2 users (currently):
cpufreq/scmi-cpufreq.c and opp/of.c
is going to change an argument and these files are affected.

The 4/10 changes a lot lines, while first 3 patches can be treated as
a preparation for the upcoming major change (4/10).

Thank you for the review.

Regards,
Lukasz

> 
>> @@ -237,7 +238,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>   	}
>>   
>>   	/* Create the performance domain and add it to the Energy Model. */
>> -	pd = em_create_pd(span, nr_states, cb);
>> +	pd = em_create_pd(dev, nr_states, cb, span);
>>   	if (!pd) {
>>   		ret = -EINVAL;
>>   		goto unlock;
> 
