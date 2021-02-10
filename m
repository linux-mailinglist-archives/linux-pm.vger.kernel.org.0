Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A97316BE1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhBJQ5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 11:57:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:45950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhBJQ4U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 11:56:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 464A9AE38;
        Wed, 10 Feb 2021 16:55:38 +0000 (UTC)
Message-ID: <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous
 SError Interrupt
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:55:36 +0100
In-Reply-To: <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
References: <20210210114829.2915de78@gollum>
         <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
         <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/Z4SwmS0k1OHJgVFXm5W"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-/Z4SwmS0k1OHJgVFXm5W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote:
> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:
> > [ Add Robin, Catalin and Florian in case they want to chime in ]
> >=20
> > Hi Juerg, thanks for the report!
> >=20
> > On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
> > > Trying to dump the BCM2711 registers kills the kernel:
> > >=20
> > > # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
> > > 0-efc
> > > # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
> > >=20
> > > [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError
> >=20
> > So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defin=
ed
> > SError,' hence IIUC the rest of the error code is meaningless to anyone=
 outside
> > of Broadcom/RPi.
>=20
> It's imp-def from the architecture's PoV, but the implementation in this=
=20
> case is Cortex-A72, where 0x000002 means an attributable, containable=20
> Slave Error:
>=20
> https://developer.arm.com/documentation/100095/0003/system-control/aarch6=
4-register-descriptions/exception-syndrome-register--el1-and-el3?lang=3Den
>=20
> In other words, the thing at the other end of an interconnect=20
> transaction said "no" :)
>=20
> (The fact that Cortex-A72 gets too far ahead of itself to take it as a=
=20
> synchronous external abort is a mild annoyance, but hey...)

Thanks for both your clarifications! Reading arm documentation is a skill o=
n
its own.

> > The regmap is created through the following syscon device:
> >=20
> > 	avs_monitor: avs-monitor@7d5d2000 {
> > 		compatible =3D "brcm,bcm2711-avs-monitor",
> > 			     "syscon", "simple-mfd";
> > 		reg =3D <0x7d5d2000 0xf00>;
> >=20
> > 		thermal: thermal {
> > 			compatible =3D "brcm,bcm2711-thermal";
> > 			#thermal-sensor-cells =3D <0>;
> > 		};
> > 	};
> >=20
> > I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> rang=
e is
> > full of addresses that trigger this same error. Also note that as per F=
lorian's
> > comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from wh=
at I can
> > tell, at least 0x7d5d22b0 seems to be faulty too.
> >=20
> > Any ideas/comments? My guess is that those addresses are marked somehow=
 as
> > secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultima=
tely,
> > the solution is to narrow the register range exposed by avs-monitor to =
whatever
> > bcm2711-thermal needs (which is ATM a single 32bit register).
>=20
> When a peripheral decodes a region of address space, nobody says it has=
=20
> to accept accesses to *every* address in that space; registers may be=20
> sparsely populated, and although some devices might be "nice" and make=
=20
> unused areas behave as RAZ/WI, others may throw slave errors if you poke=
=20
> at the wrong places. As you note, in a TrustZone-aware device some=20
> registers may only exist in one or other of the Secure/Non-Secure=20
> address spaces.
>=20
> Even when there is a defined register at a given address, it still=20
> doesn't necessarily accept all possible types of access; it wouldn't be=
=20
> particularly friendly, but a device *could* have, say, some registers=20
> that support 32-bit accesses and others that only support 16-bit=20
> accesses, and thus throw slave errors if you do the wrong thing in the=
=20
> wrong place.
>=20
> It really all depends on the device itself.

All in all, assuming there is no special device quirk to apply, the feeling=
 I'm
getting is to just let the error be. As you hint, firmware has no blame her=
e,
and debugfs is a 'best effort, zero guarantees' interface after all.

Regards,
Nicolas


--=-/Z4SwmS0k1OHJgVFXm5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAkEAgACgkQlfZmHno8
x/7fnQf9ESYreLzcvUH7mg17Cx23iFWl7EHMsqkjbcWox+PGTb8Ix0/4EZ1ddTIr
t/MNanamdbPKbN7O6K2FPYP4hSCikSXKOGNwEFo0Vnrap913p9rkL6Verg7Na/P5
QzOUUHH1hd78j6yYlAfIoFyh7Vg+7VW7aGRp8QbpQ1JPFmiqoaZV5yiWVu1++n/D
Ws+bZSuKWLp9NbiJBpdK/ghM7YujcYJzHL/55gMZx4zBFLTp4V26YR3I7Xy2Wd1C
9/nXI5EzxOnXfStRyGwsV7O85uiJrUv/ThKxYXydmMXm/chbIW+f/8kLUgzCwMcw
pvf6qmtSUR5jGt7T/gqAcbhFSsHs7g==
=MM5M
-----END PGP SIGNATURE-----

--=-/Z4SwmS0k1OHJgVFXm5W--

