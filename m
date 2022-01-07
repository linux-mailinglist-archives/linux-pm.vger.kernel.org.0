Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E6487A69
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jan 2022 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiAGQdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 11:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348266AbiAGQdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 11:33:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0043C061401
        for <linux-pm@vger.kernel.org>; Fri,  7 Jan 2022 08:33:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x6so17457632lfa.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Jan 2022 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhF6StDpI+3ZSQ6faKXsbBjH2ED0Nvwq42ETEz4x9/g=;
        b=GfA0cldfIieDD4gKWyksixy8aDD3yca5nIRpVxlKor5YXoZ73svrV5gQNQWU1QRS+T
         lG/tO43LaEmQ8cXjrOMICRqHlsDQvFxWqBYVXfOuO5Z18T/XUTq2f+LpzN56W2B4v/Ya
         MvKg+J3KHJQ1Ugg4I+zfX7lQoNo9OSM9/wODvvxXf5xs9BA5ss2+P4+qjCt4PVMtgbi0
         cZKETLV9n482jRFAH+DpdfJVfH9y6GcJn7lgrEagqRIc7p1xYQvYu0D5YSJBsbteBUdR
         Bqc361go5ui1A+xiijGtK+07cIP14v9UBveCyhspOCF7DAoG3KlTMkoXe3S8uaQr6wkk
         qHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhF6StDpI+3ZSQ6faKXsbBjH2ED0Nvwq42ETEz4x9/g=;
        b=Z4d4gjg+jNPEt/+tkDGudQwQFQtiFkYgjOQNYi7785qpAzap02lML4vrfma1e1qQec
         Ic0Pg92DJPKgeUzECHNUmaTQmzganjZeOg0y96uokrloHqodwag52cii8uVmthkkjJcM
         voTJXXxb7f992TFCvdrTJSe9UY4s7rhLB5EYhQWNrDomo8dfTmlNMiVAeA1hUmb/kVve
         VL63Zrp1sgHFGk9TTHLZLo5Tyq8qQDvIHck1IN5kr0yEIID0A8knX00hvN1OCM6LcVK8
         XQFpGqViqzh/zu0iuisZv/YLT5El7j9jui42vTlAURpQ21zI3fcL6p6+HNcQXFsh30GN
         y6pw==
X-Gm-Message-State: AOAM531awaQSAKyfoqKKssHpTYWBVeSWMgm9ljhw377O8+2/JO8DIBv8
        mJMY4B33rs7IJufXWQZQ7cTTgDxmKQD6OebbbFvpZg==
X-Google-Smtp-Source: ABdhPJzEuYs2SrCVpC4N16SjpYsCCsLOn5le1WCCeYZTgg3m4RBql877sG3Jf9246QuyNJuQuYqOyfGO06QpvouC8jI=
X-Received: by 2002:a05:651c:1246:: with SMTP id h6mr39389480ljh.300.1641573220004;
 Fri, 07 Jan 2022 08:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20220105182939.106885-1-paul@crapouillou.net> <20220105182939.106885-4-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-4-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 17:33:04 +0100
Message-ID: <CAPDyKFpUUPzqonNBrFq68h8QOVxardvf2q7AuEQVeUJ-S2726A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 Jan 2022 at 19:30, Paul Cercueil <paul@crapouillou.net> wrote:
>
> These macros are defined conditionally, according to CONFIG_PM:
> - if CONFIG_PM is enabled, these macros resolve to
>   DEFINE_SIMPLE_DEV_PM_OPS(), and the dev_pm_ops symbol will be
>   exported.
>
> - if CONFIG_PM is disabled, these macros will result in a dummy static
>   dev_pm_ops to be created with the __maybe_unused flag. The dev_pm_ops
>   will then be discarded by the compiler, along with the provided
>   callback functions if they are not used anywhere else.
>
> In the second case, the symbol is not exported, which should be
> perfectly fine - users of the symbol should all use the pm_ptr() or
> pm_sleep_ptr() macro, so the dev_pm_ops marked as "extern" in the
> client's code will never be accessed.

How common is it to export the dev_pm_ops? Do we really need a macro for this?

The similar comment/question applies for patch5.

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Kind regards
Uffe

> ---
>
> Notes:
>     v2: Remove useless empty line
>
>  include/linux/pm.h | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 389e600df233..b82f40e701ab 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_PM_H
>  #define _LINUX_PM_H
>
> +#include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> @@ -357,14 +358,39 @@ struct dev_pm_ops {
>  #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
>  #endif
>
> +#define _DEFINE_DEV_PM_OPS(name, \
> +                          suspend_fn, resume_fn, \
> +                          runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +const struct dev_pm_ops name = { \
> +       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +}
> +
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops name = { \
> -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
> +
> +#ifdef CONFIG_PM
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn, sec) \
> +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn); \
> +       _EXPORT_SYMBOL(name, sec)
> +#else
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn, sec) \
> +static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> +                                        resume_fn, runtime_suspend_fn, \
> +                                        runtime_resume_fn, idle_fn)
> +#endif
> +
> +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
>
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> --
> 2.34.1
>
