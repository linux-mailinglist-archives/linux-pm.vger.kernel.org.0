Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2A395A4B
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEaMUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 08:20:10 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38727 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 08:20:04 -0400
Received: by mail-ot1-f43.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so10933024otk.5;
        Mon, 31 May 2021 05:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbXQSOMl1SX/w64rXrUFd1GyxWJUeEozQbRJvljg6NY=;
        b=Xzu0Zf8b8aRfydwxaz52TVYOq9M2AkFplqcnDDNd47TlwIiX4XvTf85P/sfGtiOPMI
         dsJgZBllkEXQpjYmfWMuAdqbI5e3ZzgKdQ+IKXb3PCrvCkJ/dIHCeix8051nY/JcQYvF
         rxT5bXI9bxAB4VHdSaA6j0fJMxA8xVF4KBhFSPAlBNXqwZN8rgOA6oaW3X00DEdMZVV4
         q7rZHTugEFyd0+cV79zfKfhGKy2ounJgfgEXf8rHsaBU0K+2akIq4RITKG8EEX8dgR1n
         9nMOpiGMMm+cHW3LV6+s6zmo5kwiiBwFkbsVvtV5I06kDEg9RHmIVUMu7zdJJqBwnGjQ
         24sg==
X-Gm-Message-State: AOAM531zYd1djxtUJBmSMSMTMgOeviUFCbRsIgF7IeXEkWE0wFLlOrWr
        Y4yTUGt9QWBP6PYHnxva7FwNG0f2J+tpCxg1vx4=
X-Google-Smtp-Source: ABdhPJwHEAYRLw7/HcfazhPnPw+s3TPWZzaoJvVfB98jY2K8oA1l2Fk7a28bzTDcdV3Uuz3Fx09io0+sQorpJYQGp/Y=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr2194863otl.206.1622463504175;
 Mon, 31 May 2021 05:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210526162251.125600-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210526162251.125600-1-krzysztof.kozlowski@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 May 2021 14:18:13 +0200
Message-ID: <CAJZ5v0jM2mfO3W5SW+QhToLy+uCorGnmSdr=t3aTtqO-E8e5BA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: document common mistake with pm_runtime_get_sync()
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

On Wed, May 26, 2021 at 6:23 PM Krzysztof Kozlowski
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
>
> ---
>
> Changes since v1:
> 1. Reword after comments from Rafael.
> ---
>  Documentation/power/runtime_pm.rst | 6 +++++-
>  include/linux/pm_runtime.h         | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 18ae21bf7f92..33619bf83f69 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -378,7 +378,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>
>    `int pm_runtime_get_sync(struct device *dev);`
>      - increment the device's usage counter, run pm_runtime_resume(dev) and
> -      return its result
> +      return its result;
> +      be aware that it does not drop the device's usage counter on errors so
> +      so consider using pm_runtime_resume_and_get() instead of it, especially
> +      if its return value is checked by the caller, as this is likely to result
> +      in cleaner code.
>
>    `int pm_runtime_get_if_in_use(struct device *dev);`
>      - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 6c08a085367b..aab8b35e9f8a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -380,6 +380,9 @@ static inline int pm_runtime_get(struct device *dev)
>   * The possible return values of this function are the same as for
>   * pm_runtime_resume() and the runtime PM usage counter of @dev remains
>   * incremented in all cases, even if it returns an error code.
> + * Consider using pm_runtime_resume_and_get() instead of it, especially
> + * if its return value is checked by the caller, as this is likely to result
> + * in cleaner code.
>   */
>  static inline int pm_runtime_get_sync(struct device *dev)
>  {
> --

Applied as 5.14 material (with some cosmetic edits), thanks!
