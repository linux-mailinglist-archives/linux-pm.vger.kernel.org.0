Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E930EE7F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 09:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhBDIbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 03:31:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57725 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDIbl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 03:31:41 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210204083057epoutp0384cd718926dc7cd61637df6b927a49b2~gfjriBTv10913809138epoutp03j
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 08:30:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210204083057epoutp0384cd718926dc7cd61637df6b927a49b2~gfjriBTv10913809138epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612427458;
        bh=F82OQMapjm8Kpfz7PKfTvgHA4BtIyeEtvatODC7+Qjw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kvsBl3eRYlL76ploEZ/SIvSYNIp42+9noZdw5LO79OXLfMZFVLUF14RTSCn7HDFEM
         Yk0i9MokqTu0ZH9S8UzSI18Cp19yuHFERXk+suPpWIkG66jlc/8pmzOfhWxQIOmm9L
         r9h9COeeftBSYK9s4o1NMiQE8J3sg21GlHhHFPqc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210204083055epcas1p347629df1529ba2d6b9077eee337d0585~gfjpj2KuF1399213992epcas1p3l;
        Thu,  4 Feb 2021 08:30:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DWWwD1j7Qz4x9Q7; Thu,  4 Feb
        2021 08:30:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.74.10463.CB0BB106; Thu,  4 Feb 2021 17:30:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210204083050epcas1p1c32da0192b0c74962adcfce3d3f55c3f~gfjk7DyfL1856818568epcas1p1u;
        Thu,  4 Feb 2021 08:30:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210204083050epsmtrp153ed4547d75348068457789489fd55a8~gfjk6SjiD0552405524epsmtrp1v;
        Thu,  4 Feb 2021 08:30:50 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-0f-601bb0bcad0a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.B2.08745.AB0BB106; Thu,  4 Feb 2021 17:30:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210204083050epsmtip1c6c3e46d1302f7508e622f9459c23449~gfjkkmDgy1883918839epsmtip1p;
        Thu,  4 Feb 2021 08:30:50 +0000 (GMT)
Subject: Re: [PATCH v6 2/3] PM / devfreq: Cache OPP table reference in
 devfreq
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <876e4164-1d28-9d0e-3b10-28d62099b904@samsung.com>
Date:   Thu, 4 Feb 2021 17:46:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210204081424.2219311-3-hsinyi@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmru6eDdIJBgevc1hMaN3ObHG26Q27
        xeVdc9gsPvceYbS43biCzeLNj7NMFmdOX2K16Dr0l83i37WNLBabHxxjc+DymN1wkcVjwaZS
        j02rOtk8tlxtZ/Ho27KK0eP4je1MHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzri2dCpTwVrhir9XDrA3MH7l72Lk5JAQMJH4
        9OcxWxcjF4eQwA5GiVd777NCOJ8YJXav3cgOUiUk8JlR4tjzMJiOj9PeMkMU7WKU+P5+FlT7
        e0aJHx29jCBVwgIBEiv7/4PZIgKpEnt/rwYrYhboZJKYv+0vC0iCTUBLYv+LG2wgNr+AosTV
        H4/BGngF7CS+T94IZrMIqEjM/bUT7AxRgTCJk9taoGoEJU7OfAI0h4ODU8BaYusPXZAws4C4
        xK0n85kgbHmJ7W/ngF0qIbCHQ6J52UdmiBdcJCZ/3gdlC0u8Or6FHcKWknjZ3wZlV0usPHmE
        DaK5g1Fiy/4LrBAJY4n9SyczgSxmFtCUWL9LHyKsKLHz91xGiMV8Eu++9rCClEgI8Ep0tAlB
        lChLXH5wlwnClpRY3N7JNoFRaRaSb2YheWEWkhdmISxbwMiyilEstaA4Nz212LDABDm2NzGC
        k66WxQ7GuW8/6B1iZOJgPMQowcGsJMKb2CaVIMSbklhZlVqUH19UmpNafIjRFBi+E5mlRJPz
        gWk/ryTe0NTI2NjYwsTQzNTQUEmcN8ngQbyQQHpiSWp2ampBahFMHxMHp1QDU1D5QW+uK0ni
        86d47q1sYXC62KFxp0s8+mjqmZO34y805a6f0/OwT2QX5wER7uYN5vx/JObOX+p05Wj414Yj
        L0L2HvjGdTvl/bltG5KjW1rXSW5wzfNYmtK/xl9Nwe+E5P4lVgx+zjtO799YwPh8a3nY19UZ
        Wj8cao+V9c9rWbrdbb1EIS8nZ1qamqrM/Fub/y6/dkuXYfGjV43Z+W9uSMcGrLdt7404+NDo
        mn/5kxeXd1+Sc7i24pTWt9TzO88ve+HgZxy278j3tsIAhhehB1Qe3fp85MGyI1tq/xtXCv4s
        rBUyfbH3VOGJvwzicx/ypzhLfnmz5qGmt09EyLx5jc+rWhiWfvc51fss//bEDaxKLMUZiYZa
        zEXFiQAM/lhEQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO6uDdIJBg8/a1pMaN3ObHG26Q27
        xeVdc9gsPvceYbS43biCzeLNj7NMFmdOX2K16Dr0l83i37WNLBabHxxjc+DymN1wkcVjwaZS
        j02rOtk8tlxtZ/Ho27KK0eP4je1MHp83yQWwR3HZpKTmZJalFunbJXBlXFs6lalgrXDF3ysH
        2BsYv/J3MXJySAiYSHyc9pa5i5GLQ0hgB6PEygNvWSASkhLTLh4FSnAA2cIShw8XQ9S8ZZR4
        MvM8O0iNsICfRH/nVkYQW0QgVWJiczcbSBGzQDeTxKNPU6Gm7meUWHLwPthUNgEtif0vbrCB
        2PwCihJXfzwG6+YVsJP4PnkjmM0ioCIx99dOsA2iAmESO5c8ZoKoEZQ4OfMJC8hFnALWElt/
        6IKEmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG4VlIumchaZmFpGUWkpYFjCyrGCVTC4pz
        03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC409LawfjnlUf9A4xMnEwHmKU4GBWEuFNbJNKEOJN
        SaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGp8Kb2v9b03En7
        vrKcs5WZbJaqxGi59cTnvR7uLzkP5lhU9e521Q3vLou622mxMHDixPzOf5McOKNaX9touEzh
        dVTxamyfnHi6dK743jjPvpimMtm7k8+ckpA+9Jr7hr/ETA4/tdV2N/ZWik8+4nbilr2zfg7j
        hpKbLeqs1jl7Tq9Z+/qnWYdqo5HH+1Cbc+pc+d7CfYVZyaYu2iz34o3vfWRj32No/fXbkfaa
        E+lfUra2/LTp3vrfSPv72VOLvd23Xc7++0TppN3iP8fudNZXsG4L/8hrUt+YFa1ZcUZU5i5n
        cI/vc7doQVU+hm9dXTH6v2s9LD43v87vio2xlVH4eWPyPs59LFP+b9tvpcRSnJFoqMVcVJwI
        AA8I96wuAwAA
X-CMS-MailID: 20210204083050epcas1p1c32da0192b0c74962adcfce3d3f55c3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210204081436epcas1p2acb2b052090c18979c48f2c343f6b7aa
References: <20210204081424.2219311-1-hsinyi@chromium.org>
        <CGME20210204081436epcas1p2acb2b052090c18979c48f2c343f6b7aa@epcas1p2.samsung.com>
        <20210204081424.2219311-3-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hsin-Yi,

On 2/4/21 5:14 PM, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> The OPP table can be used often in devfreq. Trying to get it each time can
> be expensive, so cache it in the devfreq struct.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 6 ++++++
>  include/linux/devfreq.h   | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6aa10de792b33..a5899c9ae16fc 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -757,6 +757,8 @@ static void devfreq_dev_release(struct device *dev)
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	if (devfreq->opp_table)
> +		dev_pm_opp_put_opp_table(devfreq->opp_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -844,6 +846,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (IS_ERR(devfreq->opp_table))
> +		devfreq->opp_table = NULL;
> +
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index b6d3bae1c74d8..26ea0850be9bb 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -137,6 +137,7 @@ struct devfreq_stats {
>   *		using devfreq.
>   * @profile:	device-specific devfreq profile
>   * @governor:	method how to choose frequency based on the usage.
> + * @opp_table:	Reference to OPP table of dev.parent, if one exists.
>   * @nb:		notifier block used to notify devfreq object that it should
>   *		reevaluate operable frequencies. Devfreq users may use
>   *		devfreq.nb to the corresponding register notifier call chain.
> @@ -173,6 +174,7 @@ struct devfreq {
>  	struct device dev;
>  	struct devfreq_dev_profile *profile;
>  	const struct devfreq_governor *governor;
> +	struct opp_table *opp_table;
>  	struct notifier_block nb;
>  	struct delayed_work work;
>  
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
