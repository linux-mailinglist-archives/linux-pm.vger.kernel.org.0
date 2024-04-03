Return-Path: <linux-pm+bounces-5902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C1897969
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25AB1F23460
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E71553A2;
	Wed,  3 Apr 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcX24eMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458515530D;
	Wed,  3 Apr 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174203; cv=none; b=VZHBbbiEdfieVaNrAC3I/XjGJb7WHRcaEeQMILpA/RD3eBZRb3E7qsggauVDKjArCCaa3o7k3QADY/2KTQ5Q5L9Ud1ePse6ndAmOm7vHt8frv/pm2/vZbmsHmGzLSmEeCUDqQiIot2YEecBEUppcikEXJ/E0K8gvjxOO6zPiqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174203; c=relaxed/simple;
	bh=qy2c8g78O518PO9O6KiZAFu1Ifp8jJwqGnz0VLfkXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQLvd+Lf8m7VvoBVJ6N4aV1jRAzdoz+Wp+uQiSfQ+iepEXcfgY3QtJo1S4itHUQUsK+dtd8qTf2LH0lz9NzSggdGTTTAMn4LcvoOHvfoc1TxxuRPNlnz/nqLoK8Ht26TQWDBUrodaVROvm/CLRI7hoBVQm3l/uUwUagBMe4nrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcX24eMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3A6C433F1;
	Wed,  3 Apr 2024 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174203;
	bh=qy2c8g78O518PO9O6KiZAFu1Ifp8jJwqGnz0VLfkXp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PcX24eMcI3r7RMuyiQtrdT8VNobuQKE7qDwRG7xa37VjD5kc/Xx41+a+Cb52paHq0
	 KaceVi8Oe9+qRPi0GuEmV2AtxD2JvTGAE1YW+jXb3POR+gVzfHA1hlSSh3EFTcLmTS
	 vzOnz34ygzA/82y8tPPcGA+QS9L1heyXaQ/ZeMWqbc9iJJt06OgESedUPv2LWTGe6X
	 Hapzco7aMc1HdW7cSPObY/IoDDZw/AKTggKWbHcmJcFWas9Cu/nTc9urIqk89BEAgA
	 W7UhLFX7Fbn8+V+QDZAa+m6AQIOP0/NaMlwAoYNW4YNF3vlR1x8vmZwCKQoCX9ZTB8
	 nIydySl/aw1DQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7698CE0D85; Wed,  3 Apr 2024 12:56:42 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:56:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	clang-built-linux <llvm@lists.linux.dev>,
	Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: kernel/sched/core.c:961:15: error: incompatible pointer to
 integer conversion passing 'typeof
Message-ID: <8d5dcb8c-6fc8-4e01-b20e-970809bf842e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
 <CAKfTPtC9YgbZgGNK82MhhzzsD3P6j64+w6oieJMDKQNOmrC4FQ@mail.gmail.com>
 <20240403160041.GA1252923@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403160041.GA1252923@dev-arch.thelio-3990X>

On Wed, Apr 03, 2024 at 09:00:41AM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> + Paul McKenney
> 
> On Wed, Apr 03, 2024 at 03:26:05PM +0200, Vincent Guittot wrote:
> > Hi Naresh,
> > 
> > Adding riscv people
> > 
> > On Wed, 3 Apr 2024 at 09:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The riscv clang-17 defconfig build failed due to following warnings / errors
> > > on the Linux next-20240402.
> > 
> > Could you confirm that there is no problem with other arch and/or
> > other toolchain ?
> 
> This is not a clang specific issue, it happens with GCC too:

Some of these are fixed, but there are a few remaining failures.

I have pulled this series from -next, and apologies for putting it in
too soon.

							Thanx, Paul

>   $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux- mrproper defconfig kernel/sched/core.o
>   kernel/sched/core.c: In function '__wake_q_add':
>   arch/riscv/include/asm/cmpxchg.h:175:62: warning: passing argument 2 of 'cmpxchg_emu_u8' makes integer from pointer without a cast [-Wint-conversion]
>     175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>         |                                                              ^~~~~
>         |                                                              |
>         |                                                              struct wake_q_node *
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   In file included from arch/riscv/include/asm/cmpxchg.h:12,
>                    from arch/riscv/include/asm/atomic.h:19,
>                    from include/linux/atomic.h:7,
>                    from include/linux/cpumask.h:14,
>                    from include/linux/smp.h:13,
>                    from include/linux/lockdep.h:14,
>                    from include/linux/spinlock.h:63,
>                    from include/linux/wait.h:9,
>                    from include/linux/wait_bit.h:8,
>                    from include/linux/fs.h:6:
>   include/linux/cmpxchg-emu.h:13:52: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
>      13 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
>         |                                          ~~~~~~~~~~^~~
>   arch/riscv/include/asm/cmpxchg.h:175:69: warning: passing argument 3 of 'cmpxchg_emu_u8' makes integer from pointer without a cast [-Wint-conversion]
>     175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>         |                                                                     ^~~~~
>         |                                                                     |
>         |                                                                     struct wake_q_node *
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   include/linux/cmpxchg-emu.h:13:67: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
>      13 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
>         |                                                         ~~~~~~~~~~^~~
>   arch/riscv/include/asm/cmpxchg.h:175:23: warning: assignment to 'struct wake_q_node *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
>     175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>         |                       ^
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:179:64: warning: passing argument 2 of 'cmpxchg_emu_u16' makes integer from pointer without a cast [-Wint-conversion]
>     179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                                                                ^~~~~
>         |                                                                |
>         |                                                                struct wake_q_node *
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   include/linux/cmpxchg-emu.h:14:54: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
>      14 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
>         |                                            ~~~~~~~~~~^~~
>   arch/riscv/include/asm/cmpxchg.h:179:71: warning: passing argument 3 of 'cmpxchg_emu_u16' makes integer from pointer without a cast [-Wint-conversion]
>     179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                                                                       ^~~~~
>         |                                                                       |
>         |                                                                       struct wake_q_node *
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   include/linux/cmpxchg-emu.h:14:69: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
>      14 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
>         |                                                           ~~~~~~~~~~^~~
>   arch/riscv/include/asm/cmpxchg.h:179:23: warning: assignment to 'struct wake_q_node *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
>     179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                       ^
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:179:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:180:9: note: here
>     180 |         case 4:                                                         \
>         |         ^~~~
>   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
>     961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>         |                      ^~~~~~~~~~~~~~~
>   kernel/sched/sched.h: In function 'mm_cid_put_lazy':
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/sched.h:3292:14: note: in expansion of macro 'try_cmpxchg'
>    3292 |             !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/sched.h:3292:14: note: in expansion of macro 'try_cmpxchg'
>    3292 |             !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
>         |              ^~~~~~~~~~~
>   kernel/sched/sched.h: In function 'mm_cid_get':
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/sched.h:3429:21: note: in expansion of macro 'try_cmpxchg'
>    3429 |                 if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
>         |                     ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/sched.h:3429:21: note: in expansion of macro 'try_cmpxchg'
>    3429 |                 if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
>         |                     ^~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic_cmpxchg_relaxed':
>   arch/riscv/include/asm/cmpxchg.h:179:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:2108:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
>         |                ^~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:180:9: note: here
>     180 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
>     212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
>         |                              ^~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^~~~~~~~~~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:2108:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
>    2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
>         |                ^~~~~~~~~~~~~~~~~~~
>   kernel/sched/core.c: In function '__sched_mm_cid_migrate_from_try_steal_cid':
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11724:14: note: in expansion of macro 'try_cmpxchg'
>   11724 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11724:14: note: in expansion of macro 'try_cmpxchg'
>   11724 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11760:14: note: in expansion of macro 'try_cmpxchg'
>   11760 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11760:14: note: in expansion of macro 'try_cmpxchg'
>   11760 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>         |              ^~~~~~~~~~~
>   kernel/sched/core.c: In function 'task_mm_cid_work':
>   arch/riscv/include/asm/cmpxchg.h:333:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
>    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~
>   kernel/sched/core.c:11945:23: note: in expansion of macro 'cmpxchg'
>   11945 |                 res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
>         |                       ^~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
>    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~
>   kernel/sched/core.c:11945:23: note: in expansion of macro 'cmpxchg'
>   11945 |                 res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
>         |                       ^~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:333:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11953:14: note: in expansion of macro 'try_cmpxchg'
>   11953 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11953:14: note: in expansion of macro 'try_cmpxchg'
>   11953 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
>         |              ^~~~~~~~~~~
>   kernel/sched/core.c: In function 'sched_mm_cid_remote_clear':
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11841:14: note: in expansion of macro 'try_cmpxchg'
>   11841 |         if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11841:14: note: in expansion of macro 'try_cmpxchg'
>   11841 |         if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
>         |              ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11874:21: note: in expansion of macro 'try_cmpxchg'
>   11874 |                 if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>         |                     ^~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
>     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>         |                ^~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
>    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>         |         ^~~~~~~~~~~~~~~
>   kernel/sched/core.c:11874:21: note: in expansion of macro 'try_cmpxchg'
>   11874 |                 if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>         |                     ^~~~~~~~~~~
>   kernel/sched/sched.h: In function 'mm_cid_pcpu_unset':
>   arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
>    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~
>   kernel/sched/sched.h:3310:23: note: in expansion of macro 'cmpxchg'
>    3310 |                 res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
>         |                       ^~~~~~~
>   arch/riscv/include/asm/cmpxchg.h:334:9: note: here
>     334 |         case 4:                                                         \
>         |         ^~~~
>   arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
>     368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>         |                              ^~~~~~~~~
>   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
>      55 | #define raw_cmpxchg arch_cmpxchg
>         |                     ^~~~~~~~~~~~
>   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
>    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
>         |         ^~~~~~~~~~~
>   kernel/sched/sched.h:3310:23: note: in expansion of macro 'cmpxchg'
>    3310 |                 res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
>         |                       ^~~~~~~
> 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > riscv:
> > >   build:
> > >     * clang-17-lkftconfig - Failed
> > >     * rv32-clang-17-defconfig - Failed
> > >     * clang-17-tinyconfig - Failed
> > >     * rv32-clang-17-tinyconfig - Failed
> > >     * clang-17-defconfig - Failed
> > >     * clang-17-allnoconfig - Failed
> > >     * rv32-clang-17-allnoconfig - Failed
> > >
> > > Build log:
> > > -------
> > > kernel/sched/core.c:961:15: error: incompatible pointer to integer
> > > conversion passing 'typeof (*((__ai_ptr)))' (aka 'struct wake_q_node
> > > *') to parameter of type 'uintptr_t' (aka 'unsigned long')
> > > [-Wint-conversion]
> > >   961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
> > >       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > There is no recent change on this code. Could it be a change in
> > cmpxchg_relaxed ?
> 
> Yes, it is caused by commit df35ee400e06 ("riscv: Emulate one-byte and
> two-byte cmpxchg") in -next. There is another thread on this problem
> with a suggested diff that resolves it for me (there are other issues
> with that change as well such as break not being in the correct
> location):
> 
> https://lore.kernel.org/Zgz98szFLLjTIZSO@yujie-X299/
> 
> Cheers,
> Nathan

