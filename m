Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD881D9BD8
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgESQAL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 12:00:11 -0400
Received: from elvis.franken.de ([193.175.24.41]:59275 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbgESQAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 12:00:10 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jb4ew-0001Fc-00; Tue, 19 May 2020 18:00:02 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0EC79C012F; Tue, 19 May 2020 17:42:13 +0200 (CEST)
Date:   Tue, 19 May 2020 17:42:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/20] mips: MAAR: Add XPA mode support
Message-ID: <20200519154213.GA15797@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-13-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 08:42:30PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> When XPA mode is enabled the normally 32-bits MAAR pair registers
> are extended to be of 64-bits width as in pure 64-bits MIPS
> architecture. In this case the MAAR registers can enable the
> speculative loads/stores for addresses of up to 39-bits width.
> But in this case the process of the MAAR initialization changes a bit.
> The upper 32-bits of the registers are supposed to be accessed by mean
> of the dedicated instructions mfhc0/mthc0 and there is a CP0.MAAR.VH
> bit which should be set together with CP0.MAAR.VL as indication
> of the boundary validity. All of these peculiarities were taken into
> account in this commit so the speculative loads/stores would work
> when XPA mode is enabled.
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
> ---
>  arch/mips/include/asm/maar.h     | 17 +++++++++++++++--
>  arch/mips/include/asm/mipsregs.h | 10 ++++++++++
>  arch/mips/mm/init.c              |  8 +++++++-
>  3 files changed, 32 insertions(+), 3 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
