Return-Path: <linux-pm+bounces-22081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115CA35DD4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C21188B1E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9F2753E0;
	Fri, 14 Feb 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN0Bw6Pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17C2753E7;
	Fri, 14 Feb 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537112; cv=none; b=txxAgOflswoGqMzzloe7IjBRwmZVo7q8lMoqYvOu5n0n5QLz9Aj+dHn739TwdHFTNIUfp5P9G3FO1JEbYpOd/6YcoZhsB3AgGqX04g6LBsgKY9JauEepIjaalLUMJ9duq+826syFn4BBxzlU6CXkyk5eRcjQ6JK63o75kHDbHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537112; c=relaxed/simple;
	bh=R4hy37vGkrYE28S6AwTj2N9aT+HvyWMv8kU/AQ+7b9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwit6o9l0UkLxBTEZERW4Ggxk4108N8OeJhjWzKRtpWwYfaWH/vuLs4Yvmv/bRBparsSTC+O17cdta2BtMqeP+kvHSHjpr31i6zRrK87o8Hlpi9lBrvhNBOWQc54ULx+NGDsCKKzUDNzp/NHgudfD3hXWAg8k8pFLmREQuGfm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN0Bw6Pp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e6028214so25331535ad.0;
        Fri, 14 Feb 2025 04:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739537110; x=1740141910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV91Ol/uGYlZ+kAk8FUPrqnABFWgsBeEvSHw1qGc9Ow=;
        b=lN0Bw6PpJOW5nsaLExFin9D18N8qMZf7NbkOLHcv1da+fDYghXs+WZpRtayoPoVZxl
         /mz/fP+gcdObCHxdLNW+jFms7EMgcjVu5teocGek82JBM2lhLZzlAMsBUK8QRJ6KoU/B
         JJArZ86D+vZgFTcghepJlovi/CixEdv+tCwgPL7MkM6fCw1odL1/3CY/a8AaM3cJMpTb
         HrpYPWlUKn3eBo1F4bB4/J5C4Fw3gRMDwQ+gWqpaHvogM9G0IDjzJynLN01awi0Oqc8R
         5XDljqngFAyvbYlgA79g4UhSwO6Hya+CC2OQmOaWtRCr3dMi76cDItbKUGz2AMXOXj9z
         /YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537110; x=1740141910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV91Ol/uGYlZ+kAk8FUPrqnABFWgsBeEvSHw1qGc9Ow=;
        b=C6D8QJtJfcAnqJkKVwNgnika5SDB7kAQG0KOYazzpxpseg10I1Z1INIkK/ANGdfcr3
         RHJ04g5Hq8Gm11jgUNXQVgRsgtN4PVxWEU7REwmdPZ5KdtCVlM/QvIcwnIQtrddBKMZ4
         5SzmeC9bzt2N7IRqTz7iDWOg2kWqepVctXtJUorINMGDFlonuI9KEbEUk6m042dCqDND
         4KRVBSnfjkULe5mfRdIiT6CMds2OxWlDHhE83EbqWOqxKB70QkNfNXTCHfcMwZQQk1S2
         CVNoJnU2kMZkGV72bl24wfyQ1Q5bWEVC+ghGpdxmJ98g/ru0CcHDlSGDP+5QeyLCmg0F
         d4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNZGtev4QJTxLlfPp0T0U9AsXkONgM0v1BK2gxBVwq2D53ffkIJHi3vUlw1GoQ6/dGQz5lgXa@vger.kernel.org, AJvYcCX0MzLMZD06fi+eOisD9POWOpkjBgFeHDdA8+umgZ0E2vnAZboa9TZUbIFgwx8X80s/LfjyjTl1sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPMAil1m9dkIuqGg09dWwM8HRVIyFz+zhekX63MP1UZjx/JiT
	0ylc49kLnzNbo2nRVcgASb+3ibZTYUU3IhHBD8k7L1WJdVm1Kien
X-Gm-Gg: ASbGncueSiHpbNfRE16j3rPZ7SYFChvtG9Chix1oIWAx6FJE4JCsTlLR8y4HsA/EiX/
	pU1qGr1nRqHHPBQ0pWx9k8Zn7dD+WCHbfiRI9jcNor5jZWD7JPH7F2prJfkuHc3QeP8i19QFPQ1
	UwQvGicYkSnpSBJY7yyDKYzquOWITZHaCUPFiOg1xEYEIwa3ybHxVt/dexyHAFHN14KuuVQwSWx
	6iTlNQAtba74lpY9J4FTkrWsdbJPzTXZz5FPvxOsmpmlnHpTDrXjjLzqwWiMIZ7LUFN297UwbWD
	t9id2gXg66MpbpE+ltCaPh/Lwy6FI/1eIfXCsrc=
X-Google-Smtp-Source: AGHT+IE2e69StPZgPQBveZ5VZ37UHrxEJkVNnJNFO7ZcVLIcz2YwL+02E7YjNANvrPV/HbkC5GN3wg==
X-Received: by 2002:a05:6a00:2e84:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-7322c56f984mr16408464b3a.4.1739537110062;
        Fri, 14 Feb 2025 04:45:10 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256e8aasm3030618b3a.70.2025.02.14.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:45:09 -0800 (PST)
Date: Fri, 14 Feb 2025 21:44:59 +0900
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
Message-ID: <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>

On Fri, Feb 14, 2025 at 06:02:52PM +0800, Huacai Chen wrote:
> On Fri, Feb 14, 2025 at 5:33 PM Harry (Hyeonggon) Yoo
> <42.hyeyoo@gmail.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> > > Hi, Harry,
> > >
> > > On Wed, Feb 12, 2025 at 11:39 PM Harry (Hyeonggon) Yoo
> > > <42.hyeyoo@gmail.com> wrote:
> > > > On Wed, Feb 12, 2025 at 11:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > >
> > > > > Hibernation assumes the memory layout after resume be the same as that
> > > > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
> > > >
> > > > Could you please elaborate what do you mean by
> > > > hibernation assumes 'the memory layout' after resume be the same as that
> > > > before sleep?
> > > >
> > > > I don't understand how updating random_kmalloc_seed breaks resuming from
> > > > hibernation. Changing random_kmalloc_seed affects which kmalloc caches
> > > > newly allocated objects are from, but it should not affect the objects that are
> > > > already allocated (before hibernation).
> > >
> > > When resuming, the booting kernel should switch to the target kernel,
> > > if the address of switch code (from the booting kernel) is the
> > > effective data of the target kernel, then the switch code may be
> > > overwritten.
> >
> > Hmm... I'm still missing some pieces.
> > How is the kernel binary overwritten when slab allocations are randomized?
> >
> > Also, I'm not sure if it's even safe to assume that the memory layout is the
> > same across boots. But I'm not an expert on swsusp anyway...
> >
> > It'd be really helpful for linux-pm folks to clarify 1) what are the
> > (architecture-independent) assumptions are for swsusp to work, and
> > 2) how architectures dealt with other randomization features like kASLR...
>

[+Cc few more people that worked on slab hardening]

> I'm sorry to confuse you. Binary overwriting is indeed caused by
> kASLR, so at least on LoongArch we should disable kASLR for
> hibernation.

Understood.

> Random kmalloc is another story, on LoongArch it breaks smpboot when
> resuming, the details are:
> 1, LoongArch uses kmalloc() family to allocate idle_task's
> stack/thread_info and other data structures.
> 2, If random kmalloc is enabled, idle_task's stack in the booting
> kernel may be other things in the target kernel.

Slab hardening features try so hard to prevent such predictability.
For example, SLAB_FREELIST_RANDOM could also randomize the address
kmalloc objects are allocated at.

Rather than hacking CONFIG_RANDOM_KMALLOC_CACHES like this, we could
have a single option to disable slab hardening features that makes
the address unpredictable.

It'd be nice to have something like ARCH_SUPPORTS_SLAB_RANDOM which
some hardening features depend on. And then let some arches conditionally
not select ARCH_SUPPORTS_SLAB_RANDOM if hibernation's enabled
(at cost of less hardening)?

-- 
Harry

> 3, When CPU0 executes the switch code, other CPUs are executing
> idle_task, and their stacks may be corrupted by the switch code.
>
> So in experiments we can fix hibernation only by moving
> random_kmalloc_seed initialization after smp_init(). But obviously,
> moving it after all initcalls is harmless and safer.
> 
> 
> Huacai
> 
> > > For LoongArch there is an additional problem: the regular kernel
> > > function uses absolute address to call exception handlers, this means
> > > the code calls to exception handlers should at the same address for
> > > booting kernel and target kernel.

