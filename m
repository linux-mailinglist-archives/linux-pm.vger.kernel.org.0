Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24684BC041
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 04:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393300AbfIXClV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 22:41:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52297 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392956AbfIXClU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 22:41:20 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190924024118epoutp029a4b8eba1bb6cebeab5ab0478e3b52eb~HP48UO6Wv0886308863epoutp02T
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 02:41:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190924024118epoutp029a4b8eba1bb6cebeab5ab0478e3b52eb~HP48UO6Wv0886308863epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569292878;
        bh=HlTZWWkWqFE8ty1ADmXiBqGkS4yKkQpOAILmlR6nLNg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YXEz485ACZdXx1VbCK3UjxzXKa4OK6wUznmIsF59l01ggL1Zg6hv0GIMR8cGccWpV
         I8JkV00beo6XdSe/Wrv0VP8uAYyR2fcg0+5C5Ip977BG8prE0YvUYxMjAirltLr4d8
         WEvaZePEWfMV8vKZUDr17ZJRfE3pZbxjoPCLUDPo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924024118epcas1p244fc261204e4423c350defcd83404635~HP47phaQ41986719867epcas1p2J;
        Tue, 24 Sep 2019 02:41:18 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46cln66p9zzMqYkg; Tue, 24 Sep
        2019 02:41:14 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.A3.04068.A42898D5; Tue, 24 Sep 2019 11:41:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924024114epcas1p1c2c0b2a843625f9d2351d64dec20804e~HP44BTlnn0063400634epcas1p1J;
        Tue, 24 Sep 2019 02:41:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924024114epsmtrp25544a27cd34b882c45cf66a0337aaa2a~HP43-mMao2863428634epsmtrp2M;
        Tue, 24 Sep 2019 02:41:14 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-4c-5d89824a4597
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.A1.04081.A42898D5; Tue, 24 Sep 2019 11:41:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924024113epsmtip2bcf0c4366cc6ffa79c9370965f15493f~HP43tHsPu1806518065epsmtip2X;
        Tue, 24 Sep 2019 02:41:13 +0000 (GMT)
Subject: Re: [PATCH v7 1/6] PM / devfreq: Don't fail devfreq_dev_release if
 not in list
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2b72c253-0e83-c102-93e2-13f45ffe2702@samsung.com>
Date:   Tue, 24 Sep 2019 11:45:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06523b8ebc7006e13d92032c2e8494d2a919deac.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmnq5XU2esweSNZhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmhxbcVEVovP
        Gx4zWtxuXMFmsfrcQTaLrkN/2Sw2fvVwEPR4f6OV3WN2w0UWjwWbSj02repk87hzbQ+bx+Yl
        9R4b3+1g8jj4bg+Tx6/Doh59W1YxenzeJBfAHZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PN/YNMBc8EK1ZuW8TSwPiKr4uRg0NCwESi
        /Zh5FyMXh5DADkaJR1P2sUA4nxglvr2cygrhfGOU+L3iApDDCdax6NBeqKq9jBKz9s1jgnDe
        M0qsXnCQDaRKWCBS4uihFWwgCRGB1YwSLUvvMII4zAK9LBI77newgFSxCWhJ7H9xA6yDX0BR
        4uqPx4wgNq+AncTkKxPAalgEVCWu/znODmKLCkRIfHpwmBWiRlDi5MwnYDWcAnESsw7dYwKx
        mQXEJW49mQ9ly0s0b53NDLJYQuARu8TjbfuhnnCR2HJqAQuELSzx6vgWdghbSuLzu71sEHa1
        xMqTR9ggmjsYJbbsh4WAscT+pZOZQOHHLKApsX6XPkRYUWLn77mMEIv5JN597WGFBDGvREeb
        EESJssTlB3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC0yR43sT
        Izi9a1nuYDx2zucQowAHoxIPb8GOjlgh1sSy4srcQ4wSHMxKIrybtNpihXhTEiurUovy44tK
        c1KLDzGaAkN7IrOUaHI+MPfklcQbmhoZGxtbmBiamRoaKonzeqQ3xAoJpCeWpGanphakFsH0
        MXFwSjUwxl7cuuy1fMxZkR1HFb45S8RdWFxdErzFb31ohd+e27//nF+pkTu5QOXnvYm3J83y
        5nzT7m0g8rppbzt3qaBTCZfYzeZ1R75fMf3YqG6bteDqvPqot0Hv3jwr9u9dX8G/2lh3I8+X
        17OD7eeH7rtlXHrqS9L0ngmNvteSXrk+unNNU+fqi+iHs5VYijMSDbWYi4oTAeNzFvoFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvK5XU2eswf91PBaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmhxbcVEVovP
        Gx4zWtxuXMFmsfrcQTaLrkN/2Sw2fvVwEPR4f6OV3WN2w0UWjwWbSj02repk87hzbQ+bx+Yl
        9R4b3+1g8jj4bg+Tx6/Doh59W1YxenzeJBfAHcVlk5Kak1mWWqRvl8CV8eb+QaaCZ4IVK7ct
        YmlgfMXXxcjJISFgIrHo0F6WLkYuDiGB3YwSE3bPYoRISEpMu3iUuYuRA8gWljh8uBii5i2j
        xPqLPUwgNcICkRJHD61gA7FFBNYySsw57wBSxCzQyyLRdHAFO0THI0aJ5vWX2UGq2AS0JPa/
        uAHWwS+gKHH1x2OwbbwCdhKTr0xgAbFZBFQlrv85DlYvKhAhcXjHLKgaQYmTM5+A1XAKxEnM
        OnQP7ApmAXWJP/MuMUPY4hK3nsyHistLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi
        3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4DjX0tzBeHlJ/CFGAQ5GJR7egh0dsUKsiWXFlbmH
        GCU4mJVEeDdptcUK8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvE
        wSnVwCjD/qFytXmkyMek48q1mXEPNmhqnT34dN9tte5rYWHnlz1O2LmiJJW1lZ1TS0ag4cvk
        1i1ContmLLOaETi5KMNEvMVTMdpK/cXRptoJ1j9XvP0j6uN/ZMORezumBXjPWB96dpKLR4fK
        BqEzcc5G/04/eq66KOtAmuOdK5cy6r9yfMve3H5BhU2JpTgj0VCLuag4EQC6Ihyr7wIAAA==
X-CMS-MailID: 20190924024114epcas1p1c2c0b2a843625f9d2351d64dec20804e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211043epcas1p1dace897328bf65fef5a620067548789c
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211043epcas1p1dace897328bf65fef5a620067548789c@epcas1p1.samsung.com>
        <06523b8ebc7006e13d92032c2e8494d2a919deac.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
> Right now devfreq_dev_release will print a warning and abort the rest of
> the cleanup if the devfreq instance is not part of the global
> devfreq_list. But this is a valid scenario, for example it can happen if
> the governor can't be found or on any other init error that happens
> after device_register.
> 
> Initialize devfreq->node to an empty list head in devfreq_add_device so
> that list_del becomes a safe noop inside devfreq_dev_release and we can
> continue the rest of the cleanup.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e9e6c8f1dc4b..f5bea7350f72 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -582,15 +582,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  static void devfreq_dev_release(struct device *dev)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  
>  	mutex_lock(&devfreq_list_lock);
> -	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
> -		mutex_unlock(&devfreq_list_lock);
> -		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
> -		return;
> -	}
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
> @@ -641,10 +636,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_init(&devfreq->lock);
>  	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
> +	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
> 

It's reasonable. Thanks.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
