Return-Path: <linux-pm+bounces-28818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF7ADAE35
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D6C17044B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9B2BDC37;
	Mon, 16 Jun 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqmxzZ6R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB02D0283
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072880; cv=none; b=P6qEkFZFTZrWd0tyBAVPoozoDwZamc3fvTNxxNg8WM1CbIr5lAsfmKH6kSXYYHfuo7jFPhWiULNX7MLU0IXBC7h8VafjpGgumfKDaRio09JqoWUwXQSZfVwSOZowpxuGkqWMIVo2PIlQEvFELjHS6FsaIAexvrkPZ1ruJ1QBQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072880; c=relaxed/simple;
	bh=3lugUNOQqs13Yrt3c9ZQ8ODY6hy8OCdJ+EaMZw7sGHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BevixyZW0CnEsHKKD8xJMGqIdd8WJs1zVtLKvvZdDJchu121GZiMEQV/1sMyUx8tWuK7ROgN/ouAi7JXqpL5rxn84FX3wb0ejDXC1CcUhuvb31QlTM7RcXV45q+lvBt6G/OAAkWAEiuXySPBjLv03WxMfir0pdv2ISBJ7VzbPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqmxzZ6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AFDC4CEF3
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750072877;
	bh=3lugUNOQqs13Yrt3c9ZQ8ODY6hy8OCdJ+EaMZw7sGHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OqmxzZ6RcjePVT8yXu2QkZGI9uVy4pOPE7B1540JLIzt4izQYlPGB/E/ySX8mYgh6
	 R3q87yFcXO5lGCyA+JMEm0KSkHp0euwR1+/lcdkpmiSzuCZ8nwerBkZAMLdUSZ4ggc
	 twfTVYbw3aIdFmGbFOZ8e3h8O6K2QDXY1zkuory0s5cCSE7mYPYep7Tg19hALpD+jZ
	 5RhEK2MQaMRFvnZKFxkdJT4+tjAsv1TnORo9HqxLsLUZ9m6B07D40fBtjBcdbRLOY8
	 iEQHxneHvqXuY3l+RQ4OsuSWtbVXEkuOF0z61DmlCsYF68Y4m9ShP8gEVWAKZK2RnT
	 WIxNoXG030LiQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60ef07eb7f4so2241222eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 04:21:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw153T7GkvlWqTzEo/7amNBDObxSH0QrD8X+3AooBiApzP9Vlwg
	eMgZ8FelYi9zLvNp/DIwtyvvB7MTh/SBuAYVggLdTBwmnZeZHftao5e0wOckEvvhtS+XiC3JQIm
	wH8YfVmfQPkoFxnsJNnqyZxJWm6NgUU8=
X-Google-Smtp-Source: AGHT+IE8iOWFFiDI4jSiDv7lFXEuB6/xCeoeDdmJzdgVB8OqtqLSAF1t2XRFrDuK+EIdxZqLT3WM19+vqP8xgyQATI8=
X-Received: by 2002:a05:6820:c314:b0:611:11a3:7eac with SMTP id
 006d021491bc7-61111a380bcmr4050547eaf.3.1750072876950; Mon, 16 Jun 2025
 04:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 13:21:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>
X-Gm-Features: AX0GCFs4njhr2KiW-dFUefW5qB1c5jI-tu4XL2-vrKJCNkXWl2zf7YoNb9aJxzM
Message-ID: <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:12=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Folks,
>
> The original plan for adding pm_runtime_mark_last_busy() calls to
> functions dealing with Runtime PM autosuspend originally included a few
> intermediate steps of driver conversion, including the use of recently
> added __pm_runtime_put_autosuspend(). The review of the set converting th=
e
> users first to __pm_runtime_put_autosuspend() concluded this wasn't
> necessary. See
> <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@lin=
ux.intel.com/>.
>
> This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> the _autosuspend() variants of the Runtime PM functions dealing with
> suspending devices, i.e. pm_runtime_put_autosuspend(),
> pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> pm_request_autosuspend(). This will introduce, for a brief amount of time=
,
> unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> an issue. Also, all users of these functions, including those that did no=
t
> call pm_runtime_mark_last_busy(), will now include that call. Presumably
> in the vast majority of the cases a missing call would have been a bug.
>
> Once this set is merged, I'll post further patches to remove the extra
> pm_runtime_mark_last_busy() calls. The current set of these patches is
> here
> <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.gi=
t/log/?h=3Dpm-direct-on-next>.
>
> It'd be best to have all merged within the same cycle.
>
> Rafael: any thoughts on the merging?

I'm going to queue this up for 6.17.

> Would an immutable branch on top of rc1 be an option?

I think so, but does anyone need it?

> The patches apply cleanly on v6.16-rc1, v6.16-rc2 and linux-next.

Awesome, thanks!

> The changes in the patches to remove the pm_runtime_mark_last_busy() call=
s
> have been generated using the following Coccinelle spatch:
>
> @@
> expression E;
> identifier label, rval;
> @@
> - pm_runtime_mark_last_busy(E);
> ...
> (
>   label:
> |
> )
> ...
> (
>   pm_runtime_put_autosuspend(E);
> |
>   pm_runtime_put_sync_autosuspend(E);
> |
>   pm_runtime_autosuspend(E);
> |
>   pm_request_autosuspend(E);
> |
>   (void)pm_runtime_put_autosuspend(E);
> |
>   (void)pm_runtime_put_sync_autosuspend(E);
> |
>   (void)pm_runtime_autosuspend(E);
> |
>   (void)pm_request_autosuspend(E);
> |
>   return pm_runtime_put_autosuspend(E);
> |
>   return pm_runtime_put_sync_autosuspend(E);
> |
>   return pm_runtime_autosuspend(E);
> |
>   return pm_request_autosuspend(E);
> |
>   rval =3D pm_runtime_put_autosuspend(E);
> |
>   rval =3D pm_runtime_put_sync_autosuspend(E);
> |
>   rval =3D pm_runtime_autosuspend(E);
> |
>   rval =3D pm_request_autosuspend(E);
> )
>
> since v1:
>
> - kernel-doc fix in patch "pm: runtime: Mark last busy stamp in
>   pm_runtime_put_sync_autosuspend()".
>
> - Dropped the first patch which has been merged already.
>
> Sakari Ailus (6):
>   pm: runtime: Document return values of suspend related API functions
>   pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_request_autosuspend()
>   Documentation: PM: *_autosuspend() functions update last busy time
>
>  Documentation/power/runtime_pm.rst |  50 ++++----
>  include/linux/pm_runtime.h         | 187 +++++++++++++++++++++++++----
>  2 files changed, 186 insertions(+), 51 deletions(-)
>
> --

