Return-Path: <linux-pm+bounces-25280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4BA8631B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9D11BA0897
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CF21B905;
	Fri, 11 Apr 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUDwvmlm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CE1DE2DB;
	Fri, 11 Apr 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388529; cv=none; b=KW6T93NL9QEO1TNHU/FEn/jBXF1j8PgaaVyzXLVCSnDAIwvRc0mvkPvbxd4We68pZq24ig4gjhDyd5laZT0RlFga7W0bXrFYUCEpzD//Y3WKuH8Pm7178xkxv56eBD+kSF/GwwVhO4Ajoopxi9GQhOsGSyIerVdu2240uS3oQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388529; c=relaxed/simple;
	bh=wzAQATy54vCpkwt37K9i8fVvLuJ9F3HtOZNJF5NfmuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHKEb5SXA+J8bcWDhGZhDLdzdr2JfB8X8wzNkp4go7CQelGiyx6i1+743QCUuS61VECelSF+8qlo45JYgLzOAuwC8XdPkYSKsRg2rhyP2srBIJkfPMdY0iiJ36DDNUDBxEwH3Gagn+sOfu096j+p42/EPYBwnFIQdi5gIOxKerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUDwvmlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B53EC4CEE2;
	Fri, 11 Apr 2025 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744388528;
	bh=wzAQATy54vCpkwt37K9i8fVvLuJ9F3HtOZNJF5NfmuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUDwvmlmGNEOE6UiCuFajisN/+N0W4PsppgK3YKQxxblTRgJXcyGl2fDX3uKbdkJr
	 2+V+sMZvOsWOB80R99rxGcKZe/jhqzm0hntMRCAIy4yRtUp3Z4QdbvxGA5YqfA03A3
	 rYUgo1Y+GdFxYB1N83XbBdrM4GXSFVjUhy41gNQt4vi776Nz1z2pujd5vBTWwcchh0
	 LwBeY4i9+9HM515v7PIK0hiLxAtE6fjRjKg39JQ2sB/mENgOkt6gYw9FHfBK8gy26+
	 5tArMU4Hk5fUZbPjg7m9cwn4VJ8htSVvHAG7uy6YUzsnNBC5x0t8iefCYpo59D3X6t
	 SfC0haIi7PSxQ==
Date: Fri, 11 Apr 2025 17:21:58 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
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
Message-ID: <20250411-ebay-exerciser-392c42daf5ba@spud>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-3-63d7dc9ddd0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gXwATB6SbIWbLkFw"
Content-Disposition: inline
In-Reply-To: <20250410-dt-cpu-schema-v2-3-63d7dc9ddd0a@kernel.org>


--gXwATB6SbIWbLkFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:47:24AM -0500, Rob Herring (Arm) wrote:
> The "spin-table" enable-method requires "cpu-release-addr" property,
> so add a dummy entry. It is assumed the bootloader will fill in the
> correct values.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Tested-by: Daniel Machon <daniel.machon@microchip.com>

This is already applied, guess I forgot to merge it into the branch that
appears in linux next. I'll do that now..

--gXwATB6SbIWbLkFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lBpgAKCRB4tDGHoIJi
0h05APsEcaA5n4MeMUDF1Ullyde98iLkYYAFaHTFR+km537NdgEAxwuhCZvt2UZz
n9hkciE6jwyE29jkNaUkkhNiH534NAA=
=8lEZ
-----END PGP SIGNATURE-----

--gXwATB6SbIWbLkFw--

