Return-Path: <linux-pm+bounces-32737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40815B2E5BD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 21:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726365E33FA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C028541A;
	Wed, 20 Aug 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HABbqDGw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA461CCEE0;
	Wed, 20 Aug 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719048; cv=none; b=b+nAC5sLq84O4QuOF4Azya4fuKxjydi+O4p3UrS/1H7et0p0kJBbdgXDb6jLr7SxMMzW4V+o/jK4J8EXaWR0UGzCPn5p6Q4uNCt6JPdCdixhm8TxP+qsxWkVDdGatUUXr6qbfe6VsZu41Zhk742xWifRqqxNZCPDjT4NodmxYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719048; c=relaxed/simple;
	bh=wVbhnBpFX/Zq7DTszd7msln2BrK2tuah8OGziBFa8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3hFWt/yO6YcPO11QJzzdQBCBGvRvNt1rjmu5RLTC0RJDW0TQ0BFKwzZ9sHOEYKYUpTC9DZep9AcW0fPjyXgiaNGlo3XmA/8gsKTkzW6oYSjz0mdzsRF9wyjJz4zeMzx9v49rOVHi6OPuifE0GGwGl6WSiSC83hjLQ7fn5AcqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HABbqDGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E335CC4CEE7;
	Wed, 20 Aug 2025 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719048;
	bh=wVbhnBpFX/Zq7DTszd7msln2BrK2tuah8OGziBFa8D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HABbqDGwDkSdAJsSfXinddrrkvWyvb0hWN2fdrq4tUI56ouUNEgvZya04aSIbQbFv
	 q+f4QoTIKOCLxFDXxH7Z2t7eHQFBIyegvhSxOG5BEDAQAJL4bFQr4n+RyfUClN4Fwa
	 Qno9HlO2ZbdaL6TJbkPuL/6kuKCfyRryZnaxgcZh2A7l27UTzpuni5/yn4t1e4AVSL
	 l/JhZLrguBpPk9qJB2nKVnO61Gl8O7YY+sUm+YL/L5VklhjSFWBMBox1CMIsoG1/CT
	 EhOCWGNJfNte7n9qrCl1JxazLRjw6GTscM16O3vC1+kuGz/O86pffD0iD9BH56JESM
	 +Gs6UOSHxZDVQ==
Date: Wed, 20 Aug 2025 20:44:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: tegra: add Tegra114
 soctherm header
Message-ID: <20250820-spinning-arrogance-31b71d969bb8@spud>
References: <20250820114231.150441-1-clamor95@gmail.com>
 <20250820114231.150441-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i9diGKFZwHGtBgg2"
Content-Disposition: inline
In-Reply-To: <20250820114231.150441-5-clamor95@gmail.com>


--i9diGKFZwHGtBgg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 02:42:29PM +0300, Svyatoslav Ryhel wrote:
> This adds header for the Tegra114 SOCTHERM device tree node.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../dt-bindings/thermal/tegra114-soctherm.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
>=20
> diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h b/include/dt=
-bindings/thermal/tegra114-soctherm.h
> new file mode 100644
> index 000000000000..b605e53284fe
> --- /dev/null
> +++ b/include/dt-bindings/thermal/tegra114-soctherm.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for binding nvidia,tegra114-soctherm.
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +
> +#define TEGRA114_SOCTHERM_SENSOR_CPU 0
> +#define TEGRA114_SOCTHERM_SENSOR_MEM 1
> +#define TEGRA114_SOCTHERM_SENSOR_GPU 2
> +#define TEGRA114_SOCTHERM_SENSOR_PLLX 3

> +#define TEGRA114_SOCTHERM_SENSOR_NUM 4

Why is this "NUM" sensor not in the driver?
hint: if this is the number of sensors, remove it from the binding ;)

> +
> +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
> +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
> +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
> +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
> +
> +#endif
> --=20
> 2.48.1
>=20

--i9diGKFZwHGtBgg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKYlggAKCRB4tDGHoIJi
0rwHAQCrTuKbYeJomxSTYcBj4MJ14GO3+TBM2PC7h0zSsEvNGwEAuuUnNdesVDmX
Lbx6jgEug+wxC0uVQey13cfvJK8cIAc=
=y4RN
-----END PGP SIGNATURE-----

--i9diGKFZwHGtBgg2--

