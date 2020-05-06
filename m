Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A11C7AC1
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgEFTww (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 15:52:52 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33548 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFTww (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 15:52:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0533F8030808;
        Wed,  6 May 2020 19:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id boAYS9ab8GRM; Wed,  6 May 2020 22:52:47 +0300 (MSK)
Date:   Wed, 6 May 2020 22:52:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/20] mips: Use offset-sized IO-mem accessors in CPS
 debug printout
Message-ID: <20200506195246.noammz7zdt4d6gb4@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-15-Sergey.Semin@baikalelectronics.ru>
 <82e98cee-d39e-7df2-8b0d-ac77defd5dd8@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82e98cee-d39e-7df2-8b0d-ac77defd5dd8@cogentembedded.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On Wed, May 06, 2020 at 09:16:24PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 05/06/2020 08:42 PM, Sergey.Semin@baikalelectronics.ru wrote:
> 
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Similar to commit 8e5c62e38a88 ("mips: early_printk_8250: Use offset-sized
> > IO-mem accessors") the IO-memory might require to use a proper load/store
> > instructions (like Bailal-T1 IO-memory). To fix the cps-vec UART debug
> 
>    Baikal? :-)

Yeah, thanks.)

> 
> > printout lets use the memory access instructions in accordance with the
> > UART registers offset config specified at boot time.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > 
> > ---
> > There might be another problem in cps-vec-ns16550.S connected with the
> > difference in CPU/devices endinanness on some platforms. But there is
> 
>    Endianness.

Ah, this won't get into the commit message anyway. But thanks for noticing.)

-Sergey


> 
> > no such for Baikal-T1 SoC.
> [...]
> 
> MBR, Sergei
