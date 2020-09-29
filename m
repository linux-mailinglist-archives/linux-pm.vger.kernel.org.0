Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B527DB5C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgI2WEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 18:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgI2WEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 18:04:42 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D612083B;
        Tue, 29 Sep 2020 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601417081;
        bh=ohVJ5CYJHQN2bluTe6X9eGbwWIIhhGPBsFARciNuwI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eymmyYaEYYDNiuPAerTeDeySxwqXa6kkWlQ13rPdkILvB6K12oHE1IsLSa5n8kLDx
         yMuxVQ14X8TCoWhxGufZih6MA7o6j2ld2AwPK+QaXlVQEPi1EHSThB4UrOgLf5ceXS
         oX5AI7F5/KSw19EeHjs4NmOxud9l4JmwSuNezDG4=
Received: by earth.universe (Postfix, from userid 1000)
        id 5AD8B3C0C84; Wed, 30 Sep 2020 00:04:39 +0200 (CEST)
Date:   Wed, 30 Sep 2020 00:04:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for
 'microchip,reset-switch-core' property
Message-ID: <20200929220439.ygpiv2tlvf7q7na4@earth.universe>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
 <20200513130842.24847-4-lars.povlsen@microchip.com>
 <20200528022502.GA3234572@bogus>
 <87wo4piyqz.fsf@soft-dev15.microsemi.net>
 <20200828163916.g6vbk3anfyijl7sx@earth.universe>
 <871rjnxm5h.fsf@soft-dev15.microsemi.net>
 <875z8ei218.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx44gtk7z6nvfotn"
Content-Disposition: inline
In-Reply-To: <875z8ei218.fsf@soft-dev15.microsemi.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zx44gtk7z6nvfotn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2020 at 10:00:51AM +0200, Lars Povlsen wrote:
> Lars Povlsen writes:
> > Sebastian Reichel writes:
> >> On Tue, Jun 02, 2020 at 11:49:08AM +0200, Lars Povlsen wrote:
> >> > Rob Herring writes:
> >> > > On Wed, May 13, 2020 at 03:08:40PM +0200, Lars Povlsen wrote:
> >> > >> This documents the 'microchip,reset-switch-core' property in the
> >> > >> ocelot-reset driver.
> >> > >>
> >> > >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> >> > >> ---
> >> > >>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 =
++++++
> >> > >>  1 file changed, 6 insertions(+)
> >> > >>
> >> > >> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot=
-rese=3D
> >> t.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> >> > >> index 4d530d8154848..20fff03753ad2 100644
> >> > >> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.=
txt
> >> > >> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.=
txt
> >> > >> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
> >> > >>  Required Properties:
> >> > >>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chi=
p-res=3D
> >> et"
> >> > >>
> >> > >> +Optional properties:
> >> > >> +- microchip,reset-switch-core : Perform a switch core reset at t=
he
> >> > >> +  time of driver load. This is may be used to initialize the swi=
tch
> >> > >> +  core to a known state (before other drivers are loaded).
> >> > >
> >> > > How do you know when other drivers are loaded? This could be a mod=
ule
> >> > > perhaps. Doesn't seem like something that belongs in DT.
> >> > >
> >> >=20
> >> > The reset driver is loaded at postcore_initcall() time, which ensure=
s it
> >> > is loaded before other drivers using the switch core. I noticed other
> >> > drivers do the same to do low-level system reset and initialization =
at
> >> > early boot time.
> >> >=20
> >> > > Can this behavior be implied with "microchip,sparx5-chip-reset"?
> >> >=20
> >> > Since we need to cater for both modus operandi, I would need two dri=
ver
> >> > compatible strings per platform, which scales worse than a single
> >> > property.
> >> >=20
> >> > The "microchip,reset-switch-core" is a device configuration property
> >> > which tells the system (driver) how the hw should be handled. Since =
you
> >> > do not *always* want to reset the switch core (f.ex. when implementi=
ng
> >> > systems with warm reboot), I think it makes perfect sense - but I ma=
y be
> >> > biased off course :-)
> >> >=20
> >> > Thank you for (all) of your comments, by the way!
> >> >=20
> >> > ---Lars
> >>=20
> >> Is this series still needed? Did I miss a follow-up?
> >
> > Hi Sebastian!
> >
> > Yes, the series is still needed, but the conversation died after my
> > last message.
> >
> > If the DT-controlled reset property is too controversial, I am willing
> > to drop that part. (Rob just reviewed the bindings).
> >
> > MCHP reference designs have GPIO resets, so we *could* get by without,
> > but new designs may this feature.
> >
> >> -- Sebastian
> >
>=20
> Sebastian,
>=20
> Any update on the patches? They're the last part of the original Sparx5
> series, so I would love to get them done.
>=20
> As previously stated, I could remove the "microchip,reset-switch-core"
> parts if that's whats what holding it stuck.

I am waiting for Rob's Acked-by for the binding.

-- Sebastian

--zx44gtk7z6nvfotn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zr3QACgkQ2O7X88g7
+pqASg//fiYtiv93ajoBNnVMxH9wjp3SFnrFUbyIZMoHEBwnVmvq2sJPy9OYae7J
vpj+cWseSeyzUAJY25Id2utSJUqQfNbs131hsWEHXNpbLBIlqO3vR704hT7rd25v
kmjkWkKA47iQEJVUqraWfp24Rak55M7FmVAG57I8riNuixcLh0J8hH2SZkXrHELm
RAilzuHS0H02r0uHgOug87im+HiK66INSntn6g5DRCDwU8LFeuilMLXAKpLUDFdY
nB+IlGyYpYB5ckhxtVVod006RRMD+yyQpd6lLETtzYURKG/SvGkL3jnauY/nMNPD
qjyxw1ks7qD6OJr7TXNmpQQn4EbDf+lPLr22dYX82JFrs34nfgBHsAalcJ4H8KCZ
iNN60JE08hd6/OOerI0szArFX3dNBvnvckvPw0tZXcoDrEL9jeg5ntzsYBoHnNrJ
xRm93RzG4zk5e25tZAA5Hq5dhsuQJNZPQypzc4XdlWateYhpkQpBLPUjkw+Zxs6v
AagcBK+cjExFsj/8V8mfV3rANJYO3g4IOhnP/Yfy0oYH0UdxRm1y9SGDaxUF3x8S
k4jfQVG3ecFdAF5Q0M1Hsq1KThfO9LTpT1usTLxbOH9+8KEAet0KGrQ0r/LgQIIz
/oacIYFufXEuueiZRl2hfntRC3ITwd1c/osM7QoWWu7H/qbPY9o=
=qenh
-----END PGP SIGNATURE-----

--zx44gtk7z6nvfotn--
