Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29812F37C8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbhALR6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 12:58:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4603 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbhALR6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 12:58:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffde30a0000>; Tue, 12 Jan 2021 09:57:30 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 17:57:29 +0000
Date:   Tue, 12 Jan 2021 18:57:27 +0100
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
Message-ID: <X/3jBzWEVrguB8H2@ulmo>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo>
 <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
 <X/x49o3EtrUh6vuO@ulmo>
 <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WLbGv1eo9MD3lkb9"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610474250; bh=+sHpoQV1cl0tEOcli47w+x6rvgSMPQdichbBAh9+xWo=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=KHlgoggjU+4mI1/IiBcZjpihcVM20Hh9E3WsySuTpIumc+9fOtvaRgnwdniGV3YUn
         kMC76iNYPEkf3GacKqCWPvw9OBYF/VSEWRBolpmUp+pj+k1YW1Mykjv4f4ZQ9DbwkG
         yrfiD5Jp18H+FlGG8sfkaY7rHVnIY4XNNc9hhNwAn1v6Olsg7tyMOOvmutiwjPfdfm
         RcRmq7Frg8BidUvLiEMwtpYbXZYEbgqoBeGxg2kEeF+iyS5JWkabmxgUDWS0lBxOV4
         mWFSAIkhqutAO6dxeNybJZ9JxxQmlEH9219wJm/6/zkEv9eeKTenR5mP0Fa1RtyPp+
         z/24qilcsAhuA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--WLbGv1eo9MD3lkb9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 05:57:17PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 11, 2021 at 5:12 PM Thierry Reding <treding@nvidia.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 03:57:37PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 11, 2021 at 2:43 PM Thierry Reding <treding@nvidia.com> w=
rote:
> > > >
> > > > On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > > > > Hi Rafael,
> > > > >
> > > > > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generati=
on)
> > > > > fails to suspend when running 5.11-rc kernels: bisected to
> > > > > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > > > > and reverting that fixes it.  dmesg.xz attached, but go ahead and=
 ask
> > > > > me to switch on a debug option to extract further info if that ma=
y help.
> > > >
> > > > Hi Hugh,
> > > >
> > > > Quoting what I think are the relevant parts of that log:
> > > >
> > > > [   34.373742] printk: Suspending console(s) (use no_console_suspen=
d to debug)
> > > > [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
> > > > [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -=
6.
> > > > [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: =
-6
> > > > [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c ret=
urns -6
> > > > [   34.475130] PM: Device 6-002c failed to suspend: error -6
> > > > [   34.475187] PM: Some devices failed to suspend, or early wake ev=
ent detected
> > > > [   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to w=
rite to F03 TX register (-6).
> > > > [   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to w=
rite to F03 TX register (-6).
> > > > [   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Fa=
iled to change enabled interrupts!
> > > > [   34.487935] acpi LNXPOWER:02: Turning OFF
> > > > [   34.488707] acpi LNXPOWER:01: Turning OFF
> > > > [   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Fail=
ed to change enabled interrupts!
> > > > [   34.489669] psmouse: probe of serio2 failed with error -1
> > > > [   34.489882] OOM killer enabled.
> > > > [   34.489891] Restarting tasks ... done.
> > > > [   34.589183] PM: suspend exit
> > > > [   34.589839] PM: suspend entry (s2idle)
> > > > [   34.605884] Filesystems sync: 0.017 seconds
> > > > [   34.607594] Freezing user space processes ... (elapsed 0.006 sec=
onds) done.
> > > > [   34.613645] OOM killer disabled.
> > > > [   34.613650] Freezing remaining freezable tasks ... (elapsed 0.00=
1 seconds) done.
> > > > [   34.615482] printk: Suspending console(s) (use no_console_suspen=
d to debug)
> > > > [   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -=
6.
> > > > [   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > [   34.653115] rmi4_physical rmi4-00: Failed to suspend functions: =
-6
> > > > [   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > [   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c ret=
urns -6
> > > > [   34.653160] PM: Device 6-002c failed to suspend: error -6
> > > > [   34.653174] PM: Some devices failed to suspend, or early wake ev=
ent detected
> > > > [   34.660515] OOM killer enabled.
> > > > [   34.660524] Restarting tasks ...
> > > > [   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Fail=
ed to change enabled interrupts!
> > > > [   34.661591] psmouse: probe of serio2 failed with error -1
> > > > [   34.669469] done.
> > > > [   34.748386] PM: suspend exit
> > > >
> > > > I think what might be happening here is that the offending patch ca=
uses
> > > > some devices to be reordered in a way different to how they were or=
dered
> > > > originally and the rmi4 driver currently depends on that implicit o=
rder.
> > >
> > > Actually, the only possible case in which the commit in question can
> > > introduce suspend failures like this is when some dependency
> > > information is missing and so the reordering causes the ordering to
> > > change from the (working) implicit one.
> > >
> > > > Interestingly one of the bugs that the offending patch fixes is sim=
ilar
> > > > in the failure mode but for the reverse reason: the implicit order
> > > > causes suspend/resume to fail.
> > >
> > > And that happens because some dependency information is missing.
> > >
> > > So we have failing cases when dependency information is missing, so
> > > instead of fixing those we have tried to make the core change the
> > > ordering after every successful probe in the hope that this will take
> > > care of the problem without introducing new breakage.
> > >
> > > However, it evidently has introduced new breakage and in order to fix
> > > it we need to figure out what dependency information is missing in the
> > > failing cases and put that information in, but we may as well do the
> > > same for the cases that are failing without the offending change.
> > >
> > > So why don't we revert the commit in question and do just that?
> >
> > Unfortunately it isn't that easy. In fact, all the dependency
> > information already exists in the case that I cited in 5b6164d3465f
> > ("driver core: Reorder devices on successful probe"), but it's the
> > driver core that suspends/resumes the devices in the wrong order.
> >
> > The reason is because the ACONNECT device depends on the BPMP device
> > (via a power-domains property), but it's also instantiated before the
> > BPMP device (because it is listed earlier in device tree, which is
> > sorted by unit-address first, then alphabetically). BPMP being a CPU
> > non-addressable device it doesn't have a unit-address and hence is
> > listed very late in device tree (by convention). Normally this is would
> > not be a problem because deferred probe would take care of it. But there
> > is one corner-case which happens when the BPMP is built into the kernel
> > (which it usually is, as it provides access to resources necessary for
> > booting, such as clocks and resets) and ACONNECT is built as a loadable
> > module. In that case, BPMP gets probed before ACONNECT and hence when
> > ACONNECT does eventually get loaded, the BPMP is already there, meaning
> > ACONNECT won't defer probe and hence the DPM suspend/resume order is not
> > fixed up by the deferred probe code.
>=20
> What about using a device link to enforce the right ordering, then?

I was going to implement that, but then I realized that the specific
problem I was facing with ACONNECT had been solved differently in the
meantime. I wasn't able to exactly pinpoint what fixed it, but I suspect
it might have been some of Saravana's fw_devlink code. It's a bit
difficult to find out what exactly changed, because it happened after
the offending commit was already merged, so I would have to go through
all linux-next releases since early December and revert my patch to find
out when the change happened and then bisect which change exactly did
it.

But yes, using a device link would've done the trick as well. However
the idea had been to potentially fix many more subtle cases like the one
we faced in ACONNECT at the same time. It's unfortunate that it breaks a
bunch of other cases that apparently are also missing dependency
information and just happen to work fine with the status quo.

> Deferred probing is not a way to ensure the suitable suspend/resume order=
ing.

Well, it is in the majority of cases because deferred probe causes the
reordering of the suspend/resume queue. And that all makes sense because
suppliers should always be suspended after all their consumers.

But that's not what the offending patch was doing. The purpose was to
ensure that the default suspend/resume ordering matches the probe order,
which is both more logical (though I suppose that can be subjective) and
ensures that deferred probing can work properly for all cases.

Anyway, this is ultimately just switching out one set of broken cases
for another, so might as well revert the offending patch and concentrate
on fixing the broken cases one by one as we find them.

Like I said, I'm slightly concerned about drivers like rmi4 breaking
unexpectedly down the road because some other patch caused the ordering
to change, so reverting now may just be putting off the inevitable. But
you're obviously right that we shouldn't randomly break working setups,
so I'm fine with the revert.

Thierry

--WLbGv1eo9MD3lkb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/94wMACgkQ3SOs138+
s6FXzA//Y1zL9UW7ZM6F1rvvNkOges4RswNSz4KTcS7xrtqJbpEKZkdjU0BX26ZM
wxiDcvJSAB7ciZX6ur/VVqDG28khZzCx4HlK+IBuBiGf7AZ56FP0tBoV0GT2NZJ6
JwKKjGMArEpkCUofr54TXkuoE/03TCl+KbGV7MTLzNu3dBDFk4REmnPKk0BOwtf8
pHI1+ISHKKL4lqkat+QSuG5ixYGoHn9TSNKijM/4gSj3Cec1ZHB6Abhmr3OYbQei
2sV2gbZtcGl9iOYhDQDj/H+bOgfU82OKEZWIENLZeIRgM1EuEok8PdZaVRcT7vQp
Hdc6XIBYsBu91SNfM2lhbvcZvp98NCWhq3qQvU8LDd/Z0kiXFfXtIGE8cYny/1Js
vu3izNNsLBSnb0wZkp1bqPAYPmUA08CJ8pZgslhEi3nCp9Kb6ahCtAi83l62G3KH
yvvjXkb1sOp3MWkYM43clnliEdA5NnINsu9nCsOHaBVuJ8Sm+IbYCo4tt81JB7wW
jdklAtpWmcmQST6Wt6C2SbiWCoG8TI2h4/mbCVHVdB3qVq84mEg1EeX6TDE4NZUY
b1K4hwUTsj8YRNdFjXqeaQsJ8xcDtYt+YI6YhHVa/riyh1IvHxhjKqDjWbL0XHPI
TLNGGtFatq9AuEoj2KTze/baYTpqvMJzJenwVuC1s0daYe098ls=
=XbSZ
-----END PGP SIGNATURE-----

--WLbGv1eo9MD3lkb9--
