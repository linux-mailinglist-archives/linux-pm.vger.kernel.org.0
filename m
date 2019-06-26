Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3481955DFF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZByw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:54:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42376 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZByw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:54:52 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190626015448epoutp04bd2ebe8fdcbf7b73d9acc460ee7cb0eb~rnMpYfjif1526415264epoutp04L
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 01:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190626015448epoutp04bd2ebe8fdcbf7b73d9acc460ee7cb0eb~rnMpYfjif1526415264epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561514088;
        bh=DbLjquqRyBJxKS+PH6N4RxTqs3FfkmN7ydT/qtcxP5g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hd5FMraMbu/KBse4uRlSgog/KKm7n293lgzb63K30APjkOEHgYFMtPG82f8TNke1i
         rw5eDgU8XSLgGysucmpqiXLcx3JN4UnbuQaMwpD2csxo9EpGfaAvvS5sUdtwqZ2deM
         uxj0eDZ+IcY/E/D3KaCHbk0ZKQZr/fXDF6he7Tks=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190626015446epcas1p35ba7f4670093f47bb9afb2c48e87b89e~rnMm4pF3E0859108591epcas1p3r;
        Wed, 26 Jun 2019 01:54:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.90.04143.D50D21D5; Wed, 26 Jun 2019 10:54:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190626015437epcas1p3ee6dbb704dd18fd6d8aebf3fb0aeea59~rnMe4I6kl0859108591epcas1p3f;
        Wed, 26 Jun 2019 01:54:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626015437epsmtrp1051fced0cfab79cd06b6e2e1d11263f1~rnMe3RKCS1591315913epsmtrp1A;
        Wed, 26 Jun 2019 01:54:37 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-6c-5d12d05dc943
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.72.03692.D50D21D5; Wed, 26 Jun 2019 10:54:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626015436epsmtip25beeccd4586f1506bc99bf27bbf532f4~rnMefBHf02334423344epsmtip2W;
        Wed, 26 Jun 2019 01:54:36 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in
 devfreq
To:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <64a376ac-7e79-6b1c-6ca7-f555eaa64238@samsung.com>
Date:   Wed, 26 Jun 2019 10:57:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625213337.157525-4-saravanak@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmvm7sBaFYg72PTSxeHtK02LFdxOJs
        0xt2i8u75rBZfO49wmhxu3EFm8WbH2eZLM6cvsRq0XXoL5vFv2sbWSw2PzjG5sDtsW33NlaP
        BZtKPTat6mTz2HK1ncWjb8sqRo/jN7YzeXzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2PepUVsBXf5KhZfPsbSwDiHp4uRk0NC
        wESic9ZN1i5GLg4hgR2MEt8bJ7BBOJ8YJT50HWMFqRIS+MYo8XCuLEzHwasroDr2Mkrs7D3N
        AuG8Z5Q4u+EaG0iVsECAxMnfZ9lBEiICvUwSV0+9BZvLLNAMNOrJbEaQKjYBLYn9L26AdfAL
        KEpc/fEYLM4rYCdx7cITJhCbRUBV4uSi4ywgtqhAhMTlLbugagQlTs58AhbnFLCWOPnvHVg9
        s4C4xK0n86FseYnmrbOZQRZLCExnlzi1chYTxBMuEh8WzmSFsIUlXh3fwg5hS0m87G+Dsqsl
        Vp48wgbR3MEosWX/BagGY4n9SycDDeIA2qApsX6XPkRYUWLn77mMEDavRMPG3+wQR/BJvPva
        wwpSDhLvaBOCKFGWuPzgLtMERuVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAmPk+N7E
        CE6/WuY7GDec8znEKMDBqMTD2yAvFCvEmlhWXJl7iFGCg1lJhHdpokCsEG9KYmVValF+fFFp
        TmrxIUZTYGhPZJYSTc4H5oa8knhDUyNjY2MLE0MzU0NDJXHeeO6bMUIC6YklqdmpqQWpRTB9
        TBycUg2MRcY27ddeO0uk8Ude6pt99H1c+N5gN//Xb69tyXZJKnuyW+1Wr8J9v7YTdx7N/ttz
        pmxDre6cmxd/n/tsFTUlrUuPO2rXN8F5bkVLppYunTpBoTx05x3emhiH65ucdS7MnSeW8P7f
        4+sbJaP81vy9+mtbzaPkQsdC/XCZBYcSDjTb9jyx6pjpr8RSnJFoqMVcVJwIAAec9G3VAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvG7sBaFYg4mbhCxeHtK02LFdxOJs
        0xt2i8u75rBZfO49wmhxu3EFm8WbH2eZLM6cvsRq0XXoL5vFv2sbWSw2PzjG5sDtsW33NlaP
        BZtKPTat6mTz2HK1ncWjb8sqRo/jN7YzeXzeJBfAHsVlk5Kak1mWWqRvl8CVMe/SIraCu3wV
        iy8fY2lgnMPTxcjJISFgInHw6grWLkYuDiGB3YwSu9u2M0IkJCWmXTzK3MXIAWQLSxw+XAxR
        85ZRovXXQ2aQGmEBP4mTfyaygNgiAv1MEj+aJEBsZoFmRon77wogGvYzSny8vgisgU1AS2L/
        ixtsIDa/gKLE1R+PwZbxCthJXLvwhAnEZhFQlTi56DjYUFGBCIm+ttlsEDWCEidnPgGLcwpY
        S5z8944JYpm6xJ95l5ghbHGJW0/mQ8XlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpB
        cW56brFhgWFearlecWJucWleul5yfu4mRnAUamnuYLy8JP4QowAHoxIPb4O8UKwQa2JZcWXu
        IUYJDmYlEd6liQKxQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgsky
        cXBKNTAmPP2crXjjwqnCnMt+P2ftq5k9YZ3/RA8u/WVxW1P4MiQNFxrI5qutVP+3k+OOc/G+
        C9vYXzf25VbemGldJTCjR33753Wrpr0Tm/cnZeUak5kl22Ov/NdYYrr99DKO1BWn9vP/ZP21
        393ni6zX9Gk8D7ncFpx8u77t9fl1fla3d4nPPXDv6/6LOkosxRmJhlrMRcWJAFz8ZiG+AgAA
X-CMS-MailID: 20190626015437epcas1p3ee6dbb704dd18fd6d8aebf3fb0aeea59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190625213402epcas4p1959f1fa0603e5121c9b82c0aa216c6fc
References: <20190625213337.157525-1-saravanak@google.com>
        <CGME20190625213402epcas4p1959f1fa0603e5121c9b82c0aa216c6fc@epcas4p1.samsung.com>
        <20190625213337.157525-4-saravanak@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On 19. 6. 26. 오전 6:33, Saravana Kannan wrote:
> The OPP table can be used often in devfreq. Trying to get it each time can
> be expensive, so cache it in the devfreq struct.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/devfreq/devfreq.c | 6 ++++++
>  include/linux/devfreq.h   | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6b6991f0e873..ac62b78dc035 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -597,6 +597,8 @@ static void devfreq_dev_release(struct device *dev)
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	if (devfreq->opp_table)
> +		dev_pm_opp_put_opp_table(devfreq->opp_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -677,6 +679,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (IS_ERR(devfreq->opp_table))
> +		devfreq->opp_table = NULL;
> +
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74bfc1b..0d877c9513d7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -156,6 +156,7 @@ struct devfreq {
>  	struct devfreq_dev_profile *profile;
>  	const struct devfreq_governor *governor;
>  	char governor_name[DEVFREQ_NAME_LEN];
> +	struct opp_table *opp_table;
>  	struct notifier_block nb;
>  	struct delayed_work work;
>  
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
