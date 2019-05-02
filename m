Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAB1218D
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBSAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 14:00:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33694 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:00:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so1418918pgh.0
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XutM+a4B1cTgtM8Oyf7PhtREcBkoDSqmSV445n5cH4=;
        b=kB8V7nP22PD998/feuY9UzOFmpJ7UAbHNiTTYXYJGGrXknfWxvC5wm3jcp527g6dqg
         vPwukvTEtSLSM4Re9vSOaevZgA+nAFupngUU3QSMO64i0DG5lBhYrbTDHw5Ja/c1nWJe
         7Vz3dI2w0yVEs3a2V4bjf/9x5enw6/qMg1T3yg0OVtUyhCbYCbYE+t06+ha6kA4kluuV
         dyc5yBwxLsegaPHQsdzCKpfN2fd6Rg8BSTCT3A2tWNZRVIGf8v0UhRSDTZfAbeEkC98Y
         cUGythjf86x4KURf/jEwXSh//oTq8+BTGgykp8dL0JuXg3IOcK7HfmOp+bRLVTeZeDGs
         aOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XutM+a4B1cTgtM8Oyf7PhtREcBkoDSqmSV445n5cH4=;
        b=NQmFmhCEDybgtbCIARoB0XY1wE3crblKgoUVCnRpV3KfSueBq0kqw5DQKFQ7KGheo9
         8NnGj+E3oShHdK6t+Hr8nAQ8lvXBwVDYIE9oWpjKKy16YDyIkoqnIWYbLh5XPQvu8Mit
         JZXJ5fK2tZOuc0rmw8MFAYYMVxWMht9g5JxdcqdAAfTa6fW30Nn1ufEZRd6BA3tB3FaA
         FIvs1qbn9DnCvziozVNXUo/OPTrFaJ5YjfuVqiJJAPEEWmTwKX6dyAa06ml8mrczC6Vb
         W3EBB3oaG5Xb6WXVaYEaZQS49nqekqT38Ligz1TO/9J8J5Kcla3hra3RvUXtcyohdKwM
         ELyQ==
X-Gm-Message-State: APjAAAXtiMZQQ7w3OndKDJbbhIXfa9VLPJvKarAZC0tV7sDdy92lx8d8
        tHkJcmX1U+FjaX/V4tFiKz8NPQ5JbAa03G3MswEpVA==
X-Google-Smtp-Source: APXvYqy2aT1zx7H01JMua9f8FBMTCv1LesxIlrStO1znoW3IHNAKAIZD+vqXY8DC4ti4UJ5EfvzTNuXjNxWaI41tPgw=
X-Received: by 2002:a63:d713:: with SMTP id d19mr5406995pgg.145.1556820043227;
 Thu, 02 May 2019 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502012704.12505-1-tranmanphong@gmail.com>
In-Reply-To: <20190502012704.12505-1-tranmanphong@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 May 2019 11:00:31 -0700
Message-ID: <CAKwvOdkCesLHCFy5vD3=KUCRALe-u_TKMa3NGZBn=HuA1R_95g@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: fix clang -Wunsequenced
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     sre@kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 1, 2019 at 6:28 PM Phong Tran <tranmanphong@gmail.com> wrote:
>
> The increment operator of  pointer in be32_to_cpu() is not explicitly.
> It made the warning from clang:
>
> drivers/power/supply/power_supply_core.c:674:36: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
> drivers/power/supply/power_supply_core.c:675:41: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/460
>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  drivers/power/supply/power_supply_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index c917a8b43b2b..7cc6f5fac0d0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -665,8 +665,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
>                 }
>
>                 for (i = 0; i < tab_len; i++) {
> -                       table[i].ocv = be32_to_cpu(*list++);
> -                       table[i].capacity = be32_to_cpu(*list++);
> +                       table[i].ocv = be32_to_cpu(*list);
> +                       list++;
> +                       table[i].capacity = be32_to_cpu(*list);
> +                       list++;

I prefer preincrement/predecrement to postincrement/postdecrement
unless absolutely necessary, but it really doesn't matter in this
case.  Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
