Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31042EB1C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhJOIKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 04:10:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:64828 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhJOIKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 04:10:35 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211015080828epoutp04e452f9752cca1030775a9d562738871c~uJdRBsLri0935209352epoutp04a
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 08:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211015080828epoutp04e452f9752cca1030775a9d562738871c~uJdRBsLri0935209352epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634285308;
        bh=Dk+3Nxj8QWis9FqVBLsyTS4L9LyesVIOtSg6qZP5d5A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fHfm1CBtBsOJQTG0ZlTmuGQPTCf5C1ab9Iz7t9FZFiQwWnIbEVbKFpq1uBGl5UFzB
         ZNKcXS0xpIAszqJeIeirJXoSHIMStQUMfaBayKZW1WVblCznrcMozxV6L0Q3i0Wmd6
         eWkvfPcLfOk+uaWQ/DwxacnXnWiD5e9COELURm1c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211015080827epcas1p47065b6ddbdd353936c28b21e628b83da~uJdQi-VjR0131701317epcas1p4r;
        Fri, 15 Oct 2021 08:08:27 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HVzRS2Vxtz4x9QG; Fri, 15 Oct
        2021 08:08:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.8B.13696.4F639616; Fri, 15 Oct 2021 17:08:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211015080819epcas1p4c9367ff621e03529a9a37fa17253f486~uJdI102wF0131701317epcas1p4V;
        Fri, 15 Oct 2021 08:08:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211015080819epsmtrp26e98309c3265a431e1542c6d62ed0ee0~uJdI0-Bi_0470904709epsmtrp2K;
        Fri, 15 Oct 2021 08:08:19 +0000 (GMT)
X-AuditID: b6c32a37-297ff70000023580-a9-616936f4cac1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.1F.09091.3F639616; Fri, 15 Oct 2021 17:08:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211015080819epsmtip145bf31673f77aaba181dec1343e90377~uJdIfDuS32625826258epsmtip1b;
        Fri, 15 Oct 2021 08:08:19 +0000 (GMT)
Subject: Re: [PATCH v2 4/6] ARM: dts: sunxi: h3/h5: Update MBUS node
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
Message-ID: <435d622b-4ad9-d9d5-3c9b-7b66304e42e4@samsung.com>
Date:   Fri, 15 Oct 2021 17:29:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211004012739.39053-5-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHvf3xWtiKz4LjSjIpbzhDZ7G1P3gYypZY3HOQpYuJIXMJvrVv
        QCht7Q/DXDJwQYHimA4lsUJQAcePZLACgk1Ka8ERyGAyZ8EZcFEQ0LXCGEO2Bdb24cZ/n3Py
        Pfd7zrn3cpn8ESSOm6+3UCY9qcOQSNaN/iSx6A9FPin+aSwKrx8YZeOz9d8CfOSL3zi447GP
        jd911iL40pcDAL/Q50TwMxXX2fjYcAb+4FQzgp92DXDw2UcVCL7m+46Fr3p/ZLwTRTyfOM0h
        Oh61sYmb9kkO4WitQIjOxmJirvMSIKq6WgHxdLkOEEuOneqIDwvS8ihSS5kElF5j0Obrc5VY
        5uGcAzlyhVgikqTiKZhATxZSSkyVpRYdzNcFe8cEJ0idNZhSk2Yztjc9zWSwWihBnsFsUWKU
        Uaszyo3JZrLQbNXnJuspy36JWLxPHhQeK8gLlHkR42p0UYMrsQTYUBuI4EJUBnvm2xEbiOTy
        0V4Aq8a7OHTwO4DOYTuDDv4EcHmmnvGyZKHGwwkxH3UBeMX7Hi16DmBzS1tYFI2qYMPX98NH
        xaDnGfDyQw8rFDBRP4BXnb3MkApBhdA9N4GEeCuaAO+9eAxCzEPTYUegkR1iFroLfrU+xwrx
        dvQIHLpRuqHZBocuTYfzEWgqXKz8IcxMNBb+Mk23ykTjYY+/lkm3Pc2F1a0GmlWwf2KcTXM0
        fDrYxaE5Di4FXAjNn8GWoYHwZiBaDmCX+85GgRS6m6qDBtygQRJsd+6l0wnw5t91gPaNgoHl
        s+yQBKI8WH6GT0vegHd/ndzY4g7YUFaBnAOYfdM09k0T2DdNYP/f7ApgtYLXKKO5MJcyS4zS
        /25bYyh0gPC7Fqb0ghr/QrIXMLjACyCXicXwAp5cks/Tkp+epEyGHJNVR5m9QB7c73lm3HaN
        Ifgx9JYciSxVLFPsk8pwiUKCxfK+f5ZK8tFc0kIVUJSRMr2sY3Aj4koY+1etPXP3itK3JU5V
        xi/brSBb7d9xbPGjD1Sjb2+t9nE/3gLWXm9O+2bQkrWgPFGnSLvY33dxbLVJXfng9m3cN/5C
        mGKrNDTOdN53Tq2cyh6NIhYZuuS3xg4fMu1+tWT9c09N7x7LenN3YlL5P8dfEe2JXonJFHAU
        ZbGi3e+3T8sfCmRZs1Pnht9duS6ffuY7uPAEjgRmzgprJv5SXivO0OpYxU1tKlPLmyvdkdKA
        m5VEzD9JVMf69GWO45knt9zqFrr7MrLFnqX5+JhbGtURnaTWXVWU0OGx+UtnqnQS6VHHz5Sr
        +M61Q4GiwTWXc7JFJ+/Julo6susy88BRzc5PMJY5j5QImSYz+S9sBOduYAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO5ns8xEg8PfxC3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Mt61H2Ir+ClcsXivSgNjl0AXIyeHhICJxIdpB9i7GLk4hAR2
        M0q8n/WWGSIhKTHt4lEgmwPIFpY4fLgYouYto8TX64/YQGqEBVwkFk+6CdYsIjCZSeLk1uNM
        IA4zSNWrC9cZ4ca+/DUPbCybgJbE/hc3wNr5BRQlrv54zAhi8wrYSWx4t4QVxGYRUJXo//+C
        BcQWFQiT2LnkMRNEjaDEyZlPwOKcApYSH7vPgNnMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5
        AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGxq6W5
        g3H7qg96hxiZOBgPMUpwMCuJ8L47kJ4oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0
        xJLU7NTUgtQimCwTB6dUA9NlV4v61gP/FPMMP/NfvGQQ/PXH04cHbYpdy5deWcX/UnD/lZ6H
        dseuxjz3nuvB9+PRhu1n70nG3llzw5Hx1qXHlbUlXfGHtuZER+/43+agYPwwd0a2t+E9/m2G
        DO/fzFt8sjC311+l7dtH0T3cM1/sZjs9LfHaaZ/NG1Pz//JsO3+STeZ5scCiNzOPBNdMPjHh
        YEEfq4SOZ0zF/PCXv0MzVQ2+vplx4KBcb7yuVuOcearp/2qeP49hnBi5m6t+2/mekPfBMTq6
        0yW4X5uEykQcYJU5/qTLT+jOqmkWkSY3Lhk3PtsfuiWurG2FBHMJu1QPi/I7OeFNsvdm757e
        eE9mZ5v11gNcsi9OlZ2dPGmNEktxRqKhFnNRcSIAX8cX7kwDAAA=
X-CMS-MailID: 20211015080819epcas1p4c9367ff621e03529a9a37fa17253f486
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211004012802epcas1p27d6b3e2df865cc6d4beb379e2b65e002
References: <20211004012739.39053-1-samuel@sholland.org>
        <CGME20211004012802epcas1p27d6b3e2df865cc6d4beb379e2b65e002@epcas1p2.samsung.com>
        <20211004012739.39053-5-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/21 10:27 AM, Samuel Holland wrote:
> In order to support memory dynamic frequency scaling (MDFS), the MBUS
> binding now requires enumerating more resources. Provide them in the
> device tree.
> 
> Since the H3 and H5 have different clock divider limits, they need
> separate compatibles.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi              |  4 ++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 11 ++++++++---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 ++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 4e89701df91f..43acb98cf390 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -282,6 +282,10 @@ &display_clocks {
>  	compatible = "allwinner,sun8i-h3-de2-clk";
>  };
>  
> +&mbus {
> +	compatible = "allwinner,sun8i-h3-mbus";
> +};
> +
>  &mmc0 {
>  	compatible = "allwinner,sun7i-a20-mmc";
>  	clocks = <&ccu CLK_BUS_MMC0>,
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index c7428df9469e..3a683e190dab 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -568,9 +568,14 @@ external_mdio: mdio@2 {
>  		};
>  
>  		mbus: dram-controller@1c62000 {
> -			compatible = "allwinner,sun8i-h3-mbus";
> -			reg = <0x01c62000 0x1000>;
> -			clocks = <&ccu CLK_MBUS>;
> +			/* compatible is in per SoC .dtsi file */
> +			reg = <0x01c62000 0x1000>,
> +			      <0x01c63000 0x1000>;
> +			reg-names = "mbus", "dram";
> +			clocks = <&ccu CLK_MBUS>,
> +				 <&ccu CLK_DRAM>,
> +				 <&ccu CLK_BUS_DRAM>;
> +			clock-names = "mbus", "dram", "bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index 578a63dedf46..35d5d238e313 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -233,6 +233,10 @@ &display_clocks {
>  	compatible = "allwinner,sun50i-h5-de2-clk";
>  };
>  
> +&mbus {
> +	compatible = "allwinner,sun50i-h5-mbus";
> +};
> +
>  &mmc0 {
>  	compatible = "allwinner,sun50i-h5-mmc",
>  		     "allwinner,sun50i-a64-mmc";
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
