Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732742E618
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhJOBWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 21:22:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:13586 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhJOBWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 21:22:02 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211015011955epoutp03e7204a5e69a689638fc4ed0b0c99abbe~uD4jNvMZA1027910279epoutp03c
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 01:19:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211015011955epoutp03e7204a5e69a689638fc4ed0b0c99abbe~uD4jNvMZA1027910279epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634260795;
        bh=CLKo7JKkEg2JzyPd7YFllggEgYeaX8SoFPqSKCp0ITU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WDhwA2m1+ZRz7hnVMDhvsbvpLAPuMfnntBc2/lNsXOLTtCVazVvS+DwKHgptdeqHG
         X3UIkBcp3otDYWVmz8SpSQcGVv19xv+F8S2rA+Tx0aO58yMLlUjDm+KNJz5f8iBYtF
         0YAtCZbF5jJS4rpA4mCUp/bT1AJcAemHwN6eq5tg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211015011954epcas1p178f7c6f422611c41cb00c5b9b63cb195~uD4iiOWUf1842318423epcas1p1e;
        Fri, 15 Oct 2021 01:19:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HVpMl416jz4x9QG; Fri, 15 Oct
        2021 01:19:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.93.13888.027D8616; Fri, 15 Oct 2021 10:19:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211015011927epcas1p301f6749bbe0833b956ac39b414d7133a~uD4JoKXzO1208012080epcas1p3M;
        Fri, 15 Oct 2021 01:19:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211015011927epsmtrp103e06c99ab870683b0eb479bb13d94fc~uD4JnPwAX1752317523epsmtrp1x;
        Fri, 15 Oct 2021 01:19:27 +0000 (GMT)
X-AuditID: b6c32a39-227ff70000003640-0d-6168d720f31a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.73.09091.F17D8616; Fri, 15 Oct 2021 10:19:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211015011927epsmtip267792faa3ae1b5b939fbd42aa64dc416~uD4JTRO_z1573115731epsmtip2a;
        Fri, 15 Oct 2021 01:19:27 +0000 (GMT)
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: sunxi: Export CLK_DRAM for
 devfreq
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a48923b7-12f9-808e-1171-49b826bd5f1c@samsung.com>
Date:   Fri, 15 Oct 2021 10:40:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211004012739.39053-2-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmga7C9YxEg9X3BS3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGe8nr2JveCqcEXLgqcsDYxTBboYOTkkBEwkGp5cYO9i5OIQEtjBKHF0y0Y2COcTo8S6
        JZugnG+MEmu/9jN2MXKAtTQvyoaI72WUODN5EhOE855RYtmcRywgc4UFQiQuPToHNldEYCKT
        xOz7B1hAHGaBt4wSC3ftYAapYhPQktj/4gYbiM0voChx9cdjRhCbV8BOYvHB2WA1LAKqEgta
        zoBNFRUIkzi5rQWqRlDi5MwnLCAncQpYSnRdqgQJMwuIS9x6Mp8JwpaX2P52DjPIXgmBFxwS
        9869YoP42kVizvRmZghbWOLV8S3sELaUxMv+Nii7WmLlySNsEM0djBJb9l9ghUgYS+xfOpkJ
        ZDGzgKbE+l36EGFFiZ2/5zJCLOaTePe1hxUSXLwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF
        5JtZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMIVHd3J+7iZGcMLWstzBOP3tB71DjEwcjIcY
        JTiYlUR43x1ITxTiTUmsrEotyo8vKs1JLT7EaAoM34nMUqLJ+cCckVcSb2hiaWBiZmRsYmFo
        ZqgkznvstWWikEB6YklqdmpqQWoRTB8TB6dUAxN/jYdTZ42JgrXhdrMXW4VDFsxJrzXbeX/v
        kudr5G2D94pKyrZXbgx8eS39ocCD+3ZH+T94dVqKqWvNsmv60Mr0/0te29bd3/4eOf2HWVRD
        Uf7VXJPzQh/PpnybMV0qaauqV56I4rzUF8q3wuwnTXwrGtRk/XKf113xw/tvLy7kWFmS/cRC
        8VtmzvY54m4Mb0INTfcr1vv3qYpVnnnq8pD97p5pm1eoLq1oOrMz/0b7Kw6NyXv3/dRn3Wz6
        dib3W5Wcv5+Tjm5e18n2WXdp2NtZlp7Xd138vOPZboGkw3cZmJbM79pjW63/2sRZpMeLybL8
        VcL+RqHlpo/TvUSEtzanxyRv3J302uXuBdm1PqZKLMUZiYZazEXFiQDaaqnOYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvK789YxEgz3rpS3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Ml7P3sRecFW4omXBU5YGxqkCXYwcHBICJhLNi7K7GLk4hAR2
        M0ps3HOPtYuREyguKTHt4lFmiBphicOHiyFq3jJKvL24hBGkRlggROLSo3PsIAkRgclMEie3
        HmcCcZhBql5duM4IN7Zzy312kBY2AS2J/S9usIHY/AKKEld/PAYbxStgJ7H44GxmEJtFQFVi
        QcsZFhBbVCBMYueSx0wQNYISJ2c+YQE5iVPAUqLrUiVImFlAXeLPvEvMELa4xK0n85kgbHmJ
        7W/nME9gFJ6FpHsWkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMj
        OHK1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHedwfSE4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgkjP9nXtDYUqfAcc089lN7HmLtnPNuWzkNcP9yq/mj+aZ
        rPZdv2MP7ua0L110O9PLU/PuEaNV77+oesooTf6jt0RQm2/Rqom/9Tg+3WNunVns5xhv47aS
        w+OhSHjF74iovW+fJR81ZeK3kEiy53l11Vvm6Db+JVvlV57lzj++YUNmt3h8E9PlX1OYv313
        iOVSsJzKY/Nk+7Gtf16fi3rpKvT0/3fF59bRDIz/eR3qZ3teXmjdyPhw+/8bBXvtokKPHW1Z
        47AlveEffxDX/mKjze58V+a/uz1Vd/+nPImyJc5Lwj+Vf53l97AgQP3LrlUXjpV/zFwtpZ8u
        ta3pt8bVIJ9So9RW2ZL8vbOnTj/3X4mlOCPRUIu5qDgRAKDVY9hLAwAA
X-CMS-MailID: 20211015011927epcas1p301f6749bbe0833b956ac39b414d7133a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211004012749epcas1p35a959e43208a0de0f14aefa7ac3b0ccc
References: <20211004012739.39053-1-samuel@sholland.org>
        <CGME20211004012749epcas1p35a959e43208a0de0f14aefa7ac3b0ccc@epcas1p3.samsung.com>
        <20211004012739.39053-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/21 10:27 AM, Samuel Holland wrote:
> The MBUS node needs to reference the CLK_DRAM clock, as the MBUS
> hardware implements memory dynamic frequency scaling using this clock.
> 
> Export this clock for SoCs which will be getting a devfreq driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h        | 2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h   | 2 +-
>  4 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> index 54d1f96f4b68..a8c11c0b4e06 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> @@ -51,8 +51,6 @@
>  
>  #define CLK_USB_OHCI1_12M		92
>  
> -#define CLK_DRAM			94
> -
>  /* All the DRAM gates are exported */
>  
>  /* And the DSI and GPU module clock is exported */
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
> index d8c38447e11b..e13f3c4b57d0 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
> @@ -42,8 +42,6 @@
>  
>  /* The first bunch of module clocks are exported */
>  
> -#define CLK_DRAM		96
> -
>  /* All the DRAM gates are exported */
>  
>  /* Some more module clocks are exported */
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
> index 318eb15c414c..175892189e9d 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -113,7 +113,7 @@
>  #define CLK_USB_OHCI0		91
>  
>  #define CLK_USB_OHCI1		93
> -
> +#define CLK_DRAM		94
>  #define CLK_DRAM_VE		95
>  #define CLK_DRAM_CSI		96
>  #define CLK_DRAM_DEINTERLACE	97
> diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
> index 30d2d15373a2..5d4ada2c22e6 100644
> --- a/include/dt-bindings/clock/sun8i-h3-ccu.h
> +++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
> @@ -126,7 +126,7 @@
>  #define CLK_USB_OHCI1		93
>  #define CLK_USB_OHCI2		94
>  #define CLK_USB_OHCI3		95
> -
> +#define CLK_DRAM		96
>  #define CLK_DRAM_VE		97
>  #define CLK_DRAM_CSI		98
>  #define CLK_DRAM_DEINTERLACE	99
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
