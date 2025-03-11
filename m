Return-Path: <linux-pm+bounces-23847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5391A5C429
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99586189B73E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119225C6F6;
	Tue, 11 Mar 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZ29h8RY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63425C6F4
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704190; cv=none; b=p+eA+u7g7aAN6JTo6/+3IqFvPAlzVTIy+tBil4x9lZU9I+I5I8BPvWdfYzBZ9XZV294s9BIoZg0GR8Zp7jE2h62l93HxqdhZCiJxZHuv01O7cXqPdrT15HfFgBtDcNuuo0pIW8k5hSkvPTwhUmaVaMlxOtBvqNDYu0+kimrKUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704190; c=relaxed/simple;
	bh=VkUyoAyyCmW63H5OQPvbiafh/ZxBkE7JGT7ZH6ENAKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMll/XcKSym6Mc2QHDw6WmXJFs9nAGwLi6hYEcHla22bNF0QXdagLpYINJlW2K2c9ER+0yUxzOiMA/9EMeTt8PARrH7HfsYNI7BnFzSP7eL2Opd5zi4+dJV1KbpzIt9VBqXIqW/20OhFs03J6Lh6C/D68H25N+rMDKAGbZtFQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZ29h8RY; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6feb0742878so51970737b3.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741704187; x=1742308987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN7PsSljamLFmL3eAZGuj/XK8vFI8v0YSA3pxuzua8=;
        b=uZ29h8RYQH1WGelKC+7tTn+5F+tlCEi7O93CLE0VsxHTo8RRSNJKY4A5FKJpLikNEH
         4FKkd4MpoZKEL2GAHc+vZoYG4w3NAs2OvwlvD5iTBPu6KKXxH34MjPI14moUPSU0J2WP
         gjbsLurLtbiZNHqcxNJ1/vMccINBSlTSBPvNc3pxBK3u45/ZF3dxJzYGwWa6C9gz3UBs
         bU3rF4/jfzkJD7fwmhPflRcuuHFjylg1EUhjQJA/UoqlDJKXYX4Yv4XqwWxxl/Qnfov6
         Q9WfMDr905YoZJLb+vGiag4sEPGIX0WAror3eTlrHJ9FejO5DvAI4TGdXUYVRt0q1TGn
         B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704187; x=1742308987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN7PsSljamLFmL3eAZGuj/XK8vFI8v0YSA3pxuzua8=;
        b=MPnswLcUDGbc08Mcc6KoSeMfUaA+EtAakb2aeVB7NhR+tyZUtLlrU9uazu2rgencx7
         EYgUbiH7lgI+HuTShZqy6w+EQSocZLCYlCDHSm3hLgbQl9ByXFSTBIV8NfndG2/AyH9M
         Cu2nuqgSqbBtMPL8n46C1OT7iGtCZFfiyEctt85RZdGHG3Y9RZkvfbMbMzZtpHBrQb9G
         MuH0gUNN1xkYnGRXfg52Iat9krRYkHPl40NaRbdyWLdCgPFqjpI9Sg7XO4cJh3NL5Iwb
         ix6pmzNCwZgHexNdiP/y0mOLMh3surjndSzfNqxr5+j8wxSQBbkXz4UMfRe9TW6urcjY
         f5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVaHpWBuqA4F+gWJ90cnNxASUd2QDbz5y1KWVgw1t3Uffb0s5eRU383TyRmdm+5wNtwZeXPl0AAPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcyfRLvuZTkOg7z5M1TMC05hC1xf3UfktyDYeMdobctdH8+yH
	OKD6uSpL13nPFHcdctz9b45FJ18Dq0BeIjmLceXc51kNyw/UoLAhkjKogXE5EvzOk3BrVewkpqx
	6CDvuk4mx10u+iI81wiKlYigs1fK6wfiSQ9zbuw==
X-Gm-Gg: ASbGncuEPlPtCgUD/AQ5aP1GE+ANKWkcWokuePwhyFJZFhruV9oYZFvAsn7hIlDAgCH
	rRj95Ea7iH3SFtNxRkThKBtLp4NdpsSx7wTL1AlNQdMjwYSV+6TlOiC1s/PRQbYpHUnnfBpH37n
	JftEtqvZONO6/Z3M1cEICoIwZ5qnw=
X-Google-Smtp-Source: AGHT+IG/Nkb2MMo911BY6LZyKSsboklHqls3Mfm0CSui2XrmwBdOBouV0yL+jXkPDlFtJivejjAsU40tXjhf+7Ul5/s=
X-Received: by 2002:a05:690c:3706:b0:6fb:a696:b23b with SMTP id
 00721157ae682-6febf3c519dmr225655647b3.33.1741704187487; Tue, 11 Mar 2025
 07:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307145547.2784821-1-ping.bai@nxp.com>
In-Reply-To: <20250307145547.2784821-1-ping.bai@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Mar 2025 15:42:31 +0100
X-Gm-Features: AQ5f1JpuVnMxrQT-gRgqkxyP6H2nzFhKukp5aY_RBibf6JhIgaCor4IM8qvGE-0
Message-ID: <CAPDyKFqsE4nArB+Qn5gH5P7vVePpZ6Z7ruas2-EGYsctGV-=4w@mail.gmail.com>
Subject: Re: [PATCH v5] cpuidle: Init cpuidle only for present CPUs
To: rafael@kernel.org, Jacky Bai <ping.bai@nxp.com>
Cc: daniel.lezcano@linaro.org, lpieralisi@kernel.org, sudeep.holla@arm.com, 
	james.morse@arm.com, d-gole@ti.com, anup@brainfault.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	imx@lists.linux.dev, khilman@baylibre.com, quic_tingweiz@quicinc.com, 
	quic_yuanjiey@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 15:54, Jacky Bai <ping.bai@nxp.com> wrote:
>
> for_each_possible_cpu() is currently used to initialize cpuidle
> in below cpuidle drivers:
>   drivers/cpuidle/cpuidle-arm.c
>   drivers/cpuidle/cpuidle-big_little.c
>   drivers/cpuidle/cpuidle-psci.c
>   drivers/cpuidle/cpuidle-qcom-spm.c
>   drivers/cpuidle/cpuidle-riscv-sbi.c
>
> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
>
> With nosmp or maxcpus=0, only the boot CPU is present, lead
> to the failure:
>
>   |  Failed to register cpuidle device for cpu1
>
> Then rollback to cancel all CPUs' cpuidle registration.
>
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> above cpuidle drivers to ensure it only registers cpuidle devices
> for CPUs that are actually present.
>
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, I assume you will pick these up? Or let me know if you want me
to take them via my pmdomain tree.

Kind regards
Uffe

> ---
>  - v5 changes:
>    - add changes for cpuidle-qcom-spm
>
>  - v4 changes:
>   - add changes for other cpuidle driver that has the similar issue
>     as cpuidle-pcsi driver.
>
>  - v3 changes:
>   - improve the changelog as suggested by Sudeep
> ---
>  drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
>  drivers/cpuidle/cpuidle-big_little.c | 2 +-
>  drivers/cpuidle/cpuidle-psci.c       | 4 ++--
>  drivers/cpuidle/cpuidle-qcom-spm.c   | 2 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index caba6f4bb1b7..e044fefdb816 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -137,9 +137,9 @@ static int __init arm_idle_init_cpu(int cpu)
>  /*
>   * arm_idle_init - Initializes arm cpuidle driver
>   *
> - * Initializes arm cpuidle driver for all CPUs, if any CPU fails
> - * to register cpuidle driver then rollback to cancel all CPUs
> - * registration.
> + * Initializes arm cpuidle driver for all present CPUs, if any
> + * CPU fails to register cpuidle driver then rollback to cancel
> + * all CPUs registration.
>   */
>  static int __init arm_idle_init(void)
>  {
> @@ -147,7 +147,7 @@ static int __init arm_idle_init(void)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = arm_idle_init_cpu(cpu);
>                 if (ret)
>                         goto out_fail;
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 74972deda0ea..4abba42fcc31 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -148,7 +148,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int part_id)
>         if (!cpumask)
>                 return -ENOMEM;
>
> -       for_each_possible_cpu(cpu)
> +       for_each_present_cpu(cpu)
>                 if (smp_cpuid_part(cpu) == part_id)
>                         cpumask_set_cpu(cpu, cpumask);
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index dd8d776d6e39..b46a83f5ffe4 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -403,7 +403,7 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>  /*
>   * psci_idle_probe - Initializes PSCI cpuidle driver
>   *
> - * Initializes PSCI cpuidle driver for all CPUs, if any CPU fails
> + * Initializes PSCI cpuidle driver for all present CPUs, if any CPU fails
>   * to register cpuidle driver then rollback to cancel all CPUs
>   * registration.
>   */
> @@ -413,7 +413,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = psci_idle_init_cpu(&pdev->dev, cpu);
>                 if (ret)
>                         goto out_fail;
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index 3ab240e0e122..5f386761b156 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -135,7 +135,7 @@ static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "set warm boot addr failed");
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = spm_cpuidle_register(&pdev->dev, cpu);
>                 if (ret && ret != -ENODEV) {
>                         dev_err(&pdev->dev,
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 0c92a628bbd4..0fe1ece9fbdc 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -529,8 +529,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> -       /* Initialize CPU idle driver for each CPU */
> -       for_each_possible_cpu(cpu) {
> +       /* Initialize CPU idle driver for each present CPU */
> +       for_each_present_cpu(cpu) {
>                 ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
>                 if (ret) {
>                         pr_debug("HART%ld: idle driver init failed\n",
> --
> 2.34.1
>

