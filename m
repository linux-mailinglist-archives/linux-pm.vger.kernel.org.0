Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A63594C6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIFjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 01:39:37 -0400
Received: from muru.com ([72.249.23.125]:52494 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Apr 2021 01:39:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1BF1C80E7;
        Fri,  9 Apr 2021 05:40:32 +0000 (UTC)
Date:   Fri, 9 Apr 2021 08:39:18 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
Message-ID: <YG/ohhh3Tyet6InQ@atomide.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
 <CAJZ5v0gGntbfnvAP5A491_hUh-JUuqZjZRdPPLwWJjnZRtemcQ@mail.gmail.com>
 <1617933211.12105.22.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617933211.12105.22.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Chunfeng Yun <chunfeng.yun@mediatek.com> [210409 01:54]:
> On Thu, 2021-04-08 at 19:41 +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 11:35 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > When the dedicated wake irq is level trigger, enable it before
> > > calling runtime_suspend, will trigger an interrupt.
> > >
> > > e.g.
> > > for a low level trigger type, it's low level at running time (0),
> > > and becomes high level when enters suspend (runtime_suspend (1) is
> > > called), a wakeup signal at (2) make it become low level, wake irq
> > > will be triggered.
> > >
> > >                 ------------------
> > >                |           ^     ^|
> > > ----------------           |     | --------------
> > >  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
> > >
> > > if we enable the wake irq before calling runtime_suspend during (0),
> > > an interrupt will arise, it causes resume immediately;
> > 
> > But that's necessary to avoid missing a wakeup interrupt, isn't it?
> That's also what I worry about.

Yeah sounds like this patch will lead into missed wakeirqs.

Regards,

Tony
