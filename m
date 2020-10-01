Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF627FFC7
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgJANMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 09:12:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40438 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbgJANMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 09:12:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id c2so5292943otp.7;
        Thu, 01 Oct 2020 06:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CutUNi23FmgjlGaCB8GUt7zxXbSWDvhvD9+BHeBAnew=;
        b=Xb8j5MW9Apjj7r9oKfX/h66ib9iKQU+tIgC4uBWbW1/sG4n+nPNvplS8mXYrJ7yY3o
         YOEuSHhawlp6FLbKYSZCSe1hlsJSRDLeul2rkQfZQzkgSXnKsfcUcqk/ysLR9MM+6lmz
         WTWJpaiZVZaI/hmHa80pKoLAkdSf+lhc5RN/EyoeNh5ake7cxOx8ZBx620tTFPogYbm/
         t4UzstO6Bckz3z0ZuYSrwsSSql9U6zSp4aIGoJMzmzydvSrg4/ZWKR18z8oyva2p/aJ6
         sOOcj0HhkDCujn1niVxJiZVBrcX/8fN0a7A2/rLx6TFEm0Pujx6rYJU26h977Zekpx2f
         sDHA==
X-Gm-Message-State: AOAM533fDPwrHClitzykFWsn9m2Hixe1t1RN4cBWtO/X5+GmWihA06gL
        MF7X2XKRVM/3IFv+cUpQg6Js9PwYULVpEGxoa6w=
X-Google-Smtp-Source: ABdhPJynJdC8EJ9MWj44Vded5utR6vduohJBWaNwFNpNhY4rKdAIawjGrt5b+MKH2U5sHbc77NMa13RGnRZws4qSSFE=
X-Received: by 2002:a9d:5a92:: with SMTP id w18mr4737169oth.145.1601557919130;
 Thu, 01 Oct 2020 06:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200924055313.GC9471@atomide.com> <fe0a4fa8-53fc-d316-261f-52f631f12469@ti.com>
 <20200924060826.GE9471@atomide.com> <20200924133049.GH3968@pendragon.ideasonboard.com>
 <20200925115147.GM9471@atomide.com> <20200925115817.GB3933@pendragon.ideasonboard.com>
 <20200930052057.GP9471@atomide.com> <d8d81891-7e22-81a2-19df-6e9a5f8679c4@ti.com>
 <20201001075344.GU9471@atomide.com> <20201001081748.GW9471@atomide.com>
 <20201001082256.GA3722@pendragon.ideasonboard.com> <60ea4b42-fbc2-2b80-7eab-8a236581d4c9@ti.com>
In-Reply-To: <60ea4b42-fbc2-2b80-7eab-8a236581d4c9@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Oct 2020 15:11:48 +0200
Message-ID: <CAMuHMdUmX+i+FcScCT-_g20cBECU8J57zc0RpprT2sp+BpTprQ@mail.gmail.com>
Subject: Re: Slow booting on x15
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Grygorii et al,

On Thu, Oct 1, 2020 at 2:56 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 01/10/2020 11:22, Laurent Pinchart wrote:
> > On Thu, Oct 01, 2020 at 11:17:48AM +0300, Tony Lindgren wrote:
> >>>> -rc7 spends most of it's time:
> >>>> [    7.635530] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=POLL)
> >>>> [   14.956671] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> >>>> [   15.005211] IP-Config: Complete:

1. Is irq=POLL normal behavior for your board?
2. As this is a Micrel PHY, perhaps you are affected by the changes in
   the configuration defaults in commit bcf3440c6dd78bfe ("net: phy:
   micrel: add phy-mode support for the KSZ9031 PHY")?

See also the performance drop figures in the description of quick fix
9b23203c32ee02cd ("ravb: Mask PHY mode to avoid inserting delays twice")
(and better solution
 https://lore.kernel.org/linux-renesas-soc/20201001101008.14365-1-geert+renesas@glider.be)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
