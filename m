Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2E3CA212
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhGOQRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jul 2021 12:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGOQRt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Jul 2021 12:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FEA613ED;
        Thu, 15 Jul 2021 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626365696;
        bh=A7zSoEx7UkfbVYYyEkb2r6uf0hfMsazAqkvQUCCA4YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AxbrAyVlv14/pD7tcJyYVo9mGkIi2WhYCZpiQY/mx9svci+sYvJjbdSuai497QbqT
         GjWpEHZUK41cey366hwqWR4ZilWUvFBtBpJiLkR1aNVPn4sssRXF3gyOYRKLKfWJKE
         mw7UOjtZQASM75gCAAxgwHxevSMkNXFdOl7lMcSBjYx2ADKiNu5nbRVyyOJz1Ar5Y/
         j8Z3KkZ5ju2zoOSINtK5kpp3LAfNzAlnoW1STkcO215XhCnsON3k382PblRntlePWw
         //KxsMlyaQrGbSO++NDmOtZvTCiVy/jz+4Ptl+ZJ4SWq2dyCLl0ENJwJPrKLSxcAgQ
         YUO8sBaWGNomw==
Date:   Thu, 15 Jul 2021 11:14:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] PCI/PM: Target PM state is D3hot if device can only
 generate PME from D3cold
Message-ID: <20210715161454.GA1776966@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hJRASb-JrJYGAX_8j+S_Rvjy0VsjB17ndM3BYgQ+mE=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 12, 2021 at 05:22:58PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 8, 2021 at 3:20 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, July 8, 2021 2:39:49 PM CEST Rafael J. Wysocki wrote:
> > > On Thu, Jul 8, 2021 at 2:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 7, 2021 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jun 17, 2021 at 03:36:53PM +0300, Mika Westerberg wrote:
> > > > > > Some PCIe devices only support PME (Power Management Event) from D3cold.
> > > > > > One example is ASMedia xHCI controller:
> > > > > >
> > > > > > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> > > > > >   ...
> > > > > >   Capabilities: [78] Power Management version 3
> > > > > >         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > > > > >         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > > >
> > > > > > With such devices, if it has wake enabled, the kernel selects lowest
> > > > > > possible power state to be D0 in pci_target_state(). This is problematic
> > > > > > because it prevents the root port it is connected to enter low power
> > > > > > state too which makes the system consume more energy than necessary.
> > > > >
> > > > > IIUC this is because the loop that checks which states support PME
> > > > > starts with D3hot and doesn't even look at D3cold.
> > > >
> > > > That's because the device itself cannot be programmed into D3cold, so
> > > > the target state cannot be D3cold for it.
> > > >
> > > > > > The problem in pci_target_state() is that it only accounts the "current"
> > > > > > device state, so when the bridge above it (a root port for instance) is
> > > > > > transitioned into D3hot the device transitions into D3cold. This is
> > > > > > because when the root port is first transitioned into D3hot then the
> > > > > > ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> > > > > > the root port and the device are in D3cold). If the root port is kept in
> > > > > > D3hot it still means that the device below it is still effectively in
> > > > > > D3cold as no configuration messages pass through. Furthermore the
> > > > > > implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> > > > > > expect to be transitioned into D3cold soon after its link transitions
> > > > > > into L2/L3 Ready state.
> > > > > >
> > > > > > Taking the above into consideration, instead of forcing the device stay
> > > > > > in D0 we modify pci_target_state() to return D3hot in this special case
> > > > > > and make __pci_enable_wake() to enable PME too in this case.
> > > > > >
> > > > > > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > > > > > Reported-by: Koba Ko <koba.ko@canonical.com>
> > > > > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > ---
> > > > > > The previous version of the patch is here:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pm/20210616150516.28242-1-mika.westerberg@linux.intel.com/
> > > > > >
> > > > > > Changes from the previous version:
> > > > > >
> > > > > >   * Dropped redundant test in pci_target_state().
> > > > > >
> > > > > >  drivers/pci/pci.c | 16 +++++++++++++++-
> > > > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index b717680377a9..043c5c304308 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -2485,7 +2485,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
> > > > > >       if (enable) {
> > > > > >               int error;
> > > > > >
> > > > > > -             if (pci_pme_capable(dev, state))
> > > > > > +             /*
> > > > > > +              * Enable PME if device is capable from given state.
> > > > > > +              * Special case is device that can only generate PME
> > > > > > +              * from D3cold then we enable PME too.
> > > > > > +              */
> > > > > > +             if (pci_pme_capable(dev, state) ||
> > > > > > +                 (state == PCI_D3hot && pci_pme_capable(dev, PCI_D3cold)))
> > > > > >                       pci_pme_active(dev, true);
> > > > > >               else
> > > > > >                       ret = 1;
> > > > > > @@ -2595,6 +2601,14 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > > > > >                * PME#.
> > > > > >                */
> > > > > >               if (dev->pme_support) {
> > > > > > +                     /*
> > > > > > +                      * Special case if device supports only PME from
> > > > > > +                      * D3cold but not from D3hot we still return D3hot.
> > > > > > +                      */
> > > > > > +                     if (target_state == PCI_D3hot &&
> > > > > > +                             (dev->pme_support & (1 << PCI_D3cold)))
> > > > > > +                             return target_state;
> > > > >
> > > > > I've spent quite a bit of time trying to understand this, and I'm kind
> > > > > of dragging my feet on it because I haven't been able to really
> > > > > connect this with the specs.
> > > >
> > > > The specs aren't very clear in this area, though.
> > > >
> > > > The overall picture is that the device in question is connected to a
> > > > port (a root port in this particular case) that can be programmed into
> > > > D3cold via ACPI, but the endpoint itself can only be programmed into
> > > > D3hot.  However, if the port goes into D3cold, the endpoint also goes
> > > > into D3cold (actually, my understanding of the specs is that even if
> > > > the port goes into D3hot, the endpoint should still be assumed to go
> > > > into D3cold).
> > > >
> > > > The power state of the endpoint is changed first and at the time this
> > > > happens it is not known which power state the port is going to be
> > > > programmed into.
> > > >
> > > > Now, the device is wake-capable (in general) and so we want it to be
> > > > able to signal wakeup from the final power state.  Because it only
> > > > reports PME support in D0 and in D3cold, the kernel today leaves it in
> > > > D0 which causes the port to stay in D0 too.  Still, putting the device
> > > > into D3hot allows the port to go into D3cold which in turn causes the
> > > > device to go into D3cold and it can signal wakeup from that state.
> > > >
> > > > So there are two ways to get into a configuration from which the
> > > > endpoint device can signal wakeup, either by leaving it and the port
> > > > holding it both in D0, or by putting it into D3hot, so that the port
> > > > can go into D3cold in which case the endpoint will end up in D3cold.
> > > >
> > > > The Mika's patch is aiming at enabling the second option.
> > > >
> > > > > It also seems unfortunate to have to add this special case in two places.
> > > >
> > > > That's because __pci_enable_wake() tries to be extra careful and only
> > > > call pci_pme_active() if PME is known to be supported in the target
> > > > power state, but that is not strictly necessary.  It could just call
> > > > pci_pme_active() unconditionally and return the
> > > > platform_pci_set_wakeup() return value.
> > > >
> > > > I think I'll send a patch making this change.
> > >
> > > Actually, it needs to fail if PME cannot be signaled from the target
> > > state and the device is not power-manageable by the platform.
> > >
> > > A better idea may be to make pci_pme_capable() also check if the
> > > parent bridge can go into D3cold and return "true" if so and "state"
> > > is D3hot while PME signaling from D3cold is supported.
> >
> > So below is my version of the $subject patch (untested).
> >
> > Please let me know what you think.
> 
> I gave some more consideration to this and I was not able to convince
> myself that putting the parent port into D3hot was sufficient for the
> endpoint device connected to it to go into D3cold.  

Thanks, that was a sticking point for me, too.  I've never been able
to directly connect the parent port's D0-D3cold power state to the
main power state for a downstream device.

> However, the PCI PM spec v1.2 clearly mandates that putting a bridge
> into D3cold will cause power to be removed from the entire bus
> segment below it, which should apply to PCIe devices by extension.

Are you referring to Table 6-1, where it says "No PCI transactions; no
clock; no Vcc" on the secondary bus if the bridge is in D3cold?

I'm not really clear on how a bridge's power state affects main power
for downstream devices.  What about optical links where the power
distribution is more separate from the communication path?

> So I'm going to submit a new version of the patch below in which
> pci_pme_capable() will check whether or not the parent will go into
> D3cold in addition to all of the other checks.
> 
> Stay tuned!

Bjorn
