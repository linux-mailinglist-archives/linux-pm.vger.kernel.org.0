Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419D1CEE9C
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgELH41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 03:56:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39753 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgELH41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 03:56:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200512075623epoutp015826c24278e1936eb6649dad486d65e0~OOM-bfcKG1514915149epoutp01o
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 07:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200512075623epoutp015826c24278e1936eb6649dad486d65e0~OOM-bfcKG1514915149epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589270183;
        bh=DEqy8ozNTk3fR/BT9xkRbnIvwaU9IqqbHjW3XT7ouCI=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=m6gGwvf0mCYP30oLAatibfnoy1Z7qrI2QDZgqv79rh6bc+QRMh6pmjnppL/fOYaJP
         S8gIFk8IVmGivTgwECaAXtiFhUyoRMlqOehV/fz+Xllg4ASfpXoEVF8wNS/xhAmwQ6
         UlLc/ImjZQ8SjePxlcm6VRQYr6Di2B0o2O2tH6+Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200512075623epcas1p4ed7c6f52c91f916934dbd328e66e6cb0~OOM-HTczd0206002060epcas1p4M;
        Tue, 12 May 2020 07:56:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49Lqr54MhMzMqYm3; Tue, 12 May
        2020 07:56:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.CB.04648.1A65ABE5; Tue, 12 May 2020 16:56:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200512075617epcas1p3a9e9ffd6d719bf40ecb896318392166f~OOM5czL2O1307913079epcas1p3e;
        Tue, 12 May 2020 07:56:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512075617epsmtrp2015c83ab91834b2e82bc38e773cdda42~OOM5bxW362996129961epsmtrp2Z;
        Tue, 12 May 2020 07:56:17 +0000 (GMT)
X-AuditID: b6c32a37-7215a9e000001228-41-5eba56a1d8a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.BF.18461.1A65ABE5; Tue, 12 May 2020 16:56:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200512075617epsmtip2f70baffe6c18a0c8ac361984f2845228~OOM5RtRfn2865128651epsmtip2_;
        Tue, 12 May 2020 07:56:17 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Use lockdep asserts instead of manual checks
 for locked mutex
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b758daaa-aa7a-30a6-5947-395ff30da66a@samsung.com>
Date:   Tue, 12 May 2020 17:06:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200512064158.7957-1-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmge6isF1xBpP2M1qcP7+B3eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx6ZVnWwefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ2xbuZr9oInYhUfJs1kaWDcI9TF
        yMkhIWAi8WHNaeYuRi4OIYEdjBKT7l6Dcj4xStxaMp0VwvnGKPHuxTQmmJa5U5eyQCT2Mkqs
        WLkHquU9o8T7RhCHk0NYIFZi058DTCAJEYGdjBJt3RfAEmwCWhL7X9xgA7H5BRQlrv54zAhi
        8wrYSby5/wXMZhFQlXja/B5snahAmMTJbS1QNYISJ2c+YQGxOYHOeHh1CyuIzSwgLnHryXwm
        CFteYvvbOWAXSQi8ZZdYdOotK8TdLhIzpnVB2cISr45vYYewpSQ+v9vLBmFXS6w8eYQNormD
        UWLL/gtQDcYS+5dOBtrAAbRBU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEGDWFlicsP
        7kKDTlJicXsn1CoPiXer+5gnMCrOQvLaLCTvzELyziyExQsYWVYxiqUWFOempxYbFhgjx/cm
        RnCC1DLfwbjhnM8hRgEORiUe3g6jnXFCrIllxZW5hxglOJiVRHhbMoFCvCmJlVWpRfnxRaU5
        qcWHGE2BIT+RWUo0OR+YvPNK4g1NjYyNjS1MDM1MDQ2VxHmnXs+JExJITyxJzU5NLUgtgulj
        4uCUamCUW6ZaHeVu0xK4yKbwtsvFRpsF60/NnDXl+XPpTWu5D03ZXrpUevXDejvm4BkPUg9t
        UXweeTrlZK5VoM3cTocXwbrNIaa27+P2/F/ennxCuM9h19MkiyXnz/gb9f1RPDH50Mr1q/4Z
        3OtQS7trsdB7okac9+sbFc3VtW2/LY413nc9sn6WlKq4EktxRqKhFnNRcSIAG4+od6YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvO7CsF1xBmuXSFicP7+B3eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbFu5mv2
        gidiFR8mzWRpYNwj1MXIySEhYCIxd+pSli5GLg4hgd2MEt0NTcwQCUmJaRePAtkcQLawxOHD
        xRA1bxklZvT+YQKpERaIlVi/bhMjSEIEpPnL4U5miKp2Rok/XX8ZQarYBLQk9r+4wQZi8wso
        Slz98RgszitgJ/Hm/hcwm0VAVeJp83uwqaICYRI7lzxmgqgRlDg58wkLiM0JdOrDq1tYQWxm
        AXWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLD
        AsO81HK94sTc4tK8dL3k/NxNjOCI0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeFsyd8YJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES571RuDBOSCA9sSQ1OzW1ILUIJsvEwSnVwCTfL3XzoG5vfMfEe/Xn
        +K6r8iwuOZtyNUsgW/enzEMBYUXOjn1f7yzj4DMqueU7oynyocomM3Gps5PvRBy5k6xYXPn+
        6rzLGipN2lHRC7gCH/qvUnaNYJP3fOS5zHjDibgdIjwHe6OkY25Gz7umyauQHHfq595JFatn
        XWBwXcjeM817y6z4Y4WJogdSlDjnVtU1mz75NNN++4P8Cc/fR7hNuHX8qPuTp2u7WGTNgxqm
        Ce1MDFFbsUZQ+8Q7pzRvh2omY+bbXDrTTXesDJ1pH8lgfnKStMTTt002xxLc/a5mnmflrv2v
        pX7k7mmR3XmZPNdYAwrZP26NC9z3ny3LKdyDae6zO52M7A2HnnCnKLEUZyQaajEXFScCAEhb
        m4L3AgAA
X-CMS-MailID: 20200512075617epcas1p3a9e9ffd6d719bf40ecb896318392166f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200512064211epcas1p1f8e6cac8f2927bd703e133282313dd43
References: <CGME20200512064211epcas1p1f8e6cac8f2927bd703e133282313dd43@epcas1p1.samsung.com>
        <20200512064158.7957-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 5/12/20 3:41 PM, Krzysztof Kozlowski wrote:
> Instead of warning when mutex_is_locked(), just use the lockdep
> framework.  The code is smaller and checks could be disabled for
> production environments (it is useful only during development).
> 
> Put asserts at beginning of function, even before validating arguments.
> 
> The behavior of update_devfreq() is now changed because lockdep assert
> will only print a warning, not return with EINVAL.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/devfreq.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ef3d2bc3d1ac..52b9c3e141f3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -60,12 +60,12 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  {
>  	struct devfreq *tmp_devfreq;
>  
> +	lockdep_assert_held(&devfreq_list_lock);
> +
>  	if (IS_ERR_OR_NULL(dev)) {
>  		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	WARN(!mutex_is_locked(&devfreq_list_lock),
> -	     "devfreq_list_lock must be locked.");
>  
>  	list_for_each_entry(tmp_devfreq, &devfreq_list, node) {
>  		if (tmp_devfreq->dev.parent == dev)
> @@ -258,12 +258,12 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  {
>  	struct devfreq_governor *tmp_governor;
>  
> +	lockdep_assert_held(&devfreq_list_lock);
> +
>  	if (IS_ERR_OR_NULL(name)) {
>  		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	WARN(!mutex_is_locked(&devfreq_list_lock),
> -	     "devfreq_list_lock must be locked.");
>  
>  	list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
>  		if (!strncmp(tmp_governor->name, name, DEVFREQ_NAME_LEN))
> @@ -289,12 +289,12 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	struct devfreq_governor *governor;
>  	int err = 0;
>  
> +	lockdep_assert_held(&devfreq_list_lock);
> +
>  	if (IS_ERR_OR_NULL(name)) {
>  		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	WARN(!mutex_is_locked(&devfreq_list_lock),
> -	     "devfreq_list_lock must be locked.");
>  
>  	governor = find_devfreq_governor(name);
>  	if (IS_ERR(governor)) {
> @@ -392,10 +392,7 @@ int update_devfreq(struct devfreq *devfreq)
>  	int err = 0;
>  	u32 flags = 0;
>  
> -	if (!mutex_is_locked(&devfreq->lock)) {
> -		WARN(true, "devfreq->lock must be locked by the caller.\n");
> -		return -EINVAL;
> -	}
> +	lockdep_assert_held(&devfreq->lock);
>  
>  	if (!devfreq->governor)
>  		return -EINVAL;
> 

It is reasonable. It looks good.
Applied it. Thank


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
