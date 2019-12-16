Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8F11FC70
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 02:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLPBFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 20:05:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:61156 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPBFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 20:05:50 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216010546epoutp01f1e0876e728870e789de7d1d864e9dd9~gtIOQSmpR2495224952epoutp01i
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 01:05:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216010546epoutp01f1e0876e728870e789de7d1d864e9dd9~gtIOQSmpR2495224952epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576458346;
        bh=3PGC1UPOQOfejREl3m8Ds/ShxDCphrmBpVvbUYlrXgM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cYDbCQfH5SzrY2FpXTgJ0aCj8SPVJB0vOgtwy/pgRheTZbumocrofVcMauz5+wK15
         ZZDulUR+MmO9Ewt39gh9DeqV7xN714oYdvvVkvtXAKFSr2aAeRfA3es2ZTW26Is+Bn
         lzAX6VV6pQVCcPG/gZk5e+To1G20S8eqlWKykUrU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191216010545epcas1p4888c05bc57a34a1fce024726030e4d12~gtINOdTYT1186711867epcas1p41;
        Mon, 16 Dec 2019 01:05:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47bjkZ1vxgzMqYkV; Mon, 16 Dec
        2019 01:05:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.CD.57028.668D6FD5; Mon, 16 Dec 2019 10:05:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216010541epcas1p4c0c10a13206eebde75baa616e973b6e1~gtIJAqQSn1184911849epcas1p4q;
        Mon, 16 Dec 2019 01:05:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216010541epsmtrp1f68fa3b208ecfd9afebf2f3837f30f0a~gtII-h7-Q3034430344epsmtrp1m;
        Mon, 16 Dec 2019 01:05:41 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-65-5df6d866b79b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.1A.10238.468D6FD5; Mon, 16 Dec 2019 10:05:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216010540epsmtip288c02507f4dc4130f7bd4d167d8f72d1~gtIIkmG5n0394703947epsmtip2g;
        Mon, 16 Dec 2019 01:05:40 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com>
Date:   Mon, 16 Dec 2019 10:12:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTO23t7e3HrvFaRd52ZeMk0soC9QtkLEcI2XW42s5B9mS1BvCnX
        QuiXva1B2SIjw0EzRaaVFKeyKUvtDB9tA/jRkAKbAQNalxVGxWHqFvwYKghD1LG2t2b8e85z
        nvM+55w3h8QULTIlWWqw8GYDp6OJJXhH7/r0tJ0js4Uqx6gczVweAOjHaz8D9Mh+HkPhP0IA
        dTo06GTfkBS1e0I4avC5CeSyn8PRlSttMjRYdU+GnGMPpcgdDkqRbf4MhqYP9AHUPByQoKCz
        Xoqm28IABQa2oNCXTgL9NOQn0PFHdgxV+/pkyNbzjED/BttxNOFNQs2nghhqn2HzV7F2mxOw
        Z0+cBez9kWoZe6wygLNNbivrdtUS7PXgRYL1nN7Htk92Sdi6Zyp2vjeRPeh1AXba/WqB/LOy
        TSU8V8ybk3mDxlhcatDm0u99WPR2kTpLxaQx2egNOtnA6flcevPWgrR3SnWRfdDJuzmdNUIV
        cIJAb8jbZDZaLXxyiVGw5NK8qVhnyjalC5xesBq06RqjPodRqTaqI8IdZSXX637BTA/Wlg+7
        L2CVwL/KBhJISGXCqhN3CRtYQiqoLgBbLnbgYjAF4NXHLokYzAL4j8eHPy/5dqpBEsUKygdg
        dwMURfcBHK1pjSWWU9ug3VOLRfEKqgIeGqyK8Rh1VAaf2LOjmKBSYffECBHFS6k18Le5MIhi
        OZUHfQvfy6IYp16D4/U3Ynwi9Qns7/gqrlkG+x23Yg0lUNvh78e8uPh+Ehy9dTLutRp2/v0d
        Fm0OUl4SDkw8lokTbIaOSadExMvhnUveOK+Et+v2x3EFPNPfR4jFNQB6u69KxUQG7G4+HCkm
        Iw7rYev5DSK9Bp57chyIxi/ByZlvpFEJpOSwZr9ClKTAX8fH4rYvw1Nf1xKHAN24aJzGRSM0
        Lhqh8X+zJoC7wEreJOi1vMCYmMW/7QaxW0lVd4EjQ1t7AEUC+kV5ftlsoULK7Rb26HsAJDF6
        hZx/fbpQIS/m9uzlzcYis1XHCz1AHdl2PaZM1Bgjl2ewFDHqjRkZGSiTyVIzDJ0kJ+cChQpK
        y1n4Mp438ebndRIyQVkJsvzbO+2a01/cXH1XfmDo6WHt8F858+X3QlOuwOeDf3auqz7ybvmO
        S7vmlHf2PvAsvPXx5bEEx/sFH1S23nb/UK17mno0vHQh1Hszfx2bvUVIX2v56IKxwj031dYk
        sVfwKTea9r2S8ua2g1XX1Ls+3TmeOegfbVk5mauer/E/zFkG8oIv0LhQwjGpmFng/gMa6faK
        QQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0hTcRjA+++cnR2l4XFq/jVLHHSzWho9/ClRH4oO9RI9FCpqS09T5ubY
        UUvtopmUMzODJc7rSGWaD26Kl0zCexop8zKnLpVmIXmrvCCmXbYR+Pbj+34/vpePxAQarjcZ
        L09ilHJxgpBwxpu6hL4nY80bkQF9T8+i9Q8DAFUP9wC0pn6DIevMFEDNRTGovHuQi/QNUzgq
        bDcQqFbdiqOhoXoe+vhwkYd0n35wkcFq4iLVVg2GVvO6AaoaN3KQSVfARav1VoCMAxfQVKaO
        QK8HOwhUuqbGUHZ7Nw+pOncI9Nukx9F8oyeqemXCkH6dDvWh1SodoOvK6gC9Ys7m0cUZRpyu
        MCTThtocgraY3hJ0Q+UDWr/cwqHzdwLorS4P+lljLaBXDQev8MOdg2KZhPgURnkq+IZznCW/
        F1N8P3xn3NCGZYAOHxVwIiF1Br74WchRAWdSQLUB2NqiA46FF3xp7MFUgPzHbrCri3U4SwBq
        F0s5NseNug7VDTmYjd2pdLj9tQ+zSRil4cG5XCPuKD4DWGPMtFsE5Q/fzZsJG7tQfnBs02q/
        xqeCYfsfLc/GOHUIzhZM2+ce1DXYWmnlOBxX2F80h9vYiYqCE8WNdsaoI3C7bBhzsCecnCvn
        ONgXNi+VYM+Bm2ZXrtmVaHYlml1JBcBrgRejYGUSGRuoCJQzt0WsWMYmyyWimESZAdg/xv9Y
        CxipjO4EFAmEe/mh0o1IAVecwqbKOgEkMaE7nzm+Gingx4pT0xhlYrQyOYFhO8F+Ehd68r/I
        e8MElEScxEgZRsEo/285pJN3BkgQbWojuJMTWfSo6pp0coWvyJEMnRgJT5eEHK1uWq76dVMr
        2udSn5Qs5i1k7Vy8ZdhjGR3PP9AvCAu5zJ8N853xWVt6XBdnSTKzQY9y7/KerJTpJ8xpoabz
        1PvcAeaS9F6E62kVOqe9/y2kSm+UTrf5iaKu5i2MNZV0WxSupBBn48SB/piSFf8FFK49aS0D
        AAA=
X-CMS-MailID: 20191216010541epcas1p4c0c10a13206eebde75baa616e973b6e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d
References: <cover.1573761527.git.leonard.crestez@nxp.com>
        <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
        <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/15/19 5:09 AM, Leonard Crestez wrote:
> Add initial dt bindings for the interconnects inside i.MX chips.
> Multiple external IPs are involved but SOC integration means the
> software controllable interfaces are very similar.
> 
> Main NOC node acts as interconnect provider if #interconnect-cells is
> present.
> 
> Multiple interconnects can be present, each with their own OPP table.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> new file mode 100644
> index 000000000000..5cd94185fec3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/url?k=0c13f3e0-51df3f45-0c1278af-0cc47a30d446-77e809543b673ffd&u=http://devicetree.org/schemas/interconnect/fsl,imx8m-noc.yaml#
> +$schema: https://protect2.fireeye.com/url?k=87c672dc-da0abe79-87c7f993-0cc47a30d446-414d3b4d0127419a&u=http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic i.MX bus frequency device
> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +description: |
> +  The i.MX SoC family has multiple buses for which clock frequency (and
> +  sometimes voltage) can be adjusted.
> +
> +  Some of those buses expose register areas mentioned in the memory maps as GPV
> +  ("Global Programmers View") but not all. Access to this area might be denied
> +  for normal (non-secure) world.
> +
> +  The buses are based on externally licensed IPs such as ARM NIC-301 and
> +  Arteris FlexNOC but DT bindings are specific to the integration of these bus
> +  interconnect IPs into imx SOCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - fsl,imx8mn-nic
> +          - fsl,imx8mm-nic
> +          - fsl,imx8mq-nic
> +        - const: fsl,imx8m-nic
> +      - items:
> +        - enum:
> +          - fsl,imx8mn-noc
> +          - fsl,imx8mm-noc
> +          - fsl,imx8mq-noc
> +        - const: fsl,imx8m-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +  opp-table: true
> +
> +  devfreq:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description:
> +      Phandle to another devfreq device to match OPPs with by using the

Better to use 'parent' instead of 'another' word for improving the understanding.

> +      passive governor.
> +
> +  '#interconnect-cells':
> +    description:
> +      If specified then also act as an interconnect provider. Should only be
> +      set once per soc on main noc.
> +    const: 1
> +
> +  fsl,scalable-node-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of node ids for scalable nodes. Uses same numeric identifier
> +      namespace as the consumer "interconnects" binding.
> +
> +  fsl,scalable-nodes:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Array of phandles to scalable nodes. Must be of same length as
> +      fsl,scalable-node-ids.
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |

Is it enough example to understand the relation between
imx8m-ddrc.c, imx-devfreq.c and imx interconnect driver?

In my case, if possible, hope to show the more detailed
example. This example seems that don't contain the ddrc
dt node (imx8m-ddrc.c).

> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/interconnect/imx8mq.h>
> +    noc: interconnect@32700000 {
> +            compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +            reg = <0x32700000 0x100000>;
> +            clocks = <&clk IMX8MQ_CLK_NOC>;
> +            #interconnect-cells = <1>;
> +            fsl,scalable-node-ids = <IMX8MQ_ICN_NOC>,
> +                                    <IMX8MQ_ICS_DRAM>;
> +            fsl,scalable-nodes = <&noc>,
> +                                 <&ddrc>;
> +            operating-points-v2 = <&noc_opp_table>;
> +
> +            noc_opp_table: opp-table {
> +                    compatible = "operating-points-v2";
> +
> +                    opp-133M {
> +                            opp-hz = /bits/ 64 <133333333>;
> +                    };
> +                    opp-800M {
> +                            opp-hz = /bits/ 64 <800000000>;
> +                    };
> +            };
> +    };
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
