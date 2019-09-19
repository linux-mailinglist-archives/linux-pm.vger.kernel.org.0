Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F050AB75A8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfISJFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:05:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38935 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfISJFl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:05:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 64BED812CD; Thu, 19 Sep 2019 11:05:26 +0200 (CEST)
Date:   Thu, 19 Sep 2019 11:05:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/3] power: supply: cpcap-charger: Limit voltage to 4.2V
 for battery
Message-ID: <20190919090539.GA9644@amd>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20190917213501.16907-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-09-17 14:34:59, Tony Lindgren wrote:
> From: Pavel Machek <pavel@ucw.cz>
>=20
> There have been some cases of droid4 battery bulging that seem to
> be related to being left connected to the charger for several weeks.
>=20
> It is suspected that the 4.35V charge voltage configured for the battery
> is too much in the long run, so lets limit the charge voltage to 4.2V.

4.35V is known to make lifetime of battery shorter, but it provides
10% more capacity.

Disadvantage of this approach is that if droid is rebooted between
mainline and android, battery will go 4.35V->4.2V->4.35V... while on
charger.

I guess this patch still makes sense, I just wanted to make sure
disadvantages are mentioned.

Best regards,
								Pavel

> @@ -457,7 +457,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>  			max_current =3D CPCAP_REG_CRM_ICHRG_0A532;
> =20
>  		error =3D cpcap_charger_set_state(ddata,
> -						CPCAP_REG_CRM_VCHRG_4V35,
> +						CPCAP_REG_CRM_VCHRG_4V20,
>  						max_current, 0);
>  		if (error)
>  			goto out_err;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2DROMACgkQMOfwapXb+vLdGwCeLi8jUurAcxB4ZsufCG6/ZVWM
YXwAnj7KufmESQZDqN+D8N71Ktb04lR0
=cFLG
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
