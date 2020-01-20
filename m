Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7A142ED5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATPhA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 10:37:00 -0500
Received: from foss.arm.com ([217.140.110.172]:33812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATPg7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 10:36:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC2830E;
        Mon, 20 Jan 2020 07:36:58 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024BF3F52E;
        Mon, 20 Jan 2020 07:36:48 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
 <d0b90b97-3604-d4f4-b873-3879a9221532@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <38307e88-f7ff-bc2a-bbce-5e508e275526@arm.com>
Date:   Mon, 20 Jan 2020 15:36:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d0b90b97-3604-d4f4-b873-3879a9221532@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/20/20 3:11 PM, Dietmar Eggemann wrote:
> On 20/01/2020 15:53, Dietmar Eggemann wrote:
>> On 16/01/2020 16:20, lukasz.luba@arm.com wrote:
>>> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> [...]
> 
>>> +enum em_type {
>>> +	EM_SIMPLE,
>>> +	EM_CPU,
>>> +};
>>
>> s/EM_SIMPLE/EM_DEV ?
>>
>> Right now I only see energy models and _one_ specific type (the CPU EM).
>> So a tag 'is a CPU EM' would suffice. No need for EM_SIMPE ...
> 
> Wait, you even have
> 
> struct em_device {
>          struct em_perf_domain *em_pd;
>          struct device *dev;
>          ...
> }
> 
> static bool _is_cpu_device(struct device *dev)
> 
> Shouldn't this be enough to distinguish between EM and special CPU EM
> under the API? Even when required to use container_of() to get from
> em_perf_domain to device.
> 

Agree, I will remove this em_type related code.

Lukasz
