Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96742F046
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhJOMPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:15:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhJOMPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Oct 2021 08:15:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52380147A;
        Fri, 15 Oct 2021 05:13:10 -0700 (PDT)
Received: from [10.57.23.184] (unknown [10.57.23.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9879C3F70D;
        Fri, 15 Oct 2021 05:13:07 -0700 (PDT)
Subject: Re: [PATCH 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211007080729.8262-1-lukasz.luba@arm.com>
 <20211007080729.8262-2-lukasz.luba@arm.com>
 <0ee4bc3b-0ad8-598d-417f-b8fe0a8fb8b1@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <086e7186-7c41-5e39-4f6a-e1b44f63b867@arm.com>
Date:   Fri, 15 Oct 2021 13:13:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0ee4bc3b-0ad8-598d-417f-b8fe0a8fb8b1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara,

Thank you having a look at these patches.
My apologies for the delay, I haven't felt well
recently.

On 10/11/21 10:15 PM, Thara Gopinath wrote:
> 
> 
> On 10/7/21 4:07 AM, Lukasz Luba wrote:

[snip]

>> +/**
>> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
>> + * @cpus    : The related CPUs which capacity has been reduced
> 
> The related CPUs "for" which

thanks

> 
>> + * @capped_freq    : The maximum allowed frequency that CPUs can run at

[snip]

>> +
>> +    capacity = capped_freq * max_capacity;
>> +    capacity /= per_cpu(freq_factor, cpu);
> 
> use mult_frac as used in other implementations ?
> 

Good point. Let me check that. In that arch_topology file we never
use such trick, but in this case it makes sense IMO.

Regards,
Lukasz
