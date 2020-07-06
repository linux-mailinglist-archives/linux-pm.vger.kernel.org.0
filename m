Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BB215820
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgGFNRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 09:17:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45462 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgGFNRL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 09:17:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200706131709euoutp01978c0c7a98a2a2af2aa8d2a8d43b1cd6~fLDwh5S3g3157231572euoutp01I
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 13:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200706131709euoutp01978c0c7a98a2a2af2aa8d2a8d43b1cd6~fLDwh5S3g3157231572euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594041429;
        bh=0ceVHY+kZAg4/I4oYDy9K14+JhnlTacmtaXs5MtO3rw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lgEcfLj3ADuU3ioD6Ofk4akkyxD8IhsmYXOx3kd/X4PyhGpvNB/xR02QfdHq/HMuh
         ga0empGI0qIJyqz49j1m3Lqj4HKYlbvrCbaji+o4/kWaCthGWisusoUh4uJJlc58TK
         bUUWIyyVUkiCt2o0qzyUbfNLyW54QeS+AQVd2MGI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200706131709eucas1p20f3484ffd13d0880c1ba8f8d250c88e3~fLDwCE7_v2188621886eucas1p2y;
        Mon,  6 Jul 2020 13:17:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.95.06318.554230F5; Mon,  6
        Jul 2020 14:17:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200706131708eucas1p1487955a7632584c17df724399f48825a~fLDvspVLN0971609716eucas1p1H;
        Mon,  6 Jul 2020 13:17:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200706131708eusmtrp1bac69828d6b69f2294de5761be7870b3~fLDvqvsXM0049800498eusmtrp1u;
        Mon,  6 Jul 2020 13:17:08 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-1d-5f032455a966
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.BE.06017.454230F5; Mon,  6
        Jul 2020 14:17:08 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200706131708eusmtip10249f1817b7f16075192d6ebb03c75e6~fLDvNHArv0381103811eusmtip1d;
        Mon,  6 Jul 2020 13:17:08 +0000 (GMT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
Date:   Mon, 6 Jul 2020 15:17:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706105538.2159-4-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7qhKszxBrO+CFo0Nyxmstg4Yz2r
        xbzPshaXd81hs/jce4TR4vO2WewWTx72sVlMWLyR3YHD43JfL5PH4j0vmTzuXNvD5jHvZKBH
        35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZaw8vp6xYI5lxewj99kbGFfrdzFyckgImEic2bOG
        vYuRi0NIYAWjxL45nxghnC+MEp2rrrNAOJ8ZJVobWtlgWk4enAaVWM4o0bt2MRuE855RYuu/
        JhaQKmGBEIlfPz4ygtgiAs4SV0/eBVvCLHCOUeLR6fVgCTYBQ4mut11gY3kF7CQuPJkNFmcR
        UJH4/vsbmC0qECex/uV2JogaQYmTM5+ALeAEqj/4ehJYDbOAvETz1tnMELa4xK0n85kgTt3F
        LnF5XxaE7SKx4voDqLiwxKvjW9ghbBmJ05N7wN6REGhmlHh4bi07hNPDKHG5aQYjRJW1xJ1z
        v4Au5QDaoCmxfhc0+Bwlnr7dARaWEOCTuPFWEOIGPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bg
        hUvMExiVZiH5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAtPS
        6X/Hv+5g3Pcn6RCjAAejEg/vAw7meCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5Xm
        pBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwNj6/qPbgf6WU3HJd2P5H7pZzhXY
        q27ofU/v9uE3cleSp6V3XykV36z/Uf718+5Tx0U7Qg5/M/x98Gl36RZ5titGvYqyD+Q0l8QU
        7doRwLg1JzJoxtKe7vsrN3b3ln9ySj82SWTqK/Oao/NCjc0PH132UiaPwXL+xlViug9UVnWe
        LOM1vO53zVuJpTgj0VCLuag4EQDXfH72RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7ohKszxBs+nW1o0Nyxmstg4Yz2r
        xbzPshaXd81hs/jce4TR4vO2WewWTx72sVlMWLyR3YHD43JfL5PH4j0vmTzuXNvD5jHvZKBH
        35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZaw8vp6xYI5lxewj99kbGFfrdzFyckgImEicPDiNpYuRi0NIYCmjxLM309ggEjIS
        J6c1sELYwhJ/rnWxQRS9ZZSYenYNO0hCWCBE4tePj4wgtoiAs8TVk3fB4swC5xgl1t+vALGF
        BAolPp27DTaUTcBQouttF5jNK2AnceHJbLBeFgEVie+/v4HZogJxEsu3zGeHqBGUODnzCQuI
        zQlUf/D1JEaI+WYS8zY/ZIaw5SWat86GssUlbj2ZzzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR
        1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAo3Hbs55YdjF3vgg8xCnAwKvHwdrAxxwuxJpYVV+Ye
        YpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBCSKvJN7Q1NDcwtLQ3Njc
        2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPjLOGq59nWrqnzRN4zb765QFY5XGL1Tql1
        3PcPbl1b4vvINClh1769kjd2/t/9LJuHb8KpM6Zf486KtX18+Utk8QzHf2kzajdFWtWf5J/M
        l2uT9EjTdV5eUtHTAsdGv2km7Vw7vgXHmnYuOzRr750IF5NWw9t5u2s9D8oalE84KLLKyXX5
        wVssSizFGYmGWsxFxYkAiyaMn9gCAAA=
X-CMS-MailID: 20200706131708eucas1p1487955a7632584c17df724399f48825a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200706131708eucas1p1487955a7632584c17df724399f48825a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200706131708eucas1p1487955a7632584c17df724399f48825a
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
        <20200706105538.2159-4-daniel.lezcano@linaro.org>
        <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 06.07.2020 12:55, Daniel Lezcano wrote:
> The generic netlink protocol is implemented but the different
> notification functions are not yet connected to the core code.
>
> These changes add the notification calls in the different
> corresponding places.
>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This patch landed in today's linux-next 20200706 as commit 5df786e46560 
("thermal: core: Add notifications call in the framework"). Sadly it 
breaks booting various Samsung Exynos based boards. Here is an example 
log from Odroid U3 board:

Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = (ptrval)
[00000010] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560 
#1146
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at kmem_cache_alloc+0x13c/0x418
LR is at kmem_cache_alloc+0x48/0x418
pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
...
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xee8f1cf8 to 0xee8f2000)
...
[<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] (__alloc_skb+0x5c/0x170)
[<c08cd170>] (__alloc_skb) from [<c07ec19c>] 
(thermal_genl_send_event+0x24/0x174)
[<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>] 
(thermal_notify_tz_create+0x58/0x74)
[<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>] 
(thermal_zone_device_register+0x358/0x650)
[<c07e9058>] (thermal_zone_device_register) from [<c1028d34>] 
(of_parse_thermal_zones+0x304/0x7a4)
[<c1028d34>] (of_parse_thermal_zones) from [<c1028964>] 
(thermal_init+0xdc/0x154)
[<c1028964>] (thermal_init) from [<c0102378>] (do_one_initcall+0x8c/0x424)
[<c0102378>] (do_one_initcall) from [<c1001158>] 
(kernel_init_freeable+0x190/0x204)
[<c1001158>] (kernel_init_freeable) from [<c0ab85f4>] 
(kernel_init+0x8/0x118)
[<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)

Reverting it on top of linux-next fixes the boot issue. I will 
investigate it further soon.



> ---
>    v4:
>       - Fixed missing static declaration, reported by kbuild-bot
>       - Removed max state notification
> ---
>   drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>   drivers/thermal/thermal_helpers.c | 13 +++++++++++--
>   drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>   3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5fae1621fb01..25ef29123f72 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>   	mutex_unlock(&tz->lock);
>   	mutex_unlock(&thermal_governor_lock);
>   
> +	thermal_notify_tz_gov_change(tz->id, policy);
> +
>   	return ret;
>   }
>   
> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   {
>   	enum thermal_trip_type type;
> +	int trip_temp, hyst = 0;
>   
>   	/* Ignore disabled trip points */
>   	if (test_bit(trip, &tz->trips_disabled))
>   		return;
>   
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>   	tz->ops->get_trip_type(tz, trip, &type);
> +	if (tz->ops->get_trip_hyst)
> +		tz->ops->get_trip_hyst(tz, trip, &hyst);
> +
> +	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> +		if (tz->last_temperature < trip_temp &&
> +		    tz->temperature >= trip_temp)
> +			thermal_notify_tz_trip_up(tz->id, trip);
> +		if (tz->last_temperature >= trip_temp &&
> +		    tz->temperature < (trip_temp - hyst))
> +			thermal_notify_tz_trip_down(tz->id, trip);
> +	}
>   
>   	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>   		handle_critical_trips(tz, trip, type);
> @@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>   	mutex_unlock(&tz->lock);
>   
>   	trace_thermal_temperature(tz);
> +
> +	thermal_genl_sampling_temp(tz->id, temp);
>   }
>   
>   static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -1405,6 +1422,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>   	if (atomic_cmpxchg(&tz->need_update, 1, 0))
>   		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
> +	thermal_notify_tz_create(tz->id, tz->type);
> +
>   	return tz;
>   
>   unregister:
> @@ -1476,6 +1495,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   	ida_destroy(&tz->ida);
>   	mutex_destroy(&tz->lock);
>   	device_unregister(&tz->device);
> +
> +	thermal_notify_tz_delete(tz->id);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>   
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 87b1256fa2f2..c94bc824e5d3 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -175,6 +175,16 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>   	mutex_unlock(&tz->lock);
>   }
>   
> +static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
> +				       int target)
> +{
> +	if (cdev->ops->set_cur_state(cdev, target))
> +		return;
> +
> +	thermal_notify_cdev_state_update(cdev->id, target);
> +	thermal_cooling_device_stats_update(cdev, target);
> +}
> +
>   void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_instance *instance;
> @@ -197,8 +207,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   			target = instance->target;
>   	}
>   
> -	if (!cdev->ops->set_cur_state(cdev, target))
> -		thermal_cooling_device_stats_update(cdev, target);
> +	thermal_cdev_set_cur_state(cdev, target);
>   
>   	cdev->updated = true;
>   	mutex_unlock(&cdev->lock);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..ff449943f757 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
>   	int trip, ret;
> -	int temperature;
> +	int temperature, hyst = 0;
> +	enum thermal_trip_type type;
>   
>   	if (!tz->ops->set_trip_temp)
>   		return -EPERM;
> @@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>   	if (ret)
>   		return ret;
>   
> +	if (tz->ops->get_trip_hyst) {
> +		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = tz->ops->get_trip_type(tz, trip, &type);
> +	if (ret)
> +		return ret;
> +
> +	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
> +
>   	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
>   	return count;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

