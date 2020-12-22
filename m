Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FDF2E0E7A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgLVSzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 13:55:40 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42686 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLVSzk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 13:55:40 -0500
Received: by mail-oi1-f169.google.com with SMTP id l200so15746325oig.9;
        Tue, 22 Dec 2020 10:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la43jOzGT8cpDZH0lHbZ8yczIDIlNNAQ1oOndJF72r4=;
        b=AtCcSb0o7lY006L2GZrR5UPwPilzq/kC67NLyMjTZtASTReROhfjHPSy0RutWkOlKG
         RqbP27tGmReskQxNo0K1qfHhQcg6BAW8uhUbqOHdmm5hEmtBJFuenLd5NptgWQUOCKDz
         kjBCjoZCLZnH3k1wGg9YY432uIFwhpY+r6MsQXLuVC5Lukiq3687e0tzgaR02AiCPgSA
         hUQ6TnjAbNzY2zv/Q8ZK4fhOAFRbv50TPGQ5gIf6Z0+69bzjLuL3yZL4SdU0w7FOj1Nr
         53m1eQRxRsaWSphjOgaFwTgtkYz5JW6aTdzGIVgfIfPX0m1eiIDBLzh63umJaoDlvgAe
         kNQA==
X-Gm-Message-State: AOAM533zU2Uk2Mcr8ixJ0xDbGVLBXHLupoRPMNp6erY+S1JCHptXTjXn
        D0tMUPgu9lUdRtq9T2gSPgh66ssty+unEomxCjk=
X-Google-Smtp-Source: ABdhPJy5EVY7T6HE7RxxJ9AoKr5usE9gCbUG5HZ1gWiHgPXdK9RZjFwARYSd7qSwoUdfSw0ANGyqV1mRCh80XLruDv8=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr14009921oia.54.1608663299046;
 Tue, 22 Dec 2020 10:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20201222184510.19415-1-info@metux.net>
In-Reply-To: <20201222184510.19415-1-info@metux.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Dec 2020 19:54:48 +0100
Message-ID: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
Subject: Re: [PATCH] arch: consolidate pm_power_off callback
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enrico,

On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> Move the pm_power_off callback into one global place and also add an
> function for conditionally calling it (when not NULL), in order to remove
> code duplication in all individual archs.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thanks for your patch!

> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -43,12 +43,6 @@
>  #include "proto.h"
>  #include "pci_impl.h"
>
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void) = machine_power_off;

Assignments like these are lost in the conversion.

> -EXPORT_SYMBOL(pm_power_off);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
