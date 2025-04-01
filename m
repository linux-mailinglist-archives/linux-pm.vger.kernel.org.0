Return-Path: <linux-pm+bounces-24712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41BA780EC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFD188A8A0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244028E0F;
	Tue,  1 Apr 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F94uz2pa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DD20D516;
	Tue,  1 Apr 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526707; cv=none; b=SO4llYoeJv5uKeA52EUDiNqAUts02fP7SaKYaBHy9k0zI/TXmgB2FoDTzTpNE5AyVC3nsGjyC6uJi7TQkTlnk6L3FngyLXDqdqMyaIdqDUO4YcZaVuVEP0r2SxZcNgVItW9PfxprYYZAmtnBwfy8X4U79wQrzeMzmFcSy47vzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526707; c=relaxed/simple;
	bh=v6s7bDCS/DsYKT4hnHgqWuKObFggxODcNZ74PNLygnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF2duR5JfIckVIkHPjfUD0UIPuuJp6wGQQLBdrW7G90Yka4KIWvynZoZocufmUtPNfOn9MZPaiFcMOjIXCc2Jw+Xdszhelzv6R6FxQHQVKVsY56y+i/TvUR0CfTUcESdPCB9wvyY4c2M44hNELWfsMAEI72q8a8E//5wTsJCJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F94uz2pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B7BC4CEE4;
	Tue,  1 Apr 2025 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743526706;
	bh=v6s7bDCS/DsYKT4hnHgqWuKObFggxODcNZ74PNLygnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F94uz2paQhw1Dpsmz1wkrbV/mKW7CUgmoJXWdoB2I2WZo8x6HmboBxOh8yoDo2C/x
	 e7Tl3UaGwAIzep6IP7Kerm+Tk0mdBx4QyXhlUpz00bj2zYPQwNYUy9lXhslUd13X0M
	 cKQtHG5GcAwEh2XkHQ28zjh/G2gatMZ6vj2e6jZvprjdWl9D/zfjm5k2/Ha0S5YHGM
	 A8CczThxsD7Kts1aQEV7TTYI+K2imlTC1jm3PmInvzuJrB+zFVp/rKDHvS9KcI6SQD
	 Ua0I9WTGmkHK1lM64zbLZ+tUhJoTn6bAWfh8uQvGoK+QBRmGcPUDA2GHx1InhNojhU
	 9qFLxOLFv9JAg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3feaedb4085so3165638b6e.0;
        Tue, 01 Apr 2025 09:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE7WSlrJw5Zfl+aYECwUDIFr1neH4l/SAT09HcsQI69OUz8Hz7mO9tjhTSKrtu0EcJ5kjK+dxVZ5soroI=@vger.kernel.org, AJvYcCWOczQAJypZ5rXTMSAYPfuUyBftpWs9PKgE8dIOFjX0aqXZ6N2QMlVqG8gZBOvZvyIuo6/8VWTvWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5gxI2DFez299CvlYdbb/xiM2cLVe9qyEaj43XhYKUce024O/
	UBgykhk71/9sn64F80siFBLudLBDkOGUgUTPDrNXlUfhBSSn/V6O4v0tojq8XOcc2hDyKAIjhO2
	0WnDZahNG+jhETW93T3upEGh1aBU=
X-Google-Smtp-Source: AGHT+IH7YLbAARqxG7NxXq/bcN5z48KOXBSk3iSJJyuO4A8OdHqSdgMwTo/TywEPxPVpsRTDJzjEMuihhn4xd67jH1g=
X-Received: by 2002:a05:6808:2f07:b0:3fb:85cc:9f27 with SMTP id
 5614622812f47-3ff0f3f2fb9mr7745765b6e.0.1743526706137; Tue, 01 Apr 2025
 09:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317060357.29451-1-aboorvad@linux.ibm.com> <525a2352-dc57-45ca-adb2-f7039c37145e@arm.com>
In-Reply-To: <525a2352-dc57-45ca-adb2-f7039c37145e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 18:58:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0js=Ca4MtcTa2zO2B_fCZNJrOAJzRKAPWSD6fFzn88z_w@mail.gmail.com>
X-Gm-Features: AQ5f1JpdebilsYZyr2YXcx3myGPJfef2dtUL8ldMwAzs4Rd7Grs9wbk-0c8nEUk
Message-ID: <CAJZ5v0js=Ca4MtcTa2zO2B_fCZNJrOAJzRKAPWSD6fFzn88z_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle: menu: Prefer polling state for short idle durations
To: Christian Loehle <christian.loehle@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:35=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/17/25 06:03, Aboorva Devarajan wrote:
> > Avoid selecting deep idle state when the predicted idle duration is
> > shorter than its target residency, as this leads to unnecessary state
> > transitions without energy savings.
> >
> > On virtualized PowerPC (pseries) systems, where only one polling state
> > (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> > its target residency exceeds the predicted idle duration hurts
> > performance.
> >
> > For example, if the predicted idle duration is 15 us and the first
> > non-polling state has a target residency of 120 us, selecting it
> > would be suboptimal.
> >
> > Remove the condition introduced in commit 69d25870f20c
> > ("cpuidle: fix the menu governor to boost IO performance") that
> > prioritized non-polling states even when their target residency
> > exceeded the predicted idle duration and allow polling states to
> > be selected when appropriate.
> >
> > Performance improvement observed with pgbench on PowerPC (pseries)
> > system:
> > +---------------------------+------------+------------+------------+
> > | Metric                    | Baseline   | Patched    | Change (%) |
> > +---------------------------+------------+------------+------------+
> > | Transactions/sec (TPS)    | 494,834    | 538,707    | +8.85%     |
> > | Avg latency (ms)          | 0.162      | 0.149      | -8.02%     |
> > +---------------------------+------------+------------+------------+
> >
> > CPUIdle state usage:
> > +--------------+--------------+-------------+
> > | Metric       | Baseline     | Patched     |
> > +--------------+--------------+-------------+
> > | Total usage  | 12,703,630   | 13,941,966  |
> > | Above usage  | 11,388,990   | 1,620,474   |
> > | Below usage  | 19,973       | 684,708     |
> > +--------------+--------------+-------------+
> >
> > Above/Total and Below/Total usage percentages:
> > +------------------------+-----------+---------+
> > | Metric                 | Baseline  | Patched |
> > +------------------------+-----------+---------+
> > | Above % (Above/Total)  | 89.67%    | 11.63%  |
> > | Below % (Below/Total)  | 0.16%     | 4.91%   |
> > | Total cpuidle miss (%) | 89.83%    | 16.54%  |
> > +------------------------+-----------+---------+
> >
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> >
> > ---
> >
> > v1: https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linux.=
ibm.com/
> >
> > v1 -> v2:
> >
> > - Drop cover letter and improve commit message.
> > ---
> >  drivers/cpuidle/governors/menu.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governo=
rs/menu.c
> > index 28363bfa3e4c..4b199377e4be 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -296,17 +296,6 @@ static int menu_select(struct cpuidle_driver *drv,=
 struct cpuidle_device *dev,
> >                       idx =3D i; /* first enabled state */
> >
> >               if (s->target_residency_ns > predicted_ns) {
> > -                     /*
> > -                      * Use a physical idle state, not busy polling, u=
nless
> > -                      * a timer is going to trigger soon enough.
> > -                      */
> > -                     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLIN=
G) &&
> > -                         s->exit_latency_ns <=3D latency_req &&
> > -                         s->target_residency_ns <=3D data->next_timer_=
ns) {
> > -                             predicted_ns =3D s->target_residency_ns;
> > -                             idx =3D i;
> > -                             break;
> > -                     }
> >                       if (predicted_ns < TICK_NSEC)
> >                               break;
> >
>
> I'm still fine with this and don't see a better way to solve the reported
> issue generally, see the discussion on v1.
> Rafael, do you have any objections?

The behavior change on x86 would be rather unacceptable I'm afraid.

As already stated in a different thread today, on x86 the polling
state turns out to be overly shallow most of the time even before this
patch.

> We could make this conditional on there being a high latency difference b=
etween
> polling and non-polling to keep x86 behavior.

If I'm not mistaken, to address the issue at hand, it would be
sufficient to add an "s->target_residency_ns < RESIDENCY_THRESHOLD_NS"
condition to the if () statement removed by this patch, wouldn't it?

