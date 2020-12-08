Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28F02D2653
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 09:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgLHIh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 03:37:29 -0500
Received: from foss.arm.com ([217.140.110.172]:44960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgLHIh2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 03:37:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3232A30E;
        Tue,  8 Dec 2020 00:36:43 -0800 (PST)
Received: from [10.57.1.242] (unknown [10.57.1.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A4A3F68F;
        Tue,  8 Dec 2020 00:36:41 -0800 (PST)
Subject: Re: [PATCH 0/2] SCMI performance protocol power scale interface
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Dietmar.Eggemann@arm.com, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, rafael@kernel.org
References: <20201124104346.27167-1-lukasz.luba@arm.com>
 <20201207071308.rm7x6ro7i4qtmm7h@vireshk-i7>
 <20201208044803.6kepfqvoz3pov4c3@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <82373a3d-49e4-7201-3616-10a9f0ac77c4@arm.com>
Date:   Tue, 8 Dec 2020 08:36:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201208044803.6kepfqvoz3pov4c3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/8/20 4:48 AM, Viresh Kumar wrote:
> On 07-12-20, 12:43, Viresh Kumar wrote:
>> On 24-11-20, 10:43, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The Energy Model (EM) supports power values expressed in an abstract scale
>>> via new API. The SCMI performance protocol provides the information about
>>> power scale. This patch set implements the needed interface and updates
>>> cpufreq driver to set the right scale in the EM.
>>>
>>> It is based on top of patch series adding milli-Watts flag in EM [1]
>>> (next-20201124 was used as a base).
>>>
>>> Regards,
>>> Lukasz
>>>
>>> [1] https://lore.kernel.org/linux-pm/20201103090600.29053-1-lukasz.luba@arm.com/
>>>
>>> Lukasz Luba (2):
>>>    firmware: arm_scmi: Add power_scale_mw_get() interface
>>>    cpufreq: arm_scmi: Discover the power scale in performance protocol
>>>
>>>   drivers/cpufreq/scmi-cpufreq.c   | 4 +++-
>>>   drivers/firmware/arm_scmi/perf.c | 8 ++++++++
>>>   include/linux/scmi_protocol.h    | 1 +
>>>   3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> More scmi stuff came in which I had to apply and so I applied this to
> the ARM tree.
> 
> Rafael: I had to rebase this over one of the patches from your tree,
> which was based on rc3:
> 
> commit c250d50fe2ce ("PM: EM: Add a flag indicating units of power values in Energy Model")
> 
> I hope you won't rebase it any further.
> 
> Applied. Thanks.
> 

Thank you Viresh!

Regards,
Lukasz
