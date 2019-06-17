Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC5490D9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfFQUIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 16:08:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46380 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfFQUIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 16:08:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so11341367wrw.13
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T1m+0z6Mr16JXp5IdTNCH+l0GnmRVXEK8Vi7IMvSKA=;
        b=gAHp64460zowmxWhSL0jDRBIcdCAUdVmf3cg+a+KzUYWd2Qk+kphAFKkq+5Voiewlr
         3MR+iPk40Xf0duaV4KdZ+cQ/jCvQUEbu2lM/m4j4kT1KSGCJhwkwyLw/lR6jSgkLa0XB
         97Q4irwX4IaLJ8w3+9Z9uUmFM7Wms2oAG+EHuC6qaLtsR0r0P/erQBCu/gxtMvYyuuTY
         ZgyQkvI9gJvgb2+6M7o3/hk8x/JkGbJQ9O0vWnbbbcqBtCrU4DdVE0Q5OM0PS5wnc/9X
         TWslJXGUVuuW3lZN7/0HORn3HRiekMwWU1iEZIb7QXBrYI6zRNv7ARS52K/zNeiVb3Sx
         AozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T1m+0z6Mr16JXp5IdTNCH+l0GnmRVXEK8Vi7IMvSKA=;
        b=sNL0zfd8BTqeCIlGhjAOh1VMLMvi+qeiLGjZlt5cDyxmV/Tai/MWHa77imVObaZkTp
         80AMQpv26ykRVhQNKEeG/XrBLawppbR4FHjq6QR1jeBQ1qnkHAFSHzMxw2+E5QNw88Lq
         FCEx+tcWURUL5zfcG+vfdMAui01MiPmylgYUHOhNxkWvpWrxrwkP6oN/gU8KaEqXNxaJ
         RRulnom6a/QaoOVxJSsnWcTFbYROMP1Oq+FU9gFsvI8Vqq96U8f2Ru/M0kLOZe+zz7R6
         HgOWuEuwxVWUP9C+kvux9JeJc+4hZ5ygpICE4HsV/xWwBbC+sM/w7n5ks919UNluHR+Y
         4qMA==
X-Gm-Message-State: APjAAAUG5JA1cjRXfWi5b/wa50Xp/5hAACm8tqAIGEeKHkKqeePZbnyi
        HBdNKqw/6g8QYESYLwvIkJNDT+EQOYYSBc+vFaDg
X-Google-Smtp-Source: APXvYqzF3sU1Z7JopxkO0FNF4LQjZILnHC3GulPP4OxKIiMqMcdO2QHQE0OVywkNE3vVaEpFNHGwD5soYwiszkRlAp8=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr27702wre.294.1560802090685;
 Mon, 17 Jun 2019 13:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
 <20190521130357.20803-3-miquel.raynal@bootlin.com> <CAErSpo5i3y4CxZXV7E4tUR66uXaUa3B_-YT2+zfzZUGMmge7Ow@mail.gmail.com>
 <20190527154610.6d4d5eff@xps13> <CAErSpo7fimH5QhHTLsF2ASyPqstkw7Zibe3CYB=KXTYBOh-4GQ@mail.gmail.com>
 <20190617145004.7b11988f@xps13>
In-Reply-To: <20190617145004.7b11988f@xps13>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 17 Jun 2019 15:07:58 -0500
Message-ID: <CAErSpo5+eFn8suu1P6W4cQ0Gjjy3HD9_N53kx1nwW5TaHObWrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: mvebu: armada-37xx-periph: change
 suspend/resume time
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 17, 2019 at 7:50 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Bjorn,
>
> Bjorn Helgaas <bhelgaas@google.com> wrote on Tue, 4 Jun 2019 15:52:31
> -0500:
>
> > On Mon, May 27, 2019 at 8:46 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Bjorn,
> > >
> > > Thanks for the feedback.
> > >
> > > Bjorn Helgaas <bhelgaas@google.com> wrote on Tue, 21 May 2019 17:43:05
> > > -0500:
> > >
> > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Date: Tue, May 21, 2019 at 8:04 AM
> > > > To: Michael Turquette, Stephen Boyd, Rob Herring, Mark Rutland
> > > > Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>, Thomas
> > > > Petazzoni, Antoine Tenart, Gregory Clement, Maxime Chevallier, Nadav
> > > > Haklai, Bjorn Helgaas, Rafael J . Wysocki, <linux-pm@vger.kernel.org>,
> > > > Miquel Raynal
> > > >
> > > > > Armada 3700 PCIe IP relies on the PCIe clock managed by this
> > > > > driver. For reasons related to the PCI core's organization when
> > > > > suspending/resuming, PCI host controller drivers must reconfigure
> > > > > their register at suspend_noirq()/resume_noirq() which happens after
> > > > > suspend()/suspend_late() and before resume_early()/resume().
> > > >
> > > > "For reasons related to the PCI core's organization" manages to
> > > > suggest that this change wouldn't be needed if only the PCI core did
> > > > something differently, without actually being specific about what it
> > > > would need to do differently.
> > > >
> > > > Is there something the PCI core could do better to make this easier?
> > > > Or is it just something like "the PCI core needs to access registers
> > > > after suspend_late()"?  You mention the host controller, but of course
> > > > that's not itself a PCI device, so the PCI core doesn't have much to
> > > > do with it directly.
> > >
> > > Actually, if I understand correctly the below commit [1] and the core
> > > [2] & [3], PCI device fixups can happen at any time, including at the
> > > _noirq phase where, obviously, the PCI controller must be already
> > > setup.
> > >
> > > I don't think changing this behavior is a viable solution and I would
> > > not see it as a "PCI core could do better" alternative.
> > >
> > > ---8<---
> > >
> > > [1]
> > > commit ab14d45ea58eae67c739e4ba01871cae7b6c4586
> > > Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > Date:   Tue Mar 17 15:55:45 2015 +0100
> > >
> > >     PCI: mvebu: Add suspend/resume support
> > >
> > >     Add suspend/resume support for the mvebu PCIe host driver.  Without
> > >     this commit, the system will panic at resume time when PCIe devices
> > >     are connected.
> > >
> > >     Note that we have to use the ->suspend_noirq() and ->resume_noirq()
> > >     hooks, because at resume time, the PCI fixups are done at
> > >     ->resume_noirq() time, so the PCIe controller has to be ready at
> > >     this point.
> > >
> > >     Signed-off-by: Thomas Petazzoni
> > >     <thomas.petazzoni@free-electrons.com> Signed-off-by: Bjorn Helgaas
> > >     <bhelgaas@google.com> Acked-by: Jason Cooper <jason@lakedaemon.net>
> > >
> > > [2] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L1181
> > > [3] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L522
> > >
> > > --->8---
> > >
> > > >
> > > > s/register/registers/ ?
> > >
> > > Indeed. I would like to sort out the above technical point before
> > > sending a v3 with this typo corrected.
> >
> > I don't have anything more to contribute here; just wanted to make
> > sure this wasn't working around a fixable problem in PCI.
>
> Great! Would you mind adding a A-b/R-b tag then?

You're only touching drivers/clk, so you don't need my ack, and I
don't really feel qualified to add a reviewed-by.  Power management
and suspend/resume is still a mystery to me :)

Bjorn
