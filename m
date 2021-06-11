Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3B3A4708
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFKQwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 12:52:49 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45650 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhFKQwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 12:52:47 -0400
Received: by mail-oi1-f182.google.com with SMTP id w127so6418755oig.12;
        Fri, 11 Jun 2021 09:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5THCSNHIjfIwjf26YaVqXJWt1I0niq1tGC8N0R1X79Y=;
        b=FgE7+ZNLMSkHY6MILu+w+HZx+Lrc8bW5piwmfLruYcieI1p4tslQ2hgUihXMp0YxCq
         RRtB1UrW9ERXb8St/Sg3G83VMfvB4l8py3/5gzLjIJYH7lYU54PpxHqO5wnC3JGuM969
         YycedgUmgP2PYRz9YxLCWsDdcyKk9HTvULxbGXCWQb1Oqu8LAAmIDbHqWxtLnMyaeN8C
         dH/aGbPwiFZOdwLRZ96jqkm/XlJvp45MM317z7rJx+MGthC9zfTQWzpHCV4LZXAT4Fuu
         EINt/9BdAAteWqWN7/q0o7v9Z65z1oiZoQEcMvD9thkY/c70WXTBpOsHBrgaR0uiGifo
         GlYg==
X-Gm-Message-State: AOAM531JYOXdpwPwL2JOWJZvO1wfroQRGLMAZOrcqnu+rp5QcByumnJx
        nhM25wMrYjgS4zU+7AFY0kzDN49/ja8lEvnxnTA=
X-Google-Smtp-Source: ABdhPJx1Lbcfjspr46W9J/vtG4/t2QWL15GBVroQfquLY+1xlxHYikEyJKVUZedqE7ZbkLNHsgx6PQIJ4Wv1IzlUIEE=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr961617oia.157.1623430249492;
 Fri, 11 Jun 2021 09:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210608074437.12905-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210608074437.12905-1-thunder.leizhen@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 18:50:38 +0200
Message-ID: <CAJZ5v0gRc9XdH++VDh5tQKqhHhkhaEm+982=Y9OMUpQHwCXCBg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: remove trailing spaces and tabs
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 8, 2021 at 9:44 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Run the following command to find and remove the trailing spaces and tabs:
>
> find kernel/power/ -type f | xargs sed -r -i 's/[ \t]+$//'
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/power/Kconfig   | 12 ++++++------
>  kernel/power/process.c |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 6bfe3ead10ad..a12779650f15 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -98,20 +98,20 @@ config PM_STD_PARTITION
>         default ""
>         help
>           The default resume partition is the partition that the suspend-
> -         to-disk implementation will look for a suspended disk image.
> +         to-disk implementation will look for a suspended disk image.
>
> -         The partition specified here will be different for almost every user.
> +         The partition specified here will be different for almost every user.
>           It should be a valid swap partition (at least for now) that is turned
> -         on before suspending.
> +         on before suspending.
>
>           The partition specified can be overridden by specifying:
>
> -               resume=/dev/<other device>
> +               resume=/dev/<other device>
>
> -         which will set the resume partition to the device specified.
> +         which will set the resume partition to the device specified.
>
>           Note there is currently not a way to specify which device to save the
> -         suspended image to. It will simply pick the first available swap
> +         suspended image to. It will simply pick the first available swap
>           device.
>
>  config PM_SLEEP
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 50cc63534486..37401c99b7d7 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * drivers/power/process.c - Functions for starting/stopping processes on
> + * drivers/power/process.c - Functions for starting/stopping processes on
>   *                           suspend transitions.
>   *
>   * Originally from swsusp.
> --

Applied as 5.14 material, thanks!
