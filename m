Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077030A66E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhBALYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 06:24:25 -0500
Received: from foss.arm.com ([217.140.110.172]:56696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhBALYY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Feb 2021 06:24:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 929031042;
        Mon,  1 Feb 2021 03:23:38 -0800 (PST)
Received: from [10.57.8.191] (unknown [10.57.8.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7568A3F718;
        Mon,  1 Feb 2021 03:23:36 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     daniel.lezcano@linaro.org, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, Dietmar.Eggemann@arm.com,
        amitk@kernel.org, rui.zhang@intel.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
Date:   Mon, 1 Feb 2021 11:23:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel, Chanwoo

Gentle ping. Have you have a chance to check these patches?

On 1/26/21 10:39 AM, Lukasz Luba wrote:
> Hi all,
> 
> This patch set tries to add the missing feature in the Intelligent Power
> Allocation (IPA) governor which is: frequency limit set by user space.
> User can set max allowed frequency for a given device which has impact on
> max allowed power. In current design there is no mechanism to figure this
> out. IPA must know the maximum allowed power for every device. It is then
> used for proper power split and divvy-up. When the user limit for max
> frequency is not know, IPA assumes it is the highest possible frequency.
> It causes wrong power split across the devices.
> 
> This new mechanism provides the max allowed frequency to the thermal
> framework and then max allowed power to the IPA.
> The implementation is done in this way because currently there is no way
> to retrieve the limits from the PM QoS, without uncapping the local
> thermal limit and reading the next value. It would be a heavy way of
> doing these things, since it should be done every polling time (e.g. 50ms).
> Also, the value stored in PM QoS can be different than the real OPP 'rate'
> so still would need conversion into proper OPP for comparison with EM.
> Furthermore, uncapping the device in thermal just to check the user freq
> limit is not the safest way.
> Thus, this simple implementation moves the calculation of the proper
> frequency to the sysfs write code, since it's called less often. The value
> is then used as-is in the thermal framework without any hassle.
> 
> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
> be addressed if all agree.
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (3):
>    PM /devfreq: add user frequency limits into devfreq struct
>    thermal: devfreq_cooling: add new callback to get user limit for min
>      state
>    thermal: power_allocator: get proper max power limited by user
> 
>   drivers/devfreq/devfreq.c             | 41 ++++++++++++++++++++++++---
>   drivers/thermal/devfreq_cooling.c     | 33 +++++++++++++++++++++
>   drivers/thermal/gov_power_allocator.c | 17 +++++++++--
>   include/linux/devfreq.h               |  4 +++
>   include/linux/thermal.h               |  1 +
>   5 files changed, 90 insertions(+), 6 deletions(-)
> 
