Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDC11BDB1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLKUMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:12:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37674 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKUMH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:12:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so20552659edb.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 12:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3M5Fud8kZlxBERQgQ5pLqsW1xJISN6Eh/zfvWG18ntY=;
        b=Nm5l3Ck3dtONtgXmMx3028yxkYfjn5E+7EQDuUYstl2zM4t7BvuOF4bEUKBqBvjnBI
         lYeV5t7Wc7CH/osJtJu8iHJq0c24a7kqSEzm5ojFfMaQ5cBO+1r0Zatjf7ICdpcBcg6v
         UKskqUCpaTc880p3ngXX6FJr1xJ1EeAgpHCD5uXa+SfpgXVl8ENzqvs3LOTRqijw/v7U
         dlFMC2sRzIwfYU4I5FsDJyVEDh9ZNe1hkByxGxBeDBC1yx62cYs1gjbiWpFhIztoh0FY
         Fxg2chcdBsk0eGO4Y80N9ZDhLRCFrLXd4L+DKte5i7o023shy80nXNBUUpsc51LehfVi
         Xdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3M5Fud8kZlxBERQgQ5pLqsW1xJISN6Eh/zfvWG18ntY=;
        b=uQm20QJww9161Ks1bS6xIWjsnJT36Vkdi1zzqbkd24W55SxlNH6mxevS2m41oHV9dE
         S9ZajRI3go6ac/cSbdxS1uYTPVatcDC5SC5uwHB5QScJ6RUrLcmqBFUSI3cugDKxZvaK
         O82AKFZmEmvlIpNhzEe69IvqikzbWPF6RfsB724oLRO6f4NKUTrGislceWHBVx6R7tXH
         +UJyXAyRaFST0a1RW7txp4ORCuom2v8dj5y0ny+sv7hrJ6KNXq3VcnvJvhDkasBgfMCh
         gg5y68kX5Lr5enorV2cHF87YQ4eXeGijueY8e+tLefi1QPGVlHvMpIcG4yttAyo1Ln2K
         1cew==
X-Gm-Message-State: APjAAAWHhohDVFSDXMbzWuYcBYpp06NI819iyAawqOMoJ/1KxHey4+FS
        325Yo79bNzhfySUDxQJ0OjGf6znbBvhQ+Gwzb6b7uQ==
X-Google-Smtp-Source: APXvYqwHVc/7wc0HTazG7NDPfucduFrEbWz67kTdVMZjGJsbv8PdAp0X5DexipoHVNZbNu7tBikK3ar/QVCJGWUubX4=
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr5241097ejb.320.1576095124739;
 Wed, 11 Dec 2019 12:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org> <20191211085400.GB500800@kroah.com>
In-Reply-To: <20191211085400.GB500800@kroah.com>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 11 Dec 2019 12:11:53 -0800
Message-ID: <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 12:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> > On 10/12/2019 21:01, Wei Wang wrote:
> > > On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 05/12/2019 08:19, Wei Wang wrote:
> > >>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > >>> numbers are subject to change due to device tree change. This usually
> > >>> leads to tree traversal in userspace code.
>
> tree traversal is supposed to be done in userspace code :)
>
Yes, that can be done in userspace, but given the amount of thermal
zones we have in some mobile devices, this will bring a lot of
convenience.

e.g. this is on Pixel 4 XL:
coral:/ # ls  /sys/devices/virtual/thermal/
cdev-by-name      cooling_device15  cooling_device22  cooling_device3
 cooling_device9  thermal_zone15  thermal_zone22  thermal_zone3
thermal_zone37  thermal_zone44  thermal_zone51  thermal_zone59
thermal_zone66  thermal_zone73  thermal_zone80  thermal_zone88
cooling_device0   cooling_device16  cooling_device23  cooling_device30
 thermal_zone0    thermal_zone16  thermal_zone23  thermal_zone30
thermal_zone38  thermal_zone45  thermal_zone52  thermal_zone6
thermal_zone67  thermal_zone74  thermal_zone81  thermal_zone9
cooling_device1   cooling_device17  cooling_device24  cooling_device31
 thermal_zone1    thermal_zone17  thermal_zone24  thermal_zone31
thermal_zone39  thermal_zone46  thermal_zone53  thermal_zone60
thermal_zone68  thermal_zone75  thermal_zone82  tz-by-name
cooling_device10  cooling_device18  cooling_device25  cooling_device4
 thermal_zone10   thermal_zone18  thermal_zone25  thermal_zone32
thermal_zone4   thermal_zone47  thermal_zone54  thermal_zone61
thermal_zone69  thermal_zone76  thermal_zone83
cooling_device11  cooling_device19  cooling_device26  cooling_device5
 thermal_zone11   thermal_zone19  thermal_zone26  thermal_zone33
thermal_zone40  thermal_zone48  thermal_zone55  thermal_zone62
thermal_zone7   thermal_zone77  thermal_zone84
cooling_device12  cooling_device2   cooling_device27  cooling_device6
 thermal_zone12   thermal_zone2   thermal_zone27  thermal_zone34
thermal_zone41  thermal_zone49  thermal_zone56  thermal_zone63
thermal_zone70  thermal_zone78  thermal_zone85
cooling_device13  cooling_device20  cooling_device28  cooling_device7
 thermal_zone13   thermal_zone20  thermal_zone28  thermal_zone35
thermal_zone42  thermal_zone5   thermal_zone57  thermal_zone64
thermal_zone71  thermal_zone79  thermal_zone86
cooling_device14  cooling_device21  cooling_device29  cooling_device8
 thermal_zone14   thermal_zone21  thermal_zone29  thermal_zone36
thermal_zone43  thermal_zone50  thermal_zone58  thermal_zone65
thermal_zone72  thermal_zone8   thermal_zone87


> But what userspace code needs to do this, and for what?
In Android, thermal daemon and thermal HAL as well as some init.rc
script would use those thermal paths for managing and monitoring
thermal. The daemon/HAL could have logic pipled in, however Android's
init.rc script would be really tricky.
On a related note, we also create /dev/block/by-name links from userspace.

Thanks!
-Wei
>
> thanks,
>
> greg k-h
