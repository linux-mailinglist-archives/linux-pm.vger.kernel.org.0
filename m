Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CA3515B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDUwp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 16:52:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33342 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfFDUwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 16:52:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so291854wmh.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2019 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCHz30SDnTrnAv/weztZxXoYbAkSe2tsArruuDkoSAw=;
        b=o95o2AtV3WDFGyw1md9OSwObrbp+2ZQKkNV6T0JhyFOOnZVCIONv7VMW3w2kRXmQrQ
         Y1XC3qGKWVyhoR62ffMrKm80dj/uSTijSjWiIKa2mgSf1SrkeWTQYQIEXlCbeNcEWXKs
         /k6m/rK93raHxP9W3lCee8kaKnDUlcuiWqj4+k6wG5YIJf35urPMB8GdwN28fg/SbR/v
         DBTed768GKWrqbXE6cXIDf1ewEDRHu1nGJApaegknzDYL+UCwG7ptPm9hcLqH6pVAv0S
         6C+1hT46h0GbPwjAqjv2gdjKRDBr5T94Wuz9u0HODtT0xlH00B0ZjRsXI7zY7MS2v7KU
         4Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCHz30SDnTrnAv/weztZxXoYbAkSe2tsArruuDkoSAw=;
        b=hZHThkCSFb+01iruL/r2FIIg/4n7lr7nuQQ4NFuP2NLn44g8aqMslsro9+M3i4WaKo
         ZU7e8aVk2MmoqiI5Nkf3AqARPyMEwCOMKPGpDqTxkzPgmjhKvuBB1Es82drhLOh+JtYP
         BpEhp5FmVIud3AZ9ANdhrcCMehD2uOMNnFmBVEpDLHXKdAfVqNIyz7qlhQmp/nlXTYvb
         AFn4/yv7pyEFhH4QyNScevYjSkmkge7+qm7k9Uwl76zh92t1ROvxVc+KVs1uh9m6vYia
         5RZGZbM3YbYzxLrNmtOdWG36hS9J8w/yobLnSaVItCMd9AvAbc5kzB/14RN/ZUd7zm+K
         hxtA==
X-Gm-Message-State: APjAAAX3zLeGy4dtQoVNj2EMdZD+HndGZCxV240HL8XpBfLXY1HC7Cl0
        AoWAlp4RiNOdBX4r5Tz72hyY/WWjMQ48THwNlz/F
X-Google-Smtp-Source: APXvYqxnV0SOZU/4nmV4NDSQJrqHsnlSq+yDN6cgoSvSwJwPyNnfdu2T/8ZwVNxho0MnA27Ys385vKc1uhUJ75TsjKc=
X-Received: by 2002:a1c:f507:: with SMTP id t7mr19658456wmh.149.1559681563071;
 Tue, 04 Jun 2019 13:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
 <20190521130357.20803-3-miquel.raynal@bootlin.com> <CAErSpo5i3y4CxZXV7E4tUR66uXaUa3B_-YT2+zfzZUGMmge7Ow@mail.gmail.com>
 <20190527154610.6d4d5eff@xps13>
In-Reply-To: <20190527154610.6d4d5eff@xps13>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 4 Jun 2019 15:52:31 -0500
Message-ID: <CAErSpo7fimH5QhHTLsF2ASyPqstkw7Zibe3CYB=KXTYBOh-4GQ@mail.gmail.com>
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

On Mon, May 27, 2019 at 8:46 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Bjorn,
>
> Thanks for the feedback.
>
> Bjorn Helgaas <bhelgaas@google.com> wrote on Tue, 21 May 2019 17:43:05
> -0500:
>
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Date: Tue, May 21, 2019 at 8:04 AM
> > To: Michael Turquette, Stephen Boyd, Rob Herring, Mark Rutland
> > Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>, Thomas
> > Petazzoni, Antoine Tenart, Gregory Clement, Maxime Chevallier, Nadav
> > Haklai, Bjorn Helgaas, Rafael J . Wysocki, <linux-pm@vger.kernel.org>,
> > Miquel Raynal
> >
> > > Armada 3700 PCIe IP relies on the PCIe clock managed by this
> > > driver. For reasons related to the PCI core's organization when
> > > suspending/resuming, PCI host controller drivers must reconfigure
> > > their register at suspend_noirq()/resume_noirq() which happens after
> > > suspend()/suspend_late() and before resume_early()/resume().
> >
> > "For reasons related to the PCI core's organization" manages to
> > suggest that this change wouldn't be needed if only the PCI core did
> > something differently, without actually being specific about what it
> > would need to do differently.
> >
> > Is there something the PCI core could do better to make this easier?
> > Or is it just something like "the PCI core needs to access registers
> > after suspend_late()"?  You mention the host controller, but of course
> > that's not itself a PCI device, so the PCI core doesn't have much to
> > do with it directly.
>
> Actually, if I understand correctly the below commit [1] and the core
> [2] & [3], PCI device fixups can happen at any time, including at the
> _noirq phase where, obviously, the PCI controller must be already
> setup.
>
> I don't think changing this behavior is a viable solution and I would
> not see it as a "PCI core could do better" alternative.
>
> ---8<---
>
> [1]
> commit ab14d45ea58eae67c739e4ba01871cae7b6c4586
> Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date:   Tue Mar 17 15:55:45 2015 +0100
>
>     PCI: mvebu: Add suspend/resume support
>
>     Add suspend/resume support for the mvebu PCIe host driver.  Without
>     this commit, the system will panic at resume time when PCIe devices
>     are connected.
>
>     Note that we have to use the ->suspend_noirq() and ->resume_noirq()
>     hooks, because at resume time, the PCI fixups are done at
>     ->resume_noirq() time, so the PCIe controller has to be ready at
>     this point.
>
>     Signed-off-by: Thomas Petazzoni
>     <thomas.petazzoni@free-electrons.com> Signed-off-by: Bjorn Helgaas
>     <bhelgaas@google.com> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> [2] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L1181
> [3] https://elixir.bootlin.com/linux/v5.2-rc1/source/drivers/pci/pci-driver.c#L522
>
> --->8---
>
> >
> > s/register/registers/ ?
>
> Indeed. I would like to sort out the above technical point before
> sending a v3 with this typo corrected.

I don't have anything more to contribute here; just wanted to make
sure this wasn't working around a fixable problem in PCI.

Bjorn
