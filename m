Return-Path: <linux-pm+bounces-31691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B850BB17243
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3333218C5E46
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D413DBA0;
	Thu, 31 Jul 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s2aPDoKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3422338;
	Thu, 31 Jul 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969586; cv=none; b=C6DX64EWtQIVBSFTEW4AtKewveLHIOOZFgB1kpa1WnPEXpeXjSrnH3MndmlflZgxYdxfPpcoSy89kPNLAWOvhjHIpD3bhmjq41wv32sDJvUl9rk2tV5IU/6JSaRA+6N5Z70XtxwEK1uO/gfjMlO9Yv31CilFKy9AqR4VufeuE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969586; c=relaxed/simple;
	bh=EdfR3+ghXfvid8Ak9BFhtOhrGJNHg3UqEP+sC26bPJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1F4as/Hax3Th1V97a/7OWiaRFCRTtd13vbWhn7fbRAcX1K7R5oNff0D7ASyCrAZ9/8unZ2oJ6fiQk8KuoS7FlGnp5ytBFG3xo/k05RGdhFqNU8JqU/5xB22e0ayWSV0OviRqLDhAoSRkV02fklseuE74K6jHEBnr2hqbUMvyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s2aPDoKS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=EdfR3+ghXfvid8Ak9BFhtOhrGJNHg3UqEP+sC26bPJo=; b=s2aPDoKSHYE2kKRj6gIVVD1GOV
	fcyxAWhVigRK5nmd4r39qvJYfsh15mYv+up49sLyMVgmgm7fdKeXj6Tz8jcov+sqW47LaViq+O/08
	FiCKhEKVmsqLmQ0JaxVWMq4ng6kFiYqGXXUx75iOnj6mx4t/NmSeMMj9FH9AsQb12ZZ55EQQgHLnP
	IE0IpOIQkNRTLTp0NQKMuk5DBt+odJ9HJ8FN9vLyk29Z/24LDNtQ4lKOt9lEoGZmmEAHFhbSTLMVC
	b4OYu5XIloViojkcFakmlrrMcioISbGwOtsjg2jyrZ+B2nvw7ptg8weOVx0KeeA2p+xD6aM6MZPfu
	Oz+uHF3w==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhTbQ-0008Cv-68; Thu, 31 Jul 2025 15:45:48 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ye Zhang <ye.zhang@rock-chips.com>
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support,
 including OTP trim adjustments
Date: Thu, 31 Jul 2025 15:45:47 +0200
Message-ID: <2664626.Lt9SDvczpP@diego>
In-Reply-To: <iafobb7h4nphjcujm34gig6vwlzfveegwewpayehb4h3tayzgv@bxpdfmhf2hfa>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <3560770.QJadu78ljV@diego>
 <iafobb7h4nphjcujm34gig6vwlzfveegwewpayehb4h3tayzgv@bxpdfmhf2hfa>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 31. Juli 2025, 15:27:03 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Sebastian Reichel:
> Hi,
>=20
> On Thu, Jul 31, 2025 at 10:11:23AM +0200, Heiko St=C3=BCbner wrote:
> > Right now we're in the middle of the merge-window though, so everything
> > I apply now, I'd need to rebase onto -rc1 in slightly more than a week,
> > invalidating all those nice commit hashes that end up in the "applied" =
mails.
> >=20
> > So I'm struggling with myself on every merge window about that.
>=20
> Your are not supposed to merge anything to your for-next branch
> during the merge window anyways. See first sentence of Stephen
> Rothwell's mails [0]:
>
> > Please do not add any v6.18 material to your linux-next included
> > branches until after v6.17-rc1 has been released.

The general idea is just merging but without updating the -next branch,
then after -rc1 rebase + do new -next.

But as you pointed out, this is all cumbersome and doesn't shave off much
from the amount of patches waiting, so as most of the time, I'll just wait
for -rc1 to start clean :-)


>=20
> [0] https://lore.kernel.org/all/20250731133311.1a3e3867@canb.auug.org.au/
>=20
> Greetings,
>=20
> -- Sebastian
>=20





