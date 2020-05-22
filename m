Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360671DE768
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEVM61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 08:58:27 -0400
Received: from foss.arm.com ([217.140.110.172]:35140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgEVM61 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 May 2020 08:58:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F76D6E;
        Fri, 22 May 2020 05:58:26 -0700 (PDT)
Received: from [10.37.12.7] (unknown [10.37.12.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8533F68F;
        Fri, 22 May 2020 05:58:13 -0700 (PDT)
Subject: Re: [PATCH v7 00/15] Add support for devices in the Energy Model
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
References: <20200511111912.3001-1-lukasz.luba@arm.com>
 <abff69b6-b033-18e2-f380-ceccb42c6b01@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3f6652a5-ad9b-15cb-08a8-160becd3f912@arm.com>
Date:   Fri, 22 May 2020 13:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <abff69b6-b033-18e2-f380-ceccb42c6b01@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 5/22/20 11:43 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 11/05/2020 13:18, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set introduces support for devices in the Energy Model (EM)
>> framework. It will unify the power model for thermal subsystem. It will
>> make simpler to add support for new devices willing to use more
>> advanced features (like Intelligent Power Allocation). Now it should
>> require less knowledge and effort for driver developer to add e.g.
>> GPU driver with simple energy model. A more sophisticated energy model
>> in the thermal framework is also possible, driver needs to provide
>> a dedicated callback function. More information can be found in the
>> updated documentation file.
>>
>> First 7 patches are refactoring Energy Model framework to add support
>> of other devices that CPUs. They change:
>> - naming convention from 'capacity' to 'performance' state,
>> - API arguments adding device pointer and not rely only on cpumask,
>> - change naming when 'cpu' was used, now it's a 'device'
>> - internal structure to maintain registered devices
>> - update users to the new API
>> Patch 8 updates OPP framework helper function to be more generic, not
>> CPU specific.
>> Patches 9-14 change devfreq cooling, dropping part of old power model and
>> adding registration with Energy Model via exported GPL function.
>> The last path is a simple change for Panfrost GPU driver.
>>
>> The patch set is based on linux-next tag next-20200508.
> 
> Do you think it is possible to respin against linux-pm next ?

Yes, I will do it and send the v8.

> 
> I wanted to try the series but I'm getting non trivial conflicts with
> the devfreq_cooling changes
> 
> 

Let me take care of this.

Regards,
Lukasz
