Return-Path: <linux-pm+bounces-18377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A069E0D6F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED21B2A0EA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9C1DE8B1;
	Mon,  2 Dec 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeyRCeFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A51DD88D;
	Mon,  2 Dec 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170285; cv=none; b=WgcJUIAkH/uWWAN6tGyPU5x1yDugTr2P6pVxvCbyx2ZUFxzqUwixbs4rQhb6bO9Z/3NxI3TsegsIe4Kibbdn6avcRZCXBkyEVo0bJVlLzDielxIhuhsA26O3PEptJrep/hizv9ZYsDt9ycdPcfm2sYCE44ISPkOGmBIL3B5tO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170285; c=relaxed/simple;
	bh=SMljyBQ3PqMcQzJYaV9af8KGCbtNNS53Chu22Ncphq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBBTfEMU7pc1EG/P29M7xnWlcdR2wtX+qJfs31L62hcMnp7YwEK/l1dYefteE8V1NGz52nLviGegUV23lVtgi7XPp4NzOpG6ePo4BgAwMTchdq5E8MNjabTgqjJqmQhlkKW1yqg9D1HrcyZZxN3ueKk5zjnG/mrQvUzsNyJfwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeyRCeFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B6EC4CEE6;
	Mon,  2 Dec 2024 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733170284;
	bh=SMljyBQ3PqMcQzJYaV9af8KGCbtNNS53Chu22Ncphq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aeyRCeFlzS8BVSHsJ1b+Wqm7uKsDHPtpp5BmQzLo8+0KNkeKpRHJIs59Y0il0iCrq
	 dEwXZ8hfPouIy3sUmjzuhaR1LlBNpGjWeUTwSVcr5Nw1WXl2QU33pnqmMStZfzmUrm
	 rj5tg9siqJAhIVWlAqpeZVOUBcu8Mk05Srq1mu4r+8WpvDRch9XjOzJ+GceM5/2+RH
	 td4YUnndtY4ZYj5AL0VXaTko9Nyx1yVkVVsLO46OMXo57qGs2rWTuwL8KMBcrgjrBI
	 hS+euXWtZvXZ/ns2UH4+Vp4O3vlgLoKbA1BTvVB0sgqHcFiDJ2dv+9Aw1GCsDiP5gO
	 u7OcueoOvow9w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2967af48248so2600017fac.2;
        Mon, 02 Dec 2024 12:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfhCb7VjkQ5EyUGB7f1QStaxZnx0kYcJ8c56vcRr5h1eJPgbLsUv0nos7kkFv578RPt1qhiH9/wjA=@vger.kernel.org, AJvYcCXa8ScyXwgXsD4k+aje8zDrErcFlBiHzWPOTXSUGbGHeowLmup5lfm4OZMvxs+Snw/7yq4X1he9g9N7+y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdTgc5jIK4KEMFI3bmyJk4oPEOddlfQDQBeMDoigSHwIZbsoQ
	2HiQv0xsNqy8RPMOKE0AjYLLFrc0h4LtoePRoweD+lQlp0qNxXgVFDfpGHqNlIcWzlO9GeA7RCR
	ipHq9E+20p3D/c/RRa4QyK7/9Igk=
X-Google-Smtp-Source: AGHT+IFgRh61253Oj6tSR3cf+ytz9ae5vuuPL6lnL20jDldovYzN50pkQ1A9DqEGHJ9D+fk+pbtH1TODhdDW9iX0f6E=
X-Received: by 2002:a05:6871:4098:b0:288:49a5:7562 with SMTP id
 586e51a60fabf-29dc4387a54mr14650275fac.41.1733170283894; Mon, 02 Dec 2024
 12:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com> <20241114220921.2529905-3-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-3-saravanak@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Dec 2024 21:11:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
Message-ID: <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay.

On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> Locking is not needed to do get_device(dev->parent). We either get a NULL
> (if the parent was cleared) or the actual parent. Also, when a device is
> deleted (device_del()) and removed from the dpm_list, its completion
> variable is also complete_all()-ed. So, we don't have to worry about
> waiting indefinitely on a deleted parent device.

The device_pm_initialized(dev) check before get_device(dev->parent)
doesn't make sense without the locking and that's the whole point of
it.

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/power/main.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 86e51b9fefab..9b9b6088e56a 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct device *dev=
, bool async)
>          * counting the parent once more unless the device has been delet=
ed
>          * already (in which case return right away).
>          */
> -       mutex_lock(&dpm_list_mtx);
> -
> -       if (!device_pm_initialized(dev)) {
> -               mutex_unlock(&dpm_list_mtx);
> -               return false;
> -       }
> -
>         parent =3D get_device(dev->parent);
> -
> -       mutex_unlock(&dpm_list_mtx);
> -
> -       dpm_wait(parent, async);
> +       if (device_pm_initialized(dev))
> +               dpm_wait(parent, async);

This is racy, so what's the point?

You can just do

parent =3D get_device(dev->parent);
dpm_wait(parent, async);

and please update the comment above this.

>         put_device(parent);
>
>         dpm_wait_for_suppliers(dev, async);
> --

