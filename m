Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993122F1AA5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbhAKQNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 11:13:22 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8797 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbhAKQNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 11:13:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc78f90001>; Mon, 11 Jan 2021 08:12:41 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 16:12:40 +0000
Date:   Mon, 11 Jan 2021 17:12:38 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hugh Dickins <hughd@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
Message-ID: <X/x49o3EtrUh6vuO@ulmo>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo>
 <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="85Ht1sdjLWAN5yJC"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610381561; bh=7Yig2Tb2gp9R+0eXhwBFWu+FdEsG28aZye6K9+vGVyc=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=d2MgtiIjPPAr7igSt0BSVQBY+hwjqfDRIoRlT/hsyka0BnH5HIytgr1wFuFcB1hub
         c6o02Unhjzyb/rQSKiCa73XWbLUWcLASewQN2ZLy2bLHLGqsushpjN9N2QfjsFEiSQ
         jSI6x6a33dU02GQsPXDbh/UZC/tkj0Awz47J/kGybprF9iUnw3vqww4TzVE4Jz+nwC
         fcQB4K0mmG4Ddk5pVJ5+kSuhgXEFnxhxNes3G84iWZD9tVb+eBiz1c3qsuLSNLlWOU
         O5+sl5hSA2Dxjf/DMD4TtNLDdNBFOFzhJG7d62aVxbI8akpYbioxysLNIm32vcE7M0
         EGCwM7oYfGjEw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--85Ht1sdjLWAN5yJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 03:57:37PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 11, 2021 at 2:43 PM Thierry Reding <treding@nvidia.com> wrote:
> >
> > On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > > Hi Rafael,
> > >
> > > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> > > fails to suspend when running 5.11-rc kernels: bisected to
> > > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > > and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> > > me to switch on a debug option to extract further info if that may he=
lp.
> >
> > Hi Hugh,
> >
> > Quoting what I think are the relevant parts of that log:
> >
> > [   34.373742] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> > [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
> > [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> > [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: -6
> > [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> > [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns=
 -6
> > [   34.475130] PM: Device 6-002c failed to suspend: error -6
> > [   34.475187] PM: Some devices failed to suspend, or early wake event =
detected
> > [   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write=
 to F03 TX register (-6).
> > [   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write=
 to F03 TX register (-6).
> > [   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Failed=
 to change enabled interrupts!
> > [   34.487935] acpi LNXPOWER:02: Turning OFF
> > [   34.488707] acpi LNXPOWER:01: Turning OFF
> > [   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed t=
o change enabled interrupts!
> > [   34.489669] psmouse: probe of serio2 failed with error -1
> > [   34.489882] OOM killer enabled.
> > [   34.489891] Restarting tasks ... done.
> > [   34.589183] PM: suspend exit
> > [   34.589839] PM: suspend entry (s2idle)
> > [   34.605884] Filesystems sync: 0.017 seconds
> > [   34.607594] Freezing user space processes ... (elapsed 0.006 seconds=
) done.
> > [   34.613645] OOM killer disabled.
> > [   34.613650] Freezing remaining freezable tasks ... (elapsed 0.001 se=
conds) done.
> > [   34.615482] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> > [   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> > [   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > [   34.653115] rmi4_physical rmi4-00: Failed to suspend functions: -6
> > [   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
> > [   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns=
 -6
> > [   34.653160] PM: Device 6-002c failed to suspend: error -6
> > [   34.653174] PM: Some devices failed to suspend, or early wake event =
detected
> > [   34.660515] OOM killer enabled.
> > [   34.660524] Restarting tasks ...
> > [   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed t=
o change enabled interrupts!
> > [   34.661591] psmouse: probe of serio2 failed with error -1
> > [   34.669469] done.
> > [   34.748386] PM: suspend exit
> >
> > I think what might be happening here is that the offending patch causes
> > some devices to be reordered in a way different to how they were ordered
> > originally and the rmi4 driver currently depends on that implicit order.
>=20
> Actually, the only possible case in which the commit in question can
> introduce suspend failures like this is when some dependency
> information is missing and so the reordering causes the ordering to
> change from the (working) implicit one.
>=20
> > Interestingly one of the bugs that the offending patch fixes is similar
> > in the failure mode but for the reverse reason: the implicit order
> > causes suspend/resume to fail.
>=20
> And that happens because some dependency information is missing.
>=20
> So we have failing cases when dependency information is missing, so
> instead of fixing those we have tried to make the core change the
> ordering after every successful probe in the hope that this will take
> care of the problem without introducing new breakage.
>=20
> However, it evidently has introduced new breakage and in order to fix
> it we need to figure out what dependency information is missing in the
> failing cases and put that information in, but we may as well do the
> same for the cases that are failing without the offending change.
>=20
> So why don't we revert the commit in question and do just that?

Unfortunately it isn't that easy. In fact, all the dependency
information already exists in the case that I cited in 5b6164d3465f
("driver core: Reorder devices on successful probe"), but it's the
driver core that suspends/resumes the devices in the wrong order.

The reason is because the ACONNECT device depends on the BPMP device
(via a power-domains property), but it's also instantiated before the
BPMP device (because it is listed earlier in device tree, which is
sorted by unit-address first, then alphabetically). BPMP being a CPU
non-addressable device it doesn't have a unit-address and hence is
listed very late in device tree (by convention). Normally this is would
not be a problem because deferred probe would take care of it. But there
is one corner-case which happens when the BPMP is built into the kernel
(which it usually is, as it provides access to resources necessary for
booting, such as clocks and resets) and ACONNECT is built as a loadable
module. In that case, BPMP gets probed before ACONNECT and hence when
ACONNECT does eventually get loaded, the BPMP is already there, meaning
ACONNECT won't defer probe and hence the DPM suspend/resume order is not
fixed up by the deferred probe code.

And that's precisely what the offending commit addresses. However, the
downside is, and we did discuss this during review, that it operates
under the (somewhat optimistic) assumption that all the dependency
information exists. This is because reordering on successful probe can
potentially introduce regressions for dependencies that were previously
implicit. So if a system has component B that depends on component A but
doesn't model that dependency via some child/parent relationship or an
explicit relationship that would be flagged by deferred probe, then this
implicit dependency can break by the new reordering on successful probe.

I very much suspect that that's exactly what's going on here. This RMI4
device very likely implicitly depends on some other resource getting
enabled but doesn't properly model that dependency. If we find out what
that dependency is and return -EPROBE_DEFER when that dependency has not
probed yet, then deferred probe will automatically take care of ordering
everything correctly again (or, in fact, ordering by successful probe
will take care of it already because RMI4 would initially fail with
-EPROBE_DEFER).

Adding Vincent, Jason, Andrew and Lucas (who have recently worked on
this driver), perhaps they have some better understanding of what
missing dependencies might be causing the above errors.

Thierry

--85Ht1sdjLWAN5yJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/8ePMACgkQ3SOs138+
s6Gqfg/5AYhaDb2srbLdzVoQ0KLRPf2V2GcB/TT3j1DqfbzI9fXXVVSbxOs5Wifd
4jlJgqbSe0WB1A8rfzNJHyavNaZ9zLqAZrs8gvecGiTj3H7VlUzaQpY3QU96dLej
4w7TkJfU09jKP7XRHazSrp2w02vTk4jRwQEML7KgqAVeXHfpNeD/OFJOICfScd2j
E73JqFm1Q25sIt49au5TfQ1gzReweJ46Hfm/fex+8U9bThcXBSJC0ioMly/mJrDn
+5yq+PO9o5We4z60WCV9u0CAzl8DQY7mwJisjs9HxeD3g64cF4Udbp+8vYYZdodA
HmItuFoVz2xD3dq7ghnrWM03WD5kVdQgKEB6cxD6zjGnbMzkMShST9RC64DO3DvK
m6P7EmL11R5bxRvPz9gm7o2GtfAhTgSvipqMbik7H8pwlWF5M08TxqELoMy0K9hQ
YR/tbcfmytNQof/NeNObTDi9Z6PUMh4lIwZjSFKnm7zXRtbxTWiY7D5DuYTe0nk8
Pw0quCFq0NhYkJ4c8tIydUres8tf853zL6EdkOrUGwLrHC07pzlrXOvbwyy+74Tg
BuMZAF90xy7wMUzgXZ0GU3hBOJ9yrEJzjyRgPNJDyIW1UB2nXlv8wiPD1xdkKs+f
0ixJXq5HybDxk1XPDMGm1ZrceVAcWG/XkUYlQpcnyZIWGjvLOgI=
=Mkxw
-----END PGP SIGNATURE-----

--85Ht1sdjLWAN5yJC--
