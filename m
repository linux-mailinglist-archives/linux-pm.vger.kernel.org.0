Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35233EBE72
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 08:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfKAH0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 03:26:50 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41191 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfKAH0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 03:26:50 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191101072645epoutp02aea3f85443883e022ad595bc077d2494~S_TA0n65-2501525015epoutp02w
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 07:26:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191101072645epoutp02aea3f85443883e022ad595bc077d2494~S_TA0n65-2501525015epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572593205;
        bh=jQAgCzuy+kdb/X+nCucRoRBAFQWp4ERYDsJgkKZl/MA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U9zJVZTsaI5EhB2evibBqg5SnSi4mL3mzOGwZa7nEOT89pkaullPpqjBrTXCrREzf
         nGDFMJs6DXnumLEhdX4VN8aSirTKZOlTobPxNnHFm5x3nvrTnY9a49bFF45cRD2m82
         uVuAN240a5tjTDapDYKOz1R4MyJXne5f5LxABulQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191101072644epcas1p109dff07b66c800938443f406dcc173dc~S_S-vd_aL2868228682epcas1p1T;
        Fri,  1 Nov 2019 07:26:44 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 474DJx0r1HzMqYkW; Fri,  1 Nov
        2019 07:26:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.84.04068.F2EDBBD5; Fri,  1 Nov 2019 16:26:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191101072639epcas1p2831a8bf9afbac074a17d1a474498f2ba~S_S7dfhXe1126211262epcas1p2_;
        Fri,  1 Nov 2019 07:26:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191101072639epsmtrp15440c3fa3235d5e2bffb2d303b72cbb7~S_S7cp3ol0786707867epsmtrp1S;
        Fri,  1 Nov 2019 07:26:39 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-55-5dbbde2fcb32
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.BB.24756.F2EDBBD5; Fri,  1 Nov 2019 16:26:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191101072639epsmtip1ffb5383632e9f34b0c60fdd01528b9a6~S_S7RFCt40558205582epsmtip15;
        Fri,  1 Nov 2019 07:26:39 +0000 (GMT)
Subject: Re: [PATCH v7 16/19] PM / devfreq: Add new interrupt_driven flag
 for governors
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a4caf25c-5907-6347-f4d7-37800a077f29@samsung.com>
Date:   Fri, 1 Nov 2019 16:32:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-17-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmga7Bvd2xBveqLFZ/fMxo0TJrEYvF
        2aY37BaXd81hs/jce4TRovPLLDaL240r2CzOPvO2+LlrHotF39pLbA5cHjvuLmH02DnrLrtH
        b/M7No++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1ya
        l66XnJ9rZWhgYGQKVJiQnbHjbwNjwR+1imurJrA0MK6X72Lk5JAQMJGY8+40cxcjF4eQwA5G
        icuHmtghnE+MEtt3vGSEcL4xSpz8fgWojAOsZeu9OIj4XqCO77ehOt4zSjxsvcMIMldYIFLi
        8NYvLCAJEYFFTBJrj25nBkkwgyR2rmYCsdkEtCT2v7jBBmLzCyhKXP3xGKyZV8BOore3BayG
        RUBF4sOHbewgm0UFIiROf02EKBGUODnzCQuIzSlgLvFq1WM2iPHiEreezGeCsOUlmrfOBvtN
        QqCZXWLK5i2MEE+7SMzZcZcZwhaWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F1ghEsYS
        +5dOZgI5iFlAU2L9Ln2IsKLEzt9zGSEW80m8+9rDCgktXomONiGIEmWJyw/uMkHYkhKL2zvZ
        JjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIsf2JkZwetWy3MF47JzPIUYBDkYl
        Ht4ZXbtjhVgTy4orcw8xSnAwK4nwbl8HFOJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wNSf
        VxJvaGpkbGxsYWJoZmpoqCTO67h8aayQQHpiSWp2ampBahFMHxMHp1QDo/+6Vf+3dpv+c7qh
        euKEm8CDVr9fJ2aaFVx6a36W31iuumJqreN3o7ULDm6+Ur/QOkou3umJuGRg9Tyv1O2F55/s
        SK55d2XK5az/Z9JXt/36slfQUrGo3b2rzWrZDsEVxzbIei6XKHsRcZrj66/VppV+cXpfVs7x
        uHhY60PwVvMwnwdLefXWCSuxFGckGmoxFxUnAgBrbPvZxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnK7+vd2xBrvuyVms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnH3mbfFz1zwWi761l9gcuDx23F3C6LFz1l12
        j97md2wefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbHjbwNjwR+1imurJrA0MK6X72Lk4JAQ
        MJHYei+ui5GLQ0hgN6PEtsbZ7F2MnEBxSYlpF48yQ9QISxw+XAxR85ZRYuK2rSwgNcICkRI3
        Hu1lBkmICCxhkjj7ZTkzSIIZKNEzdwsbRMc2RomFkztZQRJsAloS+1/cYAOx+QUUJa7+eMwI
        YvMK2En09rYwgdgsAioSHz5sA7tCVCBC4vn2G1A1ghInZz4B28wpYC7xatVjNohl6hJ/5l2C
        WiwucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIEx5qW5g7Gy0viDzEKcDAq8fDO6NodK8SaWFZcmXuIUYKDWUmEd/s6oBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2M9qpihdkaR41v
        3Iu76/XyRlHdvc4mn4lXHwpUzbmoaqHEF/Og2TNammeOnJm13HPf12s8efJKLh5dfyO2xdVJ
        u3uLz/L2M3bbVWcxa2uJMRbIXe7TXJj+sVm4K/CHaGBteNJu7Uw29urLbsnzO5q2XMpeemWJ
        5J/3gfZFFl4LJ95etTcojF2JpTgj0VCLuag4EQBfkj0CsQIAAA==
X-CMS-MailID: 20191101072639epcas1p2831a8bf9afbac074a17d1a474498f2ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220705epcas5p1dc9787952bd19cefe9e0bff592642142
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220705epcas5p1dc9787952bd19cefe9e0bff592642142@epcas5p1.samsung.com>
        <20191029220019.26773-17-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> Currently interrupt-driven governors (like NVIDIA Tegra30 ACTMON governor)
> are used to set polling_ms=0 in order to avoid periodic polling of device
> status by devfreq core. This means that polling interval can't be changed
> by userspace for such governors.
> 
> The new governor flag allows interrupt-driven governors to convey that
> devfreq core shouldn't perform polling of device status and thus generic
> devfreq polling interval could be supported by these governors now.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/devfreq.c  | 14 +++++++++-----
>  drivers/devfreq/governor.h |  3 +++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b905963cea7d..0ef972264841 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -410,7 +410,8 @@ static void devfreq_monitor(struct work_struct *work)
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
>  	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> -	if (devfreq->profile->polling_ms)
> +	if (devfreq->profile->polling_ms &&
> +	    !devfreq->governor->interrupt_driven)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
> @@ -474,7 +475,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  		goto out;
>  
>  	if (!delayed_work_pending(&devfreq->work) &&
> -			devfreq->profile->polling_ms)
> +			devfreq->profile->polling_ms &&
> +				!devfreq->governor->interrupt_driven)

Better to edit it as following for the indentation.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cea05b43225f..60c5540b2a55 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -477,7 +477,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 
        if (!delayed_work_pending(&devfreq->work) &&
                        devfreq->profile->polling_ms &&
-                               !devfreq->governor->interrupt_driven)
+                       !devfreq->governor->interrupt_driven)



>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> @@ -518,8 +520,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  
>  	/* if current delay is zero, start polling with new delay */
>  	if (!cur_delay) {
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> -			msecs_to_jiffies(devfreq->profile->polling_ms));
> +		if (!devfreq->governor->interrupt_driven)
> +			queue_delayed_work(devfreq_wq, &devfreq->work,
> +				msecs_to_jiffies(devfreq->profile->polling_ms));
>  		goto out;
>  	}
>  
> @@ -528,7 +531,8 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  		mutex_unlock(&devfreq->lock);
>  		cancel_delayed_work_sync(&devfreq->work);
>  		mutex_lock(&devfreq->lock);
> -		if (!devfreq->stop_polling)
> +		if (!devfreq->stop_polling &&
> +		    !devfreq->governor->interrupt_driven)
>  			queue_delayed_work(devfreq_wq, &devfreq->work,
>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	}

In the devfreq_interval_update(), you better to modify this function as following:
It is more simple.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d3d12ed0ed29..80acb55d1686 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -510,6 +510,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
        if (devfreq->stop_polling)
                goto out;
 
+       if (!devfreq->governor->interrupt_driven)
+               goto out;
+
        /* if new delay is zero, stop polling */
        if (!new_delay) {
                mutex_unlock(&devfreq->lock);



> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index bbe5ff9fcecf..dc7533ccc3db 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -31,6 +31,8 @@
>   * @name:		Governor's name
>   * @immutable:		Immutable flag for governor. If the value is 1,
>   *			this govenror is never changeable to other governor.
> + * @interrupt_driven:	Devfreq core won't schedule polling work for this
> + *			governor if value is set to 1.
>   * @get_target_freq:	Returns desired operating frequency for the device.
>   *			Basically, get_target_freq will run
>   *			devfreq_dev_profile.get_dev_status() to get the
> @@ -49,6 +51,7 @@ struct devfreq_governor {
>  
>  	const char name[DEVFREQ_NAME_LEN];
>  	const unsigned int immutable;
> +	const unsigned int interrupt_driven;
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  	int (*event_handler)(struct devfreq *devfreq,
>  				unsigned int event, void *data);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
