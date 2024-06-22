Return-Path: <linux-pm+bounces-9804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8591338C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5B02841E2
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E51509AE;
	Sat, 22 Jun 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1xlnzHc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AD155393;
	Sat, 22 Jun 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056968; cv=none; b=eH+8vUJL3EOORDOkxz1CvG2SQ4ZmrihHRZpJ82L6bRREYNDKCwDWKgQW4pgsnbw0WzyFf7TF3iYFqZ0JdVBvVLFUT8zgF71/psm2z4CbvnbswF07/uOLlcwuLy52k52oZece1BSU8/xMhOL27zNbDn6X5V0LRPNkt+zQpKwRfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056968; c=relaxed/simple;
	bh=5FvrPBRa4r7Xhj4sScdhLXMGxs84cfjsBRSmrxV/JDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqcRyCtffi1iz6Jvt9l/JytA2cd1rZ5JImGFk9mPUPj2dZpr+t45izYTaZVYjYdo8MyAH9WLTcRV3B4sJhIieUjpz/mBO7OP8v8UBj/Hy3sOi45noJiLbIJnEl9cdLT95Lkb7YiyrMEj4y8Rp84wMgr83X4qJWmftv0ZEcuGYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1xlnzHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF31C3277B;
	Sat, 22 Jun 2024 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719056967;
	bh=5FvrPBRa4r7Xhj4sScdhLXMGxs84cfjsBRSmrxV/JDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1xlnzHcBorcrSe8NYjeojRjUoGvYaTcITiA1fWksaWWne7c7puQHarf7KOiZ/BYg
	 Oe2XtJMjcexJt7dXrZ/4aoWftVYiphi6pd5cqWogfJM8Fb05ncYiE0cf8W59gktZyx
	 GeOcYGSED50jZmZ9KGsEIaQseX9tgMTx64gLjHBJwpShy8DI0AJKdkKBCm047/ZWUu
	 E9YFfnyLsXs+bIArk33lDRikOXVLb5o+An2uFKs3IRDiiTTv1W440YsG0yOE3+7TZs
	 9oY8Al8xC6S4ta3vFBvJm6Qr+9QN7o2peqsYj4shukazbR9dEgcCHf8lgMmvi9trBH
	 kIHWCtj9B5KTw==
Date: Sat, 22 Jun 2024 12:49:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Bryan Brattlof <bb@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: syscon: add TI's opp table
 compatible
Message-ID: <20240622-aching-disagree-520469bd0f82@spud>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
 <20240621-ti-opp-updates-v3-3-d857be6dac8b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yY56wFrcEn6KxQwM"
Content-Disposition: inline
In-Reply-To: <20240621-ti-opp-updates-v3-3-d857be6dac8b@ti.com>


--yY56wFrcEn6KxQwM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:39:39AM -0500, Bryan Brattlof wrote:
> The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> various components on TI's K3 SoCs. Add a compatible to allow the
> cpufreq driver to obtain the data to limit the maximum frequency for the
> CPUs under Linux control.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--yY56wFrcEn6KxQwM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna6QgAKCRB4tDGHoIJi
0usCAP48lDl4CXm1S7KHclJJ2t8snW26tEOktdOaiBnAVXrJmgD+PwN6eIweSsyT
7c/0rpx6zufblNGqsRV6bYuLfvIC+gE=
=+Fyt
-----END PGP SIGNATURE-----

--yY56wFrcEn6KxQwM--

