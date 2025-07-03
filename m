Return-Path: <linux-pm+bounces-30053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD71AF77C3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043AE1880884
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AC2ED16E;
	Thu,  3 Jul 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZPMEHH3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DA2EBBB7;
	Thu,  3 Jul 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553534; cv=none; b=g5dcZ2OU2DnCcnKlY4+QmI/Uh+ppAy71fB9aVNFtCf0+2y+tj47ltRaBPj/JKwmNbkDQxMJb5gVSHKuvrw/ZTuG/OsOKSj1glEcd6m70EV203lZg0kQcDorsSIOsWIfcQWu10vxCjiHv4rHS7cRmVmraT3VUhtTBAuZDpWXhEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553534; c=relaxed/simple;
	bh=zvfS0hlVmZgCH6Ec9VZqZpSodo2ZG81sQHZGHrVDm2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKXXq+cmDAxRrPXaEWv0jWy8Z7GPOiYE0x0gB9+jW5MFNxQuS5ya2mZkd/Zwl1B3oYbQ/JSpNXTOTeo90LmW9Ydf/QaPjP19e7sPXeN/nmI/6anZiFGco/XK1haWs62xvO3IjEwyJdCh+zYKiaTOVPTynyOEUOHKV2sc9QfMX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZPMEHH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21744C4CEE3;
	Thu,  3 Jul 2025 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553533;
	bh=zvfS0hlVmZgCH6Ec9VZqZpSodo2ZG81sQHZGHrVDm2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FZPMEHH30nWrJnsg6H7KIh9nYTEJv6WSEeYwDklJxEujIUs8eFQjQz8/nRu5RavuD
	 e45WeDIGHpR0x480X/hb8Dwuoq46TlWxkbEiqRwNvaEB+VH5sv5C08mYjBDr8mg9+O
	 eS3ikMhmRqGQD8DIen9ZzDZKoBy+dC3DLC87xIlCcpqi/7ZOAC6+8RAkNBR1/75CEc
	 D0p4WZ5kShrD+SW6n8CUQGUsul3JZ66Hpp2MLvxQUzlUlQwcQy8+rrn8fNjLlw4rwV
	 3vJYxu5lZjSLt/PIcSNf9+pOpuNV8ilp4tp+ULXzKIRjCl1Qjgxo4kvnH48GfiEv8n
	 L2Hc6R0BUxUtA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60f0a92391bso15021eaf.0;
        Thu, 03 Jul 2025 07:38:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ+bFYhcIPI7UsAbPjMBFRDMa0FjyIVHRe/8EzVXhYSvofJ4cZ30KZyKWZK2pEYkFCj7czgZ9E/lw=@vger.kernel.org, AJvYcCXeb9pqC9xG/JUT4gsfEJgL6T5l84A60Vi+tmItnxazj5mX3q6O7uryJgcCboyKKp8SI4jAVV/P3jaMYsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaaMshFxRlO/Td5vS5MuVekSnpVm/qAqDgLNsI4IFwFti77536
	RJCwHr5mREwK4R/+8QCXaizTSPOsuvXb0pdh6/kZO1R04HJS9CVIhUE5l3x5IgFpRU0cFg/TP6c
	oju1HwRD8ArfXKEwnvO1u7mxzChOn6Xw=
X-Google-Smtp-Source: AGHT+IGO+6spzaSlr9bkN+L/3X/YVAAjnPK4L/sMudY4VMGRLPtz+v154mwJVVIo6PYuoX1QarlZtHQ3D+dDj4fLKf0=
X-Received: by 2002:a05:6820:290f:b0:611:feed:a7b6 with SMTP id
 006d021491bc7-6137e698007mr3242379eaf.7.1751553532492; Thu, 03 Jul 2025
 07:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn> <20250619035355.33402-2-zhangzihuan@kylinos.cn>
In-Reply-To: <20250619035355.33402-2-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:38:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gLVTe0a8mTRhiDa_4NuFsYw8gPZF9dnLrZzFh3yt424Q@mail.gmail.com>
X-Gm-Features: Ac12FXzEqMrT-8hLYr8iP64JV_wOntB9ABfjixfTmlkc4ai1x6ayTfF3IGQE1ac
Message-ID: <CAJZ5v0gLVTe0a8mTRhiDa_4NuFsYw8gPZF9dnLrZzFh3yt424Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: freezer: Add retry count statistics for freeze
 pass iterations
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Freezer retry loops during suspend are often triggered by tasks entering
> D-state (TASK_UNINTERRUPTIBLE), which cannot be frozen.  This patch adds
> a simple retry counter to freeze_processes() to help quantify how many
> attempts were required before all tasks entered the frozen state. This
> is useful for performance tuning and debugging unpredictable suspend
> delays.
>
> A new dmesg log is added for visibility:
>
> freeze round: xx, tasks to freeze: xx
>
> This message allows users to correlate freeze instability with system
> state.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/process.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22..87616ca710ac 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -32,6 +32,7 @@ static int try_to_freeze_tasks(bool user_only)
>         struct task_struct *g, *p;
>         unsigned long end_time;
>         unsigned int todo;
> +       unsigned int retry =3D 0;
>         bool wq_busy =3D false;
>         ktime_t start, end, elapsed;
>         unsigned int elapsed_msecs;
> @@ -63,6 +64,8 @@ static int try_to_freeze_tasks(bool user_only)
>                         todo +=3D wq_busy;
>                 }
>
> +               pm_pr_dbg("freeze round: %d, task to freeze: %d\n", retry=
, todo);
> +

This is kind of fine if it is really needed, but it needs to have a
separate on/off switch as far as I'm concerned.

Maybe use pr_debug() for it in which case it would be controlled via
dynamic debug?

>                 if (!todo || time_after(jiffies, end_time))
>                         break;
>
> @@ -79,6 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
>                 usleep_range(sleep_usecs / 2, sleep_usecs);
>                 if (sleep_usecs < 8 * USEC_PER_MSEC)
>                         sleep_usecs *=3D 2;
> +               retry++;
>         }
>
>         end =3D ktime_get_boottime();
> --
> 2.25.1
>

