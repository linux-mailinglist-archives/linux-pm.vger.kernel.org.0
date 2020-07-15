Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3B22110C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgGOPbz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 11:31:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42136 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgGOPby (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 11:31:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id g37so1759843otb.9
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 08:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfCu9gcxeRoD+7qVqyIBHyNUHyLlmoT+teLp+nb2dZ0=;
        b=NZl2qhC8LNKcmQmByLBggdhf75E2gX2gtCEGJdIHLOs9EsBfsFqF2dlaxVm+txP4jG
         TjSZsVu5rmmrD0E/uPZbqyqDahK1xeBkR1973ngnBomdEweJe4h8fqW2dOWYk5i2VbR5
         neXNCA8P5KIcnoUcwBMvujisdpS3ROV+NZ6/u/qyCTyjFQmEzc/dxl+9IMsNqwZRqQnr
         ELpHIpnkR7mOuheivDUHkee8CG2dPxjzGLhF36rGkCM+0UFvdOTeDTIOAJfnSDqQGj6B
         sLiUgwYpNueZ/8nIOt/1oLVyM4keICTbKSZPhBJSyMtjzfZZq+ftN7zm5OxQx+ntd9sf
         QYJg==
X-Gm-Message-State: AOAM530Jfx+0wyakIA3sWj0vtlAl/W5pfloRNQ/8jtWZ2eC9fjzJrTJj
        ru2GFWEVJtdBnp/VxzFbL1pBH7IOLJWuKUqdrnQ=
X-Google-Smtp-Source: ABdhPJxqCa9PIsfAHEJXsS21RCQfg4fCS9+30rYQzsKC5k3XqY+8qM8Ud9Ij5B5Du4CoOnGQcTDfoDk7AHff+v9KjO8=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr188460oth.262.1594827113876;
 Wed, 15 Jul 2020 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200714142424.66648-1-weiyongjun1@huawei.com>
In-Reply-To: <20200714142424.66648-1-weiyongjun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 17:31:42 +0200
Message-ID: <CAJZ5v0g-vEdOdHMXDBKX2+akELXCYYbRQSb+5RhG7chrP6-vXg@mail.gmail.com>
Subject: Re: [PATCH -next] cpuidle/pseries: Make symbol 'pseries_idle_driver' static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux PM <linux-pm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:14 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/cpuidle/cpuidle-pseries.c:25:23: warning:
>  symbol 'pseries_idle_driver' was not declared. Should it be static?
>
> 'pseries_idle_driver' is not used outside of this file, so marks
> it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpuidle/cpuidle-pseries.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index 6513ef2af66a..3e058ad2bb51 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -22,7 +22,7 @@
>  #include <asm/idle.h>
>  #include <asm/plpar_wrappers.h>
>
> -struct cpuidle_driver pseries_idle_driver = {
> +static struct cpuidle_driver pseries_idle_driver = {
>         .name             = "pseries_idle",
>         .owner            = THIS_MODULE,
>  };

Applied as 5.9 material, thanks!
