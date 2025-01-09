Return-Path: <linux-pm+bounces-20131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E1A06D41
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 05:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C2188986D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 04:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB621420E;
	Thu,  9 Jan 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MoqT4g5A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BB213E87
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397960; cv=none; b=QW2yWA9NH29TmR2HKQXnudsUqRlunCdkdBRNrInpF/oOlxcHCIbOMyL932DIK10+WR5IArDdX3UgywadNhdsjX5MUE7hCF1EyX7gZxGU+Q47LsLfxlFxOK7NC+v5lk6rNrrMgK7Dydp03sm6Yhld4pB1NHIb9unYcnkTCwvtzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397960; c=relaxed/simple;
	bh=umsYaBkSbdgD8vpLgaZykY/eXe5XqSqpLY23e5NxMO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk8Cil1azEtz/J1hgCq5OpJW1hEK0V8RFbCgrBr9LNDzMnPebBr/rI3Iz5unYm0RBcmQnXAGzqoF+pt+JTiR8+slt18HIv/0yyebSbmBJs0Dqr01EKu7dY4PfUoQVgBouhuCz/tePNEgH22fdrjstBSqLj1xx1Yv3pSQ42SLZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MoqT4g5A; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso120109066b.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 20:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736397957; x=1737002757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJorou/39Oku7ojMsfZLyIHEK8Kb1RaZANvXrO7EPA0=;
        b=MoqT4g5A9ISjuWHreJW+lqRzwFnlgvVfs9PxnBu/SuP9h3dMQyLI80WsmPNaHTEMzZ
         xaPprz0t7MmMxWRuLpSYi6GbFQd8DLu+wQYOf+z0JisqlyEuqEHfWlaXbwzaW8/Y7zOk
         SNy+tS1F6RUK5Qi4qsFy8kQ3vr7rbXmpZicjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736397957; x=1737002757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJorou/39Oku7ojMsfZLyIHEK8Kb1RaZANvXrO7EPA0=;
        b=LmcvsWzA6OKlWj+2SVOqiog3I+rsqMfg6Bmlj3uomnaHYrE59chStjQwwNS0aEzx/q
         pOPsWG4gUZ01aV8NGlkB/k4JugmiR4N0tZ+4xrDnAidMHN1U4WpqRPcIcnrQDWxHXxTM
         YrAUus+5q+qG4AKHBEx1pSXoS0Ok+q1OfU68INpMdNUj1RJkWzjvOgwsGrAHkyOdMNch
         gdnkppIG97C459fg4J0C9t+ynql/fBOxq9LfH4jfhql1Mz9RczzR46fBznr14wAHfXVt
         M0L/rbP4QbWORlnOxowCiB3Gjett7BjsB3nOprtEuqk7lzGYr9dzqsXveD+OplQieEUf
         Vj1w==
X-Forwarded-Encrypted: i=1; AJvYcCWOUsPMUtdEy62/WkPViSN92TCFDUU5wCZhccm+1cx/c/BfUehTD/9wRj5lHfqGBUtBuWgui/LZ4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypg3r7/fjCKyr1CnwGYXlksgsHQRknpzRYbrtKIqJE1FH/Z5d9
	B8XNmFSiQ6yqPSblqXax9tjJ9jMTseDyCQB0VbZdDtK5oUTaCaneL9b6cyV+jNBwj5BTa9GL9GT
	0xA==
X-Gm-Gg: ASbGncvkgkWw56GknudltXZAQVNfEsUaoGtlCpDtrVPSi2IXOrDIz2izmYndGsTY8JU
	+Y1JNeWlkgnkmNYmSpI3lb1qaw3AmsJMEHSTlNvZ3CiE2mATAXdZjKVWRex3PprG0ctnFSajix7
	8KYtH3J9wwgM2zRnbMMWHu3r9qKhW07SKNPUNaMimb3knpc1W1fLhM5E5obLzjVz0AUM8P+2mgQ
	UaRvB4m15h+HS8GNQOqUjcrQ5+KUnVfzLZk/qbYOjToYvRgLe4YVWTT+6Et1PEtzfN93uO/8jnG
	ppn/LipA+9mv6Mye
X-Google-Smtp-Source: AGHT+IGDjNar51uDTU2wSn1vqfib4jwGRD72oMUn2QuQPzriTL22YO8MkoKbIVV4vWP4wdCw6iDI2w==
X-Received: by 2002:a17:907:d1b:b0:aa6:ac9b:681f with SMTP id a640c23a62f3a-ab2abcab4c1mr582604766b.43.1736397956638;
        Wed, 08 Jan 2025 20:45:56 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b29aesm27487466b.156.2025.01.08.20.45.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 20:45:54 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso4879a12.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 20:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnOc80SSc/v38JvwXl4w17CYNjsnB3PjTXkZpVj9/Bdqy29co/LZX4lSuOKw+82tql4w1st08I0g==@vger.kernel.org
X-Received: by 2002:a50:935b:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d98996a28amr31889a12.1.1736397953413; Wed, 08 Jan 2025
 20:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218095613.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
In-Reply-To: <20241218095613.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 9 Jan 2025 13:45:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDmBVC2OcJ6vd-y1wJFq8o3j1ssP9G5hQ1ZeB=mcwETQ@mail.gmail.com>
X-Gm-Features: AbW1kvYEJoF60PY9Te2sygBBNJyAVpcUDmVT8k6OOiuV5yzTsX_di2UHfqSG4tc
Message-ID: <CAAFQd5DDmBVC2OcJ6vd-y1wJFq8o3j1ssP9G5hQ1ZeB=mcwETQ@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Allow configuring the DPM watchdog to warn
 earlier than panic
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Dec 19, 2024 at 2:56=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Allow configuring the DPM watchdog to warn about slow suspend/resume
> functions without causing a system panic(). This allows you to set the
> DPM_WATCHDOG_WARNING_TIMEOUT to something like 5 or 10 seconds to get
> warnings about slow suspend/resume functions that eventually succeed.

Thanks for the patch. I agree that it would be very useful to avoid
completely bringing the user's system down, while still having a
warning that lets them notice that something is not right.

That said, please see my comments below.

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/base/power/main.c | 22 ++++++++++++++++++----
>  kernel/power/Kconfig      |  8 +++++++-
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..239bcf93f821 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -496,6 +496,7 @@ struct dpm_watchdog {
>         struct device           *dev;
>         struct task_struct      *tsk;
>         struct timer_list       timer;
> +       bool                    fatal;
>  };
>
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
> @@ -512,11 +513,23 @@ struct dpm_watchdog {
>  static void dpm_watchdog_handler(struct timer_list *t)
>  {
>         struct dpm_watchdog *wd =3D from_timer(wd, t, timer);
> +       struct timer_list *timer =3D &wd->timer;
> +       unsigned int time_left;
> +
> +       if (wd->fatal) {
> +               dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> +               show_stack(wd->tsk, NULL, KERN_EMERG);
> +               panic("%s %s: unrecoverable failure\n",
> +                       dev_driver_string(wd->dev), dev_name(wd->dev));
> +       }
>
> -       dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> +       time_left =3D CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHDOG_W=
ARNING_TIMEOUT;
> +       dev_emerg(wd->dev, "**** DPM device timeout after %u seconds; %u =
seconds until panic ****\n",
> +                 CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);

Should this be printed using dev_warn() instead, since it's not fatal?

>         show_stack(wd->tsk, NULL, KERN_EMERG);
> -       panic("%s %s: unrecoverable failure\n",
> -               dev_driver_string(wd->dev), dev_name(wd->dev));
> +
> +       wd->fatal =3D true;
> +       mod_timer(timer, jiffies + HZ * time_left);
>  }
>
>  /**
> @@ -530,10 +543,11 @@ static void dpm_watchdog_set(struct dpm_watchdog *w=
d, struct device *dev)
>
>         wd->dev =3D dev;
>         wd->tsk =3D current;
> +       wd->fatal =3D CONFIG_DPM_WATCHDOG_TIMEOUT =3D=3D CONFIG_DPM_WATCH=
DOG_WARNING_TIMEOUT;
>
>         timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
>         /* use same timeout value for both suspend and resume */
> -       timer->expires =3D jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
> +       timer->expires =3D jiffies + HZ * CONFIG_DPM_WATCHDOG_WARNING_TIM=
EOUT;
>         add_timer(timer);
>  }
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index afce8130d8b9..3387b94e76c1 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -257,11 +257,17 @@ config DPM_WATCHDOG
>           boot session.
>
>  config DPM_WATCHDOG_TIMEOUT
> -       int "Watchdog timeout in seconds"
> +       int "Watchdog timeout to panic in seconds"
>         range 1 120
>         default 120
>         depends on DPM_WATCHDOG
>
> +config DPM_WATCHDOG_WARNING_TIMEOUT
> +       int "Watchdog timeout to warn in seconds"
> +       range 1 DPM_WATCHDOG_TIMEOUT
> +       default DPM_WATCHDOG_TIMEOUT
> +       depends on DPM_WATCHDOG
> +

If I'm reading the code correctly, if we set
DPM_WATCHDOG_WARNING_TIMEOUT to the same value as
DPM_WATCHDOG_TIMEOUT, then we get the current behavior when the
timeout is fatal. Would it make sense to document this in the help
text of the new symbol?

Best regards,
Tomasz

