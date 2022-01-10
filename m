Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644DB489870
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jan 2022 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbiAJMTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jan 2022 07:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbiAJMTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jan 2022 07:19:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB4C061756
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 04:19:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j11so43610787lfg.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3cdTQamqwc5wvi/XQ/FOwI7VvBmgKes9aExDZLIFjA=;
        b=gSOGJgj/TY6JNMK0G2JxMu/WZFwY7zR+ZYiKDN6iQ0Ra9n4bMKcvoREscljN5Zxf6+
         Jv8XTn8e1ietgSFsjNrQvIkgg2RQRdFt1gPZd8OPutrgR3vV3KVsXoeFxCqakP7dQ5IK
         tPgz5rE1t2ny6zDiI3eN0TDLS/iS+n9akUTmUr7Asu7W8+eAEMyLKMpkVxu+z1yP9o0W
         2Pu4YGcelUcN+PmFXSgtdvkQJfZQZkaGTd+nwid/qg+z/8njXLMJ7XA1IE5HE61dtbrt
         PYiZJCgdYYy1KqVmbiAjWa9OVsgX8vxo+MOuv1NNONCoDufVIuC0/s8fWegL93t7jZDt
         XOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3cdTQamqwc5wvi/XQ/FOwI7VvBmgKes9aExDZLIFjA=;
        b=xTGesM9gfYyfPAgPoua5Z6EJ9PMyVoIBpDTNngLDz7wc3NuOJF9aa1e1DB5rznUiIf
         trT9CcIzFdaOnNXN2Idggb0Clnj5wSOv5UYS+uU0Sj/o+IJwaqSGxVIAbsM8WsoLgnKR
         7sQ21EK4Wf7VG5R626FRkNSXjbcKNVj0KiWUS/eyLYAK+I8KR26Ut9OeX8eknRp2DkyQ
         6I9bY3/Z8maWZCCGmkLYoweMrZp4Pa5VAuUvX1/MjpBkaDT9I5e9N4uGg/EOYQURiSk7
         UgCZYJ1tDKhJ2NU2SoN+GksHQNneSNUyEoLa7ZIwjxJIissIKDLdq3FGdAQITvww6P6B
         ISoA==
X-Gm-Message-State: AOAM530BBnzr3l7dALVaAeeZsoptLNrQxl0YYxf5FgDmwa08u7Vs2NBt
        UCpniUG15eW4SlHJJU3YEZnbxn6HcCoqBpW2ssNl8w==
X-Google-Smtp-Source: ABdhPJxvPy8twDY+Ak+Q1oU4Zqi1NunN2lX57+GA7fBUxaLuRAj0pvnI5p/lmSlBQl36w0P/08dUpkNOXSvaTJemqeI=
X-Received: by 2002:a05:6512:4021:: with SMTP id br33mr4206761lfb.233.1641817153127;
 Mon, 10 Jan 2022 04:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <20220107181723.54392-4-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-4-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jan 2022 13:18:36 +0100
Message-ID: <CAPDyKFqkPT_uj4HE0y0hnGQza26JO=b7vOq8t3YVF4=QKDYa-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
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

On Fri, 7 Jan 2022 at 19:17, Paul Cercueil <paul@crapouillou.net> wrote:
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
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Clearly this can be useful!

My main concern is rather that the macros become a bit complicated
(for understandable reasons) and that kind of continues while looking
at patch4 and patch5 too. Hopefully that doesn't prevent users from
adopting them, and the current situation deserves improvements, so I
think this is worth a try!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> Notes:
>     v2: Remove useless empty line
>     v3: - Reorder the code to have non-private macros together in the file
>         - Add comment about the necesity to use the new export macro when
>           the dev_pm_ops has to be exported
>
>  include/linux/pm.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8e13387e70ec..8279af2c538a 100644
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
> @@ -357,14 +358,42 @@ struct dev_pm_ops {
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
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
> + *
> + * If the underlying dev_pm_ops struct symbol has to be exported, use
> + * EXPORT_SIMPLE_DEV_PM_OPS() or EXPORT_GPL_SIMPLE_DEV_PM_OPS() instead.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops name = { \
> -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
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
