Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB26A87C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfGPMOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:14:03 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33277 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMOD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:14:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716121400epoutp031adaf6a5c6b8c3e3c8c4fb2fbb2f9108~x4i-ZCodI0372603726epoutp030
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716121400epoutp031adaf6a5c6b8c3e3c8c4fb2fbb2f9108~x4i-ZCodI0372603726epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279240;
        bh=gLGBzTyzGINyvnuzWw8l4hJ/ZhgkqrGgrOlI+es+Cx0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hc78p2mvZzrymqa+xJgLHmxzCfR3fxmhc013sk1dT+HBUGKoG7TQibEgA0MC6q9dm
         fQuyoiTttKa5Rt7EsnjxbjcoFeMaDCsIPhQ/T9DZamTRYjvmpU02kOJZCRO7+o9RW1
         I4OZppkZO4iL9n2un8DG2oUmgNhVokTdiJr2EGvw=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716121400epcas1p241518b32e1143ff332bf02f56062bb9f~x4i_wes4c1105611056epcas1p2_;
        Tue, 16 Jul 2019 12:14:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45nzpC4SvqzMqYkX; Tue, 16 Jul
        2019 12:13:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.AC.04088.38FBD2D5; Tue, 16 Jul 2019 21:13:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716121354epcas1p47d605507ac58d785fab82a7e7ae898b0~x4i5oevr50314203142epcas1p4S;
        Tue, 16 Jul 2019 12:13:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716121354epsmtrp1c1ed4b9f604ff4a9a83165c2dba9d4dc~x4i5k9rnK0050600506epsmtrp1T;
        Tue, 16 Jul 2019 12:13:54 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-58-5d2dbf83e094
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.FD.03706.28FBD2D5; Tue, 16 Jul 2019 21:13:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716121354epsmtip1a817edc8664a478c0d7d692ed4e8911d~x4i5W1ULT1146311463epsmtip1c;
        Tue, 16 Jul 2019 12:13:54 +0000 (GMT)
Subject: Re: [PATCH v4 10/24] PM / devfreq: tegra30: Don't enable
 consecutive-down interrupt on startup
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <933b99a1-ac45-25fb-e8d5-0641ec0cab18@samsung.com>
Date:   Tue, 16 Jul 2019 21:17:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-11-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0gTYRjm293OW3T1tbTeDGqdFGgtd+rWGRpBUaOCrCDKGnbooeJ+tZtR
        SVBpmZKmZUTL7DeUVpL4Y1oxmEMpykrpB5kRKWUmzbKssLJtZ+R/z/t8z/O+3/N+H02oa6lI
        OtvqFB1WwcxSk8jG1midNt+jNelcjzR8zedexBe4LpL8w4ODYXxXSyXFD5f4EF/01UXx3Qeu
        UvzPliqSL73RSS1XGd09l5Gx2dUTZizJ/0QZS+urkXG4bk6KMjUnKUsUMkSHRrSm2zKyrZnJ
        7NpNaSvS9AYdp+US+SWsxipYxGR25boU7apsc+BCrGaXYM4NUCmCJLGxy5IctlynqMmySc5k
        VrRnmO2J9sWSYJFyrZmL022WpZxOF6cPCHfkZD2/eo6wP1btbrz5ndiP/oQVIxUNOAH8XSOK
        YjSJVmM3gn5PNSkXXxBUdPoJuRhB4K0dpv5ZrrTVhskHdxF8fvVx3O9H0HT9GBlUTcfZMPhm
        KNQrHP9BUPQzP2Qn8FZoba5RBDGFY8DT/yLET8Xz4OmPXlSMaJrBy8D/kQnSJJ4P/c2toZ4R
        eAvc91WFMIOnwb3TfWRQrsIGePaEkbvPhJd95xQyngv5DWdCCQCPUVA2cFIpJ1gJhZ5WJOPp
        MNBeP76MSPhw7PA4zoNr93yUbD6CoN7zeNwcD54rJxTBwQSOhtqWWJmeB82jZ5E8eAp8+nZU
        GZQAZuDIYbUsiYKuNz0KGc+CS4VFVBliXRPSuCZEcE2I4Po/7Dwiq9EM0S5ZMkWJs3MTX7sO
        hT5rjN6NKjrWeRGmETuZ0XgWmdRKYZe0x+JFQBNsOJP8baFJzWQIe/aKDluaI9csSl6kDyy7
        nIiMSLcFvr7Vmcbp4+Lj4/kEzqDnOHYmU/Ur2qTGmYJTzBFFu+j451PQqsj96EBNSUHHqo1j
        le/LR3d6DLFPT6du25xkPVS1zRS3fehEQmNBaeGCBz1jm5Xb8zrLylj36+Nxvy+spwcTyQ3s
        7agR9yP7qLbpdnje+47hiDUmf2J5N114avWmgYqhtn13cFMx6py91NC9Nsqnf2uC/oq6lvR9
        jjXCO5+3veEWpZFYUsoSuBjCIQl/AQ1EirLCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG7Tft1Yg/710harPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ11fMZy64wFmxbd135gbGf+xdjJwcEgImEkuP
        rQeyuTiEBHYzSkxY9h0qISkx7eJR5i5GDiBbWOLw4WKImreMEk86HrKA1AgLZEq8efCBBSQh
        ItDEJLGp9wJYM7NApETP3C1sEB1bGCV+dExiA0mwCWhJ7H9xA8zmF1CUuPrjMSPIBl4BO4n3
        r3lBwiwCqhIvdh4GWyAqECEx6dpOMJtXQFDi5MwnLCDlnAJmEtcu8kKsUpf4M+8SM4QtLnHr
        yXwmCFteonnrbOYJjMKzkHTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al
        6yXn525iBEeYluYOxstL4g8xCnAwKvHwntijEyvEmlhWXJl7iFGCg1lJhNf2q3asEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwlJvEle5wZQrfd4b6S
        ETG7seRC6pY9y5+eLY7dfXUab1/UcdHJitJHffbtUfvnWCj9lvVrzbl32mvKP7/yzbz4O0mo
        e2fCJ8bdT3/rxF0tPHbbNf7C1YyqKZe2f8zexVAvVPfl/Ycbl62+SlikXei8uqJktkJ/Q+wh
        nv7mn+VZ8ul/zt+JmteixFKckWioxVxUnAgASaoPwKwCAAA=
X-CMS-MailID: 20190716121354epcas1p47d605507ac58d785fab82a7e7ae898b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223642epcas4p1fbfbcf5181e9a25fbbaad9ef95c56f8f
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223642epcas4p1fbfbcf5181e9a25fbbaad9ef95c56f8f@epcas4p1.samsung.com>
        <20190707223303.6755-11-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> The consecutive-down event tells that we should perform frequency
> de-boosting, but boosting is in a reset state on start and hence the
> event won't do anything useful for us and it will be just a dummy
> interrupt request.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 32fe95458ee7..878c9396bb8c 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -558,7 +558,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
>  	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
> -	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_ENB;
>  
> 

Maybe, I think that better to review it by Thierry.
I'm not sure it is right or not because it depend on h/w.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
