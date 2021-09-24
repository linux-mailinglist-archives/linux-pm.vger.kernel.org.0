Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07229417ADA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbhIXSVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 14:21:42 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40614 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbhIXSVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 14:21:41 -0400
Received: by mail-ot1-f45.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so14276934otq.7
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 11:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR1+CKDjTRAf2t8Esdx9MPx7eSPdo6EXOjVrCVzRSSQ=;
        b=ePPf4EXCiMHHnphlW+uKH8EuUTBFwfgqiZjvFep8dJyJyvTxMzp9uQWnv4kbVwGyS4
         gImhDtcnk9cOcmvG23hWsd4SeC5TrN/KyRu7oi+wsAFl02TtXpe7Ww3vSo8EOSNAlWtg
         ZYnkus7gvx/U9XFYW5aQbP9a5yDuecnVG+YCmYIlSgOWveygVl8GxVXOO70hCFBA7zYP
         LAO/JeyIUIoLRervgqDX5QZIDOnBYi04PoSYu42FCOG7W8qSqOIVt+ItZ48g2KodOmSt
         zcGrh5cgRNb+2K09lNKhPWtJjTbQnGx02JEQPzYPmcuTNhsrchflBqUtSzMd1d4zoYV+
         nLUQ==
X-Gm-Message-State: AOAM530qSJIeNWuyuzIFEU350spvwt9K+VxLIi1GrU8d01ZGLZKKIiE5
        ovAIZp0OeKz3MEeHy2j71aCqhsLkcquYdlnJDpA=
X-Google-Smtp-Source: ABdhPJwyC/qW2iuR/aziMh/J41hcq/n5eBzw3wJrI1YjY0vWh25LoZIuDJgEJm75HYBwZ2o8szhv0cVaD/npgBhiuZA=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr5538121otr.301.1632507608156;
 Fri, 24 Sep 2021 11:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210924075920.2087149-1-dedekind1@gmail.com> <20210924104504.2430239-1-dedekind1@gmail.com>
In-Reply-To: <20210924104504.2430239-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 20:19:57 +0200
Message-ID: <CAJZ5v0gn-qAgVLoQXKPttBU5Y1djsT5o5kORJmzEjfbbCV=-YA@mail.gmail.com>
Subject: Re: [PATCH v2] intel_idle: remove a couple of useless variables
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 24, 2021 at 12:45 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> This patch is a cleanup and has no functional impact.

Are you sure?

> Remove the 'auto_demotion_disable_flags' and 'disable_promotion_to_c1e' global
> variables because we already have them in the global 'icpu' structure.

Which is __initdata and these variables aren't.

> Other 'icpu' members like 'use_acpi' are not duplicated,

Because it is not necessary to access them after initialization.

> and it's better to be consistent on this.

Well, the code is as consistent as it can be.

>Consistency improves readability.

That's true, but it has no bearing in this particular case IMO.

> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>
> Changes since v1:
>  * fixed crash on a platform for which the driver does not have a table. In
>    this case 'icpu' is NULL and we need to check for NULL in
>    'intel_idle_cpu_init()'.
>
>  drivers/idle/intel_idle.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 70c2237a7261..a73183016dd4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -67,9 +67,6 @@ static unsigned int disabled_states_mask;
>
>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>
> -static unsigned long auto_demotion_disable_flags;
> -static bool disable_promotion_to_c1e;
> -
>  struct idle_cpu {
>         struct cpuidle_state *state_table;
>
> @@ -1644,7 +1641,7 @@ static void auto_demotion_disable(void)
>         unsigned long long msr_bits;
>
>         rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
> -       msr_bits &= ~auto_demotion_disable_flags;
> +       msr_bits &= ~icpu->auto_demotion_disable_flags;
>         wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
>  }
>
> @@ -1676,10 +1673,13 @@ static int intel_idle_cpu_init(unsigned int cpu)
>                 return -EIO;
>         }
>
> -       if (auto_demotion_disable_flags)
> +       if (!icpu)
> +               return 0;
> +
> +       if (icpu->auto_demotion_disable_flags)
>                 auto_demotion_disable();
>
> -       if (disable_promotion_to_c1e)
> +       if (icpu->disable_promotion_to_c1e)
>                 c1e_promotion_disable();
>
>         return 0;
> @@ -1757,8 +1757,6 @@ static int __init intel_idle_init(void)
>         icpu = (const struct idle_cpu *)id->driver_data;
>         if (icpu) {
>                 cpuidle_state_table = icpu->state_table;
> -               auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
> -               disable_promotion_to_c1e = icpu->disable_promotion_to_c1e;
>                 if (icpu->use_acpi || force_use_acpi)
>                         intel_idle_acpi_cst_extract();
>         } else if (!intel_idle_acpi_cst_extract()) {
> --
> 2.31.1
>
