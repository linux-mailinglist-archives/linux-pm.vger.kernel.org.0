Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397C7143B65
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAUKtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:49:32 -0500
Received: from foss.arm.com ([217.140.110.172]:41480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAUKtc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jan 2020 05:49:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553431FB;
        Tue, 21 Jan 2020 02:49:31 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61FC23F6C4;
        Tue, 21 Jan 2020 02:49:21 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
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
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
 <20200120152804.GB164543@google.com>
 <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
 <20200121100854.GB157387@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5621c137-7057-1d5c-646a-95707105df25@arm.com>
Date:   Tue, 21 Jan 2020 10:49:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200121100854.GB157387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/21/20 10:08 AM, Quentin Perret wrote:
> On Monday 20 Jan 2020 at 16:20:49 (+0000), Lukasz Luba wrote:
>> On 1/20/20 3:28 PM, Quentin Perret wrote:
>>> Agreed, this looks a bit confusing. It should be trivial to make
>>> em_dev_get() (or whatever we end up calling it) work for CPUs too,
>>> though. And we could always have a em_cpu_get(int cpu) API that is a
>>> basically a wrapper around em_dev_get() for convenience.
>>
>> The problem not only here is that we have a CPU index 'int cpu'
>> and if we ask for device like:
>>
>> struct device *dev = get_cpu_device(cpu);
>>
>> It might be not the same device that was used during the
>> registration, when we had i.e. 4 CPUs for the same policy:
>>
>> int cpu_id = cpumask_first(policy->cpus);
>> struct device *cpu_dev = get_cpu_device(cpu_id);
>> em_register_perf_domain(cpu_dev, nr_opp, &em_cb);
>>
>> That's why the em_cpu_get() is different than em_get_pd(), mainly by:
>> if (cpumask_test_cpu(cpu, em_span_cpus(em_pd)))
>>
>> It won't be simple wrapper, let me think how it could be handled
>> differently than it is now.
> 
> Right so I suppose the easiest solution would be to do the opposite of
> my first suggestion. That is, make em_get_pd() call em_cpu_get() if the
> device is a CPU device, or proceed to the PD list iteration for other
> devices. And em_cpu_get() can remain as you originally suggested (that
> is, iterate over the PDs and test the mask).

Exactly, something like:
---------------------------->8-------------------------
288 struct em_perf_domain *em_get_pd(struct device *dev)
289 {
290         struct em_device *em_dev;
291
292         if (IS_ERR_OR_NULL(dev))
293                 return NULL;
294
295         if (_is_cpu_device(dev))
296                 return em_cpu_get(dev->id);
....
------------------------8<-----------------------------

> 
> That should ensure em_get_pd() always works, em_cpu_get() is still there
> handy for the scheduler and such, and the two EM lookup functions (for
> CPUs or for devices) are kept cleanly separated.
> 
> Thoughts ?

Agree. Then we can have these two functions and em_get_pd() will also
work fine.

> 
> Thanks,
> Quentin
> 

Regards,
Lukasz
