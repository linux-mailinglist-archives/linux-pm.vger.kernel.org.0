Return-Path: <linux-pm+bounces-32775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8BB2EE7D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5522A05D23
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BF2472BD;
	Thu, 21 Aug 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWichBKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97636CE1E
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758744; cv=none; b=NTXhGuA6Bsn4MAlnW1RU0LdUJ6WdvIS7ZUaLr72kT5i/KFKcRtvZAhlc3sSC4aMmh0/9mbzMwSzUnIykI0huVw9L5x5BO3kHFb/0GodIFc1MumyytpBSrvUImwNBA0D7xcgdQ81u4d/+cikIRmDAbwfdfT8o1O5IAk3vciIo8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758744; c=relaxed/simple;
	bh=RYDU1+gPbuO4Va/MXhU5wCxRuUZkK4Sc7nFG3u5YgTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFzVlxUpuQ+2xD+KdON5RwYZaOmR1rU2gxOFbR4aHo9hvd/xdL/XCRjAUtd8YOblGbIfPqxaGDjj+GDooaE/KmeYIl9LsCOcxvkh+TQVXGtKfNSzRAClpuIIJoK77lZ8dwePK+G3eFlxCpTXbtON5aOcAmIcyl3lPHyJ/4T5zE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWichBKC; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018fd51a0so123853241.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755758741; x=1756363541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Smd8gSEHvUxLDgOcYmY68eshiwJkxa2AO+F+xW3LA=;
        b=BWichBKChNqPvgcY92Xg1phq0NwPhnyF7i3FzwVF0MGW0PXHp8gQcxvB936yy6s9ui
         7s2dKx6dkBEwNXgeeOPw3pA/fvWvDoc8Pz7+jXcOQZnaKUgslsl639BecOfRrHRGl3YU
         Ul01B5I3MhQTdJB/5KhhvuURxd0okOtreE+F6CKrR85lV1SfIbX63Kz8aQEd03XHm3L1
         qd03y4Ic37QE/Afm5PXAavCTHpOGuLCMRLze+67sUMyCQEIOZ/WM0TLkK46Wc3dWb4zh
         efyD6mWXQUQScUKqC5o4f/TsH/vJcAar/zCVtkOKIKhH59XoNgTqRaVjEfNNw6xsIvSU
         MhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758741; x=1756363541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7Smd8gSEHvUxLDgOcYmY68eshiwJkxa2AO+F+xW3LA=;
        b=FWK3+sn32KeYH9fua3swjGbKfqiKZIYUIHTnLuXAtl2KYM5p268H2KiCMOj+BdB3uc
         IhS5lAdOMRqPYb1LYz8wsrTrlaUEsC3nLynhHVIaxiuFqOlj0f82KEaqoecbJomEphpB
         vn7K7CYAGQtzwEO6IIwwThjeUMhHJdXAAyJxFu6olJ43r4qLH4PdWR4XtaRwOg37GrzK
         ibS0yxu4S2ZlJDyiBnGbHg2nX1/99lT6GWxz7AYelRZZH+8xHCk7hEZk5GNjCossD1WK
         Zj4bKONQgLMreeWsIVfBwkCZjix2SEzirkNxpq4WeABuv3Ej0zlrnQ3L1EK7G1o6eWFw
         0eTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xk3xQZpqOBxf85ZB4xRJquGzk6c15kbH3qZvA8mZPfsmqhBS2P3eFBMauHUfPGSXlAcSeVoNnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDn18+0eTF6+al2uqTaLXZz7iqs2lD9C3bXDjeev4zldgJrvF
	YQY+r8CtpZtr52c8Kcna8RwUEEhy8gywIFVwH3F7NZ2tZQI8PrgxoGifUUIWdB4a1DKtOHawmqM
	Hw/HWJ86uB/Om4182IBioNJkoa+2oG7BH6awaFISh
X-Gm-Gg: ASbGncvpSFshTwV7lJgASawykC9LBvc/7QKWwS8KbollL+VAK/9vTVslWV7JM9MMA22
	K3B6WejO+ADPA6SahBRrolsgakYEdvRaRmc626dXnclwDjNX8DlRQ9bBoJIOY2XLeIwVL0yrHDs
	YcYjtAtiwG9ortr2HhCaWI8oxWnAN710wNWGyVWzaEBoyAQ8ffzfoebWqGK8U1kvMKolt+fdKUF
	g1FQh+ZTLHC
X-Google-Smtp-Source: AGHT+IGa1X3jkTBzp4++TY3s5fwvJa235FzeZy18kCkNQD6aqFLh83CJJj0vSfQraUgBiNuA2fsRjmWJQ5jEJ0z+zcs=
X-Received: by 2002:a05:6102:6894:b0:519:534a:6c21 with SMTP id
 ada2fe7eead31-51be13bc648mr306063137.31.1755758740796; Wed, 20 Aug 2025
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-4-wusamuel@google.com>
In-Reply-To: <20250821004237.2712312-4-wusamuel@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 20 Aug 2025 23:45:03 -0700
X-Gm-Features: Ac12FXzDTIflvmHbWTz4s_kpP9_TjDsECLoSs_L-xRlMthFUHwBgXLYgoXIErWY
Message-ID: <CAGETcx-7qkHPQdUXf_SQMzZbTdcxF3oMk4nqfRnb6=wf0QQzcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PM: Support abort during fs_sync of back-to-back suspends
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:43=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> There is extra care needed to account for back-to-back suspends while
> still maintaining functionality to immediately abort during the
> filesystem sync stage.
>
> This patch handles this by serializing the filesystem sync sequence with
> an invariant; a subsequent suspend's filesystem sync operation will only
> start when the previous suspend's filesystem sync has finished. While
> waiting for the previous suspend's filesystem sync to finish, the
> subsequent suspend will still abort early if a wakeup event is
> triggered, solving the original issue of filesystem sync blocking abort.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>

I think you meant to add my Reviewed-by: to all 3 patches.

Rafael,

Feel free to add it when you pick up these patches.

-Saravana
> ---
>  kernel/power/suspend.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index edacd2a4143b..514c590ec383 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -75,6 +75,8 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>
> +static bool suspend_fs_sync_queued;
> +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
>  static DECLARE_COMPLETION(suspend_fs_sync_complete);
>
>  /**
> @@ -85,7 +87,9 @@ static DECLARE_COMPLETION(suspend_fs_sync_complete);
>   */
>  void suspend_abort_fs_sync(void)
>  {
> +       spin_lock(&suspend_fs_sync_lock);
>         complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
>  }
>
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> @@ -420,7 +424,11 @@ void __weak arch_suspend_enable_irqs(void)
>  static void sync_filesystems_fn(struct work_struct *work)
>  {
>         ksys_sync_helper();
> +
> +       spin_lock(&suspend_fs_sync_lock);
> +       suspend_fs_sync_queued =3D false;
>         complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
>  }
>  static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
>
> @@ -432,8 +440,26 @@ static DECLARE_WORK(sync_filesystems, sync_filesyste=
ms_fn);
>   */
>  static int suspend_fs_sync_with_abort(void)
>  {
> +       bool need_suspend_fs_sync_requeue;
> +
> +Start_fs_sync:
> +       spin_lock(&suspend_fs_sync_lock);
>         reinit_completion(&suspend_fs_sync_complete);
> -       schedule_work(&sync_filesystems);
> +       /*
> +        * Handle the case where a suspend immediately follows a previous
> +        * suspend that was aborted during fs_sync. In this case, wait fo=
r the
> +        * previous filesystem sync to finish. Then do another filesystem=
 sync
> +        * so any subsequent filesystem changes are synced before suspend=
ing.
> +        */
> +       if (suspend_fs_sync_queued) {
> +               need_suspend_fs_sync_requeue =3D true;
> +       } else {
> +               need_suspend_fs_sync_requeue =3D false;
> +               suspend_fs_sync_queued =3D true;
> +               schedule_work(&sync_filesystems);
> +       }
> +       spin_unlock(&suspend_fs_sync_lock);
> +
>         /*
>          * Completion is triggered by fs_sync finishing or a suspend abor=
t
>          * signal, whichever comes first
> @@ -441,6 +467,8 @@ static int suspend_fs_sync_with_abort(void)
>         wait_for_completion(&suspend_fs_sync_complete);
>         if (pm_wakeup_pending())
>                 return -EBUSY;
> +       if (need_suspend_fs_sync_requeue)
> +               goto Start_fs_sync;
>
>         return 0;
>  }
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

