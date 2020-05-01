Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A51C124D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgEAMiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728742AbgEAMiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 08:38:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC4C061A0C;
        Fri,  1 May 2020 05:38:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BFC212A2F61
Received: by earth.universe (Postfix, from userid 1000)
        id 069B93C08C7; Fri,  1 May 2020 14:38:50 +0200 (CEST)
Date:   Fri, 1 May 2020 14:38:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/11] power: charger-manager: don't write through
 desc->properties
Message-ID: <20200501123849.ws2a5ybeeej6phyr@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <a529e64edb81a4795fe0b6480f1e4051bed1b099.1585944770.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unb3rd3vc4hlpfj7"
Content-Disposition: inline
In-Reply-To: <a529e64edb81a4795fe0b6480f1e4051bed1b099.1585944770.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--unb3rd3vc4hlpfj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2020 at 10:20:31PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> psy_desc->properties will become pointer to const.  Avoid writing
> through the pointer to enable constification of the tables elsewhere.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

For patches 1-3 I used my version, that I wrote in parallel while
reviewing a different patch series. It is slightly different, but
achieves the same goal.

-- Sebastian

--unb3rd3vc4hlpfj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sGFkACgkQ2O7X88g7
+ppqkhAAhISHuB7ilFWN8oIoGCZjUnTRVcSXFZEcfsKXphhTwrsx+4KKMN6akRCF
1KtmCRY0tcnBUnaeOSSfSoRU2blqGngUfd01Hp0Yl9X7R2W0QRC45o6A+AZ6i1Y3
uFZYsdIz3O0oq682X5KAcMrZO7eXZWySZtljUqjoNsUrAdUqFw0Mi+A9XOZtcZLC
WhB3ZFuh9NwDhb9DF4zxECiE9CgXcukeyOk94i/HbbpFZLi7YhDJyqnIkWBhdc/L
M72qaQLXov1ftz7SeDydcNDwYiU76Ue0Kc4EJuUYmtpL5eqi6Rs8ICDTCu3ujnCC
lJHaiQfLAPs527fMkULo+FFcsO7gKoEUkGqXuEGRXoyKh/CSg1U9OCMCkPAEeBnu
vblE5fj2Pe9ocsLOUZFGhFvafivE6J3sAw/nvuwPvmUgVF+3nuafUfwdc0b6b7af
r0bM9uSwwYUQ6kpTFNTIAOrE6+610zwAyfpwj51ko7xPmnEotMxW6elru4AG/WXz
OT5ZT/M9aQysPMrn3Qztc+Z0vqkFmS2nz8UxM+D8grw+S5BF6UKUEOrNaHn0iJvf
2kw2wP0oGbcJTVf/ITZqSyi79vmxK5bYfAXSQtxxfQ8sGzSW+x2/+PKq8+HNC5ay
cBC561G3JUR61YN4ZgS87Z0t96khXCls2vTZ7QS6CKktUGSMj5k=
=FVQh
-----END PGP SIGNATURE-----

--unb3rd3vc4hlpfj7--
