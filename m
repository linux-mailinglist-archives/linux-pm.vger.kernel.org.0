Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADB255E02
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZB4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:56:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23583 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZB4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:56:46 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190626015644epoutp02595d8f62b91fc17e90dab5112234f026~rnOVgXPmt1451814518epoutp02U
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 01:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190626015644epoutp02595d8f62b91fc17e90dab5112234f026~rnOVgXPmt1451814518epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561514204;
        bh=mN9kJgJwyv+yfF/Ayvk4CmbAGn6ClKZLiHRHhBm3400=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k0x50vqfMwbKZ/DdwhwRuWXGuGFerWcoplCkMQn0sYc0fRroNYXrDwBJ6OnzZ1W8n
         CdEzJPpvmqiFKOl1lROz4mSRkDMTnRDmKm7zKVc0Hx4JNO4dWN87hXGAmMBdN3Zcig
         CkXnPNzArrNiqHZjbq4OYKfGOmf2cnV9MQgMeTMQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190626015641epcas1p4980e32a22fb7b31874cb666d4caf20be~rnOSGDgMl1952119521epcas1p4r;
        Wed, 26 Jun 2019 01:56:41 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.73.04139.6D0D21D5; Wed, 26 Jun 2019 10:56:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190626015638epcas1p451164dd88ad5e8ceda798c221547592c~rnOP4zHcu1633116331epcas1p4n;
        Wed, 26 Jun 2019 01:56:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626015638epsmtrp1451ad5925cdf4a2b2483d7343b948c0e~rnOP3fGsE1653516535epsmtrp1J;
        Wed, 26 Jun 2019 01:56:38 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-7e-5d12d0d63819
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.92.03692.6D0D21D5; Wed, 26 Jun 2019 10:56:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626015638epsmtip27467b9bd9650a2cf8de35fe870824d0e~rnOPsVDLw2886328863epsmtip2O;
        Wed, 26 Jun 2019 01:56:38 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] PM / devfreq: Add required OPPs support to
 passive governor
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
Message-ID: <0d552b60-8ef1-5d66-d8bf-c192c15c325f@samsung.com>
Date:   Wed, 26 Jun 2019 10:59:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625213337.157525-5-saravanak@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmru61C0KxBs2LbSxeHtK02LFdxOJs
        0xt2i8u75rBZfO49wmhxu3EFm8WbH2eZLM6cvsRq0XXoL5vFv2sbWSw2PzjG5sDtsW33NlaP
        BZtKPTat6mTz2HK1ncWjb8sqRo/jN7YzeXzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PJhTcsBeeEKpb3NTM2MH7l62Lk5JAQ
        MJGYtOIkUxcjF4eQwA5Gia9XnrJAOJ8YJU72nmSHcL4xSqxaeZ4RpqXj1F9miMReRomLf3ax
        gySEBN4zSjx+xgRiCwtEStxYfxFsrohAL5PE1VNv2UAcZoFmRomHT2aDjWIT0JLY/+IGG4jN
        L6AocfXHY7A4r4CdxIGz28CmsgioSvx61g42VVQgQuLyll1QNYISJ2c+YQGxOQWsJTau/QhW
        zywgLnHryXwmCFteonnrbLBTJQSms0v0d8xhhfjBReLk5A9MELawxKvjW9ghbCmJl/1tUHa1
        xMqTR9ggmjsYJbbsvwDVbCyxf+lkoGYOoA2aEut36UOEFSV2/p4LDSNeiYaNv6EO4pN497WH
        FaQcJN7RJgRRoixx+cFdpgmMyrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFhsjxvYkR
        nH61THcwTjnnc4hRgINRiYe3QV4oVog1say4MvcQowQHs5II79JEgVgh3pTEyqrUovz4otKc
        1OJDjKbA0J7ILCWanA/MDXkl8YamRsbGxhYmhmamhoZK4rzx3DdjhATSE0tSs1NTC1KLYPqY
        ODilGhg1JnQ3nbz0dP8yuZf6F4VZc+N6Pdhy8+y70pkKrz5ll9C+m3d5im7sShEft+ddR5fX
        yDEdyUnTc7+nZHvLoWIFq8ojp5M5xS6bt9zbumVyeMgX/wfsR6WWmAVkuq8Rd6llm7nL4vBh
        ncOSMTu9TkmV1352z9wTmDN/Zf2vkgDRGo7AooAWayWW4oxEQy3mouJEAAaxGOTVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO61C0KxBu8ealq8PKRpsWO7iMXZ
        pjfsFpd3zWGz+Nx7hNHiduMKNos3P84yWZw5fYnVouvQXzaLf9c2slhsfnCMzYHbY9vubawe
        CzaVemxa1cnmseVqO4tH35ZVjB7Hb2xn8vi8SS6APYrLJiU1J7MstUjfLoEr48mFNywF54Qq
        lvc1MzYwfuXrYuTkkBAwkeg49Ze5i5GLQ0hgN6PEkk9nmCASkhLTLh4FSnAA2cIShw8XQ9S8
        ZZR4trCfEaRGWCBSYvri2awgtohAP5PEjyYJEJtZoJlR4v67AoiG/YwSr16eBhvKJqAlsf/F
        DTYQm19AUeLqj8dgg3gF7CQOnN3GDmKzCKhK/HrWDlYvKhAh0dc2mw2iRlDi5MwnLCA2p4C1
        xMa1H9khlqlL/Jl3iRnCFpe49WQ+E4QtL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVML
        inPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjUEtzB+PlJfGHGAU4GJV4eBvkhWKFWBPLiitz
        DzFKcDArifAuTRSIFeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyW
        iYNTqoGxx5b74kyvcxpHeu66MstXR343EOA41dcdMzMnMmHvYtF56r7cbYk39YTubJu5+5K8
        dNumA+VmCU0b/LNj6hdpKnHUTHt6oKVbQnGxqmLYlt2nlxf5dq6f/r3PdIr/MbN5Ty73sib5
        HDdxf5Yi+GPajPfrzUvtCq4/0zZxW7936vYfjD28IdZKLMUZiYZazEXFiQBu3CDcvgIAAA==
X-CMS-MailID: 20190626015638epcas1p451164dd88ad5e8ceda798c221547592c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190625213400epcas5p417a68ce8bc5e097e4363fd61bd0a667f
References: <20190625213337.157525-1-saravanak@google.com>
        <CGME20190625213400epcas5p417a68ce8bc5e097e4363fd61bd0a667f@epcas5p4.samsung.com>
        <20190625213337.157525-5-saravanak@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On 19. 6. 26. 오전 6:33, Saravana Kannan wrote:
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 3bc29acbd54e..f6de03de7a64 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -22,7 +22,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>  	int i, count, ret = 0;
>  
>  	/*
> @@ -59,13 +59,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	if (IS_ERR(opp)) {
> -		ret = PTR_ERR(opp);
> +	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> +	if (IS_ERR(p_opp)) {
> +		ret = PTR_ERR(p_opp);
>  		goto out;
>  	}
>  
> -	dev_pm_opp_put(opp);
> +	if (devfreq->opp_table && parent_devfreq->opp_table)
> +		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> +					   devfreq->opp_table, p_opp);
> +	if (opp) {
> +		*freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +		goto out;
> +	}
>  
>  	/*
>  	 * Get the OPP table's index of decided freqeuncy by governor
> @@ -92,6 +99,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	*freq = child_freq;
>  
>  out:
> +	if (!IS_ERR_OR_NULL(opp))
> +		dev_pm_opp_put(p_opp);
> +
>  	return ret;
>  }
>  
> 

I agree this approach. It is necessary.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
