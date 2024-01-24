Return-Path: <linux-pm+bounces-2677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F083A745
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4829B2AFAA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158F199C7;
	Wed, 24 Jan 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixOxMw5F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756019478;
	Wed, 24 Jan 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093589; cv=none; b=XVam+Z1HFeatYV4lxYd2nAuYrudCAyO4/s3lY6q64WYMDe5qoxKY2oayY8yV/zCEwDfsbrIPWoVDFQLetWBzOBv8paA5Sds3UfEV0MxN1bNhMndf5ZbIgT8Z6sdgoQ7zEkeiev9oIakYzqfhqli4E9KwjvurgDssPcGp2SzwPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093589; c=relaxed/simple;
	bh=fRgI8TKe4TKT/CoqSe6b8eZTQCRj+3aZnKViQg8ViUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZvohiZRqmoItiJVzUlzHLWDXKTvKqg3M5szZ77CYeRqq/AwA/odE46X7zjwxmrznPeNrV/YA57+FrzKx2YEUVMARiXk/3LJ0uQLqNhk/YXRETYdcR6kE/N6QvF/E4GFSBLbkYFMgv4LZvbEsXfCRT1idNyNlAj9FKEZ14Dr0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixOxMw5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE588C433C7;
	Wed, 24 Jan 2024 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093588;
	bh=fRgI8TKe4TKT/CoqSe6b8eZTQCRj+3aZnKViQg8ViUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixOxMw5FcDNAqJhnJyrgJmvMbZ1a5j6Aa5lWfeiyWmx6Ch/xgFkX166AtrluDWK/c
	 3gxEoXGl5KfF2eo8XKNkkn9FdNkATkEGcxV4Xt/4sgzGCRVZKhI4Qzye0a5QjTjZgX
	 GsCbuvU9/7yFHDwo0zichXRUK68Lty75ebKlSUueQPJr6t7ds8BDog97Pwq3iqU44T
	 S4WL9jlWOeKrlPz4vl9l6wUQjfdqjYo7YP9F1XLbWA6l/qoU7JLirvtUhNBs2c3zY0
	 BrRxzGf8OVQICKnEc9pjDm7lVuBbiNtBRJ8WLPVSPMOUxxJE26HGRv5EksXfcDYRfi
	 hcJkhJpFe75Mw==
Date: Wed, 24 Jan 2024 11:53:05 +0100
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
Subject: Re: [PATCH 15/15] arm64: defconfig: Enable R8A779H0 SoC
Message-ID: <ZbDsEU2z1C_4diTM@ninjato>
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
 <db4ab7b72dc2f40085f19957f93b5442ca391fd6.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJ2xvEoFeWU4mZ1F"
Content-Disposition: inline
In-Reply-To: <db4ab7b72dc2f40085f19957f93b5442ca391fd6.1704726960.git.geert+renesas@glider.be>


--bJ2xvEoFeWU4mZ1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:33:54PM +0100, Geert Uytterhoeven wrote:
> From: Linh Phung <linh.phung.jy@renesas.com>
>=20
> Enable support for the Renesas R-Car V4M (R8A779H0) SoC in the ARM64
> defconfig.
>=20
> Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--bJ2xvEoFeWU4mZ1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWw7BEACgkQFA3kzBSg
KbY/JQ/+PT+Y/iWQ+m3vrkErMMKgF415lb7D4ZbGmFGHODMFjNAD0FIJTffZ2fDo
q95UUvlxu3M2VQddneEB97ZsQWgZ+2szRyTrOogmbf3XEbgNY2rhkhbH3FR157u3
Jth6Ai6kvNvcYK5AjYyLLIvgyEfT2L8N8AVrmEAYiRaWhOAwSqnE8V4fesmR87Uy
8Tn4cSWklQggQG9AWQ9Q+3056ZctyHhUFmqXmFmaQ5ZVevrmxiSuPTikUrfYxBop
ui35IS6UkyIANuQipqULfuwBuyrxTgAZzEZX5ga8/LPFYG3zMuRhf/FyE6Qtedsq
/oW3WixgN/sh7faXKvmEZt8eg9VPTqO+dJ50BgbuZ6sJZTm6dOlFkFB+1/+e+iaZ
ExMVBiVCS4nTZnDywl5Rpo+7QPzB6KqPe0z0kWCSgwcwHlr9zUD1hP4U/cWkNuA/
2ST+nKJUxD03xLiLWFXN54z7BqfjloKwI0XS4phJQhP88LttG72Kb2tey7kemARx
QpH3Hn0CGKtqZTjIGoSDnFkyVY8KzbMrEr+BLgVNXGfj7Km9rB3uCfotK3IvjAGS
KZVhlRiln+Ea1E+CyglqUBOUaz7PI6hW4eZAr+h9kJ+zIAtqVhTbsstWZIy+nIPS
QghhOGVEoieCsd/D88YYDRpiKs0PMtv5UfnQVOWWox6vvSYb3Uk=
=dHbB
-----END PGP SIGNATURE-----

--bJ2xvEoFeWU4mZ1F--

