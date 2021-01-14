Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3949F2F6B04
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 20:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbhANTc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 14:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhANTc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 14:32:29 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA48C061757
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 11:31:49 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f6so2814952ybq.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlLwyIAZcmcU3J10djRNP6+bc1Fnx0blUx9zkQy002E=;
        b=h+QwShStJ0xWLhL8nOmLsjwIPcJFLxQjvYyXFsBD26nvqbTmCIKy96u/AbEFkKKPDf
         bSsnbuFGr7o9zxjKsnZJzBI0qtzhOiT9LGyM3n61bu5FJMG2dAe+iAmNCgp5oBywLgAj
         Aw52qPQbu5rTDuW3y/3ycT+26lo6A64C9BjtXniGQqS2ovhJWgc92MGBVsR6Uk100sHm
         iEneprcfnBF07s9/m2/AT0zKft4brSh4skum0wP2G3RIBe0rz4t64GnKpguONDhqKwuw
         XZe+undmTjPQrmJDqwhl6qbZPPR1tjKOcq+UN6m3CJk7gsPvlh5pidGlIpMEwPKzhuSO
         zbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlLwyIAZcmcU3J10djRNP6+bc1Fnx0blUx9zkQy002E=;
        b=SqcRDp7nd/HYUGFNZ6kQb+7qN9QZadlRHTcmtpvzIX6yM3WoG972QpIqVWM8/0x1Pw
         OXAwihkBDMwXdLs0kmW4i2zsjigS710CTN+bYXhYgEuJa/c/z6YbH7gPFmJuVrOWeWdd
         MYIVzxDx8EbHBoZc/xP+AJd7L4NfEwnTC7xiWfTx8jkIi4FpYtfVveUJdenYydJWme2g
         81slZjG0nCd/DVUd51WR6QOAicO+gkgczQZsYJMmLqdPHhQsCVYnrQ94EArh0mdy0pV7
         LMhnoZGucxfh9KzxySoZ65ydXhnKDQNclNuvNRLCH9Y95RC+I6JNk2vrO4mgVWp3YsSw
         Py3g==
X-Gm-Message-State: AOAM530icAHPpP4sg9rOYNs34q2UpmJtwdk2qpuUcOmM3hUB89LOvz89
        q2bmYt+o2RMTzk58iPc0f/ji1XcEp+zC2g4FtMkOKg==
X-Google-Smtp-Source: ABdhPJz/Z3gWGQUlo3M96oztqJ00Rd3rTonSFSBx090xCEmk8k26cGcBZBquWd7qOTRhkz2kLqM6Y7XRWoc7/VjRqhw=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr6927491ybc.32.1610652708236;
 Thu, 14 Jan 2021 11:31:48 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher>
In-Reply-To: <2073294.4OfjquceTg@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 11:31:12 -0800
Message-ID: <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> When adding a new device link, device_is_dependent() is used to
> check whether or not the prospective supplier device does not
> depend on the prospective consumer one to avoid adding loops
> to the graph of device dependencies.
>
> However, device_is_dependent() does not take the ancestors of
> the target device into account, so it may not detect an existing
> reverse dependency if, for example, the parent of the target
> device depends on the device passed as its first argument.
>
> For this reason, extend device_is_dependent() to also check if
> the device passed as its first argument is an ancestor of the
> target one and return 1 if that is the case.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/base/core.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
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
> @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
>         struct device_link *link;
>         int ret;
>
> -       if (dev == target)
> +       if (dev == target || device_is_ancestor(dev, target))
>                 return 1;
>
>         ret = device_for_each_child(dev, target, device_is_dependent);
>

The code works, but it's not at all obvious what it's doing. Because,
at first glance, it's easy to mistakenly think that it's trying to
catch this case:
dev <- child1 <- child2 <- target

Maybe it's clearer if we do this check inside the loop? Something like:

                if (link->consumer == target ||
device_is_ancestor(link->consumer, target))
                        return 1;

-Saravana
