Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294172AB382
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 10:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgKIJYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 04:24:25 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:48408 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgKIJYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 04:24:24 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201109092420epoutp04fefa76c873f9e53edd39c837c1c057ec~FzKcsqJvU3106131061epoutp04c
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 09:24:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201109092420epoutp04fefa76c873f9e53edd39c837c1c057ec~FzKcsqJvU3106131061epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604913860;
        bh=JT0sLbUUeWqaL2+bi/rEtX/1btMEnE0S/D8cJ+NVliE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZJVP/CsY94iFlfJ7BMDgQM7upwKk/RZtif/bfvnGIIFJ5LPUaiI3Vv4WsewQKYj3S
         w5h6zf6nF4v6sX/sb9aZkaUA0wnAIzbHMI7TRNNCnWdTqez62ARgyVmtG5RbhOJLrS
         yyrbbhK6ChEsEiy4Vhw9/D6z3nzF7o/bS/yRqvEQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201109092420epcas1p1ec07f68c400c7a8a74a095bee14869b4~FzKcbOclS0299102991epcas1p1d;
        Mon,  9 Nov 2020 09:24:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CV5D14HHYzMqYm2; Mon,  9 Nov
        2020 09:24:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.27.09582.3BA09AF5; Mon,  9 Nov 2020 18:24:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201109092403epcas1p15a534e0343e77ac137a57ab45439b9fb~FzKMlq-q83262132621epcas1p1t;
        Mon,  9 Nov 2020 09:24:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201109092403epsmtrp1252f23cefd897028d5b1c599c0e59b77~FzKMk6Z6Q0505205052epsmtrp1v;
        Mon,  9 Nov 2020 09:24:03 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-97-5fa90ab3473a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F7.08745.3BA09AF5; Mon,  9 Nov 2020 18:24:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201109092403epsmtip1b3be786c88ec2dff2593d9aecc098f13~FzKMVB4MF1708417084epsmtip1w;
        Mon,  9 Nov 2020 09:24:03 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: passive: Update frequency when start
 governor
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <90d300a2-4dad-c920-beca-dcd7b4cbffee@samsung.com>
Date:   Mon, 9 Nov 2020 18:37:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <21d84c20-ac34-7d05-3c7d-feb1a881980d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTV3cz18p4gw8nDCw2zljPajHxxhUW
        i7NNb9gtLu+aw2bxufcIo8XaI3fZLW43rmBzYPfYtKqTzaNvyypGj8+b5AKYo7JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM/b97mQuaNCq
        eDx9HmMD4zblLkZODgkBE4kP++eygthCAjsYJe53ykPYnxgllvaIdTFyAdmfGSWe/5nJDNPQ
        vvQ0E0RiF6PE/lPnGCGc94wS39dtBRslLBAkMaF/MyOILSKQKXHk3CtWkCJmgWZGiXWvLoAV
        sQloSex/cYMNxOYXUJS4+uMxWAOvgJ3E5IlT2EFsFgEViQXz14DZogJhEie3tUDVCEqcnPmE
        pYuRg4NTwF7iXHs2SJhZQFzi1pP5TBC2vETz1tnMIHslBCZySLzt2MEE8YKLxJymqywQtrDE
        q+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuyHOFpCwFhi/9LJTCCLmQU0Jdbv0ocIK0rs/D2X
        EWIxn8S7rz2sICUSArwSHW1CECXKEpcf3IU6QVJicXsn2wRGpVlIvpmF5IVZSF6YhbBsASPL
        Kkax1ILi3PTUYsMCY+TI3sQITpda5jsYp739oHeIkYmD8RCjBAezkgiv078V8UK8KYmVValF
        +fFFpTmpxYcYTYHhO5FZSjQ5H5iw80riDU2NjI2NLUwMzUwNDZXEef9od8QLCaQnlqRmp6YW
        pBbB9DFxcEo1MDlYNZvqTtr0dH7rM6kX4T+5iifKLm1ZIXFk7jdmH2NNEavSwHvf7yrFL+PL
        CTr9dtO8Sy9//tJ5IPPp7hpXlr8VTJ5bfsX1bpo/w6yIZzu7bJG05cZTQiYns9MqNNbpfHjF
        7DR/6udtBxhMDc1+ZoamsFzYPoOzo3XFLEO21Bdnzvm9vb5az7Q2WPRWWNm9xNUT9j9WP73p
        sf8t50X/V15fGBN+d7/mzoMPeeRedpXMi1sVxvf4oe30ow2T2UQmbfA4oi3Ur1gt2dhbKPPq
        Tdi/GxYvNxtwPIxR3ZW640RtYYxKDBO75GoHsf0vWRoDArveOk4+9vrejrLjalN133+6Mi+y
        NH/Kg/VrHPwe73msxFKckWioxVxUnAgAKnOtCiAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO5mrpXxBh8P81hsnLGe1WLijSss
        Fmeb3rBbXN41h83ic+8RRou1R+6yW9xuXMHmwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBl7PvdyVzQoFXxePo8xgbGbcpdjJwcEgImEu1LTzN1MXJxCAnsYJS4cuUoC0RCUmLa
        xaPMXYwcQLawxOHDxRA1bxkl3u9oZQWpERYIkpjQv5kRxBYRyJTYsf8i2CBmgWZGie3Helgh
        Og4zSlzufcMMUsUmoCWx/8UNNhCbX0BR4uqPx2DdvAJ2EpMnTmEHsVkEVCQWzF8DZosKhEns
        XPKYCaJGUOLkzCcsIBdxCthLnGvPBgkzC6hL/Jl3iRnCFpe49WQ+E4QtL9G8dTbzBEbhWUi6
        ZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjR0trB+OeVR/0
        DjEycTAeYpTgYFYS4XX6tyJeiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/XWQvjhATSE0tSs1NT
        C1KLYLJMHJxSDUxMqz9w5UfJrtL4GbBP0UFIcnNn6jXzDY+2173//GLOqyevlvRVcp22d2Od
        /W1e1LUFmd+fRH+Lv7Ll6US7hw/UD7K8+z+p0KNR1uJ/rGH3vL2BB+7+7TLPr52jlTtxYo1A
        0+JVE6cmSxy7wrTL3nahm8Du0jUvDcO9lQ7F9DG9MSw3YDa9f/nXuyyRpBztzG92nE2FrEdc
        grburV5expvdwcdaJPfnashPk2JD34S3WkeuuDBYnp9i792YuHDn3I4v7V5/vJcIZYtt987/
        n3iDN2LxAbdZF7/f8voTEBq7yT8q7sS/Bc8vK+2e8ipihcLV63NLE9/rZS45ITHz4r3P9/Nz
        nmpLeLA+33kyXOavEktxRqKhFnNRcSIARjVV9AwDAAA=
X-CMS-MailID: 20201109092403epcas1p15a534e0343e77ac137a57ab45439b9fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201103065250epcas1p4421332566646a4464d7871429aabafd9
References: <CGME20201103065250epcas1p4421332566646a4464d7871429aabafd9@epcas1p4.samsung.com>
        <20201103070646.18687-1-cw00.choi@samsung.com>
        <21d84c20-ac34-7d05-3c7d-feb1a881980d@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

Thanks for bug reporting. I'll check and fix it. 

Best Regards,
Chanwoo Choi

On 11/9/20 6:22 PM, Marek Szyprowski wrote:
> Hi Chanwoo,
> 
> On 03.11.2020 08:06, Chanwoo Choi wrote:
>> If the parent device changes the their frequency before registering
>> the passive device, the passive device cannot receive the notification
>> from parent device and then the passive device cannot be able to
>> set the proper frequency according to the frequency of parent device.
>>
>> So, when start the passive governor, update the frequency
>> according to the frequency of parent device.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch landed in linux next-20201109 as commit 9b38a4f6b664 ("PM / 
> devfreq: passive: Update frequency when start governor"). Sadly it 
> causes the following warning on various Exynos boards with default 
> exynos_defconfig build:
> 
> exynos-bus: new bus device registered: soc:bus_dmc ( 50000 KHz ~ 400000 KHz)
> exynos-bus: new bus device registered: soc:bus_leftbus ( 50000 KHz ~ 
> 200000 KHz)
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 22 at drivers/devfreq/devfreq.c:411 
> devfreq_update_target+0xdc/0xec
> Modules linked in:
> CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.10.0-rc2-next-20201109 #1898
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events deferred_probe_work_func
> [<c0111648>] (unwind_backtrace) from [<c010d000>] (show_stack+0x10/0x14)
> [<c010d000>] (show_stack) from [<c0b224a0>] (dump_stack+0xb4/0xd4)
> [<c0b224a0>] (dump_stack) from [<c0126844>] (__warn+0xd8/0x11c)
> [<c0126844>] (__warn) from [<c0126938>] (warn_slowpath_fmt+0xb0/0xb8)
> [<c0126938>] (warn_slowpath_fmt) from [<c08ae39c>] 
> (devfreq_update_target+0xdc/0xec)
> [<c08ae39c>] (devfreq_update_target) from [<c08afa0c>] 
> (devfreq_passive_event_handler+0x80/0xc4)
> [<c08afa0c>] (devfreq_passive_event_handler) from [<c08ade70>] 
> (devfreq_add_device+0x4f8/0x5a0)
> [<c08ade70>] (devfreq_add_device) from [<c08adf60>] 
> (devm_devfreq_add_device+0x48/0x84)
> [<c08adf60>] (devm_devfreq_add_device) from [<c08b01c8>] 
> (exynos_bus_probe+0x2ac/0x5c8)
> [<c08b01c8>] (exynos_bus_probe) from [<c0692a70>] 
> (platform_drv_probe+0x6c/0xa4)
> [<c0692a70>] (platform_drv_probe) from [<c0690020>] 
> (really_probe+0x200/0x4fc)
> [<c0690020>] (really_probe) from [<c06904e4>] 
> (driver_probe_device+0x78/0x1fc)
> [<c06904e4>] (driver_probe_device) from [<c068de7c>] 
> (bus_for_each_drv+0x74/0xb8)
> [<c068de7c>] (bus_for_each_drv) from [<c068fd80>] 
> (__device_attach+0xe4/0x17c)
> [<c068fd80>] (__device_attach) from [<c068ee40>] 
> (bus_probe_device+0x88/0x90)
> [<c068ee40>] (bus_probe_device) from [<c068f358>] 
> (deferred_probe_work_func+0x3c/0xd0)
> [<c068f358>] (deferred_probe_work_func) from [<c0148a70>] 
> (process_one_work+0x234/0x7e4)
> [<c0148a70>] (process_one_work) from [<c0149064>] (worker_thread+0x44/0x51c)
> [<c0149064>] (worker_thread) from [<c014fdc8>] (kthread+0x158/0x1a0)
> [<c014fdc8>] (kthread) from [<c010011c>] (ret_from_fork+0x14/0x38)
> Exception stack(0xc1e27fb0 to 0xc1e27ff8)
> 7fa0:                                     00000000 00000000 00000000 
> 00000000
> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> irq event stamp: 12147
> hardirqs last  enabled at (12171): [<c01a0358>] console_unlock+0x430/0x6b0
> dwc2 12480000.hsotg: new device is high-speed
> hardirqs last disabled at (12176): [<c01a0350>] console_unlock+0x428/0x6b0
> softirqs last  enabled at (12168): [<c01017a8>] __do_softirq+0x528/0x674
> softirqs last disabled at (12155): [<c012fdb0>] irq_exit+0x1dc/0x1e8
> ---[ end trace 89c1007ec29b9250 ]---
> 
> Reverting it on top of the linux-next fixes the warning, but I assume 
> that the proper fix would require locking changes during the devfreq 
> registration.
> 
>> ---
>>   drivers/devfreq/governor_passive.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index 63332e4a65ae..375aa636027c 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -141,6 +141,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>   		if (!p_data->this)
>>   			p_data->this = devfreq;
>>   
>> +		/*
>> +		 * If the parent device changes the their frequency before
>> +		 * registering the passive device, the passive device cannot
>> +		 * receive the notification from parent device and then the
>> +		 * passive device cannot be able to set the proper frequency
>> +		 * according to the frequency of parent device.
>> +		 *
>> +		 * When start the passive governor, update the frequency
>> +		 * according to the frequency of parent device.
>> +		 */
>> +		ret = devfreq_update_target(devfreq, parent->previous_freq);
>> +		if (ret < 0)
>> +			dev_warn(&devfreq->dev,
>> +			"failed to update devfreq using passive governor\n");
>> +
>>   		nb->notifier_call = devfreq_passive_notifier_call;
>>   		ret = devfreq_register_notifier(parent, nb,
>>   					DEVFREQ_TRANSITION_NOTIFIER);
> 
> Best regards
> 
