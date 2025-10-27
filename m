Return-Path: <linux-pm+bounces-36878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1FC0C93B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BE4F3A99
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28992F12A0;
	Mon, 27 Oct 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LA/mC7Gv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwiKYER+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LA/mC7Gv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwiKYER+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06C2FB967
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555827; cv=none; b=tHEv+5PAIFsholmHA3x4NJYnSW5ER9M8oX9TBkLhr8rg/42TgXgoZlzYa0GUP8peH36esYTFMhAv8A+v7MWHflN0KMdZoT4mMeqnLc3cCpIVJIISwaHe6tickD5oQJ7U2XvNG/bKh2gezFU+dxPHIbl/OzjKGmoED8GYhrpLcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555827; c=relaxed/simple;
	bh=vQPs3K6Ka4RKxdyvekcQUqD4Pn6qxfT7zetNE77Dp/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZayZIMHsvVYdvkGv8RPWLXo6bIN2pf1TOjOFsVLIHZkMG5DziS6gji6oJEVU0WRTduA7GE1JZqS+8Z6e5zC2xS+LI7LoJoqjsK2QBtbXi1DIQjpXWf06twFTuFZDZIOT/lYruis80RwqQd3vi31qTDyW8w6gVbn7/hOa+AScdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LA/mC7Gv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwiKYER+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LA/mC7Gv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwiKYER+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
	by smtp-out2.suse.de (Postfix) with ESMTP id 411041F387;
	Mon, 27 Oct 2025 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMBkmHj4Il5WIq7tDNPinD42JrN2hAdCrLiWHZU59ug=;
	b=LA/mC7GvBSYag5NCN1zSBUpPzUZIZrpIP0cSg2PNRiMcYySavYblijSOy6uT1pCpQccP2y
	AMpExBsBSqiwti/wph3D/5Q+tLEFv3DsshFY6CuprLJq/VgfgSISg4fgByDR4Zc5aFJnAt
	OAaiGtEAwwU4iPNT41OaFyKu3ng+qBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMBkmHj4Il5WIq7tDNPinD42JrN2hAdCrLiWHZU59ug=;
	b=xwiKYER+J7hn7pFMSEntBZ6A3dku7r5fvF07Y4j0KGHkHL4z/Sg2MLPTOFvm05reGdMqmp
	CHE++/6NcY3FFcAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="LA/mC7Gv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xwiKYER+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMBkmHj4Il5WIq7tDNPinD42JrN2hAdCrLiWHZU59ug=;
	b=LA/mC7GvBSYag5NCN1zSBUpPzUZIZrpIP0cSg2PNRiMcYySavYblijSOy6uT1pCpQccP2y
	AMpExBsBSqiwti/wph3D/5Q+tLEFv3DsshFY6CuprLJq/VgfgSISg4fgByDR4Zc5aFJnAt
	OAaiGtEAwwU4iPNT41OaFyKu3ng+qBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMBkmHj4Il5WIq7tDNPinD42JrN2hAdCrLiWHZU59ug=;
	b=xwiKYER+J7hn7pFMSEntBZ6A3dku7r5fvF07Y4j0KGHkHL4z/Sg2MLPTOFvm05reGdMqmp
	CHE++/6NcY3FFcAw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 2ECB84A05B4; Mon, 27 Oct 2025 10:03:44 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Yao Zi <ziyao@disroot.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  linux-kernel@vger.kernel.org,  Lee Jones
 <lee@kernel.org>,  Sebastian Reichel <sre@kernel.org>,  Yixun Lan
 <dlan@gentoo.org>,  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti
 <alex@ghiti.fr>,  "open list:RISC-V ARCHITECTURE:Keyword:riscv"
 <linux-riscv@lists.infradead.org>,  "open list:RISC-V SPACEMIT SoC
 Support:Keyword:spacemit" <spacemit@lists.linux.dev>,  "open list:SYSTEM
 RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
In-Reply-To: <aP8QHwsYDlbQxQJo@pie> (Yao Zi's message of "Mon, 27 Oct 2025
	06:24:31 +0000")
References: <20251026224424.1891541-1-aurelien@aurel32.net>
	<20251026224424.1891541-2-aurelien@aurel32.net>
	<A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org> <aP8QHwsYDlbQxQJo@pie>
Date: Mon, 27 Oct 2025 10:03:44 +0100
Message-ID: <mvmh5vk67in.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 411041F387
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 2.59
X-Spam-Level: **
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.59 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLajr16mudzow8bnf6sy)];
	RCVD_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim]
X-Spamd-Bar: ++

On Okt 27 2025, Yao Zi wrote:

> On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
>> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
>> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
>> > chip, which is commonly paired with the SpacemiT K1 SoC.
>> > 
>> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
>> > done directly through the regmap interface. Reboot or poweroff is
>> > triggered by setting a specific bit in a control register, which is
>> > automatically cleared by the hardware afterwards.
>> > 
>> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> > ---
>> > v2:
>> >  - Replace the "select" by a "depends on"
>> >  - Remove outdated Reviewed-by
>> > 
>> >  drivers/power/reset/Kconfig              |  9 +++
>> >  drivers/power/reset/Makefile             |  1 +
>> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>> >  3 files changed, 98 insertions(+)
>> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
>> > 
>> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> > index 8248895ca9038..61c16f3d5abc7 100644
>> > --- a/drivers/power/reset/Kconfig
>> > +++ b/drivers/power/reset/Kconfig
>> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
>> >  	help
>> >  	  Reboot support for the KEYSTONE SoCs.
>> >  
>> > +config POWER_RESET_SPACEMIT_P1
>> > +	tristate "SpacemiT P1 poweroff and reset driver"
>> > +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> > +	depends on MFD_SPACEMIT_P1
>> > +	default m
>> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
>> I believe that reboot and shutdown are actually essential functionalities,
>> so it might make more sense: default ARCH_SPACEMIT?
>
> I don't think there's anything preventing it to be built as module by
> default: even though it's "essential", it's unnecessary during kernel
> and userspace startup, thus I see no reason to build it in the image.

Wouldn't it be needed in a reboot-on-panic situation?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

