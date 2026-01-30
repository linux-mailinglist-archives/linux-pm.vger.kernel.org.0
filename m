Return-Path: <linux-pm+bounces-41796-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG7FD+j0fGlLPgIAu9opvQ
	(envelope-from <linux-pm+bounces-41796-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:14:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D5FBD9FB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E805300DF65
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4F36C0C4;
	Fri, 30 Jan 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtp0+AbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70731A051
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796813; cv=none; b=tl5SAXj+0erid5b2bJlC6buc1Inqv/R7DlauA17R4I5K9PXDfoeuEidsf2cRWRJ3Hm0dhgk+A/cB8CNgfPxx7kF2wGX6Za1TvXMGEOY1dCiFRtWA8/BOn+TRDFcmeAlovpgCh2JZPsur6Awow8iZuuV04EkoLMAazl+2IY/pWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796813; c=relaxed/simple;
	bh=LISfKR93PEiaIWL+rTvqe4PKK99gaFt2J2IfiA8N2Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehY6KrjR3QHO2Lh4baHiIedymrKxhgt70lhEtXgS0zB9fZYPFpAvWRUW1DvKN8suuikC/NXS9+almIRunKDsg8linzYIzFtVI092bB93z7GPsj8Sauhg58V1sGvLo3DZJhAeN1CW+Uqkk7d7XI7HGSwE5TfBexkEiXeT3wGu8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtp0+AbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D721C4CEF7
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769796813;
	bh=LISfKR93PEiaIWL+rTvqe4PKK99gaFt2J2IfiA8N2Y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dtp0+AbHj3S2cKad+54r9HkZQzf/38FqvFjehglY/dqBtZuSy2Q6y6/BsePTA0LCl
	 kwOMR7XCI33GLWqXSRaJDlT38TDPsEHsPPDdU7kFevAPxe+Cgkf8Y1gHz/wz9GNSRK
	 7CNMKZvtbjB8ibMTKBCAY6yYTOFh/JaY/k5+qo5hbGXrWOoRoVrsJBRorrgYirvhPb
	 yL7ierlf1pNca2uRmaylt3as0272JNVKNx4ZMZ4CZSu0T6w6mXS9FhrOkxTKUmaLod
	 Ms71cEpmTG4rVxoEhbymikCbYx27/mIVP7F+s6OBCFrEDawTMhjqQ2G4ewdD3TMUVb
	 CyFBRk9jwM7QQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6611cab8ca3so1401706eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 10:13:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNuR0/S1ZhqTXVDCIfHGV7LGYxDfr2p7xCyuJb2zQJlSVuDOgTtzaWdFQsfqDlojYcMMXVEcSQjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yygn64Nx5xj1EsdQV8TUkglE628FgdGUwV0Ax6aVDHz5qqlYIxP
	0+E8VtgykjLYO0AqCZFxcfL5RmCq/ObCvONwwFxiXPPCM7VOkCVY6iRYsotiyHwg1x8jFS7DClS
	oP9uh50BmdGH4OVG49fRO5gBsno19w4g=
X-Received: by 2002:a05:6820:f0b:b0:663:b6f:c25c with SMTP id
 006d021491bc7-6630f36f8ccmr1745766eaf.41.1769796807350; Fri, 30 Jan 2026
 10:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
 <CAJZ5v0h5CKydWU-o-Zu2z6mCtEcCszkfpL4Vuz_VmSqhxKbozg@mail.gmail.com> <7b231d33-9c40-4f25-a693-8f2e08280ce4@sirena.org.uk>
In-Reply-To: <7b231d33-9c40-4f25-a693-8f2e08280ce4@sirena.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 19:13:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gG0=AJk9wUqwMps2p-ypDre4fU-1L7EVCAZY+a75tTSg@mail.gmail.com>
X-Gm-Features: AZwV_QhtaIMBGridiBfqnH3P9NGAN0931kY95YDlXuEAROW9jN9WqHKBOgrS4RE
Message-ID: <CAJZ5v0gG0=AJk9wUqwMps2p-ypDre4fU-1L7EVCAZY+a75tTSg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
To: Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-41796-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A8D5FBD9FB
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 7:09=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jan 30, 2026 at 07:06:06PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 30, 2026 at 5:55=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > This warning is there because IRQF_ONESHOT is only meaningful when th=
ere is
> > > a threaded interrupt handler and this driver does not register one. J=
ust
> > > remove IRQF_ONESHOT, it wasn't doing anything.
>
> > Daniel, do you want me to pick up this one?  I can still push it for
> > 6.19 as a fix.
>
> FWIW the WARN_ON() is introduced in -next so won't be seen in v6.19
> (though the issue has been there since forever).

OK, so it need not go into 6.19, but it would be good to have in 6.20/7.0.

