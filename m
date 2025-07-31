Return-Path: <linux-pm+bounces-31654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31378B16B6C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCF53A78B0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710F23D2A2;
	Thu, 31 Jul 2025 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWjKOzqN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E574522A
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938414; cv=none; b=Oum6HrFfyeuyLx9x822VqNzEJIMx+dxgAWkb9mM2ZksW2rhodYcfCbWtp2m1FVCGj7Q810Q/4Lnqce9CWVteg5c5kS0rh1omTFlT3PfG3Wcp3YBHZOJZN0dlH8S1Tm2pQZuNw1C/eI+oIEVtKpFM0kfluGmUFJcF13qZi/4KGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938414; c=relaxed/simple;
	bh=oqDNnKTx6evnFIVUnZBPUaHw4iEO5wpEE0Io14bZaAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtMq/zTKAPIcIIPUu2LTAiwVBmpS8YY1tDvjgIFsIviqSkNKpKwD7OOkiTOk0PgqvuX+zAvNC+f7Ejt0/kmoJza4D54RnTfDKRE0+xNuBGmqYdLiPBSKFPLc9STxGqi4GMlGwGMkJOaCcshsQ8g5gWItXgun/1246K5BXDqsIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bWjKOzqN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab63f8fb91so4294181cf.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753938411; x=1754543211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7OHyfOZxU+Pu6FEnzeag1ObO8U/z/6yZ/ALqHmmTR4=;
        b=bWjKOzqNNgcBz0vBPPpQ4jeaHB8jCBctWbrMhEeQEqo3sbnGA2JvjG73nwfbZB95e1
         hVMZJ6kgjmgyaJnX1Z+j20BPUezL4kNno5kLxXsaZ3Azth6g24BsrYgAtGeE54ppuDUo
         YmI3plVNBeZm99OOQg0So0mk/lZ1CF7v115ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753938411; x=1754543211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7OHyfOZxU+Pu6FEnzeag1ObO8U/z/6yZ/ALqHmmTR4=;
        b=X49gg3001X07Cj6Ac646R8HXTTyqTYJmKAOqNe1uJ+Pt5YAr2O1GRn9y6Of7kHjgpA
         d1nl2TGOAjWCNAncFfJcxOOJvDeSMjLJ0BYWhEZ8mRnt0uSe5Qi17CILZgyGO0+ZuWwL
         1tDFF27Hhn1Q7EMhf81WL+NqPqC9fn591XCs1x7ezwBhYfNstWdCPXtJ34EOInZNrsVs
         zbJOVJoinFuesnthkq/uhdXuV1E+qlBB343qB2dFSO8TFzQCieUpbQiIBD9KtsaW9dLe
         mTgUplZpod1F4bvE5qDSiztMrBeOidWlLjr4F5LK/bI0SbvdhMPlkZwSoynCSHOs0sFk
         ewgw==
X-Forwarded-Encrypted: i=1; AJvYcCXk6Vt3Ua9rB7u2nW5ctiyL/fjFb+Ru3/d+bNzSE2rLkkyIfkfGU/aHkyvd/3+jsFLNYQBtQXfnpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxweNSFX78eWRLJY+r/puvEGU5uNO3U4Cv3e8+YOKIu/uEKdmIR
	K6eznqD8nftttSXjtBV6OR/I4XRS+CW8C0pkOK7sYuizEORXPJ2G1lbdcrcexK4ye0oqJrIiR6L
	NP02hog==
X-Gm-Gg: ASbGncvwWDvVKNrk47jwHgg+kRgaOYuN4FP3qEUQmfSmJtgDErSwgB1E0KJ8rbVXoAx
	0YNtwzKBEvJjRvvZ4L9LYk1WBKsI1RSY0KrB4FQYjVi+cc05nE3cyBYpGPrEfIqOZi3yq52nDGb
	PF6240jswHtOC7AQaEiUBApOAIk7OTQ9yUqoWKh1XhZ+uMmIS9vajD7Iu8WIQRX2Ri2tm/94HcX
	O2U/ICvkug6i9zzFQJM0hXSvd3yTdRvWqg/HuNsKV7TfFHP20j9J/XSzxoIftkpj8P55JTeD+sH
	uCQAmmIBW279MDJmtTavDQqATe0D3/P/GDqmvHaFeYPGFOrbstOTiCG0Ap+Dwr8hrFtFgmcrx2m
	D9GF8giYXgxNL/Dq7hI/JN9xI/SYec384ipabEEHDygrWNTuUiIh8UgGEFvnpp2S8CawshmY0
X-Google-Smtp-Source: AGHT+IG7k9l2TbMl6WZsGotNdoYWNUe5naQpFD5a9Dh4kV01f5TWLeX8HG8BHNJKA98HUJJTjK2RoA==
X-Received: by 2002:a05:622a:1823:b0:4ab:ab99:4de with SMTP id d75a77b69052e-4aedb9d64c9mr100166161cf.26.1753938411609;
        Wed, 30 Jul 2025 22:06:51 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeedb2b7asm4583221cf.46.2025.07.30.22.06.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 22:06:50 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab86a29c98so169961cf.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 22:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZFGF6GTweFlIAwOx2+5crebFNSCLOZvfPxdUu3UB0Tjhh+hMG6O39632zWpmrbTfzRKI4jvUnsA==@vger.kernel.org
X-Received: by 2002:a05:622a:cf:b0:4a9:7c7e:f2f9 with SMTP id
 d75a77b69052e-4aef1cc5bf6mr922481cf.17.1753938410102; Wed, 30 Jul 2025
 22:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
In-Reply-To: <20250731030125.3817484-1-senozhatsky@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 Jul 2025 14:06:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DQGdTSw0k4fX48qO=5XW1phScmSEYw=JmTOMuATcGjog@mail.gmail.com>
X-Gm-Features: Ac12FXyOSY-ncCQq_pMoHKvGeLdAODKyCgVM1vJKBOddnlG-iFTKjhcGmThEYWo
Message-ID: <CAAFQd5DQGdTSw0k4fX48qO=5XW1phScmSEYw=JmTOMuATcGjog@mail.gmail.com>
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:01=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add dpm_all_cpu_backtrace module parameter which controls
> all CPU backtrace dump before DPM panics the system.  This
> is expected to help understanding what might have caused
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

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

