Return-Path: <linux-pm+bounces-37041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA7C1B4AE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F3C188D503
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D92D2387;
	Wed, 29 Oct 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTXKct5T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F22D12EB
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748114; cv=none; b=fGom+o9B37LENMCAMX5GubvoAOgLix65GFAMib0gssrMZ+muJBtJ4eiJzevKjufb+5nPJZnYst3s6J+099nqFNclt4CGF9xgyivh0dyvmPeePDVMvFt9+sRJ6qpvVSw2g1k/vrTpQs3yAg4wnYeec6L2gehm4FAqwwk95xcDYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748114; c=relaxed/simple;
	bh=ycvf+w2/mE/h70FPsnRAceCWxI81fhZqTWfT4beEqSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2Y8Xs0DAxJDYovr0NHMUfb6RapkBOhIdiH2usMeMOTFxSaNxRnBJyBOnEVTEBRtgkxGwbv7mZa6Nx6u1MgIZLJ0Hj6q46UC2Skwcdx+HXuinUQ9ykQ5E6VA04mcC+sItiiYFNhnsq6/kgIPOFssDHrEQQsstXjfsk0vCOMiPU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTXKct5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A8C4CEF8
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748113;
	bh=ycvf+w2/mE/h70FPsnRAceCWxI81fhZqTWfT4beEqSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fTXKct5Tr2OCcU7ojjD51pRyEUrXc+9BpzAI8O3q13A5PKttXUox/d92JvMblaF++
	 /yI6seIlXdbbtxweiU8FU2zXD6g2+TAEMGTxx7YIW0m9s7XAWMtvtaDPSmGYbg4Fw3
	 jJKitfK2viCKcOsyImlNwg1BVMQI5tpe+GluYKdvcjhkizVnOukzJfzjjOI9R3osj5
	 RPJRMPJu2JsmuopW3JGTNaFBBeUGyBQPNk4ERIrEB/rrged4XbJAO+Wha5tG4k+IIQ
	 TE7V5fNUArewtl25kBLnHdJkHN2RcgUiGw76Qo/riB6Nuh6bEEkjC6n8Q5gtyx3Ys7
	 qLg30sfeoB2Lw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-654eb78f721so2596410eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 07:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmOZKgmaEGHcpDncK6FsSRMImPAMKceZ+LcVXFA4huHva629wj5w6F4pCKMdnVMLqylWpa8LztZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCuGvPmu0Ly6/YiLouCvyvwNOdq169XyL3FPwtD7pQtoUiMiu
	L97ItgHp6NyvCuYdRhgJTDPMOxkjE6gu+sUKnphXVsW55VN3DdSBzI09k3ihCEPeQDZpjk4Upsu
	VvBmfqbhCS8AQZLrkP/qxRo3hXlq/bOs=
X-Google-Smtp-Source: AGHT+IEbUd+JQ5DjQ2Y6NcLaDkmrtcoQ7Y649VF2s/mqXuH/MYD5YaA1OxjGFB3FBRuaAt9mj2Gb7FORgEwULlV/4P8=
X-Received: by 2002:a05:6820:603:b0:64e:822b:e6de with SMTP id
 006d021491bc7-65677f12406mr1360346eaf.7.1761748112978; Wed, 29 Oct 2025
 07:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org> <20251029081014.443psmqznd2pqm4i@lcpd911>
In-Reply-To: <20251029081014.443psmqznd2pqm4i@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 15:28:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
X-Gm-Features: AWmQ_bkIRMLKAw2hRsQOICKn11WWYrSkSN53qmpIka5w-KJlYGIgupNtIdm9ew8
Message-ID: <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:10=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Ulf,
>
> On Oct 16, 2025 at 17:19:21 +0200, Ulf Hansson wrote:
> > Some platforms supports multiple low-power states for CPUs that can be =
used
> > when entering system-wide suspend. Currently we are always selecting th=
e
> > deepest possible state for the CPUs, which can break the system-wakeup
> > latency constraint that may be required for some use-cases.
> >
> > Let's take the first step towards addressing this problem, by introduci=
ng
> > an interface for user-space, that allows us to specify the CPU
> > system-wakeup QoS limit. Subsequent changes will start taking into acco=
unt
> > the new QoS limit.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Renamings to reflect the QoS are limited to CPUs.
> >       - Move code inside "CONFIG_CPU_IDLE".
> >
> > ---
> >  include/linux/pm_qos.h |   5 ++
> >  kernel/power/qos.c     | 102 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 107 insertions(+)
> >
> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> > index 4a69d4af3ff8..bf7524d38933 100644
> > --- a/include/linux/pm_qos.h
> > +++ b/include/linux/pm_qos.h
> > @@ -149,6 +149,7 @@ bool cpu_latency_qos_request_active(struct pm_qos_r=
equest *req);
> >  void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value=
);
> >  void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 ne=
w_value);
> >  void cpu_latency_qos_remove_request(struct pm_qos_request *req);
> > +s32 cpu_wakeup_latency_qos_limit(void);
> >  #else
> >  static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
> >  static inline bool cpu_latency_qos_request_active(struct pm_qos_reques=
t *req)
> > @@ -160,6 +161,10 @@ static inline void cpu_latency_qos_add_request(str=
uct pm_qos_request *req,
> >  static inline void cpu_latency_qos_update_request(struct pm_qos_reques=
t *req,
> >                                                 s32 new_value) {}
> >  static inline void cpu_latency_qos_remove_request(struct pm_qos_reques=
t *req) {}
> > +static inline s32 cpu_wakeup_latency_qos_limit(void)
> > +{
> > +     return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_PM
> > diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> > index 4244b069442e..8c024d7dc43e 100644
> > --- a/kernel/power/qos.c
> > +++ b/kernel/power/qos.c
> > @@ -415,6 +415,103 @@ static struct miscdevice cpu_latency_qos_miscdev =
=3D {
> >       .fops =3D &cpu_latency_qos_fops,
> >  };
> >
> > +/* The CPU system wakeup latency QoS. */
> > +static struct pm_qos_constraints cpu_wakeup_latency_constraints =3D {
> > +     .list =3D PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
> > +     .target_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > +     .default_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > +     .no_constraint_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > +     .type =3D PM_QOS_MIN,
> > +};
> > +
> > +/**
> > + * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency Qo=
S limit.
> > + *
> > + * Returns the current CPU system wakeup latency QoS limit that may ha=
ve been
> > + * requested by user-space.
> > + */
> > +s32 cpu_wakeup_latency_qos_limit(void)
> > +{
> > +     return pm_qos_read_value(&cpu_wakeup_latency_constraints);
> > +}
> > +
> > +static int cpu_wakeup_latency_qos_open(struct inode *inode, struct fil=
e *filp)
> > +{
> > +     struct pm_qos_request *req;
> > +
> > +     req =3D kzalloc(sizeof(*req), GFP_KERNEL);
> > +     if (!req)
> > +             return -ENOMEM;
> > +
> > +     req->qos =3D &cpu_wakeup_latency_constraints;
> > +     pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
> > +                          PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> > +     filp->private_data =3D req;
> > +
> > +     return 0;
> > +}
> > +
> > +static int cpu_wakeup_latency_qos_release(struct inode *inode,
> > +                                       struct file *filp)
> > +{
> > +     struct pm_qos_request *req =3D filp->private_data;
> > +
> > +     filp->private_data =3D NULL;
> > +     pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
> > +                          PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
>
> Please excuse the delay in reviewing these patches,
> I was wondering why we have decided here in release to reset the
> constraints set by a user. For eg. even when I was testing the previous
> revision locally I'd just commented out this release hook, since I
> wanted to be able to just echo 0xABCD into /dev/cpu_wakeup_latency...

If you want "fire and forget", that would be a different interface.
Device special files are not for that.

Cleaning up after closing a file descriptor is a safety measure and
CPU wakeup latency constraints are a big deal.  Leaving leftover ones
behind dead processes is not a good idea.

> It seems an overkill to me that a userspace program be required to hold
> open this file just to make sure the constraints are honoured for the
> lifetime of the device. We should definitely give the freedom to just be
> able to echo and also be able to cat and read back from the same place
> about the latency constraint being set.

So you'd want a sysfs attribute here, but that has its own issues (the
last writer "wins", so if there are multiple users of it with
different needs in user space, things get tricky).

> One other thing on my mind is - and probably unrelated to this specific
> series, but I think we must have some sysfs entry either appear in
> /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> state that the governor has chosen to enter based on the value set in
> cpu_wakeup_latency.

Exit latency values for all states are exposed via sysfs.  Since
s2idle always uses the deepest state it can use, it is quite
straightforward to figure out which of them will be used going
forward, given a specific latency constraint.

