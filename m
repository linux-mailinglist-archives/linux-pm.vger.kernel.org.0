Return-Path: <linux-pm+bounces-32661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06FB2CD0B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 21:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF626687C84
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A1334728;
	Tue, 19 Aug 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3nvaP+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A78248F77;
	Tue, 19 Aug 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632117; cv=none; b=e8CEWwuRUgd31ai2GtTuQ5dbBbtFxm+fpLt0O9b/snxRpNvMliXnsH0nWxGaaZBc9hs0yaLgDNqJWsWsWyZWuyK+N+CkVOJy3C7TOTtAPkXf2mcfDu9nOwLfWei5qO/ou2R5Moit95sunsy6EGiYrNQsaVY0IyMoVFZRpOF/aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632117; c=relaxed/simple;
	bh=ACtVf0R2kQ4uAgSIy5X2g+NpvSoixjEqO6ocWQXnTCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avtk8jpUL5HYMkP08x9OE2B1I3V/qTxJMUPbedHt03bPfGg1PDODU7CXXK7UCY6SbNiom6wZEWqbMKGQoae8DAw90G2Yp39iCtHEtciJNwEnqP/87hR2g/wqGTD3diD756h6yCw/+snzj4IZtftJxPCEc0LRoOwbWFRkXhBrIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3nvaP+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0D6C4CEF1;
	Tue, 19 Aug 2025 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632117;
	bh=ACtVf0R2kQ4uAgSIy5X2g+NpvSoixjEqO6ocWQXnTCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3nvaP+XilnU9kgovOu3dCz/f5VpocQVCa/fMY028VNdy2R/9EI5GU+YRKlDVl/IN
	 XlCpIYDwNEowadlAsRwZSq7dDE3VSgP2fHJhMsegUNGvDSM4R60ymWQivNwqFElXJr
	 AxKsVq7lFmxgdvnqvVfoDUddvJrmtdhRFRrgaI8maqUj0IPHUVE3n1+thTVXutTEEk
	 gIcEngIO54Eo2fhO6KEnwv3DqHalWyTMGvVl5WTxhIDOQjDfYnCu1G0qFokqAbJejp
	 kSJdUG6gs7fcyXQheyjMBAlEYjDceTD1rGjNmy5CEg6peCpGPVuTaOPlJukBdSkNdB
	 ++aNah+ukDOvg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-435de7dd94aso3788777b6e.2;
        Tue, 19 Aug 2025 12:35:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm2zYF/N4YWHt5pJkOScES3qoBquFXkJJ0ugb/UWKykGOlmLBkWLtHgBlqeS/B7NC18GfDY4ylfXgO2LU=@vger.kernel.org, AJvYcCWUPOTG53zRLdocF9mpSO9OgRpoMkSkJs4kcp2oqIU2meczFDlt2eJPo9ykApjHbTkg1HPJe+tdM5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y/yJWwWHRUawSfzK3Xtf8QWKF/REH8LdNHY/hCuNKGcmq9pN
	0lnWPzY+myR5r8qlylBFDQwBTF8qdNv3WT5zgo4fn9tqJTcb30jyH/mRoEW3nbNNw/sE5pAJp0o
	mpB2K9aHmvU/DQ6koXj5wuso6FwNk7l0=
X-Google-Smtp-Source: AGHT+IGcUwaM7kRY7xaZYIB8n9xunEK4oeaob6UPTy6r2bUDF5jnD9uKcdQQ66ZIBfPPXnLKVPsdbRp6JtM6OVompis=
X-Received: by 2002:a05:6808:1b0c:b0:434:105:13e3 with SMTP id
 5614622812f47-43771ff9f27mr142589b6e.7.1755632116762; Tue, 19 Aug 2025
 12:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
In-Reply-To: <20250731030125.3817484-1-senozhatsky@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Aug 2025 21:35:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>
X-Gm-Features: Ac12FXywANLC9WJArKQ8y5GSn-YTKLC7C4L-nWOBJt734vx4gknskQ88G8axEoE
Message-ID: <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:01=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add dpm_all_cpu_backtrace module parameter which controls
> all CPU backtrace dump before DPM panics the system.

This is exclusively about the DPM watchdog, so the module parameter
name should reflect that.

Also, it is not quite clear which module this is going to belong to,
so a comment with this information would be helpful.

> This is expected to help understanding what might have caused
> device timeout.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..23abad9f039f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>
>  #include "../base.h"
>  #include "power.h"
> @@ -517,6 +518,9 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>         struct dpm_watchdog wd
>
> +static bool __read_mostly dpm_all_cpu_backtrace;
> +module_param(dpm_all_cpu_backtrace, bool, 0644);
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *=
t)
>         unsigned int time_left;
>
>         if (wd->fatal) {
> +               unsigned int this_cpu =3D smp_processor_id();
> +
>                 dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>                 show_stack(wd->tsk, NULL, KERN_EMERG);
> +               if (dpm_all_cpu_backtrace)
> +                       trigger_allbutcpu_cpu_backtrace(this_cpu);
>                 panic("%s %s: unrecoverable failure\n",
>                         dev_driver_string(wd->dev), dev_name(wd->dev));
>         }
> --
> 2.50.1.565.gc32cd1483b-goog
>

