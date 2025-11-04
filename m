Return-Path: <linux-pm+bounces-37380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB8C325EF
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7D3ABEA0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630F330305;
	Tue,  4 Nov 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmGaPMF6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E0299AB5;
	Tue,  4 Nov 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277699; cv=none; b=frS1o/PL3HsdEPHoaYmIC81ycRy+j6iBSpDq3IZr9OdETKGLH/fkkTczuiSXfrU3vXU4WV6YhH5TD+lvbYxeoDEiOjyEvAMhXpqr6hg/1ivCqmMWBwDwS4LQgquzX2m7heHK/peUq0bLNI4qGWPeibBINVw/5PLdOsuDAkm8fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277699; c=relaxed/simple;
	bh=8xQbltzAdhXfwga5qXiYOqU8nts0UsDRjUvSm120wQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7RYOZ0rxfy/aMwguw+MG0ubrx6qu2i0O2Hei95586BkU2zsU7O316wnH0RoffMfX3OVOgXWj/NeHGF3f6NKuMKtwJcj0BeZQ+J3gHzVk7Snfk0AslV3kbbC+h4l4qIZjcfeIq1AE6sYnfFUBwekPsxf/QB1QIMMVLc0f/R/RMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmGaPMF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C9FC4CEF8;
	Tue,  4 Nov 2025 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277699;
	bh=8xQbltzAdhXfwga5qXiYOqU8nts0UsDRjUvSm120wQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmGaPMF63foSRg8VKHoS5RRVR++RJzTQp2nLIYnhJJNlrz5vKH3z9KgR9LsIA8jZu
	 n7Aqi0/uF9eXo1R4i4oHDTeecz5kkP+GdzMXBfiAles5Yg9R4cLRANGmE6E+NITm69
	 vzk2uqAyQnpn1zYGc4LFeKVoJCGs4qOaVfgNHYY0mClGI0bK0ZuY3buaGARPTIUnhv
	 zt8SVYTRf1eGb8shbXtGJmEH1rog8VChbZRYnGGd5b5e2RYcjFdQmZXfmOaAyg23y5
	 3T2OY9/p33DAWLIMWMJvsG6hXAQKyguEvIXNtMEhifgvIuQYAAfV7mI958V6RSm5+d
	 rmuY+Pgf7uK9A==
Date: Tue, 4 Nov 2025 17:34:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
Message-ID: <20251104-trilogy-unissued-43e96d7fce87@spud>
References: <20251031183309.1163384-1-svarbanov@suse.de>
 <20251031183309.1163384-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8mj34RREUM25/Crp"
Content-Disposition: inline
In-Reply-To: <20251031183309.1163384-3-svarbanov@suse.de>


--8mj34RREUM25/Crp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 08:33:07PM +0200, Stanimir Varbanov wrote:
> Add bcm2712-pm compatible and update the bindings to satisfy it's
> requirements. The PM hardware block inside bcm2712 lacks the "asb"
> and "rpivid_asb" register ranges and also does not have clocks, update
> the bindings accordingly.
>=20
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8mj34RREUM25/Crp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo5PAAKCRB4tDGHoIJi
0paOAQDOdINvL0/4sTF6BCosi/vP75tcg5G44avu1plor8SBUgD8CObF4BwCPlZ0
thXG5aX2ATjpFnbsPNdIZ1SWKUGVkwE=
=a0/L
-----END PGP SIGNATURE-----

--8mj34RREUM25/Crp--

