Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD66D43DBCD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 09:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJ1HTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 03:19:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhJ1HTT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 03:19:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED08E1063;
        Thu, 28 Oct 2021 00:16:52 -0700 (PDT)
Received: from [10.57.25.153] (unknown [10.57.25.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8A63F73D;
        Thu, 28 Oct 2021 00:16:49 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com> <YXmdyeOmNS2x3K0W@ripper>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a75b08d9-cf0f-b132-b07e-878b10d133a2@arm.com>
Date:   Thu, 28 Oct 2021 08:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YXmdyeOmNS2x3K0W@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/27/21 7:43 PM, Bjorn Andersson wrote:
> On Fri 15 Oct 07:45 PDT 2021, Lukasz Luba wrote:
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> [..]
>> +/**
>> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
>> + * @cpus	: The related CPUs for which capacity has been reduced
>> + * @capped_freq	: The maximum allowed frequency that CPUs can run at
> 
> I know this matches what I see in e.g. the Qualcomm cpufreq hw driver,
> but in what cases will @capped_freq differ from
> cpufreq_get_hw_max_freq(cpumask_first(cpus))?

The @capped_freq is the maximum allowed frequency value due to
thermal reasons, which will always be lower or equal to the value
returned by cpufreq_get_hw_max_freq()
(effectively: 'policy->cpuinfo.max_freq').

We limit the frequency (and voltage) of CPU to reduce power (and heat)
in the passive cooling system. That information is important to us,
because scheduler needs to know how fast the CPU can go. It cannot
assume that the speed is always 'policy->cpuinfo.max_freq'. Often
it's less then that at heavy load or GPU heavy load (the same SoC).

Regards,
Lukasz
