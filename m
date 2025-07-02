Return-Path: <linux-pm+bounces-29991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B876BAF6216
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050031C4730C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF139224AF3;
	Wed,  2 Jul 2025 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVNjWHFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628A1BC099;
	Wed,  2 Jul 2025 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482719; cv=none; b=pvdpTl1thn7Mpp95/orWCtuMpviYFh5mwvbr5njSle1X7uZHYtN7LuJeBuaobghe/vPzWt3+MzS2CU+PUTxRYbW+WTt0xqakvt6vq3q3wvbstvQEx6j7q4HHcN2Hct1a3neXAj8fYIed4NhpbS/cENN4ElVX21/TBUO1kgdOhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482719; c=relaxed/simple;
	bh=1lfC3jqjtZT+pAAMGry3bTviwExKruM5W6xNQQvy1iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToOjybwcRydUn6iIWtzcthDe4WhUT+P5s6Vs8ZbpyzaS89oYMHaPATxBb/DlvOr2EfFMwVhG4ikxEJy7VElEBgfwlAs4ToCUnTPE7vdzkmQY2GXl4BwB2jz3BwqPbF6jOS1yRH4EDG4Jd8rorqW1q5FgECCfgf3KYkOIJJaNzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVNjWHFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B7C4CEEF;
	Wed,  2 Jul 2025 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482719;
	bh=1lfC3jqjtZT+pAAMGry3bTviwExKruM5W6xNQQvy1iY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PVNjWHFL2udevjAkLh6mRENy6xvvB2kNUkw2WzXDxhE8IgtoDuiKh3xRpKtbLtrMb
	 cnmbBP0g5wKmGzuzJ77i9ghw/RTmrdYiuKb8kAwScOElaUcRSZInLsMGsVdDAylhRH
	 txYcCkjxKYZonCMELQUBTpkjuYX2bb8TJXDWBzBBIylOoahbJWgxfVo46ETS/XId3T
	 1KGLsgBCz7B4VmRtTrp/Te4A9QadTp6Th6dCWCFnv4ZlxU1CSNha/S0U+wwn5e1ntz
	 NCWd8DhTXz8YtTBHQzlc9j1+lup32vf9/SFOjNouxhMRymQjgf0niFzpXLRFShJwWH
	 N2R72G1eWnkkw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6119b103132so158856eaf.1;
        Wed, 02 Jul 2025 11:58:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBFPQNBx35LrANBlrV26Qwhz8gXuVcg9KQexN9Xm5Vm5sR9i+be0gvTFRqG7cAqspYWCAmeO+Acqs=@vger.kernel.org, AJvYcCWaOtFUI6rEFVehpJlcwLcVYfGlmxcMOs09Lh7WXY8KJHuFqCSTAJYcjHOke8lomWy7zM8fHFFXmT0amVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbFh62aErWQMqlHZX3IGb2LIT/27DJvYtDAgWkApPbMeg945X
	mJUYEbdEc2oQELwz3nKrk5h1zBaMKJ4Pk1u7AmJaM3vYxxkKrUBAKXiehCATdtckEDihwP4YtvH
	Rexa99Rs7Q8uvWSNQgZ+XmFutdnM6+xw=
X-Google-Smtp-Source: AGHT+IHQNHqxwInSD7PPH2CYi3fe+J9Bvn8etDrZyNmUWRxpaJfTB3pUUl9HhsHetYiKHd2Pm3aIFXcbdvJ35AgLyI4=
X-Received: by 2002:a4a:ec4c:0:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-6137e862d21mr552063eaf.1.1751482718578; Wed, 02 Jul 2025
 11:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn> <20250619035355.33402-4-zhangzihuan@kylinos.cn>
In-Reply-To: <20250619035355.33402-4-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:58:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEzTfZZgrgyo4NNnXj+eFrAnJgmP9Ls7kB3GM3c1V2Mw@mail.gmail.com>
X-Gm-Features: Ac12FXz0gPs7GJ_osLNPEEJhZ7Xp1FmzpTdHyOKCcA_fo7K9yyOAjemecCPsGrU
Message-ID: <CAJZ5v0hEzTfZZgrgyo4NNnXj+eFrAnJgmP9Ls7kB3GM3c1V2Mw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: suspend: Assign pm_suspend_target_state
 earlier for valid debug logs
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> pm_suspend_target_state is used in debug logs inside enter_state(), but
> it is only assigned inside suspend_devices_and_enter(), which is too late=
.
>
> This causes early pm_pr_dbg() output to either show incorrect state or
> nothing at all, making suspend debugging harder.
>
> Assign pm_suspend_target_state at the beginning of enter_state() to ensur=
e
> early log output is meaningful.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/suspend.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 76b141b9aac0..16172ca22f21 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -584,6 +584,8 @@ static int enter_state(suspend_state_t state)
>         if (!mutex_trylock(&system_transition_mutex))
>                 return -EBUSY;
>
> +       pm_suspend_target_state =3D state;
> +
>         if (state =3D=3D PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> @@ -616,6 +618,7 @@ static int enter_state(suspend_state_t state)
>         suspend_finish();
>   Unlock:
>         filesystems_thaw();
> +       pm_suspend_target_state =3D PM_SUSPEND_ON;
>         mutex_unlock(&system_transition_mutex);
>         return error;
>  }
> --

Good catch, but you should remove the existing assignments at the same time=
.

