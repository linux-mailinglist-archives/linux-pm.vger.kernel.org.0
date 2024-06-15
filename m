Return-Path: <linux-pm+bounces-9232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836990992E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4152CB21433
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC349656;
	Sat, 15 Jun 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9dtjdDd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34341E89C;
	Sat, 15 Jun 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471632; cv=none; b=ji7kU3xRFlT5LlxDBqcwieo7AfJ//gAAa43b9qjeMFuyzJP3r0ZL/2x6V2N3F9xZrS1a2CNNvhAGI624A2DzU3mJaxiFa5Ekh2f/3O4JyrtFcydEkzK/b2bqKqr6e2Qh5NJ0MqPmZk0pwnMOIRx52bdeElVaeJEWE3JFum70l1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471632; c=relaxed/simple;
	bh=MrsrF30xKAE+H9SSpcALN+6xtQLJ32SlxbP4eLBlUxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doEZCNu8QSG8/P5jpEbb/ZI89Itk1oyO1BNhH+B+rF5klifY4+8vsve46Gm25LHU/kPdXN5SD8J6H0oVNILy0Ld/N49Q62coe9T4Pj8GWQqzTM4jGiMAcva37mtk3PZ/s/Y0gtIjzqKiwqhNSKH5mSB6BxyuwikifkCO96Rta1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9dtjdDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DA9C4AF52;
	Sat, 15 Jun 2024 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718471632;
	bh=MrsrF30xKAE+H9SSpcALN+6xtQLJ32SlxbP4eLBlUxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O9dtjdDd8CzOVUdvA5IQW+8NoxjH5CW73Jw6idI5pkIG4Am2OI8s8U+MJ8i4deihm
	 +eyDbB31nDxRQveSKkP2NDp5mLpyFbNZzzlC4miPzxKcuj0/iKULAElK2wmbK3Alle
	 8gMfEgmioKeMPL8jtE7AXSAobG7zrQXQAjig39vsPavIysSt4cKTjwVjhfq7LNz4kt
	 74bg+zrUlHExUjoeadsOCjvtKFSdj9HyYbhA/m8h7WCAPeJTauD6dODHehDShSx14a
	 kTPXt1YIAwiB3W/l+qNHBaWbUltaN+aEmgxdBh2+wHcs+t/QNFIEj18v+BTHzEvOqj
	 8Ia6sGOvlUAfA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cce3bc8c6so632210a12.3;
        Sat, 15 Jun 2024 10:13:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMDrNfVKmu7UWVIBXqTJKnHSZvfMBS5P5HwR7HIiFy0opKM/qnwJRskW5ia3SNHeTF1VjMK4AWSmkKN3aSBu8ql+q11fT/3Xf/7s0i8p3HekY7LX7VgGuaDC3aX4/NTHlaxE3I
X-Gm-Message-State: AOJu0YzY3hI1a8wgm3IZG0rw7YzGFtIj8HJPYJHWxLdGt/qAONoV1OU4
	CeRWvEPY4ZokulYsvsaOWYrFXp/smPJic3ug6dRSheYa3PF+9y2TIsz89Y0aUkv2lf/gRRPAUTN
	Z3zwqsbsPW1vMphkaXoXbd6uGpEo=
X-Google-Smtp-Source: AGHT+IFxpS1aGq0kZ+HwiXAYX9qxRC0dRUemJpQt5RopJMhnpU1hLlCii5dLE56EONrHnBB2vC0Elpc0iVxYQXUEluo=
X-Received: by 2002:a05:6402:17d9:b0:57c:c712:a3c7 with SMTP id
 4fb4d7f45d1cf-57cc712a42emr2547039a12.36.1718471630365; Sat, 15 Jun 2024
 10:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613181613.4329-1-kprateek.nayak@amd.com> <20240613181613.4329-12-kprateek.nayak@amd.com>
In-Reply-To: <20240613181613.4329-12-kprateek.nayak@amd.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 16 Jun 2024 01:13:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTVjD3T6F13rGVqCtqk4T+kLa+zx93aHaREo0e8tMrNOw@mail.gmail.com>
Message-ID: <CAJF2gTTVjD3T6F13rGVqCtqk4T+kLa+zx93aHaREo0e8tMrNOw@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] csky/thread_info: Introduce TIF_NOTIFY_IPI flag
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-csky@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:21=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Add support for TIF_NOTIFY_IPI on C-SKY. With TIF_NOTIFY_IPI, a sender
> sending an IPI to an idle CPU in TIF_POLLING mode will set the
> TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
> CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
> avoids spurious calls to schedule_idle() in cases where an IPI does not
> necessarily wake up a task on the idle CPU.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: linux-csky@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v1..v2:
> o Collected the ack. Thank you :)
> ---
>  arch/csky/include/asm/thread_info.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/=
thread_info.h
> index b5ed788f0c68..9bc7a037c476 100644
> --- a/arch/csky/include/asm/thread_info.h
> +++ b/arch/csky/include/asm/thread_info.h
> @@ -61,6 +61,7 @@ static inline struct thread_info *current_thread_info(v=
oid)
>  #define TIF_SYSCALL_TRACEPOINT 5       /* syscall tracepoint instrumenta=
tion */
>  #define TIF_SYSCALL_AUDIT      6       /* syscall auditing */
>  #define TIF_NOTIFY_SIGNAL      7       /* signal notifications exist */
> +#define TIF_NOTIFY_IPI         8       /* Pending IPI on TIF_POLLLING id=
le CPU */
>  #define TIF_POLLING_NRFLAG     16      /* poll_idle() is TIF_NEED_RESCHE=
D */
>  #define TIF_MEMDIE             18      /* is terminating due to OOM kill=
er */
>  #define TIF_RESTORE_SIGMASK    20      /* restore signal mask in do_sign=
al() */
> @@ -73,6 +74,7 @@ static inline struct thread_info *current_thread_info(v=
oid)
>  #define _TIF_SYSCALL_TRACEPOINT        (1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SYSCALL_AUDIT     (1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_NOTIFY_SIGNAL     (1 << TIF_NOTIFY_SIGNAL)
> +#define _TIF_NOTIFY_IPI                (1 << TIF_NOTIFY_IPI)
Acked-by: Guo Ren <guoren@kernel.org>

>  #define _TIF_UPROBE            (1 << TIF_UPROBE)
>  #define _TIF_POLLING_NRFLAG    (1 << TIF_POLLING_NRFLAG)
>  #define _TIF_MEMDIE            (1 << TIF_MEMDIE)
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

