Return-Path: <linux-pm+bounces-5918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BD8985B6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8062817B6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AE8061C;
	Thu,  4 Apr 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMIF+mAV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F5745C3
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228817; cv=none; b=GwPb7JYxwk9pqEo0YzPn402ub4I7WFLQHtIsO3SeQdqyiRppsdvgsgVD9pCDxwjZH/Qb05ae9/Rhd/E+oozqdhPLImiRFH+0CvhtSClDm3DHX8y19zZwPWCvwFunWFSwEgYr2mdvm3LTz2yww9+VWsGvUarLItqHk1x0sSo9os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228817; c=relaxed/simple;
	bh=5V+OUUQEgI9vl8LmcA0OjhwzuJPiZMzJcf6vbpryyZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+na8Ae/7lAWLpuR26fo5Iqo0ClLHSi+8FxWtXk8W3sNCkoKzwnFOfWIYcXSBm0bHKVRtT5p4V1mKmll9aCg4YRuPEJWYTmRSJH5NA6TYIgWXxwFNlclMcFx/Tlr+rmfDVyNMDmPzQlW2d6CxXA87VRJahrus5hLhv5Fua59fCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LMIF+mAV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-614b02f8ed6so17119037b3.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228814; x=1712833614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUrhQlIeNcsOw2CmXgJeR5MWpcnNUD94Apq+OR2phkU=;
        b=LMIF+mAVWpeFB5EprdK4DgGfH+6dkm0/96e5xED+/5ChNhY+2avJmD0DKuQQr2XpB1
         2n4lSzZ1umyUArvFSz1RA8VQMhZBb8ekQ7T7H4cIfjSBfB5hCqMyRi6ifiSOrwiNHQwB
         5UVS3LRBeg62oFnyA7bkV5T3/22xCg+/OEZdwF3KY9reC/qK/0gyS1LAF7Y9x4L9qg1z
         TGr6TYK3MtvmcQVpOTIiDvWfO2gmlZ+fKakYNl8joFePbYvui60fj6BeamLo8T2aC1ih
         sF+6S/vxJLBBIP9PNM8EYGsONN6fzQ/i4mVSH2qge0nK79YA4rnVQj7vhrlsz032rt2b
         HusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228814; x=1712833614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUrhQlIeNcsOw2CmXgJeR5MWpcnNUD94Apq+OR2phkU=;
        b=BokW0Cw5Sxfn7nvelIgsI53XmGcpDRjDxiG2STwn/YTr41z85MOOGlXG5Tmnvi2UOg
         Bgc8k+PmI0h8/FVG0iBRa34CtYZ3wXxFwZj826lAcbmrG/zvgjKpepWzltZV616Ia5Ey
         wrIasypIOZ3pxUxiAipbdeqmVwku2V3s148V+TOCB0TdUu/xb+etPi1YUfIlenwgG4jQ
         0kSDVa3LKn3FIwQTSAdWNCujfDAEFHZhkcxQ/hTMaS+gSpLtI39YY9VNq8+L4YT4leMp
         3Ch8cGCvfyCWkjpjKK/3LFqDwsZAPl/m+Qa+UUBAAbeOkOrf8AgA3nBJPUMr+GQUc6BY
         1C1w==
X-Forwarded-Encrypted: i=1; AJvYcCUM+L5JS+J+k1gZ2knA1hhgELw79hCToH1a5FaTSDfNARuVJBPj6OKVomfPVthlma8asYcTZjOrqTptKNMD4/XNg5ZO6KBMQHU=
X-Gm-Message-State: AOJu0YzRTeWxv2VN5mZQ481acAQESuQb86TE3AsTAv9PBtoWx7Jw3IKN
	wxt7WtR1YMHveeTRVaVeUVGgxpLJDeO03Zf4Wtuz7te1xCU7U3Ij3dIuPxBhAkBUMaxVCh5mSqr
	1zkMYUoWKWMQ/3/R8DSFCVh6xP7TOcm27+Eieow==
X-Google-Smtp-Source: AGHT+IHhQBDmJVslcc5jNndqogQbD7z2vRCEtDJwTJw1F4ttQtXxFF/71MvVUAxY5jBGM/ky3ViZgd2uDSYaCRovSQ0=
X-Received: by 2002:a25:bcc7:0:b0:ddc:d115:4768 with SMTP id
 l7-20020a25bcc7000000b00ddcd1154768mr3822445ybm.1.1712228814663; Thu, 04 Apr
 2024 04:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228151139.2650258-1-ulf.hansson@linaro.org>
In-Reply-To: <20240228151139.2650258-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 13:06:18 +0200
Message-ID: <CAPDyKFqtxR4yBw71LGiTyvHasxU3CNw2Lj_wsrP1rvkedYQkEw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Drop superfluous wrappers psci_dt_attach|detach_cpu()
To: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 16:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> To simplify the code, let's drop psci_dt_attach|detach_cpu() and use the
> common dt_idle_attach|detach_cpu() directly instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Queued up for next via my linux-pm.git (pmdomain), thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/cpuidle-psci-domain.c |  1 +
>  drivers/cpuidle/cpuidle-psci.c        |  5 +++--
>  drivers/cpuidle/cpuidle-psci.h        | 20 --------------------
>  3 files changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b88af1262f1a..2b47811d986f 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -20,6 +20,7 @@
>  #include <linux/string.h>
>
>  #include "cpuidle-psci.h"
> +#include "dt_idle_genpd.h"
>
>  struct psci_pd_provider {
>         struct list_head link;
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bf68920d038a..782030a27703 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -28,6 +28,7 @@
>
>  #include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
> +#include "dt_idle_genpd.h"
>
>  struct psci_cpuidle_data {
>         u32 *psci_states;
> @@ -224,7 +225,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 return 0;
>
> -       data->dev = psci_dt_attach_cpu(cpu);
> +       data->dev = dt_idle_attach_cpu(cpu, "psci");
>         if (IS_ERR_OR_NULL(data->dev))
>                 return PTR_ERR_OR_ZERO(data->dev);
>
> @@ -311,7 +312,7 @@ static void psci_cpu_deinit_idle(int cpu)
>  {
>         struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
>
> -       psci_dt_detach_cpu(data->dev);
> +       dt_idle_detach_cpu(data->dev);
>         psci_cpuidle_use_cpuhp = false;
>  }
>
> diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
> index 4e132640ed64..ef004ec7a7c5 100644
> --- a/drivers/cpuidle/cpuidle-psci.h
> +++ b/drivers/cpuidle/cpuidle-psci.h
> @@ -3,29 +3,9 @@
>  #ifndef __CPUIDLE_PSCI_H
>  #define __CPUIDLE_PSCI_H
>
> -struct device;
>  struct device_node;
>
>  void psci_set_domain_state(u32 state);
>  int psci_dt_parse_state_node(struct device_node *np, u32 *state);
>
> -#ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
> -
> -#include "dt_idle_genpd.h"
> -
> -static inline struct device *psci_dt_attach_cpu(int cpu)
> -{
> -       return dt_idle_attach_cpu(cpu, "psci");
> -}
> -
> -static inline void psci_dt_detach_cpu(struct device *dev)
> -{
> -       dt_idle_detach_cpu(dev);
> -}
> -
> -#else
> -static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
> -static inline void psci_dt_detach_cpu(struct device *dev) { }
> -#endif
> -
>  #endif /* __CPUIDLE_PSCI_H */
> --
> 2.34.1
>

