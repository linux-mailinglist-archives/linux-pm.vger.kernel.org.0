Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343D1C9D80
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEGVie (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:38:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38696 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEGVie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 17:38:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 704A680307C1;
        Thu,  7 May 2020 21:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bsl9EF3_yS18; Fri,  8 May 2020 00:38:30 +0300 (MSK)
Date:   Fri, 8 May 2020 00:38:29 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/20] mips: cm: Add L2 ECC/parity errors reporting
Message-ID: <20200507213829.ro7vxasi3k3t3yga@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-6-Sergey.Semin@baikalelectronics.ru>
 <20200507111753.GG11616@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200507111753.GG11616@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 01:17:53PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:23PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > According to the MIPS32 InterAptiv software manual error codes 24 - 26
> > of CM2 indicate L2 ECC/parity error with switching to a corresponding
> > errors info fields. This patch provides these errors parsing code,
> > which handles the read/write uncorrectable and correctable ECC/parity
> > errors, and prints instruction causing the fault, RAM array type, cache
> > way/dword and syndrome associated with the faulty data.
> > 
> > Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/kernel/mips-cm.c | 62 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 60 insertions(+), 2 deletions(-)
> 
> applied to mips-next.

Great! Thanks.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
