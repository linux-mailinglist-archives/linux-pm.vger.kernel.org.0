Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942C3A9503
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFPIaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 04:30:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17650 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFPIaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 04:30:23 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210616082816epoutp04ebb6d2039e0827eb42a66ee07742ef59~JArAoo8Ee2100021000epoutp04K
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 08:28:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210616082816epoutp04ebb6d2039e0827eb42a66ee07742ef59~JArAoo8Ee2100021000epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623832096;
        bh=xk056Tjpj1chPh33Q+VIHElQpGaemhZ54qCjKh088wM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LL/fyWtQlM4xdd305ejeB9l3NFlYj4wYOxh9ftgAGZ9Rhv8pcVIse7ZUAmkzNmjJe
         GvUdO4IAQBQDJQnM86qUw4PklugsKQabv2dAd06fApLRaO5I/ZEn2ml6bVzEnbiHwM
         4235xQqkgAv8c4HsYYgSNHU67eWalKJZhtjPLxg0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210616082815epcas1p390ffff65c6f2669ae446b19c5f9ac231~JArAQpUGu1782017820epcas1p33;
        Wed, 16 Jun 2021 08:28:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G4dcF4dCzz4x9Q3; Wed, 16 Jun
        2021 08:28:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.5A.09824.D16B9C06; Wed, 16 Jun 2021 17:28:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210616082812epcas1p118f7ad1e89f110cdb8cabc2e43d11cc3~JAq9YtMDz0706707067epcas1p1H;
        Wed, 16 Jun 2021 08:28:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210616082812epsmtrp25bf7c462e82f585284f58006f60e9119~JAq9Xzked1257812578epsmtrp2w;
        Wed, 16 Jun 2021 08:28:12 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-db-60c9b61df493
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.75.08163.C16B9C06; Wed, 16 Jun 2021 17:28:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210616082812epsmtip2da325089d63582748d2deb86a4e50867~JAq9FUfWX0191901919epsmtip2b;
        Wed, 16 Jun 2021 08:28:12 +0000 (GMT)
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non
 genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
Date:   Wed, 16 Jun 2021 17:47:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmga7stpMJBjOmqFhsX/+C1WJC63Zm
        i8u75rBZfO49wmjx5sdZJot/1zayWGz86mGx+cExNgcOj9kNF1k8Nq3qZPO4c20Pm0fLyf0s
        HsdvbGfy+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2RltDH3vBG6mKn0cWMjUw3hTpYuTgkBAwkXhxJ76LkYtDSGAHo8TfB7sZ
        IZxPjBI9m44wQzifGSWefr7M2sXICdZxdO8GVojELkaJezMbmUASQgLvGSVOTrYHsYUFAiQ2
        r/zJCGKLANkrelvZQRqYBW4wShxYM58FJMEmoCWx/8UNNhCbX0BR4uqPx2ANvAJ2Ep2Xu8Fs
        FgFViVPLjoHViwqESZzc1gJVIyhxcuYTsDingKXEpef97CA2s4C4xK0n85kgbHmJ7W/ngL0g
        IbCUQ2LyvSmMEC+4SHxd0sAEYQtLvDq+hR3ClpL4/G4vG4RdLbHy5BE2iOYORokt+y9A/W8s
        sX/pZCZQ6DELaEqs36UPEVaU2Pl7LiPEYj6Jd197WCEBzCvR0SYEUaIscfnBXai1khKL2zvZ
        JjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxYYI8f2JkZwWtUy38E47e0HvUOMTByM
        hxglOJiVRHh1i08kCPGmJFZWpRblxxeV5qQWH2I0BQbwRGYp0eR8YGLPK4k3NDUyNja2MDE0
        MzU0VBLn3cl2KEFIID2xJDU7NbUgtQimj4mDU6qB6frHEL/p6naqnZrPTkQ1Hbv3J2MNqwlH
        Z1Z8522uKdVRklwHG945zayd2La6ODzeQbLbJOCbqeZr+33871fqa8w78PnR77xWzqU+RtUL
        bz6vP80wfZ2h8q35yyrXxR/uj02NnWphvFtQLfm17+43vLqmV8MdjCVETh3NO2H5zfUCv4Jk
        ymaeq4f+3Fx1bIFYKvua5wJsE12nT3rs17jjiTunVc1dBqvUFZ633/IYbpQzuP748e7dLMuY
        BeJXqp4Mb3JIdl/I+WBycO9ysWsRi6M5bf5YR3EG96ucvhhowZp06niaSF32otwbb7ecaHKu
        f/xsY0qvwdevk+fK2UvZMbUnv1zFpsx/RGbT1ZsNSizFGYmGWsxFxYkAX4rWlDQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXldm28kEg1vnNCy2r3/BajGhdTuz
        xeVdc9gsPvceYbR48+Msk8W/axtZLDZ+9bDY/OAYmwOHx+yGiywem1Z1snncubaHzaPl5H4W
        j+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJXR1tDHXvBGquLnkYVMDYw3RboYOTkkBEwkju7d
        wNrFyMUhJLCDUeLL1v2MEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZToevyXBaRGWMBP4tHcycwg
        tgiQ/aTlDhuIzSxwg1Hizv4KiIa9jBIrtn5nAkmwCWhJ7H9xA6yIX0BR4uqPx2DLeAXsJDov
        d4PZLAKqEqeWHQNbICoQJrFzyWMmiBpBiZMzn4DFOQUsJS4972eHWKYu8WfeJWYIW1zi1pP5
        TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcYVpaOxj3rPqgd4iRiYPxEKMEB7OSCK9u8YkEId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiW3qwzO3lukdSLnWduZf2VZuZX0j4tJyA5M/Tu
        XjZW7ku8a583rD/7L6d/z8JFN01ksuV1N+kqTr7gsfODF7eN3yfhNwf77rnwLIqo7Fq6YNvj
        yBaDDbcNZ5Qbdk8T+yft0R2V5HBGN/PAg31eF2TzUoo2Gn8tOJes2hTsPClVbGF0gc7pOUfk
        cpaFO3L3vNf2nZ2Q3dZi87p4i8aa9hy2gvtyokdeitSmLqicK37VV+jTrM7gm0puNrLbAh5e
        if//L6hq29UEXm2uHY/2pCW0/w1U19zBe15Z8N35/Te4Zq7cwtl+iWFi0YkVD6KjzqT+Y73Y
        +lKVR6Qp1izL735zzLl2t4UON49pKzxZt1KJpTgj0VCLuag4EQAuDXC0HwMAAA==
X-CMS-MailID: 20210616082812epcas1p118f7ad1e89f110cdb8cabc2e43d11cc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc
References: <20210616053335.4181780-1-hsinyi@chromium.org>
        <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
        <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/16/21 4:55 PM, Viresh Kumar wrote:
> On 16-06-21, 13:33, Hsin-Yi Wang wrote:
>> Don't limit required_opp_table to genpd only. One possible use case is
>> cpufreq based devfreq governor, which can use required-opps property to
>> derive devfreq from cpufreq.
>>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
>> This is tested with the non genpd case mt8183-cci with passive
>> governor[1].
>> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
>> ---
>>  drivers/opp/of.c | 20 +-------------------
>>  1 file changed, 1 insertion(+), 19 deletions(-)
>>
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index aa75a1caf08a3..9573facce53a5 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>>  			lazy = true;
>>  			continue;
>>  		}
>> -
>> -		/*
>> -		 * We only support genpd's OPPs in the "required-opps" for now,
>> -		 * as we don't know how much about other cases. Error out if the
>> -		 * required OPP doesn't belong to a genpd.
>> -		 */
>> -		if (!required_opp_tables[i]->is_genpd) {
>> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
>> -				required_np);
>> -			goto free_required_tables;
>> -		}
>>  	}
>>  
>>  	/* Let's do the linking later on */
>> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>>  	struct dev_pm_opp *opp;
>>  	int i, ret;
>>  
>> -	/*
>> -	 * We only support genpd's OPPs in the "required-opps" for now,
>> -	 * as we don't know much about other cases.
>> -	 */
>> -	if (!new_table->is_genpd)
>> -		return;
>> -
>>  	mutex_lock(&opp_table_lock);
>>  
>>  	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
>> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
>> -	if (ret < 0 && !opp_table->is_genpd) {
>> +	if (ret < 0) {
>>  		dev_err(dev, "%s: opp key field not found\n", __func__);
>>  		goto free_opp;
>>  	}
> 
> Plus this and few changes to commit log.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e366218d6736..b335c077f215 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -893,6 +893,16 @@ static int _set_required_opps(struct device *dev,
>         if (!required_opp_tables)
>                 return 0;
>  
> +       /*
> +        * We only support genpd's OPPs in the "required-opps" for now, as we
> +        * don't know much about other use cases. Error out if the required OPP
> +        * doesn't belong to a genpd.
> +        */
> +       if (unlikely(!required_opp_tables[0]->is_genpd)) {
> +               dev_err(dev, "required-opps don't belong to a genpd\n");
> +               return -ENOENT;
> +       }
> +

If you add this checking statement, I think that 
when using dev_pm_opp_set_rate with required-opp property, it will be failed.

>         /* required-opps not fully initialized yet */
>         if (lazy_linking_pending(opp_table))
>                 return -EBUSY;
> 
> Applied. Thanks.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
