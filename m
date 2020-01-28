Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F814B397
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1Lkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 06:40:42 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:27358 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgA1Lkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 06:40:42 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200128114039epoutp03f21a62df18a5178b8cff8c334fe8d471~uCh0gjsgq3209332093epoutp03-
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 11:40:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200128114039epoutp03f21a62df18a5178b8cff8c334fe8d471~uCh0gjsgq3209332093epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580211639;
        bh=QMDrmWXt12RXGyvNEtNunXcHhgnQQMkNaxgiR4Sx83o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K087k7CVlKB371XpMFsggZ68YnnPh8x424lPBI3vKR3oplADSySFl/qmFh0ZfetZq
         xktPEhaZafN7Y7S8kaNhMI8gcpDC1Av3RZqIkkfEqHNdSqdJwKSxdwLANN0KUGkMZV
         JLYwzTOZ8FcbQ5JMlEa8sP+SsahFWqjZa3iKWc1c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200128114038epcas1p47e7a3ab1d06ad20f9843406e6050f122~uCh0AaOIS2730027300epcas1p45;
        Tue, 28 Jan 2020 11:40:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 486PnJ5KHSzMqYkV; Tue, 28 Jan
        2020 11:40:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.99.57028.4BD103E5; Tue, 28 Jan 2020 20:40:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128114036epcas1p2fa1cce9a08f35b1857f21c830f62c499~uChxjRILF0279102791epcas1p2J;
        Tue, 28 Jan 2020 11:40:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200128114036epsmtrp14a4f00ec90c70195b97b889fe421f1dc~uChxiS5h51860118601epsmtrp1j;
        Tue, 28 Jan 2020 11:40:36 +0000 (GMT)
X-AuditID: b6c32a35-974d39c00001dec4-09-5e301db4b7da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.2C.10238.4BD103E5; Tue, 28 Jan 2020 20:40:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200128114036epsmtip1472fc24ea5995afcbc8a91c9c0aa4336~uChxV3tk30196101961epsmtip18;
        Tue, 28 Jan 2020 11:40:36 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: use constant name of userspace governor
To:     pierre Kuo <vichy.kuo@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <33eac5f8-4cdd-3315-cf82-c5f859dffce7@samsung.com>
Date:   Tue, 28 Jan 2020 20:48:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200123155912.22160-1-vichy.kuo@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTT3eLrEGcwdz56hZnm96wW1zeNYfN
        4nPvEUaL240r2CxezlvB6sDqsXPWXXaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM6YtF6i4Ah7xdGZF9kbGBexdTFy
        ckgImEj82bOcpYuRi0NIYAejxJxPX9kgnE+MEptefgarEhL4xijx7YslTMekC4/ZIYr2Mkps
        m9HBBFH0HsjZowNiCwt4SWw8/JgRxBYRiJb4ce4KC4jNLGAl8fpjNzuIzSagJbH/xQ2wBfwC
        ihJXf0DU8wrYSWz5dR0sziKgKvFu5XWwelGBMImT21qgagQlTs58AjSTg4NTwFLi4ctYiPHi
        EreezGeCsOUltr+dwwxyp4TAGTaJ7vMvmSAecJH4d2ExlC0s8er4FnYIW0riZX8blF0tsfLk
        ETaI5g5GiS37L7BCJIwl9i+dzASymFlAU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEm
        BFGiLHH5wV2otZISi9s72SYwKs1C8s0sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWGCJH9SZG
        cFrUMt3BOOWczyFGAQ5GJR5eict6cUKsiWXFlbmHGCU4mJVEeDuZDOKEeFMSK6tSi/Lji0pz
        UosPMZoCA3sis5Rocj4wZeeVxBuaGhkbG1uYGJqZGhoqifM+jNSMExJITyxJzU5NLUgtgulj
        4uCUamBcGXDf4Dav15LDr32VLoq/36CYquA5YX/Q9Ut2W2PWxax4vCDk6rfX/Zx1rXO0lv75
        2Jx1ZcpVs9NfVt9b0aLC+ItRX7fDNnFb0SOrp4xb9q07l2IstJTv2fc1Jw4VJy9gzPiwb9lB
        Zk1ZO5/eXU0/NmmKbNNZ+T6QY0X4gd4VVxQvHDfYZnBDXomlOCPRUIu5qDgRAHvsFyShAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO4WWYM4g0mHOC3ONr1ht7i8aw6b
        xefeI4wWtxtXsFm8nLeC1YHVY+esu+wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlTFpvUTB
        EfaKozMvsjcwLmLrYuTkkBAwkZh04TF7FyMXh5DAbkaJA+uvsUMkJCWmXTzK3MXIAWQLSxw+
        XAxR85ZRYtHk5YwgNcICXhIbDz8Gs0UEoiXWTZjKCmIzC1hJvP7YDTZHSKCHUeL8DzCbTUBL
        Yv+LG2CL+QUUJa7+gOjlFbCT2PLrOlicRUBV4t3K62D1ogJhEjuXPGaCqBGUODnzCQvIPZwC
        lhIPX8ZCrFKX+DPvEjOELS5x68l8JghbXmL72znMExiFZyHpnoWkZRaSlllIWhYwsqxilEwt
        KM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOEC3NHYyXl8QfYhTgYFTi4ZW4rBcnxJpYVlyZ
        e4hRgoNZSYS3k8kgTog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZ
        Jg5OqQbGiuoM8/PNu89/Nv52SaHaZ8LS05Yptv/P8Xxf8o7ZUW7u7AkS9XZRO5OsV13w5933
        786xjWcd3qnuMjW4bM3T4OEXsnGx8ly9A3Kfp5W87Y0wi555SFfk/7zoiaxq6ScPsR1teqqV
        /ryxouIII/vFghePHgjcPTJ37VNu0dTpXZtvpS8WVZ7+WImlOCPRUIu5qDgRAMB//CiMAgAA
X-CMS-MailID: 20200128114036epcas1p2fa1cce9a08f35b1857f21c830f62c499
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200123155931epcas1p21de0db0e53438c6f326a5b75bbb69307
References: <CGME20200123155931epcas1p21de0db0e53438c6f326a5b75bbb69307@epcas1p2.samsung.com>
        <20200123155912.22160-1-vichy.kuo@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/24/20 12:59 AM, pierre Kuo wrote:
> Based on commit aa7c352f9841 ("PM / devfreq: Define the constant governor
> name"), use constant name for userspace governor.
> 
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/devfreq/governor_userspace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index af94942fcf95..0fd6c4851071 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -131,7 +131,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
>  }
>  
>  static struct devfreq_governor devfreq_userspace = {
> -	.name = "userspace",
> +	.name = DEVFREQ_GOV_USERSPACE,
>  	.get_target_freq = devfreq_userspace_func,
>  	.event_handler = devfreq_userspace_handler,
>  };
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
