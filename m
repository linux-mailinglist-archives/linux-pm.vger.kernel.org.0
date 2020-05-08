Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3291CA736
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEHJdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 05:33:14 -0400
Received: from elvis.franken.de ([193.175.24.41]:44677 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgEHJdN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 05:33:13 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jWzNV-0001bD-00; Fri, 08 May 2020 11:33:09 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A9DC3C040C; Fri,  8 May 2020 11:22:36 +0200 (CEST)
Date:   Fri, 8 May 2020 11:22:36 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/20] mips: MAAR: Use more precise address mask
Message-ID: <20200508092236.GA9085@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-12-Sergey.Semin@baikalelectronics.ru>
 <20200507110951.GD11616@alpha.franken.de>
 <20200507191337.la6z476myszqethj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507191337.la6z476myszqethj@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 10:13:37PM +0300, Serge Semin wrote:
> On Thu, May 07, 2020 at 01:09:51PM +0200, Thomas Bogendoerfer wrote:
> > On Wed, May 06, 2020 at 08:42:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > Indeed according to the P5600/P6000 manual the MAAR pair register
> > > address field either takes [12:31] bits for 32-bits non-XPA systems
> > > and [12:35] otherwise. In any case the current address mask is just
> > > wrong for 64-bit and 32-bits XPA chips. So lets extend it to 39-bits
> > > value. This shall cover the 64-bits architecture and systems with XPA
> > > enabled, and won't cause any problem for non-XPA 32-bit systems, since
> > > the value will be just truncated when written to the 32-bits register.
> > 
> > according to MIPS32 Priveleged Resoure Architecture Rev. 6.02
> > ADDR spans from bit 12 to bit 55. So your patch fits only for P5600.
> 
> > Does the wider mask cause any problems ?
> 
> No, it won't. Bits written to the [40:62] range will be just ignored,
> while reading from there should return zeros. Setting GENMASK_ULL(55, 12)
> would also work. Though this solution is a bit workarounding because
> MIPS_MAAR_ADDR wouldn't reflect the real mask of the ADDR field. Something
> like the next macro would work better:
> 
> +#define MIPS_MAAR_ADDR							\
> +({									\
> +	u64 __mask;							\
> +									\
> +	if (cpu_has_lpa && read_c0_pagegrain() & PG_ELPA) {		\
> +		__mask = GENMASK_ULL(55, 12);				\
> +	else								\
> +		__mask = GENMASK_ULL(31, 12);				\
> +									\
> +	__mask;								\
> +})

that looks horrible.

> What do you think? What is better: the macro above or setting
> GENMASK_ULL(55, 12)?

just that one ;-)

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
