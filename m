Return-Path: <linux-pm+bounces-36497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7BBF2DA7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C1918C1583
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039E2C0298;
	Mon, 20 Oct 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUnKrPyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014E2BF007
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983395; cv=none; b=DSn9Jd7/nNn336AbmVN5SWfeNQi2BVvCk9ka/2cH7acUwPTNH+xL3q2Qf/WkhZOtT9mQAJlK47H5/47j5rX6vnNROe/g046t4FP4jDOgSao0FUiZBAnf82AnQxufvTz9NyevZ0w2I9jt1TDEUw2HK3q2baSvjyuVh6B+9FT3MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983395; c=relaxed/simple;
	bh=RVmqPR6ukgm2FLF9QymIUTLT8G/Z2zpHTSggwA93snk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQojL2KSWqHnbu9c1kJ+quo4+8XXkUZIds1uM98UqDdHgysRezPy/XCGt1IoFaaJ4f55kYp0wK6wGYFayPtFwVKCr6qZk1Vr6h7/d/R3PF2ZE5Fi4DS3rYm0RLRZNCJVMyQJqK8MjEnnRStkDcVEbT6xGWcBQWCcHycvQSkym8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUnKrPyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F67FC4AF09
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983394;
	bh=RVmqPR6ukgm2FLF9QymIUTLT8G/Z2zpHTSggwA93snk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rUnKrPyOmXyiR8RQF8ZbznIygSV16nYXvU0YP8RKSBqZUdCG3RFaMDPEsJ5RmYgGs
	 V28UuQWUhMkOQkC1wVynVW/EKNOs8uGakb5mMNLzdPv6U3sjqbrBuMqx/Ewp7Ey3lv
	 N6eIqwfGjnt3VFk5xmbAMzN/tc8eC2eEXobsZGwm9ne7Mdkyr0/AGFv0aDdnbI+k2p
	 M9/2+MEXyRnsqAE0gHrBST64NCauOR7sTKLc4xVjw1b8FrN9LyvvZKGzVuYdl5aXrH
	 axC7OiDtS6AvT48o6c1Vfx5v+wSfaNEMs5L7h8Q4eNpo19rTxTfWQepk+hH3DOCCV0
	 iFXQ872Zkm6ww==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c9c379af8aso1262342fac.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 11:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi0mptrPy4ARogVvF2ofXcqfybo3dUWPgdViqlVpg5buksz/AeNbtS9mrXlxjOSXqAw2iwD47Azw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xLuwWeixFxH0SW3/w9VoZV1ttPULOJoVKvTVTfrngPp8DMvI
	mOM089XZzma8/i6zJlnp75Wi/ELUgAX8G22lBSdQvDC+9FdHw290/NyBr4WBGwV/aw2lkSlvVdH
	7YYLE4OxJlJ/A98Xj72AnkmHbi+0B7pY=
X-Google-Smtp-Source: AGHT+IEXobZZ8HzfzyL8YaqoDlTIFejtwktIZGhI0bCDp0Y6As4SDrRClP9lPbEVcszn8PrdDUSEiTN4imTr+wtQI7s=
X-Received: by 2002:a05:6870:3481:b0:331:3aa:77c6 with SMTP id
 586e51a60fabf-3c968801fc5mr6592784fac.4.1760983393381; Mon, 20 Oct 2025
 11:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 20:03:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYUeaoTRr3nowwL-pzXCD1UVoXrhO-hjsuzCif+-JxaA@mail.gmail.com>
X-Gm-Features: AS18NWD3hzkMTsbYT4PVVsV2MyqnKyUKTkufuQic82cjp8AMw6ARhHZnBBXjnqA
Message-ID: <CAJZ5v0iYUeaoTRr3nowwL-pzXCD1UVoXrhO-hjsuzCif+-JxaA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Delete timer before removing wakeup source from list
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:39=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Move timer_delete_sync() before list_del_rcu() in wakeup_source_remove()
> to improve the cleanup ordering and code clarity. This change ensures
> that the timer is stopped before removing the wakeup source from the
> events list, providing a more logical cleanup sequence.
>
> While the current ordering is functionally correct, stopping the timer
> first makes the cleanup flow more intuitive and follows the general
> pattern of disabling active components before removing data structures.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Reframed as cleanup/improvement rather than fix
>
>  drivers/base/power/wakeup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..ae6ec9f04b61 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -189,12 +189,11 @@ static void wakeup_source_remove(struct wakeup_sour=
ce *ws)
>         if (WARN_ON(!ws))
>                 return;
>
> +       timer_delete_sync(&ws->timer);

Doesn't this need to be timer_shutdown_sync()?

The current code guarantees that the timer will not be re-armed after
deletion, but the new code doesn't guarantee that AFAICS.

>         raw_spin_lock_irqsave(&events_lock, flags);
>         list_del_rcu(&ws->entry);
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>         synchronize_srcu(&wakeup_srcu);
> -
> -       timer_delete_sync(&ws->timer);
>         /*
>          * Clear timer.function to make wakeup_source_not_registered() tr=
eat
>          * this wakeup source as not registered.
> --
> 2.34.1
>

