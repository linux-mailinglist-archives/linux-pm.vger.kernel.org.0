Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F403F9A2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfD3NMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 09:12:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54271 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfD3NMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 09:12:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190430131251euoutp012e95399ccb360d7f62e2a3cb4c5412fe~aQrZISSxn0994009940euoutp01S
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 13:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190430131251euoutp012e95399ccb360d7f62e2a3cb4c5412fe~aQrZISSxn0994009940euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556629971;
        bh=8bSuQijgu0eeOTJ39ZozZtxmvL00ioedCp6uNSpBsPY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oz7qaeSRiJogczPGxWqpgObFDk4wKtzzsDKrjGnR5SA2CylreWgtnFf9/kP7YhHMK
         AV+mHyrIA+jGvy2t/NyobAXTQrrw1hDrBv7mtP6pgqw56EDdf7616fm0fLKlltbFT7
         9ix/ToPM1KPoytfdbMcpo8yEkYaPkGDjPf/IV1dU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430131250eucas1p26150156604ec7482389ce143097d1b5d~aQrYIudzS1424214242eucas1p2a;
        Tue, 30 Apr 2019 13:12:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.26.04298.2D948CC5; Tue, 30
        Apr 2019 14:12:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430131249eucas1p1bf69401061f2403dc5826bb357e64d85~aQrXNt1aV1968119681eucas1p1V;
        Tue, 30 Apr 2019 13:12:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430131249eusmtrp2468ead4aee9d40c5111e71937236b0cb~aQrW9-SNm2437624376eusmtrp2R;
        Tue, 30 Apr 2019 13:12:49 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-65-5cc849d2b344
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 92.B7.04146.1D948CC5; Tue, 30
        Apr 2019 14:12:49 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430131248eusmtip2c576406d9a86b50f4432c9e18ee814c9~aQrWJgd5_2479224792eusmtip2e;
        Tue, 30 Apr 2019 13:12:48 +0000 (GMT)
Subject: Re: [PATCH v6 02/10] clk: samsung: add new clocks for DMC for
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
Message-ID: <096f5419-9216-8969-cff2-745577409c7c@partner.samsung.com>
Date:   Tue, 30 Apr 2019 15:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68c3d065-ff8e-1ed5-204a-27bacebdbbb8@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0gUcRDud7u3ux6drJfpoL04COyhJin9elAJPbaSivpDK6GuXNTyzrrN
        yrS4krJM05ReV6ceQupZaaahFj0880zTSxOTzIoUBVMhT4/KslzXyP++mflm5vuGYQhVn9yL
        idYd5fU6TYyaUpCPan/YfVs21YUv6R7zxg9uFMvxu+FeOc6paZLjom9dCGfVm2T49SUtTu/6
        SmC7vYTGjWf7afy26jaFHWk1CN+wP5XhezWdNO44U0Bha3+yHD9r3Yw7Rl2xs+4LWqvinCOZ
        JHfL0ExylcZOmiu1XKS4tKRBirtcZkHcw4YEzlE6ZzuzW7Eqgo+JPsbr/VfvU0Rll5vJw7nL
        TjQ8/kAakNM3BbkwwAaC1dJGiFjFFiCwFc5JQYpxPIyg3zZKSYEDQbK1aZzFTHRkJW+U8vkI
        in73klIwgGCotocSR81gQ8H20kaLBXc2D8HVwlGZGBBskQx+jdyTi6Mo1g8qLEfEBiW7AZ70
        mkgRk+x8aM3LRiKeyYbBp9oSucRxg1c3uyc4LuwaGCzKnNBNsJ7wvjtHJuG5kFR+ixB3AXuV
        gdsvniNJ9jrovBkkeZ4BfbYyWsKz4E+l1AusAIY0M5JwInSlmyY5K8Fqa56QTLALoLjKX0oH
        Q3t7j0ya7grtA26SAlfIfHR98lZKuHBeJbF9oCz1zeQiD8i/e43OQGrjFF/GKV6MU7wY/+/N
        RaQFefJxgjaSFwJ0/HE/QaMV4nSRfgditaVo/AMbxmxDFWikZX81Yhmknq70Gf9GlVxzTIjX
        ViNgCLW7krO9DFcpIzTxJ3l97F59XAwvVCNvhlR7KhOmfd6jYiM1R/lDPH+Y1/+ryhgXLwNK
        yqlP3GZuw/S+kQJvdXCs2Zlxbfn5JxkRoR8Hgk5dKQ8tDczcGUUv/u3X5lXCn24MFDwSPobU
        mPId/puX+9xvXORm3LpJkZrTs+t7fQdVteNOVpwhebg4fqt/tuNBu12Xfc6RvnTFifXzhpwH
        A5mffafvRm1xyD63mKeFVM42hXWqSSFKE7CQ0Auav/dnn9d9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7oXPU/EGPydKGOxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlzNu6kKVggXnF6d13WBoYv+l2MXJwSAiYSExud+9i5OIQEljKKLHg
        5QuWLkZOoLiYxKR929khbGGJP9e62CCKXjNKPDi/lBUkISwQLnH86HGwIhGBxYwSX1urQYqY
        BVYzSUz6uAWqYwqTRFNvPwvIOjYBPYkdqwpBGngF3CT2PJ8Lto1FQFXiyuJ5jCC2qECExJn3
        K1ggagQlTs58AmZzCthLvFs9iRnEZhYwk5i3+SGULS5x68l8JghbXqJ562zmCYxCs5C0z0LS
        MgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERv62Yz8372C8tDH4EKMAB6MS
        D+8FtxMxQqyJZcWVuYcYJTiYlUR4PY4fjRHiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGBS
        yiuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwDjB0jv45ZoNskVM
        4Zffq7Avjn6k0M2V+05I/czNhNx6i5rJdh9+Pjt1W49hXs8V1x0zYq58Pr5Zu+GEGX8qYyan
        RMOJHQkz3azuCfzd/Hzatf2B95PlLQ2t9AX3atm0HA8x7FhzICpjhm59kIyOuvTCCYo67Tru
        edxln9atn77o3p6iv7fYOZRYijMSDbWYi4oTAYojQAQSAwAA
X-CMS-MailID: 20190430131249eucas1p1bf69401061f2403dc5826bb357e64d85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb@eucas1p2.samsung.com>
        <1555683568-20882-3-git-send-email-l.luba@partner.samsung.com>
        <68c3d065-ff8e-1ed5-204a-27bacebdbbb8@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 3:31 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I have no objection about this patch.
> Instead, as I commented on v4, in order to reduce the confusion
> about multiple clock definitions with same bit range of DIV_CDREX0,
> 
> You need to add the additional comment and you better to
> define the three clocks at the nearby in this driver.
> (CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1)
> If they are scattered, it is difficult for understanding
> why they are developed like this.
> 
> [1] [v4,2/8] clk: samsung: add new clocks for DMC for Exynos5422 SoC
> - https://lkml.org/lkml/2019/2/12/12
> 
OK, I will put these three clocks in one place (below 
CLK_DOUT_PCLK_CDREX definition and ad proper comment regarding
this HW assumption. I will also add these two new IDs
  #define CLK_DOUT_PCLK_CDREX    791
+#define CLK_DOUT_PCLK_DREX0    792
+#define CLK_DOUT_PCLK_DREX1    793
To the header file near the CLK_DOUT_PCLK_CDREX declaration.

After that they will be grouped and commented properly.

Thank you for the review.

Regards,
Lukasz

> Regards,
> Chanwoo Choi
> 
> 
> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c..d9e6653 100644
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
>> @@ -817,6 +827,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>   	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>   			DIV_CDREX0, 3, 5),
>>   
>> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
>> +
>>   	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>   			DIV_CDREX1, 8, 3),
>>   
>> @@ -1170,6 +1182,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
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
> 
