Return-Path: <linux-pm+bounces-27587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B1AC2614
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBFC17BBC8
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B684296D04;
	Fri, 23 May 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owPxhH+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AC296731
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013172; cv=none; b=NDbQSijqnvGYZZasyaCBwk8y5IOU5rWD+wltVrCXqnb6Ywj7KuqAJ0U6gMhfh/WY9xXabbxc+EaoKbJqAc6RiLXv+bSh4N8yzeoA5SrLZaXsyndy0K14jcXZhI4jrcKGplHL8nN/ouACcOHbfWf4xmztGMDXCWioM2u+b+yYFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013172; c=relaxed/simple;
	bh=5vYFfJe6MTZ02v7Xzf4QUVyqeeVnh3mj0iuKh2VTyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMUucTMckd4dL/ZXSOqhYSFFF8ASbYa+MMVtdWx+9ARr69TvcEez4OCYOrCG6sjvUAI/QcuVEJJ7m6Gy7eI5pJCsMlCMojBZEwcOfP/SaXHiuakd3Bjh+k/GCR/MVMgsquaWaRswL8CfUJiplVDHHL9NYD/g5QyeT3k6FxjoD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owPxhH+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63541C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013171;
	bh=5vYFfJe6MTZ02v7Xzf4QUVyqeeVnh3mj0iuKh2VTyPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=owPxhH+DwbbxLImQIHlliZFVyDN0xnN0ftsxskZzjV8XqAK6BwExwCu1B1DOti3/2
	 HA4FwtiGNrAdVto1X1rC+dS9XfoyPu1XtbHVoP03V86zv1qza89UGYxcOcBEsrcdA3
	 pVXVwpGGxay98oGZcd1c48K6H9IetvEtQbSKWEce4vJeSKU1LFK+GbFskFsR+x1lY4
	 1CvFACq38O2MsCaiqfcQnq8HJ79jvJnDg9Ec6De5ea7K3CRdLVee/qOrt5ip4Z92hC
	 co1yoAF6gpd9GWBB42UytzRdpHUEVzgXljgENBBKX9NpLKyA/43kTVjbvQ7DsTjatx
	 We69prCLHAOJA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-609e7f27c66so12691eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 08:12:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcIQF5S1bIJSqia7SzFoACZUsIzktpTDRwP9sKLKxcx2NODbwSSm4KV2j7rGE+nlvd9nqI4HLc3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlN0w6U9IPZSbsNZuNa3pfuj4GPM2mUwXwYV71FzImr0J//Ij
	IAhekQbDND+r/fYgW4WllPVxX0tApssEuU95l7uf46U3oqBhOoXjIWM0mrD4lMSPA97P1UppXJ1
	G/6Xhr9NO2OF4IpmN69yYQ9IR66gy9TY=
X-Google-Smtp-Source: AGHT+IHM5eBmOOKMsXnRBdxwfNqS24cWsMGg0nYIaPVTSbRgbom5+Y1t/HRMAboiubwHNpSEo/W0U+jMp5b7fyo78Cg=
X-Received: by 2002:a05:6820:188e:b0:603:fada:ac53 with SMTP id
 006d021491bc7-609f48de6e9mr17710092eaf.2.1748013170701; Fri, 23 May 2025
 08:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523072239.181371-1-qiwu.chen@transsion.com>
In-Reply-To: <20250523072239.181371-1-qiwu.chen@transsion.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:12:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0io7ZrzA1nJLoJx5e+0rUFACzvOaxBTEy2-jTNQRL3XYQ@mail.gmail.com>
X-Gm-Features: AX0GCFvOIaRl7DTY4ydxjgbh2yKUXn1ngWUMhciHuAEzPoWz89srqnbytkizWA0
Message-ID: <CAJZ5v0io7ZrzA1nJLoJx5e+0rUFACzvOaxBTEy2-jTNQRL3XYQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: add tracepoint for s2idle flow
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	"qiwu.chen" <qiwu.chen@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 9:22=E2=80=AFAM qiwu.chen <qiwuchen55@gmail.com> wr=
ote:
>
> Add the tracepoint cpu_idle in enter_s2idle_proper() for tracing
> the s2idle enter and exit events with a determined idle state.
>
> Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
>
> Changes in v2:
> - fix the build warning reported by kernel test robot in v1:
> https://lore.kernel.org/all/20250520030922.9505-1-qiwu.chen@transsion.com=
/
> ---
>  drivers/cpuidle/cpuidle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..9dca6a63e4ad 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -149,6 +149,7 @@ static noinstr void enter_s2idle_proper(struct cpuidl=
e_driver *drv,
>
>         instrumentation_begin();
>
> +       trace_cpu_idle(index, dev->cpu);
>         time_start =3D ns_to_ktime(local_clock_noinstr());
>
>         tick_freeze();
> @@ -174,6 +175,7 @@ static noinstr void enter_s2idle_proper(struct cpuidl=
e_driver *drv,
>         start_critical_timings();
>
>         time_end =3D ns_to_ktime(local_clock_noinstr());
> +       trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>
>         dev->states_usage[index].s2idle_time +=3D ktime_us_delta(time_end=
, time_start);
>         dev->states_usage[index].s2idle_usage++;
> --

This is a bit too late for 6.16, please resubmit when 6.16-rc1 is released.

Thanks!

