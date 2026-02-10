Return-Path: <linux-pm+bounces-42423-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7tJiD+imlyPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42423-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:45:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15A1190A1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F5A3069034
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2AF341ADD;
	Tue, 10 Feb 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZwFvb4z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE39341AB1
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716546; cv=pass; b=LtujCtpQ67GLsMDAWV6TE1dkGc0TdoJOKzOY9S3/4cDFTa8uUcs/J+6FPwCtfROf6wtfn6MM3hSGaKe/C4OkZAeWLZM7dWpdDxwnkCme6r/fHcNpmKT/KKkh16oqd7lHHB53aD1zfXgyl5MJgNYrlcfPgyvugYsl9yxkv2bVvLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716546; c=relaxed/simple;
	bh=oOjICXJg7ZpifL4ZDE4Mvkawuzo2HaLZVgTlYB0pvHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rP4Uh7cGs63XcJdMhmTaa2JFGLcjfIPhiOGf+iYHL+CFCjAKbEVZ7BwzLJ6jcyaNH4hi43w0DFl8ALpgks/2eXwtf3WuhvlniONlCzC3YOyu1vgty57yLLGNnobGe5IHLpVzkBEm/XHQKAc+D7F7kGUlCEJlXnBFk7R7hdSdtL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZwFvb4z; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-436317c80f7so1804994f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716543; cv=none;
        d=google.com; s=arc-20240605;
        b=Ke4Twrw+G6q6JEfpdZLcCVNBCPJxNGnG6yaCqH/j43r53mOkGvpFqKi3lF20h/WAWl
         Pluwv/L+/ludo+t4rpUUV2/BpX0HYVZXot8CBDLem+yTb+bqZsArR8AkCYW3HsJCvsiL
         4v1HkYSJqOa9ZPHo4LPKVOW/oerSuYus2QxPKZ7Y4aKdYSvXumNaanTIKy+g8WXnaPa+
         IssTN6eJnGwOJ81EIZwHC7oYLmsBSetvK2od6xYxQsnUiNqVeceSgaVIwe9HpE+r7D8a
         uk1hcBBIxsol4f5MB7yLOMx+/Vz9wRvbxUD8hVg8vhp5EhI39XreSE6sKRnNxN0xY/qE
         J+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        fh=aGoWRtdAmH6e30B2Yb04tWyIHDmIU7VNIIXktmuW6rc=;
        b=TTY45i8B5EWJfIszRLznWNTiEdBuHp1vqTSr1wvRD2CHTDdPz+RYWPxKZ7iSFUQuJm
         yW/jIW/kFibF1tWTKleKg7lbyJ8ku2AAlDGLpm8Ugno3ge+Izbb9oqMROa7Qz8wzcLbg
         ReKPctAHLl7wkyTiWCVHRBdu/7VkaYwKHYja2KqL2qqHKa30VpkIZYCIsjmqRRaELDZt
         aW85Qjs3Ci2vB9Swv0wAQHl6hkyKj9rpEGzvnyq5pxl9rj+ZwL6f8wO/ZmRI9omC8mw6
         5HO6iIVwwk2skcHY3liiMrmQE8p5nVlDPTYM0I6dAHx4nPCCX4yckGGpjN9Wj/INxTVS
         3O2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770716543; x=1771321343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        b=MZwFvb4zWxnfekjl+a8fsLfYtrscT0ebMy+djosDK9zMn1NLXNNuNkeJQ+YZDUZQSh
         tcLsWoxPOHXM5b/VVpDIbtS9/eMQysU7DEuHttnRlEIfhi72G94wQcIDA7I3fwtUs6rj
         nteoasqj8yMgzfcoesAhg58ZN4/uNGulmZC/d67iSwERAp7Mt+Jkxa2JWURr4iEkYGFy
         oWBK9pnh/KpCD9NvHu7tDrSq5ISoB9FqNFpd0X2E75oWHDjPuoLdvUe22FRymBGnvtBr
         cQthSGiuHgb/OH0zZ5bRLvrG3MUTNNcN1zPQOw4y/lRDOibeI+JZU3YRdmS7oBTm9slr
         OHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716543; x=1771321343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        b=Y7fW2WQEo7unm8/8q2sIMFLmkecujRrBvnp4OL7QtF7GNwM5rksiNZJFqiroSjhUwc
         qO8s06job6ysS/GH3znhdSPdiE+4rC7d7iJrIQ3fSYLl0OmfkgQWcbuF60KH4ZwJwK5W
         p8Qv6yMyG6mUH4R0+84fcitBQj8Foptkq1cYJq1Mw2mECes3uSEIQ2XWbP2/5IYFddm0
         eGFgGlf+VdGwTj2sNzzJOrF8hQYTymDcqf0IL+iXhKt/UkAHGgR2xv+SM1b5hg3aYPB/
         +l/YgxJOrsg/yg66kDNxNDfdKHK9Pnj4+drL2j09aU54U49DhQ6b0o/0Eoy0PgP5nPdw
         7JBw==
X-Forwarded-Encrypted: i=1; AJvYcCXtQLG7aPDSdANElreUflYUyoVik1dWrFlnnpy6aBsDjFxVMeFqZDOQoZqSlc/ST05eM/KAc29+5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZysScfsFzgxQMmPK6ox44QXmEXjiE/OWQO0FHdJ+sjxWU9IBD
	4dCyUqG1yGn4M7BdEaTrEcc8deiPs3A8nWodkRs4Joe6WK/kyyP3NDdaIubm9hVeGaQ9F29FSRZ
	WTpqQBWwqmKSmnMyIMOGsGHK8wMPa/vM=
X-Gm-Gg: AZuq6aLwVrj893u+R494asmf32W6saVU7eOITG3v0BfarukifjXd8arSeKFcjuvT6U+
	OpW9KlPyyJEmkmivdgZB89gEhLYlD/CgCtR/AsWdVg7kY/yqmHSXfIVzt8VoCT0zgiRBl0lwjnc
	O4sRc1NCmC4EOyIYOmv0okAa1tHv2YEEef7GLVA7ukUyqQhRI2D8m9IohiG7UWDF2NfdWknmKaW
	R2p+Le+dQ09sYj1s7OWmNS2hATF6TEtyYQwIxng9+1HQcgLyqioTpztbMcEeF/BEle3NXFQlSKA
	r54dFuZo
X-Received: by 2002:a05:6000:3111:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-4377a1f2a30mr2055191f8f.25.1770716542552; Tue, 10 Feb 2026
 01:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-2-clamor95@gmail.com>
 <20260210-hidden-swinging-galago-fdcfa3@quoll>
In-Reply-To: <20260210-hidden-swinging-galago-fdcfa3@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 11:42:11 +0200
X-Gm-Features: AZwV_Qhn-R0xjZTEGY6wy39uV3chiY2pUKepim55rxxDwQzXQ4tGrjUlByAc-JY
Message-ID: <CAPVz0n3Pzvzt+LmOH_peCtpx8DP2-GiRv--6-ppQUaa51AXRFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC DockRAM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42423-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E15A1190A1
X-Rspamd-Action: no action

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:25 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 12:43:59PM +0200, Svyatoslav Ryhel wrote:
> > Documenting an I2C device used in conjunction with the EC on ASUS
> > Transformers. The main function of DockRAM (the name used by downstream
> > ASUS sources) is to provide power-related functions, such as battery an=
d
> > charger communication. The device is exposed as an individual entity
> > because multiple embedded controllers can utilize the same DockRAM
> > instance.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b=
/Documentation/devicetree/bindings/misc/asus,dockram.yaml
> > new file mode 100644
> > index 000000000000..0cfde619ba01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
>
> Not a misc device. Find appropriate place, e.g. for EC or docking or
> laptop devices or power-related.
>

Why not misc? be more specific pls where you want it to be.

> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Asus Transformer EC DockRAM
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  Dedicated i2c device used to provide power related functions of the
> > +  embedded controller used in ASUS Transformer device family.
> > +
> > +properties:
> > +  compatible:
> > +    const: asus,dockram
>
> Way too generic compatible. You are not documenting here all ASUS
> laptops/devices dockram. For example this implies dockram is also on
> ASUS Vivobook... or on any other asus device.
>

Asus were not so generous to provide more specific data, they call
this device dockram in their sources.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
>
> Device looks weirdly empty. Probably you have it only to instantiate I2C
> handle, so what you really wanted is i2c-parent. This is not a real
> device.
>

WDYM? it is a real physical i2c device located on a i2c bus and probed
by i2c driver just fine. Maybe you will deny RTC being a real device
like it was done for example for max77663 which now causes a massive
issues since it can occupy different i2c addresses?

> Best regards,
> Krzysztof
>

