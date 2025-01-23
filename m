Return-Path: <linux-pm+bounces-20894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B2A1AB09
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11D918826FB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139D191F8E;
	Thu, 23 Jan 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFPQYhUj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C298146A71
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663367; cv=none; b=hb9wfocjdD+DyX2ZRm8dNLFmXNqHxczlmCVn9tE/T5TRz2I68EqD1XyaJUeX5YsDC8ohvJyW/PGtQ6EXbp48QpsWQ8PvSVJBDxhYdw+GRAj0C4AP4vfmzCw/fnN6FNif2w7EnqpEnAZpYJF2ynvP4EV+Lb+ungQbkU8ZvyDoWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663367; c=relaxed/simple;
	bh=z8KtELFGH1p3dWeaKia0wRfPsFSoCK2V3xW2HWKvdLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlhX3ZnPEWOQoR3M/PZkDAsD6Xf7kw3gqRGNCzQ/49CL3kTJTONH12dDUJjS175IhLrJfeTvB/PY3EWRelgiwIWj15Nl9gRa4She3T2NFnNBb92fd2p4cj3Z0U+suioN0wz6mVIIHyDUoLK2yv1p8KHVY3e7qAJXiM7x071S6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFPQYhUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891DEC4CEDF
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663366;
	bh=z8KtELFGH1p3dWeaKia0wRfPsFSoCK2V3xW2HWKvdLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NFPQYhUjILid9yOT/9rdebrbVXrHxd+XBhkhqcBV9mN0Q02zY4VoMqGdFuoSlVhAK
	 jHSJ8gPqpEXaoiZwsO6j0Kmyxc4YGmSJ/0GZpeEnms5IgxeQQZ7/LvzaciAlQPVYqH
	 YyRw/My1dpzVsSybxDsTW54CJjWwEZZAKLwqRQnFojIqTWOTQ75rLVzIMzB+1DxW8K
	 IpxoU+ZlHrAYMBgOai38zAvHjRvi95/cKB/wwY7qp4/f90YpzrAbhJRzvJMcqTKtDF
	 qtunXVqkskEzUx7OVe7KL+87iXVHm/r09gVNzaHfCfK4gO4M7TZibuzuVfp01xRu8A
	 ZfjJup/FRzf5Q==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb9bbcc936so817863b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 12:16:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWfupSzTNOaaeKPt63p/gIQFXkBEpYjWX3x0pOlbNvRKkF5CbaXF2kVc2Ngju0As8VvyTd+toUGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBEDU3UVT+Jbhf64ff28or/fK64v6z8QEihKoanMSlkLGCqIN
	Qy7Y7DHsdvHL98qld3iNXjIbVIQ8+pxdabBHnN29d6MHztgrQp0lAXfkpjCFh+rLz4OaiJv0hOK
	0cg58TYMksUmSvGfZ5WdDt/s8+ug=
X-Google-Smtp-Source: AGHT+IF9R2P47OyYoUdCFXKYEWDoFWGHk4lrLJgRNn2b0Qj5nbcBBjzbqlIoWrpGoyaPBySh1kAAA4o/HQjzZ+IP/l0=
X-Received: by 2002:a05:6808:16ac:b0:3e7:b3d9:4109 with SMTP id
 5614622812f47-3f19fca15e4mr17153659b6e.22.1737663365883; Thu, 23 Jan 2025
 12:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119143205.2103-1-vulab@iscas.ac.cn>
In-Reply-To: <20250119143205.2103-1-vulab@iscas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 21:15:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jzstox2aU6XjC9yJAm_m6nczyiENv5UKkdru07Gf8OAw@mail.gmail.com>
X-Gm-Features: AWEUYZm_lGU1gSgJT8oPHBUv86TQMvkj-Bfv9i1QpnspAcvUPUOQgyce4dt11p4
Message-ID: <CAJZ5v0jzstox2aU6XjC9yJAm_m6nczyiENv5UKkdru07Gf8OAw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Add error handling for syscore_suspend()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: rafael@kernel.org, quic_nprakash@quicinc.com, liangwentao@iscas.ac.cn, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 3:39=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In hibernation_platform_enter(), the code did not check the
> return value of syscore_suspend(), potentially leading to a
> situation where syscore_resume() would be called even if
> syscore_suspend() failed. This could cause unpredictable
> behavior or system instability.
>
> This commit modifies the suspend/resume sequence to properly
> handle errors returned by syscore_suspend(). If an error occurs
> during the suspend process, the code now jumps to 'Enable_irqs'
> label, skipping the resume call, and only enabling interrupts
> after setting the system state to SYSTEM_RUNNING.
>
> Fixes: 40dc166cb5dd ("PM / Core: Introduce struct syscore_ops for core su=
bsystems PM")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  kernel/power/hibernate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 1f87aa01ba44..8e5702811732 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -608,7 +608,11 @@ int hibernation_platform_enter(void)
>
>         local_irq_disable();
>         system_state =3D SYSTEM_SUSPEND;
> -       syscore_suspend();
> +
> +       error =3D syscore_suspend();
> +       if (error)
> +               goto Enable_irqs;
> +
>         if (pm_wakeup_pending()) {
>                 error =3D -EAGAIN;
>                 goto Power_up;
> @@ -620,6 +624,7 @@ int hibernation_platform_enter(void)
>
>   Power_up:
>         syscore_resume();
> + Enable_irqs:
>         system_state =3D SYSTEM_RUNNING;
>         local_irq_enable();
>
> --

Applied (with some edits in the changelog) as 6.14-rc material, thanks!

