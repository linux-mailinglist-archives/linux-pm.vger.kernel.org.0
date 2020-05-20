Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D931DB5D8
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETODI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 10:03:08 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59232 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETODH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 10:03:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 871B5803087B;
        Wed, 20 May 2020 14:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id teVxHK5lDq1I; Wed, 20 May 2020 17:03:03 +0300 (MSK)
Date:   Wed, 20 May 2020 17:03:03 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 18/20] mips: csrc-r4k: Decrease r4k-clocksource rating
 if CPU_FREQ enabled
Message-ID: <20200520140303.gthbmm7r7z2uvupn@mobilestation>
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520115926.lk6ycke75flwzcd2@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 02:59:27PM +0300, Serge Semin wrote:
> On Tue, May 19, 2020 at 05:50:53PM +0200, Thomas Bogendoerfer wrote:
> > On Mon, May 18, 2020 at 11:57:52PM +0300, Serge Semin wrote:
> > > On Mon, May 18, 2020 at 06:32:06PM +0200, Thomas Bogendoerfer wrote:
> > > > On Mon, May 18, 2020 at 04:48:20PM +0300, Serge Semin wrote:
> > > > > On Fri, May 15, 2020 at 11:06:47PM +0200, Thomas Bogendoerfer wrote:

[nip]

> > > > > └─>[PATCH v2 09/20] mips: Add CP0 Write Merge config support
> > > > 
> > > > this is IMHO a dangerous change. Enabling write merging for any
> > > > CPU supporting it might triggers bugs. Do it in your board bringup
> > > > code and at the moment I don't see a reason for the rest of that
> > > > patch.
> > > 
> > > Let's at least leave the mm_config() implementation but without the write-merge
> > > enabling by default. Providing features availability macro
> > > cpu_has_mm_sysad/cpu_has_mm_full and c0 config fields
> > 
> > do you have a user of that ? I'm not introducing code nobody uses.
> > 
> 
> See my comment below.
> 
> > > I could use them to implement a code pattern like:
> > > 
> > > +	if (cpu_has_mm_full) {
> > > +		unsigned int config0 = read_c0_config();
> > > +               config0 = (config0 & ~MIPS_CONF_MM) | MIPS_CONF_MM_FULL;
> > > +               write_c0_config(config0);
> > > +	}
> > 
> > you know you are running on a R5 core, so you know you have MM_FULL.
> > No need to check this.
> > 
> > > By doing so I can manually enable/disable the MM feature in the
> > > cpu-feature-overrides.h. Without that I'd have to locally define these macro,
> > > which isn't good seeing they are in fact generic and can be useful for other
> > > platforms with SYSAD and FULL MM feature available. What do you think?
> > 
> > To me this is a hardware feature I expect to be done by firmware and
> > Linux shouldn't care about it, if it doesn't have any software
> > implications.
> 
> I think there is a misunderstanding here. In this patch I am not enabling
> Write-Merge feature for any memory range. I am enabling the UCA Cache Coherency
> attribute to be available for utilization. See the user-manual info regarding
> the CP0.CONFIG.MM field:
> 	Write Merge.This bit indicates whether write-through merging is enabled
> 	in the 32-byte collapsing write buffer.
> 	0: No merging allowed
> 	1: Merging allowed
> 
> In order to have the Write-merging really enabled for a particular PFN one have
> to mark its TLB entry with UCA (EntryLoX.C[3:5] = 7) attribute. So in this patch
> I am attempting to detect whether the feature is either already enabled or if
> available to enable it for utilization.
> 
> If there is no misunderstanding and you said what you said, that even enabling
> the feature for utilization might be dangerous, let's at least leave the
> MIPS_CONF_MM, MIPS_CONF_MM_FULL and MIPS_CONF_MM_SYS_SYSAD fields
> definition in the "arch/mips/include/asm/mipsregs.h" header. I'll use
> them to enable the write-merge in my platform code.
> 
> What do you think?
> 

Thomas,
Could you also give me your comment on the above, so to make sure that we
understood each other correctly in this question?

-Sergey
