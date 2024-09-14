Return-Path: <linux-pm+bounces-14289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2E9793A7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 00:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E71F222B5
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 22:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC514373F;
	Sat, 14 Sep 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHxgIOuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14D6F066;
	Sat, 14 Sep 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726352587; cv=none; b=jP4bSnz9CGd/1p/DVWq2za9JU3Q9Ia6pqUz6/OvkLhEdIctbyNUDFeEsr4kpjGSm0WxEroYG+rc2KSpt0TxQf6sS0JzZDNtJem+3s5lGDCtVwKrxX2xcXml6kq6CalOt//DPT22i3afaVCyUugdqTJE9Vtwxs3GSIz7VhmlmjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726352587; c=relaxed/simple;
	bh=6f4sJYGh10WHP6XIIiyMztxdnYvZzcortC5SK3D2qz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaWdTmv/j0TQpYHEoYsZrQ6g7TytcPhpCjjqdWtXh0noASRkcH0tMS2YXzN40lszR3dzaWjcd6p5fv4twm7XsXUEX3rqcDhm15RmlZJtEpUFXLvwntstkdB96F7Jxav/b/rVINE9+6gmYQS4GrFRDw+CkUth9M2dS3awEH5hCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHxgIOuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3A3C4CEC0;
	Sat, 14 Sep 2024 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726352586;
	bh=6f4sJYGh10WHP6XIIiyMztxdnYvZzcortC5SK3D2qz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHxgIOuQx4qk2R9Sbd+XDWF/uz80nTlxayfdXhfmsK3wS5bEZKtYlOvjlTl22pcJh
	 ESDVwL1+wHcr3iKbSD5TN6xtMp/yVd3ou7sST4areIk3F12j7JxsqkW8PVM3wlIWV2
	 rc33vBeRhx/cpcT64h52+X2ckq8A8hn8fxFfeaqoc4yfYbZPV5wFHt+YiPcGK1AHV6
	 SlQDhhZuKJE3PVcADFoi/g7jP8L1BB5Sh5e6WqxaHiE57kq/zbTi0UF9DAAdrenb8+
	 AMQ/+Y2NTUql924V+tS61XjzRKFq5veOAPhf7UqlWccIPI70aDligyRdZrRK0EPeI+
	 fSHg3eZdN2I7Q==
Date: Sat, 14 Sep 2024 23:23:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 03/22] dt-bindings: cpufreq: apple,cluster-cpufreq:
 Add A10 compatible
Message-ID: <20240914-jiffy-scheming-356866ebc316@spud>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
 <20240914052413.68177-6-towinchenmi@gmail.com>
 <2ebf5258-b55d-4010-aa94-d5bab1f93bb5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ki+UkIw/U+rQPBsd"
Content-Disposition: inline
In-Reply-To: <2ebf5258-b55d-4010-aa94-d5bab1f93bb5@gmail.com>


--Ki+UkIw/U+rQPBsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 01:17:57AM +0800, Nick Chan wrote:
>=20
>=20
> On 14/9/2024 13:17, Nick Chan wrote:
> > The block found on the Apple A10 SoC is compatible with the
> > existing driver so just add its per-SoC compatible.
> >=20
> > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > ---
> >  .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml    | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cp=
ufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufre=
q.yaml
> > index 76cb9726660e..e0d1a9813696 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.y=
aml
> > +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.y=
aml
> > @@ -24,7 +24,9 @@ properties:
> >                - apple,t8112-cluster-cpufreq
> >            - const: apple,cluster-cpufreq
> >        - items:
> > -          - const: apple,t6000-cluster-cpufreq
> > +          - enum:
> > +              - apple,t8010-cluster-cpufreq
> > +              - apple,t6000-cluster-cpufreq
> >            - const: apple,t8103-cluster-cpufreq
> >            - const: apple,cluster-cpufreq
> > =20
>=20
> Have to retract the cpufreq patches, a v3 without them will be available
> tomorrow. cpufreq works on iPad 7 (A10). However it is already pretty
> weird when the cpufreq did not work on Apple TV 4K (A10X), with adjusted
> p-states. However, it seems that iPhone 7 (A10) is also not working. So
> this is definitely broken. As far as the hardware interfaces go they shou=
ld
> be compatible, so the only explanation that makes sense is that the behav=
ior
> is not correct on t8010 and t8011 and it only *happened* to work on iPad =
7,
> with some incorrect behaviors.
>=20
> Marked as deferred on patchwork.

When you send the v3, make sure you pick up the acks I already gave you.
I didn't check all the patches on this version, but I think you forgot
to add some.

Thanks,
Conor.

--Ki+UkIw/U+rQPBsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuYMwwAKCRB4tDGHoIJi
0nrkAQC2FOhcj45xEZCSUn6OVcREvB72MdKx61HqWuqQJGOMWAD/XyehiQe31kxj
nK74z7sVmXbM5Wh7UgZSbbwg5cj6CQA=
=ruKL
-----END PGP SIGNATURE-----

--Ki+UkIw/U+rQPBsd--

