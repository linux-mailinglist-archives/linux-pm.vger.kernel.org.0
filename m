Return-Path: <linux-pm+bounces-651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F3802348
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921D31F2110C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B91BE60;
	Sun,  3 Dec 2023 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi/JfyVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9D9473;
	Sun,  3 Dec 2023 11:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C47C433C7;
	Sun,  3 Dec 2023 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701603791;
	bh=9AmAExZTT0E8gSkeYl4/8vj3YGEGHEeebEe4KpaBne4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gi/JfyVyzJ0rE4i9QOSZe/dUMF56zu89IKsDD7ODQJX2KSWMl5CpEqydezQmqsBc7
	 Vty5xatyeZdoz+KlDZQnsBWeSjMTVInIU4TzC7gCD3mWnl84MlrGE7lmQ/e73Ad3Ug
	 ZJr0cEr2eCKB0QtCArIcTGijUzkfEjtlVbAfI6wH+FC3bz9HUazAWkfo7h58LBdwd+
	 f/iET0uMKW9Ff6Vlv7Oee5c4BMeoAiDg4a6bOdhgp2tUvLC4MwthxWsshLyZ3mXv44
	 5x1I0+v2EQpdFUxrT028TSh/yv0GzPU5BlvZrXYuxKzBbSvfo7qKkEbhK/YlJLCkX3
	 dRHMzegQmfdkw==
Date: Sun, 3 Dec 2023 11:43:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Convert DA906{1,2} bindings to json-schema
Message-ID: <20231203-unthread-suffering-411df4cb0f4c@spud>
References: <20231203113159.92316-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zzVAK3BzRdnge7Et"
Content-Disposition: inline
In-Reply-To: <20231203113159.92316-1-biju.das.jz@bp.renesas.com>


--zzVAK3BzRdnge7Et
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 11:31:48AM +0000, Biju Das wrote:
> Convert the below bindings to json-schema
> 1) DA906{1,2} mfd bindings
> 2) DA906{1,2,3} onkey bindings
> 3) DA906{1,2,3} thermal bindings
>=20
> Also add fallback for DA9061 watchdog device and document
> DA9063 watchdog device.

Horrible timing, you sent this after I started looking at the previous
revision of the patchset :( I left some comments and tags on the
previous version which I would imagine that some of them also apply
here.

>=20
> v2->v3:
>  * Updated Maintainer entries for watchdog,onkey and thermal bindings
>  * Fixed bot errors related to MAINTAINERS entry, invalid doc
>    references and thermal examples by merging patch#4.=20
>=20
> v1->v2:
>  Ref: https://lore.kernel.org/all/20231201110840.37408-5-biju.das.jz@bp.r=
enesas.com/
>  * DA9062 and DA9061 merged with DA9063
>  * Sorted the child devices
>  * mfd,onkey and thermal are pointing to child bindings
>=20
>=20
>=20
> Biju Das (11):
>   MAINTAINERS: Update da9062-watchdog bindings
>   dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
>     watchdog
>   dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
>   dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>   dt-bindings: mfd: dlg,da9063: Update watchdog property
>   dt-bindings: mfd: dlg,da9063: Update onkey property
>   dt-bindings: mfd: dlg,da9063: Sort child devices
>   dt-bindings: mfd: da9062: Update watchdog description
>   dt-bindings: mfd: da9062: Update onkey description
>   dt-bindings: mfd: da9062: Update thermal description
>   dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
>=20
>  .../bindings/input/da9062-onkey.txt           |  47 ----
>  .../bindings/input/dlg,da9062-onkey.yaml      |  60 +++++
>  .../devicetree/bindings/mfd/da9062.txt        | 124 ----------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 221 +++++++++++++++---
>  .../bindings/thermal/da9062-thermal.txt       |  36 ---
>  .../bindings/thermal/dlg,da9062-thermal.yaml  |  78 +++++++
>  .../watchdog/dlg,da9062-watchdog.yaml         |  12 +-
>  MAINTAINERS                                   |   6 +-
>  8 files changed, 336 insertions(+), 248 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.=
txt
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-on=
key.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
>  delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-ther=
mal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-=
thermal.yaml
>=20
> --=20
> 2.39.2
>=20

--zzVAK3BzRdnge7Et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxpyQAKCRB4tDGHoIJi
0l42AQDnWMEWPdUfCAwhRas6WCnOuUPuc6ZtX0mWYXUe/vuD/wD8DgLeHrMNFJEd
AJaeOfdEOnoTE0oR2tHjToYrOumSjAM=
=PJLz
-----END PGP SIGNATURE-----

--zzVAK3BzRdnge7Et--

