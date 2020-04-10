Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003B91A45B8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJLfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 07:35:10 -0400
Received: from foss.arm.com ([217.140.110.172]:60514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgDJLfJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 07:35:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4F11FB;
        Fri, 10 Apr 2020 04:35:09 -0700 (PDT)
Received: from [10.37.12.30] (unknown [10.37.12.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3573F73D;
        Fri, 10 Apr 2020 04:34:58 -0700 (PDT)
Subject: Re: [PATCH v6 04/10] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Luis Gerhorst <linux-kernel@luisgerhorst.de>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-5-lukasz.luba@arm.com>
 <87ftdboaqr.fsf@luis-debian.luis-debian-domain>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <56053904-0314-340e-fdaa-4a8f649d7b6f@arm.com>
Date:   Fri, 10 Apr 2020 12:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87ftdboaqr.fsf@luis-debian.luis-debian-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/10/20 12:12 PM, Luis Gerhorst wrote:
> 
> Lukasz Luba writes:
> 
>> +/**
>> + * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for 
>> a device
>> + * @dev        : Device for which the EM is registered
>> + *
>> + * Try to unregister the EM for the specified device (it checks current
>> + * reference counter). The EM for CPUs will not be freed.
>> + */
>> +void em_dev_unregister_perf_domain(struct device *dev)
>> +{
>> +    struct em_device *em_dev, *tmp;
>> +
>> +    if (IS_ERR_OR_NULL(dev))
>> +        return;
>> +
>> +    /* We don't support freeing CPU structures in hotplug */
>> +    if (_is_cpu_device(dev)) {
>> +        dev_dbg_once(dev, "EM: the structures are not going to be 
>> removed\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&em_pd_mutex);
>> +
>> +    if (list_empty(&em_pd_dev_list)) {
>> +        mutex_unlock(&em_pd_mutex);
>> +        return;
>> +    }
>> +
>> +    list_for_each_entry_safe(em_dev, tmp, &em_pd_dev_list, 
>> em_dev_list) {
>> +        if (em_dev->dev == dev) {
>> +            kref_put(&em_dev->kref, _em_release);
>> +            break;
>> +        }
>> +    }
>> +
>> +    mutex_unlock(&em_pd_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
> 
> Ok, so em_dev_unregister_perf_domain() does not support the CPU device
> and a subsequent em_register_perf_domain() will fail with EEXIST.

Correct. At the current mainline Energy Model we don't even have
em_unregister_perf_domain function. I had to introduce it in order
to support other devices which might have drivers loaded/unloaded
as modules.


> 
> Is there a way to unregister/change the CPU's energy model during
> runtime without restarting the whole system?

Not for the CPU for now.

It is possible for other devices. When you have i.e. a module driver for
a device and in your code there is a (*active_power)(), then it is
possible to change EM by unloading/loading the module.

For the CPU we don't have this requirement for production code. I will
add you to CC list when something like this would pop-up for a
prototyping/experimentation code. We have been analyzing some options.

Regards,
Lukasz

