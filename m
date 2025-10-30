Return-Path: <linux-pm+bounces-37137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C1C21E30
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61C64242EA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1E374AA5;
	Thu, 30 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCBYXG8D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379F36E356
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851524; cv=none; b=MV+IjEHuOkERNCl5D9dxKAJ6ctY6PK4kZmBElMcYtX8GMHXjMsBrTRHMWeMQKKmnq1obmNcRzrQb0radTkA0u8WzOFTvXVhaloiEfEf/DNt2DDOR84rAOApQwzHexT6gumkUHghadwyDo4RLx9yoFV6hZSk9pKkvxioU0SALR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851524; c=relaxed/simple;
	bh=6xyDz4Zv+Fz3D7eGGPtoJdgPOgu0NDwcJxs8Vj+X7vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckvFZ+BH0Bl1gcWIqzzDUtqASmS2+aMFA2dbYDLRpGkTfRmMamRqTMr6nJ7vLQThJdsTi+yxyp+Hc7bOIL3MVoW8aK7iHq9BVQkgIGqYpxyhmn1mBQ+C/YSYJLEqsgBfCMVUW3aZehUnIfzbHBXiF5jgYHaK1bFuLuLV9LOTUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCBYXG8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F00C4CEFB
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851524;
	bh=6xyDz4Zv+Fz3D7eGGPtoJdgPOgu0NDwcJxs8Vj+X7vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tCBYXG8DaR6/kiP003dg2+xF4uWJVKQustcz7V3hQ1z8dRqWX87dQBDHGfbg2uS1d
	 zgpIVuKDqoZfsKXqQ39PkQifnCdeHzMycY11jB/O723+Nqj4G9Sz8rN+fP/nrs34qg
	 +Z+BQBXiWeOIH9rgI5mw012DhOH1oNKwxHRY7TK13asEiEYsWClvHPrWK107BYe7l2
	 yuXMjdx03X/J1bX4BTQK3NnB2uawsPX/rhx9t56SrKR4SXzaSYfUtn6abhQMttfIrm
	 LDD4rKoxD7xBtBZ4gyl6kaAiWzs/d4Syu2XwIhtA9ZPxt4W6J3OfX8M/0UPEj928tu
	 GwAEmXyj/JmKQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-651c743b2d9so650746eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:12:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVof8AkXCLgFiPs5myM9WTiJZhs/sRUMjlOzpcdI5qxI+bswGQtNIhPpUdYnViuHlxg6y3C88+FKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvANtRHU9Ws8dvdRBQ+0sjZhCetty2a8+cSFIPHrUZSrmxY+o
	xGNr/40BA4XtKAy6vHo6YKtlIBI7u7KmCnFHvu9/r4bTLBnkFfOq0RefLHpaRoK+i3Ah66mgSm5
	iVqVL66PRQmd2WQhN09QwdZ0hvwJBe+w=
X-Google-Smtp-Source: AGHT+IE6TrJjM9TRHexTnovuHzQRW1lUv7NW/lz08f1NwlylUgWvTyacZkqDtcU1rODiMJXU04fh+Y3wt8PU6SdWFqs=
X-Received: by 2002:a05:6820:1c88:b0:656:8300:2f4e with SMTP id
 006d021491bc7-6568a6e8057mr418989eaf.6.1761851523519; Thu, 30 Oct 2025
 12:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPZ3q6Hm865NicBC@slm.duckdns.org>
In-Reply-To: <aPZ3q6Hm865NicBC@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 20:11:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gPNwrKXNg1Ng6bJ5B99PEDNhdh2YrfvbcpXc4CjLq0ww@mail.gmail.com>
X-Gm-Features: AWmQ_blQ5bUzIcmxIXXhh4vKWwm397kKdEkdtDaeZlFIwyqPH0qBTNkbeDTpsJQ
Message-ID: <CAJZ5v0gPNwrKXNg1Ng6bJ5B99PEDNhdh2YrfvbcpXc4CjLq0ww@mail.gmail.com>
Subject: Re: [PATCH PM/for-6.19] freezer: Clarify that only cgroup1 freezer
 uses PM freezer
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Qu Wenruo <wqu@suse.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:55=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> cgroup1 freezer piggybacks on the PM freezer, which inadvertently allowed
> userspace to produce uninterruptible tasks at will. To avoid the issue,
> cgroup2 freezer switched to a separate job control based mechanism. While
> this happened a long time ago, the code and comment haven't been updated
> making it confusing to people who aren't familiar with the history.
>
> Rename cgroup_freezing() to cgroup1_freezing() and update comments on top=
 of
> freezing() and frozen() to clarify that cgroup2 freezer isn't covered by =
the
> PM freezer mechanism.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/linux/freezer.h        |   12 ++++++++----
>  kernel/cgroup/legacy_freezer.c |    2 +-
>  kernel/freezer.c               |    2 +-
>  3 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 32884c9721e5..0a8c6c4d1a82 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -22,14 +22,18 @@ extern bool pm_nosig_freezing;              /* PM nos=
ig freezing in effect */
>  extern unsigned int freeze_timeout_msecs;
>
>  /*
> - * Check if a process has been frozen
> + * Check if a process has been frozen for PM or cgroup1 freezer. Note th=
at
> + * cgroup2 freezer uses the job control mechanism and does not interact =
with
> + * the PM freezer.
>   */
>  extern bool frozen(struct task_struct *p);
>
>  extern bool freezing_slow_path(struct task_struct *p);
>
>  /*
> - * Check if there is a request to freeze a process
> + * Check if there is a request to freeze a task from PM or cgroup1 freez=
er.
> + * Note that cgroup2 freezer uses the job control mechanism and does not
> + * interact with the PM freezer.
>   */
>  static inline bool freezing(struct task_struct *p)
>  {
> @@ -63,9 +67,9 @@ extern bool freeze_task(struct task_struct *p);
>  extern bool set_freezable(void);
>
>  #ifdef CONFIG_CGROUP_FREEZER
> -extern bool cgroup_freezing(struct task_struct *task);
> +extern bool cgroup1_freezing(struct task_struct *task);
>  #else /* !CONFIG_CGROUP_FREEZER */
> -static inline bool cgroup_freezing(struct task_struct *task)
> +static inline bool cgroup1_freezing(struct task_struct *task)
>  {
>         return false;
>  }
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freeze=
r.c
> index dd9417425d92..915b02f65980 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -63,7 +63,7 @@ static struct freezer *parent_freezer(struct freezer *f=
reezer)
>         return css_freezer(freezer->css.parent);
>  }
>
> -bool cgroup_freezing(struct task_struct *task)
> +bool cgroup1_freezing(struct task_struct *task)
>  {
>         bool ret;
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index ddc11a8bd2ea..a76bf957fb32 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -44,7 +44,7 @@ bool freezing_slow_path(struct task_struct *p)
>         if (tsk_is_oom_victim(p))
>                 return false;
>
> -       if (pm_nosig_freezing || cgroup_freezing(p))
> +       if (pm_nosig_freezing || cgroup1_freezing(p))
>                 return true;
>
>         if (pm_freezing && !(p->flags & PF_KTHREAD))

I gather that this is for me to pick up, so applied.

Thanks!

