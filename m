Return-Path: <linux-pm+bounces-30371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F0AFCDB9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878211886B13
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D88223DDD;
	Tue,  8 Jul 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORX8XU/4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56A21B184;
	Tue,  8 Jul 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985197; cv=none; b=q2mXjZcF/wPrtp8+ISHA6EwiSASWYiF6qUsTfm+bsUy5VjNCnxBk9Z7af+9dS49/R/MQFbVqJGAddKUwQL+AMasQYuI0SY80sU8zfASgedMiGnyi39TNdw2C9MSweDWkk8D4tjlEbQb49gVJrx8MFYzdEntANz3tX2ibLNzVqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985197; c=relaxed/simple;
	bh=utNLXH3cnocVF0s3DW7Irujgx/+GsETZteqLAdiCATo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjQHDfqg5dw429ME/1fwmaSQd1jLpB7v1Xt5EEUaUkzsIRkEhFKG/oKkAm6zVxJpWCw2eCt0HczfHZJRzw9jf2JY7mEyc5F6c+CrtEmLnUZ9mequ0Gb3Jfq41L62LAiT8FCJ003LS61p+eYmhihNlgJotHsbf/zziomfaM/3728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORX8XU/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01796C4CEF7;
	Tue,  8 Jul 2025 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985197;
	bh=utNLXH3cnocVF0s3DW7Irujgx/+GsETZteqLAdiCATo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ORX8XU/4HsmfXAu+ttwONyKDgmjdC/2adYuDv1LmNygWgYKxy+X93jrcYPn4UHHJR
	 QdzUPSv/w+HRpAwNErdAWaNEISibVGOYAUIarv2Q6eqb0rXm5SoZxErzNTjJpMAn8k
	 lepr9t4hl0dHHRobOFzu8V2usrOntKvBgi6cAl8G2afyPPNzHXYUUUd73fmrInkudC
	 nD4wJu5x6TWcjmDt9Ca4o6G0iLcJOnY9t5CVZlj1JKPd0K4Rb2TVaRn5ruiPWVdDo+
	 2UD7fxK5sJGFhJVf5BoP66BDxJvxdW86zFkCef/cPBlrXOfT+mSmfSXp31CYjJA0gM
	 GRuDpEKafyGsw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-611998766c0so2262908eaf.1;
        Tue, 08 Jul 2025 07:33:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0KZUozInkBu1RevHevps2weoOIQ4jdpIsdWBW7655m10KaKYiC+2vRoGin5tkWtxcLyahNj14apA=@vger.kernel.org, AJvYcCWeiCvn7qL3dcm9qkkZQzaixPeyPqHEDjbuR1r/MrElr6g9uY8Ov2jVPfM5JCOQFxxqh3zkBXXdEPkMQ+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YztIrVJCWSEobdL/OxYZAEG4sbXbMHp+q9YwWS/krYvqRxxthdg
	VyKyesxgA57WCpelqGh1vMtmNnZ7Zqee4SBZPBKnxt3zJFAC4C1Z5U1pa2aGi/BZ7cTZpHx3/bl
	LqQtQSubBuHoVQsjgxHozV+zc1CGXjfA=
X-Google-Smtp-Source: AGHT+IHCtFxy18tJdbPmS1pdbD7qxFrPanLGCz9iVdkc5UtRxR8SWo8Sl8LWqp5eInHk3vhKRkBRibuDd8mYu3eHMZY=
X-Received: by 2002:a05:6820:1e82:b0:611:befc:38e5 with SMTP id
 006d021491bc7-6138fd6a38cmr13791192eaf.4.1751985196181; Tue, 08 Jul 2025
 07:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708074248.1674924-1-guoqing.zhang@amd.com>
 <20250708074248.1674924-4-guoqing.zhang@amd.com> <bd30f96b-44d2-4127-a019-f02bc2689aa2@amd.com>
In-Reply-To: <bd30f96b-44d2-4127-a019-f02bc2689aa2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jul 2025 16:33:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iscejFdRXQAPkzdN0xBdZDnx5LzVvsN2SGC0ByBku85A@mail.gmail.com>
X-Gm-Features: Ac12FXzc74rd4ki3qeGnaoyMnInARYYWD0QmmPi-iPQcAH4hz74nl4kC3IivriE
Message-ID: <CAJZ5v0iscejFdRXQAPkzdN0xBdZDnx5LzVvsN2SGC0ByBku85A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, lijo.lazar@amd.com, 
	victor.zhao@amd.com, haijun.chang@amd.com, Qing.Ma@amd.com, 
	Owen.Zhang2@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:28=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/8/2025 3:42 AM, Samuel Zhang wrote:
> > When hibernate with data center dGPUs, huge number of VRAM data will be
> > moved to shmem during dev_pm_ops.prepare(). These shmem pages take a lo=
t
> > of system memory so that there's no enough free memory for creating the
> > hibernation image. This will cause hibernation fail and abort.
> >
> > After dev_pm_ops.prepare(), call shrink_all_memory() to force move shme=
m
> > pages to swap disk and reclaim the pages, so that there's enough system
> > memory for hibernation image and less pages needed to copy to the image=
.
> >
> > This patch can only flush and free about half shmem pages. It will be
> > better to flush and free more pages, even all of shmem pages, so that
> > there're less pages to be copied to the hibernation image and the overa=
ll
> > hibernation time can be reduced.
> >
> > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>
> AFAICT this didn't tangibly change and was just reordered in the series,
> I think you should carry Rafael's A-b tag forward.

Yes, please.

> > ---
> >   kernel/power/hibernate.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 10a01af63a80..7ae9d9a7aa1d 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -370,6 +370,23 @@ static int create_image(int platform_mode)
> >       return error;
> >   }
> >
> > +static void shrink_shmem_memory(void)
> > +{
> > +     struct sysinfo info;
> > +     unsigned long nr_shmem_pages, nr_freed_pages;
> > +
> > +     si_meminfo(&info);
> > +     nr_shmem_pages =3D info.sharedram; /* current page count used for=
 shmem */
> > +     /*
> > +      * The intent is to reclaim all shmem pages. Though shrink_all_me=
mory() can
> > +      * only reclaim about half of them, it's enough for creating the =
hibernation
> > +      * image.
> > +      */
> > +     nr_freed_pages =3D shrink_all_memory(nr_shmem_pages);
> > +     pr_debug("requested to reclaim %lu shmem pages, actually freed %l=
u pages\n",
> > +                     nr_shmem_pages, nr_freed_pages);
> > +}
> > +
> >   /**
> >    * hibernation_snapshot - Quiesce devices and create a hibernation im=
age.
> >    * @platform_mode: If set, use platform driver to prepare for the tra=
nsition.
> > @@ -411,6 +428,15 @@ int hibernation_snapshot(int platform_mode)
> >               goto Thaw;
> >       }
> >
> > +     /*
> > +      * Device drivers may move lots of data to shmem in dpm_prepare()=
. The shmem
> > +      * pages will use lots of system memory, causing hibernation imag=
e creation
> > +      * fail due to insufficient free memory.
> > +      * This call is to force flush the shmem pages to swap disk and r=
eclaim
> > +      * the system memory so that image creation can succeed.
> > +      */
> > +     shrink_shmem_memory();
> > +
> >       suspend_console();
> >       pm_restrict_gfp_mask();
> >
>

