Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0429194
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 09:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfEXHNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 03:13:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57998 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbfEXHNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 03:13:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190524071333epoutp0332052f441e0de85ce9bf1e253325e497~hjQiRwo9H0030500305epoutp03J
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2019 07:13:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190524071333epoutp0332052f441e0de85ce9bf1e253325e497~hjQiRwo9H0030500305epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558682014;
        bh=qHcHBe29KfVJlkGeOaVQYic7IdQg4WUquSZW9hu1FOc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DhRUXktWpnmF+d18gjm+X8h8wjZ4+kGfuz4J44gjJnWDDXLiFXfUJIvCQxUEou5eF
         Ydnq2a7P6Lp7/wL6Qb1qIEMgJHVUoZHsshLHGKwQ/phyx/UNpDLV/KZagm5SjBiGK2
         Ab+UfjJcck6Qaoo+hYvP9fK1WSgQbEOCpZt/HGPk=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190524071330epcas1p32150a33c996824caf5dded0874fe2673~hjQfPwl-10710107101epcas1p3t;
        Fri, 24 May 2019 07:13:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.AC.04143.89997EC5; Fri, 24 May 2019 16:13:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190524071327epcas1p269a31439bb71461d1e791912145845b1~hjQcmUtG61933819338epcas1p2q;
        Fri, 24 May 2019 07:13:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190524071327epsmtrp1c57280395862a164b2779a2cefc846d8~hjQclXQkf1430014300epsmtrp13;
        Fri, 24 May 2019 07:13:27 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-b6-5ce79998e70e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.32.03692.79997EC5; Fri, 24 May 2019 16:13:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190524071327epsmtip17ae3bbd2420fa3a689e0618d83a7cea5~hjQcXA2YO0920909209epsmtip1L;
        Fri, 24 May 2019 07:13:27 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: try_then_request_governor should not
 return NULL
To:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9c63ac15-9917-7adc-3ef8-3e44060797bd@samsung.com>
Date:   Fri, 24 May 2019 16:15:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523215853.16622-1-robdclark@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmge6Mmc9jDFo3C1mcbXrDbjFx/1l2
        i8u75rBZfO49wmhxu3EFm8W1n4+ZLZ4v/MHswO4xu+Eii8fOWXfZPfq2rGL0+LxJLoAlKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xsV/
        z5gKWuQqjjR8YGlgvCvexcjJISFgIrHrfhd7FyMXh5DADkaJD9d6oJxPjBLnG9ewQTjfGCU+
        nt7PCtOybfVuVojEXkaJF783QlW9Z5S4uKYdqJ+DQ1ggVOLuBHmQBhEBJ4mGG0+YQWqYBbYx
        Smza2Aw2iU1AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iYkdF1lAbBYBVYmfU9Yyg9iiAhES949t
        YIWoEZQ4OfMJWA2ngKXEhlt3wWxmAXGJW0/mM0HY8hLNW2eDLZYQeM0mcebOEzaQ4yQEXCTe
        7qmB+EZY4tXxLewQtpTEy/42KLtaYuXJI2wQvR2MElv2X4B631hi/9LJTCBzmAU0Jdbv0ocI
        K0rs/D2XEWIvn8S7rz2sEKt4JTrahCBKlCUuP7jLBGFLSixu72SbwKg0C8k3s5B8MAvJB7MQ
        li1gZFnFKJZaUJybnlpsWGCMHNubGMGpU8t8B+OGcz6HGAU4GJV4eB80PosRYk0sK67MPcQo
        wcGsJMIbux8oxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBaT2vJN7Q1MjY2NjCxNDM1NBQ
        SZw3nvtmjJBAemJJanZqakFqEUwfEwenVAOj+teZ+jdrbNZlvOEuDmVOdom1b3fVz/pnv8j9
        /fwko1dLRerEzZbP+67bmdD2/frWgLQv/u7lqtvz/Vle96k+3l+sNTPabIXD23LRpnPzth+4
        bBh/IfFhRM6yd/VTa6ZeZbvqwDGHiWFz97TZLZ82br8/SdE58Pk9dR3j1pM1ly7+NjdsObxS
        iaU4I9FQi7moOBEArHLjObMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTnf6zOcxBhPf6lqcbXrDbjFx/1l2
        i8u75rBZfO49wmhxu3EFm8W1n4+ZLZ4v/MHswO4xu+Eii8fOWXfZPfq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSvj4r9nTAUtchVHGj6wNDDeFe9i5OSQEDCR2LZ6N2sXIxeHkMBuRomrd+8w
        QiQkJaZdPMrcxcgBZAtLHD5cDFHzllHi/szDLCA1wgKhElOW9YLViwg4STTceMIMUsQssINR
        4s3q6SwQHT2MEtvfbwTrYBPQktj/4gYbiM0voChx9cdjsG5eATuJiR0XwWpYBFQlfk5Zywxi
        iwpESJx5v4IFokZQ4uTMJ2A2p4ClxIZbd8FsZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAo
        PAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwHGlp7mC8
        vCT+EKMAB6MSD++DxmcxQqyJZcWVuYcYJTiYlUR4Y/cDhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBsPTDDR3Ox+e3OK88PRyxwi2MQu5xgFHfGW11n
        cayQxI/pd7gFZvDJ7zMRTqt3nLeB5/hn2eRyTY83lqo/ZKwE7384e5c58s6uNaeYnP+UX39Z
        rLH1Iv/W5F0LKo+dD7N4c0WtXD33vLuKccbO5CVnkt7uDU06MfP4pI9lZ7Y07VJT+Ju03tpL
        iaU4I9FQi7moOBEAFx+jUZ8CAAA=
X-CMS-MailID: 20190524071327epcas1p269a31439bb71461d1e791912145845b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190523215902epcas5p40e3aca0efb342c8d778529fef416c3fd
References: <CGME20190523215902epcas5p40e3aca0efb342c8d778529fef416c3fd@epcas5p4.samsung.com>
        <20190523215853.16622-1-robdclark@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This issue[1] is already fixed on latest linux.git 
You can check it. Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b53b0128052ffd687797d5f4deeb76327e7b5711

Regards,
Chanwoo Choi


On 19. 5. 24. 오전 6:58, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The two spots it is called expect either an IS_ERR() or a valid pointer,
> but not NULL.
> 
> Fixes this crash that I came across:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
>    Mem abort info:
>      ESR = 0x96000005
>      Exception class = DABT (current EL), IL = 32 bits
>      SET = 0, FnV = 0
>      EA = 0, S1PTW = 0
>    Data abort info:
>      ISV = 0, ISS = 0x00000005
>      CM = 0, WnR = 0
>    [0000000000000030] user address but active_mm is swapper
>    Internal error: Oops: 96000005 [#1] PREEMPT SMP
>    Modules linked in:
>    Process kworker/2:1 (pid: 212, stack limit = 0x(____ptrval____))
>    CPU: 2 PID: 212 Comm: kworker/2:1 Not tainted 5.1.0-43338-g460e6984675c-dirty #54
>    Hardware name: Google Cheza (rev3+) (DT)
>    Workqueue: events deferred_probe_work_func
>    pstate: 00c00009 (nzcv daif +PAN +UAO)
>    pc : devfreq_add_device+0x2e4/0x410
>    lr : devfreq_add_device+0x2d4/0x410
>    sp : ffffff8013d93740
>    x29: ffffff8013d93790 x28: ffffffc0f54f8670
>    x27: 0000000000000001 x26: 0000000000000007
>    x25: ffffff80124abfd8 x24: 0000000000000000
>    x23: ffffffc0fabc4048 x22: ffffffc0fabc4388
>    x21: ffffffc0fabc4010 x20: ffffffc0fa243010
>    x19: ffffffc0fabc4000 x18: 0000000091c3d373
>    x17: 0000000000000400 x16: 000000000000001a
>    x15: 000000019e06d400 x14: 0000000000000001
>    x13: 0000000000000000 x12: 00000000000006b6
>    x11: 0000000000000000 x10: 0000000000000000
>    x9 : ffffffc0fa18ba00 x8 : 0000000000000000
>    x7 : 0000000000000000 x6 : ffffff80127a3d9a
>    x5 : ffffff8013d93550 x4 : 0000000000000000
>    x3 : 0000000000000000 x2 : 0000000000000000
>    x1 : 00000000000000fe x0 : 0000000000000000
>    Call trace:
>     devfreq_add_device+0x2e4/0x410
>     devm_devfreq_add_device+0x64/0xac
>     msm_gpu_init+0x320/0x5c0
>     adreno_gpu_init+0x21c/0x274
>     a6xx_gpu_init+0x68/0xf4
>     adreno_bind+0x158/0x284
>     component_bind_all+0x110/0x204
>     msm_drm_bind+0x118/0x5b8
>     try_to_bring_up_master+0x15c/0x19c
>     component_master_add_with_match+0xb4/0xec
>     msm_pdev_probe+0x1f0/0x27c
>     platform_drv_probe+0x90/0xb0
>     really_probe+0x120/0x298
>     driver_probe_device+0x64/0xfc
>     __device_attach_driver+0x8c/0xa4
>     bus_for_each_drv+0x88/0xd0
>     __device_attach+0xac/0x134
>     device_initial_probe+0x20/0x2c
>     bus_probe_device+0x34/0x90
>     deferred_probe_work_func+0x74/0xac
>     process_one_work+0x210/0x428
>     worker_thread+0x278/0x3e4
>     kthread+0x120/0x130
>     ret_from_fork+0x10/0x18
>    Code: aa0003f8 b13ffc1f 54000762 f901c278 (f9401b08)
>    ---[ end trace a6ecc18ce5894375 ]---
>    Kernel panic - not syncing: Fatal exception
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..d29f66f0e52a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  		/* Restore previous state before return */
>  		mutex_lock(&devfreq_list_lock);
>  		if (err)
> -			return NULL;
> +			return ERR_PTR(err);
>  
>  		governor = find_devfreq_governor(name);
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
