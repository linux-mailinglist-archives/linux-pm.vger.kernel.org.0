Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE781EBA67
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBLbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 07:31:39 -0400
Received: from foss.arm.com ([217.140.110.172]:49630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFBLbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jun 2020 07:31:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B08A931B;
        Tue,  2 Jun 2020 04:31:37 -0700 (PDT)
Received: from [10.37.12.87] (unknown [10.37.12.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B5E3F52E;
        Tue,  2 Jun 2020 04:31:27 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
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
References: <20200527095854.21714-1-lukasz.luba@arm.com>
 <20200527095854.21714-5-lukasz.luba@arm.com>
 <d45e5592-8e11-858b-d3a3-2ec9ce1d1f54@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7201e161-6952-6e28-4036-bd0f0353ec30@arm.com>
Date:   Tue, 2 Jun 2020 12:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d45e5592-8e11-858b-d3a3-2ec9ce1d1f54@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 6/1/20 10:44 PM, Daniel Lezcano wrote:
> On 27/05/2020 11:58, Lukasz Luba wrote:
>> Add support for other devices than CPUs. The registration function
>> does not require a valid cpumask pointer and is ready to handle new
>> devices. Some of the internal structures has been reorganized in order to
>> keep consistent view (like removing per_cpu pd pointers).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
> 
> [ ... ]
> 
>>   }
>>   EXPORT_SYMBOL_GPL(em_register_perf_domain);
>> +
>> +/**
>> + * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a device
>> + * @dev		: Device for which the EM is registered
>> + *
>> + * Try to unregister the EM for the specified device (but not a CPU).
>> + */
>> +void em_dev_unregister_perf_domain(struct device *dev)
>> +{
>> +	if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
>> +		return;
>> +
>> +	if (_is_cpu_device(dev))
>> +		return;
>> +
>> +	mutex_lock(&em_pd_mutex);
> 
> Is the mutex really needed?

I just wanted to align this unregister code with register. Since there
is debugfs dir lookup and the device's EM existence checks I thought it
wouldn't harm just to lock for a while and make sure the registration
path is not used. These two paths shouldn't affect each other, but with
modules loading/unloading I wanted to play safe.
I can change it maybe to just dmb() and the end of the function if it's
a big performance problem in this unloading path. What do you think?

> 
> If this function is called that means there is no more user of the
> em_pd, no?

True, that EM users should already be unregistered i.e. thermal cooling.

> 
>> +	em_debug_remove_pd(dev);
>> +
>> +	kfree(dev->em_pd->table);
>> +	kfree(dev->em_pd);
>> +	dev->em_pd = NULL;
>> +	mutex_unlock(&em_pd_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
>>
> 
> 

Thank you for reviewing this.

Regards,
Lukasz
