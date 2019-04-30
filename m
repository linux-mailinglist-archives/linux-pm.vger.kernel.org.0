Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC6EFC6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 06:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfD3Equ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 00:46:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15344 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3Eqs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 00:46:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190430044644epoutp0464ebe082f9135f603f25c33d8c7cb81a~aJxe_w1r61242612426epoutp04f
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 04:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190430044644epoutp0464ebe082f9135f603f25c33d8c7cb81a~aJxe_w1r61242612426epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556599604;
        bh=ZtagW9yAH9OzdK8EJmx5SCUG7Tt++IsWQC6DpkvoB6U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FQqf6KGkt2nArjFdUi3KM6ndZWR76qidxdOOeLgYrqbes9mi69Lx8WcFdNZbJmSd1
         QkT0hcxum4gCFXiP1CFyka0yR/qRx6mZjA41A5wAK96sGqFAjb3CT44ldv+hUwzhCU
         CIGsVV6C6k/dCioPDaVAeNMo1IsDEl5yYmSnL3kY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190430044641epcas1p32db065de45b7d0691ad6402cdbf571c6~aJxcaG2Pl0489604896epcas1p3m;
        Tue, 30 Apr 2019 04:46:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.2B.04143.133D7CC5; Tue, 30 Apr 2019 13:46:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430044641epcas1p16b04ecf625625ca1ddd964392da9e638~aJxcEtC0Q2784827848epcas1p1F;
        Tue, 30 Apr 2019 04:46:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430044641epsmtrp25ceed12c165bfb841fd961ae0f03bddb~aJxcDstXZ0304003040epsmtrp2v;
        Tue, 30 Apr 2019 04:46:41 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-ba-5cc7d331d120
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.10.03692.033D7CC5; Tue, 30 Apr 2019 13:46:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430044640epsmtip234df2bd9f50e0d88ae8b1ef8ed40946a~aJxbyTflC2453724537epsmtip2k;
        Tue, 30 Apr 2019 04:46:40 +0000 (GMT)
Subject: Re: [PATCH v6 01/10] clk: samsung: add needed IDs for DMC clocks in
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
Message-ID: <9eb04a57-3e80-b0ba-334a-927493deb969@samsung.com>
Date:   Tue, 30 Apr 2019 13:47:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555683568-20882-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmga7h5eMxBlfuCVlsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOAnlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGcs77jBWjCbp2Ly526mBsY+ri5GTg4JAROJhU9vsHQx
        cnEICexglFiz7z0rhPOJUWJhVxszhPONUeLU8SWsMC33N96FqtrLKDHz6yoo5z2jRPPEh2wg
        VcICkRIrX09hAkmICCxnlNg39S4jiMMssJpJ4s/XtWCz2AS0JPa/uAHWwS+gKHH1x2OgIg4O
        XgE7iW27DUDCLAKqEud37WECsUUFIiTuH9sA1sorIChxcuYTFpByTgFviYtzZUHCzALiEree
        zGeCsOUlmrfOZoa4+hG7xP97ZRC2i0T/nQ6ob4QlXh3fwg5hS0l8freXDcKullh58ggbyMkS
        Ah2MElv2X4BqMJbYv3QyE8heZgFNifW79CF28Um8+9rDChKWEOCV6GgTgqhWlrj84C4ThC0p
        sbi9E2q8h8T1Y09ZJzAqzkLyzCwkH8xC8sEshGULGFlWMYqlFhTnpqcWGxYYI8f2JkZwQtcy
        38G44ZzPIUYBDkYlHl6Pd8dihFgTy4orcw8xSnAwK4nwehw/GiPEm5JYWZValB9fVJqTWnyI
        0RQY1hOZpUST84HZJq8k3tDUyNjY2MLE0MzU0FBJnHe9g3OMkEB6YklqdmpqQWoRTB8TB6dU
        A6MKp46WfhN/YuSGA/Nmamxyf/Pm7tNV/02v3lx8Mq36oGhAs2PMeR3jBn23Tc1bEhN+HZP3
        md6jKnTe74/P8if6X94y2wsrJ8jl1b8MehK/zW+L1YdYh6SwC3Y31rDOWs5R2KL56ORBlmOS
        XqaW0ed3dcc0Xu7yKFPTln2ZtmfD1HjhHSLTHiqxFGckGmoxFxUnAgDBz3ur/gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSvK7B5eMxBvemWVpsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKO4bFJSczLLUov07RK4MpZ33GAtmM1TMflzN1MDYx9X
        FyMnh4SAicT9jXdZuxi5OIQEdjNK9P47ygiRkJSYdvEocxcjB5AtLHH4cDFEzVtGia+/97KA
        1AgLREqsfD2FCSQhIrCcUWLu36UsIA6zwGomiUkft7BBtNxnlHj5oY8NpIVNQEti/4sbYDa/
        gKLE1R+PGUFW8ArYSWzbbQASZhFQlTi/aw8TiC0qECFx5v0KsG28AoISJ2c+YQEp5xTwlrg4
        VxYkzCygLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWch6Z6FpGUWkpZZSFoWMLKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjm0tzR2Ml5fEH2IU4GBU4uH1eHcsRog1say4MvcQ
        owQHs5IIr8fxozFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJx
        cEo1MJqGHJW8kOpybf6rn8XRM50X5yn/+ZByz6VD4my61BORqiNHvQ1PHGhPDVp2V7oq5Ojh
        hrWXNP8suNustmxZ40fz84on+L8wx4lJqLGu2/IkdeKEtqrbVeeS925kilsr2dix3+Kl5oVz
        +4s+v9psH7TJb4lk9cMjO34Upr467DT90T7D+raMUw+UWIozEg21mIuKEwH+1W086QIAAA==
X-CMS-MailID: 20190430044641epcas1p16b04ecf625625ca1ddd964392da9e638
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102@eucas1p2.samsung.com>
        <1555683568-20882-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 355f469..abb1842 100644
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
> @@ -195,6 +196,18 @@
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
> +#define CLK_CDREX_PAUSE		531
> +#define CLK_CDREX_TIMING_SET	532

I cannot find the usage code of both CLK_CDREX_PAUSE
and CLK_CDREX_TIMING_SET in these patchset. 

Please remove them.

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
