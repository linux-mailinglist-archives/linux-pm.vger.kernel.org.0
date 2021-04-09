Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F1359CE9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhDILPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 07:15:05 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39707 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhDILPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 07:15:05 -0400
Received: by mail-oi1-f173.google.com with SMTP id i81so5384636oif.6;
        Fri, 09 Apr 2021 04:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rxjs0bOzud5jPgrtCrFonjn8TrOn+6BSTDUNWNa5VkA=;
        b=XeF9AXNlN/rmxxhZVdABNMCYq13Y2K8LaepjVmT0/dzS+ckWkUZZPeYlO+KpSK87uA
         yW7uWVnJxOGAaPu4JZpBF7tPYEALKyzLOIVjW7Dtk6aCcy+AqHfTKCriG0wUoteS3OqW
         ws/yyVXuwrTUsrvTutwu5x9qYxa0UUJP+HdQ7h/VuhRLOxTlKeRsSwq8noF+AysM9jI4
         csswg75J51YUijgFeZqvCARUHqLP8gXMJgeP76WxbJL43utgxjV0466kxIUZ570aakRi
         L7FXcJnkbwIrOjToAf39q6Y2rvNMTLdZem2SO+n4vZdVUhFSrtNIgorEmBig1XKDYvFu
         WZcw==
X-Gm-Message-State: AOAM531f67wHBDbcDgsGY+sj3/PKGVvFE2+8Ve4q19njXS3MYnJUThV/
        Z1lQC8kc3smMupehTD/dkTB4Z/Zlemvuy3THo64=
X-Google-Smtp-Source: ABdhPJzqQwV2RLtxpvy3bdjEZbTiGwM6R2VqAkJLIvDpOTRgfz1/jDCWilo+43fl261e+3ylK2QTCgBnzn1M84H/KAA=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr9286785oib.69.1617966892336;
 Fri, 09 Apr 2021 04:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
 <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
 <1617933211.12105.22.camel@mhfsdcap03> <YG/ohhh3Tyet6InQ@atomide.com> <1617957362.12105.27.camel@mhfsdcap03>
In-Reply-To: <1617957362.12105.27.camel@mhfsdcap03>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Apr 2021 13:14:40 +0200
Message-ID: <CAJZ5v0ioobLt5aEm8TAcPKgJiL13OJ7KqTeJmcQCuVp8ALxBmw@mail.gmail.com>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 9, 2021 at 10:36 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Fri, 2021-04-09 at 08:39 +0300, Tony Lindgren wrote:
> > * Chunfeng Yun <chunfeng.yun@mediatek.com> [210409 01:54]:
> > > On Thu, 2021-04-08 at 19:41 +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Apr 8, 2021 at 11:35 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > > > >
> > > > > When the dedicated wake irq is level trigger, enable it before
> > > > > calling runtime_suspend, will trigger an interrupt.
> > > > >
> > > > > e.g.
> > > > > for a low level trigger type, it's low level at running time (0),
> > > > > and becomes high level when enters suspend (runtime_suspend (1) is
> > > > > called), a wakeup signal at (2) make it become low level, wake irq
> > > > > will be triggered.
> > > > >
> > > > >                 ------------------
> > > > >                |           ^     ^|
> > > > > ----------------           |     | --------------
> > > > >  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
> > > > >
> > > > > if we enable the wake irq before calling runtime_suspend during (0),
> > > > > an interrupt will arise, it causes resume immediately;
> > > >
> > > > But that's necessary to avoid missing a wakeup interrupt, isn't it?
> > > That's also what I worry about.
> >
> > Yeah sounds like this patch will lead into missed wakeirqs.
> If miss level trigger wakeirqs, that means HW doesn't latch it? is it HW
> limitation?

If it's level-triggered, it won't be missed, but then it is just
pointless to suspend the device when wakeup is being signaled in the
first place.

I'm not sure if I understand the underlying problem correctly.  Is it
about addressing spurious wakeups?
