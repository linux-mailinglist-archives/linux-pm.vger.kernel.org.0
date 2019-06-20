Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F094C837
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFTHVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:21:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22150 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfFTHVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:21:23 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190620072120epoutp043c87ab649c767dd50c8e0aeeebcc6a98~p1yCWv1Os0597105971epoutp04U
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 07:21:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190620072120epoutp043c87ab649c767dd50c8e0aeeebcc6a98~p1yCWv1Os0597105971epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561015280;
        bh=os5Opt1vHXuzbVX7ni65CJx6YBhbFP5oV31ehq+GL9o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=csV14u2u/2GuS2R72SMg3+SYsyshG1ynKMBEtbjgiZ4swrQ0y9CBXf2Bo4W5H/ArL
         0Xh1Md3gbX3s0tXND9ULGO70FGLGkBbU71YxD8XK/WMmBSLXFwwbua+JiH6soFcdXk
         tA9t9kwbhL3Niyf/JzthAABdN4l6YMl6UpNPEyU8=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190620072120epcas1p1cc0ca73f75f21071ff05f51fb9c61fcb~p1yB_O2TN2047820478epcas1p1D;
        Thu, 20 Jun 2019 07:21:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.F1.04139.0F33B0D5; Thu, 20 Jun 2019 16:21:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190620072119epcas1p3b6a9541ada10046c29cb388db0225cac~p1yBYG_oq0798207982epcas1p3p;
        Thu, 20 Jun 2019 07:21:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190620072119epsmtrp1d087ca699de875ae2df6f3c0ba63e4a0~p1yBXWINZ1936319363epsmtrp1l;
        Thu, 20 Jun 2019 07:21:19 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-70-5d0b33f0c4da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.07.03692.FE33B0D5; Thu, 20 Jun 2019 16:21:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190620072119epsmtip1f1e4dda6e237e3077d604ad8bc6fa955~p1yBMYsIo1378813788epsmtip1G;
        Thu, 20 Jun 2019 07:21:19 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Sanitize prints
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c053eea7-7c7f-a03a-0f09-83cd006a6a3a@samsung.com>
Date:   Thu, 20 Jun 2019 16:23:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605190053.19177-2-ezequiel@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1xd6ctf26pJ/8ouyHUQOd1zaa4iiwTCpIKikrmxV2m7enu
        rKx/ysrSpmkPyGWpWVEW5NaMKdTAJCtJLHtYIoUV9Bg9fERPaNs18r/POb/v93d+5/wOKZSf
        JBLJEquTdVgZM0VEiW7cXqRK+aKOLkhr+hynvTrcjbSd7RMS7fV+l1j7oCIo0Y7X9CDt8L5L
        xHIizz9yHuXV+tpQ3rh3br5wiym7mGUMrCOJtRbZDCVWo45as0Gfo9dkpNEpdKZ2CZVkZSys
        jlq5Nj8lt8Qcqksl7WDMZaFUPsNxlGpptsNW5mSTim2cU0exdoPZnmlP5RgLV2Y1phbZLFl0
        Wlq6JiQsNBX//mOyT8btam53Sfaih7HVSEoCXgyDng5RNYoi5diPoP5oj5gPxhD4/3QJwio5
        /obgZdfCakRGHFXnVvGamwjuD00iPviMYOz5b3HYoMAZMPH4QOTa2bgCQTB4JXIgxCZo7D0r
        CTOBlRB4N0SEOQbPhyffX6Mwy/BS8DwORiqLcDK0NNyJ5OPwZpjo9E5pYuFewxtRmKU4G37W
        1kn4+xPgxZsmAc/zYH/HaWH4EYCHCQi+rBfzTa+E45WXRDwr4EOvT8JzIrw/WjnFe+DyvR6C
        Nx9G4AsMTJnVELhwXBCehRAvgmtdKj49Hzp/nUF84VnwadIl5sclg8OVcl6yAAZfjQh4ngOt
        h6qIOkS5p7XjntaCe1oL7v/FmpGoDcWzds5iZDnaTk//bC+KrKRS40cn+td2I0wiaqbsrjKq
        QC5mdnDllm4EpJCaLXuLogvkMgNTvpt12PSOMjPLdSNNaNr1wsS4Iltowa1OPa1JV6vV2sV0
        hoamqQSZPvr5Njk2Mk7WxLJ21vHPJyCliXvRalfO04tSmKGDU1eqnUZXfr2KtJUO1XS6k+Mf
        jT4S2ZrdpfG4r4/xDAY8jQ0bvyw7dutgesvHnStUV7kjpoTCAZ/O2NrW8iMgWS8ZyI35Gtyk
        OD3i9Q1X+rfLe5uUWxtnFhVkteeNtisrLktlM4hnMcsM60Y+Mls9UeXSNgUl4ooZWil0cMxf
        irVrbagDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO57Y+5Yg5ZXWhZrbh9itNi54Qu7
        xeZzPawWZ5vesFt87j3CaHG7cQWbA5vHjrtLGD36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        48/f7IKvohULNvSwNzBeFOxi5OCQEDCR6Fzk2sXIxSEksJtRYnvLQaYuRk6guKTEtItHmSFq
        hCUOHy4GCQsJvGWUeLmvDsQWFjCT+HKlhQWkV0SghVHi8amZbCAJZoFsiedb1zJBDD3IKHHw
        eiNYgk1AS2L/ixtgNr+AosTVH48ZQWxeATuJjVfegC1mEVCVWDjzGFhcVCBCYvauBhaIGkGJ
        kzOfgNmcAjYSv/omsEMsU5f4M+8SM4QtLnHryXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQt
        CxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeLluYOxstL4g8xCnAwKvHwntDi
        ihViTSwrrsw9xCjBwawkwvuUkTtWiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp
        2ampBalFMFkmDk6pBsb4p0vcLh39JGov43Zb6Et2MleYfl5ofd7EhLPyctu7n2bZfb5vH2fx
        3uWo/lKPH4zPN6Udqn7568/e8t2NBt9/Hp0r28G5QqUqLl6VqWOTb4zXxmO3PVdM6t4h63R1
        2q7fk+suObAcEboXZLAlr8J1jl3MrpN+Ld1P1R6eu8cbfzRz+Z0dm7crsRRnJBpqMRcVJwIA
        +y3U+5ICAAA=
X-CMS-MailID: 20190620072119epcas1p3b6a9541ada10046c29cb388db0225cac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605190249epcas3p4c5e474328413c4a3944a1ae7cbd54c29
References: <20190605190053.19177-1-ezequiel@collabora.com>
        <CGME20190605190249epcas3p4c5e474328413c4a3944a1ae7cbd54c29@epcas3p4.samsung.com>
        <20190605190053.19177-2-ezequiel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Frankly, I don't like the existing 'DEVFREQ: ' prefix 
because it is not used on all error log and it is not necessary.

Instead of this patch, I just prefer to delete the 'DEVFREQ: ' prefix

On 19. 6. 6. 오전 4:00, Ezequiel Garcia wrote:
> This commit is a simple cosmetic cleanup, where pr_fmt is used to avoid
> the "DEVFREQ" prefix in some prints.
> 
> Also, messages are changed to not start with a capital. This is just
> a cosmetic change, meant to sanitize all prints from this file.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/devfreq/devfreq.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 8868ad9472d2..44392fa1c570 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -10,6 +10,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>
>  #include <linux/sched.h>
> @@ -59,7 +61,7 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  	struct devfreq *tmp_devfreq;
>  
>  	if (IS_ERR_OR_NULL(dev)) {
> -		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
> +		pr_err("%s: invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
>  	WARN(!mutex_is_locked(&devfreq_list_lock),
> @@ -208,7 +210,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  	struct devfreq_governor *tmp_governor;
>  
>  	if (IS_ERR_OR_NULL(name)) {
> -		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
> +		pr_err("%s: invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
>  	WARN(!mutex_is_locked(&devfreq_list_lock),
> @@ -238,7 +240,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	struct devfreq_governor *governor;
>  
>  	if (IS_ERR_OR_NULL(name)) {
> -		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
> +		pr_err("%s: invalid parameters\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
>  	WARN(!mutex_is_locked(&devfreq_list_lock),
> @@ -1001,7 +1003,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>  	int err = 0;
>  
>  	if (!governor) {
> -		pr_err("%s: Invalid parameters.\n", __func__);
> +		pr_err("%s: invalid parameters.\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1066,7 +1068,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>  	int err = 0;
>  
>  	if (!governor) {
> -		pr_err("%s: Invalid parameters.\n", __func__);
> +		pr_err("%s: invalid parameters.\n", __func__);
>  		return -EINVAL;
>  	}
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
