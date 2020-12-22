Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13A92E0F48
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 21:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgLVUSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 15:18:03 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLVUSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 15:18:02 -0500
Received: from [192.168.1.155] ([95.118.68.26]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5FtF-1jtguL3EaD-0118EC; Tue, 22 Dec 2020 21:14:24 +0100
Subject: Re: [PATCH] arch: consolidate pm_power_off callback
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
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
        the arch/x86 maintainers <x86@kernel.org>,
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
References: <20201222184510.19415-1-info@metux.net>
 <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <2f1d53e9-0dbb-78ef-22d5-ab230438ddf0@metux.net>
Date:   Tue, 22 Dec 2020 21:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UpSPX5SjSxB2JTjoTNk4sWDtA2g9Ks1Ix8dKZhB/ESwn1jWfyhx
 EoQG8feaYKyQLnGwygV2naaePTeCvGl6q4M5FCoVvWDzd5IDw7I4++spAXF1Cn7hlWYDZ9i
 kl7Eptzr5sffhmk6uqoQvQuMaJH6WbEHZSp8VbRZESTCM8tqF2liTqVeSG60D5ct0JeRFXM
 C/vRJPf10ZNRyihx6OQ7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4rmsxPbYFfk=:r6XlGr1qgoUDdOPZvl+EZB
 Tvvn/+E+IBfJxp8NYxN6kmODEYBvHcxpBa91h8yz4H6rftNQGPPvhJG9K3iz7sa8U3axvH9gb
 k8MQxF8AkxpsOIqgXUvRf2/UkUWU0UyTVaNY4yxFyPXaJ5HZGvdBlHztqC0ROOQbfPfvuc9EL
 FxgUfcgonSSkeeYMjRiTB3zJbeFMtXOTHkBa2rvNba1MQtk+fNt8bwxkcg/16D1kNX6CaQa6R
 /HjaLu8M8eiwjXWLzppTMleqwd3hE1HiIRNtfJF9qFLMDQKH5ELRRUKQxUmk7wwJOm6jAqUoz
 DxOEn9gjBP8Krn67rCBumevzsK7LiZ8dtcUh+n3F3XTZoxMWvkNcvhbeCfAuF95ukrIWyQBXn
 H8gIR89lqyF1p5Egw7NhgnSoXyIbQAraihthZryjzaPuyq4jPkP8GrsbXJIV3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22.12.20 19:54, Geert Uytterhoeven wrote:

Hi,

> On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>> Move the pm_power_off callback into one global place and also add an
>> function for conditionally calling it (when not NULL), in order to remove
>> code duplication in all individual archs.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> Thanks for your patch!
> 
>> --- a/arch/alpha/kernel/process.c
>> +++ b/arch/alpha/kernel/process.c
>> @@ -43,12 +43,6 @@
>>  #include "proto.h"
>>  #include "pci_impl.h"
>>
>> -/*
>> - * Power off function, if any
>> - */
>> -void (*pm_power_off)(void) = machine_power_off;
> 
> Assignments like these are lost in the conversion.

Yes, but this doesn't seem to be ever called anyways. (in arch/alpha)
And, BTW, letting it point to machine_power_off() doesn't make much
sense, since it's the arch's machine_power_off() function, who're
calling pm_power_off().

Actually, we could remove pm_power_off completely from here, assuming
nobody would *build* any drivers that register themselves into
pm_power_off.

If you feel better with it, I could post a patch that just removes
pm_power_off from arch/alpha.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
