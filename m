Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92D81513BF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBDAkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 19:40:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33108 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBDAkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 19:40:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so5388229qkm.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2020 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eh5eLlWcHGoF/U52PtaGDoZRzy+/UdPDBxS5lqGdoE=;
        b=Hj4dY79MwiC316wkyEPymztpuzb2g7dCtVDuFqvOw3ugIm6LAFv8f7B8dLHnYb6aKb
         hB3K705ssZ76iWGwTfnC+H4FCAUermPXw4aS6LB/eqrKd+wBNRDAt+kgVTuxBsq9MZNR
         c6GO3acbSixCoaI/e4GkapdxAhVi4JVF0/Bho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eh5eLlWcHGoF/U52PtaGDoZRzy+/UdPDBxS5lqGdoE=;
        b=uPMQh1ZEYz3nyPTRg3V6MuPcooedKOuT/TUGX1bWkhjLXsaj39EP1HgXi0yTnV0HQb
         gUD/OINA3EbWh6OuEhCNzH5nynPti26hQ26w1PoD8Ds9gJg/grF89NYtoj9/wL5cmWuP
         UYHnPy2a2bOChuH+Izn7Ag9HXc5GDqRy9sVFbivF0w1Vu4Zp5vR6c4gakRoz8ytnOhFa
         LKQiXtnWesQTPkkw/sw1wqUkhtOlIXpoyDGjrnfZCelBYkde8giOOh0qP9KyORvvbSrU
         1GjWenUroowfmeX9u1oc18UzkJVh7AgJZFwc6kBjuE5rWAWn4NMJk0U3aiGjwr8afIPC
         +1/g==
X-Gm-Message-State: APjAAAWqFQlpJnpuZcJ1vARIssyRkt2ZHQrjrqMmNXXrymYPLdP3UqcV
        syqV7jtb0yiH3r8A8h0yxAHyN5L6RLqnHvD+em/3Nw==
X-Google-Smtp-Source: APXvYqxU1bO55XCmlZLBDVH2y1S8uFyVky5JIP8map2b8dUYRhMu18trOmjE/aFqdhps6L2iqh/DxhB2Gx3nHn6tq0g=
X-Received: by 2002:a37:9186:: with SMTP id t128mr24986019qkd.180.1580776851921;
 Mon, 03 Feb 2020 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20200124231834.63628-1-pmalani@chromium.org> <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
 <20200127184439.GA150048@google.com> <CACeCKafdroLXf62aHeP8CZPuiR02EEmKAGmhHczzoSyX0bFv5g@mail.gmail.com>
 <dc1fec43-1bb0-53de-af17-a91fea42a3f5@collabora.com> <CANLzEks0+J9qvAk_rw2_1r74twnonXmPGdCpY3w2nY8xYPAYLw@mail.gmail.com>
In-Reply-To: <CANLzEks0+J9qvAk_rw2_1r74twnonXmPGdCpY3w2nY8xYPAYLw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 16:40:40 -0800
Message-ID: <CACeCKafOhUXcqE6jyaijuFr0V5UtXU8h09RQ=HjV0mE9ar1jWg@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
To:     Benson Leung <bleung@google.com>
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

On Mon, Feb 3, 2020 at 3:42 PM Benson Leung <bleung@google.com> wrote:
>
> Hi Enric, Hi Prashant,
>
> On Wed, Jan 29, 2020 at 12:37 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > >> I'm OK with creating a branch for this series and merging it into
> > >> chrome-platform-5.7 once Linus releases v5.6-rc1 late next week.
> > > Thanks; I'm guessing one of the maintainers will perform the creation
> > > of chrome-platform-5.7 and merge this patch into that branch.
> > > Also, kindly pick https://lkml.org/lkml/2020/1/24/2068 , i.e patch 4/4
> > > of this series (I think an earlier version of this patch, i.e
> > > https://lkml.org/lkml/2020/1/17/628 was marked "Reviewed-by: Sebastian
> > > Reichel <sebastian.reichel@collabora.com>"
> > >
> >
> > That patch should go through Sebastian's tree, we will create an immutable
> > branch for him when rc1 is released.
> >
>
> Before rc1 is released, I've gone ahead and created a staging branch
> on chrome-platform collaboration repo here:
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=staging-cros-usbpd-notify
>
> Here are the two commits I have right now:
> e8573ca91ae4 power: supply: cros-ec-usbpd-charger: Fix host events
> a49c1263a22b platform: chrome: Add cros-usbpd-notify driver
>
> Enric, I went ahead and modified the Kconfig on the first patch to
> depend on MFD_CROS_EC_DEV and default it as well.
> Prashant, let me know how these look to you. We can convert the branch
> to an immutable next week.
Thanks Benson, looks good to me.

>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
