Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A20B8C39
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437703AbfITIDH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 20 Sep 2019 04:03:07 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35105 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391092AbfITIDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 04:03:06 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AAA1A60008;
        Fri, 20 Sep 2019 08:03:02 +0000 (UTC)
Date:   Fri, 20 Sep 2019 10:03:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: [PATCH v3 0/4] Prepare Armada 3700 PCIe suspend to RAM support
Message-ID: <20190920100301.0674a5b6@xps13>
In-Reply-To: <20190917173154.722CB2171F@mail.kernel.org>
References: <20190627125245.26788-1-miquel.raynal@bootlin.com>
        <20190917173154.722CB2171F@mail.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Tue, 17 Sep 2019 10:31:53
-0700:

> Quoting Miquel Raynal (2019-06-27 05:52:41)
> > Hello,
> > 
> > As part of an effort to bring suspend to RAM support to the Armada
> > 3700 SoC (main target: ESPRESSObin board), there are small things to
> > do in the Armada 3700 peripherals clock driver:
> > 
> > * On this SoC, the PCIe controller gets fed by a gated clock in the
> >   south bridge. This clock is missing in the current driver, patch 1
> >   adds it.
> > 
> > * Because of a constraint in the PCI core, the resume function of a
> >   PCIe controller driver must be run at an early stage
> >   (->suspend/resume_noirq()), before the core tries to ->read/write()
> >   in the PCIe registers to do more configuration. Hence, the PCIe
> >   clock must be resumed before. This is enforced thanks to two
> >   changes:
> >   1/ Add device links to the clock framework. This enforce order in
> >      the PM core: the clocks are resumed before the consumers. Series
> >      has been posted, see [1].
> >   2/ Even with the above feature, the clock's resume() callback is
> >      called after the PCI controller's resume_noirq() callback. The
> >      only way to fix this is to change the "priority" of the clock
> >      suspend/resume callbacks. This is done in patch 2.
> > 
> > * The bindings are updated with the PCI clock in patch 4 while patch 3
> >   is just a typo correction in the same file.
> > 
> > If there is anything unclear please feel free to ask.
> >   
> 
> Should I drop this patch series?
> 

No, if it is right for you I would really prefer to have it merged
(sorry for the delay in answering though) because it will be still
needed, no matter how clock dependencies are handled.


Thanks,
Miquèl
