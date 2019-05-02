Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACB11704
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBKPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 06:15:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50591 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEBKPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 06:15:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5591E80407; Thu,  2 May 2019 12:14:51 +0200 (CEST)
Date:   Thu, 2 May 2019 12:15:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Message-ID: <20190502101500.GA23980@amd>
References: <20190502074305.GA6039@vostro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20190502074305.GA6039@vostro>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> There is no need to keep sysrq_poweroff_op after initialization, so mark
> it with __initdata.

Are you sure?

pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
pavel@duo:/data/l/k$


									Pavel

> =20
> -static struct sysrq_key_op	sysrq_poweroff_op =3D {
> +static struct sysrq_key_op sysrq_poweroff_op __initdata =3D {
>  	.handler        =3D handle_poweroff,
>  	.help_msg       =3D "poweroff(o)",
>  	.action_msg     =3D "Power Off",

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzKwyMACgkQMOfwapXb+vLMRgCfdk7iKvloiJkSvH+FPrpjTsra
ZCcAn22sx6lE/WSXjd2YF0EmcFQamlbF
=vw8d
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
