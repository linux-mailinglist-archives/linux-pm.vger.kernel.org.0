Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D994EE65
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfD3Bal (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 21:30:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57034 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbfD3Bal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 21:30:41 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430013037epoutp023465d7cf6f3585cdaafed06d7a672a7f~aHGQu4BxC3214332143epoutp02b
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 01:30:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430013037epoutp023465d7cf6f3585cdaafed06d7a672a7f~aHGQu4BxC3214332143epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556587837;
        bh=4m5c4OOPyKoCvxfFp701h6f4r77iQN/zPlAaz2ARB3E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=m2QwAVDPdX0YEaP6tEMtbxqauwQPwvUvFcjiapl+Tgi1OIif+Xv9/35eVQvwcygKS
         hiqjM02Wic+RILGAGRGd+UnmYqEwbirurPw6BElCCI46QW5Ws+AcVLBZZHsFCSp8s6
         s+T1r8bZ1jLkqqFYa2Eu6UKhUcTDvQ4IcsvzoCs4=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430013034epcas1p1c76d304f1726aa2472a6d6a3042b08c8~aHGNW7WUt2432124321epcas1p19;
        Tue, 30 Apr 2019 01:30:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.0F.04139.A35A7CC5; Tue, 30 Apr 2019 10:30:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430013033epcas1p135a42c27b60123896011f8f5b3976230~aHGMs0kIf2432124321epcas1p18;
        Tue, 30 Apr 2019 01:30:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430013033epsmtrp1791fa9c3d1f0676430c2cc36d1c68d08~aHGMrvQbF0828508285epsmtrp1Q;
        Tue, 30 Apr 2019 01:30:33 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-9a-5cc7a53a3823
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.E5.03692.935A7CC5; Tue, 30 Apr 2019 10:30:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430013033epsmtip1649b3085cd7d0a02b2d18877f4970060~aHGMYUt8O1994419944epsmtip1h;
        Tue, 30 Apr 2019 01:30:33 +0000 (GMT)
Subject: Re: [PATCH v6 02/10] clk: samsung: add new clocks for DMC for
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
Message-ID: <68c3d065-ff8e-1ed5-204a-27bacebdbbb8@samsung.com>
Date:   Tue, 30 Apr 2019 10:31:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555683568-20882-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmga7V0uMxBj87OS02zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAzygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL
        9IoTc4tL89L1kvNzrQwNDIxMgQoTsjNezVrBVNBgVHHv5022Bsbfml2MnBwSAiYSFx7MZuli
        5OIQEtjBKLH/8FVmkISQwCdGiZNbYiDsb4wSm7/XwDR86/rCDNGwl1FiZ+NUKOc9o0TDx3Os
        IFXCAuESx48eZwdJiAgsZ5TYN/UuI4jDLLCaSeLP17VgVWwCWhL7X9xgA7H5BRQlrv54zAhi
        8wrYScw8eBzsDhYBVYmGz4fB4qICERL3j21ghagRlDg58wkLiM0p4C2x+8ApMJtZQFzi1pP5
        TBC2vETz1tlg50kIXGOXOPV3AzPEEy4S93e+hrKFJV4d38IOYUtJvOxvg7KrJVaePMIG0dzB
        KLFl/wVWiISxxP6lk4E2cABt0JRYv0sfYhmfxLuvPawgYQkBXomONiGIamWJyw/uMkHYkhKL
        2zvZIGwPiZ/vV7BOYFScheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBEju5NjOCUrmW6
        g3HKOZ9DjAIcjEo8vB7vjsUIsSaWFVfmHmKU4GBWEuH1OH40Rog3JbGyKrUoP76oNCe1+BCj
        KTC0JzJLiSbnA/NNXkm8oamRsbGxhYmhmamhoZI473oH5xghgfTEktTs1NSC1CKYPiYOTqkG
        RtkFbuH6VSfnusaXVR+R28ax4HO+1czf1S/CcyTurjRMvppzrbfvx8WXNS2HjvPa9yslXuVL
        Fnp9qzrAedrE36/OV5Rbl9yf11AVd2NJTuorxSsFJauudN1ZXyvYNH1jTcU0u1KbHKt2s8hk
        P2m2Ffx5yr5KWnJGxiu87+9p6770Mf7u7fydSizFGYmGWsxFxYkAjLCzX/8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSnK7l0uMxBn/nSFhsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKO4bFJSczLLUov07RK4Ml7NWsFU0GBUce/nTbYGxt+a
        XYycHBICJhLfur4wg9hCArsZJY7v5oSIS0pMu3gUKM4BZAtLHD5c3MXIBVTyllHizsmTLCA1
        wgLhEsePHmcHSYgILGeUmPt3KQuIwyywmkli0sctbBBT7zNK/LjMCGKzCWhJ7H9xAyzOL6Ao
        cfXHY7A4r4CdxMyDx8GuYBFQlWj4fBgsLioQIXHm/QoWiBpBiZMzn4DZnALeErsPnAKzmQXU
        Jf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWG
        eanlesWJucWleel6yfm5mxjBsa2luYPx8pL4Q4wCHIxKPLwe747FCLEmlhVX5h5ilOBgVhLh
        9Th+NEaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxuhs
        Q/XzvqGLZO5J8Zc+ub7DkrHp5pkP0gV7mOtSs6cH9d+5V+3ZzReY/cs8zefB3ZkNNTnSyzkn
        H3z/srt3yam7Hu9ct2+v7RXIt7R+JpE2Rd/DqK3vc3tvUlGrnN3b98sFt7lHhly8U//3yZmE
        dWnhO78l2S6IVbs/N+5pVE2QnCffmc9+SizFGYmGWsxFxYkAQH7GQukCAAA=
X-CMS-MailID: 20190430013033epcas1p135a42c27b60123896011f8f5b3976230
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb@eucas1p2.samsung.com>
        <1555683568-20882-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

I have no objection about this patch. 
Instead, as I commented on v4, in order to reduce the confusion
about multiple clock definitions with same bit range of DIV_CDREX0,

You need to add the additional comment and you better to
define the three clocks at the nearby in this driver.
(CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1)
If they are scattered, it is difficult for understanding
why they are developed like this.

[1] [v4,2/8] clk: samsung: add new clocks for DMC for Exynos5422 SoC
- https://lkml.org/lkml/2019/2/12/12

Regards,
Chanwoo Choi


On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c..d9e6653 100644
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
> @@ -817,6 +827,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>  			DIV_CDREX0, 3, 5),
>  
> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
> +
>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>  			DIV_CDREX1, 8, 3),
>  
> @@ -1170,6 +1182,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
