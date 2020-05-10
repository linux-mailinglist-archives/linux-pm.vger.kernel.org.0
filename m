Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5791CCE7D
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 00:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgEJWNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 18:13:49 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47580 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgEJWNt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 18:13:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D2DE68030807;
        Sun, 10 May 2020 22:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KXGCpCbzb8BW; Mon, 11 May 2020 01:13:45 +0300 (MSK)
Date:   Mon, 11 May 2020 01:13:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/20] mips: MAAR: Use more precise address mask
Message-ID: <20200510221344.kixpbwy2kcxf62ie@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-12-Sergey.Semin@baikalelectronics.ru>
 <20200507110951.GD11616@alpha.franken.de>
 <20200507191337.la6z476myszqethj@mobilestation>
 <20200508092236.GA9085@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508092236.GA9085@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 11:22:36AM +0200, Thomas Bogendoerfer wrote:
> On Thu, May 07, 2020 at 10:13:37PM +0300, Serge Semin wrote:
> > On Thu, May 07, 2020 at 01:09:51PM +0200, Thomas Bogendoerfer wrote:
> > > On Wed, May 06, 2020 at 08:42:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > 
> > > > Indeed according to the P5600/P6000 manual the MAAR pair register
> > > > address field either takes [12:31] bits for 32-bits non-XPA systems
> > > > and [12:35] otherwise. In any case the current address mask is just
> > > > wrong for 64-bit and 32-bits XPA chips. So lets extend it to 39-bits
> > > > value. This shall cover the 64-bits architecture and systems with XPA
> > > > enabled, and won't cause any problem for non-XPA 32-bit systems, since
> > > > the value will be just truncated when written to the 32-bits register.
> > > 
> > > according to MIPS32 Priveleged Resoure Architecture Rev. 6.02
> > > ADDR spans from bit 12 to bit 55. So your patch fits only for P5600.
> > 
> > > Does the wider mask cause any problems ?
> > 
> > No, it won't. Bits written to the [40:62] range will be just ignored,
> > while reading from there should return zeros. Setting GENMASK_ULL(55, 12)
> > would also work. Though this solution is a bit workarounding because
> > MIPS_MAAR_ADDR wouldn't reflect the real mask of the ADDR field. Something
> > like the next macro would work better:
> > 
> > +#define MIPS_MAAR_ADDR							\
> > +({									\
> > +	u64 __mask;							\
> > +									\
> > +	if (cpu_has_lpa && read_c0_pagegrain() & PG_ELPA) {		\
> > +		__mask = GENMASK_ULL(55, 12);				\
> > +	else								\
> > +		__mask = GENMASK_ULL(31, 12);				\
> > +									\
> > +	__mask;								\
> > +})
> 
> that looks horrible.
> 
> > What do you think? What is better: the macro above or setting
> > GENMASK_ULL(55, 12)?
> 
> just that one ;-)

Agreed. I'll fix it in v3.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
