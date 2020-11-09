Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9F2AB379
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 10:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgKIJWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 04:22:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46426 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgKIJWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 04:22:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201109092232euoutp014dc259da792ab3292c72361fd503845b~FzI3_KOwW2300423004euoutp01a
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 09:22:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201109092232euoutp014dc259da792ab3292c72361fd503845b~FzI3_KOwW2300423004euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604913752;
        bh=KE/9Ok8AOxVIKkv/0XY/JHQWJWJlpBmQSKZrj9ixw1U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=suhE/XuC21ayNpmgUr6/sOTUanCRuuzsz58+6uDY6hDrfMrF357uY5FMe2VMkoTjk
         xZmCkTzw/8EL1Nlsoe+Hbu1l9BVpKhj2LyZO9VYNanMA0YPs5pW6xFeCtygnGs/36A
         FEqQRWvVzNd2Mj/cV67fVuRIw83oJGq1wxgll+wU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201109092225eucas1p2c0da835875c7499bcaff92c76a8e3378~FzIxYhS7T2452824528eucas1p2B;
        Mon,  9 Nov 2020 09:22:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.02.06318.15A09AF5; Mon,  9
        Nov 2020 09:22:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201109092224eucas1p22f8047a4a03a7d6120da808ef1fc25d6~FzIw5s1gK1319013190eucas1p2R;
        Mon,  9 Nov 2020 09:22:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201109092224eusmtrp2b7b1603fff1ecf6aaca30902ec681a9b~FzIw5E5FF0820808208eusmtrp2_;
        Mon,  9 Nov 2020 09:22:24 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-be-5fa90a51faa4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.A2.06017.05A09AF5; Mon,  9
        Nov 2020 09:22:24 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201109092224eusmtip17c392d6a2c259d7d9cabc18f67ffdf91~FzIwdJ-1N1027310273eusmtip1P;
        Mon,  9 Nov 2020 09:22:24 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: passive: Update frequency when start
 governor
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <21d84c20-ac34-7d05-3c7d-feb1a881980d@samsung.com>
Date:   Mon, 9 Nov 2020 10:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103070646.18687-1-cw00.choi@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7qBXCvjDVqWiVhsnLGe1WLijSss
        Fte/PGe1ONv0ht3i8q45bBafe48wWtxuXMHmwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBl3F7SwFTwWb1ixaRWlgbGDqUuRk4OCQETiXULljN2MXJxCAmsYJSYteMgO4TzhVHi
        8bnnrCBVQgKfGSV2HFCH6fjVMB2qYzmjxN/udqiO94wSa7+9YAGpEhYIkpjQv5kRxBYRSJKY
        vWMrE0gRs0Azo8S6VxfAxrIJGEp0ve1iA7F5Bewkmg5eZAexWQRUJD60/2EGsUWBmv9+hrB5
        BQQlTs58AraAU8Ba4l3rXbAFzALyEs1bZzND2OISt57MB1smIbCIXeLS2aNsEHe7SLz585UV
        whaWeHV8CzuELSPxfydMA9B1D8+tZYdwehglLjfNYISospa4c+4X0CQOoBWaEut36UOEHSV2
        LZzKBBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiF5bRaSd2Yh
        eWcWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPO6X/Hv+5g3Pcn6RCjAAej
        Eg/vgT/L4oVYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctY
        IYH0xJLU7NTUgtQimCwTB6dUA+OFEu/D81/u/1kpu8KpRK5125er7XY1vztvMk6s2vaR6X/7
        iiWHLni+d14qYmLNsXvB8dhH9g3BB0NmpT6cZ7TkB2v20vk11nfiZ4lGhDJUr1xl+8b3/+eE
        D5YavIKM0y+7xfhOkF7+KeGDTPJD/QdmO6O3S76evGSnRmZzmtKdSWefuR4weRCvxFKckWio
        xVxUnAgAo0YndTUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oBXCvjDa5f0LfYOGM9q8XEG1dY
        LK5/ec5qcbbpDbvF5V1z2Cw+9x5htLjduILNgd1j06pONo++LasYPT5vkgtgjtKzKcovLUlV
        yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuL2kgangs3rFikmt
        LA2MHUpdjJwcEgImEr8apjN2MXJxCAksZZSY9fQRI0RCRuLktAZWCFtY4s+1LjaIoreMEsee
        HwMrEhYIkpjQvxnMFhFIktgxpYkZpIhZoJlRYvuxHlaIjj5GiZcLZoJVsQkYSnS9BRnFycEr
        YCfRdPAiO4jNIqAi8aH9DzOILQo06eWFqUwQNYISJ2c+YQGxOQWsJd613gWbwyxgJjFv80Nm
        CFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvX
        S87P3cQIjLJtx35u2cHY9S74EKMAB6MSD++BP8vihVgTy4orcw8xSnAwK4nwOp09HSfEm5JY
        WZValB9fVJqTWnyI0RTouYnMUqLJ+cAEkFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1
        OzW1ILUIpo+Jg1OqgTH5ftXmtQ0P2v7kz15h9jRUPsZZbSa3Fc+cLzd4fxZ7l33I4LdbcN7v
        WOVjxjUbtB7lmIuXqQmvyy85ffiAVKHP7mjfmbUs18xVFOtWH/cMKtFYxVvOunN1+mqGeQz8
        zQ0RCfrTtaXmlS/tTHeL5e/Xi7xu843BVn76uoKnYm9Ffgl+S9U8qsRSnJFoqMVcVJwIAI5E
        lhbIAgAA
X-CMS-MailID: 20201109092224eucas1p22f8047a4a03a7d6120da808ef1fc25d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201103065250epcas1p4421332566646a4464d7871429aabafd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201103065250epcas1p4421332566646a4464d7871429aabafd9
References: <CGME20201103065250epcas1p4421332566646a4464d7871429aabafd9@epcas1p4.samsung.com>
        <20201103070646.18687-1-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 03.11.2020 08:06, Chanwoo Choi wrote:
> If the parent device changes the their frequency before registering
> the passive device, the passive device cannot receive the notification
> from parent device and then the passive device cannot be able to
> set the proper frequency according to the frequency of parent device.
>
> So, when start the passive governor, update the frequency
> according to the frequency of parent device.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

This patch landed in linux next-20201109 as commit 9b38a4f6b664 ("PM / 
devfreq: passive: Update frequency when start governor"). Sadly it 
causes the following warning on various Exynos boards with default 
exynos_defconfig build:

exynos-bus: new bus device registered: soc:bus_dmc ( 50000 KHz ~ 400000 KHz)
exynos-bus: new bus device registered: soc:bus_leftbus ( 50000 KHz ~ 
200000 KHz)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 22 at drivers/devfreq/devfreq.c:411 
devfreq_update_target+0xdc/0xec
Modules linked in:
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.10.0-rc2-next-20201109 #1898
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
[<c0111648>] (unwind_backtrace) from [<c010d000>] (show_stack+0x10/0x14)
[<c010d000>] (show_stack) from [<c0b224a0>] (dump_stack+0xb4/0xd4)
[<c0b224a0>] (dump_stack) from [<c0126844>] (__warn+0xd8/0x11c)
[<c0126844>] (__warn) from [<c0126938>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126938>] (warn_slowpath_fmt) from [<c08ae39c>] 
(devfreq_update_target+0xdc/0xec)
[<c08ae39c>] (devfreq_update_target) from [<c08afa0c>] 
(devfreq_passive_event_handler+0x80/0xc4)
[<c08afa0c>] (devfreq_passive_event_handler) from [<c08ade70>] 
(devfreq_add_device+0x4f8/0x5a0)
[<c08ade70>] (devfreq_add_device) from [<c08adf60>] 
(devm_devfreq_add_device+0x48/0x84)
[<c08adf60>] (devm_devfreq_add_device) from [<c08b01c8>] 
(exynos_bus_probe+0x2ac/0x5c8)
[<c08b01c8>] (exynos_bus_probe) from [<c0692a70>] 
(platform_drv_probe+0x6c/0xa4)
[<c0692a70>] (platform_drv_probe) from [<c0690020>] 
(really_probe+0x200/0x4fc)
[<c0690020>] (really_probe) from [<c06904e4>] 
(driver_probe_device+0x78/0x1fc)
[<c06904e4>] (driver_probe_device) from [<c068de7c>] 
(bus_for_each_drv+0x74/0xb8)
[<c068de7c>] (bus_for_each_drv) from [<c068fd80>] 
(__device_attach+0xe4/0x17c)
[<c068fd80>] (__device_attach) from [<c068ee40>] 
(bus_probe_device+0x88/0x90)
[<c068ee40>] (bus_probe_device) from [<c068f358>] 
(deferred_probe_work_func+0x3c/0xd0)
[<c068f358>] (deferred_probe_work_func) from [<c0148a70>] 
(process_one_work+0x234/0x7e4)
[<c0148a70>] (process_one_work) from [<c0149064>] (worker_thread+0x44/0x51c)
[<c0149064>] (worker_thread) from [<c014fdc8>] (kthread+0x158/0x1a0)
[<c014fdc8>] (kthread) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc1e27fb0 to 0xc1e27ff8)
7fa0:                                     00000000 00000000 00000000 
00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 12147
hardirqs last  enabled at (12171): [<c01a0358>] console_unlock+0x430/0x6b0
dwc2 12480000.hsotg: new device is high-speed
hardirqs last disabled at (12176): [<c01a0350>] console_unlock+0x428/0x6b0
softirqs last  enabled at (12168): [<c01017a8>] __do_softirq+0x528/0x674
softirqs last disabled at (12155): [<c012fdb0>] irq_exit+0x1dc/0x1e8
---[ end trace 89c1007ec29b9250 ]---

Reverting it on top of the linux-next fixes the warning, but I assume 
that the proper fix would require locking changes during the devfreq 
registration.

> ---
>   drivers/devfreq/governor_passive.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 63332e4a65ae..375aa636027c 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -141,6 +141,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>   		if (!p_data->this)
>   			p_data->this = devfreq;
>   
> +		/*
> +		 * If the parent device changes the their frequency before
> +		 * registering the passive device, the passive device cannot
> +		 * receive the notification from parent device and then the
> +		 * passive device cannot be able to set the proper frequency
> +		 * according to the frequency of parent device.
> +		 *
> +		 * When start the passive governor, update the frequency
> +		 * according to the frequency of parent device.
> +		 */
> +		ret = devfreq_update_target(devfreq, parent->previous_freq);
> +		if (ret < 0)
> +			dev_warn(&devfreq->dev,
> +			"failed to update devfreq using passive governor\n");
> +
>   		nb->notifier_call = devfreq_passive_notifier_call;
>   		ret = devfreq_register_notifier(parent, nb,
>   					DEVFREQ_TRANSITION_NOTIFIER);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

