Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D359515E3B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEGHcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 03:32:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41654 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfEGHcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 03:32:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190507073219epoutp019cb216cec25f970bce058cc34cb5ca04~cVjDxBUzU0215902159epoutp01F
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 07:32:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190507073219epoutp019cb216cec25f970bce058cc34cb5ca04~cVjDxBUzU0215902159epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557214339;
        bh=tFHGDRRfdLTDhSz5hJ8Dy0HOsMTdJJJeVQpZJnvzqTc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GOz6MhcauDEu1U6FJlv4f4TOc9dhsU9pOZW2/o4wIjUqLw12wCt88631B7EzXxXry
         ItRvHKA/RwQ7Cgpm9D5RYg7bI/2gp3PIKBGbQHTawAOAugC5FaE8S7vUso8Ry3Ausz
         qNHgK9pDrl5tDVs208c2/uV603iNWlQVIyD6nnxI=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190507073216epcas1p2a8106a09c66f3030f54288a8526544c8~cVjBA4C-r1822218222epcas1p2Q;
        Tue,  7 May 2019 07:32:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.CF.04108.08431DC5; Tue,  7 May 2019 16:32:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190507073215epcas1p4ec7ba8c6174f577380d349cc265e6164~cVjAj0NGL0520505205epcas1p4T;
        Tue,  7 May 2019 07:32:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507073215epsmtrp266d42dd5bbcdee13e780d4ac850b4cd3~cVjAi3qoi0371003710epsmtrp2Y;
        Tue,  7 May 2019 07:32:15 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-fd-5cd134807346
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.38.03662.F7431DC5; Tue,  7 May 2019 16:32:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190507073215epsmtip1623212646bc6558738fbf534664c2724~cVjARnntt2392923929epsmtip1L;
        Tue,  7 May 2019 07:32:15 +0000 (GMT)
Subject: Re: [PATCH v7 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8b063f30-1a4d-3292-2e57-6e33e94d57ae@samsung.com>
Date:   Tue, 7 May 2019 16:33:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmrm6DycUYg92vxSw2zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAzygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL
        9IoTc4tL89L1kvNzrQwNDIxMgQoTsjO2/VnJXHBDtGLL0n9sDYyvBLsYOTgkBEwkluwR6mLk
        4hAS2MEo8fPsTzYI5xOjxP/1N1i7GDmBnG+MEjt26YLYIA231rSyQBTtZZQ48aSfGcJ5zyix
        /+tHJpAqYYFIiVVzfzGCJEQEljNK7Jt6F8xhFljNJPHn61qwuWwCWhL7X9xgA7H5BRQlrv54
        zAhi8wrYSXz+8I8FxGYRUJH4vwyiRlQgQuL+sQ2sEDWCEidnPgGr4RTwllj96xTYZmYBcYlb
        T+ZD2fISzVtng50nIXCLXeL27YWsEE+4SEw+9YkJwhaWeHV8CzuELSXx+d1eNgi7WmLlySNs
        EM0djBJb9l+AajaW2L90MhMo+JgFNCXW79KHWMYn8e5rDyskVHklOtqEIKqVJS4/uAu1SlJi
        cXsn1HgPidUTTrBMYFScheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBFju5NjOCUrmW5
        g/HYOZ9DjAIcjEo8vA9sL8QIsSaWFVfmHmKU4GBWEuFNfHYuRog3JbGyKrUoP76oNCe1+BCj
        KTC0JzJLiSbnA/NNXkm8oamRsbGxhYmhmamhoZI473oH5xghgfTEktTs1NSC1CKYPiYOTqkG
        Rg050f+TFef8fv9+74v6QD6dCTO4Jsf0vo6drK94fs+fMqu70p2uaVf+2i55dnNZ5MU0IZV5
        QXteM/4RPeWSdd2s3zt9v1TG5b1xidUFeqLGndLxCk3ip/mmlIq43Ij/Ucoq/Xrig7QTngzP
        pI+cKv8iIrjEPfDOye5iie032Yw7nxh36E5VU2Ipzkg01GIuKk4EAADe3Rn/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSnG69ycUYg3Xv9S02zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFFcNimpOZllqUX6dglcGdv+rGQuuCFasWXpP7YGxleC
        XYycHBICJhK31rSydDFycQgJ7GaUWPr/MxNEQlJi2sWjzF2MHEC2sMThw8UQNW8ZJZrv9rOB
        1AgLREqsmvuLESQhIrCcUWLu36Vgk5gFVjNJTPq4hQ2i5T6jxMV3H1lAWtgEtCT2v7gB1s4v
        oChx9cdjRhCbV8BO4vOHf2A1LAIqEv+XQdSICkRInHm/ggWiRlDi5MwnYDangLfE6l+nwE5l
        FlCX+DPvEjOELS5x68l8qLi8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYs
        MMpLLdcrTswtLs1L10vOz93ECI5vLa0djCdOxB9iFOBgVOLh7bC+ECPEmlhWXJl7iFGCg1lJ
        hDfx2bkYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyr
        PX1EVMOP2J7wDWw7F3t5gbFC2my5+DqHPRUPd7cWK3DMuSC/I+3izUuFadOjpzN7PNfYpldU
        dub+Q7azyzrX9f97v31J+pGbTReSOn2jl+hdVxXve/e5XkdL5t7NezMrt8uc21iwfbHUM/+e
        kk1JjwIu6fkd45tuw+VqWWjj0a556pz16ilKLMUZiYZazEXFiQC9W1ty6wIAAA==
X-CMS-MailID: 20190507073215epcas1p4ec7ba8c6174f577380d349cc265e6164
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf@eucas1p1.samsung.com>
        <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 355f469..bf50d8a 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -60,6 +60,7 @@
>  #define CLK_MAU_EPLL		159
>  #define CLK_SCLK_HSIC_12M	160
>  #define CLK_SCLK_MPHY_IXTAL24	161
> +#define CLK_SCLK_BPLL		162
>  
>  /* gate clocks */
>  #define CLK_UART0		257
> @@ -195,6 +196,16 @@
>  #define CLK_ACLK432_CAM		518
>  #define CLK_ACLK_FL1550_CAM	519
>  #define CLK_ACLK550_CAM		520
> +#define CLK_CLKM_PHY0		521
> +#define CLK_CLKM_PHY1		522
> +#define CLK_ACLK_PPMU_DREX0_0	523
> +#define CLK_ACLK_PPMU_DREX0_1	524
> +#define CLK_ACLK_PPMU_DREX1_0	525
> +#define CLK_ACLK_PPMU_DREX1_1	526
> +#define CLK_PCLK_PPMU_DREX0_0	527
> +#define CLK_PCLK_PPMU_DREX0_1	528
> +#define CLK_PCLK_PPMU_DREX1_0	529
> +#define CLK_PCLK_PPMU_DREX1_1	530
>  
>  /* mux clocks */
>  #define CLK_MOUT_HDMI		640
> @@ -217,6 +228,8 @@
>  #define CLK_MOUT_EPLL		657
>  #define CLK_MOUT_MAU_EPLL	658
>  #define CLK_MOUT_USER_MAU_EPLL	659
> +#define CLK_MOUT_SCLK_SPLL	660
> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>  
>  /* divider clocks */
>  #define CLK_DOUT_PIXEL		768
> @@ -243,13 +256,16 @@
>  #define CLK_DOUT_ACLK300_GSCL	789
>  #define CLK_DOUT_ACLK400_DISP1	790
>  #define CLK_DOUT_PCLK_CDREX	791
> -#define CLK_DOUT_SCLK_CDREX	792
> -#define CLK_DOUT_ACLK_CDREX1	793
> -#define CLK_DOUT_CCLK_DREX0	794
> -#define CLK_DOUT_CLK2X_PHY0	795
> -#define CLK_DOUT_PCLK_CORE_MEM	796

The your previous patch didn't change the id number
of already exiting clocks. It cause the fault.
In order to keep the compatibility, you keep
the original id number without modification.

Please don't change the id number of the existing clocks
and then just add the new clocks.


> +#define CLK_DOUT_PCLK_DREX0	792
> +#define CLK_DOUT_PCLK_DREX1	793
> +#define CLK_DOUT_SCLK_CDREX	794
> +#define CLK_DOUT_ACLK_CDREX1	795
> +#define CLK_DOUT_CCLK_DREX0	796
> +#define CLK_DOUT_CLK2X_PHY0	797
> +#define CLK_DOUT_PCLK_CORE_MEM	798
> +#define CLK_FF_DOUT_SPLL2	799
>  
>  /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		797
> +#define CLK_NR_CLKS		800
>  
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
