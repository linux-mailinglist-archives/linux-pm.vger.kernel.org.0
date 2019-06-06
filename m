Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084B036EBF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfFFIe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 04:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFIe3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 04:34:29 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89917208CB;
        Thu,  6 Jun 2019 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559810067;
        bh=EcbYfjSTzXWvDR617LT1wi89npTHFV8aCjNConeyuT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8U8I4iTbQmL82QiduasZTkkzU7lzXG6fQ8mCia6+fWcuiA0i03g1KxDVzaj1U6Gq
         lM5hTEaGIza5dyz0jw4Ss47I5FRbzg0JVE6bToOZ/yK/rlDUAFv3qjOtne21zIO5x0
         9J1jHGGoa/kDd4ba9o5TBXy8Q8tUsoRU7u5nvfSc=
Received: by mail-lf1-f45.google.com with SMTP id u10so146484lfm.12;
        Thu, 06 Jun 2019 01:34:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWqSWV03Z/DaKP5Gu2uC+CFsS2tC/lPoz681SaTyntlmJDZn4KV
        um1PVLAiFfhentF6D6FQJp6lOYkNOvgrkaIeQMU=
X-Google-Smtp-Source: APXvYqxCK50/XvWyFZNIDlxjsI9e+qKPGpstgWIbikf4y07C0N2yTXtYTSW0Xf0OiGYm6g5kM9c4YO3XXtTB7Q5yntc=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr22500135lfk.24.1559810065749;
 Thu, 06 Jun 2019 01:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61@eucas1p1.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-3-l.luba@partner.samsung.com>
In-Reply-To: <20190605165410.14606-3-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 10:34:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Message-ID: <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 57 ++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c5898f..eecbfcc6b3cf 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -134,6 +134,8 @@
>  #define SRC_CDREX              0x20200
>  #define DIV_CDREX0             0x20500
>  #define DIV_CDREX1             0x20504
> +#define GATE_BUS_CDREX0                0x20700
> +#define GATE_BUS_CDREX1                0x20704
>  #define KPLL_LOCK              0x28000
>  #define KPLL_CON0              0x28100
>  #define SRC_KFC                        0x28200
> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>         DIV_CDREX1,
>         SRC_KFC,
>         DIV_KFC0,
> +       GATE_BUS_CDREX0,
> +       GATE_BUS_CDREX1,
>  };
>
>  static const unsigned long exynos5800_clk_regs[] __initconst = {
> @@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)  = { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)     = { "dout_aclk550_cam", "dout_sclk_sw" };
>  PNAME(mout_group15_5800_p)     = { "dout_osc_div", "mout_sw_aclk550_cam" };
>  PNAME(mout_group16_5800_p)     = { "dout_osc_div", "mout_mau_epll_clk" };
> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
> +                                       "mout_sclk_mpll", "ff_dout_spll2",
> +                                       "mout_sclk_spll", "mout_sclk_epll"};
>
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>                 exynos5800_fixed_factor_clks[] __initconst = {
>         FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -       FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +       FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>  };
>
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
> @@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>         MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>         MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>
> +       MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +               mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +
>         MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>         MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>                         SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -       MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +       MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>         MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>
>         MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>
>         MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>         MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
> -       MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +       MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>         MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>         MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>         MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
> @@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>                         "mout_aclk400_disp1", DIV_TOP2, 4, 3),
>
>         /* CDREX Block */
> +       /*
> +        * The three clocks below are controlled using the same register and
> +        * bits. They are put into one because there is a need of
> +        * synchronization between the BUS and DREXs (two external memory
> +        * interfaces).
> +        * They are put here to show this HW assumption and for clock
> +        * information summary completeness.
> +        */
>         DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
>                         DIV_CDREX0, 28, 3),
> +       DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
> +                       DIV_CDREX0, 28, 3),
> +       DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
> +                       DIV_CDREX0, 28, 3),

Offline discussion with Marek and Sylwester suggested to add NOCACHE
for the two clocks using the same bits. Otherwise I am fine:

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
