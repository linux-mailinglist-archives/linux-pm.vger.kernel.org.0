Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121ABB9608
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405438AbfITQyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 12:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405360AbfITQyC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 12:54:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5DB207FC;
        Fri, 20 Sep 2019 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568998442;
        bh=sLOES0dJNNhN/FCJjlLywq5/50hm54xCZ0l0xpS2B5w=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=cyXCU3VghdUV0JG6NWEgRtcEAqgrtLyVbvntG/u8Qkrni50iNAw3mlEsuRAygnpMf
         qSNge/z+pOIZFkga6St28xLlcKVkklBXJfIBb0vwLF4rlyZxpi7gtRzdD0cH0p+80J
         hy7EzuyppwYRx5klrV5IYJvj89lLRR0PV5OulyFQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190920100301.0674a5b6@xps13>
References: <20190627125245.26788-1-miquel.raynal@bootlin.com> <20190917173154.722CB2171F@mail.kernel.org> <20190920100301.0674a5b6@xps13>
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
        <marek.behun@nic.cz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/4] Prepare Armada 3700 PCIe suspend to RAM support
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 09:54:01 -0700
Message-Id: <20190920165402.4B5DB207FC@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Miquel Raynal (2019-09-20 01:03:01)
> Hi Stephen,
>=20
> Stephen Boyd <sboyd@kernel.org> wrote on Tue, 17 Sep 2019 10:31:53
> -0700:
>=20
> > Quoting Miquel Raynal (2019-06-27 05:52:41)
> > > Hello,
> > >=20
> > > As part of an effort to bring suspend to RAM support to the Armada
> > > 3700 SoC (main target: ESPRESSObin board), there are small things to
> > > do in the Armada 3700 peripherals clock driver:
> > >=20
> > > * On this SoC, the PCIe controller gets fed by a gated clock in the
> > >   south bridge. This clock is missing in the current driver, patch 1
> > >   adds it.
> > >=20
> > > * Because of a constraint in the PCI core, the resume function of a
> > >   PCIe controller driver must be run at an early stage
> > >   (->suspend/resume_noirq()), before the core tries to ->read/write()
> > >   in the PCIe registers to do more configuration. Hence, the PCIe
> > >   clock must be resumed before. This is enforced thanks to two
> > >   changes:
> > >   1/ Add device links to the clock framework. This enforce order in
> > >      the PM core: the clocks are resumed before the consumers. Series
> > >      has been posted, see [1].
> > >   2/ Even with the above feature, the clock's resume() callback is
> > >      called after the PCI controller's resume_noirq() callback. The
> > >      only way to fix this is to change the "priority" of the clock
> > >      suspend/resume callbacks. This is done in patch 2.
> > >=20
> > > * The bindings are updated with the PCI clock in patch 4 while patch 3
> > >   is just a typo correction in the same file.
> > >=20
> > > If there is anything unclear please feel free to ask.
> > >  =20
> >=20
> > Should I drop this patch series?
> >=20
>=20
> No, if it is right for you I would really prefer to have it merged
> (sorry for the delay in answering though) because it will be still
> needed, no matter how clock dependencies are handled.
>=20
>=20

Ok. I'll apply it after the merge window. Let me know if it's more
urgent than that.

