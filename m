Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458792B6D4
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfE0NqS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 27 May 2019 09:46:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35667 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfE0NqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 09:46:18 -0400
X-Originating-IP: 90.88.147.134
Received: from xps13 (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 00172FF80A;
        Mon, 27 May 2019 13:46:10 +0000 (UTC)
Date:   Mon, 27 May 2019 15:46:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
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
Subject: Re: [PATCH v2 2/4] clk: mvebu: armada-37xx-periph: change
 suspend/resume time
Message-ID: <20190527154610.6d4d5eff@xps13>
In-Reply-To: <CAErSpo5i3y4CxZXV7E4tUR66uXaUa3B_-YT2+zfzZUGMmge7Ow@mail.gmail.com>
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
        <20190521130357.20803-3-miquel.raynal@bootlin.com>
        <CAErSpo5i3y4CxZXV7E4tUR66uXaUa3B_-YT2+zfzZUGMmge7Ow@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

Thanks for the feedback.

Bjorn Helgaas <bhelgaas@google.com> wrote on Tue, 21 May 2019 17:43:05
-0500:

> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Date: Tue, May 21, 2019 at 8:04 AM
> To: Michael Turquette, Stephen Boyd, Rob Herring, Mark Rutland
> Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>, Thomas
> Petazzoni, Antoine Tenart, Gregory Clement, Maxime Chevallier, Nadav
> Haklai, Bjorn Helgaas, Rafael J . Wysocki, <linux-pm@vger.kernel.org>,
> Miquel Raynal
> 
> > Armada 3700 PCIe IP relies on the PCIe clock managed by this
> > driver. For reasons related to the PCI core's organization when
> > suspending/resuming, PCI host controller drivers must reconfigure
> > their register at suspend_noirq()/resume_noirq() which happens after
> > suspend()/suspend_late() and before resume_early()/resume().
> 
> "For reasons related to the PCI core's organization" manages to
> suggest that this change wouldn't be needed if only the PCI core did
> something differently, without actually being specific about what it
> would need to do differently.
> 
> Is there something the PCI core could do better to make this easier?
> Or is it just something like "the PCI core needs to access registers
> after suspend_late()"?  You mention the host controller, but of course
> that's not itself a PCI device, so the PCI core doesn't have much to
> do with it directly.

Actually, if I understand correctly the below commit [1] and the core
[2] & [3], PCI device fixups can happen at any time, including at the
_noirq phase where, obviously, the PCI controller must be already
setup.

I don't think changing this behavior is a viable solution and I would
not see it as a "PCI core could do better" alternative.

---8<---

[1]
commit ab14d45ea58eae67c739e4ba01871cae7b6c4586
Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date:   Tue Mar 17 15:55:45 2015 +0100

    PCI: mvebu: Add suspend/resume support

    Add suspend/resume support for the mvebu PCIe host driver.  Without
    this commit, the system will panic at resume time when PCIe devices
    are connected.

    Note that we have to use the ->suspend_noirq() and ->resume_noirq()
    hooks, because at resume time, the PCI fixups are done at
    ->resume_noirq() time, so the PCIe controller has to be ready at
    this point.

    Signed-off-by: Thomas Petazzoni
    <thomas.petazzoni@free-electrons.com> Signed-off-by: Bjorn Helgaas
    <bhelgaas@google.com> Acked-by: Jason Cooper <jason@lakedaemon.net>

[2] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L1181
[3] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L522

--->8---

> 
> s/register/registers/ ?

Indeed. I would like to sort out the above technical point before
sending a v3 with this typo corrected.


Thanks,
Miquèl
