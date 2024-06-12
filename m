Return-Path: <linux-pm+bounces-9022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB5905763
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F010289E2C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D917FAC0;
	Wed, 12 Jun 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5Y3MI/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD71EB2A;
	Wed, 12 Jun 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207435; cv=none; b=XOHE2FnEBA/Y64Ezl26t45/hkMcLIlM4JN8tvAn/XA+gEWiiSB4GgFhRjrBkq+M7lzeEjS0D9JfYXIrcVmbp90QgjwmnppGn855EhrmVanW+tRNonJjK/ZcxLhQ7tsS2en+htIo4vtmOPQhfVBeU3nCblmSdq7FvEv4u8GqY5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207435; c=relaxed/simple;
	bh=cKWhkSC1x8cZV8isG/jgbKgy/ctUabseIFqwF1XkN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEJFpyhm9X+T4/mK/A38PRJY7CwPA5KQ8dcIOA8a77Df1Ze0FWOg91Tew4UdnlGUoPdRJ1X8R7zdUUGjjHj67gigByerxldREGRqI6wghxIKxRYldk6DWb22enid7HxMYVjGb03ogdMCmRmYCPMGkoulEpril5SauBU22KjDVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5Y3MI/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411AAC116B1;
	Wed, 12 Jun 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207434;
	bh=cKWhkSC1x8cZV8isG/jgbKgy/ctUabseIFqwF1XkN8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5Y3MI/HC7SzVrtHukUtWRDtUxhnHG8HARTOcOJiu2NtZA+/LoS+RnWQFs35D60zg
	 KEUvBb49BscZODsl0eelcYB+Di1EN9ZwwEglhlYPhwmcJXxKl3UQO/mKp+5DMI/hPQ
	 hVauIyHIg/irkZE92LiEutqknF/A3pbwxfdnT8w19cTYB6KZELFIRcV6+xy2ZykPO+
	 /ur0JSfTto17hiKaYAT98XOf0ff/9FsdPUucMR8zfAgWojhyZYOJJeAzitSzAodaJW
	 Nf7qI4c7Nhwj0JCi8eYatBXCRTI7tqgHCj1NL1NHuhOTJK+gtFUqKCokG2MTT9np+/
	 LViHhlsErOKwA==
Date: Wed, 12 Jun 2024 16:50:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Message-ID: <ZmnDwKUlXCWFJ8W0@finisterre.sirena.org.uk>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
 <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
 <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQUPfIPcfzsmHwJv"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Cookie: Your love life will be... interesting.


--cQUPfIPcfzsmHwJv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 04:28:37PM +0000, Biju Das wrote:

> > So, it'll doubtless not be a surprise that I'm not thrilled with this - it's basically just
> > punching a hole straight through all the locking and reference counting in a way that's just
> > begging for abuse.  At the very least we should have a check for exclusive access in there.

> Do you mean exclusive access by means of spinlock to avoid race between enable/disable()?
> If that is the case

No, I mean regulator_get_exclusive(), this clearly can't work if there's
more than one consumer.

> > Also it's not sure about that name, if we were doing this it should be more describing the effect

> What about the name regulator_hardware_enable() to make it generic??

Possibly.

> > on the regulator rather than this happening to be done via a register write (this should also work
> > for GPIOs...).

> Do you mean to make it generic, so that it works for both regmap based enable/disable() as well as
> gpio based enable()/disable()??

That too, I was mainly thinking about the name here though.

--cQUPfIPcfzsmHwJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpw78ACgkQJNaLcl1U
h9BgqAf/VRo1z8HnprjKJzamhqdpLugyr1xSf2Gw8i7hZJlRo+UcEZBJ0FA9qwY6
n1bmhPT7OL1n3j+NI8eEoQVnIRlz4yucjUrwSgqIfl8bIFrMrxFKSS+/eV2J0CxD
SzY4u6DqQF4jLgZ1TURMz3GyiCZaOeL0o7bYbPLo75uGAPD5n23gfw5b+0akgMaN
kQ8s9Udu6fXsn3bUrbEKn7ekxv7cyRSvfJp2/GsNXMi3jfWwwS5bwhJSBrU0p2N7
0Rv+9m3KzZoq0SKRrQEQTWKMTm9jpGnILdPhEv4bpFeikEjvGEKL3hMNu7HaHy+j
M4S6xFkbfUygjcUPcJg+LQJ0s0rcgA==
=Fwf/
-----END PGP SIGNATURE-----

--cQUPfIPcfzsmHwJv--

