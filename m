Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0063D1D38C8
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENSEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 14:04:31 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60514 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 14:04:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 576888030791;
        Thu, 14 May 2020 18:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4lfwjg7AzaIW; Thu, 14 May 2020 21:04:23 +0300 (MSK)
Date:   Thu, 14 May 2020 21:04:22 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        <devicetree@vger.kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        <linux-mips@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 01/20] dt-bindings: power: Convert mti,mips-cpc to DT
 schema
Message-ID: <20200514180422.4ofoaviqh6o2eaug@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-2-Sergey.Semin@baikalelectronics.ru>
 <20200514150903.GA28744@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200514150903.GA28744@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 10:09:03AM -0500, Rob Herring wrote:
> On Wed, 6 May 2020 20:42:19 +0300,  wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > It's a Cluster Power Controller embedded into the MIPS IP cores.
> > Currently the corresponding dts node is supposed to have compatible
> > and reg properties.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-pm@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v2:
> > - Reword the changelog summary - use shorter version.
> > - Lowercase the example hex'es.
> > ---
> >  .../bindings/power/mti,mips-cpc.txt           |  8 -----
> >  .../bindings/power/mti,mips-cpc.yaml          | 35 +++++++++++++++++++
> >  2 files changed, 35 insertions(+), 8 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Great! Thanks.

-Sergey
