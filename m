Return-Path: <linux-pm+bounces-30308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D478AFBB18
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267CE4278EE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113620C000;
	Mon,  7 Jul 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyloA6WW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B361DE4CE;
	Mon,  7 Jul 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913962; cv=none; b=ttyn3dy+Pyyvq42bonO4/lbd/+w1oKamfmGRoXcnFRjLJzlfXOw2S/NSzFhMZVYHlDsy0AirOMLJE2u0z0wL88btC9a4Seqz8LdBry5uA5vZfpfgqq3DEs04tw0N488xC5kK3KVUi6Ee+WtU3vOhffG0PQJw1P7h3ukbG+UghOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913962; c=relaxed/simple;
	bh=Exw0d59LKDjaHUeD3GYpMCtQVZExRICjzLKlfIXHvwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI9I+V4ICWuPLyl4/brF6hXkreEr62usoX/AknH33Pcf3qlCsenS1yY3SQYybGV27Ptu9XKaj2mCLTGaPWugKRNfNAjrso6wzo4HV/3pOjr4sjgcHaGGH+tfiqX61YZw8jXztxAMKj+DrYeOzh6E6RlODw3pXx03j0tO07f7jP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyloA6WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D2C4CEF5;
	Mon,  7 Jul 2025 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913962;
	bh=Exw0d59LKDjaHUeD3GYpMCtQVZExRICjzLKlfIXHvwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lyloA6WWr9o72epnz+AYyUqSHjDa8Awm3Pin8UPzg7WCrkegTuzjiZBgxj/u7U54M
	 x5V5QKqHdDOs6Ze5tmOg/cRwieHaoeWfG/WDBc3P+ubEbfRVlAso8RyO0hJrmek0Jr
	 z9l43CbdP/15T8iPZGlPvg1qbHYx3V1cmOSwJ4qiePi0Y1II4dJNVJRIAJlbmv1p9z
	 x+nXr2G8aUuHEP4Q1f1RBYgjIOUhJudYTgTuu+ZQuBiaFGmuWXBwD82XjIgJOmXhE2
	 hh7nqcMNPW/JEBEo1RLgy/kEz6dIr19TThJH7jNwtb+el41fbO0R4wmNvmUQCgrwOT
	 rkH9xE+3mGd6g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-610cbca60cdso2488123eaf.0;
        Mon, 07 Jul 2025 11:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX47PXRZHsjccv7fWmXjA69CTc44/ChkbIXn6SMGRVmWhakxUa6whT+NyDlQIQq1j/LWEBJUgNBHkaZ2ww=@vger.kernel.org, AJvYcCX6aev0Ch2a4aoL9bIeImLPgghgIIMlMb2DTifjj1FliOsNgB/rhESqivo9aPW8COK0p6C7ezD+blU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMf8mrcv0Wz18fG34I0O9Cp9BPYC85sg8TVKLWV0vFXjW2dZK0
	LWsqT5EWomBtwSbT7xHxnq82s7+clBcwz5+73+qAlHpoMq12fbzoKCd49YpVm5hVS60nQQLc0Et
	Va7lyDr9hwAJb+xG/1c2de6pctn80cTY=
X-Google-Smtp-Source: AGHT+IF8GQ5nR95vm9SOtjoNEUTEXaOSDZW5YgowrCzdwXIpwupi1UU34zWqc+M/QXO4vqb9VYs5c7HqPhTVJ6HVz0E=
X-Received: by 2002:a05:6820:201b:b0:611:b24d:c27b with SMTP id
 006d021491bc7-61392bdb6a7mr8828423eaf.7.1751913961561; Mon, 07 Jul 2025
 11:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704101233.347506-1-guoqing.zhang@amd.com> <20250704101233.347506-4-guoqing.zhang@amd.com>
In-Reply-To: <20250704101233.347506-4-guoqing.zhang@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 20:45:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfk=3RSkTgYZcwz6RES2BtqopKMz8YOs_Y_UiiHEOWEQ@mail.gmail.com>
X-Gm-Features: Ac12FXzywAfKopa7ovd9YM4ftEpfH5oYmAVVphombfN_OyRgrQHJO60zi31dSLg
Message-ID: <CAJZ5v0hfk=3RSkTgYZcwz6RES2BtqopKMz8YOs_Y_UiiHEOWEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com, 
	matthew.auld@intel.com, matthew.brost@intel.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	mario.limonciello@amd.com, lijo.lazar@amd.com, victor.zhao@amd.com, 
	haijun.chang@amd.com, Qing.Ma@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:14=E2=80=AFPM Samuel Zhang <guoqing.zhang@amd.com=
> wrote:
>
> When hibernate with data center dGPUs, huge number of VRAM data will be
> moved to shmem during dev_pm_ops.prepare(). These shmem pages take a lot
> of system memory so that there's no enough free memory for creating the
> hibernation image. This will cause hibernation fail and abort.
>
> After dev_pm_ops.prepare(), call shrink_all_memory() to force move shmem
> pages to swap disk and reclaim the pages, so that there's enough system
> memory for hibernation image and less pages needed to copy to the image.
>
> This patch can only flush and free about half shmem pages. It will be
> better to flush and free more pages, even all of shmem pages, so that
> there're less pages to be copied to the hibernation image and the overall
> hibernation time can be reduced.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

No fundamental objections from me, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..7ae9d9a7aa1d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -370,6 +370,23 @@ static int create_image(int platform_mode)
>         return error;
>  }
>
> +static void shrink_shmem_memory(void)
> +{
> +       struct sysinfo info;
> +       unsigned long nr_shmem_pages, nr_freed_pages;
> +
> +       si_meminfo(&info);
> +       nr_shmem_pages =3D info.sharedram; /* current page count used for=
 shmem */
> +       /*
> +        * The intent is to reclaim all shmem pages. Though shrink_all_me=
mory() can
> +        * only reclaim about half of them, it's enough for creating the =
hibernation
> +        * image.
> +        */
> +       nr_freed_pages =3D shrink_all_memory(nr_shmem_pages);
> +       pr_debug("requested to reclaim %lu shmem pages, actually freed %l=
u pages\n",
> +                       nr_shmem_pages, nr_freed_pages);
> +}
> +
>  /**
>   * hibernation_snapshot - Quiesce devices and create a hibernation image=
.
>   * @platform_mode: If set, use platform driver to prepare for the transi=
tion.
> @@ -411,6 +428,15 @@ int hibernation_snapshot(int platform_mode)
>                 goto Thaw;
>         }
>
> +       /*
> +        * Device drivers may move lots of data to shmem in dpm_prepare()=
. The shmem
> +        * pages will use lots of system memory, causing hibernation imag=
e creation
> +        * fail due to insufficient free memory.
> +        * This call is to force flush the shmem pages to swap disk and r=
eclaim
> +        * the system memory so that image creation can succeed.
> +        */
> +       shrink_shmem_memory();
> +
>         suspend_console();
>         pm_restrict_gfp_mask();
>
> --
> 2.43.5
>

