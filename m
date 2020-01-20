Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14552142F77
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgATQVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 11:21:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgATQVC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 11:21:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EDB731B;
        Mon, 20 Jan 2020 08:21:01 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2703F6C4;
        Mon, 20 Jan 2020 08:20:51 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
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
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
 <20200120152804.GB164543@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
Date:   Mon, 20 Jan 2020 16:20:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200120152804.GB164543@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/20/20 3:28 PM, Quentin Perret wrote:
> On Monday 20 Jan 2020 at 15:53:35 (+0100), Dietmar Eggemann wrote:
>> Would be really nice if this wouldn't be required. We should really aim
>> for 1 framework == 1 set of interfaces.
>>
>> What happens if someone calls em_get_pd() on a CPU EM?
>>
>> E.g:
>>
>>   static struct perf_domain *pd_init(int cpu)
>>   {
>> -       struct em_perf_domain *obj = em_cpu_get(cpu);
>> +       struct device *dev = get_cpu_device(cpu);
>> +       struct em_perf_domain *obj = em_pd_get(dev);
>>          struct perf_domain *pd;
>>
>> Two versions of one functionality will confuse API user from the
>> beginning ...
> 
> Agreed, this looks a bit confusing. It should be trivial to make
> em_dev_get() (or whatever we end up calling it) work for CPUs too,
> though. And we could always have a em_cpu_get(int cpu) API that is a
> basically a wrapper around em_dev_get() for convenience.

The problem not only here is that we have a CPU index 'int cpu'
and if we ask for device like:

struct device *dev = get_cpu_device(cpu);

It might be not the same device that was used during the
registration, when we had i.e. 4 CPUs for the same policy:

int cpu_id = cpumask_first(policy->cpus);
struct device *cpu_dev = get_cpu_device(cpu_id);
em_register_perf_domain(cpu_dev, nr_opp, &em_cb);

That's why the em_cpu_get() is different than em_get_pd(), mainly by:
if (cpumask_test_cpu(cpu, em_span_cpus(em_pd)))

It won't be simple wrapper, let me think how it could be handled
differently than it is now.

Regards,
Lukasz

> 
> Thanks,
> Quentin
> 
