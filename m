Return-Path: <linux-pm+bounces-37629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3191C40F61
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7942137F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F9332ED7;
	Fri,  7 Nov 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG1x+TTA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9C2C21EA;
	Fri,  7 Nov 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534726; cv=none; b=lKwiSwXLvn/s818wWNSF/4n8Y1xTx22lmjttdfwznCRmGZVAMN/nORnnvKAUSefVJHb5kQGieolb88m/ADRy/DMozlUuFApmARtRz7cD/LicStb/CqbOVDV7Qr6dMmiOUVlw5RROBS1lEd1piEW9xbRAD/b3QrEpfqcQsBNX4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534726; c=relaxed/simple;
	bh=Deg5hP1tnfyqQJxvp93MwJaREyzV5XSriYRCDYcaoIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avE3fuP95J+J/6SaQzrnV9scZmk7Vn785IHDNjJrXCauXClv8xOANgbzHEa61pbqHbgroqK9VRs73IlgOH6UGmQIIIAMA/ewqwYj9cpetXtG4APKDk67sGcxzlAkO6qG8WiXZDrRPv/eO8XxHOjdXPNZYrsuwEAiSycyTbHAk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG1x+TTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6264C116B1;
	Fri,  7 Nov 2025 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762534725;
	bh=Deg5hP1tnfyqQJxvp93MwJaREyzV5XSriYRCDYcaoIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG1x+TTAKKD/cyeabvnyLQecTtAkAoJJdfXtmDUm8y4WRJwTUuGfS1kSik8J3F0Ng
	 ltIw6btFhrVQVWmeGr2l5UxLm5IdNDaO1rPcBm1232Oxohl3Mwp+KeF5/hHO+mymBy
	 7TrK5Dnl1il/lZUrOS9g5Bph4wy9DNDEhePBGtYuHJryAlcE4i60yxGO0glFbIS88F
	 fmdw2CUEV6Bvobj4VvUnWGwoeBpx5A1HE2dYzDRXHPQpiAIGssEQ6yi/7jrG8c9voT
	 C+Xj2YNNwOtzX0gUk5GA442O5BfZl3ULta/AU5KWYtthWMy6gZ0A7FnVsbP040WX98
	 zB7gyNcFs5ERQ==
Date: Fri, 7 Nov 2025 16:58:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	"irving.ch.lin" <irving-ch.lin@mediatek.com>,
	linux-kernel@vger.kernel.org, sirius.wang@mediatek.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, netdev@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, jh.hsu@mediatek.com,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Qiqi Wang <qiqi.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	vince-wl.liu@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 02/21] dt-bindings: power: mediatek: Add MT8189 power
 domain definitions
Message-ID: <20251107-fabric-handbook-fa4aea68e64e@spud>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-3-irving-ch.lin@mediatek.com>
 <176243607706.3652517.3944575874711134298.robh@kernel.org>
 <20251106-spearhead-cornmeal-1a03eead6e8a@spud>
 <20251107-polar-satisfied-kestrel-8bd72b@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T8z4/ZRRt2Y/34dZ"
Content-Disposition: inline
In-Reply-To: <20251107-polar-satisfied-kestrel-8bd72b@kuoka>


--T8z4/ZRRt2Y/34dZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 08:26:34AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 06, 2025 at 05:17:39PM +0000, Conor Dooley wrote:
> > On Thu, Nov 06, 2025 at 07:34:37AM -0600, Rob Herring (Arm) wrote:
> > >=20
> > > On Thu, 06 Nov 2025 20:41:47 +0800, irving.ch.lin wrote:
> > > > From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > > >=20
> > > > Add device tree bindings for the power domains of MediaTek MT8189 S=
oC.
> > > >=20
> > > > Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > > > ---
> > > >  .../power/mediatek,power-controller.yaml      |  1 +
> > > >  .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++=
++++
> > > >  2 files changed, 39 insertions(+)
> > > >  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power=
=2Eh
> > > >=20
> > >=20
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >=20
> > > yamllint warnings/errors:
> > > ./Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml:=
25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> >=20
> > pw-bot: changes-requested
>=20
> I think this was bot's false positive - that's a different file, not
> changed here. The patch seems fine.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Oh dear, my bad! Good thing I sent the mail, so you noticed, rather than
just setting the status in patchwork. I saw "mediatek,mt8189" and read
nothing else in the error, I suppose.

--T8z4/ZRRt2Y/34dZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4lOwAKCRB4tDGHoIJi
0sKSAPwKZVe3dwNNrDJA98CxIbR5p1CvuU/zHuxccA9twIforwEA80yya84iofrG
AhtlRaBMllXkasNygF6wjSxLj+4AYwU=
=hCrv
-----END PGP SIGNATURE-----

--T8z4/ZRRt2Y/34dZ--

