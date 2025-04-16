Return-Path: <linux-pm+bounces-25568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D2A909A2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 19:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7785C17766F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94C2163BB;
	Wed, 16 Apr 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM4S1zuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5731FB3;
	Wed, 16 Apr 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823408; cv=none; b=obn4QgQ4n6faI+XczFtmtKNmAUd92eGqOev4nRwKPei/konXBMB51gix+vYaYBNihdgdYyI2PaRVp8WixiMvZsoF6ykVHZX/c1FlbBdw8hNXDXD69YKScacEROYSXQci8NIEvbvMCdx0TYJZ2/l0qnm3eU/3LDud4JvkYhbmPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823408; c=relaxed/simple;
	bh=GPxndeQcjZergwFORB/Rw0fwEw6OdehK/PoVumpiwhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWgdAzZRCLB7uSeFVrN2IFlNN/uPunnyuTi1hOXyFRjPDw4RcgkbWxzHu0IuLh8KYiqoA+n9ovPzFgHr3u7NVM+ckeC3swOdUWKSIfW2f77kZ90rWS97+U8TwIjioq4ieqlRLQ4Lb7YMdo4NJfb2I62v4AckyJBTpvbgfKzm2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM4S1zuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FCAC4CEE9;
	Wed, 16 Apr 2025 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823408;
	bh=GPxndeQcjZergwFORB/Rw0fwEw6OdehK/PoVumpiwhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM4S1zuQEMQqhg2E5490EGSvOLlPkmXfO2/a8rsiW5raOTdT+AwSP80ZxxgBfjFB7
	 ICdW04snQBopqh9TxyLVT4jadJgjt6ZtaqQXIh0ltP3FEe1cSnqE0C7HOu92UbDbmj
	 RPMcHm/Pq7mYU8EUndI6VL1iQOwW1ppCgmIa6aK8UF7S2VoXOIe1rkyYPvpOCGneMg
	 qhhmwGDAxM7P7Lu8JqI9TgwmZqZXWnOM4X2iGbG4VsTRFFdfUGneP0TVe+MtviiiTx
	 LK8o3F7FzDZKaW7dmM9iwfKqLE8tS4dE+90kDIOecLPdiWibowhbWrqwmXtecC3upw
	 pM+Lq5HNfBYIg==
Date: Wed, 16 Apr 2025 18:10:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] dt-bindings: firmware: thead,th1520: Add resets
 for GPU clkgen
Message-ID: <20250416-bootlace-fossil-08a975327973@spud>
References: <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
 <CGME20250414185315eucas1p1fae2d6250bfd30b12bb084e197c02948@eucas1p1.samsung.com>
 <20250414-apr_14_for_sending-v2-2-70c5af2af96c@samsung.com>
 <20250415-tycoon-naming-20ba5a55c469@spud>
 <fe445d04-b488-4f11-a14d-9dfda07e3e88@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCmZpeXQvPDx/gRW"
Content-Disposition: inline
In-Reply-To: <fe445d04-b488-4f11-a14d-9dfda07e3e88@samsung.com>


--tCmZpeXQvPDx/gRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 01:40:15PM +0200, Michal Wilczynski wrote:
>=20
>=20
> On 4/15/25 18:38, Conor Dooley wrote:
> > On Mon, Apr 14, 2025 at 08:52:56PM +0200, Michal Wilczynski wrote:
> >> Extend the TH1520 AON firmware bindings to describe the GPU clkgen res=
et
> >> line, required for proper GPU clock and reset sequencing.
> >>
> >> The T-HEAD TH1520 GPU requires coordinated management of two clocks
> >> (core and sys) and two resets (GPU core reset and GPU clkgen
> >> reset).  Only the clkgen reset is exposed at the AON level, to support
> >> SoC-specific initialization handled through a generic PM domain. The G=
PU
> >> core reset remains described in the GPU device node, as from the GPU
> >> driver's perspective, there is only a single reset line [1].
> >>
> >> This follows upstream maintainers' recommendations [2] to abstract
> >> SoC specific details into the PM domain layer rather than exposing them
> >> to drivers directly.
> >>
> >> [1] - https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc=
@imgtec.com/
> >> [2] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@ker=
nel.org/
> >>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  .../devicetree/bindings/firmware/thead,th1520-aon.yaml        | 11 ++=
+++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-a=
on.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> >> index bbc183200400de7aadbb21fea21911f6f4227b09..6ea3029c222df9ba6ea7d4=
23b92ba248cfb02cc0 100644
> >> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> >> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> >> @@ -32,6 +32,13 @@ properties:
> >>      items:
> >>        - const: aon
> >> =20
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  reset-names:
> >> +    items:
> >> +      - const: gpu-clkgen
> >> +
> >>    "#power-domain-cells":
> >>      const: 1
> >> =20
> >> @@ -39,6 +46,8 @@ required:
> >>    - compatible
> >>    - mboxes
> >>    - mbox-names
> >> +  - resets
> >> +  - reset-names
> >=20
> > Given these are new required properties, have you made sure in the
> > driver that their absence will not cause problems with older
> > devicetrees? I took a brief look at the driver, and it _looked_ like you
> > were failing if they were not there? It was a brief look though, tbf.
>=20
> Hi Conor,
>=20
> Good point =E2=80=94 but in this case, the devicetrees compatible with the
> driver haven=E2=80=99t been merged upstream yet. In fact, the TH1520 PM d=
omains
> driver currently doesn=E2=80=99t even compile against mainline, since the
> required commit [1] didn=E2=80=99t make it into 6.15.
>=20
> That said, Drew has queued the DT changes for the next release [2], and
> you=E2=80=99ve queued [1], so assuming this series lands in 6.16, there w=
on=E2=80=99t be
> any older devicetrees to support. As a result, I haven=E2=80=99t added a
> fallback path in the driver for missing properties.
>=20
> If, however this series doesn=E2=80=99t make it in for 6.16, then yes =E2=
=80=94 we=E2=80=99d
> need to revisit the driver and add a failure safe path for cases where
> these properties aren=E2=80=99t present.

Can you point this reason out in the commit message please?

--tCmZpeXQvPDx/gRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ//kaQAKCRB4tDGHoIJi
0tq6AP49djHUQH5jaiCOowqiJpYaVCgG0kyxv19IckXOxtg97wEA6PYTFj/uiYGX
nT4CK+hS2GP7lCkMqKeI3oidnhm9Uw8=
=D2g7
-----END PGP SIGNATURE-----

--tCmZpeXQvPDx/gRW--

