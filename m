Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE991CA1A7
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 05:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEHDpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 23:45:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43950 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgEHDpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 23:45:42 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200508034539epoutp0436bdf579ca5791fa87999e7d7c5fb64e~M8M62ZSpA2388023880epoutp04S
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 03:45:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200508034539epoutp0436bdf579ca5791fa87999e7d7c5fb64e~M8M62ZSpA2388023880epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588909539;
        bh=UO3iW9DISH8dA+Je/AgEClRF+xn2Pj+zZidQx/tI2eE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PiG8RslPjNG1CaHm/CuTkbI91ZEcBJqw21STbVVZ9xdCEJJTc6R5tW9aHAsNRqNF5
         xGkSHN8ZzvZj9F3DPVVoR5eMZdT2wH1APn/HpwvpatdVhwB0n4qRQ5LBFcT5K02+DV
         eCEVaCmP3wEOpGcTTyWySCp3iqyHrce0ItTOjK8k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200508034538epcas1p4669207f8f90bb6437c9002d57374e1e0~M8M6ZslId1187811878epcas1p4J;
        Fri,  8 May 2020 03:45:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49JGSY019gzMqYm5; Fri,  8 May
        2020 03:45:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.D7.04402.CD5D4BE5; Fri,  8 May 2020 12:45:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200508034532epcas1p110aa15a6425f20583f4e42607c097e55~M8M0Y_puW0977109771epcas1p1X;
        Fri,  8 May 2020 03:45:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200508034532epsmtrp1caff9b94a7a42ead1b51cabe808a2529~M8M0YJ_xg0687006870epsmtrp1O;
        Fri,  8 May 2020 03:45:32 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-f3-5eb4d5dcce82
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.5C.18461.CD5D4BE5; Fri,  8 May 2020 12:45:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200508034531epsmtip1c92a9dec3b4fc8d20c42d26544a9b0cb~M8M0EPazn0818608186epsmtip1R;
        Fri,  8 May 2020 03:45:31 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: imx: Fix inconsistent IS_ERR and PTR_ERR
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <82fc7219-b9c7-c5fa-10b1-692f6a5ed411@samsung.com>
Date:   Fri, 8 May 2020 12:55:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200507131245.GA709@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmnu6dq1viDCYdt7R4eNXfYuseVYtf
        F6exWqyaupPF4mzTG3aLFXc/slpsenyN1aLr10pmi8u75rBZfO49wmhxu3EFm8Xf7ZtYLF5s
        EXfg9Vh3UNVj56y77B6bVnWyeWxeUu+x8d0OJo/+vwYefVtWMXp83iQXwBGVbZORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvj1IIW1oJZnBX9
        l28wNjDuYu9i5OSQEDCRuHBtJ1MXIxeHkMAORom/DUeZQRJCAp8YJda2q0EkvjFK3DyxGKiK
        A6xj0VEtiJq9jBJLrtZB1LxnlLhw5A4bSEJYwFviwZLtzCAJEYHfTBKv5m5lBHGYBSYxSmze
        vZ8VpIpNQEti/4sbYB38AooSV388ZgTZwCtgJ/FlYiBImEVAReLdniawU0UFwiRObmthBLF5
        BQQlTs58wgJicwroSTw8fgEsziwgLnHryXwmCFteYvvbOWBHSAjc4JBYc7QR6gMXiUVTfSHe
        F5Z4dXwLNCikJF72t0HZ1RIrTx5hg+jtYJTYsv8CK0TCWGL/0slgc5gFNCXW79KHCCtK7Pw9
        F+oGPol3X3tYIVbxSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJvZiH5YBaSD2YhLFvAyLKK
        USy1oDg3PbXYsMAQOa43MYLTsZbpDsYp53wOMQpwMCrx8Fp83BwnxJpYVlyZe4hRgoNZSYR3
        YsWWOCHelMTKqtSi/Pii0pzU4kOMpsDAnsgsJZqcD8wVeSXxhqZGxsbGFiaGZqaGhkrivFOv
        58QJCaQnlqRmp6YWpBbB9DFxcEo1MIbHC8ybyZ/2k131RFj1NGuLTa/eXLT/sLX/4w9+xcdH
        JpSUGvNKnndp6GU1SutsfbvOrjZ/UodYRvDGP97/rOW+fuHNq4kTrpuROtuyr+NLxhyn//PX
        71HqC1DUOrDLaI2ThdeqiOlW5koxJzafP9DseaTT/tbDwuh84yM3dNvvPu189rJUTomlOCPR
        UIu5qDgRANuzjW3dAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO6dq1viDDZ+ZrF4eNXfYuseVYtf
        F6exWqyaupPF4mzTG3aLFXc/slpsenyN1aLr10pmi8u75rBZfO49wmhxu3EFm8Xf7ZtYLF5s
        EXfg9Vh3UNVj56y77B6bVnWyeWxeUu+x8d0OJo/+vwYefVtWMXp83iQXwBHFZZOSmpNZllqk
        b5fAlXFqQQtrwSzOiv7LNxgbGHexdzFycEgImEgsOqrVxcjFISSwm1FiQtc+li5GTqC4pMS0
        i0eZIWqEJQ4fLoaoecsosX7RKjaQGmEBb4kHS7YzgyREBP4ySbTcXQSWYBaYxCjxeXU+iC0k
        0Mgo0f+dA8RmE9CS2P/iBlgNv4CixNUfjxlBFvAK2El8mRgIEmYRUJF4t6eJHcQWFQiT2Lnk
        MROIzSsgKHFy5hOw2zgF9CQeHr/ACLFKXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJ6FpH0W
        kpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjODK1NHcwbl/1Qe8Q
        IxMH4yFGCQ5mJRHeiRVb4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInz3ihcGCckkJ5YkpqdmlqQ
        WgSTZeLglGpgCpG+s+SUlFOjssOhbd8tj2dePL1/TkZ+Pv+XXNFK1mt1y9+nitm8Uk2r3bFN
        qXvOiQNxF8+dML+21Sl8yvngGG5PW7dIfQ7mV7aP+E5GH5/1r+5sGKuUqtrWEGmOs6Wqhfo9
        XeaZ7q+tQg9rTcn3Lbf0K1cyt+/ysQ96KhS7i3HLq4vz7K/Zrb9/liV5yRGL9I6mznkrw81W
        r3H12fxW7GK8ZKCL7K+1jo90y0Wu/3m57Kb/g7XMZab2uew5ZlxSt3vn6dr/+nD4094jndwq
        P252d0pwOz2SnyjT78Z8QObcP1XV1x9+5T/14bph+UD487qXN1zNHc7Ne/V5TfI6mYY9+zYq
        Zp70azIxzjFWYinOSDTUYi4qTgQACLN/SjsDAAA=
X-CMS-MailID: 20200508034532epcas1p110aa15a6425f20583f4e42607c097e55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200507130824epcas1p287961e0a2f5019a55ecd1c94772fdfff
References: <CGME20200507130824epcas1p287961e0a2f5019a55ecd1c94772fdfff@epcas1p2.samsung.com>
        <20200507131245.GA709@embeddedor>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/7/20 10:12 PM, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in imx_bus_init_icc().
> 
> The proper pointer to be passed as argument to PTR_ERR() is
> priv->icc_pdev.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: 16c1d2f1b0bd ("PM / devfreq: imx: Register interconnect device")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/devfreq/imx-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 532e7954032f..4f38455ad742 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -88,8 +88,8 @@ static int imx_bus_init_icc(struct device *dev)
>  			dev, icc_driver_name, -1, NULL, 0);
>  	if (IS_ERR(priv->icc_pdev)) {
>  		dev_err(dev, "failed to register icc provider %s: %ld\n",
> -				icc_driver_name, PTR_ERR(priv->devfreq));
> -		return PTR_ERR(priv->devfreq);
> +				icc_driver_name, PTR_ERR(priv->icc_pdev));
> +		return PTR_ERR(priv->icc_pdev);
>  	}
>  
>  	return 0;
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
