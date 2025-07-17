Return-Path: <linux-pm+bounces-30994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E5B089C1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CE4564EA2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F3291C28;
	Thu, 17 Jul 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+7SuC6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6428A410;
	Thu, 17 Jul 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745861; cv=none; b=X5Kq9ITpchpgvS2Lcx3Xxm1ruG7MqNGNriMbGQjBO1rkgnqBhScfko+FOqlJ5823FOLb/G77saj0jF3dbvVYtm0XnN9GeKKmdY98bJS2deg4/aZMG55tIiWeMfknAj+y8Z6OD4CX8TGR0Pn0+dWkSytr2+ym/0t0RPrAy9sAQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745861; c=relaxed/simple;
	bh=xksjneoIi3+E3CNeYiNA4UzZ51ibysOw5iki9I32EMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2XVUEl1C5msJ1jRY2x8ctKXj/265z1DlQ3MkGfdSRdV2dMO6R7ywJgo+6A/HR5wc/IpPIxuIiNjsQ6Tr/k2zp6UL4e088yy8iiUb464l3Sj+eG8n09q6CFJXqIAybIiJ+Xn/uoLgycq+izCoJG8VnbErqnN5OagO2z0aEhY0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+7SuC6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B27AC4CEF6;
	Thu, 17 Jul 2025 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752745861;
	bh=xksjneoIi3+E3CNeYiNA4UzZ51ibysOw5iki9I32EMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R+7SuC6LTdTO9nrA9Qx3rkB5LB7zxlR2abuB5ta6ycmPnxNhVGIWRC280C4waRDsW
	 aSmXCYApitBwsNKL6qtxb3ZC5YGsK8xhVsyZdqiinqSjx752pWhLuQW8S17yJYOYdG
	 1qEyBhy73jSQlT81eOBWH57wBvigMMgBskpiHNV9XVGTz823Mg3eFzdy1LiJrbTTGO
	 8YWsHlG1NOmj4V1BdjEQKZq4SKQTW4s0emV7BdKdhTWpT3DZDh/6AIi10C4953G3PW
	 UPUxQCCLj0SHr4xNuLFgPVS98F5liOvFt1ojmG3aXIHW4rH9C6kIWzPhA4vhLH0+HH
	 bzxKxnTihnABg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e58d5108dso384483a34.3;
        Thu, 17 Jul 2025 02:51:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs6uSw8ozT8yBViPng5AwjX6clXXQw3lNlY7YRKq50BcPW4C0Bx8+SYr3za/ods1rdtX7rDLdRlGw=@vger.kernel.org, AJvYcCXsLdjl28SFd02yg0KaLK4xODUTBbsmk2GFhXF+pjKwhGRV1ngJM26StaqasEiNLailZJUbtbc1sSkHFaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqddD87bZpLym0OV0YcbBu7LcoXWT6AXqMaRTXZ706+ETTirqW
	eAxxhpkBPdWESlIWwQVBHQiRjOHWELDbqXRv9wdGQdrhLBuvVFg6klNXYh9HPpN7yZ/yvcCrnqo
	XtMWRYSQvWKWLPfqVlIwR4U6nIVPshkE=
X-Google-Smtp-Source: AGHT+IEYEZjoWRZhGrLjrN/TLANBOcjGefJaRXKhD4SFMq+aJ0cow3e3qkoJuJsodza7pkcCHl2o9HdyYA15BLOi30U=
X-Received: by 2002:a05:6830:6182:b0:73b:1efa:5f59 with SMTP id
 46e09a7af769-73e64aad09amr5897178a34.19.1752745860663; Thu, 17 Jul 2025
 02:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <CAJZ5v0goQ0DcsWAqn__E7CG=YcNAzdxo9bb-21q50V2H5CJ+xA@mail.gmail.com> <a664f801-7faf-4a9f-b4b8-365afe0c6f5d@kylinos.cn>
In-Reply-To: <a664f801-7faf-4a9f-b4b8-365afe0c6f5d@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 11:50:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvzTupABXQLmTsu7+jEUp14u5XEN4=W7opGi8X2OWorQ@mail.gmail.com>
X-Gm-Features: Ac12FXx5QWZBLrWaqBeAcWVvTiH32Ef0KMCgUP7eG4ILxUO3XvhXFiJk1FdO_kE
Message-ID: <CAJZ5v0jvzTupABXQLmTsu7+jEUp14u5XEN4=W7opGi8X2OWorQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] PM / Freezer: Skip zombie/dead processes to reduce
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:02=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> HI Rafael,
>
> =E5=9C=A8 2025/7/16 20:26, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > Hi,
> >
> > On Wed, Jul 16, 2025 at 8:26=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
> >> Hi all,
> >>
> >> This patch series improves the performance of the process freezer by
> >> skipping zombie tasks during freezing.
> >>
> >> In the suspend and hibernation paths, the freezer traverses all tasks
> >> and attempts to freeze them. However, zombie tasks (EXIT_ZOMBIE with
> >> PF_EXITING) are already dead =E2=80=94 they are not schedulable and ca=
nnot enter
> >> the refrigerator. Attempting to freeze such tasks is redundant and
> >> unnecessarily increases freezing time.
> >>
> >> In particular, on systems under fork storm conditions (e.g., many
> >> short-lived processes quickly becoming zombies), the number of zombie =
tasks
> >> can spike into the thousands or more. We observed that this causes the
> >> freezer loop to waste significant time processing tasks that are guara=
nteed
> >> to not need freezing.
> > I think that the discussion with Peter regarding this has not been conc=
luded.
> >
> > I thought that there was an alternative patch proposed during that
> > discussion.  If I'm not mistaken about this, what happened to that
> > patch?
> >
> > Thanks!
> >
>
> Currently, the general consensus from the discussion is that skipping
> zombie or dead tasks can help reduce locking overhead during freezing.

Peter doesn't seem to be convinced that this is the case.

> The remaining question is how best to implement that.
>
> Peter suggested skipping all tasks with PF_NOFREEZE, which would make
> the logic more general and cover all cases. However, as Oleg pointed
> out, the current implementation based on PF_NOFREEZE might be problematic=
.
>
> My current thought is that exit_state already reliably covers all
> exiting user processes, and it=E2=80=99s a good fit for skipping user-spa=
ce
> tasks. For the kernel side, we may safely skip a few kernel threads like
> kthreadd that set PF_NOFREEZE and never change it =E2=80=94 we can consid=
er
> refining this further in the future.

There is the counter argument of special-casing of p->exit_state and
the relatively weak justification for it.

You have created a synthetic workload where it matters, but how likely
is it to be the case in practice?

