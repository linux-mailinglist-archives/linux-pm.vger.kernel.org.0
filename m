Return-Path: <linux-pm+bounces-35527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F36BA77DA
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7EF1733E3
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C0E28D836;
	Sun, 28 Sep 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="h8PORjgs"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91D226CF7;
	Sun, 28 Sep 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093283; cv=none; b=JI/RZF7t90TQXchiW3gnjWtEHcoiPO9pEETKdHVh/wp7gq698MmXrlN9GFHlalIYuQgbg96vrnGb8PIplsoDxD7YgYfhpcf7KzaFM3XnXv5laMFu5fk8v5rQ6Z89UW+mk18NOsH138sOrQs1s3OlDgGqhXkAW4VrlcQBXsXoMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093283; c=relaxed/simple;
	bh=5HhK7XnvK65/N8XzfAZPaRc4ZNAHp83kybTevCzMBUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGpvtFW71qurguZBMF8za3nmoR3n3KH3UTQZK/3JVBDDeTjmxRWvz4MX6SBg8iltSpvzUsh+S+h71xq4p3n4C6eQAVbYEFnPE7AyOK/+K5iqhp3Bw7yf+LuQqj9xIyz/j/J3LanZQFFMJg66gc/zJalXYiM1e9c6mXvfeeW6Dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=h8PORjgs; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=aupfVz7e9wplaDlsYMjDfHncbZB7faN8jTJ9BwCTw74=; b=h8PORjgsj4t28FG8t0P54L2Rfu
	1KOok0ak82wgdvmBgnhNzzMNuvgXD/oIYYr3hdZaaWUnL6oqsLTWBjmeLCWY5x1RvP/66QV7hGqQQ
	A158LZCzybAQr9k78vVXJCpx2Xg/U8ORw+3vRpwOWy432Pi9anmusm6F1hQJM/37WJoVKtubhXiaC
	DFLcA6uTbinxM7m3JSnbXhYdDf5yBw0LJ/kTiZGlIF8YSIv9wIlEzyCABAPPuk3plzQ1xKXehHYWy
	ZQZGPymt6NiXYwhJtISiknvxQmNZKvqAp740HYUVzFgjeZemeH6W7Rqk5//5leSVjHK7JZFp3o99e
	QdzkYHxg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2yW1-001iHZ-1z;
	Sun, 28 Sep 2025 23:01:05 +0200
Date: Sun, 28 Sep 2025 23:01:00 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
Message-ID: <aNmiDIUzx5eUEOQT@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
 <20250927220824.1267318-3-aurelien@aurel32.net>
 <E15EF3B2FD46EFE7+aNiYuset7FKRo_4C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E15EF3B2FD46EFE7+aNiYuset7FKRo_4C@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-09-28 10:08, Troy Mitchell wrote:
> Hi Aurelien, Thanks for your patch!
>=20
> On Sun, Sep 28, 2025 at 12:07:41AM +0200, Aurelien Jarno wrote:
> > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> >=20
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  drivers/mfd/simple-mfd-i2c.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index 696b602051260..2e86efb0c82b8 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_=
config =3D {
> >  };
> > =20
> >  static const struct mfd_cell spacemit_p1_cells[] =3D {
> > +	{ .name =3D "spacemit-p1-reboot", },
> I=E2=80=99m not sure if this name is the best fit here.
> Since the driver also implements reboot and power-off functionality,
> would it make more sense to call it spacemit-p1-power?
> I=E2=80=99ll leave it up to you.

I see your point, for this driver naming everything was among the most=20
complex things. I have chosen "spacemit-p1-reboot" to be consistent with =
=20
the naming used in the driver itself. I chose them from recently added=20
drivers supporting both poweroff and reset, that seems to all use the=20
term reboot.

> Otherwise, LGTM.
>=20
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >  	{ .name =3D "spacemit-p1-regulator", },
> >  	{ .name =3D "spacemit-p1-rtc", },
> >  };
> > --=20
> > 2.47.2
> >=20
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

