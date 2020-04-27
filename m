Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343611BA0EA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgD0KTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:19:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34060 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0KTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:19:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id 72so25259249otu.1;
        Mon, 27 Apr 2020 03:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/ranIBWOXV+r1vGh7d3Ut57KQGbxJBp56NZiYevesc=;
        b=J3bylwHgFwo5MEvFz/1dKzmEUZTP07UXKhcTgSXKhME8nMSWxGy2AC86NLjhPB2VIp
         VIXetvjjjVt20QfDtqfqJX+gP6qeJwn0bkJwYKfDkw3AA9dLg0j0uFZq/nsJzMes56BM
         gw4A+tLUWh/9NyBykLREPj4iQtbyw6jxXRk1F45hPzwm7+LPHplWSjaE66rdl8VhEhho
         +/ixYC6MbBl7bQi85+XYJndKiFSp7cWGLgEk1VuRnNoeqYNUYsgowv/ECmI/ZuIXOJ2M
         gor9FI1uWYw/ahJ9aDgZbBSM0+WzrfEQfrrxCG5ih9e03uPPJ+IHO2jlaDOGnvDD0PeT
         n2BA==
X-Gm-Message-State: AGi0PuajwKmelOpMSMIvwvk4DOyoPP4LcS/e7xklaWdFVOzrXr9p4jRF
        Q3uLn6j46oTxgiyUny/iBD2dC8EJ5m4YGr+khiE=
X-Google-Smtp-Source: APiQypLL/90KXHP4+lnbdlxks4rEa4T5zKfZNHUlLZcWix+pIRFzwlLNsl3kVuOJ8sLeCNhHBWF42/Nz02oQnLqOfXY=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr15376635oig.54.1587982741263;
 Mon, 27 Apr 2020 03:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUmj+m8WLaSfwELD0VGYFpDaACTLgerbznBeqfVVy2nzw@mail.gmail.com> <CA+V-a8s6RacEpZ+Z5M8ftKq9NGsVgizdBY137YiYuK_yg-Ozxg@mail.gmail.com>
In-Reply-To: <CA+V-a8s6RacEpZ+Z5M8ftKq9NGsVgizdBY137YiYuK_yg-Ozxg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 12:18:50 +0200
Message-ID: <CAMuHMdVrft9Ln=DSKv2hrVcZBuOo9fvbvD_s0JDo0xUQAoG=tQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] clk: renesas: cpg-mssr: Add R8A7742 support
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
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
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

On Mon, Apr 27, 2020 at 12:07 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:10 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add RZ/G1H (R8A7742) Clock Pulse Generator / Module Standby and Software
> > > Reset support, using the CPG/MSSR driver core and the common R-Car Gen2
> > > (and RZ/G) code.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/drivers/clk/renesas/r8a7742-cpg-mssr.c
> >
> > > +static struct cpg_core_clk r8a7742_core_clks[] __initdata = {

> > > +       DEF_FIXED("zg",    R8A7742_CLK_ZG,      CLK_PLL1,           3, 1),

> > > +static int __init r8a7742_cpg_mssr_init(struct device *dev)
> > > +{
> > > +       const struct rcar_gen2_cpg_pll_config *cpg_pll_config;
> > > +       struct device_node *np = dev->of_node;
> > > +       unsigned int i;
> > > +       u32 cpg_mode;
> > > +       int error;
> > > +
> > > +       error = rcar_rst_read_mode_pins(&cpg_mode);
> > > +       if (error)
> > > +               return error;
> > > +
> > > +       cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
> > > +
> > > +       if (of_device_is_compatible(np, "renesas,r8a7742-cpg-mssr")) {
> > > +               /* RZ/G1H uses a 1/3 divider for ZG */
> > > +               for (i = 0; i < ARRAY_SIZE(r8a7742_core_clks); i++)
> > > +                       if (r8a7742_core_clks[i].id == R8A7742_CLK_ZG) {
> > > +                               r8a7742_core_clks[i].div = 3;
> > > +                               break;
> > > +                       }
> > > +       }
> >
> > Do you really need this part? (copied from r8a7743-cpg-mssr.c ;-)
> > If you remove it, r8a7742_core_clks[] can be const, and <linux/of.h> is
> > no longer needed,
> >
> I haven't come far enough to test the GPU yet, so Ill drop this for
> now and add this later if needed.

The divider is already set to 3 in the table above.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
