Return-Path: <linux-pm+bounces-42586-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vmq9DyI5jmluBAEAu9opvQ
	(envelope-from <linux-pm+bounces-42586-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 21:33:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88057130F2C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 21:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13FB1304B023
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725262D0614;
	Thu, 12 Feb 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irfRbt7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DF21C16E
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928413; cv=none; b=oj2eNSMQwl7OKleFPmoJzUC8xjfGJH7ZcXyDDSyeaseqcWCwe/SBzIBresXwf/hgRMz0tqcPZoOI8AFZoOMOAR/Lvc6CqJaJPBLrF1u94cIB4/Q9KptekmsVotPKuqVBkXgIsxMM1t2g3OsykPUGJ/p6pLmrwVppD4LE0d3KYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928413; c=relaxed/simple;
	bh=GnVOYFS1dOs4ytjskGYRNbag345ulKuZ+IaQUN3bwJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjlMA/VQmF1HGlkAMkYEGUr2N++Ji9+WaseB4hXujQyx03nSK+zOp/4rGnxNducVlH92jIYlcA1UX2CGYyKCRKoS4/CUsMAHMfWMEWftJZSn8pYP0gdNhKXEU4t88/XjHItxWVRiRwgSov0GbOI+CfXuIHwct3qpY6LspJsrvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=irfRbt7K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362507f0bcso171900f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770928410; x=1771533210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GnVOYFS1dOs4ytjskGYRNbag345ulKuZ+IaQUN3bwJk=;
        b=irfRbt7KDGQMMfULLyinfvoxkP/hz+aooshWz3GdSJHtAnlDu1FHGnHxAuOUqbTz+k
         m3bePX4J2eKz0Xdi2WFWc+s9uXzdzZk6E0O4CX+VaI/M6SXRPwt5P/BO0F84JLLDpEen
         Lmz7s9Wq8G71G0MFVKUg04VgfTOWEsAMnmGETOPAjhYnBWrFku4zvuv1YWBWXcmJYkGW
         ZHss5nV+gnmW+knAaVTX0+8z9SBpPWU3k0nvj/9NFqVLUb3sGBmXu4R4608KAXyfv9Dc
         qY6HzyBDELOwu/MCdwtaHhGy+d64ZhRNqwiQuTNSn+X0diclK5SEJ8wW8iERbYgJepsf
         qKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770928410; x=1771533210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnVOYFS1dOs4ytjskGYRNbag345ulKuZ+IaQUN3bwJk=;
        b=engLvc7DwLZs6amEs1ecVh1AF4Qsc1vY3N6kRrD/jg4y+avi+4Y0gCqNgU4jRAoML7
         BgAhGwpylB0Dj+3CMyACfgXWKtSbWt/rIeojvvDQn5E/ZIVBqX4EX5/6ud9A3I4Z3LCJ
         khPvzJ25Ah6sFOl2ppPiNDZCa/h/H+d6KWvlEYhRt6+mfraRMTVFHxT7gvzVJVibfUNn
         3yBQosuDmDe/QVbeiJV6BLHww52lXPL982ELzoQgUAtGnRz1LT89GIO1a4fzLNeL+ZGm
         Pk1886HMH2ADbYPZnYX1L3Zw1/1TUhrvHeQCyLMSfo426i9AMziFACMYUKTP8cOL2o8O
         qqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWu1uwS3ACQFIViVurh0sefjq2fOb/pp1RSUx2ckQEcP+bxZ/n8G8TDzdmcQSFgzTLOQCiKn7L+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxepiI7DQ2sQqoQHxOJJUyx5hHMJyimK2TZ9RyCyZLDAua9a6Ar
	5wFnNl5RpXU5K7yIAXqy30nuvgLqtoev+PG4CvqAnctBQUeqFBuitW4OFOQhTMJ2vjE=
X-Gm-Gg: AZuq6aJGINtXmTin/5JIvckVHNcdeBTjJB737prTrZxDYKiirS1we12LwzvFJngkV6v
	GUW3Vp5t7dn1Jy/dSSePEFPq1GH1PECP46E/J5uVgs/FpsE7xbJ1YPpQWFlgYqe+LZCkOmG/72B
	XSlvjTPdVtj/kHCp57TkFMDiaNECVjyy44JiqZdXTycA2VTEmTOmywcKLPyOwzQIAb0yfkhXBVv
	iO6dcacc1X5avbb7MdNwyJrW6/fMhHG5sxY9k69wEY9qfHPwdqsUxLVL5V90kIL07U6DheBpqjF
	bQ7QZBSug3go/VF961FCifByFYZMgyPR/QSuebXexHt735qd9sFv8RCPIsTa+xmOEY/SvwCiX4u
	upW6mH9mB3HALH+yLSDOfQucB5k060HGpQiyTtO+GOnm6csmnT6L2bTr6yVCusb1E1ijKAr22Du
	K5716mKvF/WeDnuaberLsmWTpRiLG8QX/IxUuSVc6C
X-Received: by 2002:a05:6000:3113:b0:435:9e81:105e with SMTP id ffacd0b85a97d-43796b22389mr268014f8f.19.1770928410444;
        Thu, 12 Feb 2026 12:33:30 -0800 (PST)
Received: from draszik.lan ([212.129.82.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac9d77sm419495f8f.33.2026.02.12.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:33:30 -0800 (PST)
Message-ID: <f190f9a211a69bf5200098f9d26a40b117ff7953.camel@linaro.org>
Subject: Re: [PATCH v5 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Ulf Hansson	 <ulf.hansson@linaro.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Date: Thu, 12 Feb 2026 20:33:33 +0000
In-Reply-To: <CAL_JsqKKig8ePmmMZH=QagSyw0d=FKrORTxKzj7HOZqd0jLZFg@mail.gmail.com>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
	 <20260205-gs101-pd-v5-4-ede49cdb57a6@linaro.org>
	 <20260211211229.GA3882182-robh@kernel.org>
	 <b5078af810a681333043f64d71b7d6ea55ff44bb.camel@linaro.org>
	 <CAL_JsqKKig8ePmmMZH=QagSyw0d=FKrORTxKzj7HOZqd0jLZFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
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
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-42586-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88057130F2C
X-Rspamd-Action: no action

Hi Rob,

On Thu, 2026-02-12 at 14:06 -0600, Rob Herring wrote:
> On Thu, Feb 12, 2026 at 6:03=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
>=20
>=20
> "google,gs101-pmu" represents some specific h/w. That h/w either has
> power domains or it doesn't. So which is it?

It does have power domains, they were missing during the initial submission=
 of
bindings and DTS.

>=20

> > The compatible doesn't change with these patches. So I'm not sure how t=
o make
> > your suggestion work without causing warnings for existing DTs. We can =
either
> > have an old incomplete DT+binding:
>=20
> If this is considered incomplete, then you are going to complete it
> and add the child nodes? If so, then the warnings are appropriate.

Yes, I'm going to update the relevant DTS to include power domains.

> If you were going to maintain both bindings forever, then you would
> probably want a new compatible. Or just drop the properties from
> required. Note that if you have child nodes with 'reg' and parent
> missing #address-cells or #size-cells, then dtc will warn about that.
> So it's not too important if the schema doesn't.

Maybe the commit message or footer comment was clear enough, sorry for that=
.
I never intended to support both old (incomplete) and new DT.

Dropping from required did cross my mind, as I also saw the warning about
missing #address-cells or #size-cells in that case. Missing 'ranges' would
still not trigger a warning, though.

So does my above explanation mean you're OK with the patch as such? I can
reword the commit message a bit to point out that while this binding update
breaks existing DTS, I will update them as they're simply incomplete.

Cheers,
Andre'

