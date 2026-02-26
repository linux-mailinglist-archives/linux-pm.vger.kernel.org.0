Return-Path: <linux-pm+bounces-43275-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJo+CljAoGk1mQQAu9opvQ
	(envelope-from <linux-pm+bounces-43275-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 22:51:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77E1B014D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 22:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D813037ED8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1936C593;
	Thu, 26 Feb 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="lSamVMAu"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD324677A;
	Thu, 26 Feb 2026 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142626; cv=none; b=f/EjAblWTQ2wK9mjQTuZ1t3S4bS+EYET7wsxD/ZG+O7iJlYVAK3KlojLBvC61TT9Dpl2TzeQAdydBzOtCKesP4Sq+RBVnvDSkOGbbC251hCJeM03OYJUOgsR6CxbLOGzCc27Q6S82G0Q62G/jwLwxAwcXhp5imrnV3Bl52YJ/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142626; c=relaxed/simple;
	bh=XlVnbkQv+KgOMqXOkb/YTXqihqrtCt6/49DePVPrNgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeRD+YnQ7ZdhjSF5tGjYvpCCIxR3mD75lwTy6dte5TYOnEPUjer053v4c22jTFzj4cB8rWMbKthFz870LxZuZWVCAe0rap1SQ1uxohnTlu43LXnISXPSO5JYlweR3poDHpaZOpFrSoLXbFhe5zutQm/cuqa/ak2C4pgG+i2KqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=lSamVMAu; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=pEo3m7B3INBJlM8bhz6ltlUxFqOUPxhSBYLsN/1EwlM=; b=lSamVMAuYYH3idjj5lTpd2a7jX
	+wBZ66r2CZ9iHUnEdPN7RXBNxrJKEGQt8LWSMdOP+iI8sPGErj6lmKfM31meZM3huWa7C1v5XYoi1
	F3shYzQAMI2d8mwwG3L3ZqTCrxskky9Bq+fQo+Aq/zhWKX/w0ozGPN3j4cvXOXTa/SC2FCsaAV1jt
	Q2300RVGUdE+ZOL8w6p68qJrWK9aJkRxM1cOtyWtxitFiZBmLFrkPtKFp4UsyFYh3pT2rIWo4mJo9
	9q78BhF0wp/swRuh2ewaZj8wOtuge85Ezj3t/vgsWTbg4XL14G60eqB5WLQ2C/RFd6e8ssd6eaC2R
	KqeF+Tlg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vviyH-00000008Bi9-1YrI;
	Thu, 26 Feb 2026 22:32:33 +0100
Date: Thu, 26 Feb 2026 22:32:32 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yanko Kaneti <yaneti@declera.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
Message-ID: <aaC78FTN31QYaVg0@aurel32.net>
Mail-Followup-To: Yanko Kaneti <yaneti@declera.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <20251102230352.914421-3-aurelien@aurel32.net>
 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aurel32.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aurel32.net:s=202004.hall];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43275-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aurelien@aurel32.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[aurel32.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aurel32.net:mid,aurel32.net:dkim,aurel32.net:url,aurel32.net:email]
X-Rspamd-Queue-Id: 8A77E1B014D
X-Rspamd-Action: no action

Hi,

On 2026-02-26 16:32, Yanko Kaneti wrote:
> Hello,
> 
> On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> > v5: no changes
> > 
> >  drivers/mfd/simple-mfd-i2c.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index 0a607a1e3ca1d..542d378cdcd1f 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_config = {
> >  };
> >  
> >  static const struct mfd_cell spacemit_p1_cells[] = {
> > +	{ .name = "spacemit-p1-reboot", },
> >  	{ .name = "spacemit-p1-regulator", },
> >  	{ .name = "spacemit-p1-rtc", },
> >  };
> 
> Perhaps its safe to merge this one now that everything P1 and I2C is
> already in linus tip ?

Unfortunately, this patchset is still missing:
https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com/

This means the reboots work most of the time, but are not 100% reliable, 
and that's the reason why this patch got blocked from merging.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

