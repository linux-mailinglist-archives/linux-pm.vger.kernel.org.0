Return-Path: <linux-pm+bounces-22458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B6A3C61D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED07174BB1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2620E6F9;
	Wed, 19 Feb 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvHPgHJF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA302144A1;
	Wed, 19 Feb 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985927; cv=none; b=EMcF2uYuZAtplYHvFTdQYPGlu7eQ6+c66PAu6wMtHoWSqREiZlBfWr90ZDOrMb9TQhxz+1skYXYmwHtXnHY5vCWnaTmsTcfQ4uBTYr+xGJWqREBWfWvEboaEmGENHEGC/2negdrrNkazqyVXbrRTUwjB5SihfpYa6tb7E9trPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985927; c=relaxed/simple;
	bh=ikNfhXqco/zJZ8TCINjDGAPmg4V6noayeVHjFs0Yu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3gZB92EkHkW8Bb90feTB7VKb2qxRhcPgEC8VjdtF+6Ghk0hknan3D9kRWThyZ6Ab0xAT5fK/5muUFFFbeNtD1ReeJGPVJzwkWcTSvXr0JYY9NhgrVR8I7kNToQzvAOdK9pomHnUagbY7dr0bpxVeLGuncmIXYpIVRo2FVW+Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvHPgHJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F275C4CED1;
	Wed, 19 Feb 2025 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985927;
	bh=ikNfhXqco/zJZ8TCINjDGAPmg4V6noayeVHjFs0Yu/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvHPgHJFzQvrlD3awYsWUcla0n8dIxRVIbz4RH0VeLV8dwEFCU9Qf/wojt3GC0wlk
	 ++TcMiJI6krHRmoO7At+xX4ymyQFZoIYFB/LCTncBSKYccb1sAaHTYaw3MLAuD6SzD
	 6erSEDAVcsb561bKcI/1ineoDDo2KywCWcBD+GwqlbdsnLJ80DHKu0wrzDhXUv5abR
	 /34aQfH2jaf992/jpuMIZG8S8wmGUal9kkaUWdF3TNGJpfmC7Xuy5II8bcPxgFUvzB
	 jsgIyFqi5fwE+gwm8VUL1PG5PSWcHJ/0/vxj5HIcTQC6FhWCpOa6CMMu9DGj2aVJuO
	 FphIi8TJL1nWQ==
Date: Wed, 19 Feb 2025 09:25:24 -0800
From: Kees Cook <kees@kernel.org>
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
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
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
Message-ID: <202502190921.6E26F49@keescook>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>

On Fri, Feb 14, 2025 at 09:44:59PM +0900, Harry (Hyeonggon) Yoo wrote:
> On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> > On Fri, Feb 14, 2025 at 5:33 PM Harry (Hyeonggon) Yoo
> > <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > > Hi, Harry,
> > > >
> > > > On Wed, Feb 12, 2025 at 11:39 PM Harry (Hyeonggon) Yoo
> > > > <42.hyeyoo@gmail.com> wrote:
> > > > > On Wed, Feb 12, 2025 at 11:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > Hibernation assumes the memory layout after resume be the same as that
> > > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
> > > > >
> > > > > Could you please elaborate what do you mean by
> > > > > hibernation assumes 'the memory layout' after resume be the same as that
> > > > > before sleep?
> > > > >
> > > > > I don't understand how updating random_kmalloc_seed breaks resuming from
> > > > > hibernation. Changing random_kmalloc_seed affects which kmalloc caches
> > > > > newly allocated objects are from, but it should not affect the objects that are
> > > > > already allocated (before hibernation).
> > > >
> > > > When resuming, the booting kernel should switch to the target kernel,
> > > > if the address of switch code (from the booting kernel) is the
> > > > effective data of the target kernel, then the switch code may be
> > > > overwritten.
> > >
> > > Hmm... I'm still missing some pieces.
> > > How is the kernel binary overwritten when slab allocations are randomized?
> > >
> > > Also, I'm not sure if it's even safe to assume that the memory layout is the
> > > same across boots. But I'm not an expert on swsusp anyway...
> > >
> > > It'd be really helpful for linux-pm folks to clarify 1) what are the
> > > (architecture-independent) assumptions are for swsusp to work, and
> > > 2) how architectures dealt with other randomization features like kASLR...
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

I find this whole thread confusing. :) Hibernation should already do
whatever it need to to get out of the way of the kernel it is restoring
to memory. The random locations shouldn't matter at all: they're all
stored in the image. I am not a hibernation expert, but my understanding
is that the "resume" kernel moves itself out of the way to restore the
KASLR-ed hibernation image and puts everything back exactly as it was.
Randomization should not matter at all: it's just simply "put everything
back where it was".

Yes, the tricky part is the "move itself out of the way", but that's
required for any kernel that support being relocatable (a prerequisite
for KASLR), and KASLR is just an aggressive form of "the relocatable
kernel might be anywhere" beyond just different boot loaders putting it
in a handful of different potential offsets.

-- 
Kees Cook

