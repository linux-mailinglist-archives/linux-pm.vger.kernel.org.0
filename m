Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F635489F3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFQRVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 13:21:35 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58880 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQRVf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 13:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4afMFHfci1u5XXeLng+byGIrAzWSNyHsyI06871YI5k=; b=FR9ugC9LJ0EMC2/WW4dLztG7v
        Z9BFt8fEyX5RVGOXY8z489nJKdESRtqNRSNS5QHNxjvaXV0RnundYRxH+Vx87UQTZp3a0HPVzEDna
        nPP0c7qOVDer/AdFchb2UCLDMJiwwy2CLxPoHPRWNjCzYHTknewrQi9lZbL/JKINkSPLo=;
Received: from p200300ccff076f007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff07:6f00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcvJz-0004Db-89; Mon, 17 Jun 2019 19:21:31 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcvJy-0005Fn-DA; Mon, 17 Jun 2019 19:21:30 +0200
Date:   Mon, 17 Jun 2019 19:21:16 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617192116.053951e8@kemnade.info>
In-Reply-To: <20190617170255.GF5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
        <20190617130357.41204ff7@kemnade.info>
        <20190617114048.GN5316@sirena.org.uk>
        <20190617182743.7f40f2ee@aktux>
        <20190617170255.GF5316@sirena.org.uk>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VP/ge4m0D4p08_w=ity.hXK"; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/VP/ge4m0D4p08_w=ity.hXK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2019 18:02:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jun 17, 2019 at 06:27:43PM +0200, Andreas Kemnade wrote:
>=20
> > Citing tps65950 trm page 55: =20
>=20
> > The device contains three switch-mode power supplies (SMPS):
> > =E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, =
in steps of 12.5 mV)
> > =E2=80=A2 VDD2: 600-mA buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, =
in steps of 12.5 mV, and 1.5 V as a
> >    single programmable value) =20
>=20
> > you are right, they are not really continuous. So should I add these
> > 68 steps they have as a voltage list? =20
>=20
> There's helpers for linear mappings, you should be able to use those
> (see helpers.c).
>=20
ok, I will send a 2 with such a list.

Thanks for the hint.

> > I think they are nearly continuous, so we should IMHO rather take that
> > not that strict. I guess there are no really continuous regulators, all
> > have steps as voltage is specified in a limited resolution. So what is
> > the exact meaning of that flag here? =20
>=20
> This was added for devices with extremely high resolution interfaces
> like some microcontroller interfaces that take voltage values directly
> (mirroring the regulator API) or PWM regulators - it's for cases where
> enumerating all the voltages is unreasonable.  The TWL4030 regulators
> look fairly standard in comparison.

well, VDD1 is a lot more continuous than e.g. VAUX3, but your examples
seem to be even more continuous. But maybe a comment in the api documentati=
on
might be helpful so that people do not misinterpret the meaning.

Regards,
Andreas

--Sig_/VP/ge4m0D4p08_w=ity.hXK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl0HzAwACgkQl4jFM1s/
ye/IoxAAuLW2LEMjp4xn39FDONGqu0QFyP9KNVd/Qur8jRIjxoXWgvkzwPTufX4R
WMpf0hIhoyLcZVk+EJ46FeGqNavX77W2R+kqx8qPo57uVt+ZhP2vgda7V32xE/9l
kYiyAzDnO7iVREnSSV39d8JRMz+QM86aKoGK7Int93AsIFwlTdRpaAOHXsf3dRiw
PO6EZv96aytWmchRcvMAGMz02L65AkFRpyPCUbVCfd6QqVq+ddz4SHQPJTh1dtU8
ubUE9oYmsLYg+5MeiOR6hNx+xZgIk086SbmeqRqdFZ8f21G44p8AIGDRRBx3HNX7
usoIhX6O+kHR6m3tyTLbsINjURG60AvYRvNj2xqvIkRo9yr92Cr1moE/gzblckp4
s8Jw/nA9cI7F7htdAFPJBRT+t5KZl2uI+HyxoA3kAzAuqSx2ZbD8lYJk2uSGLDOb
gC4Ii/XIuweASfSLIkMcKBNPOvX62d2++rYVWrBmWhLYp8GA4ofNJzvCWhBPZkE5
rLt8U3ejevmb0s8Embx+9M9Bs1DriliGMrdRqLpjg56T4sWiWfJYGy9exud0svhE
cKU8XnylrRtOJvu9yHE3BDqR34FAMLjpwI+jKHnhJCfb+qWgpA7/+xmbpT01Rd7x
DFHHIfoLhwJCM/2q/sWzan+S8AMgt9mmF7bbxxt6IThSEuhc8ic=
=D/c6
-----END PGP SIGNATURE-----

--Sig_/VP/ge4m0D4p08_w=ity.hXK--
