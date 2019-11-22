Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB01074E9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVPcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 10:32:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54472 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKVPcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 10:32:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id x26so7599083wmk.4
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f59CCVfdihRZS7ABtJ0WDahBA/Iy5s/bA0O3KEpFY/E=;
        b=Uh2amNqwsPriinB9f10eWW+TPFILFo4KxSfpIEHM3KvBQX7JKAopy83o94uVwpi9IW
         qhOp1EN1DvZvGv36bsfnqdqhq2IlesC/i4qdwh+kLYQxx4gknws+uhGduim+N0rCjD8I
         tj/8vQ+pcNRI9ibch0NgeBojkFdEihVti+2twm4qmohKwPc70aiULFFrQISwdzfiCszm
         ZpJWld7ESjOy1ZGwp0QxRQuCJ5RSrw9M/z7pdcadGwhcWmXe+kI7zgh6Cz232uEIQeMt
         qhPJx/kkCELGnyPoFgaIcjs/WFr3cjEFEL31BPMzux+RvUJ+pice08CYehD09MlRVa+Q
         /lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f59CCVfdihRZS7ABtJ0WDahBA/Iy5s/bA0O3KEpFY/E=;
        b=UgETqslVrQwW9Ff3Cjb8ZMxlJ3H+oBsdZ1G92UlJHLEOCXqXJAX1EatN0Hm9KNYRKd
         4nYZ5BhGrAKqUfjRPotDX+5VokpBqH0q2+HDSJQ9IXhss7RAW6uNKoEHp8bDVFCD8aMM
         EmTSvGVBUtoxWrsShiDSdlnNlYzYj5Y12uFccOsUsZzZKDfIZWZysSJiwX8dyjR3H9hm
         1DrzVEuis0EzYpyvqOGGYs1T747DmRpve0RxpSTpBbo8699iDjDLq1v3IXCjQ0LKFO+Y
         kqrd9K6hjRdM0XTGd19FEsJU+tTj5cbRxFQCVVIwSw9ypfJEKlKe/ukByoX9eKgoDXSL
         TI6A==
X-Gm-Message-State: APjAAAUhg5t8MgQ1N9vFkC+XIocd26XdStZCivjBzWWoMv6KuF6Bi4g/
        hjsbj6oXSM197V75ND+gi9z7lOK/nO61cMtmF+8=
X-Google-Smtp-Source: APXvYqxkvzqFIGq5vSlIDYpnyQujQVYMTlOWzqVWoKNhRKOEL0jWqVRBLWBWMeYtS4PPpcgTyBhHJdbdAFBDmoy33+g=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr17022781wml.102.1574436730664;
 Fri, 22 Nov 2019 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
In-Reply-To: <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Nov 2019 10:31:58 -0500
Message-ID: <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 3:24 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Wed, Oct 16, 2019 at 2:43 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > Is s2idle actually powering down the GPU?
>
> My understanding is that s2idle (at a high level) just calls all
> devices suspend routines and then puts the CPU into its deepest
> running state.
> So if there is something special to be done to power off the GPU, I
> believe that amdgpu is responsible for making arrangements for that to
> happen.
> In this case the amdgpu code already does:
>
>         pci_disable_device(dev->pdev);
>         pci_set_power_state(dev->pdev, PCI_D3hot);
>
> And the PCI layer will call through to any appropriate ACPI methods
> related to that low power state.
>
> > Do you see a difference in power usage?  I think you are just working around the fact that the
> > GPU never actually gets powered down.
>
> I ran a series of experiments.
>
> Base setup: no UI running, ran "setterm -powersave 1; setterm -blank
> 1" and waited 1 minute for screen to turn off.
> Base power usage in this state is 4.7W as reported by BAT0/power_now
>
> 1. Run amdgpu_device_suspend(ddev, true, true); before my change
> --> Power usage increases to 6.1W
>
> 2. Run amdgpu_device_suspend(ddev, true, true); with my change applied
> --> Power usage increases to 6.0W
>
> 3. Put amdgpu device in runtime suspend
> --> Power usage increases to 6.2W
>
> 4. Try unmodified suspend path but d3cold instead of d3hot
> --> Power usage increases to 6.1W
>
> So, all of the suspend schemes actually increase the power usage by
> roughly the same amount, reset or not, with and without my patch :/
> Any ideas?

Do these patches help?
https://patchwork.freedesktop.org/patch/341775/
https://patchwork.freedesktop.org/patch/341968/

Alex

>
> Thanks,
> Daniel
