Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2428810715D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKVLae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 06:30:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44572 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVLad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 06:30:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id s71so6154108oih.11;
        Fri, 22 Nov 2019 03:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AztedQRtvfRwxfo3QRrdXEr1MGU4pSr0i/7X1wXzMk=;
        b=M0LWIbI8S9K+vRpuTVgrSG1PV6hU/V7sdvF3QcQLdWOAwVCjzsPGoFw/8Wy5DXRJ/N
         6Gf/xv9U8yq1jjdH3IaG9P+VS8j+iOKVEjJJ0/ypLGBJU0mHoRN1eJXqtIkSaXqtzWT4
         vdkVYdRdp8FzeBI/YsEAWgUs3WKWE0m+396EtA+pISeCPxX3MYIbECpnOR2PzoOCzyAv
         qmfZO7BryPxID+RjZJfXhlQDhchx++FW60gW1KMWaydPxan5sVRKYr3xNHV+1BJDddl1
         abIfvBdPU0UiOzC9LnNcgjfkuhgRsIzF8ZEdamO6Bmi/6aqwDzo32eAK1YpKq1MIWSiP
         xDRA==
X-Gm-Message-State: APjAAAW6Ybh2bo5CibRH8BYlIAt71svRuxb5npkwdzxwBVXjUQLLi4V/
        iQb5fTZb3P4819FpcyeyhKlMVps8zmNOnsHPPow=
X-Google-Smtp-Source: APXvYqzti1aGeFlD9zDtiv/CrHKaEJKHYU24UOkwwawEgE4xSBwiOz2/phcrsYazP5xsApZ2IvGteoKR1Op2YMhdvWc=
X-Received: by 2002:aca:1101:: with SMTP id 1mr12076316oir.103.1574422232306;
 Fri, 22 Nov 2019 03:30:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <20191122103637.GA11621@lahna.fi.intel.com>
In-Reply-To: <20191122103637.GA11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 12:30:20 +0100
Message-ID: <CAJZ5v0gifnGZcKr6mgc6C2EfqX13OyJnOac0uDxYNKN=A0cgMg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 11:36 AM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 11:39:23PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 21, 2019 at 8:49 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 04:43:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >
> > > > > On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > > > > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > > > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > > > > > > Express Root Port" (name from lspci) and on those systems all of that
> > > > > > > > > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > > > > > > > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > > > > > > > > never get populated under this particular bridge controller, but under
> > > > > > > > > > those "Root Port"s
> > > > > > > > >
> > > > > > > > > It always is a PCIe port, but its location within the SoC may matter.
> > > > > > > >
> > > > > > > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > > > > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> > > > > > > > still the same.
> > > > > > > >
> > > > > > > > > Also some custom AML-based power management is involved and that may
> > > > > > > > > be making specific assumptions on the configuration of the SoC and the
> > > > > > > > > GPU at the time of its invocation which unfortunately are not known to
> > > > > > > > > us.
> > > > > > > > >
> > > > > > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > > > > > > that point, so it looks like that AML tries to access device memory on
> > > > > > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > > > > > accessible in PCI power states below D0.
> > > > > > > >
> > > > > > > > Or the PCI config space of the GPU when the parent root port is in D3hot
> > > > > > > > (as it is the case here). Also then the GPU config space is not
> > > > > > > > accessible.
> > > > > > >
> > > > > > > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > > > > > > a suspend ordering violation?
> > > > > >
> > > > > > No. We put the GPU into D3hot first,
> > > >
> > > > OK
> > > >
> > > > Does this involve any AML, like a _PS3 under the GPU object?
> > >
> > > I don't see _PS3 (nor _PS0) for that object. If I read it right the GPU
> > > itself is not described in ACPI tables at all.
> >
> > OK
> >
> > > > > > then the root port and then turn
> > > > > > off the power resource (which is attached to the root port) resulting
> > > > > > the topology entering D3cold.
> > > > >
> > > > > I don't see that happening in the AML though.
> > > >
> > > > Which AML do you mean, specifically?  The _OFF method for the root
> > > > port's _PR3 power resource or something else?
> > >
> > > The root port's _OFF method for the power resource returned by its _PR3.
> >
> > OK, so without the $subject patch we (1) program the downstream
> > component (GPU) into D3hot, then we (2) program the port holding it
> > into D3hot and then we (3) let the AML (_OFF for the power resource
> > listed by _PR3 under the port object) run.
> >
> > Something strange happens at this point (and I guess that _OFF doesn't
> > even reach the point where it removes power from the port which is why
> > we see a lock-up).
>
> It does not necessary lead to lock-up. Here is dmesg from Karol's
> system:
>
>   https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
>
> what seems to happen is that the GPU never "comes back" from D3cold so
> the driver starts breaking apart as the hardware is gone now.

I meant a lock-up in hardware to be precise, that causes it to stop to
respond (which causes it to appear to be permanently in D3cold).

I wonder if the port accepts PCI config space writes then.

> > We know that skipping (1) makes things work and we kind of suspect
> > that skipping (3) would make things work either, but what about doing
> > (1) and (3) without (2)?
>
> You mean in this particular case or in general?

In this case in particular to start with.  Just do an experiment to
see what happens if we skip pci_raw_set_power_state() for the port
instead of skipping it for the downstream device.

> Because if the port has _PSx methods we need to put it into D3hot AFAIK.

Yes, we need to run _PS3 then, but maybe we don't need to write to its
PMCSR directly.

> > > > > Basically the difference is that when Windows 7 or Linux (the _REV==5
> > > > > check) then we directly do link disable whereas in Windows 8+ we invoke
> > > > > LKDS() method that puts the link into L2/L3. None of the fields they
> > > > > access seem to touch the GPU itself.
> > > >
> > > > So that may be where the problem is.
> > > >
> > > > Putting the downstream component into PCI D[1-3] is expected to put
> > > > the link into L1, so I'm not sure how that plays with the later
> > > > attempt to put it into L2/L3 Ready.
> > >
> > > That should be fine. What I've seen the link goes into L1 when
> > > downstream component is put to D-state (not D0) and then it is put back
> > > to L0 when L2/3 ready is propagated. Eventually it goes into L2 or L3.
> >
> > Well, that's the expected behavior, but the observed behavior isn't as
> > expected. :-)
>
> Right :)
>
> > > > Also, L2/L3 Ready is expected to be transient, so finally power should
> > > > be removed somehow.
> > >
> > > There is GPIO for both power and PERST, I think the line here:
> > >
> > >   \_SB.SGOV (0x01010004, Zero)
> > >
> > > is the one that removes power.
> >
> > OK
> >
> > > > > LKDS() for the first PEG port looks like this:
> > > > >
> > > > >    P0L2 = One
> > > > >    Sleep (0x10)
> > > > >    Local0 = Zero
> > > > >    While (P0L2)
> > > > >    {
> > > > >         If ((Local0 > 0x04))
> > > > >         {
> > > > >             Break
> > > > >         }
> > > > >
> > > > >         Sleep (0x10)
> > > > >         Local0++
> > > > >    }
> > > > >
> > > > > One thing that comes to mind is that the loop can end even if P0L2 is
> > > > > not cleared as it does only 5 iterations with 16 ms sleep between. Maybe
> > > > > Sleep() is implemented differently in Windows? I mean Linux may be
> > > > > "faster" here and return prematurely and if we leave the port into D0
> > > > > this does not happen, or something. I'm just throwing out ideas :)
> > > >
> > > > But this actually works for the downstream component in D0, doesn't it?
> > >
> > > It does and that leaves the link in L0 so it could be that then the
> > > above AML works better or something.
> >
> > That would be my guess.
> >
> > > That reminds me, ASPM may have something to do with this as well.
> >
> > Not really if D-states are involved.
> >
> > > > Also, if the downstream component is in D0, the port actually should
> > > > stay in D0 too, so what would happen with the $subject patch applied?
> > >
> > > Parent port cannot be lower D-state than the child so I agree it should
> > > stay in D0 as well. However, it seems that what happens is that the
> > > issue goes away :)
> >
> > Well, at least this is kind of out of the spec.
> >
> > Note that pci_pm_suspend_noirq() won't let the port go into D3 if the
> > downstream device is in D0, so the $subject patch will not work as
> > expected in the suspend-to-idle case.
> >
> > Also we really should make up our minds on whether or not to force
> > PCIe ports to stay in D0 when downstream devices are in D0 and be
> > consequent about that.  Right now we do one thing during system-wide
> > suspend and the other one in PM-runtime, which is confusing.
> >
> > The current design is mostly based on the PCI PM Spec 1.2, so it would
> > be consequent to follow system-wide suspend in PM-runtime and avoid
> > putting PCIe ports holding devices in D0 into any low-power states.
> > but that would make the approach in the $subject patch ineffective.
> >
> > Moreover, the fact that there are separate branches for "Windows 7"
> > and "Windows 8+" kind of suggest a change in the expected behavior
> > between Windows 7 and Windows 8, from the AML perspective.  I would
> > guess that Windows 7 followed PCI PM 1.2 and Windows 8 (and later)
> > does something else.
>
> My understanding (which may not be correct) is that up to Windows 7 it
> never put the devices into D3cold runtime. Only when the system entered
> Sx states it evaluated the _OFF methods.

I see.

> Starting from Windows 8 it started doing this runtime so devices can
> enter D3cold even when system is in S0.

Hmm.  So by setting _REV to 5 we effectively change the _OFF into a NOP?

> > Now, the structure of the "Windows 8+" branch
> > described by you suggests that, at least in the cases when it is going
> > to remove power from the port eventually, it goes straight for the
> > link preparation (the L2/L3 Ready transition) and power removal
> > without bothering to program the downstream device and port into D3hot
> > (because that's kind of redundant).
> >
> > That hypothetical "Windows 8+" approach may really work universally,
> > because it doesn't seem to break any rules (going straight from D0 to
> > D3cold is not disallowed and doing that for both a port and a
> > downstream device at the same time is kind of OK either, as long as
> > the link is ready for that).
>
> I guess it depends on how you interpret the specs ;-) From PCIe 5.0 sec
> 5.8 we can see the supported PM state transitions and it shows that you
> get to D3cold through D3hot. Of course the device goes into D3cold if
> you simply remove its power so I agree with you as well. However, if
> there is _PS3 method we can't skip the D3hot phase.

That's my understanding too, but I'm wondering about direct PMCSR
writes.  It is unclear to me if they are necessary, or more precisely,
whether or not Windows 10, say, carries them out if ACPI PM is going
to be applied.

Maybe I'm going too far with my conclusions, but please let me know
what you think about the approach proposed at the end of
https://lore.kernel.org/linux-pm/CAJZ5v0iQttGB4m5TbzCtjp2C1j5qEkUhqhpWb++LhSk3mbW=Lw@mail.gmail.com/T/#t
?
