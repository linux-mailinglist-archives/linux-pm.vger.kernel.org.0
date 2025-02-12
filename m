Return-Path: <linux-pm+bounces-21971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4FA32A4C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BAC188CB04
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56DC214A86;
	Wed, 12 Feb 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA3nHrBl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492E2135B0;
	Wed, 12 Feb 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374781; cv=none; b=KEgbBZ2G0l11WZ3HALZ53X8FSq+993EOPmBFw2pk4zqbF0wBYOfQQuawykFZqPAjtVD9whcDZ2coHQcybBOfQ+yiKAENO/HMK1Qe7zvZusQXNAHZD6k+xyunPVOVLC7XQIggpDvIpDwVO2aJRbpHAZ/qR0LL0CIGk8ccBKhqiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374781; c=relaxed/simple;
	bh=uZ2FYXK85eM4o+udcpNG4kguUqx1WGY3yButg8prVe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuptwkFehTPR5bBXgXpER9mPuLw+XQli1tMo96p86h09d2qWFJjwedM1Fwj6ahLUiGy59rE+tGTG0Cz3Xb3Gy485/u7Oytkd5DR0yf5qBWSwVsMaLsFCDOeCrv9DzaJcouOO1ibn6jxqDt1Yhnfv3IobmOG2Ul70BvqhnM01yUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA3nHrBl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso65225961fa.3;
        Wed, 12 Feb 2025 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374778; x=1739979578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+FbtZAlFDnWNkZYt7dUHBqnCrrT1pQsY7dvJuBAfwg=;
        b=dA3nHrBlFqRKptZSvDcBcoZF1EIWyt9hgOA6kvfcrJMI4xUI7tdiMeXkgV6xNaQKmA
         s+mjmDJJLpBwhtKUCymb5ksPsZD+2PJhejq6G0ZNBywNinPvURBGyE5yyAxINW3pUaMz
         vOsFy/WjTL95coQyu0D/ISsrSTwWtdtPZHEx7c2gIFrbiHlnXre+Kpin/KcQKJ2CHQZi
         3TPQ4NeLRty36aA03MYh1bVbV60zOcy3ToLoAxhc2RKVhAuix905M56A/4paQxVPs1wc
         UXML6uz/vfV1ZZiBMlbpW2gbk+xgUdn+L/O4ByNIoJp491VjEyWCEuRT1XW1HeQ+E4UJ
         u7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374778; x=1739979578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+FbtZAlFDnWNkZYt7dUHBqnCrrT1pQsY7dvJuBAfwg=;
        b=RqQBtKxYEd9CZOAC2i8TnbZG516QDm2BSzhM1z2iGSAp5ahEgxQW3wOxOKCC2l7rhF
         H0diS76n3gXkk3uQEt9Bb0DrFRuJTSCPu+1vjTWwU9xSSmVISfZWi73MFgnvsRyesZgw
         EIS631RPakjHK84c474MsannnNf/0X6nbjFRb7SWE20S/vUVSj6513MZYqsQP4Ry6eSu
         wcndYhFy08pCq5vil2zlRMz0B3ufv8bsSLhlFAFlAk1xHU/iHos9NAD4mLF/eBgLwd/p
         rv3pJC/fnTlDIHVxh2f5F5Mj9t52N3ELeK4i5safPpqyWYAFkA00UQYzLI9+v4P3/OPc
         DHeg==
X-Forwarded-Encrypted: i=1; AJvYcCWMIx6kV67cVUSzNlIn+IcBTaGyhrpUG6QNYJgGNGHFwJfTfy9jvaUCft0Tg7kVjdh6IWYgkUyL@vger.kernel.org, AJvYcCX7Mj1FTIta/piDzxN96MaIf+iOuhb0HF3GhrKcEtKNSK2QCIOWxkd+jdmBFxOOw3kA+o0AJZzTpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5xX71ab1EkU1nGIR1ly7QrT7s/9C31FWfrE2zfKWxI6R/osW
	KvG31SaIWvyuqFYPl+PC6zbYpc3d8bLF4VlVDacXB0xQxMBJhX9mjHXCpXI9SrL/pi9d1UTCYNi
	YV3oSqGoA23/tgu5Z4D6j32Ofc3g=
X-Gm-Gg: ASbGncs2J5EAHnaLctYxmyqx1Aadkle2Dv5Vo1YVExMR/Q27A2PMRp0kV5hy2YQK5Y7
	HfSOx/N4Sw8GTjBiffJ295klA34X4rVrMG+Xof3TuMrE8EZ7ZuZd3em/3q5ab8XEI8L8XOYY=
X-Google-Smtp-Source: AGHT+IHIVXNab1BOwmWz6a/Olt6hbaMVNiKD6PsmxeEahtZ5dItZPFOQlTmfbwCK/vN41pOD1RoY6IyKFqV1etX4FZw=
X-Received: by 2002:a05:6512:3dac:b0:544:138d:4b7b with SMTP id
 2adb3069b0e04-545181aa0cdmr1114594e87.52.1739374777501; Wed, 12 Feb 2025
 07:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
In-Reply-To: <20250212141648.599661-1-chenhuacai@loongson.cn>
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Date: Thu, 13 Feb 2025 00:39:25 +0900
X-Gm-Features: AWEUYZk9xCLyQMauhOuQl-xiWShJj9iRS9rA-5uWRxBydRrisTXIpngPN_Q6b6A
Message-ID: <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Initialise random_kmalloc_seed after initcalls
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	stable@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:17=E2=80=AFPM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> Hibernation assumes the memory layout after resume be the same as that
> before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.

[Let's also Cc SLAB ALLOCATOR folks in MAINTAINERS file]

Could you please elaborate what do you mean by
hibernation assumes 'the memory layout' after resume be the same as that
before sleep?

I don't understand how updating random_kmalloc_seed breaks resuming from
hibernation. Changing random_kmalloc_seed affects which kmalloc caches
newly allocated objects are from, but it should not affect the objects that=
 are
already allocated (before hibernation).

> At least on LoongArch and ARM64 we observed failures of resuming from
> hibernation (on LoongArch non-boot CPUs fail to bringup, on ARM64 some
> devices are unusable).

Did you have any chance to reproduce it on x86_64?

> software_resume_initcall(), the function which resume the target kernel
> is a initcall function. So, move the random_kmalloc_seed initialisation
> after all initcalls.
>
> Cc: stable@vger.kernel.org
> Fixes: 3c6152940584290668 ("Randomized slab caches for kmalloc()")
> Reported-by: Yuli Wang <wangyuli@uniontech.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>
>  init/main.c      | 3 +++
>  mm/slab_common.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index 2a1757826397..1362957bdbe4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1458,6 +1458,9 @@ static int __ref kernel_init(void *unused)
>         /* need to finish all async __init code before freeing the memory=
 */
>         async_synchronize_full();
>
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +       random_kmalloc_seed =3D get_random_u64();
> +#endif

It doesn=E2=80=99t seem appropriate to put slab code in kernel_init.

Additionally, it introduces a dependency that the code must be executed
after all late_initcalls, which sounds like introducing yet another
type of initcall.

>         system_state =3D SYSTEM_FREEING_INITMEM;
>         kprobe_free_init_mem();
>         ftrace_free_init_mem();
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..23e324aee218 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -971,9 +971,6 @@ void __init create_kmalloc_caches(void)
>                 for (i =3D KMALLOC_SHIFT_LOW; i <=3D KMALLOC_SHIFT_HIGH; =
i++)
>                         new_kmalloc_cache(i, type);
>         }
> -#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> -       random_kmalloc_seed =3D get_random_u64();
> -#endif

I have no idea how hibernation and resume work, but let me ask here:
Can we simply skip or defer updating random_kmalloc_seed when the system is
resuming from hibernation? (probably system_state represents this?)

>         /* Kmalloc array is now usable */
>         slab_state =3D UP;

--
Harry

