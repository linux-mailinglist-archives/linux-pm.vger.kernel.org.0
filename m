Return-Path: <linux-pm+bounces-35183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA66B92787
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC031904DB7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A008634F;
	Mon, 22 Sep 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkaEIR8H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54531158E
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563232; cv=none; b=Y94vhT4WoVLhkPHL+DAlTFcmyj+6ib+6dKKwNdnm8BWJJTlOvW+VSZg1voSIUTVvW2bmaaUR0FZp/E4+JxbhTBWeFTQucUuTxZM6GuOdCQU0atVxDJJ/ma4lXQ+z75K56+YrrJwTCQIv/ZdkeHACKTT2LNo5s9HO9RksiOeDNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563232; c=relaxed/simple;
	bh=agdlQ/ANKPbpn5Vd/EimUh+VV7JK+okXeFSmo/mRudU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF9E1W1riFvMVAWHOEy/PWg7Ddz+MYXAtcCPItJ4WpE08LPp2EhzlOpKjpVV9oYAHEfD0d3xIcuoQB2GIuWMU68zU6GxpwBfWnRys2rskodEXF5QeR18ducMaIXd2d42SQP0u5GsIrNCrrzkJL+THQWy1Q3UY9DrBsUKQVs8uQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkaEIR8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05ECC116C6
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758563231;
	bh=agdlQ/ANKPbpn5Vd/EimUh+VV7JK+okXeFSmo/mRudU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkaEIR8Ho7WPL0trl/yW7kOnpLoE9+Jaw9E8zjVujZ5+XM00IhHQjE3TO5ViOy3o/
	 86RbZXObAukD1NJpLmy1pZCdcq7M4s25GiHoi5NdJKLrniwiMkas+DjVKhKLCY+ULu
	 AqogfKqQ1s5z5XFec3yZJvSn+XcRAaVbDD086/DvlXLscxn6jog1UF6sMWKDUMxChB
	 8DmXgwwPkSRAMU0st2UooGz2gyzBIQ6WET3Qh47VRl6SaOMaUwfBtgYlyBKizYKFpg
	 VmS8EWMWRD0CZ/Q5MYX81KM32vTOLl+t7gT6H8cksNCsSvy7JAIXuceIhcQoC5TWL6
	 gS3e4Kh3oS0MQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6219b29ed57so2099514eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 10:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcC5drpThDDxObblKPjiQaFlYc2aGJk/E7sXjeLzafR1EAB5ILNVPs6pHxfj0COfpv9xVTzOfI8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJf5dFD8DlpF9cwWZj60BRkliCE9gXrat/ECDyEnnYXnZtoyLA
	RXTUw8g7gngYgmCYgc+qTs22NI0Ku040D3bkNHMDoKM8e1OZNoxA0SSqKJCEANz13nZLwZg6sDF
	TuIYRTajxi30ZA4Gr2mfQnt61UTc5x4c=
X-Google-Smtp-Source: AGHT+IECebZntwOBxZ/uiQAtycqnxbTiqE2gUnkLzMV6I29wPiq364Lz87hgjaxasHfuIftfPXAw53HAB29i82mI4Sc=
X-Received: by 2002:a05:6820:545:b0:632:da4c:19cf with SMTP id
 006d021491bc7-632da4c1b79mr84148eaf.0.1758563231108; Mon, 22 Sep 2025
 10:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:46:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
X-Gm-Features: AS18NWDS8aq8x-Yj4mcbDtMVOdzpy_bbMx-vXGiZ8ie-gkxz8e9HeYOAa3m-Iu4
Message-ID: <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Delete timer before removing wakeup source from list
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 6:27=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Move timer_delete_sync() before list_del_rcu() in wakeup_source_remove()
> to ensure proper cleanup ordering. This prevents the timer callback from
> executing after the wakeup source has been removed from the events list.
>
> The previous order could allow the timer callback to access the wakeup
> source entry after removal but before timer deletion, potentially causing
> use-after-free issues or list corruption.

How so?  You need to specify the scenario in which that can happen.

> Deleting the timer first ensures that no callbacks can execute during
> the wakeup source removal process, providing safer cleanup semantics.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
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

