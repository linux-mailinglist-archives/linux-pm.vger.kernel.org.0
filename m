Return-Path: <linux-pm+bounces-22073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60CA35B13
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 11:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A5B16FADD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63470253F0A;
	Fri, 14 Feb 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBUzqpiZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C3186E40;
	Fri, 14 Feb 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527385; cv=none; b=lwhGHlVY9yc6qW0Or02wU4flTfMySj/BJQL2Wz3bCtDrCuWmXKLm4DPfxVgFGBzm4hEJoI0uCxupqRk76lxH5ATJonp8adOVHxZXQvEmzxiS7i2w13OEzJ1loYdMueGc/5ce2fjdbws+PVAGMpZ0HzLol0BvCd1sN4NcCjCCaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527385; c=relaxed/simple;
	bh=jO4jhFQ85OnGWdW5dvqK63uV1QT1n3kqXLhiHck4gg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBQ5821/y0mu6GoCuyLl1qxI4kyh9V3i74Szkwl/lM8sOWKLMSTcRpgGWL6Arodm0BkUDEsudwWqHYBKtZIRhnU9CvdfZsi/wvQ4zjkH/m70OJSvdQK/Xu7lyfDK10bKBPZbFmLCGO5yfxn8rahSjXigFR7Vd0tBv7h5Ab8VuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBUzqpiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0184C4CEF1;
	Fri, 14 Feb 2025 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739527384;
	bh=jO4jhFQ85OnGWdW5dvqK63uV1QT1n3kqXLhiHck4gg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBUzqpiZM2kg4A4aIeNUBUOibeqSOVdTCCgLV7S9YEmAYGt0NjfihqdFPpBOv0s0W
	 jHiJpvv422oeAnxPw9TgpAFL6ICc1RXReG+91+C3kqltaHlwiD83sE0iG0GzYL25Se
	 blcuqwNMeJwYvQyxs1zgwx6Rro5vOwC6vuoiusWrnlvGszdUg7AcL1Kt9BQmDKdjJ4
	 +tlmYpT+SkOSAa8HJqIo9OJVccxvkB+1QKjFtTK1LLcqSWCpF9lSH5NjFMBNwJUlzE
	 jnzVUo05iIxhqGda+jA0qwijumlXdQZ1Fdr7ca+Cy0eyaPRi0mZb54o9rzVenriGTS
	 8022g8FGeOiBw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7430e27b2so345813666b.3;
        Fri, 14 Feb 2025 02:03:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/9GCi8QWyRzpRsfzThdXcWBcGtHB9i7dB1MMQVeWbIh5cSj7zifHDMGQiftrqlcx42rzUo0eH@vger.kernel.org, AJvYcCWWnpssKyi98J2t8GgVlDHdp0ZSE04KzVx7w+rjeVLI7alWR+m424d01Ed96IxfQwFacDBi+K3LAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcEeaLntqyAGPmWI7BX59MU3TOtLkwXN+F6YzZaN4bWAn9bf1
	lwl6QvuraaBqU5iLwRjafDXQTawt6eqAGMI6J6ia+LZ1toFWVcDoIUqoWWeXKxghzdH4adiJsNh
	oSIerDa3jTOHXRCzHYAuaW6yIOlY=
X-Google-Smtp-Source: AGHT+IF+gf9jQe7+2YADT4xx62KGGZLtUQx0JukYMtr4LvBbe4Kkbx3IFmzUu9eWSkMmaKUi5YdGeXvyYy9vwpY3NL4=
X-Received: by 2002:a17:907:7b06:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-ab7f334aa67mr1128081866b.2.1739527382895; Fri, 14 Feb 2025
 02:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com> <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
In-Reply-To: <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Feb 2025 18:02:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
X-Gm-Features: AWEUYZm7CELBuJgCgpXlQjQwq3zKmA4KOCzMtVj82ho-oFkUscdkn1NgvHwjb6Q
Message-ID: <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
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
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:33=E2=80=AFPM Harry (Hyeonggon) Yoo
<42.hyeyoo@gmail.com> wrote:
>
> On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > Hi, Harry,
> >
> > On Wed, Feb 12, 2025 at 11:39=E2=80=AFPM Harry (Hyeonggon) Yoo
> > <42.hyeyoo@gmail.com> wrote:
> > > On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhuacai@loon=
gson.cn> wrote:
> > > >
> > > > Hibernation assumes the memory layout after resume be the same as t=
hat
> > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumpti=
on.
> > >
> > > Could you please elaborate what do you mean by
> > > hibernation assumes 'the memory layout' after resume be the same as t=
hat
> > > before sleep?
> > >
> > > I don't understand how updating random_kmalloc_seed breaks resuming f=
rom
> > > hibernation. Changing random_kmalloc_seed affects which kmalloc cache=
s
> > > newly allocated objects are from, but it should not affect the object=
s that are
> > > already allocated (before hibernation).
> >
> > When resuming, the booting kernel should switch to the target kernel,
> > if the address of switch code (from the booting kernel) is the
> > effective data of the target kernel, then the switch code may be
> > overwritten.
>
> Hmm... I'm still missing some pieces.
> How is the kernel binary overwritten when slab allocations are randomized=
?
>
> Also, I'm not sure if it's even safe to assume that the memory layout is =
the
> same across boots. But I'm not an expert on swsusp anyway...
>
> It'd be really helpful for linux-pm folks to clarify 1) what are the
> (architecture-independent) assumptions are for swsusp to work, and
> 2) how architectures dealt with other randomization features like kASLR..=
.
I'm sorry to confuse you. Binary overwriting is indeed caused by
kASLR, so at least on LoongArch we should disable kASLR for
hibernation.

Random kmalloc is another story, on LoongArch it breaks smpboot when
resuming, the details are:
1, LoongArch uses kmalloc() family to allocate idle_task's
stack/thread_info and other data structures.
2, If random kmalloc is enabled, idle_task's stack in the booting
kernel may be other things in the target kernel.
3, When CPU0 executes the switch code, other CPUs are executing
idle_task, and their stacks may be corrupted by the switch code.

So in experiments we can fix hibernation only by moving
random_kmalloc_seed initialization after smp_init(). But obviously,
moving it after all initcalls is harmless and safer.


Huacai

>
> > For LoongArch there is an additional problem: the regular kernel
> > function uses absolute address to call exception handlers, this means
> > the code calls to exception handlers should at the same address for
> > booting kernel and target kernel.
>
> --
> Harry

