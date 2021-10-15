Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0842EBD8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhJOIUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 04:20:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50834 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbhJOISW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 04:18:22 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211015081615epoutp0291d0797ab888e3e52c69d1e46e8a00b8~uJkDvX3Ag2600926009epoutp02B
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 08:16:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211015081615epoutp0291d0797ab888e3e52c69d1e46e8a00b8~uJkDvX3Ag2600926009epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634285775;
        bh=ksfbDzPLdwuIgXQ/oxv9LAcZypxcKcSyhTadBSQH2Lw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Tb+iTdGnDgxvmsFktb1LYrR0R1vDe6DbJMh+P6NphP4OAfuyy6Mv8fOMxGCbUPzNs
         096vcBP0Cz0qfsdPHcwGHhw1V6Xeyv8UFGywfT6lyUKQCjA5fkoRysoSB/H87dqPn0
         niAh/r5FBjM8qzIy6fd7pOSt8Xt47Ccx3J0bc/K4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211015081614epcas1p4f11bdd416e008654fd01fe3145d47bb9~uJkDCe-Ph0474404744epcas1p4s;
        Fri, 15 Oct 2021 08:16:14 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HVzcK3LSFz4x9QK; Fri, 15 Oct
        2021 08:16:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.8D.13696.1C839616; Fri, 15 Oct 2021 17:16:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211015081600epcas1p12a699ae83ca5ad97db3504a6fa7b9ead~uJj2X3m8R2933829338epcas1p1D;
        Fri, 15 Oct 2021 08:16:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211015081600epsmtrp1ff07c2c0bcf0a4c0a1f9c65b5f45c1cd~uJj2W2y1o1911119111epsmtrp1D;
        Fri, 15 Oct 2021 08:16:00 +0000 (GMT)
X-AuditID: b6c32a37-297ff70000023580-3e-616938c14e3b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.33.08750.0C839616; Fri, 15 Oct 2021 17:16:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211015081600epsmtip22e71595ab53ee9317e8500839d1698d1~uJj2CuJV21962819628epsmtip2D;
        Fri, 15 Oct 2021 08:16:00 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
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
Message-ID: <07410362-a37b-b6e4-5b6e-a39daa6c22e7@samsung.com>
Date:   Fri, 15 Oct 2021 17:37:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211004012739.39053-3-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmge5Bi8xEg/55whbzj5xjtXg+fx2j
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFlP27WKzaOtcxmpx8ZSrxe3GFWwWrXuPsFs8f9TJZvHv
        2kYWi5+HzjM58Hm8v9HK7rHh0WpWj52z7rJ7bFrVyeaxeUm9x4vNMxk9+rasYvR49XUuo8fn
        TXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        tysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjM2tm5iLzgkV9ExeRJbA2OfWBcjJ4eEgInEh0cr2LsYuTiEBHYwSlz4tZ8dJCEk8IlR
        YtstHwj7M6PE2efxMA1PTrYwQjTsYpSYNfMoM0TRe0aJhefSQGxhAQ+J4/0vWEGKRAQmMknM
        vn+ABcRhFngLVLRrB1gHm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSby5MAouzCKhKbHuxjgXE
        FhUIkzi5rQWqRlDi5MwnYHFOAUuJe3vXgtUzC4hL3HoynwnClpfY/nYOM8hiCYEXHBItLf1s
        ED+4SGx98Y0dwhaWeHV8C5QtJfGyvw3KrpZYefIIG0RzB6PElv0XWCESxhL7l04G2sABtEFT
        Yv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlI3pmF
        5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCY3hsJ+fnbmIEp2st8x2M095+0DvEyMTBeIhRgoNZ
        SYT33YH0RCHelMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD8wYeSXxhiaWBiZmRsYmFoZmhkri
        vMdeWyYKCaQnlqRmp6YWpBbB9DFxcEo1MOmu9FrsPWnz/VPznxhc259+3a/Nv/vufgfZOjuf
        otM9L4JuBN5VNhJ+/uH2M3ZprrkXu00aBBc4MEx5eqzn4rqC5FzJk4HTEm50S++/rp2032L6
        gnnZ8q3RWs2x8yVMTe8e8P6/4sDbYzslYtiKjLlP/n3LlRwVvVzraBj7w3PdbxJWP1RawWFu
        aFHmcFv2TLXPmvm9S7dtbg3RYYy7UPXKWD/9r8UHLxXzWSpXEldM71ku+NyVZ4Pr7yk2Ydx9
        0c5sr8InxC9kCxE8wahsefDgabHgt0/P/vSLe8XB+7Kv662PaUmtydGraYtufvj+JYt/Q5TP
        E0XF7tgmx8dFjIkFG3iWuOptsN6+/9eHM0osxRmJhlrMRcWJAGgY1l5gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO4Bi8xEgx07VS3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Mja2bmIvOCRX0TF5ElsDY59YFyMnh4SAicSTky2MILaQwA5G
        if3bLSHikhLTLh5l7mLkALKFJQ4fLu5i5AIqecso0Xj0AxNIjbCAh8Tx/hesIAkRgclMEie3
        HmcCcZhBql5duM4I0bKbUeLaxXnMIC1sAloS+1/cYAOx+QUUJa7+eAy2mlfATuLNhUlgcRYB
        VYltL9axgNiiAmESO5c8ZoKoEZQ4OfMJWJxTwFLi3t61YPXMAuoSf+ZdYoawxSVuPZnPBGHL
        S2x/O4d5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMGxq6W1g3HPqg96hxiZOBgPMUpwMCuJ8L47kJ4oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC
        18l4IYH0xJLU7NTUgtQimCwTB6dUA9MmA6bgC9tmXTc9L5WhYVgTF6719bdfdXBT8IlHX0sk
        s1dEb9m7q2q9b2+jfgT/gcMv7rZ25BpV5JWmfb8yR6aGy1jO9/9G6yzdfTrlW/IbZdtPZPFW
        F/Ol35XhmP3217LUvMvvzMyaFSKeClwMOtvvwyf0yT3+wNoncRphjBtfHQ/JtfAXrzN1s5/L
        7mQyZ5WFDE/AzJv7dY7Js4dJxyS8VNZ+9PHJkWlHTSy0/MOO3HhR0FKqG+tblmK/rj/vnNTt
        eYXlpt2OXdM/2Oy8YN/OIz5pAnf+y+rUIP235xetOffjicHExS8c9rNXchTs96jV/WCoyxs3
        N+xfmYFyje2CknD2Asa+xwuylxUosRRnJBpqMRcVJwIA5rvmckwDAAA=
X-CMS-MailID: 20211015081600epcas1p12a699ae83ca5ad97db3504a6fa7b9ead
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211004012752epcas1p4f21bb9f5ff9c2bfc7adf9d2ae4b451f3
References: <20211004012739.39053-1-samuel@sholland.org>
        <CGME20211004012752epcas1p4f21bb9f5ff9c2bfc7adf9d2ae4b451f3@epcas1p4.samsung.com>
        <20211004012739.39053-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/21 10:27 AM, Samuel Holland wrote:
> The MBUS provides more than address translation and bandwidth control.
> It also provides a PMU to measure bandwidth usage by certain masters,
> and it provides notification via IRQ when they are active or idle.
> 
> The MBUS is also tightly integrated with the DRAM controller to provide
> a Memory Dynamic Frequency Scaling (MDFS) feature. In view of this, the
> MBUS binding needs to represent the hardware resources needed for MDFS,
> which include the clocks and MMIO range of the adjacent DRAM controller.
> 
> Add the additional resources for the H3 and A64 compatibles, and a new
> example showing how they are used.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 75 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> index e713a6fe4cf7..c1fb404d2fb3 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> @@ -33,10 +33,33 @@ properties:
>        - allwinner,sun50i-a64-mbus
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: MBUS interconnect/bandwidth/PMU registers
> +      - description: DRAM controller/PHY registers
> +
> +  reg-names:
> +    items:
> +      - const: "mbus"
> +      - const: "dram"
>  
>    clocks:
> +    minItems: 1
> +    items:
> +      - description: MBUS interconnect module clock
> +      - description: DRAM controller/PHY module clock
> +      - description: Register bus clock, shared by MBUS and DRAM
> +
> +  clock-names:
> +    items:
> +      - const: "mbus"
> +      - const: "dram"
> +      - const: "bus"
> +
> +  interrupts:
>      maxItems: 1
> +    description:
> +      MBUS PMU activity interrupt.
>  
>    dma-ranges:
>      description:
> @@ -53,13 +76,42 @@ required:
>    - clocks
>    - dma-ranges
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - allwinner,sun8i-h3-mbus
> +          - allwinner,sun50i-a64-mbus
> +
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
> +    clocks:
> +      minItems: 3
> +
> +  required:
> +    - reg-names
> +    - clock-names
> +
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +
> +    clocks:
> +      maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/sun5i-ccu.h>
> +    #include <dt-bindings/clock/sun50i-a64-ccu.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -    mbus: dram-controller@1c01000 {
> +    dram-controller@1c01000 {
>          compatible = "allwinner,sun5i-a13-mbus";
>          reg = <0x01c01000 0x1000>;
>          clocks = <&ccu CLK_MBUS>;
> @@ -69,4 +121,21 @@ examples:
>          #interconnect-cells = <1>;
>      };
>  
> +  - |
> +    dram-controller@1c62000 {
> +        compatible = "allwinner,sun50i-a64-mbus";
> +        reg = <0x01c62000 0x1000>,
> +              <0x01c63000 0x1000>;
> +        reg-names = "mbus", "dram";
> +        clocks = <&ccu CLK_MBUS>,
> +                 <&ccu CLK_DRAM>,
> +                 <&ccu CLK_BUS_DRAM>;
> +        clock-names = "mbus", "dram", "bus";
> +        interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        dma-ranges = <0x00000000 0x40000000 0xc0000000>;
> +        #interconnect-cells = <1>;
> +    };
> +
>  ...
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
