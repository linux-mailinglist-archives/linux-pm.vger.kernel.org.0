Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9F38E880
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEXOSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 10:18:02 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36809 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhEXOR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 10:17:58 -0400
Received: by mail-oi1-f174.google.com with SMTP id t24so11671108oiw.3;
        Mon, 24 May 2021 07:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLfDdgFGMZneFqCktsH6atT5pZHw0ZxHDKmEv+PNYJg=;
        b=F62iU66zpK3k8PULdWvgP+iUIpnTgyTak9XPCL5BhWlaDXO9uT2Fiauw4ea8sJ7x62
         T/Ba6eL8Ib5Vqxq/W6/KwB+QVPFkrJK+nhdFITqPBPfuKbbth2pR6Tra9/nC6Ta0LZ0E
         dv7m0YEvLa3wK0naG/ymMtg+bjkbLg2v7G5bh7fXdDsA2tngHdibZ8H00sXIU4p18533
         1xiSfphQ+nbgICiCvaOp0RWiCuWYUtYLf4S8HYFYGTn2cjHegX6WmWjiahqrf3XO30ij
         M5Xq4i+/Xnn1TK4/OzEnz7JJFcSkE8TXT6EiUP3h1wBoj0VVOgK8Wh026AIIeayVeusH
         asUg==
X-Gm-Message-State: AOAM533KhD4o1JMA/5sWT6fRiuVoWSTF/1WOMxScwb/L8Qlc+la83E24
        1KZ8+tLasIF/0vIFdU8LeAtKdPZBHRuz9wqd9jM=
X-Google-Smtp-Source: ABdhPJz8Groxbv3rAOwHXxGwU5BvDpsPPdnw8wwYOkESFU3ejwqu1h7ChpOCXn2t/KTvNLWHZefa/9MJBG0Hjq8J7Bs=
X-Received: by 2002:aca:4758:: with SMTP id u85mr11023278oia.71.1621865788787;
 Mon, 24 May 2021 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221906.199436-1-kyle.meyer@hpe.com>
In-Reply-To: <20210521221906.199436-1-kyle.meyer@hpe.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:16:13 +0200
Message-ID: <CAJZ5v0iJUhUyucYEDHXKqXrsy6=3dGUz0uy1pDpx+kKOi_NB2w@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
To:     Kyle Meyer <kyle.meyer@hpe.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-acpi@vegr.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 22, 2021 at 12:19 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>
> Revert part of commit 75c0758137c7a
> ("acpi-cpufreq: Fail initialization if driver cannot be registered").
>
> acpi-cpufreq is mutually exclusive with intel_pstate, however,
> acpi-cpufreq is loaded multiple times during startup while intel_pstate is
> enabled. On systems using systemd the kernel triggers one uevent for each
> device as a result of systemd-udev-trigger.service. The service exists to
> retrigger all devices as uevents sent by the kernel before systemd-udevd
> is running are missed. The delay caused by systemd-udevd repeatedly loading
> the driver, getting a fail return, and unloading the driver twice per
> logical CPU has a significant impact on the startup time, and can cause
> some devices to be unavailable after reaching the root login prompt.
>
> Load the driver once but skip initialization if a cpufreq driver exists by
> changing the return value of cpufreq_get_current_driver() from -EEXIST to
> 0.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 7e7450453714..e79a945369d1 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
>
>         /* don't keep reloading if cpufreq_driver exists */
>         if (cpufreq_get_current_driver())
> -               return -EEXIST;
> +               return 0;
>
>         pr_debug("%s\n", __func__);
>
> --

Applied as 5.14 material with some edits in the subject and changelog, thanks!
