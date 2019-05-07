Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF515E3E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGHeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 03:34:46 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24635 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfEGHeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 03:34:46 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190507073443epoutp03dfaa9a0db3431c9cefb69cfb7c52d018~cVlKSpCf53105431054epoutp03f
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 07:34:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190507073443epoutp03dfaa9a0db3431c9cefb69cfb7c52d018~cVlKSpCf53105431054epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557214483;
        bh=1G6LhtqaYaB5VMtjqXHhyb4OBLmdb4SKk7srtqoCQqE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l4tgowxNPSKtMPhoZ3vUK/asYT7E5aPxpymGqcF9+Xj/mVkae9huyKjQ5Uk/H25d8
         LfMd5seup5F+Pw6+Nqu2VOkU3JV5hvMnYzHcU3gPWIgm93uWe1x0ACrShkw439e++s
         3I9b96+YXFwmCCwjQ0KCzB5woC3lCg12ST7awwn8=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190507073439epcas1p2b6bf0454e3649eaa2df0ae42bebaa5de~cVlGHMO2J3029030290epcas1p2u;
        Tue,  7 May 2019 07:34:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.B2.04142.F0531DC5; Tue,  7 May 2019 16:34:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190507073438epcas1p4f416dedf826a863b0b7880d3c11578c1~cVlFyjMgl2587125871epcas1p4Y;
        Tue,  7 May 2019 07:34:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190507073438epsmtrp1ad8a90545881cb064c2ddde12fce4c4d~cVlFqN4e63103931039epsmtrp1g;
        Tue,  7 May 2019 07:34:38 +0000 (GMT)
X-AuditID: b6c32a36-14a859c00000102e-57-5cd1350f04c5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.AA.03692.E0531DC5; Tue,  7 May 2019 16:34:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507073438epsmtip2c6fc4d08d564d610bb3e5bf8b0411472~cVlFZCthb1751617516epsmtip2h;
        Tue,  7 May 2019 07:34:38 +0000 (GMT)
Subject: Re: [PATCH v7 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
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
Message-ID: <3446b2d0-bf6a-66e9-9841-533fae4b27af@samsung.com>
Date:   Tue, 7 May 2019 16:36:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557155521-30949-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmgS6/6cUYg5YWPouNM9azWsw/co7V
        YvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac38dksfbI
        XXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHl8+zqJxWN2w0UWj52z7rJ7bFrVyebR2/yO
        zePguz1MHn1bVjF6bD5d7fF5k1wAZ1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
        hbmSQl5ibqqtkotPgK5bZg7QM0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssC
        veLE3OLSvHS95PxcK0MDAyNToMKE7IzLS1pYC3aYVTzr7mVuYNyl28XIySEhYCJx6lkbaxcj
        F4eQwA5Gib3bDrNBOJ8YJX7M7GWBcL4xSjxb+5cdpmVf7y12iMReRon9k1cxQzjvGSW2rFjM
        AlIlLBAu0Tn7JlhCRGA5o8S+qXcZQRxmgdVMEn++rmUFqWIT0JLY/+IGG4jNL6AocfXHY6Ai
        Dg5eATuJPTMiQUwWARWJfdvEQCpEBSIk7h/bANbJKyAocXLmExaQEk4Bb4k7r91BwswC4hK3
        nsxngrDlJZq3zgY7QULgEbvEvTk/mEHqJQRcJI4e5YV4Rlji1fEtUI9JSbzsb4OyqyVWnjzC
        BtHbAfTX/gusEAljif1LJzOBzGEW0JRYv0sfYhefxLuvPawQ43klOtqEIKqVJS4/uMsEYUtK
        LG7vZIOwPSQuLullm8CoOAvJM7OQfDALyQezEJYtYGRZxSiWWlCcm55abFhghBzZmxjB6VzL
        bAfjonM+hxgFOBiVeHgf2F6IEWJNLCuuzD3EKMHBrCTCm/jsXIwQb0piZVVqUX58UWlOavEh
        RlNgUE9klhJNzgfmmrySeENTI2NjYwsTQzNTQ0Mlcd71Ds4xQgLpiSWp2ampBalFMH1MHJxS
        DYxGkl+952yUMFj99hJvwf+HvxN2Z7yyfFvcpKTN9bd5RvPPc2075c/r7TO+mtYjphbqf0xr
        /9Wsub6rK4z9rSyar01t2fRDo/fvzw69Ge2dUbYGmSr5rmeOFFn9K/n26sUKJc2oj7+MORdG
        TzlptC/kSGns5dWiWw3O1PGvXSH36/U9TZ3ZkzOUWIozEg21mIuKEwHNP7fk/QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCSvC6f6cUYg39L9Cw2zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFFcNimpOZllqUX6dglcGZeXtLAW7DCreNbdy9zAuEu3
        i5GTQ0LARGJf7y12EFtIYDejxOWfyRBxSYlpF48ydzFyANnCEocPF3cxcgGVvGWUWPJpMzNI
        jbBAuETn7JvMIAkRgeWMEnP/LmUBcZgFVjNJTPq4hQ2i5T6jxPbll1lBWtgEtCT2v7jBBmLz
        CyhKXP3xmBFkBa+AncSeGZEgJouAisS+bWIgFaICERJn3q9gAbF5BQQlTs58wgJSwingLXHn
        tTtImFlAXeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs9C0j0LScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhgmJdarlecmFtcmpeul5yfu4kRHNdamjsYLy+JP8QowMGoxMPbYX0hRog1say4MvcQ
        owQHs5IIb+KzczFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJx
        cEo1MIY8ThB/9+XCQx/BWT4cSo6bbnR0PHjRz7XX4OuVabuiH2yfwfl9a0XTGzdmnel7CmYp
        n93HG3XlJ4PVbf4W7j8Fv/cKPO18v7L+1LsDvNE6CbvyZ3xhW/3yUOn+eQ+vdiuE3t9/0eHa
        Dmmx9nkGhw0LwuR9RBUc+3qL4hfwV6WtYp+kmncptF2JpTgj0VCLuag4EQBqZRWR5wIAAA==
X-CMS-MailID: 20190507073438epcas1p4f416dedf826a863b0b7880d3c11578c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b@eucas1p2.samsung.com>
        <1557155521-30949-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 58 +++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c..af62b6d 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -134,6 +134,8 @@
>  #define SRC_CDREX		0x20200
>  #define DIV_CDREX0		0x20500
>  #define DIV_CDREX1		0x20504
> +#define GATE_BUS_CDREX0		0x20700
> +#define GATE_BUS_CDREX1		0x20704
>  #define KPLL_LOCK		0x28000
>  #define KPLL_CON0		0x28100
>  #define SRC_KFC			0x28200
> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>  	DIV_CDREX1,
>  	SRC_KFC,
>  	DIV_KFC0,
> +	GATE_BUS_CDREX0,
> +	GATE_BUS_CDREX1,
>  };
>  
>  static const unsigned long exynos5800_clk_regs[] __initconst = {
> @@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>  PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>  PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
> +					"mout_sclk_mpll", "ff_dout_spll2",
> +					"mout_sclk_spll", "mout_sclk_epll"};
>  
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>  		exynos5800_fixed_factor_clks[] __initconst = {
>  	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>  };
>  
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
> @@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>  	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>  
> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +
>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>  	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>  			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>  
>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>  	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>  	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
> @@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
>  
>  	/* CDREX Block */
> +	/*
> +	 * The three clocks below are controlled using the same register and
> +	 * bits. They are put into one because there is a need of
> +	 * synchronization between the BUS and DREXs (two external memory
> +	 * interfaces).
> +	 * They are put here to show this HW assumption and for clock
> +	 * information summary completeness.
> +	 */
>  	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
>  			DIV_CDREX0, 28, 3),
> +	DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
> +			DIV_CDREX0, 28, 3),
> +	DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
> +			DIV_CDREX0, 28, 3),
> +
>  	DIV_F(CLK_DOUT_SCLK_CDREX, "dout_sclk_cdrex", "mout_mclk_cdrex",
>  			DIV_CDREX0, 24, 3, CLK_SET_RATE_PARENT, 0),
>  	DIV(CLK_DOUT_ACLK_CDREX1, "dout_aclk_cdrex1", "dout_clk2x_phy0",
> @@ -817,6 +840,7 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>  			DIV_CDREX0, 3, 5),
>  
> +

Maybe, it is not related to this patch? Please remove it.

>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>  			DIV_CDREX1, 8, 3),
>  
> @@ -1170,6 +1194,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>  			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>  
>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
> +
> +	/* CDREX */
> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 0, 0, 0),
> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 1, 0, 0),
> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>  };
>  
>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
> 

If you fix minor issue about adding the unneeded blanke line,
feel free to add my acked-by tag:

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
