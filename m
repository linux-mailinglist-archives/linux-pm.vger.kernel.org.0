Return-Path: <linux-pm+bounces-19540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2E9F85C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637BB1899FB7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0F1D7E4C;
	Thu, 19 Dec 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="U+aECLto"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A91D0143
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639327; cv=none; b=jLaiDB6DERXBrclQmerQeGr2R3QQm2Dj/2IwVZd31VI7D1MhJ81IICsLc6YJ1ixyRBOldHFWHzt09U9uPKliLjPvEBNAqs0sXbW8UdGrkTOs3vfuE5DKhbrmHpinsEP3sQKJHBJrx8e8lyZSSBB1XAYsBkMC70NspVNxBPtEUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639327; c=relaxed/simple;
	bh=YFReednzGu98TQOgufATBSpFCcp2srBRU1ovovjNtnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfdCQ88pdI6IZN01gYKJFWS4fWPRZiBs22yOd1HXnbcpEuZcCBkT7Jsjrv4SGpeHmC8eVtctulVG6NAuiVrmozlw7FBgsaB/tmwiu7NUPhz52kwpzC7/BN80cVparA60oNLlSJhHKscREZKUmWVKMEuo3rTIexosm9wa07n+7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=U+aECLto; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7feb6871730so777546a12.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734639324; x=1735244124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT+rfbifA8ugdKRoMQ+jUVfQKZ2z0KE7T+MSU8vUIUI=;
        b=U+aECLtoeN+mO08vXzLX1hLvIJpEANo8PJfUjROrdL68DLd0jr24X0V6YdDFUOn60d
         JXPRazHoWdDb2QWaH4KFhwF4uYXlPoGUsjwG/OD4EQg/nTdm3J61/Mk4/siPGxpP49cq
         CzMqs/Sp7ci7ufFCI4iCrYt40HqaE2xHfB1p3DED/muSea7w66lMcqiuHOw8a1pGdISy
         sSmeX+t1LpayyqaPo8HjA5As2XKcW/7Vx/u3htngrZHw81jHpvMqUi6toQT0sYtv0ot4
         sq0w+qvOVPOO02MBC8v3gYsz5aROuMmNscu2t38gvCHz1AhFxLoq7FdS9glhR/XWEddM
         f+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734639324; x=1735244124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT+rfbifA8ugdKRoMQ+jUVfQKZ2z0KE7T+MSU8vUIUI=;
        b=DG42j8q1kfWTjDRsYOQNilCfffo3tWjwZxmFtT7P3mWufqBCzGHWIY8ItHH//mPbhT
         rGeoemILUgCL0WirQgXSshW4XO+KsPoruDIoC1s+RNJy59sREgjRsN8ryGTs3Lm9isqR
         zpe4yZ4S/UBmRbl1s6iQ1AOpPMC+ylaLsOyNWFDTvrvc2Tl8GuZLxcP0lmpjwET9fBg+
         lPEp4bmkSbGmCNPM26WpZkOb47Bqjou5PitEVRuYbDfQjbPFzWVkhpu9SQftbCPc5Cyg
         mhfaQh86fXEkeCqh0XxDvnJPcbtbdQJ+SooT2lsKn8VjL/VKAVtEYvWixHL8gIf+SPRX
         rDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeuYKtK5qvhLPtAJ6wstGZXecmqZOxOaQwfFTruXkRTGbIR5zRBtbgrhUz8KHWQeQ8ZFwK6ZjaNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpL4f70KYtX95gyLZRtS1BBE0/d9OLdxwZr8D3syDtpsozf0Sl
	JKj4ZvEv3YAUb3u0enwhgS9qkrIblDIXyywU5i+JLvvsFcYOq+KwzHoaaeixWANXr6LVcRMavwq
	SAqky9XuzVWWxSgHXbdeOJlcnZUkiuWrO+ncvoQ==
X-Gm-Gg: ASbGncvQX/uUtrNVZjks0r7CR5tP4WduOgAVsIZcB1m8IfN3j6xOqjzt1+9yubsuXED
	NUOcXiO1LdHYSmXDfV8SYpNAu6xPQlUYBqXZ3pDA=
X-Google-Smtp-Source: AGHT+IEsvcvsOj95n7XbyJMuRY+6nz1xfhm/EY3siryEeSgVcTEM6LkgC01VXYkNzpxqAFhYAssCgbaavB789STkRag=
X-Received: by 2002:a05:6a20:c705:b0:1e1:9fef:e96a with SMTP id
 adf61e73a8af0-1e5e044b029mr653818637.6.1734639324551; Thu, 19 Dec 2024
 12:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <4239407f-2676-45c4-9730-70493e56e36c@amd.com> <CABqG17hUvdo4ShQzWPWpfNqJFiDCDHmApPnHahtTt83B1Thg9Q@mail.gmail.com>
In-Reply-To: <CABqG17hUvdo4ShQzWPWpfNqJFiDCDHmApPnHahtTt83B1Thg9Q@mail.gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 20 Dec 2024 01:45:13 +0530
Message-ID: <CABqG17i93frSsRp4wHCPZSNn-yW9sookHvTy6qCExZXKs2D3gA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

On Fri, 20 Dec 2024 at 01:40, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> Hi Mario,
>
> On Fri, 20 Dec 2024 at 01:02, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 12/19/2024 13:21, Naresh Solanki wrote:
> > > The previous approach introduced roundoff errors during division when
> > > calculating the boost ratio. This, in turn, affected the maximum
> > > frequency calculation, often resulting in reporting lower frequency
> > > values.
> > >
> > > For example, on the Glinda SoC based board with the following
> > > parameters:
> > >
> > > max_perf = 208
> > > nominal_perf = 100
> > > nominal_freq = 2600 MHz
> > >
> > > The Linux kernel previously calculated the frequency as:
> > > freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> > > freq = 5405 MHz  // Integer arithmetic.
> > >
> > > With the updated formula:
> > > freq = (max_perf * nominal_freq) / nominal_perf
> > > freq = 5408 MHz
> > >
> > > This change ensures more accurate frequency calculations by eliminating
> > > unnecessary shifts and divisions, thereby improving precision.
> > >
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Thanks, this makes sense to me.
> >
> > But looking at it, we should have the same problem with lowest nonlinear
> > freq as it goes through the same conversion process.  Would you mind
> > fixing that one too?
> Sure. Somehow my eyes missed that.
> Also observed that current calculations yields zero for lowest_nonlinear_freq.
Sorry I was wrong. it's not zero. Its roundoff version.

> After fixing that, it reported frequency 2002 & 1404 depending on the core.
>
> On a side note, I'm also observing that the highest_perf is set to 196 which
> should not have been the case as I do have cores with value 208.
> Seems like amd_get_boost_ratio_numerator needs some addressing for that.
>
> Regards,
> Naresh
> >
> > Gautham, Perry,
> >
> > Is there something non-obvious I'm missing about why it was done this
> > way?  It looks like it's been there since the start.
> >
> > >
> > > Changes in V2:
> > > 1. Rebase on superm1.git/linux-next branch
> > > ---
> > >   drivers/cpufreq/amd-pstate.c | 9 ++++-----
> > >   1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > index d7b1de97727a..02a851f93fd6 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> > >   {
> > >       int ret;
> > >       u32 min_freq, max_freq;
> > > -     u32 nominal_perf, nominal_freq;
> > > +     u32 highest_perf, nominal_perf, nominal_freq;
> > >       u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> > > -     u32 boost_ratio, lowest_nonlinear_ratio;
> > > +     u32 lowest_nonlinear_ratio;
> > >       struct cppc_perf_caps cppc_perf;
> > >
> > >       ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > > @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> > >       else
> > >               nominal_freq = cppc_perf.nominal_freq;
> > >
> > > +     highest_perf = READ_ONCE(cpudata->highest_perf);
> > >       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > > -
> > > -     boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> > > -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
> > > +     max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
> > >
> > >       lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> > >       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> >

