Return-Path: <linux-pm+bounces-22154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997DA36EAF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE58E3B14EC
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A814B087;
	Sat, 15 Feb 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejs0pBGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA81D5AD3;
	Sat, 15 Feb 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739628349; cv=none; b=pI8MIiybTUd1HVmPWb65p9/dLcQ+FHfrIZdwtSFNTJ3tUbDlFs/Aopi0X2XTmvjPQD+JN0NIvHCDk92iuwQi/UcFEN7dvM1MZ4G5sJZ1r9/aPfwnMY0QUCJNNYQ53BlZHptfCUsHRWpgkteVzyyV2DLXB1FDTYF69XmBNb6enBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739628349; c=relaxed/simple;
	bh=LdOS54w+GjrAoUKzo/nCkhTuTCo7ZyLyFY98GzsPKMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIIvWd6r4puE4+WE+0TJgWB9L2JyNwMiMW2jrEO+rp5MYrFuMmFTSb3Iii4mDONOVjoG1T1+pa7DtmdCCtB6Wo3FbHLJwUoP1GRJ9+LGl/ycdftNsqC/Pe8dNFIGsJLaEiDJHEV1SzTHtPNP/gWWmgzCfqJxPDYm0MOG4X5aLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejs0pBGL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d39a5627so44209835ad.1;
        Sat, 15 Feb 2025 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739628347; x=1740233147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0EBfoneyQ2m5DKQOCwe2zek2SAqeGp/XPESUcXVWkQ=;
        b=Ejs0pBGLNPwfKQwsQCRhfyV19ooNzlrspcqQqKn8PK968i0RvSwT5Tc3thVbdKIYE1
         u+ZNF+qJ3V8DIvkhb+UXpzc6ZbyoB8USM+uwgtLpJj+NQkFZ8WeUEI9Iyn10UkniS6nx
         NRWlOz71Y+Ts6LdTiSijZgttgnu5Ix++4EvIbDm/Q+y/bHyMMhS9HPdFLVCsJmrqGvO4
         QFK+IebMJtRKUqZyIXL86tPhZEb8ak5bML4Aza20dayiSrHXZ9Ib2VJiuFL4w5XCq6pR
         UCdWS3+yIWW8O3gJA76ps8iaYgdkQXAQwNM/37TyBE9ID/3lxiE8IfQ64Lxq7+ujlOQ4
         n+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739628347; x=1740233147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0EBfoneyQ2m5DKQOCwe2zek2SAqeGp/XPESUcXVWkQ=;
        b=prdo/ttLl9UMCuzwXoJVzk/GkNe9dfBdehPwgvWgsx2+JqKRXM2602739CLFOgS3nB
         1sfYqfEbActETZJavHdhRy3qcpc1aaT5qn+WgT8LTu2caqZz7lEx+FYNNhUegQ/y58nw
         0jp1yL7e4lHzcH3jns4JJYyktzZ2b9hK19Zj7FtSYi9cprRlY1lE9H8IdOCNhftTypX7
         6j3CBk8veBlTbJmfJmnIKRxzWrf4iUT3HXx1IgmWFubiL0ery80/Ob9l5cBES7+TKZCE
         wn30PkGHBp5xqXSTd/ihKY/QiO5OQ2T553JLsbVCn/Oz/xSnGZX1F+Xlsjgwe8h0yhDF
         4HRg==
X-Forwarded-Encrypted: i=1; AJvYcCVh9NUfxBM9neGPd5OHQOF8nvZJuHqPiJjkF85Kx4/QYBdNizSPd1JQGdk63pDQqidMeUkUWsbBLg==@vger.kernel.org, AJvYcCXAj9kZWzV6/Ka1/F4uJa/f4o+dtdQtZB6/psmbAW3KowMjGF77maNZVK2Q3SvyFXGix1ggoLIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3kqSu6eFvb7rkaCc3LGuUurBpjGT9zn3+quPX3tisTdHqvWj
	ahIj2dnLpVOtiazIwiR+p5GYKTdRCSLwmh0WORmLzLqJL1KqneHU
X-Gm-Gg: ASbGncu6a6yHtBwu/u+PQ8Wi3oTTVpTY9FlYBZ68+LDwcUBRZVfw3MudNbK/YTUzuYz
	EJPKIusr+ej5YmHL1BjLLW+F3ps5eb8BioVjDW9eyv8N0hQa8kej10nl5k2I9cyUgrjpfDZ6X/n
	GkopslrF1o/goLhcvtB4Y/waTdvyeBP5yrfsiLa3uAEN3zXWW2THCYYeGpnTy7DMqdgBh/iD4MO
	6rnRa3Gutb3V1y7imG7bv58dCfdwt1a7wJhDeDXJg45bDLZK/BLd0EER/a6UrlSAfJTMPop8L1L
	Wqo1VzOjdYM2vwdVlJMp4MzbxPVsj5z3FA==
X-Google-Smtp-Source: AGHT+IHiwcNhpRT7FDtJmA7aR6hz4/Zu8vY9uHoO6iE0CSHXcKq43K5Cs5Gy5oFq+I3HV/fZTOnkgw==
X-Received: by 2002:a17:902:e841:b0:21f:860:6d0d with SMTP id d9443c01a7336-22103efb488mr57653765ad.5.1739628347291;
        Sat, 15 Feb 2025 06:05:47 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220ea7a9348sm29804825ad.211.2025.02.15.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:05:46 -0800 (PST)
Date: Sat, 15 Feb 2025 23:05:34 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kees Cook <kees@kernel.org>,
	GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
Message-ID: <Z7CfLlEw9vtbFJwI@MacBook-Air-5.local>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
 <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>

On Sat, Feb 15, 2025 at 05:53:29PM +0800, Huacai Chen wrote:
> On Fri, Feb 14, 2025 at 8:45 PM Harry (Hyeonggon) Yoo
> <42.hyeyoo@gmail.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> > > On Fri, Feb 14, 2025 at 5:33 PM Harry (Hyeonggon) Yoo
> > > <42.hyeyoo@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > > > Hi, Harry,
> > > > >
> > > > > On Wed, Feb 12, 2025 at 11:39 PM Harry (Hyeonggon) Yoo
> > > > > <42.hyeyoo@gmail.com> wrote:
> > > > > > On Wed, Feb 12, 2025 at 11:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > > >
> > > > > > > Hibernation assumes the memory layout after resume be the same as that
> > > > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
> > > > > >
> > > > > > Could you please elaborate what do you mean by
> > > > > > hibernation assumes 'the memory layout' after resume be the same as that
> > > > > > before sleep?
> > > > > >
> > > > > > I don't understand how updating random_kmalloc_seed breaks resuming from
> > > > > > hibernation. Changing random_kmalloc_seed affects which kmalloc caches
> > > > > > newly allocated objects are from, but it should not affect the objects that are
> > > > > > already allocated (before hibernation).
> > > > >
> > > > > When resuming, the booting kernel should switch to the target kernel,
> > > > > if the address of switch code (from the booting kernel) is the
> > > > > effective data of the target kernel, then the switch code may be
> > > > > overwritten.
> > > >
> > > > Hmm... I'm still missing some pieces.
> > > > How is the kernel binary overwritten when slab allocations are randomized?
> > > >
> > > > Also, I'm not sure if it's even safe to assume that the memory layout is the
> > > > same across boots. But I'm not an expert on swsusp anyway...
> > > >
> > > > It'd be really helpful for linux-pm folks to clarify 1) what are the
> > > > (architecture-independent) assumptions are for swsusp to work, and
> > > > 2) how architectures dealt with other randomization features like kASLR...
> > >
> >
> > [+Cc few more people that worked on slab hardening]
> >
> > > I'm sorry to confuse you. Binary overwriting is indeed caused by
> > > kASLR, so at least on LoongArch we should disable kASLR for
> > > hibernation.
> >
> > Understood.
> >
> > > Random kmalloc is another story, on LoongArch it breaks smpboot when
> > > resuming, the details are:
> > > 1, LoongArch uses kmalloc() family to allocate idle_task's
> > > stack/thread_info and other data structures.
> > > 2, If random kmalloc is enabled, idle_task's stack in the booting
> > > kernel may be other things in the target kernel.
> >
> > Slab hardening features try so hard to prevent such predictability.
> > For example, SLAB_FREELIST_RANDOM could also randomize the address
> > kmalloc objects are allocated at.
> >
> > Rather than hacking CONFIG_RANDOM_KMALLOC_CACHES like this, we could
> > have a single option to disable slab hardening features that makes
> > the address unpredictable.
> >
> > It'd be nice to have something like ARCH_SUPPORTS_SLAB_RANDOM which
> > some hardening features depend on. And then let some arches conditionally
> > not select ARCH_SUPPORTS_SLAB_RANDOM if hibernation's enabled
> > (at cost of less hardening)?
>
> This is not good, my patch doesn't disable RANDOM for hibernation, it
> just delays the initialization. When the system is running, all
> randomization is still usable.

I think at least we need a rule (like ARCH_SUPPORTS_SLAB_RANDOM)
for slab hardening features that prevents breaking hibernation
in the future. Without rules, introducing new hardening features could
break hibernation again.

But I'm not yet convinced if it's worth the complexity of hacking slab
hardening features (for security) just to make hibernation work on
some arches, which have already disabled kASLR anyway...

> For SLAB_FREELIST_RANDOM, I found that it doesn't break hibernation
> (at least on LoongArch), the reason is:
> 1. When I said "data overwritten" before, it doesn't mean that every
> byte shouldn't be overwritten, only some important parts matter.
> 2. On LoongArch, the important parts include: switch code, exception
> handlers, idle_task's stack/thread_info.
> 3. switch code and exception handlers are protected by automatically
> disabling kASLR from arch-specific code, idle_task's stack/thread_info
> is protected by delaying random seeds (this patch).
> 
> Why SLAB_FREELIST_RANDOM doesn't corrupt idle_task's
> stack/thread_info? Because the scope of randomization of
> SLAB_FREELIST_RANDOM is significantly less than RANDOM_KMALLOC_CACHES.
> When RANDOM_KMALLOC_CACHES enabled,

You mean when SLAB_FREELIST_RANDOM enabled?
Assuming that...

> the CPU1's idle task stack from
> the booting kernel may be the CPU2's idle task stack from the target
> kernel, and CPU2's idle task stack from the booting kernel may be the
> CPU1's idle task stack from the target kernel

What happens if it's not the case?

> but idle task's stack
> from the booting kernel won't be other things from the target kernel
> (and won't be overwritten by switching kernel).

What guarantees that it won't be overwritten?
To me it seems to be a fragile assumption that could be broken.

Am I missing something?

-- 
Harry

