Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA10459EE6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 10:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhKWJMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 04:12:35 -0500
Received: from foss.arm.com ([217.140.110.172]:49812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhKWJMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 04:12:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D13ED1;
        Tue, 23 Nov 2021 01:09:27 -0800 (PST)
Received: from [10.57.23.185] (unknown [10.57.23.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B783F73B;
        Tue, 23 Nov 2021 01:09:23 -0800 (PST)
Subject: Re: [PATCH v4 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211109195714.7750-2-lukasz.luba@arm.com>
 <5de717f7-dd64-5584-540a-e0b86a431dde@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <05dd3205-a943-af80-f815-50a4a0ca9c5c@arm.com>
Date:   Tue, 23 Nov 2021 09:09:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5de717f7-dd64-5584-540a-e0b86a431dde@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/16/21 11:39 PM, Thara Gopinath wrote:
> 
> 
> On 11/9/21 2:57 PM, Lukasz Luba wrote:
>> The thermal pressure is a mechanism which is used for providing
>> information about reduced CPU performance to the scheduler. Usually code
>> has to convert the value from frequency units into capacity units,
>> which are understandable by the scheduler. Create a common conversion 
>> code
>> which can be just used via a handy API.
>>
>> Internally, the topology_update_thermal_pressure() operates on frequency
>> in MHz and max CPU frequency is taken from 'freq_factor' (per-cpu).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> 

Thank you Thara for the review!
