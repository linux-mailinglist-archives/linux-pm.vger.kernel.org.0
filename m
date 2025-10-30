Return-Path: <linux-pm+bounces-37105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E5C2083B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFA61A602A0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9B242D65;
	Thu, 30 Oct 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChvhmA3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC223E35B
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833211; cv=none; b=a92D1zHVUFcAqqtVZsJTbVfHxO40MT7tt1gG9umDiGwlT62agYK811+YmwtwXSnorY7MJtMibZvpXYuEoiBpgO91u6EOLv0acdBY0JHqJAorJ34JjSUxy4/fQH2N2TiXMD78IpZkbTDWJ4z8Rlk8dioxTQF7hQ4MlcnARTfbBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833211; c=relaxed/simple;
	bh=Dz4xOhrMTNX+wcfa5hYkqJx2E8dqowAvq+/zwJDFp1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgo8wYdtvj+Y+UBZbUawaas/33vd54yYaAbrSlUoWOV15oYMXJSY//B47hueeAmlJFIWbeS7Ad3HPboODc/7hkf0ANNcUifw4zXrJt+vrtQR8gjACQczfpjg+O10SOZIu20udnybrywbk+Tnmu4VQLrhZC5n75zIC5cuhQlkm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChvhmA3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9750CC4AF0C
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833210;
	bh=Dz4xOhrMTNX+wcfa5hYkqJx2E8dqowAvq+/zwJDFp1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ChvhmA3HVwxXvtRjAM89eYP3Yb3LXnrhCtNPgMzFWCS0962UBDr+Qil1L+St/GaBj
	 Qmh13HJZ3CZi4JpNgTqGEb3s+3WMAPB02suprra1bT6sZn4r9PZRymzyQmpX5Tnpww
	 JWgysqNdddIUzxgj4G6ngzHKxy1aGh6svtB6MNMCnVzEmg9cJwfJzQYTMIIEBdWEI2
	 MonZ8KFWfhPiKdF3nMoe4UrWzkLM/KmxA8J8qQZpxboSQQ5zyscIX8k7lmeKpmRRQB
	 niTYoeLRgnAGFJjhylXNt/wqo/7DIy2ihYQ9nuW+uOlRRL7q/QlQAKX1Lv2c8SwRmX
	 Kf3SexViRV7iQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-443ac891210so611662b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 07:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmxGzYzsvxyEgjiJ8HFnRmPvk9lPdPQAvM9pQWHqFVabumu8Ac6fbuqh+hK+ckw/dk51rWyv5dLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyneWEx/xppk/Q+krM1hxSvhWRWWXDJriMxUpltjxhefCpvVRaO
	yre4SxLS+Mod5K/psflthyvAAUEYxWJAGjMbTEi3tD0bAb0YehLM2oDSgcvjl6BwIoiZWmBmPvt
	FKwzCOrUsv0sWR7ywXzSo4NEK5Uzw7a8=
X-Google-Smtp-Source: AGHT+IEMTQb+aUa2x3zxR9LsPUgyIaqCB158ba+He4+AFp1L349tjtBQ6XJuvZoqEQzHR4+LGS6E4/e9RiKA/m5Mx9k=
X-Received: by 2002:a05:6808:4443:b0:443:9ee4:3656 with SMTP id
 5614622812f47-44f7a4daf3cmr3088791b6e.38.1761833209875; Thu, 30 Oct 2025
 07:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
 <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
 <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com> <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com>
In-Reply-To: <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 15:06:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk8CDtp7hapBF11SwzM_-NwA6URJrRlEKbJpTpP-57E_VrWkAAgZGTqVgk
Message-ID: <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > Changes in v2:
> > > > > >         - Limit the new QoS to CPUs  and make some correspondin=
g renaming of the
> > > > > >         functions along with name of the device node for user s=
pace.
> > > > > >         - Make sure we deal with the failure/error path correct=
ly when there are
> > > > > >         no state available for s2idle.
> > > > > >         - Add documentation.
> > > > > >
> > > > > > Some platforms supports multiple low-power states for CPUs that=
 can be used
> > > > > > when entering system-wide suspend and s2idle in particular. Cur=
rently we are
> > > > > > always selecting the deepest possible state for the CPUs, which=
 can break the
> > > > > > system-wakeup latency constraint that may be required for some =
use-cases.
> > > > > >
> > > > > > Therefore, this series suggests to introduce a new interface fo=
r user-space,
> > > > > > allowing us to specify the CPU system-wakeup QoS limit. The QoS=
 limit is then
> > > > > > taken into account when selecting a suitable low-power state fo=
r s2idle.
> > > > >
> > > > > Last time we discussed this I said I would like the new limit to =
be
> > > > > taken into account by regular "runtime" cpuidle because the "s2id=
le"
> > > > > limit should not be less that the "runtime" limit (or at least it
> > > > > would be illogical if that happened).
> > > >
> > > > Yes, we discussed this, but that was also before we concluded to ad=
d a
> > > > new file for user-space to operate on after all.
> > > >
> > > > To me, it looks unnecessarily limiting to not allow them to be
> > > > orthogonal,
> > >
> > > So what's the use case in which it makes sense to have a lower latenc=
y
> > > limit for s2idle than for runtime?
>
> Honestly, I don't know, but I just wanted to keep things more flexible.
>
> > >
> > > > but I am not insisting that it needs to be like this. I
> > > > was just thinking that we do not necessarily have to care about the
> > > > same use-case in runtime as in the system-suspend state. Moreover,
> > > > nothing would prevent user-space from applying the same constraint =
to
> > > > both of them, if that is needed.
> > > >
> > > > >
> > > > > It looks like that could be implemented by making
> > > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit(=
)
> > > > > into account, couldn't it?
> > > >
> > > > Right, but I am not sure we want that. See above.
> > >
> > > I do or I need to be convinced that this is a bad idea.
> >
> > And there is a specific reason why I want that.
> >
> > Namely, say somebody wants to set the same limit for both s2idle and
> > "runtime" cpuidle.  If the s2idle limit did not affect "runtime", they
> > would need to open two device special files and write the same value
> > to both of them.  Otherwise, they just need to use the s2idle limit
> > and it will work for "runtime" automatically.
>
> Right. User-space would need to open two files instead of one, but is
> that really a problem?

It is potentially confusing and error-prone.

> What if user-space doesn't want to affect the runtime state-selection,
> but cares only about a use-case that requires a cpu-wakeup constraint
> when resuming from s2idle.

Well, I'm not sure if this use case exists at all, which is key here.
If it doesn't exist, why make provisions for it?

