Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37BB2F329A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbhALOFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 09:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbhALOFv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Jan 2021 09:05:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A42AE22CE3;
        Tue, 12 Jan 2021 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460310;
        bh=YIZSFd4ngdBu3d+V+tCrhUDlUF7epBaWbFsCZCkzGJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+ljzYYL3QMPhhApX5VwhFNyceVrA27EHM0FStNvwzUR1cQ7GFOIPOcEYTO0fdDaA
         Kj7O7lmy0yWuWK+AZisJL2LrmlkoM/j63MxdM7S787vyvaT4LD71jTgKDStmGrzxuQ
         L0/NqqEzqp6wU8ndgl0gsmTuxMJL2Vz98cUyPebone1iHGoyH3HLXEv/yY8kVzE9/C
         3JxXpkug6tFhHh2/KJ9Ii5coAgelm+gr542ObqppAE3GEOphOgXDNiAJFxaofg4s3u
         N68pjfATVrUXDVMPlwIcydiug5iK5JLd2AIK2alwIqlmLf7Si7Qy4TLd2kqk9nbCgG
         c2IYKYoLXP3bw==
Date:   Tue, 12 Jan 2021 14:05:00 +0000
From:   Will Deacon <will@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        msalter@redhat.com, jacquiot.aurelien@gmail.com,
        ysato@users.sourceforge.jp, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, ley.foon.tan@intel.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        dalias@libc.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        sstabellini@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
        christian@brauner.io, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] arch: consolidate pm_power_off callback
Message-ID: <20210112140459.GC9277@willie-the-truck>
References: <20201227140129.19932-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227140129.19932-1-info@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 27, 2020 at 03:01:28PM +0100, Enrico Weigelt, metux IT consult wrote:
> Move the pm_power_off callback into one global place and also add an
> function for conditionally calling it (when not NULL), in order to remove
> code duplication in all individual archs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

[...]

> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index eb1b15850761..ec4cd66dd1ae 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -53,6 +53,16 @@ int reboot_force;
>  void (*pm_power_off_prepare)(void);
>  EXPORT_SYMBOL_GPL(pm_power_off_prepare);
>  
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL_GPL(pm_power_off);
> +
> +void do_power_off(void)
> +{
> +	if (pm_power_off)
> +		pm_power_off();
> +}
> +EXPORT_SYMBOL_GPL(do_power_off);

Could this just live as a static inline in pm.h to avoid having to export
the extra symbol?

Will
