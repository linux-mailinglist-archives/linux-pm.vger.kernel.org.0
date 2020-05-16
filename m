Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A91D6149
	for <lists+linux-pm@lfdr.de>; Sat, 16 May 2020 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEPN0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 May 2020 09:26:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40142 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgEPN0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 May 2020 09:26:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 33EAE8030791;
        Sat, 16 May 2020 13:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dj6AGkqSPpUY; Sat, 16 May 2020 16:26:01 +0300 (MSK)
Date:   Sat, 16 May 2020 16:26:00 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: reset: Unrequire regmap
 property in syscon-reboot node
Message-ID: <20200516132600.aloxet3n4373nz6e@mobilestation>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
 <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
 <20200507233846.11548-3-Sergey.Semin@baikalelectronics.ru>
 <20200515031449.GA32456@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515031449.GA32456@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 10:14:49PM -0500, Rob Herring wrote:
> On Fri, 8 May 2020 02:38:45 +0300, Serge Semin wrote:
> > Since normally syscon-reboot block is supposed to be a part of a system
> > controller, lets mark the regmap property as deprecated and recommend the
> > syscon-reboot node to be a sub-node of SYSCON.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Allison Randal <allison@lohutok.net>
> > Cc: Richard Fontana <rfontana@redhat.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v2:
> > - This is a new patch created as a result of the discussion:
> >   https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/
> > ---
> >  .../bindings/power/reset/syscon-reboot.yaml       | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Great. Thanks!

Sebastian, Rob is ok with the change. Could you take a look at the next patch?

-Sergey
