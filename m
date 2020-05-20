Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7111DBD09
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETSkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 14:40:36 -0400
Received: from elvis.franken.de ([193.175.24.41]:60592 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETSkg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 14:40:36 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jbTdq-0005JR-01; Wed, 20 May 2020 20:40:34 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 952F1C0155; Wed, 20 May 2020 20:40:24 +0200 (CEST)
Date:   Wed, 20 May 2020 20:40:24 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mips: csrc-r4k: Decrease r4k-clocksource rating
 if CPU_FREQ enabled
Message-ID: <20200520184024.GB23855@alpha.franken.de>
References: <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520115926.lk6ycke75flwzcd2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520115926.lk6ycke75flwzcd2@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 02:59:26PM +0300, Serge Semin wrote:
> I think there is a misunderstanding here. In this patch I am not enabling

you are right, I've missed the fact, that this also needs to be enabled
in TLB entries. Strange that MIPS added the enable bit while R10k simply
do uncached acclerated, whenever TLB entry selects it.

> If there is no misunderstanding and you said what you said, that even enabling
> the feature for utilization might be dangerous, let's at least leave the
> MIPS_CONF_MM, MIPS_CONF_MM_FULL and MIPS_CONF_MM_SYS_SYSAD fields
> definition in the "arch/mips/include/asm/mipsregs.h" header. I'll use
> them to enable the write-merge in my platform code.
> 
> What do you think?

I withdraw my concerns and will apply the patch as is.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
