Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0381B9F69
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0JKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:10:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45141 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0JKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:10:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so24946276otk.12;
        Mon, 27 Apr 2020 02:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcNlgT253Q+mnyb0dmPBeKwZupVLUVCEsXLGGQlN7mU=;
        b=l4XhQPhefh0GTIyDpEVrTyYasipwFtBtPxRNNze6HMFvhzgKUILtr5x4Pxt6g9S7xk
         nrlESZJxyPUREGTzDaQLIEla2kvKIHDxvCC0uK2D4Nd0MivcNkRSu0xpinahms6i0VPy
         Eqz0WfhsFoIF7hOedkK2esFVThhk6teUvbc99jmoMiILkZq3hqPVUely6hk+tFlBVsnz
         AP48sMs2gRryUU7c3+XvO5qdKBp0mRta1ZqKtQ5qTgveYbItxF38XyfEO5xcnapDhmV5
         1xBZlaI6IwhdllM/XAjkefXIbiq3yy0QclKQTPiwGEbdOEI5s+M/+QdtF9tsbEdxSdIJ
         5SZw==
X-Gm-Message-State: AGi0PuY6kedkysaYurdLYTDWR4JUxVVrmkKZPbf1M2fj5FSnUO/Ug7aP
        jxyt6a26K8Pd6DOjjb87YcTuH+i7TYMQrY0Pyqc=
X-Google-Smtp-Source: APiQypKw19uX7pNh+s25tQlcVi6u/qoBo4l+PDXl+dtgYprl6i34GYCNk/rsJvOcHawKKsX52BSbZ5FC/bbkN04OYi4=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr11539338otm.145.1587978640642;
 Mon, 27 Apr 2020 02:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 11:10:29 +0200
Message-ID: <CAMuHMdUmj+m8WLaSfwELD0VGYFpDaACTLgerbznBeqfVVy2nzw@mail.gmail.com>
Subject: Re: [PATCH 08/10] clk: renesas: cpg-mssr: Add R8A7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add RZ/G1H (R8A7742) Clock Pulse Generator / Module Standby and Software
> Reset support, using the CPG/MSSR driver core and the common R-Car Gen2
> (and RZ/G) code.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/renesas/r8a7742-cpg-mssr.c

> +static struct cpg_core_clk r8a7742_core_clks[] __initdata = {
> +       /* External Clock Inputs */
> +       DEF_INPUT("extal",      CLK_EXTAL),
> +       DEF_INPUT("usb_extal",  CLK_USB_EXTAL),
> +
> +       /* Internal Core Clocks */
> +       DEF_BASE(".main",       CLK_MAIN, CLK_TYPE_GEN2_MAIN, CLK_EXTAL),
> +       DEF_BASE(".pll0",       CLK_PLL0, CLK_TYPE_GEN2_PLL0, CLK_MAIN),
> +       DEF_BASE(".pll1",       CLK_PLL1, CLK_TYPE_GEN2_PLL1, CLK_MAIN),
> +       DEF_BASE(".pll3",       CLK_PLL3, CLK_TYPE_GEN2_PLL3, CLK_MAIN),
> +
> +       DEF_FIXED(".pll1_div2", CLK_PLL1_DIV2, CLK_PLL1, 2, 1),
> +
> +       /* Core Clock Outputs */
> +       DEF_BASE("z",    R8A7742_CLK_Z,    CLK_TYPE_GEN2_Z,     CLK_PLL0),
> +       DEF_BASE("sdh",  R8A7742_CLK_SDH,  CLK_TYPE_GEN2_SDH,   CLK_PLL1),
> +       DEF_BASE("sd0",  R8A7742_CLK_SD0,  CLK_TYPE_GEN2_SD0,   CLK_PLL1),
> +       DEF_BASE("sd1",  R8A7742_CLK_SD1,  CLK_TYPE_GEN2_SD1,   CLK_PLL1),
> +       DEF_BASE("qspi", R8A7742_CLK_QSPI, CLK_TYPE_GEN2_QSPI,  CLK_PLL1_DIV2),
> +       DEF_BASE("rcan", R8A7742_CLK_RCAN, CLK_TYPE_GEN2_RCAN,  CLK_USB_EXTAL),
> +
> +       DEF_FIXED("z2",    R8A7742_CLK_Z2,      CLK_PLL1,           2, 1),
> +       DEF_FIXED("zg",    R8A7742_CLK_ZG,      CLK_PLL1,           3, 1),
> +       DEF_FIXED("zt",    R8A7742_CLK_ZT,      CLK_PLL1,           5, 1),
> +       DEF_FIXED("ztr",   R8A7742_CLK_ZTR,     CLK_PLL1,           4, 1),
> +       DEF_FIXED("ztrd2", R8A7742_CLK_ZTRD2,   CLK_PLL1,           12, 1),

The ZT* clocks are not fixed-factor clocks, but use programmable
dividers in FRQCRB.
So either you implement them correctly, or you drop them, like we did
for the other R-Car Gen2 and RZ/G1 SoCs (there are no users yet).

> +       DEF_FIXED("zx",    R8A7742_CLK_ZX,      CLK_PLL1,           3, 1),
> +       DEF_FIXED("zs",    R8A7742_CLK_ZS,      CLK_PLL1,           6, 1),
> +       DEF_FIXED("hp",    R8A7742_CLK_HP,      CLK_PLL1,          12, 1),
> +       DEF_FIXED("b",     R8A7742_CLK_B,       CLK_PLL1,          12, 1),
> +       DEF_FIXED("lb",    R8A7742_CLK_LB,      CLK_PLL1,          24, 1),

Please use CLK_TYPE_GEN2_LB, as the LB divider depends on the state of
mode pin MD18.

> +       DEF_FIXED("p",     R8A7742_CLK_P,       CLK_PLL1,          24, 1),
> +       DEF_FIXED("cl",    R8A7742_CLK_CL,      CLK_PLL1,          48, 1),
> +       DEF_FIXED("m2",    R8A7742_CLK_M2,      CLK_PLL1,           8, 1),
> +       DEF_FIXED("zb3",   R8A7742_CLK_ZB3,     CLK_PLL3,           4, 1),
> +       DEF_FIXED("zb3d2", R8A7742_CLK_ZB3D2,   CLK_PLL3,           8, 1),
> +       DEF_FIXED("ddr",   R8A7742_CLK_DDR,     CLK_PLL3,           8, 1),
> +       DEF_FIXED("mp",    R8A7742_CLK_MP,      CLK_PLL1_DIV2,     15, 1),
> +       DEF_FIXED("cp",    R8A7742_CLK_CP,      CLK_EXTAL,          2, 1),
> +       DEF_FIXED("r",     R8A7742_CLK_R,       CLK_PLL1,       49152, 1),
> +       DEF_FIXED("osc",   R8A7742_CLK_OSC,     CLK_PLL1,       12288, 1),
> +
> +       DEF_DIV6P1("sd2",  R8A7742_CLK_SD2,     CLK_PLL1_DIV2,  0x078),
> +       DEF_DIV6P1("sd3",  R8A7742_CLK_SD3,     CLK_PLL1_DIV2,  0x26c),
> +       DEF_DIV6P1("mmc0", R8A7742_CLK_MMC0,    CLK_PLL1_DIV2,  0x240),
> +       DEF_DIV6P1("mmc1", R8A7742_CLK_MMC1,    CLK_PLL1_DIV2,  0x244),
> +};
> +
> +static const struct mssr_mod_clk r8a7742_mod_clks[] __initconst = {
> +       DEF_MOD("msiof0",                  0,   R8A7742_CLK_MP),
> +       DEF_MOD("vcp1",                  100,   R8A7742_CLK_ZS),
> +       DEF_MOD("vcp0",                  101,   R8A7742_CLK_ZS),
> +       DEF_MOD("vpc1",                  102,   R8A7742_CLK_ZS),
> +       DEF_MOD("vpc0",                  103,   R8A7742_CLK_ZS),
> +       DEF_MOD("tmu1",                  111,   R8A7742_CLK_P),
> +       DEF_MOD("3dg",                   112,   R8A7742_CLK_ZG),
> +       DEF_MOD("2d-dmac",               115,   R8A7742_CLK_ZS),
> +       DEF_MOD("fdp1-2",                117,   R8A7742_CLK_ZS),
> +       DEF_MOD("fdp1-1",                118,   R8A7742_CLK_ZS),
> +       DEF_MOD("fdp1-0",                119,   R8A7742_CLK_ZS),
> +       DEF_MOD("tmu3",                  121,   R8A7742_CLK_P),
> +       DEF_MOD("tmu2",                  122,   R8A7742_CLK_P),
> +       DEF_MOD("cmt0",                  124,   R8A7742_CLK_R),
> +       DEF_MOD("tmu0",                  125,   R8A7742_CLK_CP),
> +       DEF_MOD("vsp1du1",               127,   R8A7742_CLK_ZS),
> +       DEF_MOD("vsp1du0",               128,   R8A7742_CLK_ZS),
> +       DEF_MOD("vsp1-sy",               131,   R8A7742_CLK_ZS),
> +       DEF_MOD("scifa2",                202,   R8A7742_CLK_MP),
> +       DEF_MOD("scifa1",                203,   R8A7742_CLK_MP),
> +       DEF_MOD("scifa0",                204,   R8A7742_CLK_MP),
> +       DEF_MOD("msiof2",                205,   R8A7742_CLK_MP),
> +       DEF_MOD("scifb0",                206,   R8A7742_CLK_MP),
> +       DEF_MOD("scifb1",                207,   R8A7742_CLK_MP),
> +       DEF_MOD("msiof1",                208,   R8A7742_CLK_MP),
> +       DEF_MOD("msiof3",                215,   R8A7742_CLK_MP),
> +       DEF_MOD("scifb2",                216,   R8A7742_CLK_MP),
> +       DEF_MOD("sys-dmac1",             218,   R8A7742_CLK_ZS),
> +       DEF_MOD("sys-dmac0",             219,   R8A7742_CLK_ZS),
> +       DEF_MOD("iic2",                  300,   R8A7742_CLK_CP),

Parent should be R8A7742_CLK_HP.

> +       DEF_MOD("tpu0",                  304,   R8A7742_CLK_CP),
> +       DEF_MOD("mmcif1",                305,   R8A7742_CLK_MMC1),
> +       DEF_MOD("scif2",                 310,   R8A7742_CLK_CP),

Parent should be R8A7742_CLK_P.

> +       DEF_MOD("sdhi3",                 311,   R8A7742_CLK_SD3),
> +       DEF_MOD("sdhi2",                 312,   R8A7742_CLK_SD2),
> +       DEF_MOD("sdhi1",                 313,   R8A7742_CLK_SD2),

Parent should be R8A7742_CLK_SD1.

> +static int __init r8a7742_cpg_mssr_init(struct device *dev)
> +{
> +       const struct rcar_gen2_cpg_pll_config *cpg_pll_config;
> +       struct device_node *np = dev->of_node;
> +       unsigned int i;
> +       u32 cpg_mode;
> +       int error;
> +
> +       error = rcar_rst_read_mode_pins(&cpg_mode);
> +       if (error)
> +               return error;
> +
> +       cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
> +
> +       if (of_device_is_compatible(np, "renesas,r8a7742-cpg-mssr")) {
> +               /* RZ/G1H uses a 1/3 divider for ZG */
> +               for (i = 0; i < ARRAY_SIZE(r8a7742_core_clks); i++)
> +                       if (r8a7742_core_clks[i].id == R8A7742_CLK_ZG) {
> +                               r8a7742_core_clks[i].div = 3;
> +                               break;
> +                       }
> +       }

Do you really need this part? (copied from r8a7743-cpg-mssr.c ;-)
If you remove it, r8a7742_core_clks[] can be const, and <linux/of.h> is
no longer needed,

> +       return rcar_gen2_cpg_init(cpg_pll_config, 2, cpg_mode);
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
