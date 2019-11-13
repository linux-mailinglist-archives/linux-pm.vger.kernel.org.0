Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A470EFA3B2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 03:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfKMCLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 21:11:40 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:11272 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfKMCLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 21:11:39 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113021136epoutp01c22e3fc96bd61453d82887b16e66a1ed~WlvRh9-V-1828518285epoutp014
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 02:11:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113021136epoutp01c22e3fc96bd61453d82887b16e66a1ed~WlvRh9-V-1828518285epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573611096;
        bh=gXFVvmDkgoild6vkIJnDxBqvbU05KawywXyQLM1p5jE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X39q8G9fj7+fSWkGgNpsDaZaEmtk1Bu9I9lRrZwClsxFO1x0fzcQaiRThsB4uv1yH
         sKRkkAJ7+VIVvO6omjJFcvybYcwoLlXRl459Z2+7tiy7fDvHIcFnSqmPOJOTEOFaN1
         HqG+CaHz3PlWLR9tV1+34LIs5FjF+c/Iz0BxfHbI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113021135epcas1p4600b238e649a0adf94b1b48f2efe34d3~WlvQ8xAjE0168401684epcas1p4C;
        Wed, 13 Nov 2019 02:11:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47CSlm4PBHzMqYkg; Wed, 13 Nov
        2019 02:11:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.FC.04224.3566BCD5; Wed, 13 Nov 2019 11:11:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113021131epcas1p39305d20a91b1c8e31daea0a90875d285~WlvNJjUY80729707297epcas1p3V;
        Wed, 13 Nov 2019 02:11:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113021131epsmtrp1be04a2b0bbe4da9929cf4fa273fb9bcc~WlvNIkscK2433624336epsmtrp1o;
        Wed, 13 Nov 2019 02:11:31 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-07-5dcb6653885c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.B3.25663.3566BCD5; Wed, 13 Nov 2019 11:11:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191113021131epsmtip2fddb0de8d5f29ae79df49995d37d349e~WlvM7Flmz0807708077epsmtip2V;
        Wed, 13 Nov 2019 02:11:31 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add missing locking while setting
 suspend_freq
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1d992c15-66bd-4d53-114f-66e3105e5fae@samsung.com>
Date:   Wed, 13 Nov 2019 11:17:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112104734.31074-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmvm5I2ulYg82xFhtnrGe1OH9+A7vF
        irsfWS0u75rDZvG59wijxYzz+5gs1h65y27xecNjRovbjSvYLM6cvsTqwOUxu+Eii8emVZ1s
        Hhvf7WDy2HK1ncWjb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGf8unqfpeC+YsW+J3uZGhify3QxcnJICJhILJy5hqmL
        kYtDSGAHo8TBl0fZIJxPjBLTP/Wzg1QJCXxjlNg4QQWm49+py6wQRXsZJdZdPc4C4bxnlDi6
        4jIjSJWwQLDEgxezWUFsEYE8iZdHpoF1MAvsYZLY9O4MWIJNQEti/4sbbCA2v4CixNUfj8Ga
        eQXsJO59nAQWZxFQlbhy9DhQnINDVCBC4vTXRIgSQYmTM5+wgNicQOXrp14Bs5kFxCVuPZnP
        BGHLS2x/O4cZZK+EQD+7RN/nd4wQL7hIHFl6ggXCFpZ4dXwLO4QtJfGyvw3KrpZYefIIG0Rz
        B6PElv0XWCESxhL7l05mAjmIWUBTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIs
        cfnBXSYIW1JicXsn2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCE+TY3sQITrVa
        FjsY95zzOcQowMGoxMMrsfBUrBBrYllxZe4hRgkOZiUR3h0VJ2KFeFMSK6tSi/Lji0pzUosP
        MZoCA3sis5Rocj4wD+SVxBuaGhkbG1uYGJqZGhoqifM6Ll8aKySQnliSmp2aWpBaBNPHxMEp
        1cBYtEAmZMbRD0t6BHs+lz05s2ul43wlceles7tbbryoqs2uzloTF3jqwZc/uRz98z1T/AKK
        dgnGXt0uw2dz06Q6/9zz2xbxlx0Py06OX9ah8bVr9v+z2hsSGF68MjoXoLf+xYTa5CV9/rP7
        gpZ/NeB4lPzLI6TbdSNT4FbhhKbIe+HXi2fsje9WYinOSDTUYi4qTgQA2atK3MsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvG5w2ulYgyl3RCw2zljPanH+/AZ2
        ixV3P7JaXN41h83ic+8RRosZ5/cxWaw9cpfd4vOGx4wWtxtXsFmcOX2J1YHLY3bDRRaPTas6
        2Tw2vtvB5LHlajuLR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGX8unqfpeC+YsW+J3uZGhif
        y3QxcnJICJhI/Dt1mbWLkYtDSGA3o8SXXe+ZIBKSEtMuHmXuYuQAsoUlDh8uhqh5yyhx+shN
        ZpAaYYFgiQcvZrOC1IgI5Ek8PpoPUsMssIdJ4tSCvSwQDRMZJZ58+cMO0sAmoCWx/8UNNhCb
        X0BR4uqPx4wgNq+AncS9j5PA4iwCqhJXjh4Hi4sKREg8334DqkZQ4uTMJywgNidQ/fqpV8Bs
        ZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9Nxi
        wwKjvNRyveLE3OLSvHS95PzcTYzguNPS2sF44kT8IUYBDkYlHt4D807FCrEmlhVX5h5ilOBg
        VhLh3VFxIlaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD
        I1+s4alDG4o2yqbxXouN9LiuweosqKOyYPtV4+4/VQd/6L5sjbD+/V+stmmuDrv4uXO7zRc0
        JATv5FwWqrP9U3y+4lOVlXs84uYIRYQmNC6t9UqU/51gdqU/77S14w3v6juLDRbckbW3EL6x
        cIHk9M4P+yZoP9z0gK/5aPHrvVdbHS/9YZaMV2Ipzkg01GIuKk4EAJnmvsK3AgAA
X-CMS-MailID: 20191113021131epcas1p39305d20a91b1c8e31daea0a90875d285
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191112104809eucas1p14d5d364021a359861788472b513e43e5
References: <CGME20191112104809eucas1p14d5d364021a359861788472b513e43e5@eucas1p1.samsung.com>
        <20191112104734.31074-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

Could you take this patch directly into linux-pm.git for v5.5-rc1?

Because the devfreq pull-request for v5.5-rc1 contained issue. This patch
fix the issue of following patch[1].
[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=2abb0d5268ae7b5ddf82099b1f8d5aa8414637d4


---
Hi Marek,

Thanks for the fixup.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi


On 11/12/19 7:47 PM, Marek Szyprowski wrote:
> Commit 2abb0d5268ae ("PM / devfreq: Lock devfreq in trans_stat_show")
> revealed a missing locking while calling devfreq_update_status() function
> during suspend/resume cycle.
> 
> Code analysis revealed that devfreq_set_target() function was called
> without needed locks held for setting device specific suspend_freq if such
> has been defined. This patch fixes that by adding the needed locking, what
> fixes following kernel warning on Exynos4412-based OdroidU3 board during
> system suspend:
> 
> PM: suspend entry (deep)
> Filesystems sync: 0.002 seconds
> Freezing user space processes ... (elapsed 0.001 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1385 at drivers/devfreq/devfreq.c:204 devfreq_update_status+0xc0/0x188
> Modules linked in:
> CPU: 2 PID: 1385 Comm: rtcwake Not tainted 5.4.0-rc6-next-20191111 #6848
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0112588>] (unwind_backtrace) from [<c010e070>] (show_stack+0x10/0x14)
> [<c010e070>] (show_stack) from [<c0afb010>] (dump_stack+0xb4/0xe0)
> [<c0afb010>] (dump_stack) from [<c01272e0>] (__warn+0xf4/0x10c)
> [<c01272e0>] (__warn) from [<c01273a8>] (warn_slowpath_fmt+0xb0/0xb8)
> [<c01273a8>] (warn_slowpath_fmt) from [<c07d105c>] (devfreq_update_status+0xc0/0x188)
> [<c07d105c>] (devfreq_update_status) from [<c07d2d70>] (devfreq_set_target+0xb0/0x15c)
> [<c07d2d70>] (devfreq_set_target) from [<c07d3598>] (devfreq_suspend+0x2c/0x64)
> [<c07d3598>] (devfreq_suspend) from [<c05de0b0>] (dpm_suspend+0xa4/0x57c)
> [<c05de0b0>] (dpm_suspend) from [<c05def74>] (dpm_suspend_start+0x98/0xa0)
> [<c05def74>] (dpm_suspend_start) from [<c0195b58>] (suspend_devices_and_enter+0xec/0xc74)
> [<c0195b58>] (suspend_devices_and_enter) from [<c0196a20>] (pm_suspend+0x340/0x410)
> [<c0196a20>] (pm_suspend) from [<c019480c>] (state_store+0x6c/0xc8)
> [<c019480c>] (state_store) from [<c033fc50>] (kernfs_fop_write+0x10c/0x228)
> [<c033fc50>] (kernfs_fop_write) from [<c02a6d3c>] (__vfs_write+0x30/0x1d0)
> [<c02a6d3c>] (__vfs_write) from [<c02a9afc>] (vfs_write+0xa4/0x180)
> [<c02a9afc>] (vfs_write) from [<c02a9d58>] (ksys_write+0x60/0xd8)
> [<c02a9d58>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xed3d7fa8 to 0xed3d7ff0)
> ...
> irq event stamp: 9667
> hardirqs last  enabled at (9679): [<c0b1e7c4>] _raw_spin_unlock_irq+0x20/0x58
> hardirqs last disabled at (9698): [<c0b16a20>] __schedule+0xd8/0x818
> softirqs last  enabled at (9694): [<c01026fc>] __do_softirq+0x4fc/0x5fc
> softirqs last disabled at (9719): [<c012fe68>] irq_exit+0x16c/0x170
> ---[ end trace 41ac5b57d046bdbc ]---
> ------------[ cut here ]------------
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 94fb8e821e12..65a4b6cf3fa5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -957,7 +957,9 @@ int devfreq_suspend_device(struct devfreq *devfreq)
>  	}
>  
>  	if (devfreq->suspend_freq) {
> +		mutex_lock(&devfreq->lock);
>  		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> +		mutex_unlock(&devfreq->lock);
>  		if (ret)
>  			return ret;
>  	}
> @@ -985,7 +987,9 @@ int devfreq_resume_device(struct devfreq *devfreq)
>  		return 0;
>  
>  	if (devfreq->resume_freq) {
> +		mutex_lock(&devfreq->lock);
>  		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
> +		mutex_unlock(&devfreq->lock);
>  		if (ret)
>  			return ret;
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
