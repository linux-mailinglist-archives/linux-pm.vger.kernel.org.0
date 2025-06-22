Return-Path: <linux-pm+bounces-29212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F612AE2DAA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E4F7A7F33
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A422094;
	Sun, 22 Jun 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="f+3EfA9y"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041EA29;
	Sun, 22 Jun 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750553472; cv=pass; b=Znewi+cj4aYxSHtVOK/+N42UWr/PdQwwkUFVk0vA/gsGK6Bv6kPjG/hzs9QPeD9kxrjWwjGs7pmvU9VaDtIyCu7JP64wIQh788KlQSHZPyld7CL2T/rxCkIfoRQPwYgbdoW91TuybzAHTwMKheR4eGdUpJurA3N9yPXqQS9QOP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750553472; c=relaxed/simple;
	bh=eP4cyAVzJysY20FB2yPSJBaBtIXAbyQKZqa8mZ2WuN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZxo78xHbe3HcOlXf1g//14HWZGxUPEFmAwymhsRp+raY4YdLK095JsRNGRlog2wqWdBpM+th2wKfQSnYysTnkpEa3tQ3TRftefzb8rJvH5c3Ebg7EwGbs5AtopJWeLvUxMR/3xeWeQOowJYUfBZ6YOfj4ZutEWGRgThvR8ar40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=f+3EfA9y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750553434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nTaZPuxdEjw5EDw3tPF6Qy0HTEagp2m1aPmSyKRU2f+HJ4+u4ZC9f9ngF5plydcBC9kimI5uBnGvZW1ulzgKNnL3OTVtWFNbwWu5fIcuR2q571R50jIQsJVnfwvJRyo5awpB1R0KUQNeWe6IQABQCXGhl2E48HfHk3DK3Co/Mhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750553434; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=urvg2EBUVSXLilCyfEaHeQbpskk5FRYN4N/flVkvV78=; 
	b=VMwG6vR1GWzzfCk+Cx29KkHCudiWzscFawcybcqqs6bzMGajtS1tj+BohE9OpogqjM4tnDrOnbkVmS/ssCvr4wn2nMO8ofiGtwuwVAOEyibWApOl3/OTLFoA8RT2+Bsy0iBJbPPGD0KhjBYciUTt84Qr4RPzxpaw6YzPak7nVfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750553434;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=urvg2EBUVSXLilCyfEaHeQbpskk5FRYN4N/flVkvV78=;
	b=f+3EfA9yIO3WRuPNshg8xFVyn5cJqqTmm+HuH6SYP2wxA8YbGSB9NVhIfxv1Srqu
	g78eV9eGHUVlWk5ocPdAIe4R9O5qpDtklKq5fy+NKC4huRj++YXYgvw4q8DYOmHA2Vg
	BsJH1d6xAxvoJ1mU3nqshGz+Ejf3jcaht79PvMpI=
Received: by mx.zohomail.com with SMTPS id 1750553431554582.0728404463048;
	Sat, 21 Jun 2025 17:50:31 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 15EE4180692; Sun, 22 Jun 2025 02:50:26 +0200 (CEST)
Date: Sun, 22 Jun 2025 02:50:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sven Peter <sven@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <pqjz6jyfsoaf5matffwsly7ba6xwbw5fsumokmpow6eox7vjdx@fbuxkcjjyh6n>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>
 <20250619114958.GJ587864@google.com>
 <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xcojizk7w6niahmw"
Content-Disposition: inline
In-Reply-To: <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.540.22
X-ZohoMailClient: External


--xcojizk7w6niahmw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
MIME-Version: 1.0

Hi,

On Sat, Jun 21, 2025 at 05:51:33PM +0200, Sven Peter wrote:
> On 19.06.25 13:49, Lee Jones wrote:
> > On Tue, 10 Jun 2025, Sven Peter wrote:
> >=20
> > > The System Management Controller (SMC) on Apple Silicon machines is a
> > > piece of hardware that exposes various functionalities such as
> > > temperature sensors, voltage/power meters, shutdown/reboot handling,
> > > GPIOs and more.
> > >=20
> > > Communication happens via a shared mailbox using the RTKit protocol
> > > which is also used for other co-processors. The SMC protocol then all=
ows
> > > reading and writing many different keys which implement the various
> > > features. The MFD core device handles this protocol and exposes it
> > > to the sub-devices.
> > >=20
> > > Some of the sub-devices are potentially also useful on pre-M1 Apple
> > > machines and support for SMCs on these machines can be added at a lat=
er
> > > time.
> > >=20
> > > Co-developed-by: Hector Martin <marcan@marcan.st>
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > > Signed-off-by: Sven Peter <sven@kernel.org>
> > > ---
> > >   MAINTAINERS                |   2 +
> > >   drivers/mfd/Kconfig        |  18 ++
> > >   drivers/mfd/Makefile       |   1 +
> > >   drivers/mfd/macsmc.c       | 498 ++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
> > >   5 files changed, 798 insertions(+)
> >=20
> > This is ready.  Let me know when you have all of the other driver/* Ack=
s.
> >=20
>=20
> They've all been reviewed by the respective maintainers.
>=20
> I assume you want to take this all through the mfd tree and we'll need ac=
ks
> from Sebastian for power/reset and either Linus or Bartosz for gpio then.
>=20
> The one line change inside drivers/soc/apple would usually go through my
> tree and I'm fine with taking that through mfd instead.

I'm fine with the power/reset driver going through mfd once the
recent probe discussion has been solved.

-- Sebastian

--xcojizk7w6niahmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhXU1EACgkQ2O7X88g7
+pp5mBAAqeYtgkz3ot6SuhXbvwuOhMII4zpE8jhfW1y9qUm85/HabSF/PRrM8fTX
mrOmos/ImxU32f83/mPZshVf0+mESLu/t8jEcfWUZp9OCDWwIP22zJ0BScizgWpg
d6vfEd4K8zdCjpEwNTmghrqahi7gGfapSzfpOGoZ7yLnGSp19rWdfG8CvQ4BI6b6
EIy+2XySeO6V2n+fGt/78Td4+LVQ8k6gm6B/9/grN5WP2OBC2KwTSAsmieBXXpCD
GBT911zqqYpJ3wfaSndyeztq1sOfKH6feAYTbCKjlz2frvOG5A+0A2nRLD4UXvCW
JQmbyzwj7d03GFgqOIa95RyYZL2C0H3gdw1ZV+KO5OCGKIHWcrbRGsUnU0gzSyQj
sRP6gLNKPNXeIgcvTBVNAiuy+NA/UUTzovImxl47hAO1jfbqjMc4rGYZVGwqYevJ
szl41k3EmNjCU+Wb7Wm3xoQLb7xhjPBd4CbZBBnxJ9Zq6aRSTgyHPV6Q09/X7npU
SJG9k/V+dqhpRWtSyhJVsQ326oWDeNatp5iSKU+ZCaLN3QI+7ouH0pAi/MPlpeoq
UuK9iVt2lITPAvuHZ07XKQUHjxa/5tir3DpJJP2WAVPQM/n7ejypyXh/SHolX8G8
M5BUD7E9puP4hgXS8ETreeIi0UlYz/STD6ck27xMFk8yVIyyyik=
=Yc2m
-----END PGP SIGNATURE-----

--xcojizk7w6niahmw--

