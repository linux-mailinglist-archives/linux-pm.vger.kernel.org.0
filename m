Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13DE2FAD0B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 23:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbhARWCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 17:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbhARWCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 17:02:48 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0244FC061575
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 14:02:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i141so6577849yba.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zumUIy9oq3c425eUVST4wJD5csI9JUzk2QZ8OmfbAnc=;
        b=Yo5Gg8UTepfDRZ/i1xpsy4Mpf2PqreW1jRKVkhStFNYMcHkIvvl7uKf0NDbnoUCH9K
         1dG6y09tKrXhb4WEaSoXL5zDbhU2TLyLOXExny1os4qH3LG+NoXoSvH63bJtQ0UO/hON
         4ApMI9Ucv2UG2G5i1t3aWuVWwVB0G9TdycK7qIGUnrrQRkvBtCOzLojO75skKtnDdl02
         Br/ALA5LiKPxtxkaUfBrxJT4etBZ2ueMep9G9WjJaB5yAF2SwmOJn+1XP3hR0ACa7VPa
         vHb7Ot98fy5t1cHh9mPCnRIkh23qzqTGBPtq8ch9ufbyTyIGHzyLmDTZSaMnwn5PKh8P
         iIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zumUIy9oq3c425eUVST4wJD5csI9JUzk2QZ8OmfbAnc=;
        b=bRBA6toxH0Lgcizf7h4EZ+g9OevXOa7XCaqfv5a24OcS7FwG7tSE9aX+gwgZ+yW4/W
         kHEAdYnY2iEOVDANXMwn/TU9eag4yC+QEqWd0PBCSOP7R51v15qUpELnFM1TpQQM7jSn
         T18f99Z2LhWPouNq6GFJtUY5taf9/sVW3vZvT6CABtNlu4pH4lniRytl2uUzxA2kfxU9
         7mzxQQHmWUPhvENhcIPJrf57k1KjCfsGaXJ9RYJBCk59lzldh3v+SCVdxHQKNTpzykPe
         v2C44JPLOAxAq0/RbDZi3w1s8UPXL2+R3DaeG9VEeh9ee7WmWC3Twe4uO6YX/2Tih52R
         +0Tw==
X-Gm-Message-State: AOAM531bl8CqiJrvzwTJfkc3U/x17dIdqDJHS58sZsAkb7i72Xb5OyQv
        /PfZ0ICQgJnGm9nuhR9XURyl9zMePvLuSG1vT3i43A==
X-Google-Smtp-Source: ABdhPJyFG3FD8YyERyVDj1CgHKq7b3LpJu7wRK3tMy/NMXYqTAJIEUzQOfGydKZeX1tBVgIw529QdO8lCAEGb71PNzA=
X-Received: by 2002:a25:4047:: with SMTP id n68mr1677312yba.466.1611007352096;
 Mon, 18 Jan 2021 14:02:32 -0800 (PST)
MIME-Version: 1.0
References: <17705994.d592GUb2YH@kreacher>
In-Reply-To: <17705994.d592GUb2YH@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 Jan 2021 14:01:55 -0800
Message-ID: <CAGETcx9Bk0-nF+wnNXyLpgx7Ny-EchdUpXOYeBmhxTNF+mCR2A@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend device_is_dependent()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 10:30 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the device passed as the target (second argument) to
> device_is_dependent() is not completely registered (that is, it has
> been initialized, but not added yet), but the parent pointer of it
> is set, it may be missing from the list of the parent's children
> and device_for_each_child() called by device_is_dependent() cannot
> be relied on to catch that dependency.
>
> For this reason, modify device_is_dependent() to check the ancestors
> of the target device by following its parent pointer in addition to
> the device_for_each_child() walk.
>
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>
> -> v2:
>    * Improve the changelog.
>    * Add a comment to explain the reason for the extra check.
>    * Add tags.
>
>    No code changes.
>
> ---
>  drivers/base/core.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
>  #endif
>  #endif /* !CONFIG_SRCU */
>
> +static bool device_is_ancestor(struct device *dev, struct device *target)
> +{
> +       while (target->parent) {
> +               target = target->parent;
> +               if (dev == target)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * device_is_dependent - Check if one device depends on another one
>   * @dev: Device to check dependencies for.
> @@ -221,7 +231,12 @@ int device_is_dependent(struct device *d
>         struct device_link *link;
>         int ret;
>
> -       if (dev == target)
> +       /*
> +        * The "ancestors" check is needed to catch the case when the target
> +        * device has not been completely initialized yet and it is still
> +        * missing from the list of children of its parent device.
> +        */
> +       if (dev == target || device_is_ancestor(dev, target))
>                 return 1;
>
>         ret = device_for_each_child(dev, target, device_is_dependent);
>

Reviewed-by: Saravana Kannan <saravanak@google.com>

fw_devlink_relax_cycle() needs a similar fix. Want me to handle that
as a separate patch to driver-core-next? Or do you want to combine
that in this patch?

-Saravana
