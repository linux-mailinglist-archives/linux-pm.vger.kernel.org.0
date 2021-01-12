Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAF2F375C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 18:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhALRiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 12:38:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18983 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhALRiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 12:38:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffdde5c0000>; Tue, 12 Jan 2021 09:37:32 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 17:37:31 +0000
Date:   Tue, 12 Jan 2021 18:37:28 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
Message-ID: <X/3eWOHJ7lxtGFOa@ulmo>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo>
 <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
 <X/x49o3EtrUh6vuO@ulmo>
 <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LgYo5ll47cbXIsmU"
Content-Disposition: inline
In-Reply-To: <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610473052; bh=slej2DaJ9zju4MRmJY1Qzxg5dRFLVFuQVzHACuduIVw=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=gPe9uxc40qgSBiNNhsl6j0QLsRG9LjrhO22fSHUoEzMQvOtEZVdhxPs0Q4ckV3jLe
         +agm34VbOCA7268X/HezwwOf5OMuvfOAFuF+14ZXLMRln9REblrSAV09x2bwglgJti
         0AB7AVArGBOddjLtYlc1nlV8vAAAdBAMu/1rf0qJwFeGSLX7bgR8kWLPbzytNO2HS2
         UGVArcACETPIzHYBV/gj2sN74zb38mKzTT1CTDO0sE3usPG0EwpIvFej9KzDNGubPj
         1xkhRew9Iqbnr25XD+GnGBAS71Ma5J7ge9e/ar2cirYU6qdyyL2u6lxGCvLy2wvBVC
         6G65ANU6puk3w==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--LgYo5ll47cbXIsmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 02:44:03PM -0800, Saravana Kannan wrote:
> On Mon, Jan 11, 2021 at 8:57 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Mon, Jan 11, 2021 at 5:12 PM Thierry Reding <treding@nvidia.com> wro=
te:
> > >
> > > On Mon, Jan 11, 2021 at 03:57:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 11, 2021 at 2:43 PM Thierry Reding <treding@nvidia.com>=
 wrote:
> > > > >
> > > > > On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th genera=
tion)
> > > > > > fails to suspend when running 5.11-rc kernels: bisected to
> > > > > > 5b6164d3465f ("driver core: Reorder devices on successful probe=
"),
> > > > > > and reverting that fixes it.  dmesg.xz attached, but go ahead a=
nd ask
> > > > > > me to switch on a debug option to extract further info if that =
may help.
> > > > >
> > > > > Hi Hugh,
> > > > >
> > > > > Quoting what I think are the relevant parts of that log:
> > > > >
> > > > > [   34.373742] printk: Suspending console(s) (use no_console_susp=
end to debug)
> > > > > [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=
=3D-6
> > > > > [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode:=
 -6.
> > > > > [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > > [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions=
: -6
> > > > > [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > > [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c r=
eturns -6
> > > > > [   34.475130] PM: Device 6-002c failed to suspend: error -6
> > > > > [   34.475187] PM: Some devices failed to suspend, or early wake =
event detected
> > > > > [   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to=
 write to F03 TX register (-6).
> > > > > [   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to=
 write to F03 TX register (-6).
> > > > > [   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: =
Failed to change enabled interrupts!
> > > > > [   34.487935] acpi LNXPOWER:02: Turning OFF
> > > > > [   34.488707] acpi LNXPOWER:01: Turning OFF
> > > > > [   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Fa=
iled to change enabled interrupts!
> > > > > [   34.489669] psmouse: probe of serio2 failed with error -1
> > > > > [   34.489882] OOM killer enabled.
> > > > > [   34.489891] Restarting tasks ... done.
> > > > > [   34.589183] PM: suspend exit
> > > > > [   34.589839] PM: suspend entry (s2idle)
> > > > > [   34.605884] Filesystems sync: 0.017 seconds
> > > > > [   34.607594] Freezing user space processes ... (elapsed 0.006 s=
econds) done.
> > > > > [   34.613645] OOM killer disabled.
> > > > > [   34.613650] Freezing remaining freezable tasks ... (elapsed 0.=
001 seconds) done.
> > > > > [   34.615482] printk: Suspending console(s) (use no_console_susp=
end to debug)
> > > > > [   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode:=
 -6.
> > > > > [   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > > [   34.653115] rmi4_physical rmi4-00: Failed to suspend functions=
: -6
> > > > > [   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > > [   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c r=
eturns -6
> > > > > [   34.653160] PM: Device 6-002c failed to suspend: error -6
> > > > > [   34.653174] PM: Some devices failed to suspend, or early wake =
event detected
> > > > > [   34.660515] OOM killer enabled.
> > > > > [   34.660524] Restarting tasks ...
> > > > > [   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Fa=
iled to change enabled interrupts!
> > > > > [   34.661591] psmouse: probe of serio2 failed with error -1
> > > > > [   34.669469] done.
> > > > > [   34.748386] PM: suspend exit
> > > > >
> > > > > I think what might be happening here is that the offending patch =
causes
> > > > > some devices to be reordered in a way different to how they were =
ordered
> > > > > originally and the rmi4 driver currently depends on that implicit=
 order.
> > > >
> > > > Actually, the only possible case in which the commit in question can
> > > > introduce suspend failures like this is when some dependency
> > > > information is missing and so the reordering causes the ordering to
> > > > change from the (working) implicit one.
> > > >
> > > > > Interestingly one of the bugs that the offending patch fixes is s=
imilar
> > > > > in the failure mode but for the reverse reason: the implicit order
> > > > > causes suspend/resume to fail.
> > > >
> > > > And that happens because some dependency information is missing.
> > > >
> > > > So we have failing cases when dependency information is missing, so
> > > > instead of fixing those we have tried to make the core change the
> > > > ordering after every successful probe in the hope that this will ta=
ke
> > > > care of the problem without introducing new breakage.
> > > >
> > > > However, it evidently has introduced new breakage and in order to f=
ix
> > > > it we need to figure out what dependency information is missing in =
the
> > > > failing cases and put that information in, but we may as well do the
> > > > same for the cases that are failing without the offending change.
> > > >
> > > > So why don't we revert the commit in question and do just that?
> > >
> > > Unfortunately it isn't that easy. In fact, all the dependency
> > > information already exists in the case that I cited in 5b6164d3465f
> > > ("driver core: Reorder devices on successful probe"), but it's the
> > > driver core that suspends/resumes the devices in the wrong order.
> > >
> > > The reason is because the ACONNECT device depends on the BPMP device
> > > (via a power-domains property), but it's also instantiated before the
> > > BPMP device (because it is listed earlier in device tree, which is
> > > sorted by unit-address first, then alphabetically). BPMP being a CPU
> > > non-addressable device it doesn't have a unit-address and hence is
> > > listed very late in device tree (by convention). Normally this is wou=
ld
> > > not be a problem because deferred probe would take care of it. But th=
ere
> > > is one corner-case which happens when the BPMP is built into the kern=
el
> > > (which it usually is, as it provides access to resources necessary for
> > > booting, such as clocks and resets) and ACONNECT is built as a loadab=
le
> > > module. In that case, BPMP gets probed before ACONNECT and hence when
> > > ACONNECT does eventually get loaded, the BPMP is already there, meani=
ng
> > > ACONNECT won't defer probe and hence the DPM suspend/resume order is =
not
> > > fixed up by the deferred probe code.
> >
> > What about using a device link to enforce the right ordering, then?
> >
> > Deferred probing is not a way to ensure the suitable suspend/resume ord=
ering.
>=20
> Thierry,
>=20
> Can you try booting with fw_devlink=3Don with this series? It's queued
> up for 5.12-rc1
> https://lore.kernel.org/lkml/20201218031703.3053753-1-saravanak@google.co=
m/
>=20
> It might solve your issue, but I think your patch still addresses a real =
issue.

I've tried booting next-20210112 on the Jetson AGX Xavier device where
the suspend/resume problem with ACONNECT was happening and even if I
revert the reordering patch, ACONNECT resumes correctly.

Interestingly, and I don't know if that's expected or not, even setting
fw_devlink=3Doff on today's linux-next no longer exhibits the problem. My
impression from going through the fw_devlink code was that switching it
off would disable any reordering that was going on, so I'm not sure I
understand why the initial problem is fixed even in that case.

> > > And that's precisely what the offending commit addresses. However, the
> > > downside is, and we did discuss this during review, that it operates
> > > under the (somewhat optimistic) assumption that all the dependency
> > > information exists. This is because reordering on successful probe can
> > > potentially introduce regressions for dependencies that were previous=
ly
> > > implicit. So if a system has component B that depends on component A =
but
> > > doesn't model that dependency via some child/parent relationship or an
> > > explicit relationship that would be flagged by deferred probe,
> >
> > Again, deferred probing may not help here.
> >
> > > then this implicit dependency can break by the new reordering on succ=
essful probe.
> > >
> > > I very much suspect that that's exactly what's going on here. This RM=
I4
> > > device very likely implicitly depends on some other resource getting
> > > enabled but doesn't properly model that dependency. If we find out wh=
at
> > > that dependency is and return -EPROBE_DEFER when that dependency has =
not
> > > probed yet, then deferred probe will automatically take care of order=
ing
> > > everything correctly again (or, in fact, ordering by successful probe
> > > will take care of it already because RMI4 would initially fail with
> > > -EPROBE_DEFER).
> > >
> > > Adding Vincent, Jason, Andrew and Lucas (who have recently worked on
> > > this driver), perhaps they have some better understanding of what
> > > missing dependencies might be causing the above errors.
> >
> > IMV it is a mistake to believe that deferred probing can get
> > everything right for you in every case, with or without the offending
> > commit.  Sometimes you need to tell the core what the right ordering
> > is and that's what device links are for.
>=20
> IMHO, Thierry's patch is the right way to imply dependencies when
> device links aren't explicitly calling out dependencies. It's not
> really depending on deferred probe to imply dependency order. Rather,
> it's saying that the order in which devices probe is a better way to
> imply dependency than relying on the order in which devices are added.
>=20
> For Thierry's case, fw_devlink=3Don might solve his problem, but that's
> solving the problem by explicitly calling out the dependency (by
> getting it from DT where the dependency is explicitly called out). For
> implicit cases, we still need his patch. I wonder how

Yes, I think reordering on probe is logically the right thing to do.
However, I also understand Rafael's argument that this can now cause
failures that were not there before.

I do think that any failures exposed by this patch are in fact bugs
caused by missing explicit dependencies that are hidden right now by
mere chance because devices are instantiated in an order that makes
them work. If for any reason the instantiation order changes these
can easily break again.

> > As it stands today, that commit doesn't improve the situation and it
> > adds overhead and complexity.
>=20
> I'm okay if we revert it for now, but that doesn't solve the
> overarching ordering issues though.

Given that the ACONNECT problem seems to have been solved I don't have
any objections to reverting this either. On the other hand, perhaps we
can stage this in by tying it to a command-line option? I'm not sure how
helpful that would be, because if it isn't a default, people are
unlikely to go and test with it enabled and report issues.

I suppose it's also not a perfect solution because it doesn't weed out
all of the missing dependencies. Besides the implied dependencies that
can now get jumbled, I'm sure there are lots of implied dependencies
that won't get jumbled and therefore will still go unnoticed.

And perhaps that's fine. We only need to fix the bugs that are actually
causing problems, right?

Thierry

--LgYo5ll47cbXIsmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/93lQACgkQ3SOs138+
s6FF3A//W3m/cuCcyqO8mMKtAfoifYKXwGD/4ylFy4F+tyqUWBX/geqoh8IxxY4q
mD56eO2sexSF1WfLiIFBBMaxxvgmANZ3pwjEE/HbrAQ4DpJzLEibPplws7uCrNxC
7P+MaCunuMDC7h210Ilx0TajGenHY4O5ggD4PWjN5hW8hJMbvXC8PYuCw9H8/jqN
eYPC1kI24vULslvPzjiWVzUHpq8Ct5CpRJaO5lr/DaNs4W8fphonBsKjlWmKDItR
SGNlQBKGS07oIqYRZ9vJgPz28kfm8K8HMyHH9tu+I+dtVCgB6vw5uFQRvxQzCCwT
STcVKfpQHyXCkKkicz5xQcEZkzMTa5Yks+GlpcKH5vsPI44XILbpO3WPKxXmzS96
xN6mkT3BTPK0RJkSwaN/jY06mTiL8ekH3utCR+/2JNfJJBiFH3ZZLUaZQWbAsEac
UymEtSTWyJv1RsIVBxBYDKRcke8Ol5a/YxYQV2gpQw/rmN20iLYAmz+RuvGIngdY
VTm4ouNFFFJLztLA2OGLBWFGsBC9Su359ZjswIdeDrhCV0Fi715dyJk04Qx5BX/f
mpHOtH7TcMaJoA0TrOjftXyNZTQomxcAnxUWFqyOrRj1Jl9O7PmxWFoxSIH9KWYN
PpHb25FFfdrSHYtJDehvRU/owihkH+rtqQ5yUetbDthxQVeYYj4=
=bBFF
-----END PGP SIGNATURE-----

--LgYo5ll47cbXIsmU--
