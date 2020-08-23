Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33424EFBD
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHWUyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 16:54:41 -0400
Received: from mail.ispras.ru ([83.149.199.84]:51698 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgHWUyl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 16:54:41 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 8315940A206F;
        Sun, 23 Aug 2020 20:54:38 +0000 (UTC)
Date:   Sun, 23 Aug 2020 23:54:38 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Len Brown <lenb@kernel.org>
cc:     Liwei Song <liwei.song@windriver.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/power turbostat: call pread64 in kernel directly
In-Reply-To: <CAJvTdKms0Qj3d+g_tK8oboMXebYgnPm51EdSL_UvLdw3GV6A3A@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.13.2008232345570.12553@monopod.intra.ispras.ru>
References: <20200717060849.12469-1-liwei.song@windriver.com> <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com> <52f16995-6d2d-fa7d-ed5e-682db3461d03@windriver.com> <CAJvTdKms0Qj3d+g_tK8oboMXebYgnPm51EdSL_UvLdw3GV6A3A@mail.gmail.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I am not the original submitter, but I have answers and a proper patch :)

On Fri, 21 Aug 2020, Len Brown wrote:

> Re: offset size
> 
> The offsets on this file are the MSR offsets.
> What MSR are you trying to access at offset 0xc0010299?

This MSR is particular is part of AMD RAPL (energy measurements) interface.

> Re: pread vs pread64
> 
> If I take on faith that you have some kind of 32-bit execution
> environment that makes pread into pread32 instead of pread64, and that
> truncates an off_t to 32-bits from 64-bits, and it actually makes
> sense to request a read at this large offset...

The problem here stems from the backward compatibility in Glibc: off_t is
32-bit on 32-bit x86, unless compiled with -D_FILE_OFFSET_BITS=64. This
macro should be used for all new code. Distros should enable it for all
builds, but when one builds turbostat 'by hand', they hit the issue.

> would we really have to invoke syscall() directly -- couldn't we
> invoke pread64() directly? (eg. below)

No, the proper fix is to pass -D_FILE_OFFSET_BITS=64 to the compiler.

Here's the patch:

---8<---

From: Alexander Monakov <amonakov@ispras.ru>
Date: Sun, 23 Aug 2020 23:27:02 +0300
Subject: [PATCH] turbostat: build with _FILE_OFFSET_BITS=64

For compatibility reasons, Glibc off_t is a 32-bit type on 32-bit x86
unless _FILE_OFFSET_BITS=64 is defined. Add this define, as otherwise
reading MSRs with index 0x80000000 and above attempts a pread with a
negative offset, which fails.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 tools/power/x86/turbostat/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2b6551269e43..40ae44402eec 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -12,6 +12,7 @@ turbostat : turbostat.c
 override CFLAGS +=	-O2 -Wall -I../../../include
 override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-D_FILE_OFFSET_BITS=64
 override CFLAGS +=	-D_FORTIFY_SOURCE=2
 
 %: %.c
-- 
2.26.2

