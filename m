Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E61B250
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfEMJHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 05:07:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37455 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfEMJHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 05:07:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E0B2B8041D; Mon, 13 May 2019 11:07:34 +0200 (CEST)
Date:   Mon, 13 May 2019 11:07:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20190513090743.GA19319@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
 <20190513075641.1277716-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190513075641.1277716-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-13 09:56:32, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Rob Herring <robh@kernel.org>

Who is expected to apply this? I don't think more iterations will make
it better... it seems pretty good already :-).

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzZM98ACgkQMOfwapXb+vLqCACgoz/AzQEDWexNUzu1UVpUEYwa
+xUAn2G+pCRs436J1QAIEWF1YTJJGCk2
=o77A
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
