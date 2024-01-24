Return-Path: <linux-pm+bounces-2670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C683A70A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1FB2921C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE817741;
	Wed, 24 Jan 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1GgWZHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341E156E4;
	Wed, 24 Jan 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092910; cv=none; b=opIDwRtGKnpyz9JV2Lc9K4vPJ3R+pS0hboc0HpjsqctXYOfhL7a6NRPEEBn43wZvMxZ1DJrUIkuwOLaKd/VO/nEpzkMC44WgDNovS0d+LQLxk5E0uxeVKLgY/ytUa8iVDv4aqS05oXxPtl/+cgKEGza8u/XycjGfSXcvO1GhERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092910; c=relaxed/simple;
	bh=VOpDAR9/icTczlTjQajuoNH5r9cQnm2A3HLZ4/ljiH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf9XGTfh979+o9LreXI27pB5dnAWEjv2aeDg/Ji07mI06IdUxeLauztye0OWpzJlKj8v9t5vyKdm44XScCV4lxk+sfk04mX/OvoedGlLxHUu3Oiq5COIpNq42hTcLSmxX5XqIsVrk1Mib/+crcyUDVBakQ9udZn23QnXnGzl8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1GgWZHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C60FC433F1;
	Wed, 24 Jan 2024 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092909;
	bh=VOpDAR9/icTczlTjQajuoNH5r9cQnm2A3HLZ4/ljiH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1GgWZHoF5aagXH8LM3/qmVZcLHTpf3nuAcKhCO2CJ5XS9CtMmON+YJJ981hOWzPP
	 ynWgxAeFw/t+RdPAfqdFGUZeioKgrqT4u5a0hohn1m240nsK9txmPiD0vM+P9vfmdK
	 3K0j+HccPkkm28VLqFkm1APJP59Pq/ZDH8Lgmm+0+QihEx4ACWrQZq8rTzE8Q2FwS2
	 7AEJy6N4E5L3GeCs3Fitn7TUjtg59KQtaKMcXldSyetWEVmN2nqaOqbk93J7og14Vu
	 cvwQ5gRaDGzV0xQqfS1RN0UvhL/S9q1xmKi4agMmZaAvSpTqFDuAEjKEHCiCXMFtrz
	 mgwTz4qA+BRqg==
Date: Wed, 24 Jan 2024 11:41:46 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/15] clk: renesas: rcar-gen4: Add support for FRQCRC1
Message-ID: <ZbDpaijWZ-yVWMz1@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
References: <cover.1704726960.git.geert+renesas@glider.be>
 <b7ec45c86c2bd17cf3b3de43194c4821b606e483.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZLw8yXuJlwt3Ol4k"
Content-Disposition: inline
In-Reply-To: <b7ec45c86c2bd17cf3b3de43194c4821b606e483.1704726960.git.geert+renesas@glider.be>


--ZLw8yXuJlwt3Ol4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:46PM +0100, Geert Uytterhoeven wrote:
> R-Car V4H and V4M have a second Frequency Control Register C.
> Add support for this by treating bit field offsets beyond 31 as
> referring to the second register.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested by enabling CLOCK_ALLOW_WRITE_DEBUGFS and checking the impact of
> CPU core clk rate on CPU core speed on R-Car V4M.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ZLw8yXuJlwt3Ol4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw6WoACgkQFA3kzBSg
KbYebhAAoNEvcdLcz/baTtGkYrjktAOc54NysQPel8cyihNfSbvLgNXFwa//gR/G
rlYBhpRRt2AoU+l6UqE13XfRAp2bupQ9lyoR5gcK5C1RbKE7BljT4pATJDTM5rD4
1iFXFgtufkDF9i8TASIctVot9cCTEnhiCJNOT/Z9tAj2z8RDUVbmzpSLrAX3azLD
MjAxn+LpjB5hAn2ZvdtG/FiFnm1UlJ4DZT7fuZ2UjRLLHNIw7ZTAi30tAjSWcupp
zfJ7F4nDr4O/k+aX5GrNfCWAoVeNEHg2V3RcHJp3IYp201LDadmwPRMU3804muHU
8Ua7VP1hrGdirjRV5G7mI0t6hO7H1tOV1hRvPCQ4EdrNX9BqstqHlOl54BzldzxL
uVzNk5nZu0QXPbo+yVFXzInyIZURqXRJeLfpFvOsW4DpcvKNbJuDwN++O2jL9kkp
1OmlVDCGDLB77Q1tLr6Po43ATOSkoCGaPVzSrfNM9n+hk8y5rPqYOcQKe+WzR5bp
9K7duierjlqmAHCC4gkLtCkky63R8Z8OILkoGCZKX+pXoebPby/KWT6emV+7uG4i
1IOXXnkDbhuR0OWtqSXZOITpq0hSTgw6Ud/P6dtpZ+P0kypjd7Cmim/XjIt3CQrX
+cLcCyKTI3D4nQxMDxCM1qkgINRtVHlkEt4Wg3On58xFuaCZ45I=
=QjEk
-----END PGP SIGNATURE-----

--ZLw8yXuJlwt3Ol4k--

