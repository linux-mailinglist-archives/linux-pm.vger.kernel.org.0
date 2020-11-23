Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDE2C1678
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 21:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKWUXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 15:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgKWUXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 15:23:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42757C061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 12:23:52 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g15so17117022ybq.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 12:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytY0TjIQhQqzTgq9pErBBYZkvIrInUjx/HXC7cUTubA=;
        b=fcF5rVixvJS1RPyLEtzot26wp8NLskDRniD1rrQvQ+0hOA9PXrl0jMDmVRZ111Qpyu
         pKjYgzqNoeZs/Fb1E/DTkjPe4l8xRZ6YwpwB84Pw1HAmDgHMttUW5jCWVhCQRkf2gV3p
         cw4BgP/LjRhy6g9QeBJxtge8QPljEIC0HtGFxl9AhYV4lUg8KEobFxncG91bSa/RPNCX
         61bMqmrVY26TYlh/d/niiqEvXEH1g4LoQzS5l4Ma0SWgbyWSrHxOSa5OyV1qrpjIl1Zs
         /b/H1ct1eOib+WeIDRUeYzGZCjuPbVfgcXpZuuura8V19KEUWFY+JOGsZb08Y600KOf8
         p28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytY0TjIQhQqzTgq9pErBBYZkvIrInUjx/HXC7cUTubA=;
        b=sWsDdQDkTX7Vsd+jjh0pUBX0ELxKlbUjIs0nmxpm+WXT+xKYKXNhJsE7XOQANwGuUk
         Fvn+GCA9Vt+TDApRC9hrJRAizbe8KHgOpvKZKi1qyBrJkl0+EnbohsPoE6v0eb0kBFKX
         fzqvGAk7KwdBIJcMbbV29u4KjLGslMr37viAFUB2B/TVL54fxjOCyeTUmbLPPTeJVZxN
         WlSKoDTXkq7xchB24B8gl0YrK1TRQd2yoD1qHJSOF6N3mkXgEoSzpWHFJ2LgdXdPGgW/
         OKqJ5Wt41+nUbthAoo3MGQphxkboKyN8PQzOP0zf7WXwKvrkUDOeaxTxMU8QQDuajKIv
         ZZ3A==
X-Gm-Message-State: AOAM531JLBdq6tb0DN6l7VjegO316P0ntcp5GGJ2Jmnx+t7VqBvKL73V
        cjR7xD1ry4soWKwYg0WJXNrSA8S7EPQMei9xQw13mQ==
X-Google-Smtp-Source: ABdhPJy1VdCSDZJoaQJrbvD7tv+fVQria0lHcg1KbPvsx75dm9PwFWebGVaHYVcWqpwJmWEaK1TMqP/F+3wSvKGdz0o=
X-Received: by 2002:a25:5b89:: with SMTP id p131mr2099411ybb.310.1606163031206;
 Mon, 23 Nov 2020 12:23:51 -0800 (PST)
MIME-Version: 1.0
References: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
 <CAPDyKFrxKhO0V-uTDLDV6RFQFwhjesE0zfnuBLfYs-n5bNxXtg@mail.gmail.com>
 <35721978-d166-c5d9-06f6-45cec0d835ad@nvidia.com> <CAPDyKFoVQ=D96KtFnmjMh6R7=PrCvTLWqUAPAYsRrVOg2dFFTA@mail.gmail.com>
 <d51fd10f-864a-f7ea-4b8b-006351a16a05@nvidia.com>
In-Reply-To: <d51fd10f-864a-f7ea-4b8b-006351a16a05@nvidia.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 23 Nov 2020 12:23:15 -0800
Message-ID: <CAGETcx-4C41FHO-Ou9AcmYNaWr9Q+WRoNUUmoYmG+-SOKxbtxA@mail.gmail.com>
Subject: Re: [RFC] PM Domains: Ensure the provider is resumed first
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 23, 2020 at 6:57 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 23/11/2020 14:31, Ulf Hansson wrote:
>
> ...
>
> >>> Note that, if there is no device attached to the genpd, the
> >>> ->power_on() callback may not be invoked - unless there is a child
> >>> domain being powered on.
> >>>
> >>> From the genpd provider driver point of view - why do you need to
> >>> implement system suspend/resume callbacks at all? Do you have some
> >>> additional operations to run, besides those executed from the
> >>> ->power_on|off() callbacks?
> >>
> >> The provider in this case is an embedded controller, the BPMP, and it
> >> needs to be resumed [0] prior to calling the provider callbacks. I am
> >> wondering if any other providers have this requirement?
> >
> > It seems like it should be a rather common requirement for a genpd
> > provider - at least for those providers that need to run some
> > additional operations at system suspend/resume.
> >
> > I guess the reason for this problem is that the order of how the
> > devices end up in the dpm_list, doesn't fit well for your case.
> > Normally, a provider should be registered prior and the consumer, as
> > that would probably lead to that the provider becomes resumed first.
>
> Yes it does appear that way. The BPMP (genpd provider) is probed before
> the ACONNECT (consumer) but still the order in which they end up in is
> not what we want.
>
> > In any case, to make sure the order becomes correct, a device link
> > should be created between the genpd domain provider and the consumer
> > device. As a matter of fact, this is done "automagically" during boot
> > for DT based platforms, see of_link_property() in
> > drivers/of/property.c.

Ulf, thanks for adding me and pointing people to fw_devlink.

> >
> > Currently these device links are created with DL_FLAG_SYNC_STATE_ONLY,
> > unless the "fw_devlink" kernel command line specifies a different
> > option (on == DL_FLAG_AUTOPROBE_CONSUMER). I would try to play with
> > that and see how that turns out.
>
> OK, good to know. I will take a look at that. Thanks for the inputs.

Jon,

Let me know if you run into issues with fw_devlink. I can try to help
you address them. If you hit issues, it's going to be one of these two
cases below.

Known issues with fw_devlink:
1. It doesn't like cycles in dependencies in DT (it does the right
thing for some of them, but not all).
2. If a DT device node has a driver that "probes" it without using
driver core/struct device, it blocks the probing of all its consumers.

(1) is on my TODO list of things to fix
(2) needs the driver to be fixed to not do this.

-Saravana
