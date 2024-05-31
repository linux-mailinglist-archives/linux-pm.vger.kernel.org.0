Return-Path: <linux-pm+bounces-8483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB88D651B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497E728E5F6
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9506CDCC;
	Fri, 31 May 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0r8HZ6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA07483;
	Fri, 31 May 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167878; cv=none; b=H5mSkYy5HK+xBnJayNziBkzgkGiUVpfVDvNeqlDVmxsiJxXV3EfPGhbfeT2tWXeS5WnQDrljuTCsDjWFDJC23fZC5KqxQ6qRoj6q0F5+gFf/UYACx/NWryRN9yXIUX5w2EdDINPxD2OcCKX33QF/oTozcJ5V5/J3MhzrI9I8kFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167878; c=relaxed/simple;
	bh=WlONLvUzuGAWpIFAckDTFmIFip9XIDRJ004IX70Pa7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHnqOsz2O+eramLF9Mz7mz+eeIstvj0tlrdTx9wmfBqgBpg2Ocvl4BjqT9n/PLNzpZYxW6AmG4HHHoWcyYPcYbpwAZ1FLeCPJCEmBat8nwnn925ZE1hToQnxWoQAzasQGO8b2snwHcLAcaCmm5Tw9H5yBJ3HIMPjulWGF2HAuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0r8HZ6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C353DC116B1;
	Fri, 31 May 2024 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167878;
	bh=WlONLvUzuGAWpIFAckDTFmIFip9XIDRJ004IX70Pa7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0r8HZ6wRlWQ8R7CpmEvEMHRZ8f5m4JQa4hyyRFq+uqUEAYINjfc7wUw8O4xqvvhl
	 f/EBqTzaVIiGe+3P3TVXsSSDEFY04V8CmIPLCl4A6mGInJRmUd4uxt+lOCOzoS//lT
	 5OctIOrg7J0+8y++Kwh5uEfiXKvD0ZJtZJBJAINyOHE4uK12UuawnUeAzmTIPx3Itg
	 h3PN0MiYCKmOKTv9TvRoYUuH8yT2Khhc9Y7+g8/XeP6GKXbAQv9hVyaW+Q0x0sKhdF
	 zLMYwfZT8TwziirNpOt94sJlBoq7rFPcf8jceK2odSb5rMf3UWT+OQvHDvHjt5nQyX
	 OeR1OKATPKrYw==
Date: Fri, 31 May 2024 16:04:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Haylen Chu <heylenay@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal
Message-ID: <20240531-oyster-duct-9eaf5f3e6f35@spud>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BD44992A23E2B0061023D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <1624f2f0-0a2d-4918-a129-84dca6da9af8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+uuAo5InwkaQdoaN"
Content-Disposition: inline
In-Reply-To: <1624f2f0-0a2d-4918-a129-84dca6da9af8@kernel.org>


--+uuAo5InwkaQdoaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:54:24AM +0200, Krzysztof Kozlowski wrote:
> On 30/05/2024 15:48, Haylen Chu wrote:
> > Add devicetree binding documentation for thermal sensors integrated in
> > Sophgo CV180X SoCs.
> >=20
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >  .../thermal/sophgo,cv180x-thermal.yaml        | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv=
180x-thermal.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv180x-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv180x-therma=
l.yaml
> > new file mode 100644
> > index 000000000000..0364ae6c1055
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.y=
aml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sophgo,cv180x-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV180x on-SoC Thermal Sensor
> > +
> > +maintainers:
> > +  - Haylen Chu <heylenay@outlook.com>
> > +
> > +description: Binding for Sophgo CV180x on-SoC thermal sensor
> > +
> > +properties:
> > +  compatible:
> > +    items:
>=20
> Drop items
>=20
> > +      - enum:
> > +          - sophgo,cv180x-thermal

And a soc-specific compatible too please.

Thanks,
Conor.

--+uuAo5InwkaQdoaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnnAAAKCRB4tDGHoIJi
0qptAP4qGy3UQyXxXeohA72UPBX2kjoA0eFZmEQmtys4kbms9gEAlrIcVuX9VmxR
vRHaOBCFCMp9dhqbo/U7804CHW3NYgM=
=annq
-----END PGP SIGNATURE-----

--+uuAo5InwkaQdoaN--

