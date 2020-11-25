Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0E2C3BD4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKYJSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 04:18:16 -0500
Received: from foss.arm.com ([217.140.110.172]:34394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgKYJSP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Nov 2020 04:18:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31ABE106F;
        Wed, 25 Nov 2020 01:18:15 -0800 (PST)
Received: from [10.57.27.121] (unknown [10.57.27.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455D73F70D;
        Wed, 25 Nov 2020 01:18:13 -0800 (PST)
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Add power_scale_mw_get()
 interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org
References: <20201124104346.27167-1-lukasz.luba@arm.com>
 <20201124104346.27167-2-lukasz.luba@arm.com>
 <20201124165624.glxnmlxavq4bhppm@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2a8a4fd0-dfb7-69a2-5bae-7b5c0d2a1e3e@arm.com>
Date:   Wed, 25 Nov 2020 09:18:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201124165624.glxnmlxavq4bhppm@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/24/20 4:56 PM, Sudeep Holla wrote:
> On Tue, Nov 24, 2020 at 10:43:45AM +0000, Lukasz Luba wrote:
>> Add a new interface to the existing perf_ops and export the information
>> about the power values scale.
>>
>> This would be used by the cpufreq driver and Energy Model framework to
>> set the performance domains scale: milli-Watts or abstract scale.
>>
> 
> Looks good to me. I saw this after I sent pull request this afternoon.
> In case you want to take it via PM tree:
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thank you Sudeep!

Regards,
Lukasz

