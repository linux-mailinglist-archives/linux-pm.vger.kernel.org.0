Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9CDA6AE9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfICOMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 10:12:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57584 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfICOMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 10:12:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 80B2A81FA1; Tue,  3 Sep 2019 16:12:35 +0200 (CEST)
Date:   Tue, 3 Sep 2019 16:12:48 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Biwen Li <biwen.li@nxp.com>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] soc: fsl: add RCPM driver
Message-ID: <20190903141248.GA8354@amd>
References: <20190821031537.46824-1-ran.wang_1@nxp.com>
 <20190821031537.46824-3-ran.wang_1@nxp.com>
 <DB8PR04MB6826A9EA5D9232D55FE8BDEFF1AA0@DB8PR04MB6826.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6826A9EA5D9232D55FE8BDEFF1AA0@DB8PR04MB6826.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +	/* Begin with first registered wakeup source */
> > +	ws =3D wakeup_source_get_start(&idx);
>=20
> Since I have mad some change in this version, could you please take a loo=
k on this.
> If it's OK to you, I would re-add 'Acked-by: Pavel Machek <pavel@ucw.cz> '

I'm sorry, I'm a bit busy at the moment and this is not really my
area.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1udOAACgkQMOfwapXb+vLLrwCgprpkyPdWIRm3F6Lv4rV9h5Vg
zkUAnRa7EWL6E5/thkcXz87A7zdQUWUB
=oBPe
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
