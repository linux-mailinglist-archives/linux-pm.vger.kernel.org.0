Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1E34DDEC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 04:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC3CBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 22:01:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21867 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhC3CBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 22:01:44 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210330020142epoutp03f81818d5bd0138ca190670ec3464c44b~w-FOlA3px2685226852epoutp03n
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 02:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210330020142epoutp03f81818d5bd0138ca190670ec3464c44b~w-FOlA3px2685226852epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617069702;
        bh=5LHwGUnv+7Yz8Cd8SMnGnbGl0pOMxtIm799tDYb5xXM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nOt/ALdBtHZ5MAclb1WdiStfJ6JJEYsOhLGCCWFfRhJt+FraNxU0msEXIMjjPxAiz
         3H1kQ90dSpkMHyA0hm8lkW95DSDVHqxeVi5MYjHIZbazmMBIUk+ePN9zyQIVkSd/r4
         KrZ5YwvC4ZvlbImNDIek8b0xYcUNB7y73amYqmFk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210330020137epcas1p277085e822ae27da4f25cc8a5b9461e7a~w-FKDf-Ss1342613426epcas1p2V;
        Tue, 30 Mar 2021 02:01:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F8Xk71jZTz4x9Pv; Tue, 30 Mar
        2021 02:01:35 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.19.22618.97682606; Tue, 30 Mar 2021 11:01:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210330020124epcas1p29d8c60d272b5c95a2bbf35d0910ee53a~w-E_Vsd7g2051320513epcas1p2n;
        Tue, 30 Mar 2021 02:01:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210330020124epsmtrp21bceb73e7d92ad35bc8ae9237d361ccd~w-E_VF6xK1872018720epsmtrp2H;
        Tue, 30 Mar 2021 02:01:24 +0000 (GMT)
X-AuditID: b6c32a38-3f2a8a800001585a-cc-6062867975d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.2F.08745.47682606; Tue, 30 Mar 2021 11:01:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210330020124epsmtip26b6b7f5b0e2f02a33d6d98ccedcb3670~w-E_GAkDj3060630606epsmtip2B;
        Tue, 30 Mar 2021 02:01:24 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: imx8m-ddrc: Remove unneeded
 of_match_ptr()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <481127dc-1112-35d5-ba77-096eafab01e0@samsung.com>
Date:   Tue, 30 Mar 2021 11:18:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210329122425.579386-2-festevam@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvm5lW1KCwf5mUYuHV/0tun6tZLb4
        3HuE0YHZY+esu+weG9/tYPL4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Cy
        QK84Mbe4NC9dLzk/18rQwMDIFKgwITvj4Jv57AXz2Su+PuZpYPzG2sXIwSEhYCLR9VOhi5GT
        Q0hgB6PEqrk8XYxcQPYnRom+p+uZIZzPjBLLti1gAakCa1jdxQrRsYtR4lSTCoT9nlFi5vMI
        EFtYIFhi9cp5TCALRATUJE7P0wcJMwvoS9xc/ogNxGYT0JLY/+IGmM0voChx9cdjRhCbV8BO
        YlpPDxOIzSKgKvHo8kMwW1QgTOLkthaoGkGJkzOfgJ3DKWApcXbeZ2aI+eISt57MZ4Kw5SW2
        v50Ddr+EwEt2iavXWlgh7neRWP93HdQvwhKvjm9hh7ClJD6/28sGYVdLrDx5hA2iuYNRYsv+
        C1DNxhL7l04Ge4xZQFNi/S59iLCixM7fcxkhFvNJvPvaAw1cXomONiGIEmWJyw/uMkHYkhKL
        2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIEf0JkZw8tOy2ME49+0HvUOM
        TByMhxglOJiVRHiFDyQmCPGmJFZWpRblxxeV5qQWH2I0BQbwRGYp0eR8YPrNK4k3NDUyNja2
        MDE0MzU0VBLnTTJ4EC8kkJ5YkpqdmlqQWgTTx8TBKdXAVOApsDlTz9h69e+jPeuruFaKNOh6
        8wWKfGYXfldYbxl6OzO5J2DRvOdbJp6pZLrZ8lCrd9uU9Ye5G+cH1Ete2D+XlSPBnH3NOwvH
        j7ETGLdWeqk5cbK0pszITe5rXeHwUPOtauQnmxK/yXJL/p+qeLDsIP8Fx32nzK2SOqe/feYz
        dSLzo7iq2aUd/xa+6d27gNn20LHjgsoLl0TwrTw6aVWXW8uuNSoydXZKD39r/5ngO/lTt3nS
        HYdjqS9lFNLmbecIDVQTO7Zr8uTJgfzn4jykF1vffyy4Zfdqb7v2pKu3F3oaRM6KjzrCXrNP
        w93lmB53gr4zvwnvi4DExlnb49cESTHql667qTy5uXuhEktxRqKhFnNRcSIAjnNRgQcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvG5JW1KCwY5LJhYPr/pbdP1ayWzx
        ufcIowOzx85Zd9k9Nr7bweTxeZNcAHMUl01Kak5mWWqRvl0CV8bBN/PZC+azV3x9zNPA+I21
        i5GTQ0LARKJrdReYLSSwg1Hi0HlbiLikxLSLR5m7GDmAbGGJw4eLuxi5gEreMkrcnvCcHaRG
        WCBYYvXKeUwgNSICahKn5+mDhJkF9CVuLn/EBlG/m1Hiy/1DjCAJNgEtif0vbrCB2PwCihJX
        fzwGi/MK2ElM6+lhArFZBFQlHl1+CGaLCoRJ7FzymAmiRlDi5MwnLCA2p4ClxNl5n5khlqlL
        /Jl3CcoWl7j1ZD4ThC0vsf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWl
        lusVJ+YWl+al6yXn525iBMeCltYOxj2rPugdYmTiYDzEKMHBrCTCK3wgMUGINyWxsiq1KD++
        qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpu3nvjqLid6PT855p7Zf3k5/
        h/cKxkT5lXzt7Pc/fo/nmD7bUvrznOnvnAOPNWrK7Nrc/26vaVN27da9Bl3xkqW13P+6JBU4
        y1j7E055bOMvmWW8lzVU+XH5ieJ2m8PC5+eWH3AsT1lbn6oTfcx8HUcwV9Ple/efm/exbTGf
        PIHXRi9c1KpAZT9b8/NbyxyvlD6SlP8lr5vSs2tV/Np9axunrHXk7lcUCN6wPuLkNdHPgYkm
        3mu81tQWLnm7KcTm3TRn7Rfl2fqOlWXzzmvOjriuyn6D4SZ/R/TyfQ8T9k5qX+KjXSsw4crT
        hx90Nhj7eq26KvOh9EBB5/+nDvYhd+d7J8l1f//lamu65kC6EktxRqKhFnNRcSIAiSqaTfQC
        AAA=
X-CMS-MailID: 20210330020124epcas1p29d8c60d272b5c95a2bbf35d0910ee53a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210329122449epcas1p1be5b4b7adc60a1826384aa6d38430b22
References: <20210329122425.579386-1-festevam@gmail.com>
        <CGME20210329122449epcas1p1be5b4b7adc60a1826384aa6d38430b22@epcas1p1.samsung.com>
        <20210329122425.579386-2-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/29/21 9:24 PM, Fabio Estevam wrote:
> i.MX is a DT-only platform, so of_match_ptr() can be safely
> removed.
> 
> Remove the unneeded of_match_ptr(). 
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/devfreq/imx8m-ddrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index ecb9375aa877..16636973eb10 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -447,7 +447,7 @@ static struct platform_driver imx8m_ddrc_platdrv = {
>  	.probe		= imx8m_ddrc_probe,
>  	.driver = {
>  		.name	= "imx8m-ddrc-devfreq",
> -		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
> +		.of_match_table = imx8m_ddrc_of_match,
>  	},
>  };
>  module_platform_driver(imx8m_ddrc_platdrv);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
