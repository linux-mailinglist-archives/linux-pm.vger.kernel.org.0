Return-Path: <linux-pm+bounces-35127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB35B8E893
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 00:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5D1189C097
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1B253359;
	Sun, 21 Sep 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWFQwBZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314972AE6A;
	Sun, 21 Sep 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493257; cv=none; b=X2ysAccpGfaXxme+FC9BUad78sBgfL03NlvVGPTrkwDl3sOmpKK9v8cCsFV4nc/cxZOq3qFabcVs8dluQE70MY5wB/M8s24bncjxBQFyMYyTLoATSPZmlzqKsAtZtaIuXmxeUJIDg/DC7chhdQApXyjoATYYqxZemwnWwkivD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493257; c=relaxed/simple;
	bh=deIlNliIFfttHaVaz+a5cZngYOdByEk2eSULIl0DxWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrwYuHAePeCPtC5FxtdhES+8Zk7dUxHgOQsRH79U+Ba8BbVh0gU3iNIdBla+ZlkAWr/z2TfV/rkaOvkKpjEHhRvMtqEiwCpzw6FyhOC6F1fUFthWRDC4dDAeEVdSDGDurQM9KawrjK15dmczqDT8+2ouFHfY/tlWZ0+3+segVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWFQwBZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F07C4CEE7;
	Sun, 21 Sep 2025 22:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758493256;
	bh=deIlNliIFfttHaVaz+a5cZngYOdByEk2eSULIl0DxWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWFQwBZAhMYUaaA5uo8ILM7NlcErylUxQ0nRkEnKhmzH9SouyhUwUsvmPI8QMRlt9
	 Jg2/R3gHsr8SZPU31xZDfAd1A63rI4tGgEnOzVNDdm3/rg0soJjO205N0BG6WGf2nW
	 WW8D7QcD+yi2pqrLhsgwlPIIKEwBhDthWnIoiVFPXf2kxhdRf5Y6Po4bYd+TOsAA7/
	 Q9ny93JPVwtoGPrSc4xbuu0gY6KwDLYX59A5Ygmq2srNC0wUu7EnWnODFp9RcNmMe4
	 Yswi79VHYfZLnnz8r8LNOolutZmqspeDlCmODf7uIfi6Ls6u2XBT95jAjtpbXhPU/I
	 objma6kY4n/pw==
Date: Sun, 21 Sep 2025 23:20:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
Message-ID: <20250921-abroad-decibel-5b81c0680693@spud>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
 <20250820-await-chomp-9812902c0f74@spud>
 <wtwdpqi4tk3ixzmrvdyv2aguf6pjlmnz6q5gvhlajl2hk6mdys@fmkugriedhqe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7v51AzaYiK6X0Wju"
Content-Disposition: inline
In-Reply-To: <wtwdpqi4tk3ixzmrvdyv2aguf6pjlmnz6q5gvhlajl2hk6mdys@fmkugriedhqe>


--7v51AzaYiK6X0Wju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 08:35:12PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Aug 20, 2025 at 08:48:23PM +0100, Conor Dooley wrote:
> > On Wed, Aug 20, 2025 at 07:40:49PM +0200, Sebastian Reichel wrote:
> > > Instead of having an optional rockchip,grf property, forbid using it =
on
> > > platforms without registers in a GRF being needed for thermal monitor=
ing
> > > and make it mandatory on the platforms actually needing it.
> >=20
> > I am assuming that "needing it" means that it was actually mandatory but
> > the binding was just missing the required required entry. If so
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I just noticed, that I never replied: The GRF configuration is
> required for proper functionality as far as I can tell. Technically
> it might be skipped, if the bootloader already configured the
> registers correctly. but I don't think this is something anyone wants
> to rely on and with the same argument we could describe almost any
> resource as optional :) The upstream kernel DT always had the GRF
> specified for these platforms (and thus most likely has never been
> tested without it).

Acked-by: Conor Dooley <conor.dooley@microchip.com>

(ik I gave it already, but for clarity)

--7v51AzaYiK6X0Wju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNB6QwAKCRB4tDGHoIJi
0oeMAP9PVmH8y60xBY5fyeXeZW7A8LvI0TS/a+zumSiuaKg5lwEA1ZC8Pd7dkYva
SIjnbkEWh1VeQ9wWMnQJof1jJW/IsAY=
=mGFB
-----END PGP SIGNATURE-----

--7v51AzaYiK6X0Wju--

