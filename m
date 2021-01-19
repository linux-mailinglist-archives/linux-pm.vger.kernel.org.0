Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB772FC275
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391497AbhASRsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:48:31 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34267 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbhASPKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 10:10:06 -0500
Received: by mail-oi1-f173.google.com with SMTP id h192so3782786oib.1;
        Tue, 19 Jan 2021 07:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++IVvZ2kgMH9GFUIsq1f35VqyxedSb+37MMbjI/pptM=;
        b=hl/xht3qMp9MY3jCzXV9rW2vBoT9ag3SuiFDexdwFyidky0/AMIp0cfF6EuvVnQHfi
         l5o5nPiiN1osEkj/MnhvkCfMEZj/L5yXQhXb/M4HjwIVFz27YI8p+9F8vflj/lddxkS0
         pfRwI74D0CtkUbnm/Gg2r/3J0oINrh8Q1AXiu8XvSDCGfcluhfuMAMrmL0yTsfRolqRX
         GaLzG0ci+Vi9Hl5lFrBV80MIXVVcBp9GzxXJtfgG2/aWbiE5GIVXTsp3M+rmtO5Sm79r
         5MBph/H/Gb09Qny9gZspLDqmJah2NEP1eACRuprCdutYomaz39nZb06Homk7jFjSdQxW
         cg9A==
X-Gm-Message-State: AOAM532foQSl+SUFRILoFVA0VvQbbcKI9ir1zmibJ7ur/ajLowcg4sv0
        migMqtxMt0PdmWEcnZxCMEsiY9Tp7FtyEVCcNs0=
X-Google-Smtp-Source: ABdhPJydK8I08ZXQnAS/dd+fKv2KFZZSvWr0szZww8Tr4PPJ6llRQU50vaBDj10O+1EUD94dAUTmBfJIzxlI7Mioymg=
X-Received: by 2002:aca:308a:: with SMTP id w132mr51025oiw.69.1611068965134;
 Tue, 19 Jan 2021 07:09:25 -0800 (PST)
MIME-Version: 1.0
References: <17705994.d592GUb2YH@kreacher>
In-Reply-To: <17705994.d592GUb2YH@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jan 2021 16:09:14 +0100
Message-ID: <CAJZ5v0gccJKSVuN-okBnvHPjNYJ_FbkzfOueb=AUDr2xHaL7Xg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend device_is_dependent()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 7:31 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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

Greg, are you going to pick up this one or do you want me to take care of it?

It has been reviewed by Saravana.

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
>
>
