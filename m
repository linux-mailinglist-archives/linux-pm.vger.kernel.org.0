Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3919A1BE7F5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2UAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:00:16 -0400
Received: from foss.arm.com ([217.140.110.172]:44202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2UAP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 16:00:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39F261063;
        Wed, 29 Apr 2020 13:00:15 -0700 (PDT)
Received: from [10.37.12.43] (unknown [10.37.12.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C80F3F68F;
        Wed, 29 Apr 2020 13:00:13 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] thermal/drivers/cpuidle_cooling: Change the
 registration function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a0a3edaf-03ff-2fbe-7caf-d77b43db7ed4@arm.com>
Date:   Wed, 29 Apr 2020 21:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200429103644.5492-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 4/29/20 11:36 AM, Daniel Lezcano wrote:
> Today, there is no user for the cpuidle cooling device. The targetted
> platform is ARM and ARM64.
> 
> The cpuidle and the cpufreq cooling device are based on the device tree.
> 
> As the cpuidle cooling device can have its own configuration depending
> on the platform and the available idle states. The DT node description
> will give the optional properties to set the cooling device up.
> 
> Do no longer rely on the CPU node which is prone to error and will
> lead to a confusion in the DT because the cpufreq cooling device is
> also using it. Let initialize the cpuidle cooling device with the DT
> binding.
> 
> This was tested on:
>   - hikey960
>   - hikey6220
>   - rock960
>   - db845c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   - V4:
>     - Changed message from pr_info to pr_debug
>     - Fixed of properties to comply with the binding
>     - Add a debug message int case the thermal-idle node is not found
>     - Do not return an error as the caller won't care
> ---

Looks good.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
