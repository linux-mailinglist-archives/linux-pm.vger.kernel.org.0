Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35151166B0A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgBTXkP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 18:40:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51264 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 18:40:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 88DCC1C0141; Fri, 21 Feb 2020 00:40:13 +0100 (CET)
Date:   Fri, 21 Feb 2020 00:40:13 +0100
From:   Pavel Machek <pavel@denx.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/6] driver core: Fix
 driver_deferred_probe_check_state() logic
Message-ID: <20200220234013.GA1544@amd>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-2-john.stultz@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * If deferred_probe_timeout is not set (-1), it returns
>   -EPROBE_DEFER until late_initcall, after which it returns
>

You may want to complete the sentence here :-).

Best regards,
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5PGN0ACgkQMOfwapXb+vJMxQCgtQnWwo29Vvo9vP16H4Ght8IZ
9+gAoLwdTur5xCGAmWe/M/quEr4HK1t3
=eyDo
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
