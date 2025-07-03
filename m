Return-Path: <linux-pm+bounces-30052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D2AF77AF
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB17188B678
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BA92EBBB7;
	Thu,  3 Jul 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ccq7GgnF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50F17FAC2;
	Thu,  3 Jul 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553368; cv=none; b=EZ0WtOLFIU1KTuN82Mxqgbf3yMMuKL5zeIwEaS+nri1e8FYShtLcINI+zRj0nQ8T2Nx05xZVsZ5D6d5cZH7rogHFJTUXi8p7olmbapXqecGrpfcwdwsd0avvmvsVj2Jf5xCDlQbdNSEcMMleSM+q0rd5hvqYU1vVhv1snsnB4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553368; c=relaxed/simple;
	bh=pvG7xe6BGbrfAKTfLgoDx+709pfuEK1E7qCKVSKlUn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRVDxLivlTU5ou3HA1IeW6xdg42dGg+uxhqWsXrzqwol1d7I/O1xBCUuEFzn5U0Z8yfWcPXWHsyu7khqtFw6XK+eCKZ03CWi15s3AQqY2FeDUhLFtU4sEiyw+hWO1f/iYgyHfSy3dZGQde7MpX0Ck00+MAmwsAc1XpUbdWfrznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ccq7GgnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5564C4AF09;
	Thu,  3 Jul 2025 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553367;
	bh=pvG7xe6BGbrfAKTfLgoDx+709pfuEK1E7qCKVSKlUn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ccq7GgnF0NuNYeTP/kVe4NStb8lu5PFyyKieEqXXKWkXfKqcQwBWG58NtsVofqMfv
	 zLjYaWXNfLN5XWLHffYl8NBoVmSRIIUHzRFN1EUqEBlJz8jtBvmVC+jn9FUSklDh6g
	 ylcZKUBEuSQ73LNXPxJJI7eiLmUA7e1voaFv9xTBGK3W7muS7H+trpX4XoM+oCxT46
	 K6GKyEQYa+nXfhsvSl2eIym2Kxp4YvBwAEoyJN5FL5xF49BfSP0h7O0K0TX+br96Hx
	 a9DjCxUilIvhY79jm0ayAep+zIN87Vten0v7Oa8KM6v7X4oof0tVeBAMJjoEy4+sNi
	 X1eE8iHclIDnQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60d63174f05so7286eaf.0;
        Thu, 03 Jul 2025 07:36:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWw6Zh2spd1G0/LvlnbGOnZe20gbu4JjqNiTX8wnJXif4ODgs41rQt4YbABRZ9KwTQG7W3bdOEkQtWSiyk=@vger.kernel.org, AJvYcCXweO/+Ho+Op2GyWc/rySQwbbJSUQfVBcEo484DxpB3VUf8KBEfFQLx1rbqCQbVoruRbUZEAmO9ZBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYt7Asya+K2vFDpqzSg5hGu9oapu2ZIwcgCQx2E0/3psXMyA1O
	6t3h+XEfpVIGUupImCqkBDwmjMyu7wE2Te1ZgfR6a/GKOQv/l4sDw1c1mbqvdgL1NQ2im1+KGjj
	9WMVEgHi/QTrQUy+b/+36CZOdpqEbmOg=
X-Google-Smtp-Source: AGHT+IEkhvn+8jNU8o3fMR9sAH17KtdXghaVznuEOh1N6nMSzEeABnDR+qkAPL7IcARL4Hda9+wwliIPwgpysrkaXUI=
X-Received: by 2002:a05:6820:2913:b0:613:872a:7b0b with SMTP id
 006d021491bc7-613872a7e73mr1287331eaf.1.1751553366919; Thu, 03 Jul 2025
 07:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617084650.341262-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250617084650.341262-1-quic_zhonhan@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:35:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbuQ8sRctAB7eC3JTr5TrDBnu5yjjG82HrSiJ23_99bQ@mail.gmail.com>
X-Gm-Features: Ac12FXwX-Q0wtKZ01ONvEW8u-19Nxyc4fwRb1remFu35TrXz9gluPQ6gcBRSo-w
Message-ID: <CAJZ5v0hbuQ8sRctAB7eC3JTr5TrDBnu5yjjG82HrSiJ23_99bQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Drop superfluous might_sleep() calls
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 10:47=E2=80=AFAM Zhongqiu Han <quic_zhonhan@quicinc=
.com> wrote:
>
> Drop superfluous might_sleep() calls from dpm_resume(), dpm_complete(),
> and dpm_prepare(). These functions already invoke primitives that
> implicitly check for sleep in atomic context:
>
> - dpm_resume() and dpm_complete() invoke mutex_lock(), which internally
>   triggers might_sleep()
> - dpm_prepare() calls wait_for_device_probe(), which internally uses
>   flush_work(), and thus might_sleep()
>
> These annotations are unnecessary and can be dropped to reduce clutter.
>
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  drivers/base/power/main.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index eebe699fdf4f..0f40c00c1401 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1095,7 +1095,6 @@ void dpm_resume(pm_message_t state)
>         ktime_t starttime =3D ktime_get();
>
>         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
> -       might_sleep();
>
>         pm_transition =3D state;
>         async_error =3D 0;
> @@ -1198,7 +1197,6 @@ void dpm_complete(pm_message_t state)
>         struct list_head list;
>
>         trace_suspend_resume(TPS("dpm_complete"), state.event, true);
> -       might_sleep();
>
>         INIT_LIST_HEAD(&list);
>         mutex_lock(&dpm_list_mtx);
> @@ -2109,7 +2107,6 @@ int dpm_prepare(pm_message_t state)
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
> -       might_sleep();
>
>         /*
>          * Give a chance for the known devices to complete their probes, =
before
> --

Applied as 6.17 material, thanks!

