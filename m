Return-Path: <linux-pm+bounces-12048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6694D1DF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09C928355F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B2195FEA;
	Fri,  9 Aug 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwe3mLax"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D3174EE4;
	Fri,  9 Aug 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212684; cv=none; b=oJ8tg+fezGn9BH+LbnAMfO90EqMf7eiQXqmd6hzEChpIHLAVpz+SXxh3gP62Z7wtUQtScCD+2PduVj4kRrcjwg2mYdZn2tW50U/7I82ojUOm//5MLR1Vk+5B8vXCzW6PJ6qylelhAXSNdKWEfOwoIEDvG/Y1tgTSRcZ+r5Dr1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212684; c=relaxed/simple;
	bh=NtkhbxXEYV3n5Jv7xrDwbnDxuRAaPrmhDfvy4uf1SNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRdLdBFUxGOZ5RkZBFtefhIQ4jhCL/y7Tw3vnH+odYrIzV0mDGVjuRw9YSNF6qtizJm7VC+gs0unRFqZwaADoTOT6yjLf3sg/7rFJIw8yY2sOTyZh7vLLtOqi7DfEK64tWpwFFJrGIKRJICh3xeERu04ZqInxH7hWGU2+HHCppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwe3mLax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAAFC32782;
	Fri,  9 Aug 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723212684;
	bh=NtkhbxXEYV3n5Jv7xrDwbnDxuRAaPrmhDfvy4uf1SNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cwe3mLaxkPyHddzS1VAb6WwLRJ7eADc/iB2LylJMwes1nXYFnlMlVHR0Njo9FFyll
	 YjCNNNDzlIgH0Z4s/t9jRmX5EpQl4tLPRxIAo9UfDlH0SJ8Cc5mPXIfvYyoBL6Z4NR
	 StGA13GTBxyJFuSfzepdn2/C5UvXvPV+c7Yp9e2oebHui6/q/JQD2TTcTQ3fVuanVy
	 /CcagZ0y540isHvUgDw2aRnBusG7AeWlYnXOeVczh2ZP0siiCSYurbLtVvoPES2WKl
	 rnjpiukThl7HkYbcz5+0yj739gIs1sztTYxHj58KiMsGCqNFQTjX5JvzypL3QWhTA7
	 LkFw3GX7OH9UQ==
Date: Fri, 9 Aug 2024 15:11:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add support for RK3576 SoC
Message-ID: <20240809-dancing-earthly-d4b76d38f965@spud>
References: <20240809125925.4295-1-detlev.casanova@collabora.com>
 <20240809125925.4295-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2cVcGqQINBTKi1m8"
Content-Disposition: inline
In-Reply-To: <20240809125925.4295-2-detlev.casanova@collabora.com>


--2cVcGqQINBTKi1m8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 08:58:04AM -0400, Detlev Casanova wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> Define power domain IDs as described in the TRM and add compatible for
> rockchip,rk3576-power-controller
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [reword, add yaml]
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2cVcGqQINBTKi1m8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYjhgAKCRB4tDGHoIJi
0nltAP9grRpAhJWIS0t3A5qRXMQsM6Tz3QpNxUQm7nORvKdHcwD+K2otD+Ea2ckc
xTIpjDlsf6OIemBuvdu5OECk0X6DeAE=
=Y6cW
-----END PGP SIGNATURE-----

--2cVcGqQINBTKi1m8--

