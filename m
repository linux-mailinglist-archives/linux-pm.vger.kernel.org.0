Return-Path: <linux-pm+bounces-11793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11E9444EB
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F812809C6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9C16DC3F;
	Thu,  1 Aug 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pySWYoet"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D316D9C6
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495314; cv=none; b=QzBzfxsU5gzscwc0+FgN0YiL9ENn2gyt4vaR7XzTy+F23+YGnMPlZFzRfhc6AiOAIaaOfPIZ87LKH8pmKnEqBTl8sFnMgbwQeU4tfwlJ0ND1rSzcLLyNqjnAXsP83DXUmP/M/mLI8f26sHBcAbOylAjlk5kRhyudnnkapT8cIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495314; c=relaxed/simple;
	bh=G6JbqvP+JzPpaqmI1T0/vuWFUnk1MnN+96gN2QgHM+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXzg2RlfsBd2EklzdrlU0epc9IaHe1CgQ9AuAxNmzARzwCtSRIIdHNFISMvDomj1k3suCen1go1JZqb9VpEFJEUJ3nzOj4jdI3fjKbiG5FgqkZTe14ClP4Mtc8o4JJbapvFQ0Iv1niC51+HDDO5VNWGevjUA6diX4nAfz1nnm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pySWYoet; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3F933F327
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722495303;
	bh=G6JbqvP+JzPpaqmI1T0/vuWFUnk1MnN+96gN2QgHM+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pySWYoety/aIQC10alFsZI7n5dMGuVtfeBvtOtJupffqZJNYApfDDg1Yy+Xlgn1R4
	 CFf3o2OrpSTes43KQ0qjP3UzNGKCLULXqJ6zd58xNbfKAvL/JRnT7tOGjAo3cyiHa6
	 SIaj/EM3FHqasZ7POHDWUGkqx2+SjULejniofPK0mFEbKleOX4MHAtylfUQj4cQlk+
	 kxruIEBqRkJRJfkVAkK1c5CN7Jy2lbjPtz6IzwOicZdmDFHk0EtXNZViAtn8zfItD6
	 hxLF9rYQ3KxCcrB4RhYYfOB2BUee1fyLuiszAUwlv7iIqtDl7fzZ0rVlTBsk+uh/8C
	 4rMoIMYo/Qjmw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70d1d51f3e9so7225606b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 23:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495302; x=1723100102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6JbqvP+JzPpaqmI1T0/vuWFUnk1MnN+96gN2QgHM+Q=;
        b=ggBYJJ1Wzsz2ZuK1k0OXI//xrLlCuaVRevidcH0wyEkLPXXP86cF4E0QxDIlsNsiJQ
         LjPPt6ZOAY7Mmaf6tsu5kgXzdmWRtWG14VGJxYdXmlAym1y3Yo/h3bEn2d3nQwJazUgi
         C8jBnpQRDElPUjrfOYR0dy5I36HJXDbyb/4weQdVsr/pudzxqHukQMtbSkgrRfU2/p5O
         t0z7U6/3Agr1pS6qqU96Pa0zNwWel0c8l6F1D/MDYoAEZ5X/aZqaeAzhMEUAGuILXpNi
         S/bRqg6JD0i/pOVfNwiB9+21Mdv7/ZL5ERq4MmmKXxD/GjNlwOWkNEm/7eLx9cTGW1Q1
         TeKA==
X-Forwarded-Encrypted: i=1; AJvYcCV8ew1FylCnrn3/9HTcHUrsMJkSJ1jfKiHBeFNy22D0DKW0KV9PvZPkvvDq7stNBePriyu12IbLdHj0VJCXfcLe68BV6OZPYIM=
X-Gm-Message-State: AOJu0Yw6ZYXeM/yctOTTPGhcq1S6O31Ky29Rl/GOzmziGXZfMXmjZLGU
	NSjMhM/tyKLQJOZuIa+U/GfecHyH9CKZmAw0DAR02ZqQu5CfbhDNTeRdHZqs6eU9A+tEQ3GcH8P
	7wX/0qqlUHPP1AH7CUxzz4wSzoOYHpeD3LQzLWr1z0IsFnQsLDylC2x5J7LRSnfDkKcWVxggOgZ
	qcDu6/cSPlBdepmiUiNA+62+FOTUEL9X0KZ8BcDe9TsIGT1Mm3O/3Bcx8yug==
X-Received: by 2002:a05:6a00:9189:b0:70d:3420:9309 with SMTP id d2e1a72fcca58-7105d6fb620mr1930240b3a.17.1722495302201;
        Wed, 31 Jul 2024 23:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxH4U08W48TiLv/0lYDLI+xjjrYJvSMkNbAHFf/lyYnes9cUnLr9AFBs3sy0zZLo9Ov9Y6WXTTMZ/jAfYoWxA=
X-Received: by 2002:a05:6a00:9189:b0:70d:3420:9309 with SMTP id
 d2e1a72fcca58-7105d6fb620mr1930233b3a.17.1722495301765; Wed, 31 Jul 2024
 23:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
 <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
 <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
 <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com> <CAJvTdK=wafegpUB-KD=P9KazWngMNQb_rcbwQX_DDwPBtZ9W7w@mail.gmail.com>
In-Reply-To: <CAJvTdK=wafegpUB-KD=P9KazWngMNQb_rcbwQX_DDwPBtZ9W7w@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 1 Aug 2024 14:54:50 +0800
Message-ID: <CAAd53p52A7ymkQhFweoy2vRXfkT81pumU6V5Q8tbEBKTnX=ASg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 12:28=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 2:18=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The crucial part to make the issue (i.e. slow ethernet) is
> > ".disable_promotion_to_c1e =3D true".
>
> Okay, so the problem statement is that on this machine with some
> ethernet controller and some workload,
> performance is better when you use just C1 and not C1E (or deeper) states=
.
>
> And so you want to have the option of accessing C1 without the overhead o=
f C1E?

Yes, that's the case here.

>
> Presumably you don't care about the power savings of the deeper states,
> or you are using PM_QOS to avoid deep c-states at run time?

I tried to use cpu_latency_qos in the network driver's NAPI poll, but
only saw marginal improvement to around 830Mbps. Hitting the 940Mbps
is still the goal here.

>
> > Can we use that for EHL and JSL?
>
> Yes.

Is it plausible to disable C1E promotion while using ACPI idle driver?
Or provide a C-state table in intel_idle and update the states via
_CST?

>
> You may also have a BIOS option to achieve the same goal, depending on
> the platform.)

I am seeing three different platforms from different vendors hitting
the same issue, so it's better to disable C1e for these platforms.

Kai-Heng

>
> --
> Len Brown, Intel
>

