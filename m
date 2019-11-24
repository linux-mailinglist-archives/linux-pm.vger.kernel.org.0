Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CACD1085A2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 00:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKXXx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 18:53:58 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30688 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKXXx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 18:53:58 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191124235353epoutp0347d3dc6f4f98bb78c9fcca152a91e7a0~aPmd5WjBm0612806128epoutp03l
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2019 23:53:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191124235353epoutp0347d3dc6f4f98bb78c9fcca152a91e7a0~aPmd5WjBm0612806128epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574639633;
        bh=AVvdCtMY//59JkfT+HX/3Kx1Dzwu9AgzcPoN1Jdpdt8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cz/oz5DAAUC2aZ8t+UcwtXzs95cjBc1hP7+2mvnw4jFhrerHyCS3RLb5rCPltOpCH
         jufLCbhRzZxprdSiFIHBILNV3fhe0WejA1BYhdtRmJbX9Ki5HS1ZXz8I/wPs36qi1r
         L8TUYUTp3436XjYlnfwiKDDFjFwa16tFn6f9JhLg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191124235352epcas1p3fed83ed00327ba1521f2b91b5819fdfe~aPmc9ok1a1532315323epcas1p3l;
        Sun, 24 Nov 2019 23:53:52 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Ln7J23CczMqYkZ; Sun, 24 Nov
        2019 23:53:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.DE.48498.C081BDD5; Mon, 25 Nov 2019 08:53:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191124235347epcas1p28508f778af78e31484ff54490986f2fe~aPmXrHABF0205002050epcas1p2k;
        Sun, 24 Nov 2019 23:53:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191124235347epsmtrp1c1294cb0c214ff9bcda9b225b2d1ed49~aPmXp1pT32074420744epsmtrp1g;
        Sun, 24 Nov 2019 23:53:47 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-90-5ddb180cb625
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.9F.10238.B081BDD5; Mon, 25 Nov 2019 08:53:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191124235346epsmtip2b7ab829c6bf0a17771700d4bc29825ce~aPmXRJ2Sq1614516145epsmtip2t;
        Sun, 24 Nov 2019 23:53:46 +0000 (GMT)
Subject: Re: [PATCH v7 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f8838bc8-44db-551f-3199-eeea91e493f7@samsung.com>
Date:   Mon, 25 Nov 2019 08:59:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRj29N7eXnB1l0LHESMtdzFxKNDCwIOBuQibN2xm+BFjFhnewE0h
        9MvednNuTvxgMGQbZOJC1a3pxlIQhX6wwQSRUtkY0AnyFRA1A5NNHTgrC2Gitr0s8u95n/d5
        zpvnPXlJTNYriSNL9WbOpGe1NBGJX+zbkpK0Ac4UqOxDDyJvf7sELQ1eA+jC6LcA/VV/GUNz
        P80AdKmhCJ31+cXI6Z7B0eluF4Ga6ztxdP16mwQNv/e7BDlm74iRa25CjO7U/ChG1StNGAoc
        9wHUODkiQhOOOjEKtM0BNHJtB5p510Ggz/29BBoaHBWjim6fBFV7Vwn0z4QTRzc9sajx3ASG
        nEvM9nimvtoBmJYzLYBZnKqQMJ+Uj+CMzWVhXM3HCOaHiS6CcZ9/h3EudIiY3oUuEXNyVcWs
        9MkZz3glzpzwNAMm4IrP37i3LKuEY4s5k5LTFxmKS/WabHrXS4U5hekZKnWSOhM9RSv1rI7L
        pnN35yftLNUGd0Qr97NaS5DKZ3meTtmWZTJYzJyyxMCbs2nOWKw1ZhqTeVbHW/Sa5CKD7mm1
        SpWaHhS+XlZyymoXGS/ANxevDGHlwB1VDSJISG2F9slOSTWIJGVUB4BjK35MKP4E8PhHYyKh
        uAugq+8Wft8yfqMLFxrdADaN3V0rFgFsr5gEIVU09Sp0fPV1sEGSMZQJ1gwkhjQY9a8EXrRd
        xUIagkqEPTeniBDeSCXA8eW5sFdKbYP+yvawBqceg60VgfA78uCbg0usIImCAw3zYTqC2gfd
        tsMhGqNi4fT8WZGAFfDS7U/DaSA1RkLf1dNrAXJh4MMmIOBo+OsVj0TAcfDWyaNr+BBsGvAR
        grkKQE/Pd2KhkQZ7Gk+JQoMxagtsvZwi0Amw895nQBj8EFxYqhGHJJCSwqqjMkGyGX7/86xI
        wA/Dc5XHiFpAW9elsa6LYF0Xwfr/MBvAm8EmzsjrNByvNqau/2wXCJ9PYkYHsPt3ewFFAnqD
        tO2L6QKZmN3PH9R5ASQxOka6c3iqQCYtZg++xZkMhSaLluO9ID246zosTl5kCB6j3lyoTk9N
        S0tDW9UZ6Wo1HSsll0cKZJSGNXNlHGfkTPd9IjIirhy03XO27sk57M8se+WNB55UTD0hVbXk
        2fe1K5Q5uc+ye5JHFXV7uTwgtcp/0XSuyp97OSEmev7R3gOv7TqwcGjghVyNLfnMcKYrMq+/
        9vm+F0WVJvdv/VWzmmeORO+48YHy7/c3NQSmHy//g3qktbGWzPvmy+3nfW8rso5INy9/HM9H
        1d6mcb6EVSdiJp79Dxo3fjBUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9rpavs7GHg2UFlEZZVIfnsCkD11eCCIwuoHZ0Bc1t7n2
        ql0hK0RaF+2ywnWzvLSWkts0zVu0qZWW4WpzqZW6UhN12CrEW7mtYN/+nPP7nXM+HAoTVRDh
        VJoyk1UrZXIpKcCfWqWRaxbAnoR1tj4MWVqr+ehXextAZbYWgH5q6zDk+tIDUE1hErrX3EEg
        o7kHRzcbTSQyaJ/h6N27Sj56e3aUj/SfJghkcjkINHHxM4E0U48w5LnUDFBpVycPOfRXCOSp
        dAHU2bYV9ZzRk+hxxwsSvWm3ESi3sZmPNJZZEs05jDgarpKg0mIHhoy/mM0RjFajB0z53XLA
        uJ25fOZWTifOFJmyGJPhPMn0OhpIxlxymjGO1/KYF+MNPCZ/dh0zZRUzVfY8nLlcZQCMxxSx
        K/iAIDaZladls+rouEOC1Gu6BzxVGTzmfvkGywHmEA0IoiC9AdoHGnANEFAiuh7A56/vA38j
        DN7obME0gJrPodBq5fzMGIADvX2Ylwml90F9fRPuzYtpNawry+d7IYzOpWBFeyHfbwwAWDBr
        Ir0USUfB58NOXw6ml0L7pMu3TUjHwY68at9UnF4On+R6fFPF8xuGapz/mBD4uvAr7r0oiD4I
        zUWnvGWMXgFn7towf5bA7q/3eP4cCWvGbmMFIFQXYOsCFF2AogtQigBuAGGsilOkKLgYVYyS
        PbqWkym4LGXK2qQMhQn4nihqVS14X5JoATQFpAuFlRXdCSJCls0dV1gApDDpYuG2t84EkTBZ
        dvwEq85IVGfJWc4CllC4VCL8pmzdL6JTZJlsOsuqWPX/Lo8KCs8Bmxxq0+Ca4PqrDdf3pKsG
        5uj4I67IHys/9ldsKdYe3nvglfwz4dg4dw4MDU7vjKPLuz6FFeRETO8Xu8fnsusWfIgWx+5Y
        5D54Z9nqskeb02NGtpfG936Xrb95bTp+h32vvWlUIjd3W2ZGJg27LdV/7giswt8TJ3UXjP01
        u1uVcQ9HpDiXKouJwtSc7C+oqkdRQAMAAA==
X-CMS-MailID: 20191124235347epcas1p28508f778af78e31484ff54490986f2fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191122214539epcas1p34d4ca24634642e8a79c33d7a7c9291ba
References: <cover.1574458460.git.leonard.crestez@nxp.com>
        <CGME20191122214539epcas1p34d4ca24634642e8a79c33d7a7c9291ba@epcas1p3.samsung.com>
        <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 11/23/19 6:45 AM, Leonard Crestez wrote:
> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
> frequency switching is implemented inside TF-A, this driver wraps the
> SMC calls and synchronizes the clk tree.
> 
> The DRAM clocks on imx8m have the following structure (abridged):
> 
>  +----------+       |\            +------+
>  | dram_pll |-------|M| dram_core |      |
>  +----------+       |U|---------->| D    |
>                  /--|X|           |  D   |
>    dram_alt_root |  |/            |   R  |
>                  |                |    C |
>             +---------+           |      |
>             |FIX DIV/4|           |      |
>             +---------+           |      |
>   composite:     |                |      |
>  +----------+    |                |      |
>  | dram_alt |----/                |      |
>  +----------+                     |      |
>  | dram_apb |-------------------->|      |
>  +----------+                     +------+
> 
> The dram_pll is used for higher rates and dram_alt is used for lower
> rates. The dram_alt and dram_apb clocks are "imx composite" and their
> parent can also be modified.
> 
> This driver will prepare/enable the new parents ahead of switching (so
> that the expected roots are enabled) and afterwards it will call
> clk_set_parent to ensure the parents in clock framework are up-to-date.
> 
> The driver relies on dram_pll dram_alt and dram_apb being marked with
> CLK_GET_RATE_NOCACHE for rate updates.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/Kconfig      |   9 +
>  drivers/devfreq/Makefile     |   1 +
>  drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
>  3 files changed, 475 insertions(+)
>  create mode 100644 drivers/devfreq/imx8m-ddrc.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 59027d7ddf2a..5eac479dd05f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  Each memory bus group could contain many memoby bus block. It reads
>  	  PPMU counters of memory controllers by using DEVFREQ-event device
>  	  and adjusts the operating frequencies and voltages with OPP support.
>  	  This does not yet operate with optimal voltages.
>  
> +config ARM_IMX8M_DDRC_DEVFREQ
> +	tristate "i.MX8M DDRC DEVFREQ Driver"
> +	depends on ARCH_MXC && HAVE_ARM_SMCCC

I'll edit it as following and applied it.

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 5eac479dd05f..38a94df749a2 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,7 +93,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_IMX8M_DDRC_DEVFREQ
        tristate "i.MX8M DDRC DEVFREQ Driver"
-       depends on ARCH_MXC && HAVE_ARM_SMCCC
+       depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
+               (COMPILE_TEST && HAVE_ARM_SMCCC)

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
