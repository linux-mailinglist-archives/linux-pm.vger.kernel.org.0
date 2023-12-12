Return-Path: <linux-pm+bounces-984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183E80EF71
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02C6281AC7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B3745E3;
	Tue, 12 Dec 2023 14:58:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1210C3;
	Tue, 12 Dec 2023 06:58:03 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da09f8ce35so710475a34.0;
        Tue, 12 Dec 2023 06:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393083; x=1702997883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI7/niVPwJXrqn+aODJkyH9Zg/KMSJ6EEIEaKjbnNpY=;
        b=otyzK4LO7asNGssByl2eJz5+J44qgQgCNdAd5TrA2L3M/S0fbh600e12HlDcnlbg96
         9uy94ntnzniIb3QZl05FwmsoVGkUJxEDz/GsxdmnvRIPla7moqOLp4VXuZWbN6CdQoxr
         Az41+V9xyI24qV/emrdw7dzlTt7rgick4LS6pDZCi98tSnKv/15SkOE2xp21ZoUYQj06
         +fXdYKyrtSQugGVQ7p4UJymMIQ+vGdcKwjwbseWqirmfwun+L/0VjebFDaldlj4qJu/d
         7ynEClg90t5NeOMj3LDy88v/CLMw6zDPuFpq+LdQTg1Ikrncgiub6CGwKVZywbmgE5X9
         IZpg==
X-Gm-Message-State: AOJu0YwPzQ2jSKrNnylq083/NetHKuvIYgnJ6I2XoRoxh2+6XwjCKfDc
	0ntlgR6aSDJKhKWPjOD0jp0S/pG7ZCIf+mQERGw=
X-Google-Smtp-Source: AGHT+IFX85hOWBf/RrXFpoD9jaXzKOGxn2HXgJByjv/5kq8gOM68c2U1NhKQYr3oCRj/lN3h7WobxtedVxKE9Of+nJU=
X-Received: by 2002:a4a:da02:0:b0:590:8a57:8012 with SMTP id
 e2-20020a4ada02000000b005908a578012mr10635729oou.0.1702393083230; Tue, 12 Dec
 2023 06:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
 <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
 <CAJZ5v0j8x_hzKg4RHx-xyd6Mye9=xj7MgACcWa7R1PcagFLzwQ@mail.gmail.com> <20231212233245.14ae64258bdf07ae1d2f2ff9@kernel.org>
In-Reply-To: <20231212233245.14ae64258bdf07ae1d2f2ff9@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 15:57:52 +0100
Message-ID: <CAJZ5v0gObpUYXBydJG-JA5Ew=gScFMEdp6Xu=viv5FT0xyLQQQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com, briannorris@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:32=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Rafael,
>
> On Tue, 12 Dec 2023 14:39:17 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Mon, Nov 27, 2023 at 11:38=E2=80=AFAM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > Expose last succeeded resumed timestamp as last_success_resume_time
> > > attribute of suspend_stats in sysfs.
> > >
> > > There are some printk()s for printing the similar resume timing to
> > > dmesg, but those are recorded with local_clock(), and user can not
> > > compare it with current time. We also have tracing events but it
> > > requires CAP_SYS_ADMIN to use it.
> > >
> > > This suspend_stats attribute is easy to access and only expose the
> > > timestamp in CLOCK_MONOTONIC.
> >
> > Why CLOCK_MONOTONIC?
>
> CLOCK_MONOTONIC is the simplest clock which can be used in both user
> space and kernel space. If we use the CLOCK_LOCAL here, user can not
> know the actual time delta from the succeeded resume.

So what does user space need to do to use this value?

> >
> > > So user can find the actual resumed
> > > time and measure the elapsed time from the time when the kernel
> > > finished the resume to the user-space action (e.g. display the UI).
> >
> > Can you please say a bit more about why this is useful?
>
> This is a reference timestamp from the user space to measure their
> processing time for resuming. The kernel side is OK to just trace
> or printk the each component or subsystem internally. But the user
> space needs to know when the kernel resume has been done for measuring
> its component or processes done.

Why does it need to know that?

> Actually this is obscure because the
> end of resuming in userspace is defined by the user-space application
> or desktop systems. But anyway if there is a reference point, user
> process can calculate the delta at any point from that.
>
> >
> > The time stamp is taken at the point when user space has been already
> > running for some time, so what's the exact benefit of it?
>
> Yes, but that timestamp can be scheduled afterwards so it may not
> be so accurate. This can provide the accurate time of the kernel
> resume.

I'm talking about the timestamp added by this patch, that is
/sys/power/suspend_stats/last_success_resume_time.

By the time ktime_get_ts64() in pm_suspend() is called, user space has
already been thawed and is running, so why is this useful?

