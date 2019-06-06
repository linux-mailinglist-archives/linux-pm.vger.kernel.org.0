Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA936F99
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfFFJMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 05:12:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53384 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfFFJMv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 05:12:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190606091249euoutp01c31a5ccd90b8eeedf3aa658f29efb6b6~lkRX0RIrJ1005310053euoutp01T
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 09:12:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190606091249euoutp01c31a5ccd90b8eeedf3aa658f29efb6b6~lkRX0RIrJ1005310053euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559812369;
        bh=HEmcpuFKrlX42jr9EnXs0W9md6lip+SgUuLTGKhZXdc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b38IMxoc6oesinkXIzvl8axJ/2s8nW1USAGa7zWpCYEorDmQhpBrHIOZnBriC1zn5
         ujI+BdNQqUUNrle9LbNYs5hzurBKo1zgHOAGjxxSpBtxxXB1aj1tPaJ5ceYp2B2+yz
         r3M2HgGhja88A8cj2c0Tvia26e1P54voIbJAWwF8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190606091248eucas1p19558471c8054bc64a08b57235446f2e2~lkRXCquU70849908499eucas1p1J;
        Thu,  6 Jun 2019 09:12:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.BF.04377.019D8FC5; Thu,  6
        Jun 2019 10:12:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190606091247eucas1p26f3eb1e36a2158b0eaec65c1458f1538~lkRWL-KGY1607916079eucas1p2r;
        Thu,  6 Jun 2019 09:12:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606091247eusmtrp1f4bcfd88a368d5e5c77e3289a54a24a0~lkRV57HtK2813428134eusmtrp1F;
        Thu,  6 Jun 2019 09:12:47 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-a3-5cf8d910f6c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.BB.04140.F09D8FC5; Thu,  6
        Jun 2019 10:12:47 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190606091246eusmtip107aceb603f30cfc18a800939f2e27bc2~lkRU8mCLe0434904349eusmtip1G;
        Thu,  6 Jun 2019 09:12:46 +0000 (GMT)
Subject: Re: [PATCH v8 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <d0bbb864-5803-fe5e-0673-f05654d31099@partner.samsung.com>
Date:   Thu, 6 Jun 2019 11:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djP87oCN3/EGFzdKGSxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwRHHZpKTmZJalFunbJXBlzDjRxlrQZ1Ax7e4dlgbGrSpdjJwc
        EgImEo1HNrJ1MXJxCAmsYJRYsLyJFcL5wigxc95nqMxnRontD7cyw7TMWvGeBcQWEljOKPGz
        yxyi6C2jxPqeWWAJYYFwiRP9bYwgtoiApsT1v9/BxjILbGSR2L5jF3sXIwcHm4CexI5VhSAm
        r4CbxJotYSDlLAIqEhc+7mUFsUUFIiTuH9sAZvMKCEqcnPkEbDynQKDEweMfwO5hFhCXuPVk
        PhOELS+x/e0cZpBVEgJTOSS23dnHAnG0i8S65qfsELawxKvjW6BsGYnTk3ugaoolGnoXMkLY
        NRKP++dC1VhLHD5+kRXkTmagX9bv0ocIO0qsudjICBKWEOCTuPFWEOIEPolJ26YzQ4R5JTra
        hCCqNSS29FxggrDFJJavmcY+gVFpFpLHZiF5ZhaSZ2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84
        Mbe4NC9dLzk/dxMjMAWe/nf8yw7GXX+SDjEKcDAq8fBKbPweI8SaWFZcmXuIUYKDWUmEt+zC
        jxgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjCrf6oKK
        X8n4+nNNnB57+tOrupRV6a0qZSHXam39I1e8mhVyKCXJfvX+/zM+c792i3pafZzz9klDtgV2
        aQciPsQdOcyw84DyRKUsp6IJ8tFCvNrqr1oFt9VsvKSZ1KbeNPPA7zih9w1zo5Y5Xfvw4FeC
        TOj3t6FhRQHiuff4s17wt4ucY1aUVWIpzkg01GIuKk4EACcfxUh9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7r8N3/EGFxrEbTYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyZpxoYy3oM6iYdvcOSwPjVpUuRk4OCQETiVkr3rN0MXJxCAksZZR4
        tfU1M0RCTGLSvu3sELawxJ9rXWwQRa8ZJdZf/QCWEBYIlzjR38YIYosIaEpc//udFaSIWWAj
        i8TFV71MEB0TmCTaZlwFGsvBwSagJ7FjVSGIySvgJrFmSxhIL4uAisSFj3tZQWxRgQiJM+9X
        sIDYvAKCEidnPgGzOQUCJQ4e/wB2HLOAmcS8zQ+hbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywk
        LbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYORvO/Zzyw7GrnfBhxgFOBiV
        eHglNn6PEWJNLCuuzD3EKMHBrCTCW3bhR4wQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wOT
        Ul5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaq7brOl4LuCS/i
        cNfO2vHkXUHBy+ryjr1Vcx65ubvOZT1zsZ7hgmvAJQv7eTWyNxZ3T1m+WvNziyWbiN5779Uv
        901iWGrFfrdC49vkpaXl1UD//2Y8sNP6Z9OhyB0REo/PVC4qaBR3vzBjsVjN8q1cPww7/X+c
        exmqExzgLxh0I2HvV/caJSWW4oxEQy3mouJEAC2Pp7ESAwAA
X-CMS-MailID: 20190606091247eucas1p26f3eb1e36a2158b0eaec65c1458f1538
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
References: <CGME20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61@eucas1p1.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
        <20190605165410.14606-3-l.luba@partner.samsung.com>
        <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/6/19 10:34 AM, Krzysztof Kozlowski wrote:
> On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 57 ++++++++++++++++++++++++++--
>>   1 file changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c5898f..eecbfcc6b3cf 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -134,6 +134,8 @@
>>   #define SRC_CDREX              0x20200
>>   #define DIV_CDREX0             0x20500
>>   #define DIV_CDREX1             0x20504
>> +#define GATE_BUS_CDREX0                0x20700
>> +#define GATE_BUS_CDREX1                0x20704
>>   #define KPLL_LOCK              0x28000
>>   #define KPLL_CON0              0x28100
>>   #define SRC_KFC                        0x28200
>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>          DIV_CDREX1,
>>          SRC_KFC,
>>          DIV_KFC0,
>> +       GATE_BUS_CDREX0,
>> +       GATE_BUS_CDREX1,
>>   };
>>
>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>> @@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)  = { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>   PNAME(mout_group14_5800_p)     = { "dout_aclk550_cam", "dout_sclk_sw" };
>>   PNAME(mout_group15_5800_p)     = { "dout_osc_div", "mout_sw_aclk550_cam" };
>>   PNAME(mout_group16_5800_p)     = { "dout_osc_div", "mout_mau_epll_clk" };
>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>> +                                       "mout_sclk_mpll", "ff_dout_spll2",
>> +                                       "mout_sclk_spll", "mout_sclk_epll"};
>>
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock
>> @@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
>>   static const struct samsung_fixed_factor_clock
>>                  exynos5800_fixed_factor_clks[] __initconst = {
>>          FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>> -       FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>> +       FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>   };
>>
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>> @@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>          MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>          MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>
>> +       MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>> +               mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>> +
>>          MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>> -                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>> +                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>          MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>                          SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>> -       MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>> +       MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>          MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>
>>          MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>> @@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>
>>          MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>          MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>> -       MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>> +       MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>          MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>          MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>          MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>> @@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>                          "mout_aclk400_disp1", DIV_TOP2, 4, 3),
>>
>>          /* CDREX Block */
>> +       /*
>> +        * The three clocks below are controlled using the same register and
>> +        * bits. They are put into one because there is a need of
>> +        * synchronization between the BUS and DREXs (two external memory
>> +        * interfaces).
>> +        * They are put here to show this HW assumption and for clock
>> +        * information summary completeness.
>> +        */
>>          DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
>>                          DIV_CDREX0, 28, 3),
>> +       DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
>> +                       DIV_CDREX0, 28, 3),
>> +       DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
>> +                       DIV_CDREX0, 28, 3),
> 
> Offline discussion with Marek and Sylwester suggested to add NOCACHE
> for the two clocks using the same bits. Otherwise I am fine:
Indeed, I have changed it and run some tests of these three clocks with:
-----------8<-------------------------
DIV_F(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
	DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
DIV_F(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
	DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
DIV_F(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
	DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
--------------->8---------------------
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Thank you for the review and ACK.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
