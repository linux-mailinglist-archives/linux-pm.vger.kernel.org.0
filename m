Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3B2A7F21
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgKEMzl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:55:41 -0500
Received: from foss.arm.com ([217.140.110.172]:59928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKEMzl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:55:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAED4142F;
        Thu,  5 Nov 2020 04:55:40 -0800 (PST)
Received: from [10.57.22.37] (unknown [10.57.22.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A18D3F719;
        Thu,  5 Nov 2020 04:55:36 -0800 (PST)
Subject: Re: [PATCH v4 1/4] PM / EM: Add a flag indicating units of power
 values in Energy Model
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
References: <20201103090600.29053-1-lukasz.luba@arm.com>
 <20201103090600.29053-2-lukasz.luba@arm.com>
 <20201105091759.GA8237@e123083-lin>
 <876ca521-1576-63c5-9af5-b000f52cc17b@arm.com>
 <20201105105633.GB8237@e123083-lin>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7740a2a1-2e6a-1e04-91ff-364ea21540d6@arm.com>
Date:   Thu, 5 Nov 2020 12:55:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201105105633.GB8237@e123083-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/20 10:56 AM, Morten Rasmussen wrote:
> On Thu, Nov 05, 2020 at 10:09:05AM +0000, Lukasz Luba wrote:
>>
>>
>> On 11/5/20 9:18 AM, Morten Rasmussen wrote:
>>> On Tue, Nov 03, 2020 at 09:05:57AM +0000, Lukasz Luba wrote:
>>>> @@ -79,7 +82,8 @@ struct em_data_callback {
>>>>    struct em_perf_domain *em_cpu_get(int cpu);
>>>>    struct em_perf_domain *em_pd_get(struct device *dev);
>>>>    int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>>> -				struct em_data_callback *cb, cpumask_t *span);
>>>> +				struct em_data_callback *cb, cpumask_t *spani,
>>>
>>> "spani" looks like a typo?
>>>
>>
>> Good catch, yes, the vim 'i'.
>>
>> Thank you Morten. I will resend this patch when you don't
>> find other issues in the rest of patches.
> 
> The rest of the series looks okay to me.

Thank you for checking the whole series. I have re-sent this patch only.

Lukasz

> 
> Morten
> 
