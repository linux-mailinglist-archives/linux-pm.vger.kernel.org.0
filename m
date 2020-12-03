Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427DB2CDD32
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgLCSS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 13:18:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33047 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgLCSS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 13:18:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so2674185ots.0;
        Thu, 03 Dec 2020 10:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNOzNwHkOuGXa7Fh+2VeICnOxC6RLTqC8+Fsh7pbYpc=;
        b=B54bQ7wQTclSsqMy240SK/TtJfK0nPoRMY/LwoFzOoc2GE+dxlW35rkRMz+Ha6FPbK
         oFs5EuYqg+0Wt98ZGw95Xowi3To7JzhlxNdQeD2zs4+C0rsPNfhHm1MkMzRcnZlcNk9P
         O4cNuG3/+x5GHlFNEAR8fNg8kIc3pbkEeh0JSmo4LfGJzb50auj+J0Z+DzGPM9FIWtHT
         LMIWYUl/dNhx1z5nBoiECk4i0zsNDDUxAWvb+HYG462ZCbiah3lLFLNsaUm8C3UGIF1f
         yxV9KF+m21BfJwKCvWxTA8wiPypgCE7bw0u/jgYnH61NGnrDJp/1h6PkvUImbv3NRkiE
         e59A==
X-Gm-Message-State: AOAM531CzQZ5Bw+1otAso2BqqqDf/vH9TK/0FynsMrl0ESv3KDR9zA0Y
        DMtI5+8jYh3YN39I/dnp6vpnOArt2/I8LaznR+U=
X-Google-Smtp-Source: ABdhPJwqemI0nHjABZ8DB7T9ID8g6r75bCjCbsZsgEY3dEVpaIf5c1RYqBLsK8j8uDjbk+vtzho1oSX9qn3XWGdKszQ=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr342208ots.321.1607019461761;
 Thu, 03 Dec 2020 10:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203175756.1405564-1-thierry.reding@gmail.com>
In-Reply-To: <20201203175756.1405564-1-thierry.reding@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Dec 2020 19:17:30 +0100
Message-ID: <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Reorder devices on successful probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 3, 2020 at 6:58 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Device drivers usually depend on the fact that the devices that they
> control are suspended in the same order that they were probed in. In
> most cases this is already guaranteed via deferred probe.
>
> However, there's one case where this can still break: if a device is
> instantiated before a dependency (for example if it appears before the
> dependency in device tree) but gets probed only after the dependency is
> probed. Instantiation order would cause the dependency to get probed
> later, in which case probe of the original device would be deferred and
> the suspend/resume queue would get reordered properly. However, if the
> dependency is provided by a built-in driver and the device depending on
> that driver is controlled by a loadable module, which may only get
> loaded after the root filesystem has become available, we can be faced
> with a situation where the probe order ends up being different from the
> suspend/resume order.
>
> One example where this happens is on Tegra186, where the ACONNECT is
> listed very early in device tree (sorted by unit-address) and depends on
> BPMP (listed very late because it has no unit-address) for power domains
> and clocks/resets. If the ACONNECT driver is built-in, there is no
> problem because it will be probed before BPMP, causing a probe deferral
> and that in turn reorders the suspend/resume queue. However, if built as
> a module, it will end up being probed after BPMP, and therefore not
> result in a probe deferral, and therefore the suspend/resume queue will
> stay in the instantiation order. This in turn causes problems because
> ACONNECT will be resumed before BPMP, which will result in a hang
> because the ACONNECT's power domain cannot be powered on as long as the
> BPMP is still suspended.
>
> Fix this by always reordering devices on successful probe. This ensures
> that the suspend/resume queue is always in probe order and hence meets
> the natural expectations of drivers vs. their dependencies.
>
> Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Saravana had submitted a very similar patch (I don't have a pointer to
that one though) and I was against it at that time due to
overhead-related concerns.  There still are some, but maybe that
doesn't matter in practice.

Also, I kind of expect this to blow up somewhere, but since I have no
examples ready from the top of my head, I think let's try and see, so:

Acked-by: Rafael. J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/dd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 148e81969e04..cfc079e738bb 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -370,6 +370,13 @@ static void driver_bound(struct device *dev)
>
>         device_pm_check_callbacks(dev);
>
> +       /*
> +        * Reorder successfully probed devices to the end of the device list.
> +        * This ensures that suspend/resume order matches probe order, which
> +        * is usually what drivers rely on.
> +        */
> +       device_pm_move_to_tail(dev);
> +
>         /*
>          * Make sure the device is no longer in one of the deferred lists and
>          * kick off retrying all pending devices
> --
> 2.29.2
>
