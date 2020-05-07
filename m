Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5D1C889F
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGLnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 07:43:22 -0400
Received: from elvis.franken.de ([193.175.24.41]:43588 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgEGLnV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 07:43:21 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jWevq-00081e-04; Thu, 07 May 2020 13:43:14 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 952AEC0409; Thu,  7 May 2020 13:10:07 +0200 (CEST)
Date:   Thu, 7 May 2020 13:10:07 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] mips: cm: Fix an invalid error code of
 INTVN_*_ERR
Message-ID: <20200507111007.GE11616@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-5-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 08:42:22PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
> errors") adds cm2_causes[] array with map of error type ID and
> pointers to the short description string. There is a mistake in
> the table, since according to MIPS32 manual CM2_ERROR_TYPE = {17,18}
> correspond to INTVN_WR_ERR and INTVN_RD_ERR, while the table
> claims they have {0x17,0x18} codes. This is obviously hex-dec
> copy-paste bug. Moreover codes {0x18 - 0x1a} indicate L2 ECC errors.
> 
> Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/kernel/mips-cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
