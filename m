Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D414C15FF3
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEGI7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 04:59:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54422 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfEGI7E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 04:59:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190507085902euoutp010652c377bb0977481f09a9dbf19fbc01~cWux1oGyz0976809768euoutp01E
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 08:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190507085902euoutp010652c377bb0977481f09a9dbf19fbc01~cWux1oGyz0976809768euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557219542;
        bh=zsnQ2n2sg+rEiILd09HmkOJl5HNryLGFO+yYeT8WV/U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=szUKukNxLntVCtU+T/HsfE7ZiwSLQINNri08d2dKf6x03UGp2cKBykIfi4uil6hMm
         7UN1ieEKHWP5sGUW3rJ+agt63hi0cnkoxF4Bd5K+dfUtJS94knZwsESTy5H482m2fX
         3F7UG3QFkrm1CCG25dy3uHqExLSqFGhUCni1H9Ps=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507085901eucas1p13d6f11571d0d43d21a48a64fc024d2c8~cWuw-rlQd1893818938eucas1p14;
        Tue,  7 May 2019 08:59:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.5F.04325.5D841DC5; Tue,  7
        May 2019 09:59:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190507085901eucas1p1f193d43196da1a4d6096ac14d6a7fc27~cWuwPHOVm1906619066eucas1p1v;
        Tue,  7 May 2019 08:59:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507085901eusmtrp2d739bcb5aee56f56c21c0177c7cc9a8b~cWuwOSp1Q0476004760eusmtrp2I;
        Tue,  7 May 2019 08:59:01 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-9e-5cd148d5a2ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.16.04146.4D841DC5; Tue,  7
        May 2019 09:59:00 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507085900eusmtip2b6cc41775693831dbb9dd5ebc600f1b8~cWuvf1knB1723817238eusmtip2h;
        Tue,  7 May 2019 08:59:00 +0000 (GMT)
Subject: Re: [PATCH v7 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <c6f4cf53-0238-073a-eeee-28a62835c914@partner.samsung.com>
Date:   Tue, 7 May 2019 10:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3446b2d0-bf6a-66e9-9841-533fae4b27af@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTYRCG/bq77UIsfqwHIyLGRhIwseIR/YxGEQ1ZJRr9JQKJrropBIra
        BRUxESQeVC4hKLbWOwIFVBARiGe5RUGiRhHvGs9q1ALGSETahci/Z2beN/NOMizFORhfNjYh
        UTQkCPEapSdd3fS7fcZjvjM62LkvgFQUXmLIk54PDDnV0M6Q0h92RPLvWhTk3mE9ybF/oUhH
        x2UVub/PoSIP604oiTOrAZHCjpsKUt7wQkW604qVpN5xkCG3Hq0k3X+8SF/LWxTC8X29eTRv
        Tu2k+VrTCxVfac1Q8lnp35R8dpUV8VfaUnhnpf8aNtJz0RYxPnaHaJi5eKNnjP3NdcW2OrLr
        aEaeKhV91hqRBwt4LpgaaxkXc7gYwZH0ZUbkOcg9CLq6HEgunAhsfTZq2NFdcoOWB0UIWu5l
        M3LxFcEv80vkUo3F6yDD3EW5BuPwOQQFJX8UroLCpQro7y0ftLCsEmuhxrrdZVDjMHDetitd
        TONp0Naa5g41HkfAq6bLjKzxhtbj72gXe+Al8LO8180U9oFn704pZJ4C6VfN7sWAj7NQ1fIc
        ybmXg2XgokrmsfC5uWqI/WCgVjYDliA168yQfg/YcyxDmoVQ39zpzkzhILhUN1NuLwVjT7G7
        DdgLnn71liN4QV71MUpuq+HQAU5WB0JV5oOhRROgqOyoKhdpTCMOM404xjTiGNP/vacRbUU+
        YpKk14nSnARxp1YS9FJSgk67eau+Eg3+YNvf5t4adLN/kw1hFmlGq3NDH0RzjLBDStbbELCU
        ZpxaeN8ezam3CMm7RcPWDYakeFGyoUksrfFRp4x6HcVhnZAoxoniNtEwPFWwHr6pyCuI1wbH
        nx9T4f9pVaP1WohvaVzGiXmWgECyMnLR2cV7WvODyg44JuXPrglrO1tQp7ZxDvvE2LU680Jh
        avjejy0nB/wfF/59exd9CzO2/rqwwM+Wntyfe7jr0Zfc76E5Efszw7m4er69Wrli/XwPy/jJ
        z4KMugXH0gqOJK6Omua9646GlmKEWdMpgyT8A+piolF/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd0rHhdjDGY9s7HYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyHj/cw1Swy6JiWuck9gbGV3pdjJwcEgImErdX7mXpYuTiEBJYyihx
        4VADI0RCTGLSvu3sELawxJ9rXWwQRa8ZJZYvP84KkhAWCJfonH2TGcQWEVjMKPG1tRqkiFlg
        NZPEpI9boDqmMEn8mXyUqYuRg4NNQE9ix6pCkAZeATeJzwces4HYLAIqEqdPNoINFRWIkDjz
        fgULRI2gxMmZT8BsTgF7iU9rv4LZzAJmEvM2P2SGsMUlbj2ZzwRhy0s0b53NPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwNjfduzn5h2MlzYGH2IU4GBU
        4uF9YHshRog1say4MvcQowQHs5IIb+KzczFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9M
        S3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhg7tztp99ddENUL
        3Dr143PHv9vcErOz4l/WW3NPnaPcYfBiljzHjbI88cPhSzdNak+KesbDLs2ScvHkNq1IIY1N
        Hk2W5p+XXjFvFrLee6/xpriUpVFg7W4mw+VMTX1/bRLuT5tS+7SlqPAF05mNzyMCJVa/0JnR
        /5SPt6r4SmLkts2af+Rn71BiKc5INNRiLipOBADhUUvnEwMAAA==
X-CMS-MailID: 20190507085901eucas1p1f193d43196da1a4d6096ac14d6a7fc27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b@eucas1p2.samsung.com>
        <1557155521-30949-3-git-send-email-l.luba@partner.samsung.com>
        <3446b2d0-bf6a-66e9-9841-533fae4b27af@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/7/19 9:36 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 58 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c..af62b6d 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -134,6 +134,8 @@
>>   #define SRC_CDREX		0x20200
>>   #define DIV_CDREX0		0x20500
>>   #define DIV_CDREX1		0x20504
>> +#define GATE_BUS_CDREX0		0x20700
>> +#define GATE_BUS_CDREX1		0x20704
>>   #define KPLL_LOCK		0x28000
>>   #define KPLL_CON0		0x28100
>>   #define SRC_KFC			0x28200
>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>   	DIV_CDREX1,
>>   	SRC_KFC,
>>   	DIV_KFC0,
>> +	GATE_BUS_CDREX0,
>> +	GATE_BUS_CDREX1,
>>   };
>>   
>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>> @@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>   PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>>   PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>>   PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>> +					"mout_sclk_mpll", "ff_dout_spll2",
>> +					"mout_sclk_spll", "mout_sclk_epll"};
>>   
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock
>> @@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
>>   static const struct samsung_fixed_factor_clock
>>   		exynos5800_fixed_factor_clks[] __initconst = {
>>   	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>   };
>>   
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>> @@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>   	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>   
>> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>> +
>>   	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>   	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>   			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>   	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>   
>>   	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>> @@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   
>>   	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>   	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>   	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>   	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>   	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>> @@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>   			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
>>   
>>   	/* CDREX Block */
>> +	/*
>> +	 * The three clocks below are controlled using the same register and
>> +	 * bits. They are put into one because there is a need of
>> +	 * synchronization between the BUS and DREXs (two external memory
>> +	 * interfaces).
>> +	 * They are put here to show this HW assumption and for clock
>> +	 * information summary completeness.
>> +	 */
>>   	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
>>   			DIV_CDREX0, 28, 3),
>> +	DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
>> +			DIV_CDREX0, 28, 3),
>> +	DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
>> +			DIV_CDREX0, 28, 3),
>> +
>>   	DIV_F(CLK_DOUT_SCLK_CDREX, "dout_sclk_cdrex", "mout_mclk_cdrex",
>>   			DIV_CDREX0, 24, 3, CLK_SET_RATE_PARENT, 0),
>>   	DIV(CLK_DOUT_ACLK_CDREX1, "dout_aclk_cdrex1", "dout_clk2x_phy0",
>> @@ -817,6 +840,7 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>   	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>   			DIV_CDREX0, 3, 5),
>>   
>> +
> 
> Maybe, it is not related to this patch? Please remove it.
OK
> 
>>   	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>   			DIV_CDREX1, 8, 3),
>>   
>> @@ -1170,6 +1194,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>   			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>   
>>   	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>> +
>> +	/* CDREX */
>> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 0, 0, 0),
>> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 1, 0, 0),
>> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>>   };
>>   
>>   static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>>
> 
> If you fix minor issue about adding the unneeded blanke line,
> feel free to add my acked-by tag:
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you.

Regards,
Lukasz
> 
