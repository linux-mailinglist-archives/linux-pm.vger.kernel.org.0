Return-Path: <linux-pm+bounces-13855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35B97080F
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD99B1F21CF7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D116FF3B;
	Sun,  8 Sep 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="wwhC0S9W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEA167D98;
	Sun,  8 Sep 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805120; cv=none; b=JmlEkZIEG5c31O3gx/0SFRhh6Bh4y3HSPUUdEaXab0GWgfjDhk6YcLx5bnXFcRBQGqM0LvRJ+iLhdco5OP2nmuxyUmQQH+XuUJ5ySrtYbdxyLBePyRL1ahdZOScn1I4TTq8QfFc1P936TJJssifblvAkiXbfS/OmPIXpz82ev3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805120; c=relaxed/simple;
	bh=KdCAkpSxWToj01hG+HMh8F5JCx/jJz0b//tp1btl+C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh/nYssnvaCGX063asVoRAaSKgRjdikBZihA3aWW2/9C3/sYsZHHZxXBfnG2CEpgWcjOaCU01WqCw1WyvSPNfrJeL31gRB27sZFkhXUHzMLyetZg42Ecd7dfk+ZraBmhWFLjTmzkJBjNhpxFcCk8hUFZjOPXNzTBWLa/pOwVCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=wwhC0S9W; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1725805097; x=1726409897; i=christian@heusel.eu;
	bh=KdCAkpSxWToj01hG+HMh8F5JCx/jJz0b//tp1btl+C4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wwhC0S9WVRsi4O5FxruWo0xqIUOkGcC4mXZuI1wm2P41Wkt4D3M8WVJCgXe9ptb1
	 bAcKBPoA3j+NaB2hI+IQ9iLFiMEjEYflzIaHXYD+a7UPxHQ5V+jOcZI3wvSkcFi8y
	 wm/ZrpQGig/f+00ByPi5O8kKXmqRRlaJK899RzSS/evrwKzQyzFB/vTDmfqpTij3C
	 plc0bOw/BciA8UGqHMSLyrWH93khs8tDXYTeQBDXZqBlTZXTX5bvfvRAK117j2pvC
	 lsLDHZFtzB51eyB8BwNPVm8aNoMXtEDBq3i1gknORc3VitwgKP5aCWVzVFXQfuMAa
	 SsvYDCgrq5Q8YfZPuA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.147.242]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Md76B-1sEF5H1OoF-00baVj; Sun, 08 Sep 2024 16:12:32 +0200
Date: Sun, 8 Sep 2024 16:12:28 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	"Jones, Morgan" <Morgan.Jones@viasat.com>, Sasha Levin <sashal@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	David Arcari <darcari@redhat.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "li.meng@amd.com" <li.meng@amd.com>, 
	"ray.huang@amd.com" <ray.huang@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: linux-6.6.y regression on amd-pstate
Message-ID: <2ffb55e3-6752-466a-b06b-98c324a8d3cc@heusel.eu>
References: <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
 <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
 <2024090834-hull-unbalance-ca6b@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="untl3rwejom3jhic"
Content-Disposition: inline
In-Reply-To: <2024090834-hull-unbalance-ca6b@gregkh>
X-Provags-ID: V03:K1:byAXoZ49ubmpQ/IDV9pyyVQ7B6JQwh4qm/+uY0bdyXg0SmFpe2Q
 d2XCEqlc498HgvZ8ZwsKZhiDOHOT8ktPby9kKzHuM59LSiAKWgCkaIqR4N1/R8QTlieDeBA
 +XGrJyTwiqzdH9438Iv8Wj0hXR31vXSnrlTCSVftyvExnZXkEfA7p+8l1f0cLKaPAS65+Bq
 I8IPU4FSbNL25k5GbI0Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LgCtJWv2B7o=;0AZrK6xlA2XBd6eH20YkaZjsxfr
 y6sDjo/yF+q1PCXre5o/tob9a5rDaZDJfmRg9ccIoEixgvhZ+ivbAbZS1PvqeedhHsK1vyKPP
 +Fjc2bnctG+kaQX0XQJtyJgMG7gXfddLKukasgJintak1rYW1d4cM2HEi5YsRp3En+MtBGyM6
 bc4WV9Zgg6fzWEFomob2aR2u4Ido8mca4bBv2GfAl+wKrVvcEw5MyS73MXa6x1zBOcWBGrpaU
 H42aPADS49e9P5Om88t5MEjekJe6c+YjCSzTXZYZP2/fEoNF+JqELs/yTav9mW26q8NlSzUSm
 qYpyAb/7vRMnUaEfxDuhE/qF6sjkgQaHyR2qFd2gf7QmV5orSWNvBlbsmThSXZiBfxOsykE+E
 fO4Wv3ul7q9Fo8Kt31vNwh8oWjP/RWrY3mJ64wU1ym23xOvkaYkImKQoe9RH9C/KilRkIjX1e
 7RUnotVGXWIANpsPkIxVozfcHXSUWBdyKfwn0hvpGnXWyY9Ut7jIJEy9NjII/VvjUldbl5zlz
 aaMzRK99fhj1GJgcUZySqxZJQtbrutTCNZwhxbBjGXaVU56CD33ynbinnFo/PZUQwe6fh3U7o
 nnZ9JGCk5BAJ/dac5qQU9fBooXFXue57Hd5oNtdWmVHDcIC2w1weJqEhPPvJR5QneC3zCRP7T
 PGRfGoDeZyFkzAlIGNLXyszMQ9/NOIBPgALssIXLlH7Tp/1Ra7TQk5YsZ+Uyvv2OmZSOyqsqI
 O2xGidifP3pRW1ooGW5KVuMcVitx2gq0w==


--untl3rwejom3jhic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

On 24/09/08 04:05PM, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 04:14:26PM -0500, Mario Limonciello wrote:
> > + stable
> > + regressions
> > New subject
> >=20
> > Great news.
> >=20
> > Greg, Sasha,
> >=20
> > Can you please pull in these 3 commits specifically to 6.6.y to fix a
> > regression that was reported by Morgan in 6.6.y:
> >=20
> > commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest perform=
ance
> > value")
>=20
> This is fine, but:
>=20
> > commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred =
core
> > support")
>=20
> This is not a valid git id in Linus's tree :(

f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core suppor=
t")

>=20
> > commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency is=
sue
> > which limits performance")
>=20
> And neither is this :(

bf202e654bfa ("cpufreq: amd-pstate: fix the highest frequency issue which l=
imits performance")

> So perhaps you got them wrong?

I have added the ID's of the matching commits from Linus' tree above! :)

> thanks,
>=20
> greg k-h

Cheers,
Chris

--untl3rwejom3jhic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmbdsMwACgkQwEfU8yi1
JYVV4w/9H4ueQtb8WDM5BBv8VgFqn+YZm7UAGRKLmAGzzTH963Ormkp8gU30ksAq
SRzLc5rTbZ+tnefQdKIS4QRhkaor+PB5h1hoak3VZY39k/71mJH7fgUIA+wTHiEY
lTZVjxBg5HsGSSzQtZU5ITan11CMQgti9AGwsq0ZZLk2OjxgMl3DF+SCWAme3nH3
xzQXS6rXN/JIAYh7F5inMlP7caGAN9Wqalgb4aaVii0E9saHQZTVHnxQB5socxpV
aksCf+d/R3wArxN+sMConEf0doGSaBqNazb+Jz62xw7fGNkKAj21pAd4DiHYRhSM
82Fwwz4fMjq8T62Hqtv4rrB+SVAXVfslKt7YZfeLqRkCpffUNNGxfOzFzpjDJt25
lAXEwy2YsSvWq6hRSQksO0Lpx6+EnhCQVnEBpzeqQih40QU3PJXFuZIXnydF1Px8
RdjfSr4grEqQUV/vQMup8xDuGTqCy/nsht567C6gWemXRSONs4McffX+aEVnWYde
5y0UVKlR9GX9Rw6WxQyxGehS706HCQtTH4K0LIStLPs1G/ZXhH5hT24qN91E5iEk
QlpIP75kpe3uSb2HP18qr3lNfpO9wIebODQ3M9j7+9tQrQnNbzLwBzdlE0nSK9rY
COt/Gyq5abVMMfMnXQKPI9Mnif7Md7CAa1OfRQdFiuI9usmI56Q=
=qgee
-----END PGP SIGNATURE-----

--untl3rwejom3jhic--

