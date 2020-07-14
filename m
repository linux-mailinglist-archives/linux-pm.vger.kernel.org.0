Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280E121F861
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGNRmz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Jul 2020 13:42:55 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43791 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgGNRmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 13:42:54 -0400
Received: by mail-oo1-f67.google.com with SMTP id t12so3488180ooc.10;
        Tue, 14 Jul 2020 10:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S0/1ZaSgSVdg/MxTYjJ9dtzl+Xg6TV7Nwz4t/Mg+vsA=;
        b=bxG5u3JaixTFLisBdjbjmgG4Jst8r6wVfvLIGPHWzMlVo37Epp2Q4apYEcxdyWhO8Z
         TaXXs8AThce5w/pZCHmpK5f7+PVxyoWsx0g4iaer6Sf6WKFj/Zt0Rl1zPL511V1/0wJ6
         TjQz3WlqO22fERTQw96XP7ixxfZ39Y/8jSaMv7LIVY6CAoS0LFv9EIJlzl/tV5zzhg4D
         es0R4+fpTaL/eZvlyQCuw2MZ01ICIcKVYvJ3iZbT5r+GQQB3T3qJKn5Aw3ZJWw/IWvUZ
         pNansNA2kP6zgGsN3rVPctRK4fedW3VwcsW31+mJpP9mn8uY5ZP4VTpW69+bx3wL4LHB
         o2Dw==
X-Gm-Message-State: AOAM530/XpfJzhQ7svUeSjwdNyx/T48v0Jwv1NJjIduNMjmp5sWkuaDU
        6JJLeo12H7rsmJU/+8wcMAC8ODvfdc34SJhdGQk=
X-Google-Smtp-Source: ABdhPJymOPVRLUsrOujMOFvvybCIJI6YZCquLF+UTRGeAaJBEmNdfb5ZLFnZQsOI5ZGbtgzfbZEvH0Pjtz9Um19XLJw=
X-Received: by 2002:a4a:9552:: with SMTP id n18mr5563407ooi.1.1594748574051;
 Tue, 14 Jul 2020 10:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-12-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-12-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 19:42:42 +0200
Message-ID: <CAJZ5v0h-RjAFChHB9OazbkwSmBR1E-sFCBO_b5=mC+Jr-j_VmA@mail.gmail.com>
Subject: Re: [PATCH 11/13] cpufreq: pcc-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Matthew Garrett <mjg@redhat.com>,
        Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Can't see them being used anywhere and the compiler doesn't complain
> that they're missing, so ...

Autoloading of the module too.

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
>  619 | static const struct acpi_device_id processor_device_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~
>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 5789fe7a94bd3..99cf8b78c032a 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -616,13 +616,6 @@ static void __exit pcc_cpufreq_exit(void)
>         free_percpu(pcc_cpu_info);
>  }
>
> -static const struct acpi_device_id processor_device_ids[] = {
> -       {ACPI_PROCESSOR_OBJECT_HID, },
> -       {ACPI_PROCESSOR_DEVICE_HID, },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> -
>  MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
>  MODULE_VERSION(PCC_VERSION);
>  MODULE_DESCRIPTION("Processor Clocking Control interface driver");
> --
> 2.25.1
>
