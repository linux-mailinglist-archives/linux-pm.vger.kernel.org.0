Return-Path: <linux-pm+bounces-22147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FAA36D22
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A68D7A4860
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84C1A08AF;
	Sat, 15 Feb 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA0pkx0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F42194A75;
	Sat, 15 Feb 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613222; cv=none; b=GLufALCnDOUyKePAczCMBjZmXV0WjGNPgEPatTN1nQg6WMxIhUkBZcvHvlL2asOtf/xhmLX/wMA00aAEULYLs5MRxGtvoeAVMgIjik3dbymcIwDsMhX6dx7MSpzZ1Cm/1mBFEiiaxvpcQuqtvlByVl2SO09dsy3CoMxkrlMpmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613222; c=relaxed/simple;
	bh=XRON9YpZit+13IZCBmcmH3X3m0W/5w3xJWfXTOVxWqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvgZhQspwPfhTK6jEoid3gtAVsZ/qyraAQ6+Z3ATHA9QD9vmdkN3cZctz9eLnRefB1uJjIXVYZwt7/bRwgAxERZjoFwpaH79RlLqJRZfLL71LACFGix406gdUlQG5Vlu5mTrAGzhz5PCFVHUquzmlXunYu3GTXUnHJjIspSEpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA0pkx0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BB2C4CEEF;
	Sat, 15 Feb 2025 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739613222;
	bh=XRON9YpZit+13IZCBmcmH3X3m0W/5w3xJWfXTOVxWqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oA0pkx0/MESTfEIvJadmKD6VCVArPKOcSHHrGsAU7Vm+LvyVk/GWxzfItTXt3Y4PR
	 G3GLXz0+2L1uxKP2wCfGO52RAuJ8PYKJIrNP61lwQxHONcPt6zQ/+URxu4DcleZNav
	 SpfM4qWOhYMADuy4jLX/1kTWLAPIoOKcBHBOTpGBSkRzPM88q2TBCi3CI5gQBngoF5
	 eo8p4hhpRFCWA2dNmWu+NTBSInQrdNWwaND5N5Hv9rUAnxumaKzsyDetNB7wLqsPGO
	 vf92XVxvTFWexrGXEmbcvCzr3+8Pbt7N0NRoJycH3iToTW5YeX3X+4jC51lgL86AGz
	 xNHJ8J5NGeevg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7b80326cdso545378966b.3;
        Sat, 15 Feb 2025 01:53:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp0yFqS4lRHMQiPWCDe4sWUg4oFyG7q7VwNT+uhO/SLNn6gvHmPxP3KQVqO3Ka8iwJFpQSWj6+@vger.kernel.org, AJvYcCWuc6P5N+SUJGHqyJgt4Xf9Zr7cq6c1KjF0t7Sftsut1eoI3uUGTXeRfxcb8C56oMj60Bb6/mIgkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzVvsWCqt4Hr7x2ceY1G8oy66KbFW6BIKUW6s1kj8djldVxej
	sGD771nDKMjsuEAomEZKcTQ3i0sNwVaPj6BVi5q5Q/5sRbCXYlitni6bsrWOKYqUIoD1lSGsb4t
	DQZnfUodOvtbF0di8xyhuDbJ+QNs=
X-Google-Smtp-Source: AGHT+IFQkktP4/XZXdQKDzrldOcGrW+VT8uHPIAcZrza8zIIRSr6WzGkT3I/FT6WmfK75v5Ts1MUFtLaUBNk+lVlKwg=
X-Received: by 2002:a17:906:3158:b0:ab7:b8eb:f725 with SMTP id
 a640c23a62f3a-abb70a7a54emr190367866b.7.1739613220431; Sat, 15 Feb 2025
 01:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local> <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
In-Reply-To: <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Feb 2025 17:53:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>
X-Gm-Features: AWEUYZn1B4iVF_hrPKrMzEuFIJf7ie2bWNy-5mfqJDkWYIXZqn6mcTtrKk52_Ko
Message-ID: <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org, 
	Yuli Wang <wangyuli@uniontech.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kees Cook <kees@kernel.org>, 
	GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:45=E2=80=AFPM Harry (Hyeonggon) Yoo
<42.hyeyoo@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> > On Fri, Feb 14, 2025 at 5:33=E2=80=AFPM Harry (Hyeonggon) Yoo
> > <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > > Hi, Harry,
> > > >
> > > > On Wed, Feb 12, 2025 at 11:39=E2=80=AFPM Harry (Hyeonggon) Yoo
> > > > <42.hyeyoo@gmail.com> wrote:
> > > > > On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhuacai@=
loongson.cn> wrote:
> > > > > >
> > > > > > Hibernation assumes the memory layout after resume be the same =
as that
> > > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assu=
mption.
> > > > >
> > > > > Could you please elaborate what do you mean by
> > > > > hibernation assumes 'the memory layout' after resume be the same =
as that
> > > > > before sleep?
> > > > >
> > > > > I don't understand how updating random_kmalloc_seed breaks resumi=
ng from
> > > > > hibernation. Changing random_kmalloc_seed affects which kmalloc c=
aches
> > > > > newly allocated objects are from, but it should not affect the ob=
jects that are
> > > > > already allocated (before hibernation).
> > > >
> > > > When resuming, the booting kernel should switch to the target kerne=
l,
> > > > if the address of switch code (from the booting kernel) is the
> > > > effective data of the target kernel, then the switch code may be
> > > > overwritten.
> > >
> > > Hmm... I'm still missing some pieces.
> > > How is the kernel binary overwritten when slab allocations are random=
ized?
> > >
> > > Also, I'm not sure if it's even safe to assume that the memory layout=
 is the
> > > same across boots. But I'm not an expert on swsusp anyway...
> > >
> > > It'd be really helpful for linux-pm folks to clarify 1) what are the
> > > (architecture-independent) assumptions are for swsusp to work, and
> > > 2) how architectures dealt with other randomization features like kAS=
LR...
> >
>
> [+Cc few more people that worked on slab hardening]
>
> > I'm sorry to confuse you. Binary overwriting is indeed caused by
> > kASLR, so at least on LoongArch we should disable kASLR for
> > hibernation.
>
> Understood.
>
> > Random kmalloc is another story, on LoongArch it breaks smpboot when
> > resuming, the details are:
> > 1, LoongArch uses kmalloc() family to allocate idle_task's
> > stack/thread_info and other data structures.
> > 2, If random kmalloc is enabled, idle_task's stack in the booting
> > kernel may be other things in the target kernel.
>
> Slab hardening features try so hard to prevent such predictability.
> For example, SLAB_FREELIST_RANDOM could also randomize the address
> kmalloc objects are allocated at.
>
> Rather than hacking CONFIG_RANDOM_KMALLOC_CACHES like this, we could
> have a single option to disable slab hardening features that makes
> the address unpredictable.
>
> It'd be nice to have something like ARCH_SUPPORTS_SLAB_RANDOM which
> some hardening features depend on. And then let some arches conditionally
> not select ARCH_SUPPORTS_SLAB_RANDOM if hibernation's enabled
> (at cost of less hardening)?
This is not good, my patch doesn't disable RANDOM for hibernation, it
just delays the initialization. When the system is running, all
randomization is still usable.

For SLAB_FREELIST_RANDOM, I found that it doesn't break hibernation
(at least on LoongArch), the reason is:
1. When I said "data overwritten" before, it doesn't mean that every
byte shouldn't be overwritten, only some important parts matter.
2. On LoongArch, the important parts include: switch code, exception
handlers, idle_task's stack/thread_info.
3. switch code and exception handlers are protected by automatically
disabling kASLR from arch-specific code, idle_task's stack/thread_info
is protected by delaying random seeds (this patch).

Why SLAB_FREELIST_RANDOM doesn't corrupt idle_task's
stack/thread_info? Because the scope of randomization of
SLAB_FREELIST_RANDOM is significantly less than RANDOM_KMALLOC_CACHES.
When RANDOM_KMALLOC_CACHES enabled, the CPU1's idle task stack from
the booting kernel may be the CPU2's idle task stack from the target
kernel, and CPU2's idle task stack from the booting kernel may be the
CPU1's idle task stack from the target kernel, but idle task's stack
from the booting kernel won't be other things from the target kernel
(and won't be overwritten by switching kernel).


Huacai

>
> --
> Harry
>
> > 3, When CPU0 executes the switch code, other CPUs are executing
> > idle_task, and their stacks may be corrupted by the switch code.
> >
> > So in experiments we can fix hibernation only by moving
> > random_kmalloc_seed initialization after smp_init(). But obviously,
> > moving it after all initcalls is harmless and safer.
> >
> >
> > Huacai
> >
> > > > For LoongArch there is an additional problem: the regular kernel
> > > > function uses absolute address to call exception handlers, this mea=
ns
> > > > the code calls to exception handlers should at the same address for
> > > > booting kernel and target kernel.

