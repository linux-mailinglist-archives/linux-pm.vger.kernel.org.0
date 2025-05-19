Return-Path: <linux-pm+bounces-27359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B1ABC44D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3807A315D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7428AAFB;
	Mon, 19 May 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UINxs4j2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5C288521;
	Mon, 19 May 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671220; cv=none; b=GkI/YSvdk9md7vg4W1YLg3QTbW/JUDbVtgqt/hX9K8/T6iaLcG/KDlXQo39AwLjN1oA5/UYLlpm+Oz8XZwQErsr81Fe1zQaeejaGJxJZAEtx1xTdxPLDY1luQdggih9io8wXB0MkAPBF7c3Q4pAwUv7JztBVx7FLc77bLM4D8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671220; c=relaxed/simple;
	bh=UmNwSFajsb2gQxcRHVej6ZPnsmaY+xQpujk6JzYISKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3zfcaMlzrKpfnk/Oc0SpXoJsqJ0VLRy1qqErxUK/6C8bPA7Io1jx4PXXxcnfK6ayaaCGkfodWveYzmB0J9TNTtZ9Rgrvld4ngKnhP2R/7ac3mgeWThlFP82vmxc3Alf9h/iI/u7zPN9Ael6eczMB7EilE2IAEV7klUDwIUnP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UINxs4j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58EC4CEE4;
	Mon, 19 May 2025 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747671219;
	bh=UmNwSFajsb2gQxcRHVej6ZPnsmaY+xQpujk6JzYISKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UINxs4j2cfiBSaoEdJJzkYN5Tx/PcgIPy5rq7TgNkhzZWdE0eFaMBD/IR74uAEqfe
	 RaHFXyBaZBDYPMcruzgeZPwiM5kiQwGl+q3FHuKuJs5DsZ4myHbx9y8rfSbS85sx+J
	 s72IUKxA6vHx4c/8uvqIcGmwhWg5eP0ya+IIKR5P9qHJ6v3bE+v1ChVN64/OHyGV/N
	 7x2enUtRQ/76g7/x3L1LJRLRHUsy9Gx3Xw5LknZhfT+yJKK9QWCynjXE8yuUjkuZSW
	 lITbzVYEzjDNJ1TA12QgOtQghbdbh03fpytLjL2EGZq0z1b0eopROxjtpkhYBJ354g
	 p8vdiQDuQiCrg==
Date: Mon, 19 May 2025 17:13:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: rockchip: pmu: Add compatible for RK3528
Message-ID: <20250519-backer-resisting-dd1b7b51c552@spud>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oHpkP4t8DDp0/UVF"
Content-Disposition: inline
In-Reply-To: <20250518220707.669515-4-jonas@kwiboo.se>


--oHpkP4t8DDp0/UVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 10:06:50PM +0000, Jonas Karlman wrote:
> Add the compatible for the pmu mfd on RK3528 SoC.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oHpkP4t8DDp0/UVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtYrgAKCRB4tDGHoIJi
0pqNAP9W6yAd8hmNkjtk/3p3P81h6tv3qfTuReMFreJQxi7OXQD9EBF1xQlvXWqT
Fol2XJSQwjgip0XWN/RFdwalToSoYwc=
=1zv7
-----END PGP SIGNATURE-----

--oHpkP4t8DDp0/UVF--

