Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBAD1481C4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbgAXLWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 06:22:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59284 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391215AbgAXLWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 06:22:32 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200124112231euoutp0141a20c81ee7484727111e446bf65a43d~szs2Qpa070216702167euoutp01I
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 11:22:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200124112231euoutp0141a20c81ee7484727111e446bf65a43d~szs2Qpa070216702167euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579864951;
        bh=gH8EIJeJlCpXZLUo9SizzuGQeQgKu9yKoahR+VdzaC0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZUsjU/snKJDoLgpzOZzP4YhLLm5qsWkOK/QVKyREP34CAeJgq+1kqqUmh8E5h15dh
         y8932klgGlKlSJUWGLHNxebDDo6A9UHu0BkEknDleHa2NEZ9JkzHk/5K92kKM3HEi1
         riMifFVq3XjCgkztweXYam7w/lbC8f/NF401Tbg8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200124112230eucas1p16d9ec921d759632091731778cb04cd6e~szs1nHtSe2709327093eucas1p11;
        Fri, 24 Jan 2020 11:22:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.A8.60698.673DA2E5; Fri, 24
        Jan 2020 11:22:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200124112230eucas1p291726bf7d38e291fba61b48f61eee9fe~szs1Sbhr02304223042eucas1p2w;
        Fri, 24 Jan 2020 11:22:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200124112230eusmtrp1437ace3339b579ec0f61a6988674b2e2~szs1R3yFr0086800868eusmtrp14;
        Fri, 24 Jan 2020 11:22:30 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-b0-5e2ad3761941
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.FC.08375.673DA2E5; Fri, 24
        Jan 2020 11:22:30 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200124112230eusmtip23eb7cec6c530209891158808b8cd0899~szs0yYZFW1635916359eusmtip2Q;
        Fri, 24 Jan 2020 11:22:29 +0000 (GMT)
Message-ID: <6c41f75456d4c9347414b94215162d81acf4b84a.camel@samsung.com>
Subject: Re: [PATCH v4 1/3] interconnect: Export of_icc_get_from_provider()
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
Date:   Fri, 24 Jan 2020 12:22:29 +0100
In-Reply-To: <45e28d51-27db-2faa-d633-3a3d857ecdc9@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87pll7XiDGZPMrTYOGM9q8X1L89Z
        Labv3cRmcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CJ4rJJSc3JLEst0rdL4Mpobu1kLJguXnHx5hO2Bsb3Ql2MnBwSAiYSby51sYDYQgIrGCXO
        37bvYuQCsr8wSky7PJ0ZIvGZUeLa2wqYhk9Nx5khipYzShx4vIoRwnnGKDFxfyMrSBWvgIfE
        tk8z2UFsYQFvicevLjCC2GwC9hJnb39jAmkQEehklFg36SFYglkgUeL75GawBhYBVYnrhy+C
        2ZwCdhIvvyxhhFitI/H2VB/QrRxACwQl/u4QhmiVl2jeOpsZomQRu8SCJ0YQtovEk0VrmSBs
        YYlXx7ewQ9gyEqcn97BA2MUST3feZwW5R0KggVFi07IjUIOsJe6c+8UGsotZQFNi/S59iLCj
        xNMTN8HCEgJ8EjfeCkKcwCcxaRsosEDCvBIdbUIQppLErpl8EI0SEk2rr0HN9pCY/3sv+wRG
        xVkIr8xC8soshK0LGJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKaY0/+Of93BuO9P
        0iFGAQ5GJR7eA12acUKsiWXFlbmHGCU4mJVEeBnDgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwMmg+7Xyg59KikNvsN7t2QolN35OPaokbrM/lrSvI
        1G19OP2NtdNOm3vT/IOSbrJUbupuLREU2XSq6Oiest6J0n8fs0+YKlPTe/FpTse5m1UJ5wu+
        vv9u8Idf/oGWsce5A5yTrs4NPhTs8+Diwqb4edXpe70TJ3ZzvZlxTr0pVfqYYZvGZKNPSizF
        GYmGWsxFxYkAg5/ZVC0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7pll7XiDGY3yFpsnLGe1eL6l+es
        FtP3bmKzOH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kdODw2repk87hzbQ+bR9+WVYwenzfJ
        BbBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0
        t3YyFkwXr7h48wlbA+N7oS5GTg4JAROJT03HmbsYuTiEBJYySpz69IUFIiEh8XH9DVYIW1ji
        z7UuNoiiJ4wSUx7tB0vwCnhIbPs0kx3EFhbwlnj86gIjiM0mYC9x9vY3JpAGEYEuRok7k5cy
        gySYBRIl9nycAtbAIqAqcf3wRTCbU8BO4uWXJYwQG74wSkxaOheqQVOidftvdogzdCTenuoD
        Oo8DaLOgxN8dwhAl8hLNW2czT2AUnIWkYxZC1SwkVQsYmVcxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIERtG2Yz8372C8tDH4EKMAB6MSD69Er2acEGtiWXFl7iFGCQ5mJRFexjCgEG9KYmVV
        alF+fFFpTmrxIUZToH8mMkuJJucDIzyvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZq
        akFqEUwfEwenVANjGl/3n2O9TqHyiVtk/m8Sfsn86fbixf/Fak6/Yk2XuXWitSE2K6nTpmN5
        3Z03X4v3/G7o/X1H0XtuVrFZI2fY88QZun/XK1xqsA7O/T9txeptvk2xHq8XSh8y33wmgVd5
        y/2LC/b5Oj8XceHJX/jsI+93P+t2iwtaLGL/J8y1XHZxV+f95RFlSizFGYmGWsxFxYkA+gX1
        k7gCAAA=
X-CMS-MailID: 20200124112230eucas1p291726bf7d38e291fba61b48f61eee9fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0
References: <20200116144202.12116-1-a.swigon@samsung.com>
        <CGME20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0@eucas1p1.samsung.com>
        <20200116144202.12116-2-a.swigon@samsung.com>
        <45e28d51-27db-2faa-d633-3a3d857ecdc9@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, 2020-01-23 at 11:21 +0200, Georgi Djakov wrote:
> Hi Artur,
> 
> On 1/16/20 16:42, Artur Świgoń wrote:
> > This patch makes the above function public (for use in exynos-bus devfreq
> > driver).
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/interconnect/core.c           | 3 ++-
> >  include/linux/interconnect-provider.h | 6 ++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > index f277e467156f..0be1764d3528 100644
> > --- a/drivers/interconnect/core.c
> > +++ b/drivers/interconnect/core.c
> > @@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
> >   * Returns a valid pointer to struct icc_node on success or ERR_PTR()
> >   * on failure.
> >   */
> > -static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> > +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> >  {
> >  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
> >  	struct icc_provider *provider;
> > @@ -349,6 +349,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> >  
> >  	return node;
> >  }
> > +EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
> >  
> >  /**
> >   * of_icc_get() - get a path handle from a DT node based on name
> > diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> > index 0c494534b4d3..cc965b8fab53 100644
> > --- a/include/linux/interconnect-provider.h
> > +++ b/include/linux/interconnect-provider.h
> > @@ -103,6 +103,7 @@ void icc_node_del(struct icc_node *node);
> >  int icc_nodes_remove(struct icc_provider *provider);
> >  int icc_provider_add(struct icc_provider *provider);
> >  int icc_provider_del(struct icc_provider *provider);
> > +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
> >  
> >  #else
> >  
> > @@ -154,6 +155,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
> >  	return -ENOTSUPP;
> >  }
> >  
> > +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> 
> Please make this static inline, as we may see a warning in some configurations:

Sure, will fix.

> In file included from drivers/devfreq/exynos-bus.c:18:
> ./include/linux/interconnect-provider.h:160:18: warning: no previous prototype
> for ‘of_icc_get_from_provider’ [-Wmissing-prototypes]
>   160 | struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> > +{
> > +	return ERR_PTR(-ENOTSUPP);
> > +}
> > +
> >  #endif /* CONFIG_INTERCONNECT */
> >  
> >  #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
> > 

-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


