Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC74376476
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhEGLaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhEGL3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 07:29:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA79C061761
        for <linux-pm@vger.kernel.org>; Fri,  7 May 2021 04:28:35 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x17so190679vsc.0
        for <linux-pm@vger.kernel.org>; Fri, 07 May 2021 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeCXuynOU5/nueZeAhSxiOqvtvTDZN1GezJx4N+SP5Y=;
        b=Sc6Kx3Bq8NZR2LLjLN69C7kmPQwIg+Pw5FF2SI4xm0J/8FXustQJ0wswlmc5qhn2Rm
         CtoPxRq+NR3NkdAe4uT2y84gEvatGzUT3OEAIQfW5RnBQcGHaOBKBB/ePsBduE+cq770
         q8GbnkyfmQ63gnhf7i+0N8+s/r8vyab32+KU6r+Ug0n9vzZOA5jGF6H+Jt9pjdIHWZWN
         CiSseKvJdfPsxRAjQn8CMLhYSMz+0dpDf3X5R1KD/GknyNX+CqyWqF55WT5DzUJERz0s
         JhpA73elzjKL4dI+5N7VpXjEwuF+L95AnIT076J33cthIb+gbuVK604AWz2zMjRHbwZE
         Uk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeCXuynOU5/nueZeAhSxiOqvtvTDZN1GezJx4N+SP5Y=;
        b=k3VZqAOiDaNX0+cVOXzlBYmzVrUDRZUOdkn9Ijky6v36BIv/gvdxgWM/P4rBp5VA+G
         nVkBJuTM3kP4A7PPho1CFJAfnq3fWQBdc5prar2Mai9CJewdEaXGFMRN+iOHwR27ZSc8
         Oqg/VF+kM6tXChI6qGbaQ6e+hC/msutYNtj1aDUnVTGYoiq7GRt9REDRSMYS+/+8tPLP
         bfwcTOsLiSRKOR4lFSMlk1qz4BF6JCX6Fd1n8yPCkbdcEjYOQNvY0jkWQCAv5ItV+ovo
         ojmdoaT7aFuazjTr2L+ylECeX2YNx34fVaPt9G7B6UQRHmSylh4R1UQ6/jpnU3KJsrUL
         NJfA==
X-Gm-Message-State: AOAM533ZHur3+IBmI/br5HdLy6TzrsV2bQnjIonXEWgl5YXI1ZXVlJF9
        lsWZ0YcGedCJtTcYcbHTZ67o4Jea2O3IiVM+DTqANA==
X-Google-Smtp-Source: ABdhPJyrRjbYfbEH+gitFsy/NzamJybijwKorLqRs4OhSdm/1MD6yw1F4Ca3Ien29T+xvHRZRTg2N9+IdpEys401Xf8=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr7864810vss.42.1620386915110;
 Fri, 07 May 2021 04:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135723.3601743-1-arnd@kernel.org>
In-Reply-To: <20210421135723.3601743-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 13:27:58 +0200
Message-ID: <CAPDyKFomx+B5MJqW46fKuq_vrV8tLtG5n91eu1pOpvDkcSJJag@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: qcom_scm: fix Kconfig dependencies again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        He Ying <heying24@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Lina Iyer <ilina@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Apr 2021 at 15:57, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The previous compile time fix was incomplete and still results in
> warnings like:
>
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> WARNING: unmet direct dependencies detected for QCOM_SCM
>   Depends on [n]: (ARM [=y] || ARM64) && HAVE_ARM_SMCCC [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> Use a dependency on ARCH_SUSPEND_POSSIBLE as a prerequisite for
> selecting ARM_CPU_SUSPEND, and a dependency on HAVE_ARM_SMCCC
> for QCOM_SCM.
>
> Fixes: 498ba2a8a275 ("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like this isn't applied yet, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/cpuidle/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 334f83e56120..fc596494251c 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -107,7 +107,8 @@ config ARM_TEGRA_CPUIDLE
>
>  config ARM_QCOM_SPM_CPUIDLE
>         bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
> -       depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
> +       depends on ARCH_QCOM || (ARCH_SUSPEND_POSSIBLE && COMPILE_TEST)
> +       depends on ARM && HAVE_ARM_SMCCC
>         select ARM_CPU_SUSPEND
>         select CPU_IDLE_MULTIPLE_DRIVERS
>         select DT_IDLE_STATES
> --
> 2.29.2
>
