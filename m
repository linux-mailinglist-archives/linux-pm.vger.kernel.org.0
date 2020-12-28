Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0FD2E35E8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 11:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgL1K3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 05:29:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgL1K3X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Dec 2020 05:29:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72D431FB;
        Mon, 28 Dec 2020 02:28:37 -0800 (PST)
Received: from [10.57.30.50] (unknown [10.57.30.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EDF13F6CF;
        Mon, 28 Dec 2020 02:28:33 -0800 (PST)
Subject: Re: [PATCH] thermal: cpufreq_cooling: fix slab OOB issue
To:     Michael Kao <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        brian-sy yang <brian-sy.yang@mediatek.com>
References: <20201223074849.1989-1-michael.kao@mediatek.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <010350df-e094-cf12-1c17-f56aa4b20b9f@arm.com>
Date:   Mon, 28 Dec 2020 10:28:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201223074849.1989-1-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/23/20 7:48 AM, Michael Kao wrote:
> From: brian-sy yang <brian-sy.yang@mediatek.com>
> 
> Slab OOB issue is scanned by KASAN in cpu_power_to_freq().
> If power is limited below the power of OPP0 in EM table,
> it will cause slab out-of-bound issue with negative array
> index.
> 
> Return the lowest frequency if limited power cannot found
> a suitable OPP in EM table to fix this issue.
> 
> Backtrace:
> [<ffffffd02d2a37f0>] die+0x104/0x5ac
> [<ffffffd02d2a5630>] bug_handler+0x64/0xd0
> [<ffffffd02d288ce4>] brk_handler+0x160/0x258
> [<ffffffd02d281e5c>] do_debug_exception+0x248/0x3f0
> [<ffffffd02d284488>] el1_dbg+0x14/0xbc
> [<ffffffd02d75d1d4>] __kasan_report+0x1dc/0x1e0
> [<ffffffd02d75c2e0>] kasan_report+0x10/0x20
> [<ffffffd02d75def8>] __asan_report_load8_noabort+0x18/0x28
> [<ffffffd02e6fce5c>] cpufreq_power2state+0x180/0x43c
> [<ffffffd02e6ead80>] power_actor_set_power+0x114/0x1d4
> [<ffffffd02e6fac24>] allocate_power+0xaec/0xde0
> [<ffffffd02e6f9f80>] power_allocator_throttle+0x3ec/0x5a4
> [<ffffffd02e6ea888>] handle_thermal_trip+0x160/0x294
> [<ffffffd02e6edd08>] thermal_zone_device_check+0xe4/0x154
> [<ffffffd02d351cb4>] process_one_work+0x5e4/0xe28
> [<ffffffd02d352f44>] worker_thread+0xa4c/0xfac
> [<ffffffd02d360124>] kthread+0x33c/0x358
> [<ffffffd02d289940>] ret_from_fork+0xc/0x18

Thank you for looking at this and sending a fix.

It's worth to add the 'fixes' line:

Fixes: 371a3bc79c11b ("thermal/drivers/cpufreq_cooling: Fix wrong 
frequency converted from power")

IIRC that patch was sent to stable trees. Might be worth to check
and apply this fix.


> 
> Signed-off-by: brian-sy yang <brian-sy.yang@mediatek.com>


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


> ---
>   drivers/thermal/cpufreq_cooling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index cc2959f22f01..fb33b3480a8f 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -123,7 +123,7 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>   {
>   	int i;
>   
> -	for (i = cpufreq_cdev->max_level; i >= 0; i--) {
> +	for (i = cpufreq_cdev->max_level; i > 0; i--) {
>   		if (power >= cpufreq_cdev->em->table[i].power)
>   			break;
>   	}
> 
