Return-Path: <linux-pm+bounces-27723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771FAC67E9
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A64D1BC4E95
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EE27AC41;
	Wed, 28 May 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4ueGTMJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D327A448;
	Wed, 28 May 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429945; cv=none; b=qOBUdrHSWjYT4f6NYx270Ic6GkSSvHCbATT9o7OAYKYkfjcY7zabyYXvQKqKFQzDwyCgzydSzEHZveibQ0IPi+drKQeNBwwcbNc2MXmaLHrCxIeAtxbyOypBS4ZoWDcsH80fdyf6NNpxYx33EGPIkeFtjf5U+1tWdqRDYEance4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429945; c=relaxed/simple;
	bh=UeArXwDGUV++k8Y775RIDVtcr2w2zvvPDO6/8+Vet0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeWSUO3qMKfIQuZNX10KwgHnUcKqBRwoxKbB9L8JDOzXlhlIBErVe/AX6WkX+KhE/uvuo1f5tLYRMrRILmdupfebWMu2vNUrDnlXz8zVpgVckZdaMSuf/obMGvcP9+/dbV6pMfb0T/e8pjguR3rLaiq0OiSZStieQlobMBtYhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4ueGTMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0372C4CEE7;
	Wed, 28 May 2025 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748429944;
	bh=UeArXwDGUV++k8Y775RIDVtcr2w2zvvPDO6/8+Vet0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4ueGTMJD6zNQpD1yS7j/gqmKAO2WZlbSUEJ3u9a+Va/hRZsifmoXLOl1o4VfIAbH
	 hYvNIPqeE4i7BLAM/B7fdRjXJ5xLpUuNIav+OVJ16t2sXPYL2jX97SlVXPWy6DnEJ2
	 clh8wLkZsIgnc4zQ+pg3YGcqg5WGOHGNvrQqiuBSedVJEYEO73tVN45B/l31tuV4bu
	 WZh9sHlN7Cjcr6p8HWRFIDot8Ip/hax2IFsnZOzcA5X7Azp05qn1y/fBWMuN9gv0EY
	 wb4oCFq7snTld/yjidTienxTFZQq2HrDg/7nQ5uE7peZZZCuKpF8RCL6/qt0ZTmsxm
	 IESbW6pfRasYQ==
Date: Wed, 28 May 2025 11:58:58 +0100
From: Mark Brown <broonie@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, eballetbo@gmail.com, abelvesa@linux.com,
	b38343@freescale.com, yibin.gong@nxp.com,
	Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: pf1550: add support for regulator
Message-ID: <99a2f5bd-5b73-4f4e-95c6-8bc03ffed90c@sirena.org.uk>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
 <20250527-pf1550-v3-3-45f69453cd51@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oXCbNIednqxLO6bi"
Content-Disposition: inline
In-Reply-To: <20250527-pf1550-v3-3-45f69453cd51@savoirfairelinux.com>
X-Cookie: Keep away from edge.


--oXCbNIednqxLO6bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2025 at 06:25:35PM -0400, Samuel Kayode via B4 Relay wrote:

> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pf1550.c - regulator driver for the PF1550

Please make the entire comment a C++ one so things look more
intentional.

> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>

Presumably there's been some updates since then?

> +static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_bits;
> +	int ret;
> +
> +	if (id > PF1550_VREFDDR)
> +		return -EACCES;
> +
> +	ramp_delay = 6250 / ramp_delay;
> +	ramp_bits = ramp_delay >> 1;
> +	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg + 4, 0x10,
> +				 ramp_bits << 4);

Shouldn't we validate the value of ramp_delay?

> +static irqreturn_t pf1550_regulator_irq_handler(int irq, void *data)
> +{

> +	switch (irq_type) {
> +	case PF1550_PMIC_IRQ_SW1_LS:
> +	case PF1550_PMIC_IRQ_SW2_LS:
> +	case PF1550_PMIC_IRQ_SW3_LS:
> +		dev_info(dev, "lowside interrupt triggered! irq_type=%d\n",
> +			 irq_type);
> +		break;
> +	case PF1550_PMIC_IRQ_SW1_HS:
> +	case PF1550_PMIC_IRQ_SW2_HS:
> +	case PF1550_PMIC_IRQ_SW3_HS:
> +		dev_info(dev, "highside interrupt triggered! irq_type=%d\n",
> +			 irq_type);
> +		break;

Are these under and overvoltage events which should be reported as such?

> +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> +	case PF1550_PMIC_IRQ_LDO2_FAULT:
> +	case PF1550_PMIC_IRQ_LDO3_FAULT:
> +		dev_info(dev, "ldo fault triggered! irq_type=%d\n", irq_type);
> +		break;

Similarly, we can report error events.

> +	case PF1550_PMIC_IRQ_TEMP_110:
> +	case PF1550_PMIC_IRQ_TEMP_125:
> +		dev_info(dev, "thermal exception triggered! irq_type=%d\n",
> +			 irq_type);
> +		break;

We also have an over temperature event type.

--oXCbNIednqxLO6bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg27HIACgkQJNaLcl1U
h9CQZQf+J99VNLePtEzL+A5BdJaKLeiBWdMSF4MgfRlFjXSXBfqarn2GcU/5cEcX
6GCypJFkQMhyWt6ywk8NNSEQ8YrCiE/y2KfquUo7OQpLw8jvzEancHU76epQabzO
sfJhz+M2dQ1bJkVe6zGAbATE/dJcPMU6m+yCKFozmMwN7JF20aqeI7HzGWx+fVou
17F9/jy+DGvJvM5LKWv2KVLcS4TdMmJwuadjMUn2rm1fy0J3aSHN88Wpb9sJmn7v
VzDfGR5w3dOM/Baqv9b5bSp1Z6XaHqrXmXjfGh2SvVG4PZKsx2/UTwG8dWTDAqt2
uyEc8XWQOnK6q2M+J16oMOZOZzyrng==
=g3Y9
-----END PGP SIGNATURE-----

--oXCbNIednqxLO6bi--

