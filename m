Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA44115A768
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 12:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBLLMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 06:12:38 -0500
Received: from foss.arm.com ([217.140.110.172]:59362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBLLMh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 06:12:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D66230E;
        Wed, 12 Feb 2020 03:12:37 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E90E3F68F;
        Wed, 12 Feb 2020 03:12:34 -0800 (PST)
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
To:     Lukasz Luba <lukasz.luba@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
 <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
 <289c6110-b7ea-1d61-d795-551723263803@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <eeafe486-e408-b229-24ef-329649a13f70@arm.com>
Date:   Wed, 12 Feb 2020 11:12:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <289c6110-b7ea-1d61-d795-551723263803@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/02/2020 10:55, Lukasz Luba wrote:
>> Because, as the commit message outlines it, such a frequency is terribly
>> out of spec?
> 
> I don't see in the RM that < 1MHz is terribly out of spec.
> 'Frequency
> Increments at a fixed frequency, typically in the range 1-50MHz.
> Can support one or more alternative operating modes in which it increments by larger amounts at a
> lower frequency, typically for power-saving.'
> 
> There is even an example how to operate at 20kHz and increment by 500.
> 
> I don't know the code if it's supported, thought.
> 

For that one case the value reported by CNTFRQ shouldn't change - it's still
a timer that looks like is operating at 10MHz, but under the hood is doing
bigger increments at lower freq.

As I was trying to get to, this patch isn't validating the actual frequency
the timer operates on, rather that whatever is reported by CNTFRQ is
somewhat sane (which here means [1, 50]MHz, although we just check the
lower bound).

[...]

>> And? It seems to address a potential issue where the time frequency
>> is out of spec, and makes sure we don't end up with additional problems
>> in the AMU code.
> 
> This patch just prints warning, does not change anything in booting or
> in any code related to AMU.
> 

Right, but it should still be worth having - at least it shows up in
dmesg, and when someone reports something fishy we get a hint that we can
blame the hardware.

>>
>> On its own, it is perfectly sensible and could be merged as part of this
>> series with my
>>
>> Acked-by: Marc Zyngier <maz@kernel.org>
>>
>>          M.
> 
> Regards,
> Lukasz
