Return-Path: <linux-pm+bounces-3880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45F853272
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F89F1C224BB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74AD56B6A;
	Tue, 13 Feb 2024 13:59:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E056B65;
	Tue, 13 Feb 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832764; cv=none; b=swszHgJRoVdPONRRTJjQNYSgXaA24uu4vckKm4w4QMgzOstW6VE2a2D21dMWNvyLYMmy0Uxz73MVGy253Cfd6TWizxxankmDFQNDCPvLDVPdUgcak2nUn9GwdNY9MU/FgjHbpvVW5TKqrInt7UOvNUmPy2slcI9rLlKJc5398EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832764; c=relaxed/simple;
	bh=AFH5mXgYpgm7k1VaeAmR7XOmcIr8m+gl7ANkYB0CJYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rnl9qpyMQ2TwTQbEO41h0UW4cbChSdQcuL39NjhFmJLHRx/Z58S6PjdjzN0QluQx4ZaqXVmb8rYaFlypf+5UTic8kLgeX/8h/Ce3cjystQr2b0TLyWLfyX7z3UE6+Rk22JVwgucbZl0mr8UxUSYWB1kUbG29PX7qdGTACQvW/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59d29103089so119841eaf.0;
        Tue, 13 Feb 2024 05:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832762; x=1708437562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtLjlT9JbsjIzXWWX8LrQHq6rvO1Du63NHf/SHICIds=;
        b=AjjcmVRuC33QCJZatlFaIxKuh6pq32iSMZQoHe0uRkWW/PyOIjGYWp0hQn/+U5xEAz
         O5J5teSY+JsZybAale+CdUWjsNYhIVKAGmW6JxFim9n5tfiroqgIkDqFHifT2DYgkloU
         t8eS2kXurz/D0pNsvTrZ3XQTD4qbiZsvt/VX8yAdzkff/KBT2FtpPi6/OkTkTy5D5ei8
         NX7kAI5mLMhKf0rblIcQnNaf9TM9kUnUEGQUg92h/5do8l90Iq61KSAgH/Hf5jgXSdUH
         KNjNBsAS3Ca8FzPIAD1sjhyPQ5GwBwWHhniSsCwXHQvgXBUPqhmu+Ilcyu1r5eZwtm16
         bqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUy2WGG1FSnNmqbT7nyfHj+Zrc32w3ryRhrYLJVL/UyFWZSjD5HvLP1bJ9kwhRCAfIsVOO/pV7D/z0js09qqFiXNBfG2UZ
X-Gm-Message-State: AOJu0YyR596b1es09iY8Q1lngExnCYDwkeKm73NZ0tcK/bN5oFA2gQJP
	MoKQTkC2RKc/ZhQQSByXBgLVe9U3jOqMwhXiKRMTOOpus7l/xu/Iqj3+hxyl89I22o6mInbNjDT
	UWD5vsWFMNFyJYDVK3lu9/mqL8Gk=
X-Google-Smtp-Source: AGHT+IEr+CgFXjmG0D1cSHmU1Nn3AjLhgrwPgyZdSrNffcqbKHgcQaT4YBnNpwWH9K3/pSmIsPUk0rmW05Pv8Pgp7K0=
X-Received: by 2002:a4a:ca0d:0:b0:599:e8ff:66d9 with SMTP id
 w13-20020a4aca0d000000b00599e8ff66d9mr7635483ooq.1.1707832762197; Tue, 13 Feb
 2024 05:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com> <20240212161615.161935-4-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20240212161615.161935-4-stanislaw.gruszka@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 14:59:10 +0100
Message-ID: <CAJZ5v0jr4Z=ffm9E+eR7p7rQwbCWEP=YHxNbR9VAEwb8-3e3GA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] thermal: intel: hfi: Enable interface only when required
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 5:16=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> Enable and disable hardware feedback interface (HFI) when user space
> handler is present. For example, enable HFI, when intel-speed-select or
> Intel Low Power daemon is running and subscribing to thermal netlink
> events. When user space handlers exit or remove subscription for
> thermal netlink events, disable HFI.
>
> Summary of changes:
>
> - Register a thermal genetlink notifier
>
> - In the notifier, process THERMAL_NOTIFY_BIND and THERMAL_NOTIFY_UNBIND
> reason codes to count number of thermal event group netlink multicast
> clients. If thermal netlink group has any listener enable HFI on all
> packages. If there are no listener disable HFI on all packages.
>
> - When CPU is online, instead of blindly enabling HFI, check if
> the thermal netlink group has any listener. This will make sure that
> HFI is not enabled by default during boot time.
>
> - Actual processing to enable/disable matches what is done in
> suspend/resume callbacks. Create two functions hfi_do_enable()
> and hfi_do_disable(), which can be called from  the netlink notifier
> callback and suspend/resume callbacks.
>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
>  1 file changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index 3b04c6ec4fca..5e1e2b5269b7 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -159,6 +159,7 @@ struct hfi_cpu_info {
>  static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) =3D { .index =
=3D -1 };
>
>  static int max_hfi_instances;
> +static int hfi_thermal_clients_num;
>  static struct hfi_instance *hfi_instances;
>
>  static struct hfi_features hfi_features;
> @@ -477,8 +478,11 @@ void intel_hfi_online(unsigned int cpu)
>  enable:
>         cpumask_set_cpu(cpu, hfi_instance->cpus);
>
> -       /* Enable this HFI instance if this is its first online CPU. */
> -       if (cpumask_weight(hfi_instance->cpus) =3D=3D 1) {
> +       /*
> +        * Enable this HFI instance if this is its first online CPU and
> +        * there are user-space clients of thermal events.
> +        */
> +       if (cpumask_weight(hfi_instance->cpus) =3D=3D 1 && hfi_thermal_cl=
ients_num > 0) {
>                 hfi_set_hw_table(hfi_instance);
>                 hfi_enable();
>         }
> @@ -573,28 +577,93 @@ static __init int hfi_parse_features(void)
>         return 0;
>  }
>
> -static void hfi_do_enable(void)
> +/*
> + * HFI enable/disable run in non-concurrent manner on boot CPU in syscor=
e
> + * callbacks or under protection of hfi_instance_lock.
> + */

In the comment above I would say "If concurrency is not prevented by
other means, the HFI enable/disable routines must be called under
hfi_instance_lock." and I would retain the comments below (they don't
hurt IMO).

> +static void hfi_do_enable(void *ptr)

I would call this hfi_enable_instance().

> +{
> +       struct hfi_instance *hfi_instance =3D ptr;

Why is this variable needed ro even useful?  prt can be passed
directly to hfi_set_hw_table().

> +
> +       hfi_set_hw_table(hfi_instance);
> +       hfi_enable();
> +}
> +
> +static void hfi_do_disable(void *ptr)

And I'd call this hfi_disable_instance().

> +{
> +       hfi_disable();
> +}
> +
> +static void hfi_syscore_resume(void)
>  {
>         /* This code runs only on the boot CPU. */
>         struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
>         struct hfi_instance *hfi_instance =3D info->hfi_instance;
>
> -       /* No locking needed. There is no concurrency with CPU online. */
> -       hfi_set_hw_table(hfi_instance);
> -       hfi_enable();
> +       if (hfi_thermal_clients_num > 0)
> +               hfi_do_enable(hfi_instance);
>  }
>
> -static int hfi_do_disable(void)
> +static int hfi_syscore_suspend(void)
>  {
> -       /* No locking needed. There is no concurrency with CPU offline. *=
/
>         hfi_disable();
>
>         return 0;
>  }
>
>  static struct syscore_ops hfi_pm_ops =3D {
> -       .resume =3D hfi_do_enable,
> -       .suspend =3D hfi_do_disable,
> +       .resume =3D hfi_syscore_resume,
> +       .suspend =3D hfi_syscore_suspend,
> +};
> +
> +static int hfi_thermal_notify(struct notifier_block *nb, unsigned long s=
tate,
> +                             void *_notify)
> +{
> +       struct thermal_genl_notify *notify =3D _notify;
> +       struct hfi_instance *hfi_instance;
> +       smp_call_func_t func;
> +       unsigned int cpu;
> +       int i;
> +
> +       if (notify->mcgrp !=3D THERMAL_GENL_EVENT_GROUP)
> +               return NOTIFY_DONE;
> +
> +       if (state !=3D THERMAL_NOTIFY_BIND && state !=3D THERMAL_NOTIFY_U=
NBIND)
> +               return NOTIFY_DONE;
> +
> +       mutex_lock(&hfi_instance_lock);
> +
> +       switch (state) {
> +       case THERMAL_NOTIFY_BIND:
> +               hfi_thermal_clients_num++;
> +               break;
> +
> +       case THERMAL_NOTIFY_UNBIND:
> +               hfi_thermal_clients_num--;
> +               break;
> +       }
> +
> +       if (hfi_thermal_clients_num > 0)
> +               func =3D hfi_do_enable;
> +       else
> +               func =3D hfi_do_disable;
> +
> +       for (i =3D 0; i < max_hfi_instances; i++) {
> +               hfi_instance =3D &hfi_instances[i];
> +               if (cpumask_empty(hfi_instance->cpus))
> +                       continue;
> +
> +               cpu =3D cpumask_any(hfi_instance->cpus);
> +               smp_call_function_single(cpu, func, hfi_instance, true);
> +       }
> +
> +       mutex_unlock(&hfi_instance_lock);

So AFAICS, one instance can be enabled multiple times because of this.
  I guess that's OK?  In any case, it would be kind of nice to leave a
note regarding it somewhere here.

> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block hfi_thermal_nb =3D {
> +       .notifier_call =3D hfi_thermal_notify,
>  };
>
>  void __init intel_hfi_init(void)
> @@ -628,10 +697,16 @@ void __init intel_hfi_init(void)
>         if (!hfi_updates_wq)
>                 goto err_nomem;
>
> +       if (thermal_genl_register_notifier(&hfi_thermal_nb))
> +               goto err_nl_notif;

Is it possible for any clients to be there before the notifier is
registered?  If not, it would be good to add a comment about it.

> +
>         register_syscore_ops(&hfi_pm_ops);
>
>         return;
>
> +err_nl_notif:
> +       destroy_workqueue(hfi_updates_wq);
> +
>  err_nomem:
>         for (j =3D 0; j < i; ++j) {
>                 hfi_instance =3D &hfi_instances[j];
> --

