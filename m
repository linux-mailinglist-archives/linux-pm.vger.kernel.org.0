Return-Path: <linux-pm+bounces-42074-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHZrGWg+g2kPkQMAu9opvQ
	(envelope-from <linux-pm+bounces-42074-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:41:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCEE5EEC
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790A43013EEC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADC3F077B;
	Wed,  4 Feb 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgxOCnFp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4637A4B5
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208856; cv=pass; b=r7X7CgYJ4ubKmoZ6U36IfsrFDxKcOKsrJAifQ6kR8L54bDA+WWQ31qRcVp0o0Fakf3mMlMZlQTGy/SNL7ek2B5RWtLiYB6gKWps5+Y+b0JIl4SXnfkgEm3IaY6Oc6Dyxae8BZu2ey4S09egF1qnb5x6KPc72PFJ85y/D/xYHKs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208856; c=relaxed/simple;
	bh=VVoqN1cbo7saKNRizaznTRjcFiDowh+PjgHqkK04EXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMjgyLBvYhvICc8QtOpRWrZGHo1GmsyBxaPALhImlHdKNRwpHS0JqpABqGY+kMpbD6ItpPXxRn8RF3dTAOn0DY+kBUF+aTQN2oPbO+5tOMOuRJxZ+Dt+fKMbgi5AdoG1YdpY4cjFX+6N+mdABNFG9oJHDzJJ8TGFemoUQfOZOIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgxOCnFp; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d256c2e6so5416881f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770208855; cv=none;
        d=google.com; s=arc-20240605;
        b=ZYEDghzYqX4+Tf0zD5JccjL05y+eI1s3lKMS4qZjW+2H0j8hnYbO0eT2AlQsTYRWst
         x2UN2MBgpIiwh4sVXuNkoWs0uvEOrr4dshIoIjDklNvWpy5BuQtTF+3fcC6DUegDz4qE
         Pl9yTpilnlgZWXpNN18kSq6r0ewgaLUdC0q26JVceC5vKteB2G4AD9LuRWg9RR4BdXSt
         tCIrtFgfFGR9gqWeko9IFbROiHMJmTlj6bP9tRFS9vdivcet7kvrxN1mFzhmmHNfuged
         KMgnpO9Cl4RVUjKYXrNomzNYexEl/6z7XJlE3kKVTpB0s/zYchzhQ5jABOd20ZKbi4DX
         DAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        fh=mF/PC73Kj7OakwYtdPOq5HIUWBvtJKJ2/2P2DNs0RG4=;
        b=BeCHZ9EIumIB3gmzkLbkDkh/gLOXaWIH0CtI9xlTZkz7Bg/XbcY1zbBGZbatVAxJpP
         46bRyqPBvsQj0ZjuffwUmEnCRpm6VbeBBHJ6w0oefllYwPIxdNcqtlyp/0/R9YiAi+Yz
         mXavH90YMORxdTw+o/C2GkMKG3Rjm42cxBZqCkOklVsC4ejnz3+GfYGz4oabB0kTp6vO
         qNxTV2sg67Hu+4TNA2DxBzQlfwKyj0pwTDcrMu/bWTBA1CP02mSOAPN9ytUVkkzGuOCb
         9zrosqUT8gjVJ2ZRxRsbiRA/AtQwF2Bqm6Ec1iVxv5hth+Uf/D6NAZY2zQE48wDSdqQW
         dgFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208855; x=1770813655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        b=XgxOCnFpLIcB14A1aqEtxqTxGYRcjFq2R+iF1g/G5VUZLLl4achDnCyhdFu/2VotNv
         LY9MiT9k8Wicu+tPAzFZyowDFRtmAbjsOAcqM66SIJZhT4kJEd29ilyOsreQ/H5f6XQs
         /cc3ApU/IfhiZYMgbwF7uCnjd9/t5aA43XjucmuSNE6UkG+Gy8ClfhS4JX0CADP/YNP2
         uXEd6w/MNVVlDGqklHl/H5uCrmyGfGJHw4ETON6HTPIbv2OjvZVm1xaiXmsYs31a5XTU
         IPDe0+IG98N/866vOVNahnRtXxTavtQxwwO+xalzKfes4S37JBAiS6WdbUj++rcS9CaS
         pRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208855; x=1770813655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        b=DB4HDiqInVPdJXmO68WHj4tbyRj0l9nLxcWz/k0g4llYIeD8nVScJXwtpvTMobg8UG
         sfXOSPgD52h6mFEBtpF9kH1P3esb2ghAORUO1ThWsaXrF5IG+7oai3XDt5m7ag/4zNLO
         YtFKCgd3hDHn0WdDbyr3a4QJoF54IyL6blUb8YSbVV5LPylTikGAAw2vAhm6tMp4ZXWo
         x9fhoLAMDPU76Ogf1a/kvpcd0X1gjYXubIaEzDPDupJhZ86ruLCa0XqYprHYEqQc3JNK
         np6scQu8HbPFvXnlHMaVTxNrBzCkmuXKlVkoUQX0YMt4CnNxHl4Y0zqWHe3+WIhseGbB
         lKlA==
X-Forwarded-Encrypted: i=1; AJvYcCWucpZ1emV1OHc9BBS4kIyIzASZhjOY4ewQbvv/OAvvhX2EH2ErxgyejLsCG2jec/elpcg1PysExA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRr1Rt0RfS5lFr0qHM3KKPFweO4ffnvkjimUBxosTYqsMhixIj
	6PN+TBMA5+e5/oG0UoxfrJJMs4Mv+IQ6I8uIXY6GgITboPFD5TiQkpn3cDR974NiRkyt1u5gRKZ
	MilJztLY5cytYckZ/KyG1vnqIKg6/p0I=
X-Gm-Gg: AZuq6aJ74rmgJHhYbXropGf8LpNjEXNWk7ZE3GMF4UY8wmpqzPLrl94eVBqdzYwvgWg
	tiTdUDHJMkrlSYstPhIbfZ8OO1We/JVa8XHX0fYvUjiGvnclCZeIFx9y8TQ2qYpvT6oAxGbbEse
	fzkIY0wZVMLMb726xNsm80WaFo10rulRtIgbNX51GURILzR7qSaPa+Pu44ppI28JGIhrYeo7R9q
	JWZENYkyDsY5L63b5G41sR90hqFWQI3fg+QPWJ+JMJzYf25RtXZfbUXEZ653r2L92uPOukV
X-Received: by 2002:a05:6000:238a:b0:431:38f:8bc4 with SMTP id
 ffacd0b85a97d-4361805fbf4mr4039864f8f.61.1770208854743; Wed, 04 Feb 2026
 04:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh> <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
 <2026020314-humbling-mobility-c24a@gregkh> <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>
 <2026020347-mushy-lunar-d12d@gregkh>
In-Reply-To: <2026020347-mushy-lunar-d12d@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 4 Feb 2026 14:40:43 +0200
X-Gm-Features: AZwV_Qgnx8Hqpc3gLtz5e76GzgExX_xLHyQNYXgz5FpI0RojQ_lqa8cEDXcBX9o
Message-ID: <CAPVz0n0jrRxPQD-g7Pq-koDTW1Wr_FxNZc-SmY2-eE71dfei+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42074-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E3BCEE5EEC
X-Rspamd-Action: no action

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:58 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 06:50:01PM +0200, Svyatoslav Ryhel wrote:
> > > debugfs allows you to do much much more than simple stuff like
> > > BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs=
,
> > > that is NOT what it is there for at all, but rather, that is exactly
> > > what debugfs is for.
> > >
> >
> > I am removing said stuff from sysfs, that is not what I am asking.
> > Debugs does not allow to upload register values in a form of binary
> > block. It allows only dumping via debugfs_create_blob or
> > debugfs_create_regset32 but not writing. If you know examples of
> > reading and writing register sets as binary data, please point me to
> > it.
>
> You can easily write your own given that debugfs allows you to use what
> ever file operations you want to use for a file.  Why not just use that?
>
> > I am asking if it is possible only to preserve dockram_read/write
> > functions in the code, without exposing it to sysfs.
>
> Why would you want to do that?
>

Nevermind, everything is good. I have figured it out hopefully.

> confused,
>
> greg k-h

