Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888A94810B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFQLk4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 07:40:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQLkz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 07:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TGS1jJo4f0gqZ+d4CFQwjoWxEngjb1gvJrhJoe43XXw=; b=ZBwbG3Gn/ueMgLs/6/3z0n1QM
        507hzQfk0t9Zw1uJnlZeDzAPWNYDhAeo/UV94aOVTVW/5AywlPRBL02pEaEpoEFyUUdrxrGJh99mn
        Nrzcw971o/sV50QDOkFF03USVvyeXz4z1PhCPhdiQ1rV4M9BBGW0dKByZQECxSQ73jPf8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcq0H-0001VF-Pe; Mon, 17 Jun 2019 11:40:49 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0FA79440046; Mon, 17 Jun 2019 12:40:49 +0100 (BST)
Date:   Mon, 17 Jun 2019 12:40:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617114048.GN5316@sirena.org.uk>
Mail-Followup-To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
        lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
References: <20190615163314.28173-1-andreas@kemnade.info>
 <20190617103111.GM5316@sirena.org.uk>
 <20190617130357.41204ff7@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukZ3tWq1IjZw6zEx"
Content-Disposition: inline
In-Reply-To: <20190617130357.41204ff7@kemnade.info>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ukZ3tWq1IjZw6zEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:

> > Why is this a good fix and not defining the supported voltages?  These
> > look like fairly standard linear range regulators.

> I am fixing the definition of the two regulators in the patch.
> I am defining them as continuous.=20
> Voltage ranges are defined in
> arch/arm/boot/dts/twl4030.dtsi
> Only the continuous flag is missing.

> Is there anything else do you want to be defined?

These regulators are not continuous regulators as far as I can see, they
are normal linear range regulators and so should have their voltages
enumerable like any other linear range regulator.

--ukZ3tWq1IjZw6zEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HfEAACgkQJNaLcl1U
h9C9fgf/demCydc2jv+vdSyZVH8mb+/coXKQUhsJXvaspY3plQYlF5HnzQrABgHC
nFoahPYWwqbuRl4WzotNHAnblTLZz54cPzr+W89TPLVlfRLxKuF44I3807SJYW4f
+eh/7+cyOcyiA+eJba+PAG72l5oIkJszxNywvIDZENBjIc7exIxo5I8ee4zfTSoI
2uv7ZzaeVVrI/1j7SIuC2KlBhQ6j3qOPew1r0kpl66Q7zPNFf4AWzl2LbhjIuUVk
3BxJcetz+zA7NbCR2QIEr5o7vCnOuOLQQN8Dk1LNI4QxItF7MD0PXkSA33GCu8rD
uYW9FLSQK0YzKaeddERgm1nLLKkKYg==
=U7Iy
-----END PGP SIGNATURE-----

--ukZ3tWq1IjZw6zEx--
