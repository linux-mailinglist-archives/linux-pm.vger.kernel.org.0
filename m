Return-Path: <linux-pm+bounces-30468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DCAFE7CA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA2545AF8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046D2D6620;
	Wed,  9 Jul 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrPQv+8N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB02D660E
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060680; cv=none; b=m0wMOUpJMec8r2e04iuW1e1nkPjqZo5Ub3FEja8K085QKu/MbtrxYfVClgQOgHNoAwW1+B2ah9bGCZz7BWMfTw87wmsxOPSFJxqvpMXm3SU5vhHA35erUj5e+jQ0Cc7eiY2vY0TYfbdoj7NM+FKVCHTWZdI+Sw4i0CSHptxrD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060680; c=relaxed/simple;
	bh=4Hkk5OuwSgpa8ZVz2A9112tSYqvhkuQtD4oQV2IJQgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4jDZwyPkC/X6lrFlSAPJ50IFKS8UseTVtURTYT/97Pb+5KGX12H9NDoyg/xpW1ENE315Eh0ClsW2VKLXR6up9Jc5k2WgMcio5kvjvejLJXKcHzW51PuKV0aLwNYKpXHlTT3L5TufpVNMIUFz6jLrNTuEmkWWxhW/EY8oiYO+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrPQv+8N; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e4043c5b7so48313017b3.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060678; x=1752665478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhinRnC2KgbrCAQjb5GrNdfbvaAbJYEqjJK/1IzV5G8=;
        b=MrPQv+8NX70FYkTMV4RTftqbDYYQklA2tp0odqaQtpTNjPt+3tMwzgpqUS1gwxEChA
         B7btfrilPobCCIcEvY4ha4QHRvSnHhIfIF1yjeSI9XdvPdTJP1L4kdooVJGAFD2bFFHT
         aKH1LIU1iJquesfGs15pezsI+wf/NHBP4zwHKKUbymBc9hzcooJJF5GltWCwzjJqNKqF
         qMbE+dlxTbJ2WjYkBWVgG3f/OX8l0wH5A4aYlDG0I0/l0uRp9woh04GXopJwtO1Fu1l+
         ZjeF5ftkFT4iLiQbfoqESHfgikdEMyMRZUBVJnHU4TK/mXj8xt34JQ3LgX10zG0fOz9e
         OPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060678; x=1752665478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhinRnC2KgbrCAQjb5GrNdfbvaAbJYEqjJK/1IzV5G8=;
        b=kXg2rT+z++Qur3XUUQ5BQQW8Neo0NKQxREp7A+c5lzI6ssFooSJHlegXtjyMN5F5BQ
         8FvbYGjH/Bkr+/p1ly3MQ2/nE78qUaqcKoqN83tLuK+V4SCPIGdGrRFZSfQLR5zqQcAT
         nXC7cBuTdRTmUohda/FYkSmmsxQPryV36VnITiuvbHe/w3wrjYK3tbapfwy5XnNkM4ey
         TOP3sRfFNe3xBHF92t5FDX7IpY4n/pBnTyUEvUnrzuvxHc9bAs0+aMgyLtcZERIQtODV
         SPF7KpgUN/WXf1vfSJ8K5riKqUicoeceS4oKKbuRRKqDDKUiBuhUh9Z6CF+1+13Bi+du
         mpzg==
X-Gm-Message-State: AOJu0Yy7jWGL5KyuVPr7RKScJIIpHZQVGOKQBtlXdOeFbRdMp1uiKECN
	jxVq06ZGiTCubO9QOK0Zl0MLdIgacUpA1s5lLdV59yCAvcF06lc4kMmz1w2yB9xg+2wrM36JtQJ
	IrCH5l242jeeTN4NpFfmz40KPKsVxzXTgwDQkUgzE+A==
X-Gm-Gg: ASbGnctbdPn7M7pngl8Ujh+195B5K+3t3iwV6TApF7AEzcf+FDd27jeTzbbP+n2esR7
	68SV1c27i2nvUFNe9p8wYahqS4vUEyJKazjLiJ01pFfL8hlizw6LmJESHBuVkGb2TvAEn07yxnx
	hJPTORyNI2ummMfyGc3J7+uDpwv43uC01a8JtQ7wZqQEvz
X-Google-Smtp-Source: AGHT+IGH/F6xYLHPIoC6QZpCT/W5DUlQY8P9zi7qkAmnI0IUChUcZNLBvcHsqWHGEgSnYu/SEZC21ND0ucUUVBJryNo=
X-Received: by 2002:a05:690c:311:b0:70e:2ced:6f5f with SMTP id
 00721157ae682-717b1a0cdb7mr31460677b3.37.1752060677687; Wed, 09 Jul 2025
 04:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com>
In-Reply-To: <20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:40 +0200
X-Gm-Features: Ac12FXwikg22mOAGpboGSZcxhcTM_ZXNIAi7032DsK4OuPilgCtD8TpPeVBGJ18
Message-ID: <CAPDyKFpjPLrM04uoWAT1m6WCt7WKh-e6gycNbjo4wjQQyv=96A@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: governor: Consider CPU latency tolerance
 from pm_domain_cpu_gov
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 10:30, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>
> pm_domain_cpu_gov is selecting a cluster idle state but does not consider
> latency tolerance of child CPUs. This results in deeper cluster idle state
> whose latency does not meet latency tolerance requirement.
>
> Select deeper idle state only if global and device latency tolerance of all
> child CPUs meet.
>
> Test results on SM8750 with 300 usec PM-QoS on CPU0 which is less than
> domain idle state entry (2150) + exit (1983) usec latency mentioned in
> devicetree, demonstrate the issue.
>
>         # echo 300 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us
>
> Before: (Usage is incrementing)
> ======
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             29817          537        8          270        0
>
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             30348          542        8          271        0
>
> After: (Usage is not incrementing due to latency tolerance)
> ======
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             39319          626        14         307        0
>
>         # cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
>         State          Time Spent(ms) Usage      Rejected   Above      Below
>         S0             39319          626        14         307        0
>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Applied for fixes and by adding fixes/table-tags, thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Rename device pointer to cpu_dev
> - Replace dev_pm_qos_read_value() with dev_pm_qos_raw_resume_latency()
> - Link to v1: https://lore.kernel.org/all/20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com
> ---
>  drivers/pmdomain/governor.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..39359811a93047b36443a1b9583962726f24b88b 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -8,6 +8,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/hrtimer.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/ktime.h>
> @@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         struct cpuidle_device *dev;
>         ktime_t domain_wakeup, next_hrtimer;
>         ktime_t now = ktime_get();
> +       struct device *cpu_dev;
> +       s64 cpu_constraint, global_constraint;
>         s64 idle_duration_ns;
>         int cpu, i;
>
> @@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>                 return true;
>
> +       global_constraint = cpu_latency_qos_limit();
>         /*
>          * Find the next wakeup for any of the online CPUs within the PM domain
>          * and its subdomains. Note, we only need the genpd->cpus, as it already
> @@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>                         if (ktime_before(next_hrtimer, domain_wakeup))
>                                 domain_wakeup = next_hrtimer;
>                 }
> +
> +               cpu_dev = get_cpu_device(cpu);
> +               if (cpu_dev) {
> +                       cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
> +                       if (cpu_constraint < global_constraint)
> +                               global_constraint = cpu_constraint;
> +               }
>         }
>
> +       global_constraint *= NSEC_PER_USEC;
>         /* The minimum idle duration is from now - until the next wakeup. */
>         idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
>         if (idle_duration_ns <= 0)
> @@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>          */
>         i = genpd->state_idx;
>         do {
> -               if (idle_duration_ns >= (genpd->states[i].residency_ns +
> -                   genpd->states[i].power_off_latency_ns)) {
> +               if ((idle_duration_ns >= (genpd->states[i].residency_ns +
> +                   genpd->states[i].power_off_latency_ns)) &&
> +                   (global_constraint >= (genpd->states[i].power_on_latency_ns +
> +                   genpd->states[i].power_off_latency_ns))) {
>                         genpd->state_idx = i;
>                         genpd->gd->last_enter = now;
>                         genpd->gd->reflect_residency = true;
>
> ---
> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
> change-id: 20250708-pmdomain_qos-29077f8b622e
>
> Best regards,
> --
> Maulik Shah <maulik.shah@oss.qualcomm.com>
>

