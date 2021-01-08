Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68C2EF855
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 20:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbhAHTmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 14:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhAHTmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 14:42:36 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02432C061381;
        Fri,  8 Jan 2021 11:41:56 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id t8so10881709iov.8;
        Fri, 08 Jan 2021 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSmK740YSdua1TBiaZGc3pU7A4XjUf+hqO+Eu7pIgDI=;
        b=LW6/Fu2oT4YXtfLepXFJm6iCV4xwMhI8o0+4ymU9z0ZZhfz0bHubL5e/n0vVs9C1DD
         OfqvuNTha/IcdyfYhNfDvqYmqp3n/nZhU8nJ/+fDuaqCDIeTiby1x8eZf2wwXGFQr0p5
         S6oNr3FTpIETmHLW+AI56KVw+ZuNKFafn3+YYZs88E5s0281PKCBQ9B8AtzSkoX7lYPn
         PTnfRhFqMHqXYi1UZ0fw38Fs8Rda9m2GwSkmD92yI2xQWz9m4io0dQlsuHKfY6HqfTps
         ZetEqqVa/j94gAns0YWmalgVswJErJaqZ1fX92ES0o+PJClXex8JBYGrkYwdUiAGBItN
         tUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSmK740YSdua1TBiaZGc3pU7A4XjUf+hqO+Eu7pIgDI=;
        b=awma8rxQWEy46NL4IuEzt+c5O9N590ZA9nOHRRBSDvCA6iYuLM15VGSLdK/QmKj/yP
         3gKzyazhzLkGaZOURIEr2WNv+T06QL6Qouz8JLkw3A3HH+wC36qQOz/+2hj8tz0b80h4
         PscU2Qujoi4IhSA7EHNUC5T3t1M/u5uU253ObT7wt13pUIbGvjSQS8ZKQl/h/n2e8NDC
         jnYzS6o4xHVWCgjdn8kvw878hizfohO61RAioZgxBOBs+kfV5XJk/WjQ0ei05z85lcz0
         +glgjClUMRT3FBzgU6GYyLqtqzd3YVtIit5Qu4jfLbs5boRqKQCgGyoPWlQDxLQIL7RR
         9vXQ==
X-Gm-Message-State: AOAM531XAzEqbgaQSIHVxZIcyVGo8Vfy5c/ViA877PNhPPL8VtcNDkjG
        iGgcWSfYDVBQl5h2obpOM+5lXKYWBtabNJRBr00=
X-Google-Smtp-Source: ABdhPJwq1Rd1SbLe6o1CWs/FYa17fyAKdBlHca8n7J8SjDNBccWpz4vD4mILV6JXy3UkMSr+b1ePjmNtmW5XC/q8MZ0=
X-Received: by 2002:a05:6638:296:: with SMTP id c22mr4786311jaq.65.1610134915220;
 Fri, 08 Jan 2021 11:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20201230084338.19410-1-tony@atomide.com> <CAHCN7xJmwcUOpoza-LNxTAbRNb9ToERnBNuKboP86DSBdtS61A@mail.gmail.com>
 <7C9106E0-FC75-4056-AD5F-16CCFA9C24E5@goldelico.com> <X/gIO9Ta3JPDaeV3@atomide.com>
 <CAHCN7xKzeqabm5YJbNS_jcENnhxdU9tAuhWZv81xJA7VbaW6NA@mail.gmail.com> <CAHCN7xJNk=2_Kx4XS3asxcxVGZXaTZgmCkpoFGFHdOQuM3aKCQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJNk=2_Kx4XS3asxcxVGZXaTZgmCkpoFGFHdOQuM3aKCQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Jan 2021 13:41:44 -0600
Message-ID: <CAHCN7xJkA1yi_AM-VjmsVC-cRCF4HX7byP2K1vUHAmDuiGAH_A@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 12:31 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 7:45 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 1:22 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * H. Nikolaus Schaller <hns@goldelico.com> [201230 13:29]:
> > > > > Am 30.12.2020 um 13:55 schrieb Adam Ford <aford173@gmail.com>:
> > > > > On Wed, Dec 30, 2020 at 2:43 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > >>
> > > > >> At least for 4430, trying to use the single conversion mode eventually
> > > > >> hangs the thermal sensor. This can be quite easily seen with errors:
> > > > >>
> > > > >> thermal thermal_zone0: failed to read out thermal zone (-5)
> > > ...
> > >
> > > > > I don't have an OMAP4, but if you want, I can test a DM3730.
> > > >
> > > > Indeed I remember a similar discussion from the DM3730 [1]. temp values were
> > > > always those from the last measurement. E.g. the first one was done
> > > > during (cold) boot and the first request after 10 minutes did show a
> > > > quite cold system... The next one did show a hot system independent
> > > > of what had been between (suspend or high activity).
> > > >
> > > > It seems as if it was even reproducible with a very old kernel on a BeagleBoard.
> > > > So it is quite fundamental.
> > > >
> > > > We tried to fix it but did not come to a solution [2]. So we opened an issue
> > > > in our tracker [3] and decided to stay with continuous conversion although this
> > > > raises idle mode processor load.
> > >
> > > Hmm so maybe eocz high always times out in single mode since it also
> > > triggers at least on dra7?
> > >
> > > Yes it would be great if you guys can the $subject patch a try at
> > > least on your omap36xx and omap5 boards and see if you see eocz
> > > time out warnings in dmesg.


I do see chatter.

[   15.531005] ti-soc-thermal 48002524.bandgap: eocz timed out waiting low
[   16.571075] ti-soc-thermal 48002524.bandgap: eocz timed out waiting low
[   17.610961] ti-soc-thermal 48002524.bandgap: eocz timed out waiting low

and it repeats quite often.

I would say this patch series would cause a regression on the DM3730.

adam


> >
> > I should be able to try it on the dm3730 logicpd-torpedo kit this weekend.
>
> I am going to be a bit delayed testing this.  I cannot boot omap2plus
> using Linux version 5.11.0-rc2.
>
> [    2.666748] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xbc
> [    2.673309] nand: Micron MT29F4G16ABBDA3W
> [    2.677368] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 64
> [    2.685119] nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
> [    2.693237] Invalid ECC layout
> [    2.696350] omap2-nand 30000000.nand: unable to use BCH library
> [    2.702575] omap2-nand: probe of 30000000.nand failed with error -22
> [    2.716094] 8<--- cut here ---
> [    2.719207] Unable to handle kernel NULL pointer dereference at
> virtual address 00000018
> [    2.727600] pgd = (ptrval)
> ...
> [    3.050933] ---[ end trace 59640c7399a80a07 ]---
> [    3.055603] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    3.063323] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> Once I get past this, I'll try to test the thermal stuff.
>
> adam
>
> >
> > adam
> > >
> > > Regards,
> > >
> > > Tony
