Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD1459EF1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhKWJOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 04:14:32 -0500
Received: from foss.arm.com ([217.140.110.172]:49846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234292AbhKWJO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 04:14:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1D69ED1;
        Tue, 23 Nov 2021 01:11:21 -0800 (PST)
Received: from [10.57.23.185] (unknown [10.57.23.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB233F73B;
        Tue, 23 Nov 2021 01:11:17 -0800 (PST)
Subject: Re: [PATCH v4 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, amitk@kernel.org, daniel.lezcano@linaro.org,
        amit.kachhap@gmail.com, thara.gopinath@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211111031535.nvrngqqffdmw2jgz@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b8e768b3-a03b-f359-fc15-bcfb84ab0353@arm.com>
Date:   Tue, 23 Nov 2021 09:11:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211111031535.nvrngqqffdmw2jgz@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 11/11/21 3:15 AM, Viresh Kumar wrote:
> On 09-11-21, 19:57, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set v4 aims to refactor the thermal pressure update
>> code. There are already two clients which do similar thing:
>> convert the capped frequency value into the capacity of
>> affected CPU and call the 'set' function to store the
>> reduced capacity into the per-cpu variable.
>> There might be more than two of these users. In near future
>> it will be scmi-cpufreq driver, which receives notification
>> from FW about reduced frequency due to thermal. Other vendors
>> might follow. Let's avoid code duplication and potential
>> conversion bugs. Move the conversion code into the arch_topology.c
>> where the capacity calculation setup code and thermal pressure sit.
>>
>> Apart from that $subject patches, there is one patch (3/5) which fixes
>> issue in qcom-cpufreq-hw.c when the thermal pressure is not
>> updated for offline CPUs. It's similar fix that has been merged
>> recently for cpufreq_cooling.c:
>> 2ad8ccc17d1e4270cf65a3f2
>>
>> The patch 4/5 fixes also qcom-cpufreq-hw.c driver code which did
>> the translation from frequency to capacity wrongly when there
>> was a boost frequency available and stored in 'policy->cpuinfo.max_freq'.
> 
> LGTM. I will apply this in a few days so people get time to Ack/Review
> the patches.
> 

Thara has reviewed the patches. Could you take the patch set into
your tree, please?
