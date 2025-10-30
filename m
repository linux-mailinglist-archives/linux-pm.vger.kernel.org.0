Return-Path: <linux-pm+bounces-37143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9CC221D9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 21:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F235189F286
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B7359F85;
	Thu, 30 Oct 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Col8Tj6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8832F777;
	Thu, 30 Oct 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854563; cv=none; b=gRy9nFQaC/O6DKYlrx0qJTe2h2HiLtPZXElrCa5dj74VwZrO9s9U4EFVUsh6sBKWt0FG9gP+Qg2sU5aFtENWCjzi5M9AM897CRU+4E5nVI5HWG9kd4EbubW6i8/lTlo6UDaDbsDH614aErXZWRrT4Zu3O9HOVqwhOboHpr0tfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854563; c=relaxed/simple;
	bh=r9g1+QBPnAwiLvwl2Y4ihxuJibESLERl8N7u/1HES3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na0UVpLKHhALwK4zFYScWppYVkn02o/BPqZEVJbG5Q8TixKMBmqJkir9X/tzRyN03JjwlAvNxYUcfb5rHgzFEOSOrDwtnaNPvqoqXPI+sDpqpy6SpwAEi0xiCoZ+3tU8RU0U4FbaSATrPIMxHjpkd/V/jmNM3wEZOjo+jDrUqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Col8Tj6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96C8C4CEF1;
	Thu, 30 Oct 2025 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854562;
	bh=r9g1+QBPnAwiLvwl2Y4ihxuJibESLERl8N7u/1HES3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Col8Tj6XUNGhXonaQskRLt2WlVen1XF5dChCHC7F9BBf/J7mLDrv2ON+5gKCVEG85
	 YFOrLOQlNEf7fCXS1pEyBQJWrEsEsTpv4NffN+JLp/VJ75/HdFU+7Xq4Y9ufoi/m9I
	 pZWpzdM5EAYxQqblD6RHZnDcqCBnocEZAAmRe4HGPDZsX6Od5SoVfvO80yfef8PpLl
	 6yYDk+VfTGClwMISRLmVB76n+NylFvbHTdGEDaC+7E3mA8cZBK74ih7yo6ZhvBxGLQ
	 nF7t75CP4LIte5QqX4Cyk9VpMRwP3B6kCGhqEr5IJ3200y4Cti78ipZEdjpb+Wt6DS
	 qnH4jDf6Jflsw==
Date: Thu, 30 Oct 2025 20:02:38 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Drop db8500-thermal.txt
Message-ID: <20251030-twins-cornhusk-0b2ea4d039bc@spud>
References: <20251030195234.439141-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="de59hFfPK3GXyBtd"
Content-Disposition: inline
In-Reply-To: <20251030195234.439141-1-robh@kernel.org>


--de59hFfPK3GXyBtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 02:52:33PM -0500, Rob Herring (Arm) wrote:
> The binding is already defined in mfd/stericsson,db8500-prcmu.yaml and no=
ne
> of 'the tripN.*' properties appear to be in use.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--de59hFfPK3GXyBtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQPEXgAKCRB4tDGHoIJi
0lIcAP97f8tvjZE6V6uEXoHA+6k+pp5fimpgVm4xY+mid3ZneQEA6O/07u5q8+o+
bowZo9WiYP188GzbGNFEHij8DgF6aw8=
=O8F4
-----END PGP SIGNATURE-----

--de59hFfPK3GXyBtd--

