Return-Path: <linux-pm+bounces-25383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD5A88949
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B091893A1B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3F2820D6;
	Mon, 14 Apr 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haXXUUQ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B04539A;
	Mon, 14 Apr 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650165; cv=none; b=FBRCHYgh8EJvnuLCAMHLhGvmV0pSj9ohVqoIz7zZWk9nSnx/wCcD49X2PsJUbM5KVN20v3c+zjp2eJjb8quDNExj4Qaq1i+ShD9FV8tW7apxge0ROVaGlHhtF3MS6MPz5Mrc9jKoL8i+tEfn4DSW3u0Lmn4e/Hd+R2poWqzfr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650165; c=relaxed/simple;
	bh=KqFT3PKAxBM7aneYNA4QM0R7Gd1DemUhbyEfOOJZdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghxVq4wfI9T/VpgrrQGHQ4EcZ6hXTesPpkVkT5G+1EJo1y6TDFT15KIhdF58v0UVv7YA+eKu6o4NP0UfDbl6TFM09v8etH55NAbK8lbB1PXKUZI7jkBzuKVVgJvnHNSk08DB0NyLncxbi4fcHgEQ3obX4jtDcEreSX6OjjxGcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haXXUUQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD4FC4CEEB;
	Mon, 14 Apr 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744650164;
	bh=KqFT3PKAxBM7aneYNA4QM0R7Gd1DemUhbyEfOOJZdwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haXXUUQ5j7/xdMK6YjwHt6lr9C50Nl/g7bFmEYMZvNiz+gF0wIYn0k0JlsN7AgIIr
	 4iu+74zlC0pGVbnny4GpZcvFCtRv7UbXiLj/Jktoz55Xw4OI0gFEF9IMr5JRkbS89a
	 FWUp+fMSf5UkmLfyLJ4Oh8mMhzRX4zRBtIyxizLmg1yK8LXnD6fzQ4a/5VdOID9XcX
	 dE75rVIJSiBbQRqIjkmlXD+Sz1tODj0aRj329Hqs8wN3tRMUOekPmkiQJuBXhlIRBs
	 zzEUQdKKdZxKbNiIRzd4lVHI7DTVE6ie+lpUtXY7UaT3cQKWd5+rfYxv5sIPEdod6N
	 ZZHwk4psw8ppw==
Date: Mon, 14 Apr 2025 18:02:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 03/17] arm64: dts: microchip: sparx5: Fix CPU node
 "enable-method" property dependencies
Message-ID: <20250414-fragile-same-9cd06114cd85@spud>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-3-63d7dc9ddd0a@kernel.org>
 <20250411-ebay-exerciser-392c42daf5ba@spud>
 <CAL_JsqJza-bufzjZ415THyDDQaOfk8F+JRFvFxzNwObG=NKVJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pt+1yttKuNYLWgzQ"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJza-bufzjZ415THyDDQaOfk8F+JRFvFxzNwObG=NKVJQ@mail.gmail.com>


--pt+1yttKuNYLWgzQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 03:26:50PM -0500, Rob Herring wrote:
> On Fri, Apr 11, 2025 at 11:22=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Apr 10, 2025 at 10:47:24AM -0500, Rob Herring (Arm) wrote:
> > > The "spin-table" enable-method requires "cpu-release-addr" property,
> > > so add a dummy entry. It is assumed the bootloader will fill in the
> > > correct values.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> > > Tested-by: Daniel Machon <daniel.machon@microchip.com>
> >
> > This is already applied, guess I forgot to merge it into the branch that
> > appears in linux next. I'll do that now..
>=20
> Sometimes I check next, but in this case I just looked at replies for
> which there were none. I dislike submitting dts changes because it's a
> range of AWOL maintainers, only applying around some rcN (so up to 2
> months later), silently applying, and applied but never in linux-next
> (until in soc tree).

Let's add "send the b4 ty email" to the list of things that I did not
do, but thought that I had done.

--pt+1yttKuNYLWgzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/0/qQAKCRB4tDGHoIJi
0llIAQCfeSIfGZefusGStXxy21uaJUGlki/H/XzQ1dq4t278oAD9GMv/CXNEj8CG
oPoSllLdscFoA/5qVRjJh0erPiNF8gA=
=q+yA
-----END PGP SIGNATURE-----

--pt+1yttKuNYLWgzQ--

