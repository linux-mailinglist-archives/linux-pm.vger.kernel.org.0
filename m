Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E241C9D47
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGVc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:32:28 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38628 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGVc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 17:32:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7CEDE803087C;
        Thu,  7 May 2020 21:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fl9KsNoMQI8f; Fri,  8 May 2020 00:32:24 +0300 (MSK)
Date:   Fri, 8 May 2020 00:32:22 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/20] mips: cm: Fix an invalid error code of
 INTVN_*_ERR
Message-ID: <20200507213222.ju3qeb27ml22omej@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-5-Sergey.Semin@baikalelectronics.ru>
 <20200507111007.GE11616@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200507111007.GE11616@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 01:10:07PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:22PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
> > errors") adds cm2_causes[] array with map of error type ID and
> > pointers to the short description string. There is a mistake in
> > the table, since according to MIPS32 manual CM2_ERROR_TYPE = {17,18}
> > correspond to INTVN_WR_ERR and INTVN_RD_ERR, while the table
> > claims they have {0x17,0x18} codes. This is obviously hex-dec
> > copy-paste bug. Moreover codes {0x18 - 0x1a} indicate L2 ECC errors.
> > 
> > Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/kernel/mips-cm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
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
