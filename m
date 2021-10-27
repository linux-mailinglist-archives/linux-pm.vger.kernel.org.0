Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4A43CAC3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhJ0Nhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 09:37:48 -0400
Received: from foss.arm.com ([217.140.110.172]:43446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236811AbhJ0Nhs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 09:37:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821E71FB;
        Wed, 27 Oct 2021 06:35:22 -0700 (PDT)
Received: from [192.168.185.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E003F73D;
        Wed, 27 Oct 2021 06:35:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com>
 <431230a5-00e9-0211-0731-035eab5fa3f6@arm.com>
 <e38d2b22-0579-90ac-11fe-3c3163bef685@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <018a888d-ed39-09a1-9828-cedef23c7701@arm.com>
Date:   Wed, 27 Oct 2021 15:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e38d2b22-0579-90ac-11fe-3c3163bef685@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2021 10:56, Lukasz Luba wrote:
> Hi Dietmar,
> 
> Thank you for having a look at this.
> 
> On 10/26/21 5:51 PM, Dietmar Eggemann wrote:
>> On 15/10/2021 16:45, Lukasz Luba wrote:

[...]

>>> +void topology_thermal_pressure_update(const struct cpumask *cpus,
>>> +                      unsigned long capped_freq)
>>> +{
>>
>> ... why not just s/unsigned long th_pressure/unsigned long capped_freq
>> in existing topology_set_thermal_pressure() and move code the
>> frequency/capacity conversion in there? The patch set will become
>> considerably smaller.
> 
> I've been trying to avoid confusion when changing actually behavior
> of the API function. Thus, introducing new would IMO opinion
> make sure the old 'set' function was expecting proper pressure
> value, while the new 'update' expects frequency.
> 
> I agree that the patch set would be smaller in that case, but I'm
> not sure if that would not hide some issues. This one would
> definitely break compilation of some vendor modules (or drivers
> queuing or under review), not silently passing them through (with wrong
> argument).

I see, since the parameter type list would stay the same, this could
potentially happen.

[...]
