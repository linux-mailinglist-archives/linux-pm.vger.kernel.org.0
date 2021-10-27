Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E843D157
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 21:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhJ0TDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 15:03:16 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35718 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbhJ0TDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 15:03:11 -0400
Received: by mail-ot1-f44.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so5057077ott.2;
        Wed, 27 Oct 2021 12:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twYyXM54JZtknY6kSlEQB2YIbHREslZxx1VWjQb9rKA=;
        b=K5USj36N/xFW8pCr+3ry3/T7CI2ZI5jI/yDViD6+veeV7vRxI8d0iW5al0Wjnn/KfH
         rdB25lF2DZ5jbBvgAoFTPEdHCArGVS6LAJEf44lfd0uNihmC4OLr9RwesfFSvjhJwvHC
         89yxS9S0FSWmhkOFFfZZtAJFZ68hYbgshebuhH9w5iHk9h2y8d6cAbOFpdoIndoO9FBJ
         bqyo0u5XJNf6S22yAiffMFoKCbqtscL551Ts9v3QOsn1a9KTrlqjRKQdtt8S1FdgMglQ
         IhSck47GjHkersVHMbi5Sso2TeK9f4IJkhz9W/Yex9F4avDa+PeRsYNZ6yYsSR9PYfa1
         fSvw==
X-Gm-Message-State: AOAM533nYQHOWGxaotOAm1NoCPF2gKqsjjnB1fxgMmFtNRcWHZsArsBs
        RXenxJF+yaU4fUWzbABrmzVFYAp52gy9mZwc0gE=
X-Google-Smtp-Source: ABdhPJxwyoNvTjXEvWSwEzQkvS3twTW+fZkOH2aK+Tp8JKa7djpi/yo4glrydaOg6ed57ahTO8qmsT3UR7s8ZIDHGmY=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr25814378otd.16.1635361244953;
 Wed, 27 Oct 2021 12:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211025070155.2995-1-chunfeng.yun@mediatek.com>
 <CAJZ5v0gb6vN9kHeQbgjRQXvOCNaFK8ur7bLDeAVjDqdT2=a+-g@mail.gmail.com> <fba3246fbc600f06eb40e90283c1cd51bc259804.camel@mediatek.com>
In-Reply-To: <fba3246fbc600f06eb40e90283c1cd51bc259804.camel@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 21:00:34 +0200
Message-ID: <CAJZ5v0hnrr+ZidUMkN837utcKc6otmqaZ+uTX_xMukTUrdHLDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PM / wakeirq: support enabling wake-up irq after
 runtime_suspend called
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 11:34 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Tue, 2021-10-26 at 17:39 +0200, Rafael J. Wysocki wrote:
> > On Mon, Oct 25, 2021 at 9:02 AM Chunfeng Yun <
> > chunfeng.yun@mediatek.com> wrote:
> > >
> > > When the dedicated wake IRQ is level trigger, and it uses the
> > > device's low-power status as the wakeup source, that means if the
> > > device is not in low-power state, the wake IRQ will be triggered
> > > if enabled; For this case, need enable the wake IRQ after running
> > > the device's ->runtime_suspend() which make it enter low-power
> > > state.
> > >
> > > e.g.
> > > Assume the wake IRQ is a low level trigger type, and the wakeup
> > > signal comes from the low-power status of the device.
> > > The wakeup signal is low level at running time (0), and becomes
> > > high level when the device enters low-power state (runtime_suspend
> > > (1) is called), a wakeup event at (2) make the device exit low-
> > > power
> > > state, then the wakeup signal also becomes low level.
> > >
> > >                 ------------------
> > >                |           ^     ^|
> > > ----------------           |     | --------------
> > >  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
> > >
> > > if enable the wake IRQ before running runtime_suspend during (0),
> > > a wake IRQ will arise, it causes resume immediately;
> > > it works if enable wake IRQ ( e.g. at (3) or (4)) after running
> > > ->runtime_suspend().
> > >
> > > This patch introduces a new status WAKE_IRQ_DEDICATED_REVERSE to
> > > optionally support enabling wake IRQ after running
> > > ->runtime_suspend().
> > >
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >
> > I don't really have anything to add regarding the code.
> >
> > The kerneldoc comments could be improved, but I can take care of this
> > when applying the patch.
> Ok, thanks
> >
> > Please collect ACKs for the remaining 2 patches in the series and I
> > will pick up all three.
> The files (mtu3_plat.c, xhci-mtk.c) modified by other 2 patches are
> maintained by myself, please pick up them, thanks a lot.

OK, applied as 5.16 material, thanks!
