Return-Path: <linux-pm+bounces-24889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BBA7E64B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C3E4238B6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF81214230;
	Mon,  7 Apr 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BduanG0O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E682206F0D;
	Mon,  7 Apr 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042455; cv=none; b=mdZtm7YoqmIMdFUJLe/u5Fg9cuA1gjwSjktSiOYuGjxKgo0axeXK0y5PddPFX+DhYUFXOfE9x4T2Cbxu20Lue6Ul2ZYg389PEgs/vN7lLQ/JYCJW1C3ayJdXyWpyDRL7DvWwB6JVATJJa68Ap2SdwLnmFPqFM0y10yxIqJL1usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042455; c=relaxed/simple;
	bh=lRo58WOEoZYlMzgSCKBBpT6Df41auOl5bPYJGpgfOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1yTdH61FdKlUDaG6aCY9toc7ygMPQRW5sfijf/zoGjSr4v1PT1IoSavSkCM7ZS2yiih4gcbefDXK3zCtOS+2vaMrEyZ+59jOQpD+j8EYiLmY4QLm3VNAhaW7e9VjWV447oBlnNLN8gyv2Q5GjIH3Obw8XbpRIABjug39mq/eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BduanG0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254EBC4CEDD;
	Mon,  7 Apr 2025 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042455;
	bh=lRo58WOEoZYlMzgSCKBBpT6Df41auOl5bPYJGpgfOuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BduanG0OKVkleR8XFTyB0bnJmIxsGo7D1T9I5vCD76VKCcdZ7KP7VYem4hEhSJG6o
	 3BgO8dkrpSQp+RtKnegbA5ymlT+zjUKS1ssOMVIZHytOfBHQ4HRKkFRTWDHw2JvI1j
	 3lK488n94NKLGxqmgtxCoUsVlsTHOIRJMjGw2fkapl18pk5CooT6kfZ6NhvqtRWvqO
	 fhVklUI/mhbdCGOv/rfl7FgEI8VPnvO54E6WbhVZGWbQRw/eB5/LRdqhQ9aTU0eYG3
	 c7CML4a6NE7L0zlZrghuj9M6F8UCQQO3MRS4RBigHT3E8PY6pEjNaw7cl7KKAMdS42
	 lPQzUJB2DO3Tw==
Date: Mon, 7 Apr 2025 17:14:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: add toradex,smarc-ec
Message-ID: <20250407-glacial-unfrozen-333d6d62144c@spud>
References: <20250407114947.41421-1-francesco@dolcini.it>
 <20250407114947.41421-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S83CsH0c2BAJ1I46"
Content-Disposition: inline
In-Reply-To: <20250407114947.41421-2-francesco@dolcini.it>


--S83CsH0c2BAJ1I46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Actually, one minor thing, $subject says "firmware" but the binding is
in the reset directory. I can see why you'd put it in either, but pick
one for both please.

--S83CsH0c2BAJ1I46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/P50gAKCRB4tDGHoIJi
0kaSAQCNZoSpmCC0RG0qlP1RosPaWHfYiFhuqtHjB8ycKDoCcQD+NymWoYRU/8qS
7P///Etu4/piiVat9uxqeuX3UFwU7gI=
=mT8w
-----END PGP SIGNATURE-----

--S83CsH0c2BAJ1I46--

