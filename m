Return-Path: <linux-pm+bounces-22879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A67A43DC1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EF173927
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD143DBB6;
	Tue, 25 Feb 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh0x9/uf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D612BB13;
	Tue, 25 Feb 2025 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483327; cv=none; b=Iq8398AJedG5rTnOxdpKjso7kkrJwKffjclnR4PG9ufwnKpt2rlOZDf4QVe1DUlMb7WaQeADdiGV6rh5yXUUYMazdNAp4CLSFKjkWMy4H5glpfHiIy8bU1cwBMiDYxQl52tffTa+AVgCWwUGh0JrxdonQl4Ftr4JNhw5YAubtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483327; c=relaxed/simple;
	bh=KXFZfcc7XbnsLiwkxI328DODcNjmY7AfOm4ZSVUusbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAAZWoGkXKXwe84iWh2fjzDWpkx3EKAAloxBUkIkv/4qjg4OgrfX3Y4Twkw9F+bDphUEUUlCZeWJT3yKgmrUgSHrGPzeXzWeMxqQEf+lOoZLsexvbrq8FYAeW+J7oWbybZHfA6Y2r1uEKHJYAuULslaGsH3pk7wQfffwkCvgtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh0x9/uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F175C4CEE9;
	Tue, 25 Feb 2025 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740483326;
	bh=KXFZfcc7XbnsLiwkxI328DODcNjmY7AfOm4ZSVUusbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qh0x9/uf4R1sR0/Rl8ln53jCjkTU97MmFMxgzZy7UrSI403zrugaLWC1UjXnrlA94
	 rAZ42ro7SyRS4zmyMR3+bA42+oMhF1bPTddNAw6wPkj3xxtuuN0smK79b8+628veAk
	 2n2ngsoqvnsco/aD8N4ndLd7pW6IXwct8SQqEwcUacyuL4nh46znKa5VDg8YIcyxIm
	 DB/XtsGhQFRCdB5iSIpHNuQ6JTr6tmudCXMFmJwUrPWcuKJPEnMtisZC8XLpaX3LTm
	 Pr0xStRQmAKAtQlgNdcCwAeoRnARbRSK1pxRzbJuhjuB3VKewMB1qeanLMVutqMTUW
	 S5HRvaqlQscvw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab78e6edb99so770408066b.2;
        Tue, 25 Feb 2025 03:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/jERD0lAtIu4UW/B+mw7Wg2obtmR5d1r1FNBDjoz45JTdKDeP++BlEE7Oq+BpAr1Ttac709f8AQ==@vger.kernel.org, AJvYcCW+J//3IL2gWb7bYYhE57m9WwIy0ESIdAbRIQCgdW3hzSRcxZgSTVYJS7FvkdB8I/3elvoOPmEm@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAR1fJuoatXs2MqGxrDBQnqwE8Z+ZkMAM9gxBZA32SUwgCHL3
	a6kH1rLzIkDaJ1esHSZk5+8+VQE3+wLUyBjNd30HUVcCozY6+XkxbaNIiigCJIDAMwbDaXTLiDX
	hAzbrBG6AiGoKC//yiIY3ZVnwc3M=
X-Google-Smtp-Source: AGHT+IHpNm5R6d1kXnggyLRBiCFLHj7c8aZbt3rfulQuZsViVrgOnfz9UD3ihQBKZctEaUuFInNweAbCbQHy84PcLNQ=
X-Received: by 2002:a17:906:110d:b0:abe:cccf:ac88 with SMTP id
 a640c23a62f3a-abecccfb0a7mr357469566b.54.1740483324943; Tue, 25 Feb 2025
 03:35:24 -0800 (PST)
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
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local> <202502190921.6E26F49@keescook> <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 19:35:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp9_oaXVTIfpV_aoA35urmG2ZqS7ChPrwpnZ1qyFh1PmoCPuWDgFLWstUE
Message-ID: <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	stable@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Harry, Kees, and Rafael,

On Thu, Feb 20, 2025 at 2:09=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 19, 2025 at 6:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Fri, Feb 14, 2025 at 09:44:59PM +0900, Harry (Hyeonggon) Yoo wrote:
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
> > I find this whole thread confusing. :) Hibernation should already do
> > whatever it need to to get out of the way of the kernel it is restoring
> > to memory. The random locations shouldn't matter at all: they're all
> > stored in the image. I am not a hibernation expert, but my understandin=
g
> > is that the "resume" kernel moves itself out of the way to restore the
> > KASLR-ed hibernation image and puts everything back exactly as it was.
> > Randomization should not matter at all: it's just simply "put everythin=
g
> > back where it was".
>
> Exactly.
>
> > Yes, the tricky part is the "move itself out of the way", but that's
> > required for any kernel that support being relocatable (a prerequisite
> > for KASLR), and KASLR is just an aggressive form of "the relocatable
> > kernel might be anywhere" beyond just different boot loaders putting it
> > in a handful of different potential offsets.
I have investigated deeper, and then found it is an arch-specific
problem (at least for LoongArch), and the correct solution is here:
https://lore.kernel.org/loongarch/20250225111812.3065545-1-chenhuacai@loong=
son.cn/T/#u

But I don't know how to fix arm64.

Huacai

>
> Right.
>
> Thanks!

