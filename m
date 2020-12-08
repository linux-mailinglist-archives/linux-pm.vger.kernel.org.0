Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870762D346F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgLHUlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgLHUls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 15:41:48 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF46C0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 12:41:08 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c12so7949291pfo.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIIDS5UbHS+iP04X9nwjtge3+yYkdmmw5G2DdkBGrYg=;
        b=IVkX5Ca68BCKcdF2xOkQaKNZb1DQ8/6Z6QNaWS1Uq8AEKzm/gAAsk/yGJ+ee2LV99y
         HpjaYuc8GNVPiaO4QpZTVlts1t17P3M1LJ2DYu5lW/yXfOYfXRp3tfppkOCpAplRqN8I
         r1tPZx1xvaU5cB76H0VfDTIDF889g469HO1ssh2Mttt6XKRoG4eCefn/YdNAgwWwqfeT
         O4gHqZBaNgf1uqxs5iKVEn1zSMAjxmVo5iLALFSkBim+58yk5TUhwNypIxfibqBGy9+3
         fQuDOHw8l/lxThSVFhEgoV2Sb8thNrsKrloY4ePA31BOt4obNo8yC9ZQScECRqOzsKpY
         Bb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIIDS5UbHS+iP04X9nwjtge3+yYkdmmw5G2DdkBGrYg=;
        b=fFXiwA05yKxaHc7M0esLtLNblFE4x7njmjF2pV218rJ9sFGGMdjgAmfT9mRitypsqq
         K1HY/rtnuovZJwUksUhzXzMVOhMppFQXlYlA1ZyN0r4MBDdCPKuw0PxKf5EAr4xELi0n
         is14RLIgcSIo2PYxVy2hvUlIA1HwyKBY5zyTCyGUOrc2/+zf+EIxRRIdPMr6UJgnL4oG
         qgsO2+sEwE5roTdN2akHMiHBd9mSHgL9T9B/RydeZzRaqxKuV7ye0YrPqJzLBynzxW7M
         ghNzxwb6euJK/BBoqsrfKFpIHLQNM1fRR+a6C5zVJkYMItZnPoijuPJkiLNNKFmra2pt
         1+yw==
X-Gm-Message-State: AOAM531PhLCTLC8xcuI32xL9HBAPcQq/lXPmM4qPCImWaFSnAwraIcZP
        hIHX7jpMaCd51dqFcx1eqBZR24WeuJAYxOnckWM4aw==
X-Google-Smtp-Source: ABdhPJwcshoPsolxrwGrcprrx9t7RVw9VxrK2Lo5vn2Ta5pum1EyTJxBSNXZtrI+Y62Yt9JecxgZ4MO4aWMdSO/IDgc=
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr5907977pjb.182.1607460067950;
 Tue, 08 Dec 2020 12:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20201208191955.2466057-1-tstrudel@google.com> <X8/ZM7Vm/aD9FdlG@kroah.com>
In-Reply-To: <X8/ZM7Vm/aD9FdlG@kroah.com>
From:   Thierry Strudel <tstrudel@google.com>
Date:   Tue, 8 Dec 2020 12:40:56 -0800
Message-ID: <CAMGPabUpDKsVHDtVi=Nyir2Si8cgUCvyeX5OcGyKri+6NWu2uw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: domains: create debugfs nodes when adding power domains
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry about that.
Thanks for the reviews

On Tue, Dec 8, 2020 at 11:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 08, 2020 at 11:19:55AM -0800, Thierry Strudel wrote:
> > debugfs nodes were created in genpd_debug_init alled in late_initcall
> > preventing power domains registered though loadable modules to have
> > a debugfs entry.
> >
> > Create/remove debugfs nodes when the power domain is added/removed
> > to/from the internal gpd_list.
> >
> > Signed-off-by: Thierry Strudel <tstrudel@google.com>
> > Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75
>
> You don't need this, checkpatch.pl should have warned you :)
>
> > ---
> > v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> > v3: remove extra trailing char added by mistake in v2 - kernel test robot
> > v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
> >  drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 28 deletions(-)
>
> Looks good to me, thanks for fixing it up.  Rafael, will this go through
> your tree?
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
