Return-Path: <linux-pm+bounces-42943-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL/IEkKSmGkfJwMAu9opvQ
	(envelope-from <linux-pm+bounces-42943-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:56:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C40169828
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC4D302C6ED
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF172F690F;
	Fri, 20 Feb 2026 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="Wl8EkULE"
X-Original-To: linux-pm@vger.kernel.org
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39972EC0A1
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606587; cv=none; b=I199F8ceik1kKwkAkOe7QgBHJlFQMGBVgcF0ChTWP9ZplT33UzSeCUzOn3YIvwn127iJwghIFh+xNqDlhuZhA/0978+GeGd+5cWg8pK34UMJ2O6Rw15I0fskxxTZx991TYToqFATAYUAFgridvTxGk4Uuc7SQ8U26OTiwvNhL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606587; c=relaxed/simple;
	bh=8D9Y1XXC2qdEK5lv2ngWbb8ZY8WcwD0gpYfssancm0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WfyP1V3Q6q7vXfDoR4to/tNSB6PS7YdQxxDNFLgNAuMmivNWF0YudmAbXeJIhy/DIPCs3B+CTkZ23t83ejHS/CYj/7Dq0VkEN949jIkkT3/+El/d0z/p1hbmd5+YZGp0bC8N8ZqWtK6iMxyI1Ts5zgBHPmt2WLGNvLAQNH/4w5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=Wl8EkULE; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 5DA0B6E86D9;
	Fri, 20 Feb 2026 17:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1771606584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0lld6vPE30NQltxwTbPT1iVmbe7L/OOthusNPaOsLo=;
	b=Wl8EkULECxUNWFwP0xk/j1XeHstIdG7Zvpg4HpIoQyf8y/2LFS6WWIY0KlWnGY3YXlPUAP
	ESbwKUfHUVIJRKVBlqZYUrIpDnnMnSvhnKZS1KMV5imA7mmM9Jat9yGzRXNhEjU212VEEc
	1CPlZ19uDBa8naXSKQ/AATLbodr8NKksYlWPEHEa0DNdbUcWIu8lBJlsrF7GvhbCtpo5Dc
	5pbNtFyrGpWnja5OmpOUDh1dEDrqHX9O8kmjIudTc88NB7118VifEtgp1mH+LuqTZIgjHK
	gYe2a0ru+srsKHnx287wEHeiGi+C1LRxCsBQJVyCY4+K9QsnXd/EkWZOACJdmw==
Message-ID: <4cf24e281fac45637fedf40944d8b5230c0e22d9.camel@svanheule.net>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
From: Sander Vanheule <sander@svanheule.net>
To: Kaustabh Chakraborty <kauschluss@disroot.org>,  =?ISO-8859-1?Q?Andr=E9?=
 Draszik	 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>, Pavel
 Machek	 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 MyungJoo Ham	 <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan	 <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Fri, 20 Feb 2026 17:56:22 +0100
In-Reply-To: <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
	 <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
	 <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
	 <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[svanheule.net,none];
	R_DKIM_ALLOW(-0.20)[svanheule.net:s=mail1707];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42943-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sander@svanheule.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[svanheule.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5C40169828
X-Rspamd-Action: no action

Hi,

On Thu, 2026-02-05 at 21:02 +0530, Kaustabh Chakraborty wrote:
> On 2026-02-04 15:23 +00:00, Andr=C3=A9 Draszik wrote:
> > On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
> > > +static const struct regmap_config s2mu005_regmap_config =3D {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +};
> >=20
> > No cache? And what is the .max_register value?
> >=20
>=20
> This was in the previous revision, but I ended up removing it because
> (at least I thought at that time) interfered with interrupts firing in
> some way. The actual issue was unrelated, so I will add it back.
>=20
> However, there is also another thing I see in logs:
>=20
> sec-pmic-i2c 2-003d: using zero-initialized flat cache, this may cause
> unexpected behavior
>=20
> This is due to REGCACHE_FLAT, I am not sure if I should just ignore
> this.

Sorry to be late to the party, but I'm somewhat responsible for that warnin=
g, so
allow me to chime in :-)

What you are might have been seeing is REGCACHE_FLAT giving you "cached" va=
lues
of 0x0, while the hardware actually has something else. This can cause omit=
ted
writes, existing (bootloader) config to overwritten, etc.

As Andr=C3=A9 suggested, using .num_reg_defaults_raw is a possibility, but =
then you
have to remember that the register defaults are taken to be what the hardwa=
re
state is at that moment, including pre-probe changes. These defaults are us=
ed to
seed the cache (so far, so good), but this may break the contract of
regmap_sync() if you ever want to use that after actually resetting the PMI=
C.

If you want to use the flat cache, I would suggest you use REGCACHE_FLAT_S,
which will track what has already been read from/written to hardware. You w=
ill
also need to specifiy .max_register.

I see the other regmap_config-s in this driver also use REGCACHE_FLAT, so y=
ou
may want to consider switching those over as well if these are also showing=
 the
new warning.


Best,
Sander

