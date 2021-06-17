Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBC3AA84C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 02:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFQA4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 20:56:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18931 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFQA4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 20:56:51 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210617005443epoutp02a001125146157c39873aff2dcb32fd30~JOISxTsjD2757327573epoutp02U
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 00:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210617005443epoutp02a001125146157c39873aff2dcb32fd30~JOISxTsjD2757327573epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623891283;
        bh=Pk+kGhGf8WOsTr8n6Nk2Q9N0imKFPx+eWrNowitJSnY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ogyc8hIUO1F0McF/v5r3kEAUh/OQmX116QPfd036eBlkZNFVBBlMPXp1yyMGurGTd
         3vkd7MRh9bDhzSvvUaMNfdlDLqpfxT9to+TyUWMygVbqfiP2Hos0s2n0HLUVhCjNas
         cAYfxwePV8KnyNRAkaHSehcHdzODmqVAs2/zc1Gg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210617005442epcas1p407c369a53e36535711a9d12747f958f6~JOISTTCXy1198311983epcas1p4b;
        Thu, 17 Jun 2021 00:54:42 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G53VS37Svz4x9QC; Thu, 17 Jun
        2021 00:54:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.1D.09736.E4D9AC06; Thu, 17 Jun 2021 09:54:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210617005438epcas1p41b598063c342ff446e585221fb813184~JOIONeLeN1192911929epcas1p41;
        Thu, 17 Jun 2021 00:54:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617005438epsmtrp2cbd56ab5fbbb17b3264508086db3b949~JOIOMa3US1693916939epsmtrp2u;
        Thu, 17 Jun 2021 00:54:38 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-07-60ca9d4ef9a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.8B.08637.E4D9AC06; Thu, 17 Jun 2021 09:54:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210617005437epsmtip2b9fbb73ac68ddddc25afd2a18c493c2b~JOIN6kiUf1236112361epsmtip2M;
        Thu, 17 Jun 2021 00:54:37 +0000 (GMT)
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non
 genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
Date:   Thu, 17 Jun 2021 10:13:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmga7f3FMJBl+eqlhsX/+C1WJC63Zm
        i8u75rBZfO49wmjx5sdZJot/1zayWGz86mGx+cExNgcOj9kNF1k8Nq3qZPO4c20Pm0fLyf0s
        HsdvbGfy+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2xq65fxkLDipU/Jw4ib2B8ZFkFyMnh4SAicT6bd+Zuxi5OIQEdjBK7PjZ
        zgbhfGKUWLF9MhOE841Rom3XYjaYlq2nH0Ml9jJKHJvcC9XynlFiwqdDrCBVwgIBEptX/mTs
        YuTgEBHQknh5MxWkhlngD6PE5L9nWEBq2IDi+1/cAJvKL6AocfXHY0YQm1fATqLpEITNIqAq
        8X7zAWYQW1QgTOLkthaoGkGJkzOfgM3hFLCUOP/xEDuIzSwgLnHryXwmCFteYvvbOWDPSQgs
        5ZA48m8uK8QLLhILmzYxQdjCEq+Ob2GHsKUkPr/bC/VmtcTKk0fYIJo7GCW27L8A1WwssX8p
        KGA4gDZoSqzfpQ8RVpTY+XsuI8RiPol3X3tYQUokBHglOtqEIEqUJS4/uAu1VlJicXsn2wRG
        pVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCU+To3sQITqxaljsYp7/9oHeIkYmD8RCj
        BAezkgivbvGJBCHelMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD0zteSXxhqZGxsbGFiaGZqaG
        hkrivDvZDiUICaQnlqRmp6YWpBbB9DFxcEo1MAX63Xh3PGazNO+xg0ejd4SxT5HXYfvMuiRM
        tdOzl6Xa7uvpa2Fb701bI/mqbb30gnebpknFmih27Ky8KLFy4oojx5tluqwbZv/c22eZs66t
        +1feXV5nlg3LdYWYFDt5P2WzMngdstq0xuT8xnWVSRdi3qk/MHgyd2vAisML03cte70nvSlC
        U+/xqhfv6u12PPxg8nFSQ3RccFJB0vOYQ4KVJfl+qhd2LRe5kiqw+ubeMyduBjA43LL7YTzb
        LT7eXSjx8awk3VPSJ3fJrVjLYKCntE5YRXwRy2pHHRWftz6X5bpKq2/oVmVvLuA7nn9g9tfv
        a91zE19oy5V8sHqxcq7bn+ezzhnxl7Ovdvgvza3EUpyRaKjFXFScCAAv+FScNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXtdv7qkEg5YpnBbb179gtZjQup3Z
        4vKuOWwWn3uPMFq8+XGWyeLftY0sFhu/elhsfnCMzYHDY3bDRRaPTas62TzuXNvD5tFycj+L
        x/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4MrYNfcvY8FBhYqfEyexNzA+kuxi5OSQEDCR2Hr6
        MVMXIxeHkMBuRolp3V1MEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZT4sfALG0iNsICfxKO5k8Fq
        RAS0JF7eTAWpYRb4xyjxbuJuNoiGhUwSS051s4A0sAEV7X9xA6yZX0BR4uqPx4wgNq+AnUTT
        IQibRUBV4v3mA8wgtqhAmMTOJY+ZIGoEJU7OfAI2h1PAUuL8x0PsIDazgLrEn3mXmCFscYlb
        T+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWle
        ul5yfu4mRnCEaWnuYNy+6oPeIUYmDsZDjBIczEoivLrFJxKEeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYMqp87qvzvjOWrJSzcB4wlJ+r3bvU+9YzD+J
        2ysu/PhvkipX+ZFa/+DTexV+H/oj++gNd1xCAYvzi5UHrq74LzK1Z+HGs4qdHv0fJY9xP7Zr
        uSV0ri9I//uVuob7kYb9P+Zffe+3MfuPssrntn9fQ1ey+omETmhqPWjboVZ8v6BqjfrE7TM0
        rZeZnLQN+si8V8atfG3/sUumTFvj1mZIXliu3lqzqmHvtV2qD97liuRrG3zq0DwYcO38mze2
        gbEZiaYMFXe6yluVXD5L6l/KqG06vWuu4T+N9olq91d2LfsRZW7Ad0d1QnaKTMdHM7klU3g6
        JvL4MLRrZGsf/3xqhZr1TDPWe4yZbUyX31cLKLEUZyQaajEXFScCAJcK2MwfAwAA
X-CMS-MailID: 20210617005438epcas1p41b598063c342ff446e585221fb813184
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
        <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
        <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/16/21 6:09 PM, Viresh Kumar wrote:
> On 16-06-21, 17:47, Chanwoo Choi wrote:
>> On 6/16/21 4:55 PM, Viresh Kumar wrote:
>>> On 16-06-21, 13:33, Hsin-Yi Wang wrote:
>>>> Don't limit required_opp_table to genpd only. One possible use case is
>>>> cpufreq based devfreq governor, which can use required-opps property to
>>>> derive devfreq from cpufreq.
>>>>
>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>> ---
>>>> This is tested with the non genpd case mt8183-cci with passive
>>>> governor[1].
>>>> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
>>>> ---
>>>>  drivers/opp/of.c | 20 +-------------------
>>>>  1 file changed, 1 insertion(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>>>> index aa75a1caf08a3..9573facce53a5 100644
>>>> --- a/drivers/opp/of.c
>>>> +++ b/drivers/opp/of.c
>>>> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>>>>  			lazy = true;
>>>>  			continue;
>>>>  		}
>>>> -
>>>> -		/*
>>>> -		 * We only support genpd's OPPs in the "required-opps" for now,
>>>> -		 * as we don't know how much about other cases. Error out if the
>>>> -		 * required OPP doesn't belong to a genpd.
>>>> -		 */
>>>> -		if (!required_opp_tables[i]->is_genpd) {
>>>> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
>>>> -				required_np);
>>>> -			goto free_required_tables;
>>>> -		}
>>>>  	}
>>>>  
>>>>  	/* Let's do the linking later on */
>>>> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>>>>  	struct dev_pm_opp *opp;
>>>>  	int i, ret;
>>>>  
>>>> -	/*
>>>> -	 * We only support genpd's OPPs in the "required-opps" for now,
>>>> -	 * as we don't know much about other cases.
>>>> -	 */
>>>> -	if (!new_table->is_genpd)
>>>> -		return;
>>>> -
>>>>  	mutex_lock(&opp_table_lock);
>>>>  
>>>>  	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
>>>> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>>>>  		return ERR_PTR(-ENOMEM);
>>>>  
>>>>  	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
>>>> -	if (ret < 0 && !opp_table->is_genpd) {
>>>> +	if (ret < 0) {
>>>>  		dev_err(dev, "%s: opp key field not found\n", __func__);
>>>>  		goto free_opp;
>>>>  	}
>>>
>>> Plus this and few changes to commit log.
>>>
>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>> index e366218d6736..b335c077f215 100644
>>> --- a/drivers/opp/core.c
>>> +++ b/drivers/opp/core.c
>>> @@ -893,6 +893,16 @@ static int _set_required_opps(struct device *dev,
>>>         if (!required_opp_tables)
>>>                 return 0;
>>>  
>>> +       /*
>>> +        * We only support genpd's OPPs in the "required-opps" for now, as we
>>> +        * don't know much about other use cases. Error out if the required OPP
>>> +        * doesn't belong to a genpd.
>>> +        */
>>> +       if (unlikely(!required_opp_tables[0]->is_genpd)) {
>>> +               dev_err(dev, "required-opps don't belong to a genpd\n");
>>> +               return -ENOENT;
>>> +       }
>>> +
>>
>> If you add this checking statement, I think that 
>> when using dev_pm_opp_set_rate with required-opp property, it will be failed.
> 
> Yes, that is exactly what I am trying to do here. Hsin already
> confirmed that you guys won't use this API, isn't ?
> 
> The point here is that the _set_required_opps() function only updates
> the performance state of genpds today. So it won't work for you guys
> anyway.

The devfreq driver(exynos-bus.c) has used the dev_pm_opp_set_rate()
and used the passive governor without the required-opp property.

I have a plan to use the required-opp property
between devfreq drivers (exynos-bus.c) with dev_pm_opp_set_rate().

I'll support them on later if this approach doesn't break the any
rule of required-opp property.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
