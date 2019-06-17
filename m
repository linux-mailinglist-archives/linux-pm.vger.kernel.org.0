Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E116A4898C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQRDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 13:03:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQRDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 13:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YCw5ZGqGwDO2jRR4SKrGPJxH9VYTLoFjpJ0IDkR4FtQ=; b=XswRJ/R50SFktB+oheI64colW
        YsD42tCs10vzDTouy2DDJI11BUaSItpL1SPF24/rX4cygyIcmS+tbQXESWRiY+zd+IoKFFJYYFK6X
        OCc6MN+TKGi1WCfQPlXOCOhlpD+3IiyTarnA3PV5Gr/ceX5gyAatnSy3neQw7tP2kqs/o=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcv20-0002GR-3Z; Mon, 17 Jun 2019 17:02:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 4F2BB440046; Mon, 17 Jun 2019 18:02:55 +0100 (BST)
Date:   Mon, 17 Jun 2019 18:02:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617170255.GF5316@sirena.org.uk>
Mail-Followup-To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
        lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
References: <20190615163314.28173-1-andreas@kemnade.info>
 <20190617103111.GM5316@sirena.org.uk>
 <20190617130357.41204ff7@kemnade.info>
 <20190617114048.GN5316@sirena.org.uk>
 <20190617182743.7f40f2ee@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO+9/CRZBGNspxuY"
Content-Disposition: inline
In-Reply-To: <20190617182743.7f40f2ee@aktux>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SO+9/CRZBGNspxuY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 06:27:43PM +0200, Andreas Kemnade wrote:

> Citing tps65950 trm page 55:

> The device contains three switch-mode power supplies (SMPS):
> =E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in=
 steps of 12.5 mV)
> =E2=80=A2 VDD2: 600-mA buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in=
 steps of 12.5 mV, and 1.5 V as a
>    single programmable value)

> you are right, they are not really continuous. So should I add these
> 68 steps they have as a voltage list?

There's helpers for linear mappings, you should be able to use those
(see helpers.c).

> I think they are nearly continuous, so we should IMHO rather take that
> not that strict. I guess there are no really continuous regulators, all
> have steps as voltage is specified in a limited resolution. So what is
> the exact meaning of that flag here?

This was added for devices with extremely high resolution interfaces
like some microcontroller interfaces that take voltage values directly
(mirroring the regulator API) or PWM regulators - it's for cases where
enumerating all the voltages is unreasonable.  The TWL4030 regulators
look fairly standard in comparison.

--SO+9/CRZBGNspxuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hx74ACgkQJNaLcl1U
h9CWNQf+MwgfRdIW7BcriKWVMF03v0jco6sVD6U8CVZVFsKKZcsnzI2Y68Z90jGL
guU08JDMRePIz7mPhlBSLqwvOIAa7oF3difVoepvu5vyNmckQho4IBpja827vHLY
w7zeVoEE1GIA2X9r4SjY5d0NHVSdfbAkEGXkJCyRvJE+COGUVw2btMe42st8Yh0F
qud88Wj7O1RCHzFmSzK0Q2nIbXSKNzHk7vi6spYUU9TdbloMtiGny7kG9Fto37Kf
wUqHzHHJRCI9KToy7AR3M3Oy1FdmuR8GBnmDcb+Js0kGMmDvcP9+7L7gGZkZV+Pq
hwbZETb/MHtSj7MqotPchV9n1Y0wIA==
=cjH3
-----END PGP SIGNATURE-----

--SO+9/CRZBGNspxuY--
