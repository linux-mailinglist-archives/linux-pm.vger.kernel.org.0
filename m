Return-Path: <linux-pm+bounces-43267-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH52HjtboGm3igQAu9opvQ
	(envelope-from <linux-pm+bounces-43267-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:39:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117031A7BBA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2027300DF5C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C413D3327;
	Thu, 26 Feb 2026 14:39:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5B043332902
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.105.196.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116785; cv=none; b=EK92Ww7Zn9Z0rzz5wDNq49kIShhlWs0X9BF64iGcHJM0xQG7yhha5hvkPpO6GEb8qDOGPC+3KUQVaZGg+j9bMxNJUXT4vUg57CCdLGimjYAiUZt75z01TlxvBGv8EQjin1K2bOPk0f5f7m5tECvUEnuxJNdJpJe5E2X3lgEKAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116785; c=relaxed/simple;
	bh=jUnVLRlYIjWKofi/vKDPcNK99SnLf7jH9tN/5zFXfrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWvsMKMAdaDpU152udxNG9jgHjVkZXHhSKv5lhr6CmrEXuqncFTCy18j+XXg/dI0iELueJQ5aSpwzXGdPkUDATW0uV0EsjvrIk3sR/iDIAI+5yXMYmGikPtFrFI5PpxTV5LC+r4XTgbLIPSi3LGp1fFlmCWdYUv1/KedlYqA79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com; spf=pass smtp.mailfrom=declera.com; arc=none smtp.client-ip=193.105.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=declera.com
Received: (qmail 21106 invoked from network); 26 Feb 2026 14:32:58 -0000
Received: from d2.declera.com (HELO ?212.116.131.122?) (212.116.131.122)
  by indigo.declera.com with SMTP; 26 Feb 2026 14:32:58 -0000
Message-ID: <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
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
 <spacemit@lists.linux.dev>
Cc: "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Date: Thu, 26 Feb 2026 16:32:58 +0200
In-Reply-To: <20251102230352.914421-3-aurelien@aurel32.net>
References: <20251102230352.914421-1-aurelien@aurel32.net>
	 <20251102230352.914421-3-aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.2 (3.59.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yaneti@declera.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,aurel32.net:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43267-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[declera.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 117031A7BBA
X-Rspamd-Action: no action

Hello,

On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
> v5: no changes
>=20
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 0a607a1e3ca1d..542d378cdcd1f 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_co=
nfig =3D {
>  };
> =20
>  static const struct mfd_cell spacemit_p1_cells[] =3D {
> +	{ .name =3D "spacemit-p1-reboot", },
>  	{ .name =3D "spacemit-p1-regulator", },
>  	{ .name =3D "spacemit-p1-rtc", },
>  };

Perhaps its safe to merge this one now that everything P1 and I2C is
already in linus tip ?

mainline + patch + dts bits enabling i2c8 on the OrangePi RV2 and R2S
allows both to soft reboot as expected.

-Yanko

