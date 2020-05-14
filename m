Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D971D38CB
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgENSFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 14:05:39 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60540 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 14:05:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5DF20803089C;
        Thu, 14 May 2020 18:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W3Xv057Q_gie; Thu, 14 May 2020 21:05:32 +0300 (MSK)
Date:   Thu, 14 May 2020 21:05:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 02/20] dt-bindings: bus: Add MIPS CDMM controller
Message-ID: <20200514180532.3lg2476qtdfaxmoa@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-3-Sergey.Semin@baikalelectronics.ru>
 <20200514150943.GA30404@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200514150943.GA30404@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 10:09:43AM -0500, Rob Herring wrote:
> On Wed, 6 May 2020 20:42:20 +0300,  wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > It's a Common Device Memory Map controller embedded into the MIPS IP
> > cores, which dts node is supposed to have compatible and reg properties.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v2:
> > - Lowercase the example hex'es.
> > ---
> >  .../bindings/bus/mti,mips-cdmm.yaml           | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/mti,mips-cdmm.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Great! Thanks.

-Sergey
