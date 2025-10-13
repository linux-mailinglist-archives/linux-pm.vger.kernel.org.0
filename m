Return-Path: <linux-pm+bounces-35997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAEBD5C97
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E11889711
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E522D7DEE;
	Mon, 13 Oct 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NApMBl1T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAF2D7DDC
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381500; cv=none; b=YSAlwnWG1ovuLmlTrx9h8ckYSFNpK9ZnAoXnBSBU1eHucEbwGXXVcwyuST6b0LifZCfC7NBd7hUJZAvhclQZnMbZntnlcud0j/6FiDiO5qtj2vKUo4aRqAZa2SaNnqNA2PAqvaB2aGcBDybyl5755HqaZpK3oRb147T1twB9maw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381500; c=relaxed/simple;
	bh=7Y2bMNKr8rQXdsNf91lUVGNDOpD7AY0UyDjYoYeerxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIKZ8EcfhuTJtdouH/v1+hFHCYXX+twdb4DpEzuxUcgDgGobty3XEYhLtkGYvLCrilJQkC4g7WR+HdVj2ozz80iIPZgSNI/F4Smpfj6yxXztVYKW+NZIOvskiMlLKbs4m9jW6lDAGpDIgYqRncAuq4wgYhwHjJze/TvzkHsW0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NApMBl1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F62C19421
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381500;
	bh=7Y2bMNKr8rQXdsNf91lUVGNDOpD7AY0UyDjYoYeerxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NApMBl1THr79qcbHokhWSl1EAdEQFQjh+7lo6ecPMGbZwHrTKNvDpL2kX6Topzubn
	 Jd8wT8kNohb0vIrJGCLo3q44ioc9riTYTqeS7jn1C5F+IvFfuYdWg7H3pxIu1gmsAE
	 Dxx8CTG/tS3cVGCKdJRs3/xH7GpkBuyZoIg4x8PH/D3i1kRSc6dCvthw4PENVsRUD6
	 9c5EFaqXcWF2l99mFvifbuFyd7TU7mRnm8k51ou/Gj3ZQqMtZ7oq6dB3qQ+e7G+koi
	 k2U8/uaNC1lQmK8pBLHRTjQUlAtlIRIYtRYqQElxF3sex1/MN9NkD8VsSWpBi25kKV
	 nJBEUL60uAIjg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f5dbebf02so833645b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:51:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUke1pXaMEHL0tF6ZLeYEaePykld+UoDqr/6paEdJFLuPzzvozFlTnv36m+Yje4/scphw7u3m9iUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8cJzAiuVzm7msaPq5Cz7KSzJ4tmNA/lKMl1Kgi5kkKkrQq5d
	Z9HdhhuBT2LuDyT3b9JX9F9KDaPhbLENtECr8x69IpJUzHqCcmwKTl8E4LP6kz/zZ/mDwCUMgWu
	M/3tNH1BQ6j6ilM8HvjMohs6OpOAmXEQ=
X-Google-Smtp-Source: AGHT+IHp04j0X8V+YZn78AWh+GE1NkZUNURdFGmB0yxPRQjsTStFnwWmD2B8Ldqps7NzxrcIRd71Se/yGCxtIOI52NA=
X-Received: by 2002:a05:6808:2227:b0:43f:2c73:347f with SMTP id
 5614622812f47-4417b2c44f7mr8886330b6e.1.1760381499288; Mon, 13 Oct 2025
 11:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com> <20250919153008.324338-2-marco.crivellari@suse.com>
In-Reply-To: <20250919153008.324338-2-marco.crivellari@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:51:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
X-Gm-Features: AS18NWDP7weQw8xJd8EY6ufmdL1fH7PzayLqxb-HH7im4vrRHXdzpJCFJzFuGd4
Message-ID: <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: WQ_UNBOUND added to pm_wq workqueue
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:30=E2=80=AFPM Marco Crivellari
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
> This change add the WQ_UNBOUND flag to pm_wq, to make explicit this
> workqueue can be unbound and that it does not benefit from per-cpu work.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 3cf2d7e72567..33a47ed15994 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -1056,7 +1056,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
>
>  static int __init pm_start_workqueue(void)
>  {
> -       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE, 0);
> +       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
>
>         return pm_wq ? 0 : -ENOMEM;
>  }
> --

Applied as 6.19 material, thanks!

