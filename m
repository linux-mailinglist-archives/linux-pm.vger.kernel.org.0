Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B920D48793D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jan 2022 15:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiAGOug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiAGOug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 09:50:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA8C06173F
        for <linux-pm@vger.kernel.org>; Fri,  7 Jan 2022 06:50:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x6so16344534lfa.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Jan 2022 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d5KDjwbf/j/V9ij+JUJJfPSYLZLI5qkKPPbe9Vs//U=;
        b=TSQQd9jhNzdgS3Q7sdJuidX/1KozmxZOJpekwqz4vCyTaQJ0rasZkimqN1gSikS1qU
         5mTIIQNXHNFkJJmoA5pdw/tkU3piK6RSo9iAuhCZ4ECRPyCUn37RqLa+VaLiYxcMpuDb
         t+MQR23xB1RR8nipc42nCm6hy/YFXKkZWTGznXBUP6P3IzFXsae/msC7jAE+Acavbo8c
         NJstSG+EF0TJBxSzbOGmizrIzDc1R3FH+8O9ARcr40nG5PXAmJyQrBdDt4l3K4K7V9/C
         Mg2bcG9+oMqHgGbOFonCBXRJHWjABVNejlF32e74emPbBAmYYZBaaCac17K+SqgWns6B
         VY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d5KDjwbf/j/V9ij+JUJJfPSYLZLI5qkKPPbe9Vs//U=;
        b=CY+uF8mpG2ssUEm+c6Be43lJ8PIsS34/aS2eVH40s/6hhN3Zm5IhKRJiOoN5TAY/sb
         OJkpmNV3w/utxYkgtS+Pq4ooE0jjULxNvX7mXXyxNhURJA0HJvsG9qvWCfSmnLrngANV
         mhL+w87ujifrUPeilNoM+QJRsAfe2Qi+nuFe9/9vcbdzlv1vjNlOZccHKIHBHHD1UJQm
         eopqdeJB8TEClyU6C2PlQ774xmyKEaknJgeSY51fL2PgYkjEaC4jsENU85Vmdw0AE07d
         1YeQvqlv1u1Wp6wiNKkQf7Q9YJfEZK1FCV/FOHUQJFUxc2cafDm4FjUYew1rblXp0afT
         Sj0A==
X-Gm-Message-State: AOAM532cQYCoaV5bVg/iRBeyXU35lCd4uIczR8yy4jGFj7e1eTq/dWDi
        +rstgWHvE64bedMH3jJym9LuQsmJCrn0wnfnQFdR2ppxGWXAntvT
X-Google-Smtp-Source: ABdhPJxmiIoDwltqWIeYOccdeCvfhPekqAhRl5CsJTEvUjmfpP0Y4AOg8V9wqCb3uZc4dt7YhDpUhKnR9B/+dEVTtNk=
X-Received: by 2002:a19:6748:: with SMTP id e8mr26227258lfj.358.1641567033566;
 Fri, 07 Jan 2022 06:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-2-daniel.lezcano@linaro.org> <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
 <556eca9c-4ce8-1c79-cc6d-08d0ec603bd4@linaro.org>
In-Reply-To: <556eca9c-4ce8-1c79-cc6d-08d0ec603bd4@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 15:49:56 +0100
Message-ID: <CAPDyKFpWtVFoqhFrhMQOgHUjggvg_GPYwmeK-jkphQpA7KQZRw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init
 to data section
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jan 2022 at 14:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 31/12/2021 14:33, Ulf Hansson wrote:
> > On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> The dtpm table is used to let the different dtpm backends to register
> >> their setup callbacks in a single place and preventing to export
> >> multiple functions all around the kernel. That allows the dtpm code to
> >> be self-encapsulated.
> >
> > Well, that's not entirely true. The dtpm code and its backends (or
> > ops, whatever we call them) are already maintained from a single
> > place, the /drivers/powercap/* directory. I assume we intend to keep
> > it like this going forward too, right?
> >
> > That is also what patch4 with the devfreq backend continues to conform to.
> >
> >>
> >> The dtpm hierarchy will be passed as a parameter by a platform
> >> specific code and that will lead to the creation of the different dtpm
> >> nodes.
> >>
> >> The function creating the hierarchy could be called from a module at
> >> init time or when it is loaded. However, at this moment the table is
> >> already freed as it belongs to the init section and the creation will
> >> lead to a invalid memory access.
> >>
> >> Fix this by moving the table to the data section.
> >
> > With the above said, I find it a bit odd to put a table in the data
> > section like this. Especially, since the only remaining argument for
> > why, is to avoid exporting functions, which isn't needed anyway.
> >
> > I mean, it would be silly if we should continue to put subsystem
> > specific tables in here, to just let them contain a set of subsystem
> > specific callbacks.
>
> So I tried to change the approach and right now I was not able to find
> an alternative keeping the code self-encapsulate and without introducing
> cyclic dependencies.
>
> I suggest to keep the patch as it is and double check if it makes sense
> to change it after adding more dtpm backends
>
> Alternatively I can copy the table to a dynamically allocated table.

I am not sure I understand the problem. You don't need a "table of
callbacks" at all, at least to start with.

Instead, what you need is to make a call to a function, or actually
one call per supported dtpm type from dtpm_setup_dt() (introduced in
patch2).

For CPUs, you would simply call dtpm_cpu_setup() (introduced in
patch3) from dtpm_setup_dt(), rather than walking the dtpm table an
invoking the ->setup() callback.

Did that make sense to you?

Going forward, when we decide to introduce the option to add/remove
support for dtpm types dynamically, you can then convert to a
dynamically allocated table.

[...]

Kind regards
Uffe
