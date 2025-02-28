Return-Path: <linux-pm+bounces-23174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8DA499A1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 13:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431D83BE1BA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEB26FA79;
	Fri, 28 Feb 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AveexRAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA726E16C
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746423; cv=none; b=UoQihPqxPBpJaHTWm/AHCZPMlidI8A2ChTpJHlYpRf4kwyTaeAU3KbqPDHdRqz5Ow7Ld8lCt5WHbGNlj2BJNwX6YhLa47uxbdnjtsiWiX84wOjrLKu8UX2u3U/13JDO1xmAXrgB+S9+sA9n30oDCoeLfd/F1kV2XJ9woBXYWyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746423; c=relaxed/simple;
	bh=p7UHPz/x6dNQRPqJQLRXiWvx5o+HcUaUc1ZXs8aUXVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDKhBRWVqItsHFXTMX4cfp/hMVQV5PtjXW49T6hhp47M6xNULwjK2vv5jw1raWuf70l3fiVRFAnJA0H8M6+pYxUujnI9lDc1BUBBEEmvk5StwitAlQzlhXTOBVve71Fu+4+lasDUmr4gkp7HDxgmCbLF2rXGJtM8D2SzOC+9zU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AveexRAz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef60e500d7so17788957b3.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740746420; x=1741351220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Ooa8XCICJaKIeuj7xAOOuapry4kkf3QfCq/gmxVI4=;
        b=AveexRAzWC3+qrQuWnUuXiF1WtcSx5SX8gW6ckmkpF6Cx/P51WkCvj95WK+t7AvOmq
         V/p0fEpEOwREQW8SIMJzBtGRu4ntrdznKNeqA3wua9xDWCxkI2pA1OTg5CUqspjtI9+M
         yRgYeWwehOlLItzdOgBr6XDjvq53EvPu4TLuKhsVO9T4FfBxz9UISUfQCJyfn3Qs+MBk
         7MXxrDMyHF9ZiZIC7cAVAFrt5hDV5hC9qSsJusZ0FvlpERe9T/wIRn829d/MQRsJ/99f
         1uTUpyC1FqVcJ0RLsLzd/RuYzz7hr7OUvfMOX+CTBLsDPMXambbK6Nm7Ae21lI//QsAc
         8PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746420; x=1741351220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4Ooa8XCICJaKIeuj7xAOOuapry4kkf3QfCq/gmxVI4=;
        b=WFzxIjthT+HZkBe91WhCHAijW07cnxg+Mofm0PMBSAmVTPKDGGr/SBbbaefoM35atx
         V6Pp8SzT2zTRABZ+T4WgsNVJ5XeTD0YcxeGyyZS2o5VL9zpYx2XaTO9D0yayQgEpYaht
         G+GVhPIYWqIfKr7Elauk5/Nq9AEVAKGl8xbKtpDlgYJzLGjb/ikLrLpMDBGRp/b/smnY
         gWccTqHyH9+iQZRTUhbcmJqLfMOtEIeDyiQlTMDTZfawuXlgIXLNywLN8ZuF2BF5SHbn
         ON2kHcvau8WS7BPCJB2Yb8xSQWXHvVbyKBKPQexePS3iyXxytOfJiFhZR29x0RxVnR4h
         nB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVhi2v8vS/UTgCEhchTcFXZp21T5uIRynXraJSNQIM/5MilM457lKfeJZ/DFYPidjGBf2jenjDB7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBu9lkB/FCI4K1kO/69Zkz3CqtrJyK63AH1r5b+Jm1BBCqwq1S
	urXx88Uzn8Hj2CYtUcdeH7Mky5rCCIORz3mLDJDwgj60MN/bJF606VH87+ojeuuKZQQ+PdS8ZY/
	36rWUDnUjksz90Vw/4/ccSr7/pm2f5KTlG1q6kg==
X-Gm-Gg: ASbGnctVcEHD1GvzsNrj87G1Yjd4Ej3bmjs8OA5Xti3fQBRFh0kWAudYO3CfCpCYdC3
	nSWwE7yFZvmX7IC1r3BL1zI0d4QoNynxRl1iNMA/3tupWa+mvT8g2y/nFPebAWl1pCL6/BTWmiW
	ZqO+ItzIK7
X-Google-Smtp-Source: AGHT+IE6rmIYi4YBpGngAE6PomvXz/uDDFVnejLUgDP0GX639U137UwtUudkUOfBd3ZknAjto1pnaVb9tjHRIZ3Ml8I=
X-Received: by 2002:a05:690c:6d04:b0:6f9:56d1:a8bd with SMTP id
 00721157ae682-6fd4a155dd7mr39445077b3.33.1740746420539; Fri, 28 Feb 2025
 04:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
In-Reply-To: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 28 Feb 2025 13:39:44 +0100
X-Gm-Features: AQ5f1JrR9nYrPemsgETZ2Dn78sZElA03FbcgLHeClD85UJTZwTb-sf-4AdlB3As
Message-ID: <CAPDyKFr+P9oi-ofXOkfoBHSCLaCAREW_efjJ6TctTeo_AVCzDA@mail.gmail.com>
Subject: Re: [PATCH RFC] pmdomain: core: add support for writeble power domain state
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: vigneshr@ti.com, d-gole@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 14:48, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>
> Add support for writeable power domain states from debugfs.
>
> Defining GENPD_ALLOW_WRITE_DEBUGFS will enable writeable pd_state
> node in debugfs.
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
> This has turn out to be really helpful when debugging SCMI protocol
> for power domain management.
>
> Reference has been taken from clock framework which provides similar
> CLOCK_ALLOW_WRITE_DEBUGFS, which helps to test clocks from debugfs.
> ---
>  drivers/pmdomain/core.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 9b2f28b34bb5..6aba0c672da0 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1298,6 +1298,60 @@ late_initcall_sync(genpd_power_off_unused);
>
>  #ifdef CONFIG_PM_SLEEP
>
> +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> +/*
> + * This can be dangerous, therefore don't provide any real compile time
> + * configuration option for this feature.
> + * People who want to use this will need to modify the source code directly.
> + */
> +static int genpd_state_set(void *data, u64 val)
> +{
> +
> +       struct generic_pm_domain *genpd = data;
> +       int ret = 0;
> +
> +       ret = genpd_lock_interruptible(genpd);
> +       if (ret)
> +               return -ERESTARTSYS;
> +
> +       if (val == 1) {
> +               genpd->power_on(genpd);
> +               genpd->status = GENPD_STATE_ON;
> +       } else if (val == 0) {
> +               genpd->power_off(genpd);
> +               genpd->status = GENPD_STATE_OFF;
> +       }
> +
> +       genpd_unlock(genpd);
> +       return 0;

This makes the behaviour in genpd inconsistent and I am worried about
that, even if it's for debugging/development.

For example, what if there is a device hooked up to the genpd which
requires its PM domain to stay on? And what about child domains?

> +}
> +
> +#define pd_state_mode  0644
> +
> +static int genpd_state_get(void *data, u64 *val)
> +{
> +
> +       struct generic_pm_domain *genpd = data;
> +       int ret = 0;
> +
> +       ret = genpd_lock_interruptible(genpd);
> +       if (ret)
> +               return -ERESTARTSYS;
> +
> +       if (genpd->status == GENPD_STATE_OFF)
> +               *val = 0;
> +       else
> +               *val = 1;
> +
> +       genpd_unlock(genpd);
> +       return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(pd_state_fops, genpd_state_get,
> +                        genpd_state_set, "%llu\n");
> +
> +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> +
>  /**
>   * genpd_sync_power_off - Synchronously power off a PM domain and its parents.
>   * @genpd: PM domain to power off, if possible.
> @@ -3639,6 +3693,11 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
>         if (genpd->set_performance_state)
>                 debugfs_create_file("perf_state", 0444,
>                                     d, genpd, &perf_state_fops);
> +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> +       debugfs_create_file("pd_state", 0644, d, genpd,
> +                           &pd_state_fops);
> +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> +
>  }
>
>  static int __init genpd_debug_init(void)
> @@ -3653,6 +3712,24 @@ static int __init genpd_debug_init(void)
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>                 genpd_debug_add(genpd);
>
> +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> +       pr_warn("\n");
> +       pr_warn("********************************************************************\n");
> +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("**  WRITEABLE POWER DOMAIN STATE DEBUGFS SUPPORT HAS BEEN ENABLED **\n");
> +       pr_warn("**  IN THIS KERNEL                                                **\n");
> +       pr_warn("** This means that this kernel is built to expose pd operations   **\n");
> +       pr_warn("** such as enabling, disabling, etc.                              **\n");
> +       pr_warn("** to userspace, which may compromise security on your system.    **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("** If you see this message and you are not debugging the          **\n");
> +       pr_warn("** kernel, report this immediately to your vendor!                **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> +       pr_warn("********************************************************************\n");
> +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> +
>         return 0;
>  }
>  late_initcall(genpd_debug_init);
>
> ---
> base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
> change-id: 20250221-pm-debug-0824da30890f
>
> Best regards,
> --
> Kamlesh Gurudasani <kamlesh@ti.com>
>

When working with genpd and SCMI PM domains, a more robust way to
debug things would be to implement a slim skeleton driver for a
consumer device. In principle it just needs some basic runtime PM
support and the corresponding device hooked up to the SCMI PM domain
in DT. In this way, we can use the existing sysfs interface for
runtime PM, to control and debug the behaviour of the genpd/SCMI PM
domain.

I have a bunch of local code/drivers for this already. Even for
testing the SCMI perf domain with OPPs. I can share them with you, if
you are interested?

Kind regards
Uffe

