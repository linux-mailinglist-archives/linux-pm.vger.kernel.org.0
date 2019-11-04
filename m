Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BFED7C9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 03:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfKDCmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 21:42:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55249 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfKDCme (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 21:42:34 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191104024230epoutp01437b5267b8778b58ae56868df730a96b~T1WsVWcZV2804928049epoutp01V
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 02:42:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191104024230epoutp01437b5267b8778b58ae56868df730a96b~T1WsVWcZV2804928049epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572835350;
        bh=Rs2gEr8eGJ5NgzXa3Z0pO2e5Rj3/ugs6+FpAD8JnSL8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A367mhJllYVA47d955aMXaiWsl72lm9dwD3FcpNygbbdPA5GAWKn+A/VzTpIWV1XW
         BURELkgvcYsS9OnC8VcehijtRCcv8uZHaIN8ByWe/hN/aireIL36lIoIevZ5lskd1d
         wiov518ny4Y5p+L9UvfD+TtOTL5lWsC1y8nrx6kU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191104024230epcas1p4da07407c569c3a29abf3a6639ac27e44~T1Wr2XrJX0777807778epcas1p4N;
        Mon,  4 Nov 2019 02:42:30 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 475xsc19kszMqYkb; Mon,  4 Nov
        2019 02:42:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.94.04144.4109FBD5; Mon,  4 Nov 2019 11:42:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191104024227epcas1p3b97700a2c0993f70ac93b96c58520cd7~T1WpbadNn2000620006epcas1p3A;
        Mon,  4 Nov 2019 02:42:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191104024227epsmtrp14ad00803c4709fc7224f4457988104a0~T1Wpamahp2085620856epsmtrp1k;
        Mon,  4 Nov 2019 02:42:27 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-65-5dbf90143a97
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.AD.25663.3109FBD5; Mon,  4 Nov 2019 11:42:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191104024227epsmtip28530c548515f2a0d7914e5256be9fdf4~T1WpJe-Lc0256902569epsmtip2v;
        Mon,  4 Nov 2019 02:42:27 +0000 (GMT)
Subject: Re: [PATCH v8 15/18] PM / devfreq: Add new interrupt_driven flag
 for governors
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f86d35dc-1749-ad29-2023-7d69366bd0d1@samsung.com>
Date:   Mon, 4 Nov 2019 11:48:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103204130.2172-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TeUzTcBTOry1dUae1gjyXqFjxD1BwFYeditGIOgMxJMZETQg00DDC1i3t
        5hkTFcNhxAv/wHoj3lGMIgEMTMeCDkVR4i1eEBUv4gHxiNGVYuS/7733fe+973dQONNAmqg8
        ySPKkuBgySFETVOsOT5ipy/DrF6n+DOfOxG/Ra0g+NbNHwx8e/1+kv9aGkB8yTeV5PvetCD+
        yaaTJN/6OpX/UX+Q4LefvUvOHWqr7ahEtjq1w2ArLfhE2tTCRtK2vfo0sn29MC6dXJk/2y4K
        OaIcLUrZrpw8KTeZTV2aOT/TkmTm4jkrP4ONlgSnmMympKXHL8xzhNZjo1cJDm8olS4oCjt1
        zmzZ5fWI0XaX4klmRXeOw211JyiCU/FKuQnZLudMzmyeZgkRs/LtN2/VYO5Hk9b0bNqFb0Tf
        xm5F4RTQ02G3vwXfioZQDF2L4Mb9soHgC4KKYBXSWAzdh6D+Z/w/RdufZwad1BAiNb/A9KAH
        wfP7+8M01ih6Bbw/0k5ohQi6C4OGwBZCK+ChQlPdGUzDJB0HvrcPSQ2PoCfAve+d/eOM9Bw4
        7g8aNEzQMXDx/NXQThQVSS+HG72CThkJwb1d/S3D6SRo6tyB6+2j4HHXIUzH46Hg0r5+O0CX
        GaCjptigW0iBK52VYToeBe+uVQ/kTdC9o3AAr4dTwQCpi4sRVPvaBgSJ4DtWhmkL4XQsVNVP
        1dMToO7XAaQPHg6fereFaRSgjVBcyOiUidD+ogPT8Rg4WlRC7kSsOsiOOsiCOsiC+n/YYUSc
        RqNFt+LMFRXOzQ2+7Quo/+nGWWrRnltpfkRTiB1mfBvuy2DChFXKWqcfAYWzEcY75Q0ZjDFH
        WLtOlF2ZstchKn5kCR32LtwUme0KfQTJk8lZpiUmJvLTuSQLx7FRxnknjmUwdK7gEfNF0S3K
        /3QYFW7aiLJsZfaodglrvD0easZ2S09GPzet9sjD2SuLqj5mLZlVenLKocWXP/hbK4733UtY
        c+d3FXk3Apt4rusmc76SWnD0u7c8ELthETHrQdG5Z3KR++WkZT2eyBWT38TMbLOCFSX3NgeW
        BctjHqVNLmdqi0Zgh1NTFnYTJU+bXykFLY1WllDsAheHy4rwF5vwg23QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK7whP2xBg+/yFus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFt+en2K0uN24gs3i7DNvi5+75rFY9K29xObA7bHj7hJG
        j52z7rJ79Da/Y/OY1baPzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyzpzbxlRwU7XifeNE
        5gbGL7JdjJwcEgImEhf+32PvYuTiEBLYzSix6OhWNoiEpMS0i0eZuxg5gGxhicOHiyFq3jJK
        nDn2lhWkRlggUuJz/0dGkISIwDMmiYV7dzKBJJiBEj1zt7BBdGxhlNi4fA/YVDYBLYn9L26A
        2fwCihJXfzxmBLF5Bewklh06yQ5iswioSGzecJAZxBYViJB4vv0GVI2gxMmZT1hAbE4BM4nD
        j/uZIZapS/yZdwnKFpe49WQ+1BHyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzgCtbR2MJ44EX+IUYCDUYmH9wXn/lgh1sSy4srcQ4wS
        HMxKIrwXZ+yNFeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp
        1cCo+kfLPu9mRdNCnVL5p99MdWzqJcvWJljk7m74PjVv6lR9l0mq+f8NlQ+/3bPXVS/DemWd
        eGGDudKSWRsm1C++lDu5Lqzr4Zf/2zM2Sm2rEPorlXHunKZOKa/rVhaxc6aaZicnhW0JVshb
        53D/4Fvmw0HlDfOdti1i2Wuif+C/fPH141Kye9KUWIozEg21mIuKEwG94ZJOvAIAAA==
X-CMS-MailID: 20191104024227epcas1p3b97700a2c0993f70ac93b96c58520cd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191103204257epcas1p4ce6f9ae729ed6cf6df1816237c80ee45
References: <20191103204130.2172-1-digetx@gmail.com>
        <CGME20191103204257epcas1p4ce6f9ae729ed6cf6df1816237c80ee45@epcas1p4.samsung.com>
        <20191103204130.2172-16-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Sorry for the additional comment of this patch.
I think that you better to change the 'interrupt_driven' checking
style as following in order to keep the consistency of governor
flag checking style.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 27de8ddeaaa8..fe409fc1bcc4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -410,9 +410,11 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
+       if (devfreq->governor->interrupt_driven)
+               return;
+
        INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
        if (devfreq->profile->polling_ms &&
-           !devfreq->governor->interrupt_driven)
                queue_delayed_work(devfreq_wq, &devfreq->work,
                        msecs_to_jiffies(devfreq->profile->polling_ms));
 }
@@ -475,12 +477,15 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
        if (!devfreq->stop_polling)
                goto out;
 
+       if (devfreq->governor->interrupt_driven)
+               goto out_update;
+
        if (!delayed_work_pending(&devfreq->work) &&
                        devfreq->profile->polling_ms &&
-                       !devfreq->governor->interrupt_driven)
                queue_delayed_work(devfreq_wq, &devfreq->work,
                        msecs_to_jiffies(devfreq->profile->polling_ms));
 
+out_update:
        devfreq->last_stat_updated = jiffies;
        devfreq->stop_polling = false;


If you edit it as following, feel free to add my reviewed-by tag:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


On 19. 11. 4. 오전 5:41, Dmitry Osipenko wrote:
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
>  drivers/devfreq/devfreq.c  | 9 +++++++--
>  drivers/devfreq/governor.h | 3 +++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b905963cea7d..a711a76d386e 100644
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
> +			!devfreq->governor->interrupt_driven)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> @@ -509,6 +511,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  	if (devfreq->stop_polling)
>  		goto out;
>  
> +	if (devfreq->governor->interrupt_driven)
> +		goto out;
> +
>  	/* if new delay is zero, stop polling */
>  	if (!new_delay) {
>  		mutex_unlock(&devfreq->lock);
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
