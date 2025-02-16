Return-Path: <linux-pm+bounces-22163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD95A37207
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 06:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3825116DBC8
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E87481CD;
	Sun, 16 Feb 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRQ5cIQQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9C3209;
	Sun, 16 Feb 2025 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739682526; cv=none; b=Gmm0GI4flmz0APC1qoixRak5u6HFcrm/2/v2Pk65ygFt4w8Sxae9h8E/VTS/wGvlx/G5uiN2IT5Ur4VpZv7fhGzqND0Yo4J+Isa3xVR35ItFWq8Ey7kg3w5W6tcYW3aW83jyva5d9KZ0ts+KQ6F5xMhdCE32p9uj41xAqDvFscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739682526; c=relaxed/simple;
	bh=TjMHj92f3aH5T5tcN0AWk+5u5VvS/UjV5tTtkNWW/KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TniLs/q1SQmV0ycwfZqBQNiMLpN635FHARVEzSa3y/IxRToNAlVYooOcOIMEuHeThXQuKIc/Ozv8t0CXCrnHISnQ9YhIrGNDuoIwk2LoIxlqwSHibGStOXNX/5drgNz46UcGEqlrlHI/7FppUrAu+YihXXZxKdTkql3kMkUpUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRQ5cIQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A528C4CEED;
	Sun, 16 Feb 2025 05:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739682523;
	bh=TjMHj92f3aH5T5tcN0AWk+5u5VvS/UjV5tTtkNWW/KU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aRQ5cIQQbUcCNuPYP8w+LHwJxNAcAx9aARni4FLB8wYgy+W2pPpi0R5rXEa/Wwrs1
	 xey0wH7u3eVEM+uliFQHM8gKlTKOFJ8beRMPfZvPDqwAjZUJ0vCZqL+Z7kl2t7hxr1
	 tyY0glmZin0Reir7ibYDR+BOEHTrwBy+5FKrxa/5htyWn7oZimqf5/vkRWLgImYUgw
	 wSjsBat66nelICFL2ri3gvdehwDaBZAQle4wYiUQDKyLROc0zqkLF5TJ9OU1LStqNi
	 cK8jWQI+VVWGMr/LtnVQj3o+RmVUuecAky/55POv04DYBS1mbu4Icdlbjj2mt/mlMx
	 iPsGXFwnBO4IQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab744d5e567so626425666b.1;
        Sat, 15 Feb 2025 21:08:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaNNj8ou6YPg2YhZsvC7pwIAufQpb0k9+9im71eSpWxljV18HFwmNKuIirfBZuhR8p4k2qi3v0@vger.kernel.org, AJvYcCXXQGvc4CyMIso/TTVhFp1RycssbOLJ5hB93feo02Kc51hqZwR/tU+ykLSejq5mnQ/Ok+ZruMeTyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqcSgex599tMkw6Bv1wviGMF4aX9ZMOxIxRIlOtL1RNMwygeW
	0qoSK6f6mrRMV4QWwjgpVeDU9LJrM3zLbYjwOt1cNVjZTHkM96x3q31kvtJTXK97xisRSRR2H4L
	OPykUznof0gqsYyjTqNfyPdQhF1I=
X-Google-Smtp-Source: AGHT+IG0uKd25dY1QefQSYqIH7OdcvhKYoVhskTkARo2TPH/qMDXTbbtCOZRrar1d9hRbIVAtnHQspupRqZZZjzgpwc=
X-Received: by 2002:a17:906:c14c:b0:aba:620a:acf7 with SMTP id
 a640c23a62f3a-abb708aaf52mr569004266b.10.1739682521939; Sat, 15 Feb 2025
 21:08:41 -0800 (PST)
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
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local> <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>
 <Z7CfLlEw9vtbFJwI@MacBook-Air-5.local>
In-Reply-To: <Z7CfLlEw9vtbFJwI@MacBook-Air-5.local>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 16 Feb 2025 13:08:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40eTo+tUx8b8=j4_9sfq7i9wo-LSO9pHKmRU7=wDDdbw@mail.gmail.com>
X-Gm-Features: AWEUYZk9z8Ky-eeelh-PyAQijbE-EnoVcqWYGSYclbdmVVJgV2PTlUciZ2MX3Q4
Message-ID: <CAAhV-H40eTo+tUx8b8=j4_9sfq7i9wo-LSO9pHKmRU7=wDDdbw@mail.gmail.com>
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

On Sat, Feb 15, 2025 at 10:05=E2=80=AFPM Harry (Hyeonggon) Yoo
<42.hyeyoo@gmail.com> wrote:
>
> On Sat, Feb 15, 2025 at 05:53:29PM +0800, Huacai Chen wrote:
> > On Fri, Feb 14, 2025 at 8:45=E2=80=AFPM Harry (Hyeonggon) Yoo
> > <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> > > > On Fri, Feb 14, 2025 at 5:33=E2=80=AFPM Harry (Hyeonggon) Yoo
> > > > <42.hyeyoo@gmail.com> wrote:
> > > > >
> > > > > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > > > > Hi, Harry,
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 11:39=E2=80=AFPM Harry (Hyeonggon) Yoo
> > > > > > <42.hyeyoo@gmail.com> wrote:
> > > > > > > On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhua=
cai@loongson.cn> wrote:
> > > > > > > >
> > > > > > > > Hibernation assumes the memory layout after resume be the s=
ame as that
> > > > > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this =
assumption.
> > > > > > >
> > > > > > > Could you please elaborate what do you mean by
> > > > > > > hibernation assumes 'the memory layout' after resume be the s=
ame as that
> > > > > > > before sleep?
> > > > > > >
> > > > > > > I don't understand how updating random_kmalloc_seed breaks re=
suming from
> > > > > > > hibernation. Changing random_kmalloc_seed affects which kmall=
oc caches
> > > > > > > newly allocated objects are from, but it should not affect th=
e objects that are
> > > > > > > already allocated (before hibernation).
> > > > > >
> > > > > > When resuming, the booting kernel should switch to the target k=
ernel,
> > > > > > if the address of switch code (from the booting kernel) is the
> > > > > > effective data of the target kernel, then the switch code may b=
e
> > > > > > overwritten.
> > > > >
> > > > > Hmm... I'm still missing some pieces.
> > > > > How is the kernel binary overwritten when slab allocations are ra=
ndomized?
> > > > >
> > > > > Also, I'm not sure if it's even safe to assume that the memory la=
yout is the
> > > > > same across boots. But I'm not an expert on swsusp anyway...
> > > > >
> > > > > It'd be really helpful for linux-pm folks to clarify 1) what are =
the
> > > > > (architecture-independent) assumptions are for swsusp to work, an=
d
> > > > > 2) how architectures dealt with other randomization features like=
 kASLR...
> > > >
> > >
> > > [+Cc few more people that worked on slab hardening]
> > >
> > > > I'm sorry to confuse you. Binary overwriting is indeed caused by
> > > > kASLR, so at least on LoongArch we should disable kASLR for
> > > > hibernation.
> > >
> > > Understood.
> > >
> > > > Random kmalloc is another story, on LoongArch it breaks smpboot whe=
n
> > > > resuming, the details are:
> > > > 1, LoongArch uses kmalloc() family to allocate idle_task's
> > > > stack/thread_info and other data structures.
> > > > 2, If random kmalloc is enabled, idle_task's stack in the booting
> > > > kernel may be other things in the target kernel.
> > >
> > > Slab hardening features try so hard to prevent such predictability.
> > > For example, SLAB_FREELIST_RANDOM could also randomize the address
> > > kmalloc objects are allocated at.
> > >
> > > Rather than hacking CONFIG_RANDOM_KMALLOC_CACHES like this, we could
> > > have a single option to disable slab hardening features that makes
> > > the address unpredictable.
> > >
> > > It'd be nice to have something like ARCH_SUPPORTS_SLAB_RANDOM which
> > > some hardening features depend on. And then let some arches condition=
ally
> > > not select ARCH_SUPPORTS_SLAB_RANDOM if hibernation's enabled
> > > (at cost of less hardening)?
> >
> > This is not good, my patch doesn't disable RANDOM for hibernation, it
> > just delays the initialization. When the system is running, all
> > randomization is still usable.
>
> I think at least we need a rule (like ARCH_SUPPORTS_SLAB_RANDOM)
> for slab hardening features that prevents breaking hibernation
> in the future. Without rules, introducing new hardening features could
> break hibernation again.
I don't think so, even if on LoongArch, hibernation and various RANDOM
infra can co-exist (need some adjustment). Even if hibernation cannot
be used together with kASLR, we don't disable it at build time but at
run time. This means we can choose hibernation or kASLR with a single
kernel image.

>
> But I'm not yet convinced if it's worth the complexity of hacking slab
> hardening features (for security) just to make hibernation work on
> some arches, which have already disabled kASLR anyway...
I don't think this patch is an ugly hack, it is a proper adjustment.
Random kmalloc can still work with hibernation, delaying the seed
initialization only makes that random kmalloc doesn't work (fallback
to predictable kmalloc) for a very short time during the boot phase.
And again, kASLR is disable at run time rather than build time.

>
> > For SLAB_FREELIST_RANDOM, I found that it doesn't break hibernation
> > (at least on LoongArch), the reason is:
> > 1. When I said "data overwritten" before, it doesn't mean that every
> > byte shouldn't be overwritten, only some important parts matter.
> > 2. On LoongArch, the important parts include: switch code, exception
> > handlers, idle_task's stack/thread_info.
> > 3. switch code and exception handlers are protected by automatically
> > disabling kASLR from arch-specific code, idle_task's stack/thread_info
> > is protected by delaying random seeds (this patch).
> >
> > Why SLAB_FREELIST_RANDOM doesn't corrupt idle_task's
> > stack/thread_info? Because the scope of randomization of
> > SLAB_FREELIST_RANDOM is significantly less than RANDOM_KMALLOC_CACHES.
> > When RANDOM_KMALLOC_CACHES enabled,
>
> You mean when SLAB_FREELIST_RANDOM enabled?
> Assuming that...
Yes.

>
> > the CPU1's idle task stack from
> > the booting kernel may be the CPU2's idle task stack from the target
> > kernel, and CPU2's idle task stack from the booting kernel may be the
> > CPU1's idle task stack from the target kernel
>
> What happens if it's not the case?
SLAB means "objects with the same type", right? So it is probably the
case. Yes, there is a very very low possibility that not the case,
but...

In theory x86_64 also has a low possibility that the idle task's stack
or other metadata be overwritten, then should we also disable random
kmalloc for x86_64?

On the other hand, if we really need to handle this theoretic
possibility about SLAB_FREELIST_RANDOM now, we can simply move
init_freelist_randomization() after all initcalls, too.

Huacai

>
> > but idle task's stack
> > from the booting kernel won't be other things from the target kernel
> > (and won't be overwritten by switching kernel).
>
> What guarantees that it won't be overwritten?
> To me it seems to be a fragile assumption that could be broken.
>
> Am I missing something?
>
> --
> Harry

