Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40865572AF9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 03:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiGMBks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiGMBkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 21:40:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC91FCCC
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 18:40:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c8a1e9e33so98879527b3.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZ6q4ZoU0Ir2Jz6gl3O36uWJiXB5Oh91BCPws+bH2j8=;
        b=ji+wVu3QJM0EhDDfnd4KC9wcoUan+Y4cWT0Znkq7+Z2sCd7H2Mtlv/BU0ZX80Fo+Sl
         n4eUmPnHjmuxgCyGAZJMEk2JlYP3g70GQ2456nRDKRzrHMK6ar5r2qs6UUbeIZmuwEyK
         nwoo/EieD/MOWvL4dMjOFNdfvM6SlJ1T0LKwl0z9S4ZWP8LZFZAZTSXLmAU3LEuHla15
         ui1zjdNwntrt1omjmMv2BbEWB9N8hi5MSJ/y9b9ltlGcaJehwox9JKSmLwNsxR5XjDHn
         uTm3v+ral7SUpl85AD9hw413MEHq9ki2x7Hv1pXI3N6IXRcm40n1TubBkpT1GaMU/UVx
         qwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZ6q4ZoU0Ir2Jz6gl3O36uWJiXB5Oh91BCPws+bH2j8=;
        b=pRo69i1wm9vWcY4odWmZvb5IRgHFQV0NOkGBLdHQ3/BX/F/oiKQMSJOfYpsmL53AaI
         9Rg7oGuG8j1F1hiAUCw9wybw1unaZcfTyjQKfThSeKRYrcNviU0I5+gVth4pnPCrrNrg
         poUAVuMcM9YPkykXrzkQZWCP70NIUb59GCERcB3PsfX3VwI/w0ztGWl/jHfpiE90O8Wm
         NOcwr+itKatLcKiNAChAqAR397TPmhSO5RlBzlDTgw3UcyJoX/niZVTsN2ZiiEyoEAso
         1LEhRASxAVuGK00fsUEAKZEqPyxv4trV3RBKJPnb6lWcAz1ViZddR3DmiSdNULIQU4zu
         xRVA==
X-Gm-Message-State: AJIora8N9cAVA5p+gzUifPGgk7RwepAjQgZiOtyGs4zuISRwK2AL1wTO
        zqPmeoaLP5ZJmsQVJ3gwEcObLu3n18gsU9WyPze90g==
X-Google-Smtp-Source: AGRyM1vMvB5ytWB//zuy1WgkUbEH2A/pfANLOdqXAYxeYQCkgIpwtGZK6oswsKsqIzWkcI3ZmSNdp0rUWokDDKCmQSA=
X-Received: by 2002:a81:9e50:0:b0:31c:840e:33a8 with SMTP id
 n16-20020a819e50000000b0031c840e33a8mr1517792ywj.218.1657676444867; Tue, 12
 Jul 2022 18:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-4-saravanak@google.com> <CAMuHMdWo_wRwV-i_iyTxVnEsf3Th9GBAG+wxUQMQGnw1t2ijTg@mail.gmail.com>
In-Reply-To: <CAMuHMdWo_wRwV-i_iyTxVnEsf3Th9GBAG+wxUQMQGnw1t2ijTg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Jul 2022 18:40:08 -0700
Message-ID: <CAGETcx-jU5+Tc0Qkt1e4QY0YprYSp-4A+MoaSRjpdPp_8tZm5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] net: mdio: Delete usage of driver_deferred_probe_check_state()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 5, 2022 at 2:11 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Jun 1, 2022 at 2:44 PM Saravana Kannan <saravanak@google.com> wrote:
> > Now that fw_devlink=on by default and fw_devlink supports interrupt
> > properties, the execution will never get to the point where
> > driver_deferred_probe_check_state() is called before the supplier has
> > probed successfully or before deferred probe timeout has expired.
> >
> > So, delete the call and replace it with -ENODEV.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch, which is now commit f8217275b57aa48d ("net:
> mdio: Delete usage of driver_deferred_probe_check_state()") in
> driver-core/driver-core-next.
>
> Seems like I missed something when providing my T-b for this series,
> sorry for that.

No worries. Appreciate any testing help.

>
> arch/arm/boot/dts/r8a7791-koelsch.dts has:
>
>     &ether {
>             pinctrl-0 = <&ether_pins>, <&phy1_pins>;
>             pinctrl-names = "default";
>
>             phy-handle = <&phy1>;
>             renesas,ether-link-active-low;
>             status = "okay";
>
>             phy1: ethernet-phy@1 {
>                     compatible = "ethernet-phy-id0022.1537",
>                                  "ethernet-phy-ieee802.3-c22";
>                     reg = <1>;
>                     interrupt-parent = <&irqc0>;
>                     interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>                     micrel,led-mode = <1>;
>                     reset-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
>             };
>     };
>
> Despite the interrupts property, &ether is now probed before irqc0
> (interrupt-controller@e61c0000 in arch/arm/boot/dts/r8a7791.dtsi),
> causing the PHY not finding its interrupt, and resorting to polling:

I'd still expect the device link to have been created properly for
this phy device. Could you enable the logging in device_link_add() to
check the link is created between the phy and the IRQ?

My guess is that this probably has something to do with phys being
attached to drivers differently.

>
>     -Micrel KSZ8041RNLI ee700000.ethernet-ffffffff:01: attached PHY
> driver (mii_bus:phy_addr=ee700000.ethernet-ffffffff:01, irq=185)
>     +Micrel KSZ8041RNLI ee700000.ethernet-ffffffff:01: attached PHY
> driver (mii_bus:phy_addr=ee700000.ethernet-ffffffff:01, irq=POLL)

Can you drop a WARN() where this is printed to get the stack trace to
check my hypothesis?

-Saravana

>
> Reverting this commit, and commit 9cbffc7a59561be9 ("driver core:
> Delete driver_deferred_probe_check_state()") fixes that.
>
> > --- a/drivers/net/mdio/fwnode_mdio.c
> > +++ b/drivers/net/mdio/fwnode_mdio.c
> > @@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
> >          * just fall back to poll mode
> >          */
> >         if (rc == -EPROBE_DEFER)
> > -               rc = driver_deferred_probe_check_state(&phy->mdio.dev);
> > -       if (rc == -EPROBE_DEFER)
> > -               return rc;
> > +               rc = -ENODEV;
> >
> >         if (rc > 0) {
> >                 phy->irq = rc;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
