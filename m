Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE431DE07D
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgEVG6R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 02:58:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53584 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEVG6Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 02:58:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200522065813epoutp04ceb780efee883b9f99a0f8cf9f60ab99~RR3DCCwF01241112411epoutp04V
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 06:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200522065813epoutp04ceb780efee883b9f99a0f8cf9f60ab99~RR3DCCwF01241112411epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590130693;
        bh=fjkMXe+YmN/5yp/JORsAYIY2lVP6T4CaRaOljPc5+qk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K3Jn+dorxhnm8bRY66RdVd4z5X7dDFC2vrhB3oa7ZJZ3aYuujz4VnvAzr6LRqsWjx
         sLT5Vsun2/heynspQ51ZZiQ1ketrzf5LKPLupfgVA4FyOy/kGf/hLgW1XNLcb54txL
         vNMOrLPQDcCfjNhQdThkXmvdy7yQM+BsqgkK4Hyg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200522065812epcas1p4f4856a57f16e49db37a98cf996928eed~RR3Cr2n6Q0947709477epcas1p45;
        Fri, 22 May 2020 06:58:12 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49Sy4K5Jz8zMqYkb; Fri, 22 May
        2020 06:58:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.50.04544.10877CE5; Fri, 22 May 2020 15:58:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522065809epcas1p16e7a70dae1754f364f088c0e3ed01bf1~RR2-oviBU2344923449epcas1p1Z;
        Fri, 22 May 2020 06:58:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200522065809epsmtrp2a3b3682de306f22aa9d1d4b352c12728~RR2-n2fet2531325313epsmtrp2T;
        Fri, 22 May 2020 06:58:09 +0000 (GMT)
X-AuditID: b6c32a36-7ffff700000011c0-99-5ec778016225
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.EC.18461.10877CE5; Fri, 22 May 2020 15:58:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522065809epsmtip232901c459100cf7ee1201e59c30895d5~RR2-VS56P2872028720epsmtip2z;
        Fri, 22 May 2020 06:58:09 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] extcon: max14577: Add proper dt-compatible
 strings
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8ec0c604-8cdc-04f8-fc5c-fd967f52022b@samsung.com>
Date:   Fri, 22 May 2020 16:08:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200522064801.16822-2-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURSAuzu7s2O4dlstTxalI/3IUHe0tdFVC5ISsrKifoSPBp10c1/u
        rKFFpCW+ekpJZWZqRLaSlYiapqKtlhVaSCmKUSQWmhbZkyjacZT8991zvsM5595LEepy0ovS
        m2y81cQZaHKhvOHhGn9/lPkoQdN4di1779IdBVvydpRk+/ruKtn+5jKSnT7tQOxtx4iSHc6p
        JtmnLbaNVHSdvZCMPlNvR9HTdStjiX1p4ak8l8xbvXlTkjlZb0qJoLfuTtyUqA3RMP5MKLue
        9jZxRj6CjoqJ9d+sNzgHoL0PcYYMZyiWEwQ6MDLcas6w8d6pZsEWQfOWZIMl1BIgcEYhw5QS
        kGQ2hjEaTZDWKe5PS32VPyKz/HHL/PH1PcpG1a5FyIUCvA4cNeWyIrSQUuMmBK3TZ5TS4QuC
        3oJiJFpq/B3B5PENcxVVhbUKSWpF0J9/cbbiE4LHL4uUouWOY6Fg9LNMZA+sB0fv+EwFgV8g
        GDtdTIoJEvtB+4fBGV6EfeDlz3cz7VQ4Ei48uy0XWY5XQ3/joELkJXgv9DTkzjqLoefyqNOh
        KBen/8u+WQwT2BOGRq/JJF4FjZNlhDR1CQVdHzUSR0FOy1+5xO4w/qheKbEXTE+1khIfgVs9
        DlKcGXABgvr25wopEQztN87LxL4EXgN3mgOlsA/c/30VSX3dYOrbKYWoAFZBQZ5aUnyh/82I
        TOJlcD2/kDyH6NJ5y5TO26B03gal/5tVILkdLeUtgjGFFxhL0PzHrkMzf9MvpAlV9cZ0Ikwh
        2lXFHuhOUCu4Q0KWsRMBRdAeqspFXQlqVTKXdZi3mhOtGQZe6ERa510XE15LkszOn26yJTLa
        oODgYHYdE6JlGNpTVTJgSFDjFM7Gp/G8hbfO1ckoF69sVKuL+eLjuXOAsb5Ob2h7Utm3Ma7N
        Ted7s2Nn+p7mBVf8fM+HwZapsvvxOvKs+z6GqYjXH9z14Prv/GNRTUdrIl1quW1X3IZN7hOX
        bg4dqI4U2lZ2l+niTqSN/fCIvxuW26G7YFuet715h+/JsYF7de9W2BULXg/uits7ET6FNthX
        1dByIZVj/AirwP0DY48IcrEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvC5jxfE4g+fdAhYbZ6xntZj68Amb
        xfnzG9gtLu+aw2bxufcIo8XaI3fZLW43rmCzOL27xIHDY9OqTjaPvi2rGD0+b5ILYI7isklJ
        zcksSy3St0vgyrjWfpep4C9fxfcvzxkbGFfwdDFyckgImEgs6lzHCmILCexmlJi2sx4iLikx
        7eJR5i5GDiBbWOLw4eIuRi6gkreMEi/WTGMGqREW8JP4s+MwG4gtIpApsWP/RSaQImaBy4wS
        W2/2MEJ0HGWU2PhjL1gHm4CWxP4XN8A6+AUUJa7+eMwIYvMK2ElMObOWBcRmEVCVuLz9BthF
        ogJhEjuXPGaCqBGUODnzCQvIRZxA9T9XuYGEmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG
        4VlIumchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0hLcwfj
        9lUf9A4xMnEwHmKU4GBWEuFdyH80Tog3JbGyKrUoP76oNCe1+BCjNAeLkjjvjcKFcUIC6Ykl
        qdmpqQWpRTBZJg5OqQamxF22k16xfowyet3D6lj38qGLvrq+3l5WlR/HZA7pOmulsPFd8e7N
        +HTp27WvMYVtAbN/3hb5uGzLXuG4fVxPShVymVnUDEMPf7A0kO45+kryYaWOVOc03+UBq7in
        1v5fv32H/tf2yc/833qZrjm+uP2zYcDNCSsEt894VzZl4oSKXbvqeDWDW2KV4294+57L/Z+7
        Z/nxxXe2+Ry+8suhvOiw/ofKyoCXZ90Mj+u+uKwUdF8p7PWtzJCejbtvrHK37r7IdHrT6TXt
        Tzp3sH3w/3SXx3iKiGrdEcXFT5waxV7XmRVtztWYdrLI9pDs1F+fb7b8f+7AsVz1mf7Xzprn
        R8WZkqVtD+8r51l+xe17tBJLcUaioRZzUXEiAHbeXLwPAwAA
X-CMS-MailID: 20200522065809epcas1p16e7a70dae1754f364f088c0e3ed01bf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
References: <20200522064801.16822-1-m.szyprowski@samsung.com>
        <CGME20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8@eucas1p2.samsung.com>
        <20200522064801.16822-2-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/22/20 3:48 PM, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - added .of_match_table pointer
> ---
>  drivers/extcon/extcon-max14577.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index 32f663436e6e..03af678ddeba 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -782,9 +782,19 @@ static const struct platform_device_id max14577_muic_id[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, max14577_muic_id);
>  
> +static const struct of_device_id of_max14577_muic_dt_match[] = {
> +	{ .compatible = "maxim,max77836-muic",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> +	{ .compatible = "maxim,max14577-muic",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> +	{ },

How about changing the order between max77836 and max14577 as already added structure
like platform_device_id if there are no specific reason as following:?


static const struct of_device_id of_max14577_muic_dt_match[] = {
	{ .compatible = "maxim,max14577-muic",
	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
	{ .compatible = "maxim,max77836-muic",
	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
	{ },



> +};
> +MODULE_DEVICE_TABLE(of, of_max14577_muic_dt_match);
> +
>  static struct platform_driver max14577_muic_driver = {
>  	.driver		= {
>  		.name	= "max14577-muic",
> +		.of_match_table = of_max14577_muic_dt_match,
>  	},
>  	.probe		= max14577_muic_probe,
>  	.remove		= max14577_muic_remove,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
