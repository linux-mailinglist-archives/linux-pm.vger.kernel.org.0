Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB537FB2A
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhEMQCv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 12:02:51 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60314 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhEMQCu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 12:02:50 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 262901C0B87; Thu, 13 May 2021 18:01:38 +0200 (CEST)
Date:   Thu, 13 May 2021 18:01:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: Switch to pr_xxx log functions
Message-ID: <20210513160137.GB19588@duo.ucw.cz>
References: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Switching to pr_debug et al has two benefits:
> - We don't have to add PREFIX to each log statement
> - Debug output is suppressed except DEBUG is defined or dynamic
>   debugging is enabled for the respective code piece.
>=20
> In addition ensure that longer messages aren't split to multiple lines
> in source code, checkpatch complains otherwise.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYJ1NYQAKCRAw5/Bqldv6
8jjoAKDCAf0bfCosCwpNYAfYM7ExTZ8KbwCfbqGkEyPdJ/bmJka4HFw+tSoVM44=
=lc0P
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
