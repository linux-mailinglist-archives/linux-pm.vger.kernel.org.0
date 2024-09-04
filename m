Return-Path: <linux-pm+bounces-13599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9696C214
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CD1F222CF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B01DEFC3;
	Wed,  4 Sep 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrUtPIOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB21D88D0;
	Wed,  4 Sep 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463149; cv=none; b=EhN7nhv6KMMANHrRF0lxeukr2imkXUUASvOzO1LeV6rwxJKa2Qg0yxf0eTcZ0UPYqbamvaj9RWBU7gRANAPu80RfXaMvmlg5z13iXpSEFaMCu1uOlEGkF1H9hMCS1UpLeIe7D/8rtSp8JGhe6bT1fxEsDl2MZ6uYSp9gIywDM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463149; c=relaxed/simple;
	bh=dxoF5mrLD1YpafdGeWOWnDMQ/OGVYM7nZ5pHb9IdVR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mts8FsQDZVdlBki4yykdOgpxc27N/rUrj9NDh024r8C1rAb3GpYNJ/4XzAIPxaOtGyBJTc8SWm4SU/h98o347eNu1BBrSnEfpQfFMgHPx4Z6/P7DWMtgPYhAR25fTLmnTJaGS1d5JgVGMzAdThNnnmuY7gN+17giAY2BL/Md7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrUtPIOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E66DC4CEC9;
	Wed,  4 Sep 2024 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463149;
	bh=dxoF5mrLD1YpafdGeWOWnDMQ/OGVYM7nZ5pHb9IdVR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XrUtPIOW/19qHsz5ALYBHc8Km96HRN4FBBXKJKz0mX1Qyp4SuWXCmxL+VCOEfww40
	 zpD9epnMyKhZ5ezeTLGHGQgtuRLoMabcxjRBQ9ANjj4/OglvS2dgA+mhqfdm07s1oB
	 jGLfTDdFtEhAh8UJHizg6GQSzQPpGIk0eF0Ow3dPLFeQ79Qnb7Zxs8dbDsQC+G4VeF
	 p0+fzz6ddTUMR4/K6rbmblIRPJXTLYx4TuWLdBgkYArBRonLDCWuZVAofzg5kNTzAf
	 nREOdZ9QsJYrpsbGbXnhchwSqnV9m3fAcZYYPSNdaCYC8sd9wVwHD5SrjCowZRpQNl
	 6e35jV0iD2B0A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5df96759e37so4396741eaf.2;
        Wed, 04 Sep 2024 08:19:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVl9rrVhtIos0+0KXtqm3wMuqzsNjMjbeYf+l6u5/AQaPFLWwFdD8ghv0RcXfndI13E6oOfZkrqRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Cfpg86x+YwlS2Z3LGDzSdcpfWjuE7sQAWKe7Tg4qQrhHRt1a
	dt5hi6fpU2qqlKwPDN54D+Wmn3uRPVrHIxyseBH2N0X+ezISj9CD49Jpe2dxaLSfBRYqcP5HqTA
	VIyooJUFis5sMJsuKKDlgU8jiPic=
X-Google-Smtp-Source: AGHT+IGNkVTXcVlTx/V19cWzkO9tSKQrkD3rAmnUPYv6uWF0V/CkRXRJXG3Nz/phzcM5OgBvILG5R0C5EEMfqoHvA9g=
X-Received: by 2002:a05:6870:a34d:b0:270:6890:9a2e with SMTP id
 586e51a60fabf-2779013a9b6mr24788084fac.21.1725463148471; Wed, 04 Sep 2024
 08:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819154259.215504-1-axboe@kernel.dk> <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 17:18:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
Message-ID: <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Sep 4, 2024 at 4:28=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
> > > Hi,
> > >
> > > This is v6 of the patchset where the current in_iowait state is split
> > > into two parts:
> > >
> > > 1) The "task is sleeping waiting on IO", and would like cpufreq goodn=
ess
> > >    in terms of sleep and wakeup latencies.
> > > 2) The above, and also accounted as such in the iowait stats.
> > >
> > > The current ->in_iowait covers both, this series splits it into two t=
ypes
> > > of state so that each can be controlled seperately.
> >
> > Yeah, but *WHY* !?!? I have some vague memories from last time around,
> > but patches should really keep this information.
> >
> > > Patches 1..3 are prep patches, changing the type of
> > > task_struct->nr_iowait and adding helpers to manipulate the iowait co=
unts.
> > >
> > > Patch 4 does the actual splitting.
> > >
> > > This has been sitting for a while, would be nice to get this queued u=
p
> > > for 6.12. Comments welcome!
> >
> > Ufff, and all this because menu-governor does something insane :-(
> >
> > Rafael, why can't we simply remove this from menu?
>
> Same reason as before: people use it and refuse to stop.
>
> But this is mostly about the schedutil cpufreq governor that uses
> iowait boosting.

To be more precise, there are two different uses of "iowait" in PM.

One is the nr_iowait_cpu() call in menu_select() and the result of it
is used for two purposes: (1) select different sets of statistics
depending on whether or not this number is zero and (2) set a limit
for the idle state's exit latency that depends on this number (but
note that it only takes effect when the "iowait" statistics are used
in the first place).  Both of these are arguably questionable and it
is unclear to me whether or not they actually help and how much.

The other use is boosting CPU frequency in schedutil and intel_pstate
if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
p->in_iowait value in enqueue_task_fair().

AFAICS, the latter makes a major difference.

