Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059D1CAA63
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEHMP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 08:15:57 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:33180 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgEHMP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 08:15:57 -0400
Received: from flygoat-x1e (unknown [IPv6:240e:e0:f181:b238:7275:17ea:845e:bb31])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 5189A2049E;
        Fri,  8 May 2020 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588940156; bh=UlB/LTQO9GDoNBWvUvxhRQdqtyIVKakesW0HTOXtYEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HmpjRH8UIJe/LGtE/KC4xshp8rXQyfTRgfTtU/ZHHyOip/0iU/qXM8YZ7BfFEZyFZ
         6TyU+Pv5kC/pms8VXZMRefwS8Q62sa1VRbuJ6GpguxtnMeTQn/q90m7GW7Ch640bnG
         TZxQie1uUxnJ6m8hjCffzP5geBSOmcHc7nycjdtAxZ4Fd1ejSm/tV+sPY+QMO8zPBL
         N5NK6i1RD9qrGTZYE+4NxDWvjxtb1f4+yuv6iwXsXcEAbssbkKFOJMHPyPhc5kbAf3
         RR4bmSjeSHIH+H8110o8qAhgZraRnYjjPjSXeDZF4fPU5h0AN8MIPrLsxmoHZ9r4ja
         2Lw1Daucvo8bw==
Date:   Fri, 8 May 2020 20:15:34 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     <Sergey.Semin@baikalelectronics.ru>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 17/20] mips: Add udelay lpj numbers adjustment
Message-ID: <20200508201534.2a54da17@flygoat-x1e>
In-Reply-To: <20200506174238.15385-18-Sergey.Semin@baikalelectronics.ru>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
        <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
        <20200506174238.15385-18-Sergey.Semin@baikalelectronics.ru>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 May 2020 20:42:35 +0300
<Sergey.Semin@baikalelectronics.ru> wrote:

> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Loops-per-jiffies is a special number which represents a number of
> noop-loop cycles per CPU-scheduler quantum - jiffies. As you
> understand aside from CPU-specific implementation it depends on
> the CPU frequency. So when a platform has the CPU frequency fixed,
> we have no problem and the current udelay interface will work
> just fine. But as soon as CPU-freq driver is enabled and the cores
> frequency changes, we'll end up with distorted udelay's. In order
> to fix this we have to accordinly adjust the per-CPU udelay_val
> (the same as the global loops_per_jiffy) number. This can be done
> in the CPU-freq transition event handler. We subscribe to that event
> in the MIPS arch time-inititalization method.
> 
> Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

That have been absent in MIPS kernel so long!

Thanks.
> ---
[...]
---
Jiaxun Yang
