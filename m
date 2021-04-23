Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5E369460
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhDWOJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 10:09:13 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:35390 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWOJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 10:09:12 -0400
Received: by mail-oo1-f52.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so10703920ook.2;
        Fri, 23 Apr 2021 07:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kObfPlQGyESavmLmIC/iQS46Wbu2JdeyTNd7a/sTbM=;
        b=H2jFzay3d89ULDqsA+t3w1jt0MT42h/WAvF3MobWtXbZwz8pi+db0vgLoELNYhIAr6
         aRGsGFaMopWfklKnJDchvcB1WdRUo3t9YUrq1b3OrnC9quhOWXzdlHUU8ayobf4O+teb
         khj/zaBHhY1Sd/BjJ+r4rxox5MRof4bKdQgyXOOomGLI/cWL8nOqfi7jZpuWG4RZP0lY
         pcqlTSMC7kzGc1uzL1rLz7oIb6hdr8Cn5x1a4YsUFYY82xA8uDelcq4Ex/HT5MDPwFox
         komwz/ZiuKPst3OVJ0sYmLqCPlv2zZexoIBEh8JLMqxV3cDoZOR8rryZZsds9EJkygz2
         tnUg==
X-Gm-Message-State: AOAM531zwOn4NKphojbWZS0vEzoI37tEoakpEUPudeHKq6rYduKY7KEi
        zWzoNODeF2ZoRKix8amsatk2vS3SkAcX9Cb0Z3w=
X-Google-Smtp-Source: ABdhPJw1YK2ThWP+liJA9jLFkldSRi2TBe4dgowFGr9o9EtJC6+Qv/9Ylq8Bkg3D5WdhitdMvu6fgXC5+z2nBNgM/X0=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr3203207oos.2.1619186914902;
 Fri, 23 Apr 2021 07:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 16:08:23 +0200
Message-ID: <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: document common mistake with pm_runtime_get_sync()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 22, 2021 at 6:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> pm_runtime_get_sync(), contradictory to intuition, does not drop the
> runtime PM usage counter on errors which lead to several wrong usages in
> drivers (missing the put).  pm_runtime_resume_and_get() was added as a
> better implementation so document the preference of using it, hoping it
> will stop bad patterns.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/power/runtime_pm.rst | 4 +++-
>  include/linux/pm_runtime.h         | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 18ae21bf7f92..478f08942811 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -378,7 +378,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>
>    `int pm_runtime_get_sync(struct device *dev);`
>      - increment the device's usage counter, run pm_runtime_resume(dev) and
> -      return its result
> +      return its result;
> +      be aware that it does not drop the device's usage counter on errors so
> +      usage of pm_runtime_resume_and_get(dev) usually results in cleaner code

Whether or not it results in cleaner code depends on what that code does.

If the code is

pm_runtime_get_sync(dev);

<Do something that will fail if the device is in a low-power state,
but there is no way to handle the failure gracefully anyway>

pm_runtime_put(dev);

then having to use pm_runtime_resume_and_get() instead of the
pm_runtime_get_sync() would be a nuisance.

However, if the code wants to check the return value, that is:

error = pm_runtime_resume_and_get(dev);
if (error)
        return error;

<Do something that will crash and burn the system if the device is in
a low-power state>

pm_runtime_put(dev);

then obviously pm_runtime_resume_and_get() should be your choice.

The rule of thumb seems to be whether or not the return value is going
to be used.

>    `int pm_runtime_get_if_in_use(struct device *dev);`
>      - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 6c08a085367b..0dfd23d2cfc3 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -380,6 +380,9 @@ static inline int pm_runtime_get(struct device *dev)
>   * The possible return values of this function are the same as for
>   * pm_runtime_resume() and the runtime PM usage counter of @dev remains
>   * incremented in all cases, even if it returns an error code.
> + * Lack of decrementing the runtime PM usage counter on errors is a common
> + * mistake, so consider using pm_runtime_resume_and_get() instead for a cleaner
> + * code.
>   */
>  static inline int pm_runtime_get_sync(struct device *dev)
>  {
> --
> 2.25.1
>
