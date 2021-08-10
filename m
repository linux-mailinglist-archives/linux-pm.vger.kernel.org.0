Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905A83E5717
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 11:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhHJJft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 05:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234188AbhHJJft (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 05:35:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9611063;
        Tue, 10 Aug 2021 02:35:26 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9EB3F718;
        Tue, 10 Aug 2021 02:35:22 -0700 (PDT)
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <6449a61f-a5fc-0b81-65b2-7bf77b8a71aa@arm.com>
 <20210810092705.ctf43hwhzdepmcrv@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <765a5fd5-1109-1af1-b339-624561070890@arm.com>
Date:   Tue, 10 Aug 2021 10:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210810092705.ctf43hwhzdepmcrv@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 10:27 AM, Viresh Kumar wrote:
> On 10-08-21, 10:17, Lukasz Luba wrote:
>> Hi Viresh,
>>
>> I like the idea, only small comments here in the cover letter.
>>
>> On 8/10/21 8:36 AM, Viresh Kumar wrote:
>>> Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
>>> with the EM core on their behalf. This allows us to get rid of duplicated code
>>> in the drivers and fix the unregistration part as well, which none of the
>>> drivers have done until now.
>>
>> The EM is never freed for CPUs by design. The unregister function was
>> introduced for devfreq devices.
> 
> I see. So if a cpufreq driver unregisters and registers again, it will
> be required to use the entries created by the registration itself,
> right ? Technically speaking, it is better to unregister and free any
> related resources and parse everything again.
> 
> Lets say, just for fun, I want to test two copies of a cpufreq driver

It's good that it's just for fun ;)

> (providing different set of freq-tables). I build both of them as
> modules, insert the first version, remove it, insert the second one.
> Ideally, this should just work as expected. But I don't think it will
> in this case as you never parse the EM stuff again.

The EM is directly used by scheduler in the hot-path, there are no
checks even if the EM if for CPUs. We are sure it's is for CPUs and
is always there for all CPUs.

I'm currently working on a EM v2 which would have stronger mechanisms
and do better job in this field. The patches are under internal review
and hopefully ready to post by the end of month.

> 
> Again, since the routine is there already, I think it is better/fine
> to just use it.

True, it doesn't harm, so I commented it in the patch 1/8 that it
could stay.

> 
>>> This would also make the registration with EM core to happen only after policy
>>> is fully initialized, and the EM core can do other stuff from in there, like
>>> marking frequencies as inefficient (WIP). Though this patchset is useful without
>>> that work being done and should be merged nevertheless.
>>>
>>> This doesn't update scmi cpufreq driver for now as it is a special case and need
>>> to be handled differently. Though we can make it work with this if required.
>>
>> The scmi cpufreq driver uses direct EM API, which provides flexibility
>> and should stay as is.
> 
> Right, so I left it as is for now.
> 
