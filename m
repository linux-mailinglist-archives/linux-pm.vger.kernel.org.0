Return-Path: <linux-pm+bounces-28103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D0ACDCA9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038BC189768E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F728ECC9;
	Wed,  4 Jun 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byI6xZ56"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77028EA6D;
	Wed,  4 Jun 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749036928; cv=none; b=HlbYhZHfdS2QFUCSsc8JWiu4FUj4svfM0J/FeGKs/zWmei3xIVo6/MrqzfyBIVoQ7vkOOgTNpnDDWl4WIZxSgl2JbtiMu0uokm+mfy6iiB6gsUq4nqYQGj4JbxFR8qiwd9oiBFZCMu9p/0Z15ByPx2S6vGXiqIEh/m/i+mF76LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749036928; c=relaxed/simple;
	bh=wXSTBOc9hfPvgHW6k38UqyP60yWHejz7Bu4vESAaYGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw2KvT8JJ6dXxxrEU8fGv0UpagKTU2gHzDPzLJvqXk+F13YJKzkBRpV9QX03M8/btwlHuF4pOQ7g4cRI/PRP5XoJ3BK2iYa9DiY38GxGZU3q+mh1y2vjQS4vJUHGZfHigu9QajAhZe1BdhIsjxAIY1WFq2pQ2+LHDJH92WrYUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byI6xZ56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6247CC4CEE7;
	Wed,  4 Jun 2025 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749036927;
	bh=wXSTBOc9hfPvgHW6k38UqyP60yWHejz7Bu4vESAaYGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byI6xZ56+XQ73QaQFzVyf3xS+xcl4WnFhC/Yo9S8+yMrqTI4Tje/ARheZJsjWSCo4
	 eiAMaihUpAUlyLoo7oRPmdDK1iXVNdFUQ5hUh4Q8Vpcy1EP/viiRDFSudIa2c6ao8U
	 y71BzzlcWn1e9GRCjG6jbztgcYfhv0Pf5vpDSkQHdzNarlQgEBFiusi23mznCKwtqE
	 iEJRvZNtc56L6zyNxnPw/2/AfvOIY5mIOAdWyVg8H0wlHbbzf8jFb08t3oTz7ALID/
	 QbdpU4UhBjYKGyUB2RGa71VkswRBtb7OZRyXzzvEWepJN5sl4PHAJUA0/xQ3Dngxjt
	 /HNxqs4IaZx1A==
Date: Wed, 4 Jun 2025 12:35:21 +0100
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
Subject: Re: [PATCH v4 3/6] regulator: pf1550: add support for regulator
Message-ID: <eb1fb4e2-42aa-4795-bc6c-dbcf1fa04f11@sirena.org.uk>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-3-bfdf51ee59cc@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ow0kNdE51Zb6Qp/"
Content-Disposition: inline
In-Reply-To: <20250603-pf1550-v4-3-bfdf51ee59cc@savoirfairelinux.com>
X-Cookie: Non-sequiturs make me eat lampshades.


--7ow0kNdE51Zb6Qp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 02:27:47PM -0400, Samuel Kayode via B4 Relay wrote:

> +static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_bits = 0;
> +	int ret;
> +
> +	if (id > PF1550_VREFDDR)
> +		return -EACCES;
> +
> +	if (ramp_delay > 0) {
> +		ramp_delay = 6250 / ramp_delay;
> +		ramp_bits = ramp_delay >> 1;
> +	}

I'm not seeing validation of the maximum ramp_delay value here?

> +	switch (irq_type) {
> +	case PF1550_PMIC_IRQ_SW1_LS:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +	case PF1550_PMIC_IRQ_SW1_HS:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> +		event = REGULATOR_EVENT_OVER_CURRENT;

You appear to be flagging all these events as over current events which
doesn't seem entirely plausible.

--7ow0kNdE51Zb6Qp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhAL3gACgkQJNaLcl1U
h9BP0gf7BQBYj/vVLKsA5wseOvzZSYmWZEKxie9t4vNLf1wwUtWrL8QpfAW6AMuA
zTuTdnQpclS9lZMHtfcdUfLpgEma4S59VuiMDIt7EcjE16R7NvjFppzaRG+rSLHG
EsaPxW4w2VV7m+oLjGKTMJYxFpBbcldcwNgXKlLsSPnC/tY2x7x1jymSJYuZ93UX
Z13o6DQjL+9Ku3brZKjPubVwnAnUU8/hY5W9gbNj+Q1yZHReSwNU2Rbre4qOxCRJ
YsRk1x4xVMcD8E9xDK3iNpk+1Uf3aC2heiSRy2k1tpNCR9AKYqH+pJ3FN61Xc/QP
cIetZ86IqOH4t8q/Y6lLqNCxEE526A==
=7Ooj
-----END PGP SIGNATURE-----

--7ow0kNdE51Zb6Qp/--

