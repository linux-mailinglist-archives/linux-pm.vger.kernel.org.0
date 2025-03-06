Return-Path: <linux-pm+bounces-23557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4FDA54870
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA33716C22B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A0204699;
	Thu,  6 Mar 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFDE1ciW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69C202C56
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258433; cv=none; b=WClV9Hq8egXW8kP04jhkRdoVWsgwceGLYPrLVI25MJrgp6a8ZpsQBvQs9VNxWtBqWwDQSnPXjLHzk/k+JruUSF7X7bG6gHnBdHzR5TaVHqlRKJVrjAHiPD5W/cdw0RpygIqYG2kijLJhXk1TnvBMB4396MpuS8JNJJEDWX3b52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258433; c=relaxed/simple;
	bh=BjCm5PBqyHKmjMucOFRQC1jdtY0RK6Pqe0onnAO5mwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slhAOhaR4VMBc28doELNWzxnLZm7fhvzw4v3Y1KlbPGy6O03gEJ7qUNNCanlW3S0VrxPQQgg7GLR4z2i+5yfSYq8atc602I1SM4TAMTT7I9gOEt1GC4PcwrdqvPt8EjDDEfT3piDuHcHSNhj62GB+osLUSEP9GncGoK9tCeax+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFDE1ciW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f74b78df93so5251027b3.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258430; x=1741863230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l3kxF9s0s10HtMJFdaStPVy028iaechePMj70+RdBiw=;
        b=uFDE1ciWDJlFtboEWAIvsZI2uxRdZ+8LVVpUhrImVRQ7V2BKQMMYBHLTIT7UZVxzEO
         KuZt8MnZgND/hCY2TpAM6zEo90IxWF+b30tTmwjqTguqQ4LTolRXF/r49X7xkgzrbmQn
         XMRUrs1HSbhRllXxdzHlrSWCVCGsv/KOKvMJhqUl6AEZVZ79IH31oxdKZut71+H3M/C2
         pbHMrlA281UwnWHp7KuU/swZvj0O7m0wLA3Mzz+iQziBdHc7a5wdhehFRn0g+Kwqs3Mp
         CJOAkkvb/g/tf0vFrx4sKQZ/pZOUaChpHVGESuah/8zGljTUZCWy52E45lB4OciL2bJU
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258430; x=1741863230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3kxF9s0s10HtMJFdaStPVy028iaechePMj70+RdBiw=;
        b=TlBEh78r3T3Y6JGpzQkLD6CtPjNi2QsCUzsC+GjCeKV6x4nhvoSnFLJ0XnDGLQ3bns
         XFOsjDsFg38L1dn7Sbm75Xhat+nCjt8PCMGBdRQDWRst1xuso7hcXvPmgsjkuq1wP56g
         70T14RHT+ZX6VQjoydoS/6XXZ8qpedT1Dyn6fPpWhpSl/S3neGhXHhUpdrCaavJNceJ5
         YhpunpkVY4wvrxhhe5av9/cIwx7mRG6LxTVT+dfp177exhLR+qFN7TGHu6ZysyHeIVbA
         XEselNcHxpwkehYuhCF5LbfNDoLPE3pVobyoKnI+ImkcBeTueVdhlGxSr++834r0hVfb
         uUzw==
X-Forwarded-Encrypted: i=1; AJvYcCVZnBZ/HPZ1HeQJCrohNoh5Ni6qUJe5w4ExYyTWwzEWJShkdSaWE1RGjsSVquYHkLaT8drIi59kPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlVglgzQVrY/ScZIpKuReyjImQKHHFUApoEzo58vy571uHzYV
	wYuuKxWCrbAAQ+1QvBI47mffiYu1S8CH6qaTuYyilk2ygH1odDgKwcg9Z3o9/pb2a9Ckr+IGSaP
	2ojSjfZqcYECJisx/WqI8B7DpzPGm6YyCi5JoVQ==
X-Gm-Gg: ASbGncvgUK0oWAAf+pQzGc1MjtzjYs0ioyl4YbM439FsXDV32t211exlA+PaVXeC3ah
	8OkRRQqm5LGrBdgBeDJhc/SItQH2BMsv2DmHSpAPD/aJd/lTREOAPVDiGKsyXa8Hacrz1nDGQ61
	VwsML80ko8lwuYq6Am8CMEtD2xDLc=
X-Google-Smtp-Source: AGHT+IHveALh7pfAJxb1zQDrWysmjfRsRboRORBFdyusSPBVnlo9Xnd8mhzTm+ZPYxFyYXm4hgY3Nu9iytramRNs4y8=
X-Received: by 2002:a05:690c:64c1:b0:6fd:44a5:5b68 with SMTP id
 00721157ae682-6fda306fffbmr91783397b3.35.1741258430563; Thu, 06 Mar 2025
 02:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306061805.2318154-1-ping.bai@nxp.com>
In-Reply-To: <20250306061805.2318154-1-ping.bai@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 6 Mar 2025 11:53:14 +0100
X-Gm-Features: AQ5f1JoVI52ootMQgeP7Rja3_fKhyfkFzcUyyz4qn2NojBs4a97d8HfR3zSlUrg
Message-ID: <CAPDyKForY4VNZtqietDPt2FQM3p4OsaoE_oJb0PPLUAh98WsHQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
To: Jacky Bai <ping.bai@nxp.com>
Cc: lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, james.morse@arm.com, d-gole@ti.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, khilman@baylibre.com, 
	quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 07:17, Jacky Bai <ping.bai@nxp.com> wrote:
>
> for_each_possible_cpu() is currently used to initialize cpuidle
> in the PSCI cpuidle driver.
>
> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
>
> With nosmp or maxcpus=0, only the boot CPU is present, leading
> to the failure:
>
>   |  Failed to register cpuidle device for cpu1
>
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> PSCI cpuidle driver to ensure it only registers cpuidle devices
> for CPUs that are actually present.
>
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Is this problem specific to cpuidle-psci?

Others are using for_each_possible_cpu() when registering their cpuidle drivers.

Kind regards
Uffe

> ---
>  - v2 changes:
>   - Improve the changelog as suggested by Sudeep
> ---
>  drivers/cpuidle/cpuidle-psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..00117e9b33e8 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = psci_idle_init_cpu(&pdev->dev, cpu);
>                 if (ret)
>                         goto out_fail;
> --
> 2.34.1
>

