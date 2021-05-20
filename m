Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC5389B6F
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 04:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhETCef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 22:34:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:25431 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhETCee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 22:34:34 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210520023312epoutp0443446b0d7c18eb4c80a793edff65620d~ApaSUXF__1795317953epoutp04f
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 02:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210520023312epoutp0443446b0d7c18eb4c80a793edff65620d~ApaSUXF__1795317953epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621477992;
        bh=y7pEOKzydJlktygq2zR8R8Kn1nJxrI0emKobaLyuO8A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QXL0IyaHU+JFOUlZWRgJD/HF3m76eFM7e8M63/SZYBmSzntwQfNl9pR6+GAec3xO4
         7khGPf2D9cY8LCQ0Xin3fIzga1zwhmhx8fPvRLyIDuGl1o7NIEYCEpeMAefV48UZUs
         10DWTHsZmnZLdybUTXLTi91YDDJfih4bOGJuxLnI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210520023311epcas1p1d68ce34e9d2fc27c1b9e41159a0a24b5~ApaR10-IQ2641226412epcas1p1F;
        Thu, 20 May 2021 02:33:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Flv114plWz4x9QJ; Thu, 20 May
        2021 02:33:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.D5.10258.56AC5A06; Thu, 20 May 2021 11:33:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210520023309epcas1p1422170758b3ec6ad58920a50fc6e15dc~ApaPqVNFk0367903679epcas1p1k;
        Thu, 20 May 2021 02:33:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210520023309epsmtrp242eebde5a07a33b9f1087a1fe6ae0e39~ApaPkjw712077920779epsmtrp2J;
        Thu, 20 May 2021 02:33:09 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-2b-60a5ca65b854
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.D3.08163.56AC5A06; Thu, 20 May 2021 11:33:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210520023309epsmtip16bc49a17228c5c25565ddebb31228af3~ApaPZlmRk0623106231epsmtip1F;
        Thu, 20 May 2021 02:33:08 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: imx-bus: Remove
 imx_bus_get_dev_status
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e04987ea-0e97-9e79-5b59-b4f4df165939@samsung.com>
Date:   Thu, 20 May 2021 11:51:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210519070545.1728197-1-aisheng.dong@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmrm7qqaUJBgsWqlksu3SU0eLL1F3M
        Fn83T2ezWDV1J4vF2aY37BabHl9jtej6tZLZ4nPvEUaL240r2CxebBF34PLYOesuu8emVZ1s
        HpuX1HtsfLeDyaP/r4FH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM54/u0lc8Fz3oqVK7sYGxiXcHcxcnJICJhIPN+3
        iA3EFhLYwSgx6b5TFyMXkP2JUaL53XJmCOczo8SBZcsYYTou7DzGCJHYxShxbNYrdoj294wS
        z5fLgNjCAv4Sm968YgaxRQQcJdY/PsoK0sAscJxR4tCubiaQBJuAlsT+FzfAdvMLKEpc/fEY
        bAOvgJ3EjacTwYayCKhKXJj+kRXEFhUIkzi5rQWqRlDi5MwnLCA2p4CNxMQXT8HizALiEree
        zGeCsOUltr+dwwxx9QEOic2XZSFsF4kvf56zQtjCEq+Ob2GHsKUkPr/bywZhV0usPHmEDeRo
        CYEORokt+y9ANRhL7F86GWgBB9ACTYn1u/QhwooSO3/PhbqBT+Ld1x5WkBIJAV6JjjYhiBJl
        icsP7jJB2JISi9s72SYwKs1C8s0sJB/MQvLBLIRlCxhZVjGKpRYU56anFhsWmCBH9iZGcLrV
        stjBOPftB71DjEwcjIcYJTiYlUR4t3svThDiTUmsrEotyo8vKs1JLT7EaAoM34nMUqLJ+cCE
        n1cSb2hqZGxsbGFiaGZqaKgkzpvuXJ0gJJCeWJKanZpakFoE08fEwSnVwBR7o3h/U0yFz+Yz
        p2ZkObqkH/qWeVf+334Xr7yDJhGt+QFRin8WXxcrZxU4wmVhnM5QrLWfjdsz4P29Y7IVt6Ze
        Oi6398ecQ95pSo2/ru5+fnvn2o87up/GzRU/3/qb/eOe9ErhHR8vXwyXqoi5vG2186kXTGcZ
        Ji0SvxI3WW5H2r4JuY+yq+dq+GtzXFj2vLTXTS0hSOu5yOGK2U+Y+YT4WGz3NJ9Yc7zr01n+
        O0LCq9OZ5q1Vf/3zhsC776v+MMTM3Gj966/oWTbpx2sYnR9Nmb7VPbdh8ewZORwrHO96OU14
        9yszTmflwiV/LwXM3n1v/+NSUaZTfbd0hK0/cp17kjQvdMpNeZXDG1U89YsPKbEUZyQaajEX
        FScCAOZG9aVABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7qqaUJBv9/s1ssu3SU0eLL1F3M
        Fn83T2ezWDV1J4vF2aY37BabHl9jtej6tZLZ4nPvEUaL240r2CxebBF34PLYOesuu8emVZ1s
        HpuX1HtsfLeDyaP/r4FH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZTz/9pK54DlvxcqVXYwN
        jEu4uxg5OSQETCQu7DzG2MXIxSEksINRYvKexcwQCUmJaRePAtkcQLawxOHDxRA1bxkldred
        ZQGpERbwldh95yGYLSLgKLH+8VFWkCJmgeOMEteXzGOH6OhnlJg9rxOsik1AS2L/ixtsIDa/
        gKLE1R+PGUFsXgE7iRtPJ7KD2CwCqhIXpn9kBbFFBcIkdi55zARRIyhxcuYTsDmcAjYSE188
        BetlFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5N
        zy02LDDKSy3XK07MLS7NS9dLzs/dxAiOPi2tHYx7Vn3QO8TIxMF4iFGCg1lJhHe79+IEId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpjaLpZIaldctJ5x
        +o7X1xtRC5QLRR+GtObX+/o1FV5fvNUmZIk5Uww7T8iy8xLL+D6tap7Xu+Ia3zSej6+zhVi/
        v+Nk5mtsc/zuyuy66O/xcw/3TpAKjpko7d+d2Ru16J9Gkb3RpzeT21d2Lbg11fqAerHZrFot
        z5KX9y8Iv7SdNDHJOfrJr+7Yg7uneb1xOKoRvqzmxI21jB9L4yueFW+Y4vS+76b4nZnHjk+6
        qLXYJbNfREh3tdWqVa92u9wpyL48c5rbg6Agy/V/8nYeV98a73/sZnF00TXOLeeNbIKZAkt/
        TLeM+CA7Z5aXAFvvCwseti+/Elb5HBVJf+q1O2Lp3/yLa7OuNHakR/i9+/VAiaU4I9FQi7mo
        OBEAHy4QUi0DAAA=
X-CMS-MailID: 20210520023309epcas1p1422170758b3ec6ad58920a50fc6e15dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210519070646epcas1p278827601f2ce81e96e088f8fcac31d32
References: <CGME20210519070646epcas1p278827601f2ce81e96e088f8fcac31d32@epcas1p2.samsung.com>
        <20210519070545.1728197-1-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/19/21 4:05 PM, Dong Aisheng wrote:
> Current driver actually does not support simple ondemand governor
> as it's unable to provide device load information. So removing
> the unnecessary callback to avoid confusing.
> Right now the driver is using userspace governor by default.
> 
> polling_ms was also dropped as it's not needed for non-ondemand
> governor.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/devfreq/imx-bus.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 3fc3fd77492d..f3f6e25053ed 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -45,18 +45,6 @@ static int imx_bus_get_cur_freq(struct device *dev, unsigned long *freq)
>  	return 0;
>  }
>  
> -static int imx_bus_get_dev_status(struct device *dev,
> -		struct devfreq_dev_status *stat)
> -{
> -	struct imx_bus *priv = dev_get_drvdata(dev);
> -
> -	stat->busy_time = 0;
> -	stat->total_time = 0;
> -	stat->current_frequency = clk_get_rate(priv->clk);
> -
> -	return 0;
> -}
> -
>  static void imx_bus_exit(struct device *dev)
>  {
>  	struct imx_bus *priv = dev_get_drvdata(dev);
> @@ -129,9 +117,7 @@ static int imx_bus_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	priv->profile.polling_ms = 1000;
>  	priv->profile.target = imx_bus_target;
> -	priv->profile.get_dev_status = imx_bus_get_dev_status;
>  	priv->profile.exit = imx_bus_exit;
>  	priv->profile.get_cur_freq = imx_bus_get_cur_freq;
>  	priv->profile.initial_freq = clk_get_rate(priv->clk);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
