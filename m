Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9524EFCE
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgHWVQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 23 Aug 2020 17:16:38 -0400
Received: from mail.v3.sk ([167.172.186.51]:44612 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbgHWVQi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 17:16:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D7991DFAA3;
        Sun, 23 Aug 2020 21:15:34 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n4yfbq_FXlnr; Sun, 23 Aug 2020 21:15:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3A52FDFAA9;
        Sun, 23 Aug 2020 21:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z2QIb2K3RBg1; Sun, 23 Aug 2020 21:15:32 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 00970DFAA3;
        Sun, 23 Aug 2020 21:15:31 +0000 (UTC)
Date:   Sun, 23 Aug 2020 23:16:29 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
Message-ID: <20200823211629.GA240555@demiurge.local>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
 <20200823182050.GA210632@demiurge.local>
 <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Sun, Aug 23, 2020 at 10:31:36PM +0300, Dmitry Osipenko wrote:
> 23.08.2020 21:20, Lubomir Rintel пишет:
> > On Sun, Aug 23, 2020 at 05:08:44PM +0300, Dmitry Osipenko wrote:
> >> The ENE KB930 hardware is compatible with KB3930.
> >>
> >> Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
> >> that is running firmware specifically customized for the needs of the
> >> Acer A500 hardware. This means that firmware interface isn't re-usable
> >> by other non-Acer devices. Some akin models of Acer tablets should be
> >> able to re-use the FW interface of A500 model, like A200 for example.
> >>
> >> This patch adds the new compatibles to the binding.
> > 
> > I've responded to patch 5/6 with what should've been said here [1].
> > Sorry for the confusion.
> > 
> > In any case please consider adding a new binding file instead of
> > modifying the kb3930 binding doc. It would also remove a dependency on
> > my patch set which should have slipped out of maintainers' radar.
> > 
> > [1] https://lore.kernel.org/lkml/20200823180041.GB209852@demiurge.local/
> 
> Hello, Lubomir! I was doing some research about the differences of
> KB3930 and KB930 before created this patch and my understanding is that
> the controllers are mostly identical. I've seen posts from people who
> replaced KB3930 with KB930 (and vice versa) on various notebooks and it
> worked, although not always.
> 
> It's a very common practice to re-use binding in a case of a sibling
> hardware. Do you know what are the exact differences between KB3930 and
> KB930 which could justify having separate bindings?
> 
> The firmware implementation varies a lot from device to device,

It sometimes does. The ENE's downstream driver suggests there are parts
that run more-or-less stock firmware that are comatible with each other.
That is why I grabbed the generic kb3930 name.

> and
> thus, each device needs to have its own driver in order to talk to the
> firmware, but hardware description (i.e. DT binding) should be common
> for all devices.

Note the DT is not the hardware description. It's the description of how
the hardware presents itself, from the software's perspective. As far as
that is concerned, the devices don't seem to have anything in common at
all (other than the bus address). The fact that you need an entirely
different driver implies this.

This would be the case even if the A500 EC was based directly on a KB3930.

A good reason to keep bindings for different yet somewhat similar devices in
a single document is to avoid duplication. Yet here there's very little to
share here. If you've done your bindings correctly, you'd need to
conditionalize the monitored-battery and power-supplies properties for
acer,a500-iconia-ec, complicating the binding too much. It makes more
sense to just add a new document.

Thanks,
Lubo
