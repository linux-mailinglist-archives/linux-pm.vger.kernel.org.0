Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089124323C9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJRQ1p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhJRQ1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 12:27:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AAEC06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 09:25:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0AAD21F42F6D
Received: by earth.universe (Postfix, from userid 1000)
        id 9CD483C0CA8; Mon, 18 Oct 2021 18:25:29 +0200 (CEST)
Date:   Mon, 18 Oct 2021 18:25:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] power: supply: axp288-charger: cleanups + fixes
Message-ID: <20211018162529.ryoq2xu3g6um3gqs@earth.universe>
References: <20211018135053.213310-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3spedfjxntaaaw3"
Content-Disposition: inline
In-Reply-To: <20211018135053.213310-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w3spedfjxntaaaw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 18, 2021 at 03:50:50PM +0200, Hans de Goede wrote:
> Here are 3 patches for the axp288-charger driver which apply on top of
> commit ed229454856e ("power: supply: axp288-charger: Optimize register
> reading method") in linux-power-supply/for-next .
>=20
> The first patch is a build fix and the other 2 are 2 small cleanups.
>=20
> Regards,
>=20
> Hans
>=20
>=20
> Hans de Goede (3):
>   power: supply: axp288-charger: Add depends on IOSF_MBIO to Kconfig
>   power: supply: axp288-charger: Remove unnecessary is_present and
>     is_online helpers
>   power: supply: axp288-charger: Simplify axp288_get_charger_health()
>=20
>  drivers/power/supply/Kconfig          |  2 +-
>  drivers/power/supply/axp288_charger.c | 37 +++++----------------------
>  2 files changed, 8 insertions(+), 31 deletions(-)

Thanks, queued.

-- Sebastian

--w3spedfjxntaaaw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFtn/IACgkQ2O7X88g7
+przKQ/9EjmP8djlTOrSyqoykugHImZbotXLVgPizlVLpFsuAW/zJTMiZxeeU3NX
ppBf8reepNcuoR1zF3LLCB4UltgvnP4IvpR4l4EOYTV1V6UjbBQCxBtM2NjXnDIm
YjP37wPAtiOzvaiHvVDdbKkpFn5xbVgfgQdr0h/OKHpNDwVIb9OzszOOjgWzGU4I
mddE/gNQbJF1FtdFkQmxDdR8CQb48T/S++H9sD1mssEbqp5PketZKWK31QeIO3gf
Ugx7Mo0bGK9Gwg6m+jaWgyWEtaSg7dkBZcjACTJME8AUNfwO4+xHa5QsUM66xrih
QuO6n6UtRN5qTQhRYORKKAFiin1yMpjn02phQH/zmx1vmQpJwCvX1te+DGEhX9XP
X9WAJghcnGRJMIoIAVjwvJSwcM1p2ZM22sog+c4COPmI4pFZxnyLmceJNQ61UGtf
wTSGSDQoZXgKr/2twliqKgDP6dV2LTbAougSGPv/s1mCcWUzcONo/BOtviTZ+v5/
1WippROptQxOdwvvI3U6p0Tty9xQcYh/4O0rL2LRliVitTom1VPq8GX3q/iSpO+k
vuEOpObZOH33Lo3S++SAsLRwCaJgbojdqbYmHEZd05LwhN+Psest7eitHfGm4lYg
vgGYjwGhSn1neWLuls36HmcPTot258IjaTrJ1N5hD8yKuiXxSc0=
=nVgE
-----END PGP SIGNATURE-----

--w3spedfjxntaaaw3--
