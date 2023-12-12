Return-Path: <linux-pm+bounces-1012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3980F5DA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541091C20ACE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062A7F56B;
	Tue, 12 Dec 2023 18:55:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75CCF;
	Tue, 12 Dec 2023 10:55:52 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5908b15f43eso473991eaf.1;
        Tue, 12 Dec 2023 10:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407352; x=1703012152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxfzJxjkTeD8WaF9ShGyfeclA3COTWzjO/BbalNXvb4=;
        b=ZBvpWD+lemY2LwUgXoujjRiiGQEIYZ7EpxXcUnWc6rWx/hL7H0xVnNjx/bvWq+Tfsa
         T9U9eRvjXKvKasR9Gr4MFHDVsiwmCJ9i2AGkO8y9C/g4ZnUzF3oPjXHUS9FhZTxYZwJc
         OstDPwNd2rYa6Z81mtRkGvrXSlh9p4U4URiWcMIQDxbNrB3kCoZnxscsNTCeLgUlc9Sz
         VPlBezJhIg8gUHY5M2yUCefqW4y1eb+ulIugFGcOmyC/zNmzwlqJb0FsSE30j5k/POMU
         kfkRI5Bk3OW59Bfr9ExWQahA6pfhv79ACZcsnXbO8Gt8ekutikwlwtsJUqyYyJieh8rE
         NPFg==
X-Gm-Message-State: AOJu0YxIKZca3APfmxVuPlsL10XuXaFdtHjWUA7dmFVrdNmMNISxCD0k
	YJg8FmmNPTaYPEOtB96hLILqpwR8QgVWM6ipL9I=
X-Google-Smtp-Source: AGHT+IGxfJfy8DOs+omvTf/HfWKIvqkSL4STYgIRle/KjpC/ZqSTLmrF9pw+hIbuAj+YQKKqeyE0joxkxni883OEL7M=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13750358oob.1.1702407351786; Tue, 12
 Dec 2023 10:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204021155.10434-1-chris.feng@mediatek.com>
In-Reply-To: <20231204021155.10434-1-chris.feng@mediatek.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 19:55:41 +0100
Message-ID: <CAJZ5v0iJcTp+G4zmc6sq1wLf+TFs_uJFcYrimth+a5a9-B=Wmw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] PM: hibernate: Avoid missing wakeup events
 during hibernation
To: Chris Feng <chris.feng@mediatek.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
	hua.yang@mediatek.com, ting.wang@mediatek.com, liang.lu@mediatek.com, 
	chetan.kumar@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:12=E2=80=AFAM Chris Feng <chris.feng@mediatek.com>=
 wrote:
>
> Wakeup events that occur in the hibernation process's
> hibernation_platform_enter() cannot wake up the system. Although the
> current hibernation framework will execute part of the recovery process
> after a wakeup event occurs, it ultimately performs a shutdown operation
> because the system does not check the return value of
> hibernation_platform_enter(). In short, if a wakeup event occurs before
> putting the system into the final low-power state, it will be missed.
>
> To solve this problem, check the return value of
> hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
> the occurrence of a wakeup event), execute the hibernation recovery
> process, discard the previously saved image, and ultimately return to the
> working state.
>
> Signed-off-by: Chris Feng <chris.feng@mediatek.com>
> ---
> [PATCH v2]:
>  - Optimize the "if" condition logic.
>  - Link to v1: https://lore.kernel.org/all/20231024091447.108072-1-chris.=
feng@mediatek.com
> [PATCH v3]:
>  - Use pr_info instead of pr_err.
>  - Fix undeclared function 'swsusp_unmark' build error.
>  - Refine commit and printing message.
>  - Change the subject.
>  - Link to v2: https://lore.kernel.org/all/20231120081516.55172-1-chris.f=
eng@mediatek.com
> ---
>  kernel/power/hibernate.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 8d35b9f9aaa3..fb3b63e178b0 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -642,9 +642,9 @@ int hibernation_platform_enter(void)
>   */
>  static void power_down(void)
>  {
> -#ifdef CONFIG_SUSPEND
>         int error;
>
> +#ifdef CONFIG_SUSPEND
>         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
>                 error =3D suspend_devices_and_enter(mem_sleep_current);
>                 if (error) {
> @@ -667,7 +667,15 @@ static void power_down(void)
>                 kernel_restart(NULL);
>                 break;
>         case HIBERNATION_PLATFORM:
> -               hibernation_platform_enter();
> +               error =3D hibernation_platform_enter();
> +               if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
> +#ifdef CONFIG_SUSPEND
> +                       swsusp_unmark();
> +#endif

It would be somewhat cleaner to define an empty stub of
swsusp_unmark() for the CONFIG_SUSPEND undefined case in the header
file.

> +                       events_check_enabled =3D false;
> +                       pr_info("Hibernation process aborted due to detec=
ted wakeup event.\n");
> +                       return;
> +               }
>                 fallthrough;
>         case HIBERNATION_SHUTDOWN:
>                 if (kernel_can_power_off())
> --

