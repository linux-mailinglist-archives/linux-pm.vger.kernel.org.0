Return-Path: <linux-pm+bounces-43448-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hl0KOEHpmmRJAAAu9opvQ
	(envelope-from <linux-pm+bounces-43448-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 22:57:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056741E4657
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 22:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E209D31525C1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082392EA468;
	Mon,  2 Mar 2026 20:34:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 78A0038C433
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.105.196.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483683; cv=none; b=WhadMKNNTqeieYnEOSUjTGPfp4+LHg8jZEFqtuMM2pAEcxJzJySqBnJmvztWqtTAFHYIRBPPCpRfBMCZvTOxBF2Zm52HirtEZ+B79KzL9rt0a0lD2za+UZrkwPNpvAaEDvUIDJOb8AFSkiRULOOvb0tR5JPZGDl39703/JBRBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483683; c=relaxed/simple;
	bh=MSNT+vzSoz8JEVbz1InyC14pAK5t6L7YnAyF9maZEtQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cod6/R+SccbZKmVUEhIwl2fXKAtrdPxe73pC34el+VSiWod0zXmJ5urhNNHggHipMxI8o0kbUxiRGwitxuIS9aAyO0rQkL3SE64fFQKzOt63TayfWLYZvMpa3D53Yc1OlRo3IhzVIRiNxLOHlyiwOxGJtPtn/202QDnoYJwq53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com; spf=pass smtp.mailfrom=declera.com; arc=none smtp.client-ip=193.105.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=declera.com
Received: (qmail 19022 invoked from network); 2 Mar 2026 20:34:33 -0000
Received: from d2.declera.com (HELO ?212.116.131.122?) (212.116.131.122)
  by indigo.declera.com with SMTP; 2 Mar 2026 20:34:33 -0000
Message-ID: <36f8df695463e5ff3eaaffbac357fc73026f7373.camel@declera.com>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
From: Yanko Kaneti <yaneti@declera.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org, Lee
 Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Troy Mitchell	
 <troy.mitchell@linux.spacemit.com>, Yixun Lan <dlan@gentoo.org>, Paul
 Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou	
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, "open list:RISC-V
 ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>, "open
 list:RISC-V SPACEMIT SoC Support:Keyword:spacemit"	
 <spacemit@lists.linux.dev>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"	
 <linux-pm@vger.kernel.org>
Date: Mon, 02 Mar 2026 22:34:33 +0200
In-Reply-To: <aaXuWwyA5NzBZzlW@aurel32.net>
References: <20251102230352.914421-1-aurelien@aurel32.net>
	 <20251102230352.914421-3-aurelien@aurel32.net>
	 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
	 <aaC78FTN31QYaVg0@aurel32.net>
	 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
	 <aaS6xeKFZz06fb1_@aurel32.net> <aaXuWwyA5NzBZzlW@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.3 (3.59.3-1.fc45) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 056741E4657
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.862];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yaneti@declera.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aurel32.net:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43448-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[declera.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hello,

On Mon, 2026-03-02 at 21:08 +0100, Aurelien Jarno wrote:
> On 2026-03-01 23:16, Aurelien Jarno wrote:
> > On 2026-02-27 13:29, Yanko Kaneti wrote:
> > > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
> > > > Hi,
> > > >=20
> > > > On 2026-02-26 16:32, Yanko Kaneti wrote:
> > > > > Hello,
> > > > >=20
> > > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> > > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> > > > > >=20
> > > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > > > > ---
> > > > > > v5: no changes
> > > > > >=20
> > > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-=
mfd-i2c.c
> > > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
> > > > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > > > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1=
_regmap_config =3D {
> > > > > >  };
> > > > > > =20
> > > > > >  static const struct mfd_cell spacemit_p1_cells[] =3D {
> > > > > > +	{ .name =3D "spacemit-p1-reboot", },
> > > > > >  	{ .name =3D "spacemit-p1-regulator", },
> > > > > >  	{ .name =3D "spacemit-p1-rtc", },
> > > > > >  };
> > > > >=20
> > > > > Perhaps its safe to merge this one now that everything P1 and I2C=
 is
> > > > > already in linus tip ?
> > > >=20
> > > > Unfortunately, this patchset is still missing:
> > > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-626942d94d9=
1@linux.spacemit.com/
> > > >=20
> > > > This means the reboots work most of the time, but are not 100% reli=
able,=20
> > > > and that's the reason why this patch got blocked from merging.
> > >=20
> > > I see. Thanks. Sounds to me like sometimes working compared to never
> > > working is better , but anyway..
> >=20
> > I agree with that, but the decision was to hold on this patch until the=
=20
> > I2C PIO part got merged.
> >=20
> > > FWIW  with this patch and the pio patcheset I get this rcu splat on
> > > reboot (which is still working). Similar splat is there without the p=
io
> > > patcheset.
> >=20
> > I haven't been able to reproduce the issue here after 10+ reboots on a=
=20
> > BPI-F3 board, but I tried the patch on top of 6.19. I'll try to build a=
=20
> > 7.0.0-rc2 kernel and report back.
>=20
> I have tried that, and I am still unable to reproduce the issue with a=
=20
> 7.0.0-rc2 kernel and a BPI-F3 board.

I can still see it on every reboot (with the patches that allow reboot
to work). Do you have CONFIG_PREEMPT_RCU in your config ? its default on
when anything PREEMPT is selected. In Fedora its CONFIG_PREEMPT_DYNAMIC
that flips it.

Regards
Yanko


