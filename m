Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCC167AD5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 11:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgBUKdA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 05:33:00 -0500
Received: from foss.arm.com ([217.140.110.172]:36156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgBUKc7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 05:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4350131B;
        Fri, 21 Feb 2020 02:32:59 -0800 (PST)
Received: from [10.37.12.243] (unknown [10.37.12.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21EB53F68F;
        Fri, 21 Feb 2020 02:32:55 -0800 (PST)
Subject: Re: [RESEND PATCH v2 0/2] Enable Odroid-XU3/4 to use Energy Model and
 Energy Aware Scheduler
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dietmar.eggemann@arm.com
References: <20200220095636.29469-1-lukasz.luba@arm.com>
 <20200220180040.GA8338@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <597f1475-754c-d77a-b599-0fa07d8ee948@arm.com>
Date:   Fri, 21 Feb 2020 10:32:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220180040.GA8338@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 2/20/20 6:00 PM, Krzysztof Kozlowski wrote:
> On Thu, Feb 20, 2020 at 09:56:34AM +0000, Lukasz Luba wrote:
>> Hi all,
>>
>> This is just a resend, now with proper v2 in the patches subject.
>>
>> The Odroid-XU4/3 is a decent and easy accessible ARM big.LITTLE platform,
>> which might be used for research and development.
>>
>> This small patch set provides possibility to run Energy Aware Scheduler (EAS)
>> on Odroid-XU4/3 and experiment with it.
>>
>> The patch 1/2 provides 'dynamic-power-coefficient' in CPU DT nodes, which is
>> then used by the Energy Model (EM).
>> The patch 2/2 enables SCHED_MC (which adds another level in scheduling domains)
>> and enables EM making EAS possible to run (when schedutil is set as a CPUFreq
>> governor).
>>
>> 1. Test results
>>
>> Two types of different tests have been executed. The first is energy test
>> case showing impact on energy consumption of this patch set. It is using a
>> synthetic set of tasks (rt-app based). The second is the performance test
>> case which is using hackbench (less time to complete is better).
>> In both tests schedutil has been used as cpufreq governor. In all tests
>> PROVE_LOCKING has not been compiled into the kernels.
>>
>> 1.1 Energy test case
>>
>> 10 iterations of 24 periodic rt-app tasks (16ms period, 10% duty-cycle)
>> with energy measurement. The cpufreq governor - schedutil. Unit is Joules.
>> The energy is calculated based on hwmon0 and hwmon3 power1_input.
>> The goal is to save energy, lower is better.
>>
>> +-----------+-----------------+------------------------+
>> |           | Without patches | With patches           |
>> +-----------+--------+--------+----------------+-------+
>> | benchmark |  Mean  | RSD*   | Mean           | RSD*  |
>> +-----------+--------+--------+----------------+-------+
>> | 24 rt-app |  21.56 |  1.37% |  19.85 (-9.2%) | 0.92% |
>> |    tasks  |        |        |                |       |
>> +-----------+--------+--------+----------------+-------+
>>
>> 1.2 Performance test case
>>
>> 10 consecutive iterations of hackbench (hackbench -l 500 -s 4096),
>> no delay between two successive executions.
>> The cpufreq governor - schedutil. Units in seconds.
>> The goal is to see not regression, lower completion time is better.
>>
>> +-----------+-----------------+------------------------+
>> |           | Without patches | With patches           |
>> +-----------+--------+--------+----------------+-------+
>> | benchmark | Mean   | RSD*   | Mean           | RSD*  |
>> +-----------+--------+--------+----------------+-------+
>> | hackbench |  8.15  | 2.86%  |  7.95 (-2.5%)  | 0.60% |
>> +-----------+--------+--------+----------------+-------+
>>
>> *RSD: Relative Standard Deviation (std dev / mean)
> 
> Nice measurements!

Glad to hear that.

> 
> Applied both, thank you.
> 
> Best regards,
> Krzysztof
> 

Thank you for applying this.

Regards,
Lukasz
