Return-Path: <linux-pm+bounces-30045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C141BAF766E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458111BC32BC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B62E7F39;
	Thu,  3 Jul 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJqeh6zS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BE2E7F28;
	Thu,  3 Jul 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551213; cv=none; b=AhlVFY/z01afS1jQfyTGezw+slFJRju6e4/B9PJQoaPrDeCDcE+ayzPez6vVtxqEJiExniikq3MGHE6dZ0y+BckGJAAlnTlpvefxmToXQb3KlY6N139nGo574kzWs9zvY0aqqQiF1/nqVVAJaYMfidPKrd7XQIltHnSzMxxw5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551213; c=relaxed/simple;
	bh=bS8ewtSLSyODzJSFSvjxtjK2e7VlFfrt/F7Wayo4+Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+84A6ZZAUIEQavhBF/lwDkMy97TSTHAQz2NVDruOiOOlZn8MQLSg42goWOmYWm7NZMt2SmPDQsPd5UMKb77677rmSn4hhYWEBpEBZQGR5N9bcDRASeH94F0KSH4vb+KM1HLLHTFViY6YyBlFPJAvU2EWbzdr2I8XiKkZm3e/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJqeh6zS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC6EC4CEE3;
	Thu,  3 Jul 2025 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751551212;
	bh=bS8ewtSLSyODzJSFSvjxtjK2e7VlFfrt/F7Wayo4+Wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eJqeh6zSkg9WFRZTeXgRmRYQx9rjA8JoMnuq8pV/Q60PMjseLIniIlXRNG3OKzIDW
	 3g0qwEOI6tMrCNOdF+PyzMVOEBs+7w/QpybibLsVqVc49lAaaM95Rf0NRa3uBmEdsB
	 6WQ9lSaBxyY8O0vq5yqYa7vFQiKX3WRKAPsr2c2322cVZEygOwKHwfEbRasXiQqsrT
	 L1QsHSZOmOsX3UUC6behsQ7pbxMi+hHZ/Md3m9uXvt1/AaTx9snzg8+YU0ZJdcgERh
	 SSY462IAwpK4TvxHo1JPUGOOyNY8zJ51SuZtFXAEwX0ApwhmT4VOtYfDiSzyLzzLEi
	 yruf2ZMIHj6xw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6119b103132so705727eaf.1;
        Thu, 03 Jul 2025 07:00:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULcoHaK8UkUNgh+IvZ5rXgER2bkgY3zF76xBw3KzrpOSBYVSX7l+OhQ0sFeFnPdvvoehasqP/3H7c=@vger.kernel.org, AJvYcCXStXsZV63SDdjtYIJZH2W6QPBx183pbD4mOO72qS80J5o49AESJQRrJtFY/tm//MPg9XQ82NcWwWhn3Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01jjn8mjtMzuqY3vCCmQAX0/rCiE85Lo3VP/gdDhn/xSCgUKS
	QF72IFMPCdheR/ax+pSJXh/w9/cyR0ZuYCoVc7jcfgb47T63sltjaB9O49I1nimJUMWHs9Tq+ZF
	M+qnR9MVldFs1PAIe5VaXnWUMlwu6LZk=
X-Google-Smtp-Source: AGHT+IEtqzweRxuSZIv1vHCBO2l1eix9Pt0bsXN1JqFbQsdofN6fWnEOoAVOr0sNGnHWKREKgkJf01NZTDJ2RI8Tz94=
X-Received: by 2002:a05:6820:c096:b0:611:5a9e:51c4 with SMTP id
 006d021491bc7-6138332f22amr921860eaf.4.1751551211388; Thu, 03 Jul 2025
 07:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526010854.7834-1-tuhaowen@uniontech.com> <20250603010157.19121-1-tuhaowen@uniontech.com>
In-Reply-To: <20250603010157.19121-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:00:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie4gTuX4DQy874OoMiK7ujXYYvHKSL2QsrP=+c1bNfTA@mail.gmail.com>
X-Gm-Features: Ac12FXzqdxY8uhqMCORQa7HbwE7yhCv5u_s87DSJVt0o0yojaEfnq2cj3c8HaEw
Message-ID: <CAJZ5v0ie4gTuX4DQy874OoMiK7ujXYYvHKSL2QsrP=+c1bNfTA@mail.gmail.com>
Subject: Re: [PATCH v4] PM/console: Fix the black screen issue
To: tuhaowen <tuhaowen@uniontech.com>
Cc: rafael@kernel.org, huangbibo@uniontech.com, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	wangyuli@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:02=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> wr=
ote:
>
> When the computer enters sleep status without a monitor
> connected, the system switches the console to the virtual
> terminal tty63(SUSPEND_CONSOLE).
>
> If a monitor is subsequently connected before waking up,
> the system skips the required VT restoration process
> during wake-up, leaving the console on tty63 instead of
> switching back to tty1.
>
> To fix this issue, a global flag vt_switch_done is introduced
> to record whether the system has successfully switched to
> the suspend console via vt_move_to_console() during suspend.
>
> If the switch was completed, vt_switch_done is set to 1.
> Later during resume, this flag is checked to ensure that
> the original console is restored properly by calling
> vt_move_to_console(orig_fgconsole, 0).
>
> This prevents scenarios where the resume logic skips console
> restoration due to incorrect detection of the console state,
> especially when a monitor is reconnected before waking up.
>
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
> Changes in v4:
> - Moved `vt_switch_done =3D false;` below the `if (orig_fgconsole >=3D 0)=
`
>   block to ensure it is only reset after a console switch has occurred.
> - Link to v3: https://lore.kernel.org/all/20250526010854.7834-1-tuhaowen@=
uniontech.com
> - Link to v2: https://lore.kernel.org/all/20250516084011.29309-1-tuhaowen=
@uniontech.com
> - Link to v1: https://lore.kernel.org/all/20250516034643.22355-1-tuhaowen=
@uniontech.com
> ---
>  kernel/power/console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/console.c b/kernel/power/console.c
> index fcdf0e14a47d..19c48aa5355d 100644
> --- a/kernel/power/console.c
> +++ b/kernel/power/console.c
> @@ -16,6 +16,7 @@
>  #define SUSPEND_CONSOLE        (MAX_NR_CONSOLES-1)
>
>  static int orig_fgconsole, orig_kmsg;
> +static bool vt_switch_done;
>
>  static DEFINE_MUTEX(vt_switch_mutex);
>
> @@ -136,17 +137,21 @@ void pm_prepare_console(void)
>         if (orig_fgconsole < 0)
>                 return;
>
> +       vt_switch_done =3D true;
> +
>         orig_kmsg =3D vt_kmsg_redirect(SUSPEND_CONSOLE);
>         return;
>  }
>
>  void pm_restore_console(void)
>  {
> -       if (!pm_vt_switch())
> +       if (!pm_vt_switch() && !vt_switch_done)
>                 return;
>
>         if (orig_fgconsole >=3D 0) {
>                 vt_move_to_console(orig_fgconsole, 0);
>                 vt_kmsg_redirect(orig_kmsg);
>         }
> +
> +       vt_switch_done =3D false;
>  }
> --

Applied as 6.17 material, thanks!

