Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3500742F04D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhJOMP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:15:58 -0400
Received: from foss.arm.com ([217.140.110.172]:41688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhJOMP5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Oct 2021 08:15:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76B9E147A;
        Fri, 15 Oct 2021 05:13:51 -0700 (PDT)
Received: from [10.57.23.184] (unknown [10.57.23.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73F13F70D;
        Fri, 15 Oct 2021 05:13:48 -0700 (PDT)
Subject: Re: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu
 thermal pressure
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
 <20211007080729.8262-4-lukasz.luba@arm.com>
 <be6fb99f-90bc-9ba1-b5a7-034b30734158@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7ef0ce1c-40c7-ad08-c7e8-5b1a8507508c@arm.com>
Date:   Fri, 15 Oct 2021 13:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be6fb99f-90bc-9ba1-b5a7-034b30734158@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/11/21 10:17 PM, Thara Gopinath wrote:
> 
> 
> On 10/7/21 4:07 AM, Lukasz Luba wrote:
>> The thermal pressure signal gives information to the scheduler about
>> reduced CPU capacity due to thermal. It is based on a value stored in
>> a per-cpu 'thermal_pressure' variable. The online CPUs will get the
>> new value there, while the offline won't. Unfortunately, when the CPU
>> is back online, the value read from per-cpu variable might be wrong
>> (stale data).  This might affect the scheduler decisions, since it
>> sees the CPU capacity differently than what is actually available.
>>
>> Fix it by making sure that all online+offline CPUs would get the
>> proper value in their per-cpu variable when there is throttling
>> or throttling is removed.
>>
>> Fixes: 275157b367f479 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt 
>> support")
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Thanks for the fix.
> 
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> 

Thank you for the review!
