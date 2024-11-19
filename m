Return-Path: <linux-pm+bounces-17787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B819D2ED4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE81F23754
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80098150994;
	Tue, 19 Nov 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaBlnpSb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF38528E;
	Tue, 19 Nov 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044525; cv=none; b=ChELs2EbpSkeBT2VwyfLcnlCUwNtQ5YpcwHzO6RVErS1UOWGKVV1wDLT7kTAOHHlVowudXWP/BkqnYHlENYQrCB4w/OcSjE3hgID0ql/g66Wu1nlU7YVTsYJgPPNYV5XI/fYP+A0agGJbdlDWCXRkIdyStUyqQxcNvcPYo86q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044525; c=relaxed/simple;
	bh=rgu/dpYYYGyXbFxm0m33bH5EvBBRPujKWiRleZLGTLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDpxWeTMUkFBmnvzvrKks42UXkykHDScVxcAWiHjT0PJ5dI+RJpaEg6bTW1xcBLbJrMrIgn8ZWfLI8SEleZXfW+wHd1tdmdtOV9GlnFkWjkpuWP2S5YoQ/LocsPGVfU/IPOBa8otLQ/yb7H+O2AuUw8s4jWxsxIPW13svERFgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaBlnpSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CF1C4CECF;
	Tue, 19 Nov 2024 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732044524;
	bh=rgu/dpYYYGyXbFxm0m33bH5EvBBRPujKWiRleZLGTLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YaBlnpSbY0u0D71ubW9dxI0E//PhhXxiCyr9Fx1WwvqDMaDxWZNMBAH51LpeWzzmt
	 2LhheTb+YA7neqYs7U4Kcf/hS7ATHgESqd0vTbOjTl2oHIVo7XD9VHgbYNVLmJ2ZDv
	 FMjxNHzifaQpiNLeK1BRks+FGzT1FeZcYafx4ksx8caFSZyTNBKyOSo2LDtwm0tMOs
	 1XH8f0umM9+ah0M2xZzPd8GJUisfjuvJkJp2ZreOwDkRGkjtUtc+CUZA4GhXGRBl+x
	 avs2Lhv1NAejllFJujSKpnQYQjSpO5y6e/JZmIv8ULExfSBpX109KcHw2v0aY+JrVx
	 HzWf0f5JWlKrw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2951f3af3ceso1764480fac.1;
        Tue, 19 Nov 2024 11:28:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcLWiFTR/u9ghHyQBWkp0O+n+JlntsNjC26P4Ze3fTzncylaknFKtQXFpRjyxz8giZVwCMrMPMPFk=@vger.kernel.org, AJvYcCVmP99hQgWEN9UN6gd4x5qRR1IEAJmNWmQx2jNSjy67qGPFv8dTAME3v7zX71ckGGTrGFKH+sv1IGUA69s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoMg+bWeQA1Doil7DDrPKbKYGItoyJGhIsz2pa1D9wW+CGxYA
	d1tgxsjK/hYv1v0LcebjWLcStfGFD94KO4alGbT5Jb3IVruVSUTMtqOnccEOZdMNraot+nvtTvV
	MXjcVlmRAewZyMMQfTyV4PGAYYrg=
X-Google-Smtp-Source: AGHT+IHkG0hhGENLhbN7NwtrQ5XXs8Ed8UYrog/ACiwN8A2Cjoi3PWy/bqH5Uyh2knxzhzOHuNkmVup91+MoyudL+DQ=
X-Received: by 2002:a05:6870:c89:b0:278:8fe:6293 with SMTP id
 586e51a60fabf-296d9adadc6mr91302fac.1.1732044524216; Tue, 19 Nov 2024
 11:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <1889415.atdPhlSkOF@rjwysocki.net>
 <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com> <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
 <20241119173702.GA27509@noisy.programming.kicks-ass.net>
In-Reply-To: <20241119173702.GA27509@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 20:28:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jaXxQDKwLHUNRgK1rZi4XuRGwfRZFPrGa+3o38w1=o7Q@mail.gmail.com>
Message-ID: <CAJZ5v0jaXxQDKwLHUNRgK1rZi4XuRGwfRZFPrGa+3o38w1=o7Q@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq
 drivers to enable EAS
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 6:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 11, 2024 at 02:54:43PM +0100, Rafael J. Wysocki wrote:
>
> > Or what about ondemand?  Is it alway completely broken with EAS?
>
> I thought that thing was mostly considered broken anyway :-)

Well, it's still there in the tree, although honestly I don't know how
many users of it there are.

> > > For plain (non-intel_pstate) powersave and performance we could repla=
ce
> > > sugov_effective_cpu_perf()
> > > that determines the OPP of the perf-domain by the OPP they will be
> > > choosing, but for the rest?
> >
> > I generally think that depending on schedutil for EAS is a mistake.
>
> Well, the thinking was that we wanted to move to a single governor, and
> not proliferate things.

Thing is, intel_pstate in its default configuration doesn't use a
separate cpufreq governor at all.  It allows P-code to select
P-states, but on the new HW the result of this isn't really that much
different from what schedutil would do.

The cpufreq governor check needs to be adjusted at least for this
case, but overall it should be done in cpufreq because it refers to
cpufreq internals.

