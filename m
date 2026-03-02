Return-Path: <linux-pm+bounces-43447-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OBFEG7upWlLHwAAu9opvQ
	(envelope-from <linux-pm+bounces-43447-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 21:09:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08A1DF240
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 21:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B65830488FD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20636330B31;
	Mon,  2 Mar 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="L8Gn3Obh"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590521D3CC;
	Mon,  2 Mar 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482152; cv=none; b=Bw03pkpE7L31ESvKmKZyEG+5qC4R/gXKA6oyvFBBCYHEGYZifc82gmhMHM2QM32UNzBbTUlgThw2M3r+wJ3yF3u/+ct/ryl3vIi7WIazf52P5pQlsCsUOWGtr8toOEhfQ5qBwQes6OBkfntz2OWdv3a9Tt66a+sZNlbd5hzMVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482152; c=relaxed/simple;
	bh=teVWVpZi8I2gppKw9vPHGEjqeBAZSadaqN2z40LzGqE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3ziTtJ06MkhXbNdhneDuFU5GMECRfP1jwNsnWZBNricDUCp6AB+MwfKi1h75nPwYEd3vLyNlEWY0SO696ufFPgJJd3ALVyr1wyfARq1sNzv64ZLs4wBaKoGav2+npKjVYQC2TMLA7ZBbgVMkSHwuPwnYKzjH82Y2/dxRDLtqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=L8Gn3Obh; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Content-Transfer-Encoding:Cc:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=3+zY78mylit5/fdujgN7gsluGF7Jzq9S48A1C8Ytv1M=; b=L8Gn3ObhH/saBw+CuqV4l5WOTv
	RJOPtfC780LFjQ0NDKj5DaYMeEoZBqtwKXedJvfPk67SOUvAYDwE+M0NpBPMnDRFbQ69S4wdkMK1H
	515agvtqnisdhWJ9YObmpXe8WrayHDWjx7nqXjfCJnFQ+Tl/llmfIC0Q9qal/CklI60OmhH8W62Qw
	i2EvXN7Ywk1QBtRMdhrfBabXy/EImPO56+Jt4JTRn/7+anYguBCevoKp57iWuaiwZFgN3/msDwZju
	wqV96uvnU/j4vh2XX5I9sF0GMaHVZpAzFCZmp3c7d39RJFSVlf1VMnTvq0K0Sr7Da3Py2hIUXHPTR
	dKl/WWNg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vx9Zc-0000000DNAz-0LDs;
	Mon, 02 Mar 2026 21:09:00 +0100
Date: Mon, 2 Mar 2026 21:08:59 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yanko Kaneti <yaneti@declera.com>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
Message-ID: <aaXuWwyA5NzBZzlW@aurel32.net>
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
 <aaC78FTN31QYaVg0@aurel32.net>
 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
 <aaS6xeKFZz06fb1_@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaS6xeKFZz06fb1_@aurel32.net>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Rspamd-Queue-Id: EB08A1DF240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aurel32.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[aurel32.net:s=202004.hall];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43447-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aurelien@aurel32.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[aurel32.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aurel32.net:dkim,aurel32.net:email,aurel32.net:url,aurel32.net:mid]
X-Rspamd-Action: no action

Hi,

On 2026-03-01 23:16, Aurelien Jarno wrote:
> On 2026-02-27 13:29, Yanko Kaneti wrote:
> > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
> > > Hi,
> > > 
> > > On 2026-02-26 16:32, Yanko Kaneti wrote:
> > > > Hello,
> > > > 
> > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> > > > > 
> > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > > > ---
> > > > > v5: no changes
> > > > > 
> > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
> > > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_config = {
> > > > >  };
> > > > >  
> > > > >  static const struct mfd_cell spacemit_p1_cells[] = {
> > > > > +	{ .name = "spacemit-p1-reboot", },
> > > > >  	{ .name = "spacemit-p1-regulator", },
> > > > >  	{ .name = "spacemit-p1-rtc", },
> > > > >  };
> > > > 
> > > > Perhaps its safe to merge this one now that everything P1 and I2C is
> > > > already in linus tip ?
> > > 
> > > Unfortunately, this patchset is still missing:
> > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com/
> > > 
> > > This means the reboots work most of the time, but are not 100% reliable, 
> > > and that's the reason why this patch got blocked from merging.
> > 
> > I see. Thanks. Sounds to me like sometimes working compared to never
> > working is better , but anyway..
> 
> I agree with that, but the decision was to hold on this patch until the 
> I2C PIO part got merged.
> 
> > FWIW  with this patch and the pio patcheset I get this rcu splat on
> > reboot (which is still working). Similar splat is there without the pio
> > patcheset.
> 
> I haven't been able to reproduce the issue here after 10+ reboots on a 
> BPI-F3 board, but I tried the patch on top of 6.19. I'll try to build a 
> 7.0.0-rc2 kernel and report back.

I have tried that, and I am still unable to reproduce the issue with a 
7.0.0-rc2 kernel and a BPI-F3 board.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

