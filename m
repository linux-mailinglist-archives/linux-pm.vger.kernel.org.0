Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB7346831
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhCWSz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 14:55:28 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:41478 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhCWSzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 14:55:24 -0400
Received: by mail-oo1-f51.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so5186339ooq.8;
        Tue, 23 Mar 2021 11:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L13pApSwTy1/VDlY51Mp4lDN/b9lSMq4JPn8BwJgewA=;
        b=fnhkf6XlcNevEl8fU4SknF9QCvgI4vBHKypjJ7U8DZ2UrM/oXZ0QRAwt9faoYDm1vh
         bpYi/u3C2FKZLpaktl88fkEHefFJF/Ihh8u4PfhhQA4n67ZSNQUATZyvKtLQPX77l2o2
         xGjvf94JYk5N9Ht2znT64ZA/YuPVBdwWcmgbYvsITuvumbNl0NvHXg/oKzRPUzFT5Muy
         yIDpgF9+pWHlnTwXdQ3dWl3KSCqPBpCeM4IdihunWKu+vt5ZBhQOx07S1JUBks0z4kQM
         oeXnCl5lImpBadRK7iUSssXHz0Fa6/vKactyikfVFz2ep6DiJZ9N9OmE7o5N1PM6IbDR
         MLog==
X-Gm-Message-State: AOAM530fLoA/j0U9BvZWkPSOOgCoOsAWxB2vZj8IFB1Mf13stc5CXJkd
        VbFi2vhS5i98n4eRnwauuABvTXvg0HAvm0XKoYdZoWWK
X-Google-Smtp-Source: ABdhPJwekCc17a1Mtoi/kSxgOs17TS3FIFEeUFZh/Dy5SuVc77zHxImI+XmMj7fbnoquxgF31A9+cZ21I7X3P6eI7is=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr4985570oou.44.1616525723681;
 Tue, 23 Mar 2021 11:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210323145608.29832-1-lukasz.luba@arm.com> <YFoIjt3E+MIK3yQQ@kroah.com>
 <39cee1e7-c085-88d2-9b3b-e4ffbbee04eb@arm.com>
In-Reply-To: <39cee1e7-c085-88d2-9b3b-e4ffbbee04eb@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Mar 2021 19:55:12 +0100
Message-ID: <CAJZ5v0hD1qz1RDQpj47fkK4p_q2xSB84kx6bCenj4P6s-n9HsQ@mail.gmail.com>
Subject: Re: [PATCH] PM / EM: postpone creating the debugfs dir till fs_initcall
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 23, 2021 at 4:57 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 3/23/21 3:26 PM, Greg KH wrote:
> > On Tue, Mar 23, 2021 at 02:56:08PM +0000, Lukasz Luba wrote:
> >> The debugfs directory '/sys/kernel/debug/energy_model' is needed before
> >> the Energy Model registration can happen. With the recent change in
> >> debugfs subsystem it's not allowed to create this directory at early stage
> >> (core_initcall). Thus creating this directory would fail.
> >> Postpone the creation of the EM debug dir to later stage: fs_initcall.
> >> It should be safe since all clients: CPUFreq drivers, Devfreq drivers will
> >> be initialized in later stages.
> >> The custom debug log below prints the time of creation the EM debug dir at
> >> fs_initcall and successful registration of EMs at later stages.
> >>
> >> [    1.505717] energy_model: creating rootdir
> >> [    3.698307] cpu cpu0: EM: created perf domain
> >> [    3.709022] cpu cpu1: EM: created perf domain
> >>
> >> fixes: 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> >> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >> Hi Rafael,
> >>
> >> Please take this patch into your PM v5.12 fixes. The change described in
> >> the patch above landed in v5.12-rc1. Some of our EAS/EM tests are failing.
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
>
> Thank you Greg!

Applied as 5.12-rc material, thanks!
