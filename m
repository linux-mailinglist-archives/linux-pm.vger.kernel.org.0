Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE53C2F15B5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 14:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbhAKNoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 08:44:01 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10628 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbhAKNnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 08:43:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc55f00001>; Mon, 11 Jan 2021 05:43:12 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 13:43:12 +0000
Date:   Mon, 11 Jan 2021 14:43:09 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
Message-ID: <X/xV7ZV5jzI7RvAe@ulmo>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lN+kFVj2Dd+ypR5G"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610372592; bh=VtI56arTmvPDds1bUHvrFG9JNVtaZLCU5E2c0yjQpUo=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=B8wFtRoZgODFUGcc0Xan/ISDzie6Pqg/3b8dr4v8QD47i4N435lnshuSPyNEmuV19
         GQZv9taXUIKF+kjwPdSp/8/MA4SUutYE+En/EFeDjQ1fJOfKYAPsYQjlclxmv2W46R
         xFSgqNx3QE6ThP2T3QcIpgAPwRsekSDOMT1teBUgpGE05gJlWSHvJRJX6BlevAE75e
         N0bOVVdN9Qr6mZSjeeaOKA62ySUjG9ZhxdEspHkIX1tpGXhxUjgWI9JHQ4NZ45s2Qq
         zzrgJ87A95mgvaGuCX9RYrf14TytF8iialUNsn8UID47XRvsypNxA2nv6kTWcvHIYE
         zC/HR4SqNKS/w==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--lN+kFVj2Dd+ypR5G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> Hi Rafael,
>=20
> Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> fails to suspend when running 5.11-rc kernels: bisected to=20
> 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> me to switch on a debug option to extract further info if that may help.

Hi Hugh,

Quoting what I think are the relevant parts of that log:

[   34.373742] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
[   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
[   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
[   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: -6
[   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
[   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
[   34.475130] PM: Device 6-002c failed to suspend: error -6
[   34.475187] PM: Some devices failed to suspend, or early wake event dete=
cted
[   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to =
F03 TX register (-6).
[   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to =
F03 TX register (-6).
[   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Failed to =
change enabled interrupts!
[   34.487935] acpi LNXPOWER:02: Turning OFF
[   34.488707] acpi LNXPOWER:01: Turning OFF
[   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to ch=
ange enabled interrupts!
[   34.489669] psmouse: probe of serio2 failed with error -1
[   34.489882] OOM killer enabled.
[   34.489891] Restarting tasks ... done.
[   34.589183] PM: suspend exit
[   34.589839] PM: suspend entry (s2idle)
[   34.605884] Filesystems sync: 0.017 seconds
[   34.607594] Freezing user space processes ... (elapsed 0.006 seconds) do=
ne.
[   34.613645] OOM killer disabled.
[   34.613650] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[   34.615482] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
[   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
[   34.653115] rmi4_physical rmi4-00: Failed to suspend functions: -6
[   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
[   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
[   34.653160] PM: Device 6-002c failed to suspend: error -6
[   34.653174] PM: Some devices failed to suspend, or early wake event dete=
cted
[   34.660515] OOM killer enabled.
[   34.660524] Restarting tasks ...
[   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to ch=
ange enabled interrupts!
[   34.661591] psmouse: probe of serio2 failed with error -1
[   34.669469] done.
[   34.748386] PM: suspend exit

I think what might be happening here is that the offending patch causes
some devices to be reordered in a way different to how they were ordered
originally and the rmi4 driver currently depends on that implicit order.

Interestingly one of the bugs that the offending patch fixes is similar
in the failure mode but for the reverse reason: the implicit order
causes suspend/resume to fail.

I suspect that the underlying reason here is that rmi4 needs something
in order to successfully suspend (i.e. read the IRQ status registers)
that has already been suspended where it hadn't prior to the offending
patch. It can't be the I2C controller itself that has been suspended,
because the parent/child relationship should prevent that from
happening.

I'm not familiar with how exactly rmi4 works, so I'll have to do
some digging to hopefully pinpoint exactly what's going wrong here.

In the meantime, it would be useful to know what exactly the I2C
hierarchy looks like. For example, what's the I2C controller that the
RMI4 device is hooked up to. According to the above, that's I2C bus 6,
so you should be able to find out some details about it by inspecting
the corresponding sysfs nodes:

	$ ls -l /sys/class/i2c-adapter/i2c-6/
	$ cat /sys/class/i2c-adapter/i2c-6/name
	$ ls -l /sys/class/i2c-adapter/i2c-6/device/

Thierry

--lN+kFVj2Dd+ypR5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/8VesACgkQ3SOs138+
s6Ft5Q/9HcqSA6B75qme4KuUeNVezjsP1jchYDUCdqNDWup+tyCiGQBWBxfq/lZ5
ggDpCzIS5aDv/awCwet/qzm5M8b5a4NJyZ3mEX91tcOaYa4Ah2TVwqgg0e0GOhad
xpM2VSfnymZOdXiF8zGzs9h1tYyy3P6HY0cKWNY96qu6DX87E1YDg98rEtPmX32Q
YcvD1xJMtwZFj1hP1VF2v5niQjFQge98sWR+X6oxaqnp4X6JOwQD9m+qGqDORbGX
ApuB9sUs3HA7kYGQ+jjDJONLIyJipW5sK4b2U6rC7M5GRTZ++WxrtR8dn5YBjRYh
Isj6OFUccKM35tAUBFmygbA1FXpJaylYJxocOowEwIRFlkCoWCx4LPu0DDfcM0nw
m7H3Ygt7VM2hM10K+z6iGUGEGmjBbK9p0jsu5GNz5rvKwb2fBJ1C1NPp0hIxscKc
PyPOfoVuiMeyaGNq1tLzxloSuCViQXpTrjdA05TUmBBq4YIIycD6DO0dZ2AFiL3h
0AE1SwLmeOLYs4ELf3QbMoETvNoFinPYjzba9c4cmV56ZFLPngKQRTtdGvfxHXC7
iox6O48PudVOZrZlMDUJKMHsDj9WFWDFtTaEbxSMAzVU0AyEtsk/lTCqmWOc8yHF
i7Ta5ZR7rOnDhqGcbwMOPTd4232s1Lcv/mRmphYIYlqt/W5h88E=
=Spe+
-----END PGP SIGNATURE-----

--lN+kFVj2Dd+ypR5G--
