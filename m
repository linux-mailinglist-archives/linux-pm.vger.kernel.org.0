Return-Path: <linux-pm+bounces-22462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E347A3C70E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7723B635B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B12147EF;
	Wed, 19 Feb 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYbhlB2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B331FDE02;
	Wed, 19 Feb 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988591; cv=none; b=CsT3+eSjb7w0Wy5wKnEP4zYzJgu89/igM94lfO78omCGU4MOOSLKEigaZ0aGyklPRz8bFtswjJLnNNjyF28TYLAsPsVZkcOV127d1bF1jkeDZyfRrdEJTsrcoDcPgt4fl1JaarAwaY1UwLEys2Ty6LFmatMnhRuXk6GMBCJ0Lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988591; c=relaxed/simple;
	bh=N9vSWcUq0IGl/jxpCF6PvN75WrUJPDE//1NmUV7Xpys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owBGCLILXSMaUc0kO6V3jYfpZIxtXDSJqy8+bCgUG2SLrQDr8CwsMcT212HSuXM2lK4ey7z6U+p+rbawIDVSRPUJHDLQvTA54mgqy8Ztc9yf8/ZbSud5H54Liwf9ZeMZIQQmaxXu5Sjb35lcp289AaEgdTUMwxgQ09d8nKSu0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYbhlB2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB2FC4CEEA;
	Wed, 19 Feb 2025 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988591;
	bh=N9vSWcUq0IGl/jxpCF6PvN75WrUJPDE//1NmUV7Xpys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AYbhlB2SoBU/JhLkTCzTOjVE2/wh40dB0pBnwxCsu8YfqdwgNpA/bvcF5LLi1ZwDG
	 v70YlBZKaK55WK5rfKRoTuc9deuT43KM/m4Pb0kMgO6f+qPlR9anJ8hyNi0OfhAdtv
	 ZHbJ8q/rvUWJbQmF5MjwCpiF9F54khUdO/fhjIF+5a4BeTmzfpLxpyOTnntxqWqqZQ
	 D84ShXzIMRE4MaMYuU3BaL1/DBAvQbn9Tzyf+CloTiTGrCsGKFGDnFPySYHiYy7fH6
	 cWpU7sX41F2P7/S9VbYdogVxpVfR+a6nkKuOtYBRgqtCbaR8yZqhXrEShYYr1xFwX2
	 ddjvgE+iz3gMQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3e7a00d39so46307b6e.1;
        Wed, 19 Feb 2025 10:09:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpfYYU2o7OPYwZU6ygV+uKi8qmN9IeLsvuG9pupOMFVtaUStrS/xh58RtPvip4UtUimCRhqytpqg==@vger.kernel.org, AJvYcCXRnb8e29vubus5tiz7tt6Hql17zuIDq54+D0fFqR791F8P+YzGJPTxkERrtbK6bNhV1bhp1cg/@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXXvgSOZR0zQAfb4n+eoeyEVpZIMA7fPfQCOawIINv7q/J05M
	lsvwtzkVrXPgmLRSVDZlM858FnTFlMiGZ9nfUm2b8H22FxT0Mywx7+8rNeV46II1WbQsQzxLPQp
	mgHoEGiDLKFghVuK+hUZ65PloYHA=
X-Google-Smtp-Source: AGHT+IEzRVlMusSMhWJrKyb/zQLVYBZSqkVptzLtiq0YDdKI0GR2lLsCO5YX7YYNCeBkDo7XSEe8XU/28DSCo8iH808=
X-Received: by 2002:a05:6808:1316:b0:3f3:b6c2:a29 with SMTP id
 5614622812f47-3f3eb0a4145mr12494123b6e.7.1739988590372; Wed, 19 Feb 2025
 10:09:50 -0800 (PST)
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
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local> <202502190921.6E26F49@keescook>
In-Reply-To: <202502190921.6E26F49@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Feb 2025 19:09:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
X-Gm-Features: AWEUYZk3yJjC2QFMzoCRuV9g3yUGclC0qBadjE9zX-9osdlpTZtdfn3fLdIXWJY
Message-ID: <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
To: Kees Cook <kees@kernel.org>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	stable@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 6:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Feb 14, 2025 at 09:44:59PM +0900, Harry (Hyeonggon) Yoo wrote:
> > On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> > > On Fri, Feb 14, 2025 at 5:33=E2=80=AFPM Harry (Hyeonggon) Yoo
> > > <42.hyeyoo@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > > > Hi, Harry,
> > > > >
> > > > > On Wed, Feb 12, 2025 at 11:39=E2=80=AFPM Harry (Hyeonggon) Yoo
> > > > > <42.hyeyoo@gmail.com> wrote:
> > > > > > On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhuaca=
i@loongson.cn> wrote:
> > > > > > >
> > > > > > > Hibernation assumes the memory layout after resume be the sam=
e as that
> > > > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this as=
sumption.
> > > > > >
> > > > > > Could you please elaborate what do you mean by
> > > > > > hibernation assumes 'the memory layout' after resume be the sam=
e as that
> > > > > > before sleep?
> > > > > >
> > > > > > I don't understand how updating random_kmalloc_seed breaks resu=
ming from
> > > > > > hibernation. Changing random_kmalloc_seed affects which kmalloc=
 caches
> > > > > > newly allocated objects are from, but it should not affect the =
objects that are
> > > > > > already allocated (before hibernation).
> > > > >
> > > > > When resuming, the booting kernel should switch to the target ker=
nel,
> > > > > if the address of switch code (from the booting kernel) is the
> > > > > effective data of the target kernel, then the switch code may be
> > > > > overwritten.
> > > >
> > > > Hmm... I'm still missing some pieces.
> > > > How is the kernel binary overwritten when slab allocations are rand=
omized?
> > > >
> > > > Also, I'm not sure if it's even safe to assume that the memory layo=
ut is the
> > > > same across boots. But I'm not an expert on swsusp anyway...
> > > >
> > > > It'd be really helpful for linux-pm folks to clarify 1) what are th=
e
> > > > (architecture-independent) assumptions are for swsusp to work, and
> > > > 2) how architectures dealt with other randomization features like k=
ASLR...
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
> > some hardening features depend on. And then let some arches conditional=
ly
> > not select ARCH_SUPPORTS_SLAB_RANDOM if hibernation's enabled
> > (at cost of less hardening)?
>
> I find this whole thread confusing. :) Hibernation should already do
> whatever it need to to get out of the way of the kernel it is restoring
> to memory. The random locations shouldn't matter at all: they're all
> stored in the image. I am not a hibernation expert, but my understanding
> is that the "resume" kernel moves itself out of the way to restore the
> KASLR-ed hibernation image and puts everything back exactly as it was.
> Randomization should not matter at all: it's just simply "put everything
> back where it was".

Exactly.

> Yes, the tricky part is the "move itself out of the way", but that's
> required for any kernel that support being relocatable (a prerequisite
> for KASLR), and KASLR is just an aggressive form of "the relocatable
> kernel might be anywhere" beyond just different boot loaders putting it
> in a handful of different potential offsets.

Right.

Thanks!

