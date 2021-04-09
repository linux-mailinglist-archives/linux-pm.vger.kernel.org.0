Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136C53594D4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 07:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDIFm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 01:42:26 -0400
Received: from muru.com ([72.249.23.125]:52520 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233308AbhDIFky (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Apr 2021 01:40:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1890D818C;
        Fri,  9 Apr 2021 05:41:50 +0000 (UTC)
Date:   Fri, 9 Apr 2021 08:40:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend
 hook called
Message-ID: <YG/o1ERNkcaYAV9y@atomide.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
 <CAATdQgCQ5Gm1CNEbVgLFiFcgDX0yP5G=48Fa29WYbpSuz25WXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATdQgCQ5Gm1CNEbVgLFiFcgDX0yP5G=48Fa29WYbpSuz25WXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Ikjoon Jang <ikjn@chromium.org> [210409 05:33]:
> Hi Chunfeng,
> 
> On Thu, Apr 8, 2021 at 5:35 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > When the dedicated wake irq is level trigger, enable it before
> > calling runtime_suspend, will trigger an interrupt.
> >
> > e.g.
> > for a low level trigger type, it's low level at running time (0),
> > and becomes high level when enters suspend (runtime_suspend (1) is
> > called), a wakeup signal at (2) make it become low level, wake irq
> > will be triggered.
> >
> >                 ------------------
> >                |           ^     ^|
> > ----------------           |     | --------------
> >  |<---(0)--->|<--(1)--|   (3)   (2)    (4)
> >
> 
> Can't we just use a falling edge type for this irq line?

Sounds reasonable to me :)

Tony
