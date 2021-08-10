Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE03E5B79
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhHJN0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 09:26:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241448AbhHJNZn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 09:25:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 350041FB;
        Tue, 10 Aug 2021 06:25:21 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF013F70D;
        Tue, 10 Aug 2021 06:25:16 -0700 (PDT)
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
To:     Quentin Perret <qperret@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Andy Gross <agross@kernel.org>,
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
 <YRJym+Vn4bbwQzzs@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <af06b333-3d8a-807c-9ccb-d491d6a54930@arm.com>
Date:   Tue, 10 Aug 2021 14:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YRJym+Vn4bbwQzzs@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 1:35 PM, Quentin Perret wrote:
> On Tuesday 10 Aug 2021 at 13:06:47 (+0530), Viresh Kumar wrote:
>> Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
>> with the EM core on their behalf.
> 
> Hmm, that's not quite what this does. This asks the cpufreq core to
> use *PM_OPP* to register an EM, which I think is kinda wrong to do from
> there IMO. The decision to use PM_OPP or another mechanism to register
> an EM belongs to platform specific code (drivers), so it is odd for the
> PM_OPP registration to have its own cpufreq flag but not the other ways.
> 
> As mentioned in another thread, the very reason to have PM_EM is to not
> depend on PM_OPP, so I'm worried about the direction of travel with this
> series TBH.
> 
>> This allows us to get rid of duplicated code
>> in the drivers and fix the unregistration part as well, which none of the
>> drivers have done until now.
> 
> This series adds more code than it removes, and the unregistration is
> not a fix as we don't ever remove the EM tables by design, so not sure
> either of these points are valid arguments.
> 
>> This would also make the registration with EM core to happen only after policy
>> is fully initialized, and the EM core can do other stuff from in there, like
>> marking frequencies as inefficient (WIP). Though this patchset is useful without
>> that work being done and should be merged nevertheless.
>>
>> This doesn't update scmi cpufreq driver for now as it is a special case and need
>> to be handled differently. Though we can make it work with this if required.
> 
> Note that we'll have more 'special cases' if other architectures start
> using PM_EM, which is what we have been trying to allow since the
> beginning, so that's worth keeping in mind.
> 

The way I see this is that the flag in cpufreq avoids
mistakes potentially made by driver developer. It will automaticaly
register the *simple* EM model via dev_pm_opp_of_register_em() on behalf
of drivers (which is already done manually by drivers). The developer
would just set the flag similarly to CPUFREQ_IS_COOLING_DEV and be sure
it will register at the right time. Well tested flag approach should be
safer, easier to understand, maintain.

If there is a need for *advanced* EM model, driver developer would
have to care about all these things (order, setup-ready-structures,
fw channels, freeing, etc) while developing custom registration.
The developer won't set this flag in such case, so the core won't
try to auto register the EM for that driver.

I don't see the dependency of PM_EM on PM_OPP in this series.
