Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B007156D62
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgBJBYX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 20:24:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37679 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgBJBYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 20:24:23 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so5759695ioc.4
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2020 17:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zC0fdW0OW5YxUTZQffc1YGjSyo5yWj42gz4iqB+iq/4=;
        b=YmUaDrCVMpaeU9vaLH2rmyMHfw9M8EWRbeEEii8jTQMfkSUrQTkIwxMd+6JdUlSFdZ
         9joO3sFWLMiBWXN/3kfqL2nRJyn4Qu8tK+ITWFrbYwaIl+DrmEyqdGqee30CjQgMBz86
         gmrnzrJFUl7byk6lFBTVKuVTvELbNP44tgLtjHtMdxnKOmpN2ynXPn5A3caJlofY3xUe
         oAwO9YxNjiGyC5FJMUtunEsTCR8VE4BRaF1nmNZGT5/tXsny0Dsc9pxpQcXpYfHTvY3e
         PNs1GElo8dtySsoPC2Z3lODApWpEk1l80Bl7KbHhe7EhivwHSnQ73gCufHJZyliMa/m5
         gyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zC0fdW0OW5YxUTZQffc1YGjSyo5yWj42gz4iqB+iq/4=;
        b=FGLlx5t866PMHRRKOHS7nN5zrsAR8HkdWgocIoGXSup1sFAfOtVxhUCfIiNXpPywc1
         DvYysIUOlOlXzWbiLiIoPqCwULIU+VTBlNF7q7Zdbfo3pASgmRHVfyHFw79qjSGwBHOs
         8w56K2p6yWClKOgl6ZLIVjHF6Byyt9NpfOb7qHG6Ow6jdcNmZUM3ibnMacYFdvgT3QRn
         HBseBSNdot6Mh3aPq6x/TCeqI7DtYKG04r7CzuSrzeUhe4DZ79JwdSrQNTQS2E+naOPE
         xGoFE8iW3vr2QtO7twq4qFe0WBw82t8qFvh3DukHkj486yc6EjckZgTMJBTdo4mQEFtX
         C4Kg==
X-Gm-Message-State: APjAAAVDYi4ebdIw+VthNY72g+OfrFlXvBs6NAYZrQkFbrmWIhh+LoCP
        1XFkCPxlmA3VsUDFK3YcmqrV2vmQgci+u7DRicrJjg==
X-Google-Smtp-Source: APXvYqxoaravzFo4BYAfmTNFmHT4OctToj+bl7sh6YjfJ94LpR3RQh2BYVNjhL0VMr3BPqpZBMMzDPIH4a7FkSzffQQ=
X-Received: by 2002:a02:2107:: with SMTP id e7mr8257336jaa.9.1581297862580;
 Sun, 09 Feb 2020 17:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20200124231834.63628-1-pmalani@chromium.org> <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
 <20200127184439.GA150048@google.com> <CACeCKafdroLXf62aHeP8CZPuiR02EEmKAGmhHczzoSyX0bFv5g@mail.gmail.com>
 <dc1fec43-1bb0-53de-af17-a91fea42a3f5@collabora.com> <CANLzEks0+J9qvAk_rw2_1r74twnonXmPGdCpY3w2nY8xYPAYLw@mail.gmail.com>
 <CACeCKafOhUXcqE6jyaijuFr0V5UtXU8h09RQ=HjV0mE9ar1jWg@mail.gmail.com>
In-Reply-To: <CACeCKafOhUXcqE6jyaijuFr0V5UtXU8h09RQ=HjV0mE9ar1jWg@mail.gmail.com>
From:   Benson Leung <bleung@google.com>
Date:   Sun, 9 Feb 2020 17:24:09 -0800
Message-ID: <CANLzEktZnv3Fv8GYR+kRu6BpCQa+15TvbuN8=YhVxmb+-HySxw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Prashant,

On Mon, Feb 3, 2020 at 4:40 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Mon, Feb 3, 2020 at 3:42 PM Benson Leung <bleung@google.com> wrote:
> >
> > Hi Enric, Hi Prashant,
> >
> > On Wed, Jan 29, 2020 at 12:37 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > >> I'm OK with creating a branch for this series and merging it into
> > > >> chrome-platform-5.7 once Linus releases v5.6-rc1 late next week.
> > > > Thanks; I'm guessing one of the maintainers will perform the creation
> > > > of chrome-platform-5.7 and merge this patch into that branch.
> > > > Also, kindly pick https://lkml.org/lkml/2020/1/24/2068 , i.e patch 4/4
> > > > of this series (I think an earlier version of this patch, i.e
> > > > https://lkml.org/lkml/2020/1/17/628 was marked "Reviewed-by: Sebastian
> > > > Reichel <sebastian.reichel@collabora.com>"
> > > >
> > >
> > > That patch should go through Sebastian's tree, we will create an immutable
> > > branch for him when rc1 is released.
> > >
> >
> > Before rc1 is released, I've gone ahead and created a staging branch
> > on chrome-platform collaboration repo here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=staging-cros-usbpd-notify
> >
> > Here are the two commits I have right now:
> > e8573ca91ae4 power: supply: cros-ec-usbpd-charger: Fix host events
> > a49c1263a22b platform: chrome: Add cros-usbpd-notify driver
> >
> > Enric, I went ahead and modified the Kconfig on the first patch to
> > depend on MFD_CROS_EC_DEV and default it as well.
> > Prashant, let me know how these look to you. We can convert the branch
> > to an immutable next week.
> Thanks Benson, looks good to me.

I've rebased the branch and marked it immutable.

https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=ib-chrome-platform-power-supply-cros-usbpd-notify

I can send a pull request for Sebastian's sake too.

>
> >
> > --
> > Benson Leung
> > Staff Software Engineer
> > Chrome OS Kernel
> > Google Inc.
> > bleung@google.com
> > Chromium OS Project
> > bleung@chromium.org



-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
