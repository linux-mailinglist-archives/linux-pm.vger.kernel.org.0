Return-Path: <linux-pm+bounces-21996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C5A33604
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B610188AF65
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A078204C27;
	Thu, 13 Feb 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de0A3Qf4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46E2046BA;
	Thu, 13 Feb 2025 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739416835; cv=none; b=hk42vtcuvpuY0rKzuzb70PhslWcwT1PYchUjzTDkOJgP3BTaNRKRJ9/TOO+2VUhnn6rh9Pl8d3hzgMYvTU2AJtKgpj29MigM9qIYT8WUmLMDnahYoCWbI0vdPntQyx3auOF7BsWFrmXt19yt/MkzOpHiprbL6c08OmjE0gA9Wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739416835; c=relaxed/simple;
	bh=ZZtTGc97rYuezRwymIH2Hj30+2Ig+dElar5rFqwGxTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twpTK2Jk92cPiD9h2EljKG+lDNOFNK3vCoKBwF+Cv7mwjvOyn4YtbJvALFQN3keOuykqm6aUqNnwq0vGXt81P0NRbsykwmWeZ8LqB7KiF8HKqcKG4lNjTjttAII26LTUxOV7mcJA7Y9pIT/xS8zJ5nM5ipBURYUqcV37TN6jWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de0A3Qf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E5C4CEE8;
	Thu, 13 Feb 2025 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739416834;
	bh=ZZtTGc97rYuezRwymIH2Hj30+2Ig+dElar5rFqwGxTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=de0A3Qf4Xj1Q3wrFa/BONbIsxubNb1elroOVkQnysNxvvngC1gwLSAwNduq3fxEsO
	 WJO3khkyOZmAG6oS6S6iBGQziE4y9RxfWaK7cKg0B0Rtno6Lbyvg2Zv1Y8zefVLoKV
	 Rb+k4i+vdfKUA9nFFDp8yGJfMQMz6Ynjmj8tBUY+aIn0qRDAXAMsPi+7HsLkVP9GQf
	 wtEiKMqv5JvNoy4wtx6KKXs4pHXagoHrUVLEbz7gth3Tr72Wa+2MfvRJS6rbBCSIY6
	 0yT7r7RpM8ZpgnR5tXWZzcmuE9ZwFgblME5vUs4v+fdsZCEDppkdVNpjsB8L6O+lIG
	 Z1Sn7COePJGVg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso78174766b.1;
        Wed, 12 Feb 2025 19:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhdXb6LRS8ARxReDfKHdoZ31JYDvQSqZsbgH9Do+SserfOkrOaayj3iarbc9ouS8eu5+okdk1c@vger.kernel.org, AJvYcCVltihLM+yYDAGIKQnYAbZ4mgCoU4c4tr7kdgCdq5XbW3heAsr5T8JRjARc7Dkh6bGznXCBG56sKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfexoZN7Vvth7NseeTq86wC3Ebm5C6l4iegGlZS3dkKsT66tw2
	ivTHEhJRCIdzguZ4D6lxz9xQLeInc+HN9aKGbpHDtcekdSnDd6wErp4sr4xQ8tlu2lhKXIrpQHS
	F1OIRAXFPM9bFvtsPa3OVROIM0OE=
X-Google-Smtp-Source: AGHT+IFmDko2YyfGXLm5N7dpgFRel/cJF8hEyY4/JBVR8gKi9tylitcgLg0rIQPxEOtT+fAIMByFWZ5LtW5BhSRGpSI=
X-Received: by 2002:a05:6402:4024:b0:5d0:efaf:fb73 with SMTP id
 4fb4d7f45d1cf-5deaddc10acmr5634218a12.15.1739416832930; Wed, 12 Feb 2025
 19:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212141648.599661-1-chenhuacai@loongson.cn> <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
In-Reply-To: <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 13 Feb 2025 11:20:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
X-Gm-Features: AWEUYZkPCPR1x9EMHB3sgDzhdPaQ_MLs8QhmK6dDB4tI1CFXaY4nt5-W7kb1leg
Message-ID: <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Initialise random_kmalloc_seed after initcalls
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

Hi, Harry,

On Wed, Feb 12, 2025 at 11:39=E2=80=AFPM Harry (Hyeonggon) Yoo
<42.hyeyoo@gmail.com> wrote:
>
> On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhuacai@loongson=
.cn> wrote:
> >
> > Hibernation assumes the memory layout after resume be the same as that
> > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
>
> [Let's also Cc SLAB ALLOCATOR folks in MAINTAINERS file]
>
> Could you please elaborate what do you mean by
> hibernation assumes 'the memory layout' after resume be the same as that
> before sleep?
>
> I don't understand how updating random_kmalloc_seed breaks resuming from
> hibernation. Changing random_kmalloc_seed affects which kmalloc caches
> newly allocated objects are from, but it should not affect the objects th=
at are
> already allocated (before hibernation).
When resuming, the booting kernel should switch to the target kernel,
if the address of switch code (from the booting kernel) is the
effective data of the target kernel, then the switch code may be
overwritten.

For LoongArch there is an additional problem: the regular kernel
function uses absolute address to call exception handlers, this means
the code calls to exception handlers should at the same address for
booting kernel and target kernel.

>
> > At least on LoongArch and ARM64 we observed failures of resuming from
> > hibernation (on LoongArch non-boot CPUs fail to bringup, on ARM64 some
> > devices are unusable).
>
> Did you have any chance to reproduce it on x86_64?
I haven't reproduce on x86_64, but I have heard that x86_32 has problems.

>
> > software_resume_initcall(), the function which resume the target kernel
> > is a initcall function. So, move the random_kmalloc_seed initialisation
> > after all initcalls.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3c6152940584290668 ("Randomized slab caches for kmalloc()")
> > Reported-by: Yuli Wang <wangyuli@uniontech.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >
> >  init/main.c      | 3 +++
> >  mm/slab_common.c | 3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 2a1757826397..1362957bdbe4 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1458,6 +1458,9 @@ static int __ref kernel_init(void *unused)
> >         /* need to finish all async __init code before freeing the memo=
ry */
> >         async_synchronize_full();
> >
> > +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> > +       random_kmalloc_seed =3D get_random_u64();
> > +#endif
>
> It doesn=E2=80=99t seem appropriate to put slab code in kernel_init.
>
> Additionally, it introduces a dependency that the code must be executed
> after all late_initcalls, which sounds like introducing yet another
> type of initcall.
What about introducing a function to initialize kmalloc seed in
slab_common.c, and then call it at kernel_init()? I don't have a
better solution than this.

>
> >         system_state =3D SYSTEM_FREEING_INITMEM;
> >         kprobe_free_init_mem();
> >         ftrace_free_init_mem();
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 4030907b6b7d..23e324aee218 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -971,9 +971,6 @@ void __init create_kmalloc_caches(void)
> >                 for (i =3D KMALLOC_SHIFT_LOW; i <=3D KMALLOC_SHIFT_HIGH=
; i++)
> >                         new_kmalloc_cache(i, type);
> >         }
> > -#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> > -       random_kmalloc_seed =3D get_random_u64();
> > -#endif
>
> I have no idea how hibernation and resume work, but let me ask here:
> Can we simply skip or defer updating random_kmalloc_seed when the system =
is
> resuming from hibernation? (probably system_state represents this?)
Do you mean something like below? It does work (it is my original
solution), but this patch is simpler.

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b35e2db7eb0e..42fb91650b13 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -614,14 +614,20 @@ static __always_inline enum kmalloc_cache_type
kmalloc_type(gfp_t flags, unsigne
         * The most common case is KMALLOC_NORMAL, so test for it
         * with a single branch for all the relevant flags.
         */
-       if (likely((flags & KMALLOC_NOT_NORMAL_BITS) =3D=3D 0))
+       if (likely((flags & KMALLOC_NOT_NORMAL_BITS) =3D=3D 0)) {
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
+               unsigned long random_seed =3D 0;
+
+               if (system_state > SYSTEM_SCHEDULING)
+                       random_seed =3D random_kmalloc_seed;
+
                /* RANDOM_KMALLOC_CACHES_NR (=3D15) copies + the KMALLOC_NO=
RMAL */
-               return KMALLOC_RANDOM_START + hash_64(caller ^
random_kmalloc_seed,
+               return KMALLOC_RANDOM_START + hash_64(caller ^ random_seed,

ilog2(RANDOM_KMALLOC_CACHES_NR + 1));
 #else
                return KMALLOC_NORMAL;
 #endif
+       }


Huacai

>
> >         /* Kmalloc array is now usable */
> >         slab_state =3D UP;
>
> --
> Harry

