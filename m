Return-Path: <linux-pm+bounces-33996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3368B45A09
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144C97B06DF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829C35FC06;
	Fri,  5 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTaHxfhN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B35E4EF;
	Fri,  5 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081043; cv=none; b=QC3Dh4160lQfSqL/dOW96EqDa3SdP934Ud0rUJtA3Aj5FSjrpc2G6b65zPRmcAEMG6zHjUFrURdp/SzZPmhbO4/0tJRXh51ctwdLUfqShqN1chyLuWUc9CDAhlT0K8SJkHfez683HrdY3KriFR2ppQcjw4/FURWyK8MdCsbDziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081043; c=relaxed/simple;
	bh=vLqJNc0A6hQb9mRJjRAtSBWmOnC+voVxwxvdDZ0+Z/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTkbJneWWcKpQMUJKUIbs2L9J2CHDB6KhSwLw5DIoIqispF/v/XKFsMi/Q2bw56ikoCFUlvsBNp/m+IbTxyhG1OM+wvCM59uSvyossLLRkXFFKPvvgWw+jS3ZhWj9nhrjjuWu2Xx29KywO+OFwP6jl4wL0LYFojf6A7xDBNpDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTaHxfhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2EDC4CEF5;
	Fri,  5 Sep 2025 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757081043;
	bh=vLqJNc0A6hQb9mRJjRAtSBWmOnC+voVxwxvdDZ0+Z/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MTaHxfhNiDNPB/c+PF+Rkv1CX++GdBS3i4CNIOFPB/R3zBQVNqAa3JNNEdiSQtKij
	 yR6KsCT4rQgwmnariJHnWZ6OcHbhaA7DvgeYM+vUxxdM2J382RINWKm1p1CQnYAOYA
	 k2TRDWbvXUTOe19E6mcZ80yySOmCWSlKADZAn5zu9npoGtvnvAaukOSwAopXRdejnm
	 0dIABSSLYdxmhxM/AHglkHhZhazR6mhyMCXlUpUACCEVJN4hHf/Pna0576TY47h0Lm
	 t7iWUYx6TrVSYt8dumohOhczbcbTENASnEBvMLO14LbxFnwAuGZ3kbzCvWEvZHaYZ7
	 QJFpGzbtcPQJw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e4dbce8d6so838686eaf.2;
        Fri, 05 Sep 2025 07:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3FsHxsGC88N4iRxpwvHwIH4zBhgsOUGpZr3nM9WaiDS6lZx8vLO1Mt/4a8hmJyTDohwwOHHZmRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmz+rtvWAitP8Ekg6+ovw8+wB1Yf96nvDfLPgAw1cbN0W9kMW5
	F8jdCxQG2TpeZ5RujZONwQrekXGAmu1esY42d95BIAlXQ0uShWGOrQPtzR7vxXPhEauBCKVhm4q
	/CTgkoQqIBE7nbaK1YpzT/+0kcRU7JkE=
X-Google-Smtp-Source: AGHT+IFGYg6KR687l3jjJ5aWJrWE/jrYh5yHsuVW/HQn98XowY1NzkAL0yqwlXJWr6w89dFoIbOwW+qxIGABCbyVZQY=
X-Received: by 2002:a05:6808:1812:b0:438:3ae6:d5a5 with SMTP id
 5614622812f47-4383ae6d76cmr3862443b6e.35.1757081042920; Fri, 05 Sep 2025
 07:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090602.105725-1-marco.crivellari@suse.com> <20250905090602.105725-2-marco.crivellari@suse.com>
In-Reply-To: <20250905090602.105725-2-marco.crivellari@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 16:03:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jr1-dD9_cWrgunkXEsqE25CsHwpB5U0Zn_z7ztXRbSeg@mail.gmail.com>
X-Gm-Features: Ac12FXxna5eDr0zHh9hqw_XJXOHz4EJRyDl-Eo8VYSEcg1USqbB15o5H4-CujtQ
Message-ID: <CAJZ5v0jr1-dD9_cWrgunkXEsqE25CsHwpB5U0Zn_z7ztXRbSeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: WQ_PERCPU added to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:06=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API=
.
>
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.

Duplicate paragraph.

> This patch adds a new WQ_PERCPU flag to explicitly request the use of

Using phrases like "this patch" in kernel patch changelogs is
discouraged because the patches become commits when they go into git
and then the language becomes slightly odd.  You can say "this change"
instead.

> the per-CPU behavior. Both flags coexist for one release cycle to allow
> callers to transition their calls.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.
>
> All existing users have been updated accordingly.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4817..eb55ef540032 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -1012,7 +1012,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
>
>  static int __init pm_start_workqueue(void)
>  {
> -       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE, 0);
> +       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_PERCPU, 0);

I have no strong opinion on the change itself.

While preserving the current behavior is prudent, this particular
workqueue may as well be better off as WQ_UNBOUND.

>
>         return pm_wq ? 0 : -ENOMEM;
>  }
> --

