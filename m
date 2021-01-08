Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45E2EF764
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbhAHSbz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 13:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhAHSbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 13:31:55 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C70FC061380;
        Fri,  8 Jan 2021 10:31:15 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 14so9920615ilq.2;
        Fri, 08 Jan 2021 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BlUHgKNMv9YrK7lCvnTL1WUMTl1HZQ3/mwN2WXhlmg=;
        b=eBuRcMONqftbbi1g47dCr74dSvP5KHK0NxWks6LuFs5U/ceuKUhM8C7TgEg93zGZyh
         3PozXU6Xwmh02whV9B4IpgtratvfABpTSl+0QAxFVCPTcY4MV3U5hSkEF0LbgG7dX4e7
         fXkGwWs6wpeLnNZDgmZrMNkWVYtBLAKXcA6FkKYJsvnloiuuNIMstwqTKd9Vo+r949PB
         tMqIaY4Y4rcPdKkk9HUk2mRoe12WvmamnGvOg+yCTAfF3WHbpPwa7Pqu1qPqdfyE3NOz
         gaX+RWyj977R8V4Eomsgs4i7LUsKrFye1zwNGN/qXV8RdXBOaHZBlFtnwXHoHgvlWrKN
         wKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BlUHgKNMv9YrK7lCvnTL1WUMTl1HZQ3/mwN2WXhlmg=;
        b=okRHkhve+pJPMZMYb0HlAXVC+N0K1G9bxacm0BW7QyAbWVxmr6uyEzL1LfOrckD1zP
         cuOVJ7SSCyvnNQuF+RTvLr4Y46KE6FVQKydnm23kCAOmk7HLlHdCwm6SHdilh8Z6eL1d
         ImKQVvdj4aN1BNBCg7zMb+X76yoCEN+1Y3D3lL8QmkbCF2XO9ONwGIBqkBeSTdLyM3c5
         6nvcXkVtZ6aC1p6Ac0cYEycvqzT45Rfo2vOV+3t4bE+wu3pwYVL0XEyA4bFHdsefi+0b
         xWh8RrHDpBthvooScayc0qpxoMw/pyMfgeisUArcGB12N7bJ5ejVIJ3tHvWJswu0odVH
         CcNA==
X-Gm-Message-State: AOAM5318Cbjwt6C1WjObTO3e3FR4o8B+c/mhX9Q8MzVgN1Ff+PkJr+CC
        sQqWQMjstJ76VHR21Em7bXFv1TupbghIQYuD8UA=
X-Google-Smtp-Source: ABdhPJyaB63aeNgGOu91EjPTl74K2uAq232U11RiWXlAr5bmFX5ceNPhRX30fIoB8pL8iCXjV2BkFwdQ4Oui1BpHm8E=
X-Received: by 2002:a92:c081:: with SMTP id h1mr4942286ile.46.1610130674387;
 Fri, 08 Jan 2021 10:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20201230084338.19410-1-tony@atomide.com> <CAHCN7xJmwcUOpoza-LNxTAbRNb9ToERnBNuKboP86DSBdtS61A@mail.gmail.com>
 <7C9106E0-FC75-4056-AD5F-16CCFA9C24E5@goldelico.com> <X/gIO9Ta3JPDaeV3@atomide.com>
 <CAHCN7xKzeqabm5YJbNS_jcENnhxdU9tAuhWZv81xJA7VbaW6NA@mail.gmail.com>
In-Reply-To: <CAHCN7xKzeqabm5YJbNS_jcENnhxdU9tAuhWZv81xJA7VbaW6NA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Jan 2021 12:31:03 -0600
Message-ID: <CAHCN7xJNk=2_Kx4XS3asxcxVGZXaTZgmCkpoFGFHdOQuM3aKCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Fix stuck sensor with
 continuous mode for 4430
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 8, 2021 at 7:45 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 1:22 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * H. Nikolaus Schaller <hns@goldelico.com> [201230 13:29]:
> > > > Am 30.12.2020 um 13:55 schrieb Adam Ford <aford173@gmail.com>:
> > > > On Wed, Dec 30, 2020 at 2:43 AM Tony Lindgren <tony@atomide.com> wrote:
> > > >>
> > > >> At least for 4430, trying to use the single conversion mode eventually
> > > >> hangs the thermal sensor. This can be quite easily seen with errors:
> > > >>
> > > >> thermal thermal_zone0: failed to read out thermal zone (-5)
> > ...
> >
> > > > I don't have an OMAP4, but if you want, I can test a DM3730.
> > >
> > > Indeed I remember a similar discussion from the DM3730 [1]. temp values were
> > > always those from the last measurement. E.g. the first one was done
> > > during (cold) boot and the first request after 10 minutes did show a
> > > quite cold system... The next one did show a hot system independent
> > > of what had been between (suspend or high activity).
> > >
> > > It seems as if it was even reproducible with a very old kernel on a BeagleBoard.
> > > So it is quite fundamental.
> > >
> > > We tried to fix it but did not come to a solution [2]. So we opened an issue
> > > in our tracker [3] and decided to stay with continuous conversion although this
> > > raises idle mode processor load.
> >
> > Hmm so maybe eocz high always times out in single mode since it also
> > triggers at least on dra7?
> >
> > Yes it would be great if you guys can the $subject patch a try at
> > least on your omap36xx and omap5 boards and see if you see eocz
> > time out warnings in dmesg.
>
> I should be able to try it on the dm3730 logicpd-torpedo kit this weekend.

I am going to be a bit delayed testing this.  I cannot boot omap2plus
using Linux version 5.11.0-rc2.

[    2.666748] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xbc
[    2.673309] nand: Micron MT29F4G16ABBDA3W
[    2.677368] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    2.685119] nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
[    2.693237] Invalid ECC layout
[    2.696350] omap2-nand 30000000.nand: unable to use BCH library
[    2.702575] omap2-nand: probe of 30000000.nand failed with error -22
[    2.716094] 8<--- cut here ---
[    2.719207] Unable to handle kernel NULL pointer dereference at
virtual address 00000018
[    2.727600] pgd = (ptrval)
...
[    3.050933] ---[ end trace 59640c7399a80a07 ]---
[    3.055603] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    3.063323] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

Once I get past this, I'll try to test the thermal stuff.

adam

>
> adam
> >
> > Regards,
> >
> > Tony
