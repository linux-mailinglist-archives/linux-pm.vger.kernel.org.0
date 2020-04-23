Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EC1B6170
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgDWQ6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 12:58:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgDWQ6X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 12:58:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85EE330E;
        Thu, 23 Apr 2020 09:58:22 -0700 (PDT)
Received: from [10.37.12.89] (unknown [10.37.12.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9B73F68F;
        Thu, 23 Apr 2020 09:57:48 -0700 (PDT)
Subject: Re: [PATCH v6 04/10] PM / EM: add support for other devices than CPUs
 in Energy Model
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
 <20200410084210.24932-5-lukasz.luba@arm.com>
 <20200423151250.GB65632@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ff1c8cc5-f64d-6156-7d30-97b8426c6f99@arm.com>
Date:   Thu, 23 Apr 2020 17:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423151250.GB65632@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/23/20 4:12 PM, Daniel Lezcano wrote:
> On Fri, Apr 10, 2020 at 09:42:04AM +0100, Lukasz Luba wrote:
>> Add support for other devices that CPUs. The registration function
>> does not require a valid cpumask pointer and is ready to handle new
>> devices. Some of the internal structures has been reorganized in order to
>> keep consistent view (like removing per_cpu pd pointers). To track usage
>> of the Energy Model structures, they are protected with kref.
> 
> Why not add the energy model structure in the struct device directly?

Do you mean this structure?
https://elixir.bootlin.com/linux/latest/source/include/linux/device.h#L537

and to put something like:
struct device {
...
	struct dev_pm_domain	*pm_domain;
#ifdef CONFIG_ENERGY_MODEL
	struct em_perf_domain	*em_pd;
#endif
...
};

> 
> For instance for the em_cpu_get() function, the cpu id allows to retrieve the
> cpu device and then from there, the energy model instead of browsing another
> list. The em_device life cycle will be tied to the struct device.

That would be perfect.

> 
> Then when the struct device and the em_device are connected, add the debugfs
> with a struct device list for those which are energy aware, so you end up with
> a structure:
> 
> struct em_device {
> 	struct device *dev;
> 	struct list_head em_dev_list;
> };
> 
> (a global single dentry for debugfs to do a recursive delete is enough).
> 
> Locks when inspecting and add/removal called from the struct device release
> function. So no need of an extra refcounting.
> 
> Does it make sense?
> 

Indeed it looks much cleaner/simpler.

I will try to address this idea and get rid of refcounting.

This should be doable in this patch (4/10). In the v7 I will keep your
ACKs for other patches that you have already commented.

Thank you for your suggestions and review.

Regards,
Lukasz

