Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B392A7B4D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 11:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgKEKJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 05:09:12 -0500
Received: from foss.arm.com ([217.140.110.172]:56514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgKEKJL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 05:09:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C492142F;
        Thu,  5 Nov 2020 02:09:11 -0800 (PST)
Received: from [10.57.22.37] (unknown [10.57.22.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FF1F3F718;
        Thu,  5 Nov 2020 02:09:06 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <876ca521-1576-63c5-9af5-b000f52cc17b@arm.com>
Date:   Thu, 5 Nov 2020 10:09:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201105091759.GA8237@e123083-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/20 9:18 AM, Morten Rasmussen wrote:
> On Tue, Nov 03, 2020 at 09:05:57AM +0000, Lukasz Luba wrote:
>> @@ -79,7 +82,8 @@ struct em_data_callback {
>>   struct em_perf_domain *em_cpu_get(int cpu);
>>   struct em_perf_domain *em_pd_get(struct device *dev);
>>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>> -				struct em_data_callback *cb, cpumask_t *span);
>> +				struct em_data_callback *cb, cpumask_t *spani,
> 
> "spani" looks like a typo?
> 

Good catch, yes, the vim 'i'.

Thank you Morten. I will resend this patch when you don't
find other issues in the rest of patches.
