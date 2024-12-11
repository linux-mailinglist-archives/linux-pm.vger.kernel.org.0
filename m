Return-Path: <linux-pm+bounces-19042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F124F9ED30F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79108281FAB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A81DE3BC;
	Wed, 11 Dec 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYAq4Av+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E71D798E
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936881; cv=none; b=K92Soy7bPGXYGPhGeY00M6QlAVu04x6ehnHnZdZHjPsy2aXDTuQjN+Dp6BoUrdGgiTjxBxrsMxGAAe6Gjmh0jPXLlvZlaWi49UKjP61pmywSsQsWNjV0d8IwCHMkHfuwlv4s9wXZSYBlOl8x6JBC/9ihmaosAvWYTdUt3+Nma2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936881; c=relaxed/simple;
	bh=HdN/dCVuEHNmcD/xQ2f4pbnmTBWvVJsDvPisj/vpU3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/XkeuWr1wfcltTITxxItibgeSCltfQgS0FG8ZA6w5p/GU5X5omS/IA77S7AzTCpz3x6YUIRaCMQ0IBEM+8W10j6VFzNApDiCEsmhreGdmcT7Q03Y/FfWOza19WHM2ksPYr9J6Jc6cmiyzHWNv/dHjwtkdo3cLAqAx+ukNGd+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TYAq4Av+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so5086567a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733936878; x=1734541678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4IunYreEKiLZ14j5MbhCFvCDx23KAmIEeLi7z7m5fY=;
        b=TYAq4Av+cttxEYlJjmEcUuONZyo4puY276rD5KGnAZiAYEuwBQj2KzKHRW+yGxuCoG
         LwuxQYeMJWXpZL1al3dQ2udhIa0R+ROfIUYYOX/8IeDEjiZaaopH1/GFAuATWaZBtA4g
         dkxM7o5JnKtuAFVKvELHiyLtToi9HEF6tnUQ68wdUOJ6wri17DnRcO+wsEm77xKJhV7B
         a3ir0XSnLPqwvJlpHvT+N5MV4BoUwsMKwCUh2qOuXjQsSkHIKvYsu2r3P0MQREY45I5W
         3dOKd9Jv2I0BvawlmQA5SOLQ2O1rhyCkq4GExLHZ5wA6FAIKmooTPisBrRuJyky+OEWn
         rF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936878; x=1734541678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4IunYreEKiLZ14j5MbhCFvCDx23KAmIEeLi7z7m5fY=;
        b=mrvCj1wr2p8PNEEcKYen4uEpPTxNEMLo7d9OHYN/jeZuvFPPNccLJLR3BlVfmTEXhd
         Gxe0THPu+/wDE6mP1RLSSb0a4QLckBiyPGa4l0IdlfrrAu1KOezg/o3fml1PazpqrXJR
         +7o8KgjN645Q2M0b39O5nuqOFQ+WPyz7LNuI32u+PesChy92h4vafp7t/1mIKX6y+Edv
         LN4YaU/LqbtnLFsiiHmEw14En+/DWcKRnzBOlHwEdFHS6grJxv7OKvNUXUuzAGfT3Q1/
         Zhv6r/jhjDFTK/JpLyorNvx3LateHhGVZVwHaNUxfuIsVrA4//KfzubszLhvHdlcWjK8
         tBFw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWKT0GIg8JQADzDR/Xqju0GyRZxhE511EqqNASVz22sO/XGq5kkKyvCQyD13an/+/VcDI223f3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94SScRvZNL5lEQ+mvNu8wsxkTLRep04IPZ4/pIxLc11UChWD0
	IHg2eMYSvEDsDZRY4btJlSRhW3F5uB7NUa+UZKPEmZgvZx4EFxNLbLytxdPbDQIOS/kdlEO4mrK
	h+SbLkFhUbIs8byXBHPB3z6kyNt28vwLojIBjvQ==
X-Gm-Gg: ASbGncuEA9Psskepe1cssrOlno2gFwko8LhA7GfYZp1xsdlb/CwC1RxJtjCG3d+OzYe
	L1v3cJpuvJIoZxvDkTQQxpbH9S4dpoXDhnfeQijcq+aNixP9OHNKnX07Elvs/AlsG
X-Google-Smtp-Source: AGHT+IEOOj/K1k/UHwEEIrrEWG2laxjPIM+B7oY/yvCIi550pEFqRB4qCt55O1zQUupnV9BvsTqHensBBQ7kayuWKB0=
X-Received: by 2002:a05:6a21:b8d:b0:1e0:c29c:f2d4 with SMTP id
 adf61e73a8af0-1e1cead7545mr26655637.15.1733936878120; Wed, 11 Dec 2024
 09:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
 <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com> <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Dec 2024 18:07:45 +0100
Message-ID: <CAKfTPtBJsDPGeRdqk0Ag8dPFxYn0r0ow_xb4s+=Y=QzLWiX9uQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Dec 2024 at 17:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 2:25=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 12:29, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > > >
> > > > On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Make it possible to use EAS with cpufreq drivers that implement t=
he
> > > > > :setpolicy() callback instead of using generic cpufreq governors.
> > > > >
> > > > > This is going to be necessary for using EAS with intel_pstate in =
its
> > > > > default configuration.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > This is the minimum of what's needed, but I'd really prefer to mo=
ve
> > > > > the cpufreq vs EAS checks into cpufreq because messing around cpu=
freq
> > > > > internals in topology.c feels like a butcher shop kind of exercis=
e.
> > > >
> > > > Makes sense, something like cpufreq_eas_capable().
> > > >
> > > > >
> > > > > Besides, as I said before, I remain unconvinced about the usefuln=
ess
> > > > > of these checks at all.  Yes, one is supposed to get the best res=
ults
> > > > > from EAS when running schedutil, but what if they just want to tr=
y
> > > > > something else with EAS?  What if they can get better results wit=
h
> > > > > that other thing, surprisingly enough?
> > > >
> > > > How do you imagine this to work then?
> > > > I assume we don't make any 'resulting-OPP-guesses' like
> > > > sugov_effective_cpu_perf() for any of the setpolicy governors.
> > > > Neither for dbs and I guess userspace.
> > > > What about standard powersave and performance?
> > > > Do we just have a cpufreq callback to ask which OPP to use for
> > > > the energy calculation? Assume lowest/highest?
> > > > (I don't think there is hardware where lowest/highest makes a
> > > > difference, so maybe not bothering with the complexity could
> > > > be an option, too.)
> > >
> > > In the "setpolicy" case there is no way to reliably predict the OPP
> > > that is going to be used, so why bother?
> > >
> > > In the other cases, and if the OPPs are actually known, EAS may still
> > > make assumptions regarding which of them will be used that will match
> > > the schedutil selection rules, but if the cpufreq governor happens to
> > > choose a different OPP, this is not the end of the world.
> >
> > Should we add a new cpufreq governor fops to return the guest estimate
> > of the compute capacity selection ? something like
> > cpufreq_effective_cpu_perf(cpu, actual, min, max)
> > EAS needs to estimate what would be the next OPP; schedutil uses
> > sugov_effective_cpu_perf() and other governor could provide their own
>
> Generally, yes.  And documented for that matter.
>
> But it doesn't really tell you the OPP, but the performance level that
> is going to be set for the given list of arguments IIUC.  An energy

Yes, the governor return what performance level it will select and asl
to the cpufreq driver so EAS can directly map it to an OPP and a cost

> model is needed to find an OPP for the given perf level.  Or generally
> the cost of it for that matter.
>
> > > Yes, you could have been more energy-efficient had you chosen to use
> > > schedutil, but you chose otherwise and that's what you get.
> >
> > Calling sugov_effective_cpu_perf() for another governor than schedutil
> > doesn't make sense.
>
> It will work for intel_pstate in the "setpolicy" mode to a reasonable
> approximation AFAICS.
>
> > and do we handle the case when
> > CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not selected
>
> I don't think it's necessary to handle it.

I don't think that CI and others will be happy to possibly get an
undeclared function. Or you put a dependency of other governors with
CPU_FREQ_DEFAULT_GOV_SCHEDUTIL

