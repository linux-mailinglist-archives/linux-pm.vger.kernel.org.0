Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82970184D4E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 18:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMRL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 13:11:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRL7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 13:11:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5810B31B;
        Fri, 13 Mar 2020 10:11:58 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1D6B3F534;
        Fri, 13 Mar 2020 10:11:47 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] OPP: change parameter to device pointer in
 dev_pm_opp_of_register_em()
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, javi.merino@arm.com,
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
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org
References: <20200309134117.2331-1-lukasz.luba@arm.com>
 <20200309134117.2331-3-lukasz.luba@arm.com>
 <20200313101524.GA150397@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3ac8ebf8-9db0-d168-8b80-f7f5ba345f86@arm.com>
Date:   Fri, 13 Mar 2020 17:11:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200313101524.GA150397@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/13/20 10:15 AM, Quentin Perret wrote:
> On Monday 09 Mar 2020 at 13:41:15 (+0000), Lukasz Luba wrote:
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index d2b5f062a07b..676b56424886 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -275,7 +275,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>>   	policy->cpuinfo.transition_latency = transition_latency;
>>   	policy->dvfs_possible_from_any_cpu = true;
>>   
>> -	dev_pm_opp_of_register_em(policy->cpus);
>> +	ret = dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>> +	if (ret)
>> +		dev_dbg(cpu_dev, "Couldn't register Energy Model %d\n", ret);
>>   
>>   	return 0;
> 
> Ah, that answers my comment on patch 01. You're adding the error
> messages here.
> 
> Isn't this more boilerplate for the drivers ? All they do is print the
> same debug message. Maybe just move it inside dev_pm_opp_of_register_em
> directly ?
> 

Agree. I could add a 'fail' label in dev_pm_opp_of_register_em
something like:

--------------------------------->8----------------
dev_pm_opp_of_register_em
...
	nr_opp = dev_pm_opp_get_opp_count(dev);
	if (nr_opp <= 0) {
		ret = -EINVAL;
		goto fail;
	}

...
	ret = em_register_perf_domain()
	if (ret)
		goto fail;

	return 0;

fail:
	dev_dbg(cpu_dev, "Couldn't register Energy Model %d\n", ret);
	return ret
------------------------8<-----------------

Makes more sense, agree, thank you for your suggestion.

I will remove this
   if (ret)
	dev_dbg(cpu_dev, "Couldn't register Energy Model %d\n", ret);
from the cpufreq drivers.


Regards,
Lukasz
