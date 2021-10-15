Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8142EB12
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhJOIKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 04:10:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40420 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhJOIKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 04:10:06 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211015080759epoutp023810ee3c1fd0b62f62c25ee4719357bf~uJc2CHg2H1510715107epoutp02e
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 08:07:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211015080759epoutp023810ee3c1fd0b62f62c25ee4719357bf~uJc2CHg2H1510715107epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634285279;
        bh=i/8snz7oQQF/veQVY2UXngyhVMdyor5+6y2YvZnUbcY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SraTBmD6WmTIdJXqI90dg2DXotTaF4bB0wPXEE5MZJXeUfTKtYc2hIS99smEBpJ7d
         U/WONngV/yMoeDgz2MVy5vOBnF1GypVIKpy5PKb0a0cUkrC7eSMvwYrl1/j+78WH4b
         6l/fHzJ3r7YaavCkbQBkhgPQnu4eg/AQz/8X3IBM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211015080758epcas1p4756d38a9aa4bb067dbd8e496b924fd3b~uJc1ejYvd0145601456epcas1p40;
        Fri, 15 Oct 2021 08:07:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.231]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HVzQy3jySz4x9QK; Fri, 15 Oct
        2021 08:07:54 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.30.13888.3D639616; Fri, 15 Oct 2021 17:07:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211015080747epcas1p2c3992e77b2c68f8ea3eab68cbc6e5530~uJcrGr-lq1458514585epcas1p24;
        Fri, 15 Oct 2021 08:07:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211015080747epsmtrp2609be969588b22ed88f3be7f9a3c7121~uJcrFsBw20472204722epsmtrp2o;
        Fri, 15 Oct 2021 08:07:47 +0000 (GMT)
X-AuditID: b6c32a39-227ff70000003640-6f-616936d3a991
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.92.08750.3D639616; Fri, 15 Oct 2021 17:07:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211015080747epsmtip1243c85b809ac914d7cd799a3f3fb0288~uJcqz-OF02744627446epsmtip1b;
        Fri, 15 Oct 2021 08:07:47 +0000 (GMT)
Subject: Re: [PATCH v2 5/6] arm64: dts: allwinner: a64: Update MBUS node
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
Message-ID: <27543cc4-1294-0a28-d020-5d578f4bc7b0@samsung.com>
Date:   Fri, 15 Oct 2021 17:29:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211004012739.39053-6-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmru5ls8xEg8tPbCzmHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGes+nmCveAWV8W0I78YGxjPc3QxcnJICJhIzNh2mKmLkYtDSGAHo8TT1zfYIZxPjBKH
        z15hhHA+M0rs3/mGDabl+emHrBCJXYwS516uhKp6zyjx5cQ5oAwHh7CAh8SyjRogcRGBiUwS
        s+8fYAFxmAXeMkos3LWDGWQUm4CWxP4XN8DG8gsoSlz98ZgRxOYVsJM4PbsbLM4ioCoxc2YP
        K4gtKhAmcXJbC1SNoMTJmU9YQJZxClhKtD53BQkzC4hL3HoynwnClpfY/nYOM8heCYE3HBKz
        T85jhnjBRaJ5dwMrhC0s8er4FnYIW0ri87u9UG9WS6w8eYQNormDUWLL/gtQDcYS+5dOZgJZ
        zCygKbF+lz5EWFFi5++5jBCL+STefe0BB4SEAK9ER5sQRImyxOUHd5kgbEmJxe2dbBMYlWYh
        +WYWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LTOHRnZyfu4kRnLC1LHcwTn/7Qe8QIxMH4yFG
        CQ5mJRHedwfSE4V4UxIrq1KL8uOLSnNSiw8xmgLDdyKzlGhyPjBn5JXEG5pYGpiYGRmbWBia
        GSqJ8x57bZkoJJCeWJKanZpakFoE08fEwSnVwGRQ1qp3dcr34yuaeie6NayzZX/yv1bac+GJ
        ya8O/StfGnTAL1l78eaH8nuPxyRssjKt5+HfGuzH9/5ve9Edxakrfwft3NRzd73dqccuLTc3
        VwhIpManVGhFi+vFhhXHbrt0+LFzf6j13NWt3SvO5z7MNmZrunyhfzbb5C6dWOeKxzF8WRM+
        sexjC8u/u6PVXebZkala8snaPpsPbo389y7s0vyXW7kE3XikN+tvdBDb3rue65FpytU/Srfm
        HlCP/jBz1trtsyMjGyc4vZJrOsUheSFU1u7StoZXKtdValsL2N9/NjI3/LWyba/1Gstz4Sb6
        p/51a9tV/Ji/+mnFs9ZUrwt/7xl3uR6obxMI81ViKc5INNRiLipOBAAQ6VBeYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO5ls8xEgwt/5S3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Mlb9PMFecIurYtqRX4wNjOc5uhg5OSQETCSen37I2sXIxSEk
        sINRYvvP3awQCUmJaRePMncxcgDZwhKHDxdD1LxllHh+dx87SFxYwENi2UYNkLiIwGQmiZNb
        jzOBOMwgRa8uXGeE6NjNKPHmVzsTyFQ2AS2J/S9usIHY/AKKEld/PGYEsXkF7CROz+4Gi7MI
        qErMnNkDdoWoQJjEziWPmSBqBCVOznzCArKZU8BSovW5K0iYWUBd4s+8S8wQtrjErSfzmSBs
        eYntb+cwT2AUnoWkexaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4crW0djDuWfVB7xAjEwfjIUYJDmYlEd53B9IThXhTEiurUovy44tKc1KLDzFKc7AoifNe
        6DoZLySQnliSmp2aWpBaBJNl4uCUamBaaLsj+7ru3FcPrbel/F5ke0Y1eur8h9tTPy+443XG
        UGx21LZN29p9HXV3fo14ODueY7X27rPn18SUBS2aI7Lwi8TxGYvb9879dvXzb82Nb09sjNSY
        UvVS/NvW0IfT8qvuuPF6bwvx1UzYdCL3j8BhhhKzdbbbz/XPPvLvOfuzVM/LvVYfK+SFogwO
        XoxO2b2hg8l5ZvmGRSc9e5dazv2fMMvum6So6XvTKctytz8IW+xh6cT0rHHF1XUh//RYs97O
        ZJfz+nP93Wy5IkGhFzs17RwN5gdkLwtv6JV75jS/98KKi09/LojKN9Y4HO1Uc/90305390OS
        f8xDumd9Epmvzfwm5ObkkwbJ/C7N3UwBB5VYijMSDbWYi4oTAVBdymBLAwAA
X-CMS-MailID: 20211015080747epcas1p2c3992e77b2c68f8ea3eab68cbc6e5530
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211004012804epcas1p4a6ad04a1d71344d15a3a04ba852414d6
References: <20211004012739.39053-1-samuel@sholland.org>
        <CGME20211004012804epcas1p4a6ad04a1d71344d15a3a04ba852414d6@epcas1p4.samsung.com>
        <20211004012739.39053-6-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/21 10:27 AM, Samuel Holland wrote:
> In order to support memory dynamic frequency scaling (MDFS), the MBUS
> binding now requires enumerating more resources. Provide them in the
> device tree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 6ddb717f2f98..609a59c6c778 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -1129,8 +1129,14 @@ pwm: pwm@1c21400 {
>  
>  		mbus: dram-controller@1c62000 {
>  			compatible = "allwinner,sun50i-a64-mbus";
> -			reg = <0x01c62000 0x1000>;
> -			clocks = <&ccu 112>;
> +			reg = <0x01c62000 0x1000>,
> +			      <0x01c63000 0x1000>;
> +			reg-names = "mbus", "dram";
> +			clocks = <&ccu CLK_MBUS>,
> +				 <&ccu CLK_DRAM>,
> +				 <&ccu CLK_BUS_DRAM>;
> +			clock-names = "mbus", "dram", "bus";
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
