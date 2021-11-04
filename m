Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F95445BDD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 22:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhKDV5W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKDV5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 17:57:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B93C061714
        for <linux-pm@vger.kernel.org>; Thu,  4 Nov 2021 14:54:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r10so10653683ljj.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Nov 2021 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hh+F7FtQ40kV8BIiTuy1XfTh1yXhREz8tGFu3uN9U6s=;
        b=svLRA6PdtMaosokexHRNtyZkxc4Wj+ukUuS7t+WCkBB1nslSHGB6d+rzgyOaZurD3M
         LUwjvKGk2YQeIK47UrHO6fmJoevT1S+VyOCI6PCy+kcIA7Lq82vdYFdUfaa50XGirmsT
         l15Ft8m2dDDY/rPnKEhX5+CbwrusskZjnwuM4Y1oLgyln6bMpm7IPshOcx8F73BJkJU1
         2cheHF2LvFf1qYCjpyN3RGWnWEnFanFJyZwvaTTLpYrqXpAruSzky7R+dqLueFc59ASa
         Y1VDl8hU/ifhG7Px+W1tvv63jCzin5KE8UExXBYI4DPNOERGQEDw0iqjcZwq2BJL/nJA
         TFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hh+F7FtQ40kV8BIiTuy1XfTh1yXhREz8tGFu3uN9U6s=;
        b=pzhYQMOMBwX0E1jju+rWIBcX5DKWLb7gtwgH88it3s013w/hwE1CSSiDHORAV8ONGZ
         B62iZBREMzcJECsHbWHNqVLPuODhgsgcs+4m7ueARctsRvTd6VrHEmO5VQD+pB0h9lmW
         pKfLvrzXVf4mXDG2J8yBX1eocG/KmxRscVWR+whTzOZMxNEqkZ/7AIfaZBtkEaBthiKV
         YelVuU3O7G1lKGuHzcQhQgKODteiJW4Ak8Kjz2cmF4w+1mpBpcqkjlbnNEAN6MdPWxx4
         s3ksdlwqJX7H8NcpySHfQuCUBSO7dLGEeLq2aToMmlXRmebPXOATOJ3h93AyDpZhphb5
         ADNA==
X-Gm-Message-State: AOAM5328svOvalcqSzIFALNEql7XILuzlEFmkjZb8KN4v9AiGFENIVhy
        eRIc9pEtoUe+VOgzGuuVkjmTqK9hU/OE2Rbi6QorYg==
X-Google-Smtp-Source: ABdhPJz13Ez8L482AtveMwJcjwaRKUPF+gqux9gEkm3m4tmpT9lXgvRN3nLtFVmBH7uJkjh48mjuVGZZaFn1N5U+wkU=
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr57030492ljq.198.1636062881296;
 Thu, 04 Nov 2021 14:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211104215047.663411-1-nathan@kernel.org>
In-Reply-To: <20211104215047.663411-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Nov 2021 14:54:28 -0700
Message-ID: <CAKwvOdkkKse-EkKMgBBx83eKeG6iXJVhusVRfhrQTrbOrwMtKA@mail.gmail.com>
Subject: Re: [PATCH] power: reset: ltc2952: Fix use of floating point literals
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 4, 2021 at 2:51 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new commit in LLVM causes an error on the use of 'long double' when
> '-mno-x87' is used, which the kernel does through an alias,
> '-mno-80387' (see the LLVM commit below for more details around why it
> does this).
>
> drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
>         data->wde_interval = 300L * 1E6L;
>                                   ^
> drivers/power/reset/ltc2952-poweroff.c:162:21: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
>         data->wde_interval = 300L * 1E6L;
>                            ^
> drivers/power/reset/ltc2952-poweroff.c:163:41: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
>         data->trigger_delay = ktime_set(2, 500L*1E6L);
>                                                ^
> 3 errors generated.
>
> This happens due to the use of a 'long double' literal. The 'E6' part of
> '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> it to 'long double'.
>
> There is no visible reason for floating point values in this driver, as
> the values are only assigned to integer types. Use USEC_PER_SEC, which
> is the same integer value as '1E6L', to avoid changing functionality but
> fix the error.
>
> Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
> index fbb344353fe4..ebe3f2bed4c5 100644
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
>
>  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
>  {
> -       data->wde_interval = 300L * 1E6L;
> -       data->trigger_delay = ktime_set(2, 500L*1E6L);
> +       data->wde_interval = 300L * USEC_PER_SEC;
> +       data->trigger_delay = ktime_set(2, 500L * USEC_PER_SEC);
>
>         hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
>
> base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> --
> 2.34.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
