Return-Path: <linux-pm+bounces-27588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE58AC2619
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506363AC2E1
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA866296723;
	Fri, 23 May 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAxOtxvk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93524294A04;
	Fri, 23 May 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013270; cv=none; b=JDtu62Z7DMFrULsUYmIjYHnQYh26ZAQrEDPT5aH/ws/Ve0Hes1JulfQ9yT9+hPK0HBUbB0g3DFVHZsUBEsQPSyP//rNgalaTnOMerYTQy+Rz1R0T8nN03lQFEpsesrkLpfAFh2MYmU16o7EtOw2JNIovlqOOUqvkP10NCpEw0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013270; c=relaxed/simple;
	bh=0Qw66rc7PmkxBXsDw/t2zc/4z3MAFYfxOMkORRxiylc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVplnKzNkeB/uswLLWCpyeDxV8KFuRnbdMITymgWbtnmk7wFGo8+4cP4bzOA2GvVQEZQTTMiKoSBIefu1cfEyz/8A9ZEjEHY89bQcqVLtQEa+dZnd6hmuae5i4rEw5tc8bMMBaAuQrKjw7iIHWaFlv8GKgNIo4bk7gXZdouY/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAxOtxvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCADC4CEE9;
	Fri, 23 May 2025 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013270;
	bh=0Qw66rc7PmkxBXsDw/t2zc/4z3MAFYfxOMkORRxiylc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BAxOtxvkHqlhntoG02uY9XO9rTEmZVz7VCzQw+Sn+nWw8DrYgF9cRe7y+xR0imvFT
	 4vGAcM5M42BOyMoYLbexs+NK7P3alZaeQ/aAeTDCS7u49zvOxWzRka1ym3DMSAkwa9
	 ah+ajsmdjU7yfsV3K7aQ9mcaiGvW5HAdjSTOfm5E5AFXAByegyGft1WwUbFaXfIZlO
	 iDGQGDD0ERMwgP9x0OEshMRqQvw9fsrUcyhGMPAfJCK2cTmufulKvjWp/wka44h+pN
	 ZQf3zYUAxch4Efq9GFUkbRO5QulmhfV9u3+4JQ4gBv9JjtaxCq7bliKz/76cg8MI1e
	 hshD+0JMm7ccQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60b8a9be972so11577eaf.1;
        Fri, 23 May 2025 08:14:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY/mNuXuKbhGItXqet4TodSa8elVa8s60FDgYgRZILFFmyP7JHJkJ84abalWKpji+K4uxlZEm5y29I5OA=@vger.kernel.org, AJvYcCWyaCFGFzurdzjV2is0g2HLyfZJKfxvkYA9/pKjXnnz6P93br69N0v4RIWGDQUwcqRx1YDT9vSiEvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANx0ZA2T1+aNIPdNnuqG1ND91UrJFXb1Bi0jHxK4uyMdfSHqL
	6uI6p5kOH8k5DYfDuFUWnYn7t5zpYBN0odNV8YBi+1TpJlZrcP8AoZKV1ksgG/i+/v1pt6nBNVh
	+FVQl2/j/cG0MCgGTWqVcqeqYNx3FHYc=
X-Google-Smtp-Source: AGHT+IHgbeaYJujl+cfbxuxc1QsSxMsWo29Cf9GRGctriPfjo9YYNXi5dgreqXSQN0lHqPMLs4yiPndPUAFqAJ1KsAM=
X-Received: by 2002:a05:6820:1990:b0:605:f34d:7e00 with SMTP id
 006d021491bc7-609f376c5c0mr18879038eaf.7.1748013269433; Fri, 23 May 2025
 08:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523034253.88083-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250523034253.88083-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:14:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7i1zbcR7Tv4zNDzR8__keq3bV2m1BZJCS0-cxT8Da4Q@mail.gmail.com>
X-Gm-Features: AX0GCFvM-eoDysKXc8iJBisS9rMmvxIADQatA2sZ0L8nAWQSXFVSvvpxzo6Au1Y
Message-ID: <CAJZ5v0j7i1zbcR7Tv4zNDzR8__keq3bV2m1BZJCS0-cxT8Da4Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM / Freezer: Skip dead/zombie processes
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 5:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> ZOMBIE (exit_state =3D=3D EXIT_ZOMBIE) and DEAD (exit_state =3D=3D EXIT_D=
EAD)
> processes have already finished execution and will not be scheduled again=
.
>
> In the context of system suspend (e.g., S3), attempting to freeze such
> processes is unnecessary. Moreover, freezing them can obscure suspend
> diagnostics and delay resume if they appear "stuck" in logs.
>
> This patch introduces an early check for `p->exit_state !=3D 0` in
> `try_to_freeze_tasks()` and skips freezing for such tasks. This is a safe
> optimization because:
>
>  - They hold no running resources
>  - Their `task_struct` is only waiting to be collected or freed
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>
> Changes in v2:
> - Simplified code, added judgment of dead processes
> - Rewrite changelogs
> ---
>  kernel/power/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 66ac067d9ae6..82528a79d46a 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
>                 todo =3D 0;
>                 read_lock(&tasklist_lock);
>                 for_each_process_thread(g, p) {
> -                       if (p =3D=3D current || !freeze_task(p))
> +                       if (p =3D=3D current || p->exit_state || !freeze_=
task(p))
>                                 continue;
>
>                         todo++;
> --

This is a bit too late for 6.16, please resubmit when 6.16-rc1 is out.

Thanks!

