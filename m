Return-Path: <linux-pm+bounces-28112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B8ACE01E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A33A6B69
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350FF290D94;
	Wed,  4 Jun 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smnr6tvu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C026ACC;
	Wed,  4 Jun 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046770; cv=none; b=L922Z7VHm74FdalNXwPcBRxfSKMArA/hhPvxqd1MzCtMLXJciRIrYu78WTVlRX2KB3jL6mqoFLpSVGigvlYvlbhTfuaLtoVohFRJl/qUIXwGh7n56CQw1yxkfMFBouR5+EztqJZ8k/4QsjdorDisbQf0QqIH8qPI7+dIiyqavxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046770; c=relaxed/simple;
	bh=7YsuzD8Qz+jO4WRfB8ZOVNTmXy1/NRoTyJpWk3RBQmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubDiPJW06rqE/0DDkf8fXhnFsgfLUv4/6mSGi22DHcYeFIwWZ7zqrQ+5DQmZeb24NwLohOHj+LWjugTfU0BUr7mVNcZsSUMUWAAqGrC694Qv5o1TzJsIzvE1H153O+8iPnGFgtJ0VskMMocr9n7VngAeRG2GJdVCjqKTwUQBZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smnr6tvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D66AC4CEFA;
	Wed,  4 Jun 2025 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749046769;
	bh=7YsuzD8Qz+jO4WRfB8ZOVNTmXy1/NRoTyJpWk3RBQmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Smnr6tvuIR7JjHfl4D2OAQvC5kT4zIzGU/qYIFKRuAifKlCT4Mj6OXpeS2Io/LxPk
	 1mVQv5OQptPXFFwq0lWlGwt9pUFlQDl7zngPKEDEotpc4QhG5ZoOpsAaArcBRgmhVL
	 pw2If8cYdH8ayppEgVq3MwnxRwIJExiuyD3QHBcamiglank6OHxFFTL3MqTiGdpaPf
	 zn95oZcu3uRaCMq2Qi9X47SOwj6G9CQ44ydpPXcfXaw5d6kuDIsO3oU+wfc2nRoN+j
	 14/s8cqnsXwHcrobT7y9WHQ0SYUOq3Na27tGjxIfoyuAY0innSXNQyC0XNfa6TYRDg
	 zvkIGY3nh+MZA==
Date: Wed, 4 Jun 2025 15:19:23 +0100
From: Mark Brown <broonie@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 2/6] mfd: pf1550: add core mfd driver
Message-ID: <41f40dfc-a71e-46d9-bd06-807a8d9c5748@sirena.org.uk>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-2-bfdf51ee59cc@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CxhOUmXXhXq/QXX/"
Content-Disposition: inline
In-Reply-To: <20250603-pf1550-v4-2-bfdf51ee59cc@savoirfairelinux.com>
X-Cookie: I'm definitely not in Omaha!


--CxhOUmXXhXq/QXX/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 02:27:46PM -0400, Samuel Kayode via B4 Relay wrote:

> +enum pf1550_pmic_reg {
> +	/* PMIC regulator part */
> +	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
> +	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
> +	PF1550_PMIC_REG_SILICON_REV		= 0x02,
> +
> +	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,

I notice that you don't seem to be using the top level interrupt here,
that's going to add overhead since you need to check more registers on
each interrupt.  Look at the sub irq stuff for some generic handling for
that.

--CxhOUmXXhXq/QXX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhAVeoACgkQJNaLcl1U
h9BcZAf/bAoZC9oVRKkCQ7a6xVE/Snfm0QLW9yVBOGPr/nmKmruf5JM8TICwAO8c
BkL4IPkPOI/ydRth25EvtqGczAXgZLU2UC4cupTLNofUqb11NarGxhmd2kI5QUP3
RmyPWVpGpglxl275sJ/zro3f4u5erLXFcrcbTov1HOvcfIGotPmZhXtE7Pccm0+N
+cECCVbEzSIdZaFDw0DyZ34VYrBaQIFbOmBDi1tlkcO2xgEPkIDsRt0rsG+M/iIY
u8WRbMFOpSl7VVIgDhJCbmX9hNrRes/qLTqFUHhvyz0FwqX0fRMK93zQas3AgupX
Ndt5Zdid0LqkRokAr919rQf2ZxvL2A==
=kr6O
-----END PGP SIGNATURE-----

--CxhOUmXXhXq/QXX/--

