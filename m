Return-Path: <linux-pm+bounces-29921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E4AEFF19
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5343ACAC3
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9127703A;
	Tue,  1 Jul 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYr3iXr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32D273818;
	Tue,  1 Jul 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386044; cv=none; b=HYdjzJIZ4MUpSZ3P4VXHe8xLOSv+N4rK4acXs4cQjcNxjLXJC/vFcOGdjXjVs7VTXxyfkKVb4TPVr+MlMU741OfbbgmEmpLgJrsgeAiZEOYepsxo7WWAVZi7WCJv6FWvWv9gFwCY6PjnpbcLKR9IShhwdqpiqZ3L63kkDR2tBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386044; c=relaxed/simple;
	bh=HsjIkpBxBstl9Atcqae/pq36VptWvAxCi7tw7cCSpjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSGVPVTioWy8qafhYYcz36Lfj6FZ83KUtJte1oF0stN2ZqrUhHk81odFBI8sCaI62e0VcZP3TPWONRDxhi/nV1Gpys8SZ4BPx2uwsdY7e+YLSg4ehY4r8T6NFSto+P+gGyBJ/QuuNEBlSJ5FdMIvN6ya8t/9Q4HcU2CLID2iRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYr3iXr5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31306794b30so762810a91.2;
        Tue, 01 Jul 2025 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386042; x=1751990842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s5/kLm6bcjzmUmo8TOBM6JrD/Wu1K8ZqjA08OXVfrw=;
        b=NYr3iXr5+WAt7n7QhC9vd1xzdqDorGcsifypy3pM8HTHJRMFS+LD0NrdvAmZswnW2L
         DOZcDtlkLizNMOF5cklkAxnwXMmVAPq8OyV2qqAyHPR7j7Z4J7Oo5ssM7ThzT5sMeXU+
         ID5Va+Yr+IejoEqs9UQHQGEdhLXvm7m8J/oy4SKcLbZZKMwY/T1g77sH1cROHJID2uAm
         7iraDmJhkouQWlcNXAbtoN2LcicBd9haoEO0wIklcU0w5zuIE93KvD0bpgnG9F256Blp
         6Jb4aJerl34pazuSz/NIucRF48ypBQu/by8QVa9KZEHrC+p5V5Ygj+qLRLEbM9wBLqNJ
         LDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386042; x=1751990842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s5/kLm6bcjzmUmo8TOBM6JrD/Wu1K8ZqjA08OXVfrw=;
        b=RyLSVf8FimJzC2dBZvgP53YVuZdE/OuGK7FDpPiQRHdRwxVU5loVwQ/DMLKwB3TN9h
         q7ry3aW4T4MCWJBZDuAm2b6CCJAsANmC9y5bngWB7mPY3aM1L6CeySAFJFyoPkJ1Ibsf
         85klH4cftlzmTAbFE7+VL79JvNvP0QVtIfu7AAhDdAXbyDaP89Shtr2KeVaboA7/F0+c
         NFnwe/4JjGXHC5/N00IMkXn44EulnDBwhTerUOty3qg6/2z3a/yMxYZFJednzEQJLRtw
         HRTRB7FqWIx1N42beGxcjaEif/hVjp729mY9VWK+vjiew4TsfRYt78j5eczuSCAwhNI2
         HNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ly+oARt8lTlMvN6wCkKsLoYZqJ+1q0JtYrbuFHyFrrpCzneIDSPW2UPAyCioLyXVK8c4abq0RjzAlZA=@vger.kernel.org, AJvYcCWEsM1OLOD/Ro3IaG1cx4M/HtXgPPpRdbdiK+0Zw2eyGehNsYKriywB6TvkjXzLrdTrnrJClpecjtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7MGGDwTpCPPhSHis24FqikIVOZMhFfssseWuxyXMi3+dix6G
	CFmDKJcBlefaeiERu6NbMut0vwRsQzUlW2wd7MbSWUSYHQHVuG3K7waLdnOmiwzM8VZhRR795b0
	ARlRe++JHqv7wanH4cnJj+vxiDCuOXNpJDw==
X-Gm-Gg: ASbGncv2nTrOXULqOhIYWeZMbwN/VarnldpH1f1CwzXpGrAvkCcJMCHkxrVfDVg2xRC
	KYk3gdrVKdQ6a5OogbzVE6K6VVghKDr1hefc3fcOZRWLu5pj/0dkJnqsSQtFe2LLgbGEcsI+1NO
	H+/puEvSoAE7eSUGaYxFneW4KpU0hDkCfw6u/64mu/EboG
X-Google-Smtp-Source: AGHT+IFQJNo7HwID/TeXlAbTPbbNefXtXxAG2rRd8AEgaEOCEY9ozjNHRKWsTXfzbsIfuCVK/y+uC5IX0mQc9ZwS12g=
X-Received: by 2002:a17:90b:180e:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31a800bba6bmr1931961a91.2.1751386042181; Tue, 01 Jul 2025
 09:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630104116.3050306-1-guoqing.zhang@amd.com>
 <20250630104116.3050306-4-guoqing.zhang@amd.com> <8806781b-90d1-4b99-a798-dd1d29d4c8c0@amd.com>
 <8eb1700d-4d60-4a1e-9d09-718f65baaf1e@amd.com> <019a15d5-142f-4761-9408-58c103d3922b@amd.com>
In-Reply-To: <019a15d5-142f-4761-9408-58c103d3922b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jul 2025 12:07:10 -0400
X-Gm-Features: Ac12FXwdbdy8HjwfCgq96-OHQZyxxU6ldvjvewIOGImA43uESTZlF3tB4NQ9pb0
Message-ID: <CADnq5_PHfNTbLL7Xmb9HFgtZemDVaLSqbrONWWEf9hjwk1rF1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: skip kfd resume_process for dev_pm_ops.thaw()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"len.brown@intel.com" <len.brown@intel.com>, "pavel@kernel.org" <pavel@kernel.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
	"Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, 
	"Ma, Qing (Mark)" <Qing.Ma@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 4:32=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 01.07.25 10:03, Zhang, GuoQing (Sam) wrote:
> >
> > thaw() is called before writing the hiberation image to swap disk. See
> > the doc here.
> > https://github.com/torvalds/linux/blob/v6.14/Documentation/driver-api/p=
m/devices.rst?plain=3D1#L552 <https://github.com/torvalds/linux/blob/v6.14/=
Documentation/driver-api/pm/devices.rst?plain=3D1#L552>
> >
> > And amdgpu implemented thaw() callback by calling amdgpu_device_resume(=
).
> > https://github.com/torvalds/linux/blob/v6.14/drivers/gpu/drm/amd/amdgpu=
/amdgpu_drv.c#L2572 <https://github.com/torvalds/linux/blob/v6.14/drivers/g=
pu/drm/amd/amdgpu/amdgpu_drv.c#L2572>
> >
> > This patch is skip amdgpu_amdkfd_resume_process() call in thaw() during
> > hibernation. it is not skipped in restore() during resume from
> > hibernation when system boot again.
> >
> >
> > I just found the following kernel doc. Thaw() is intended to resume the
> > storage device for saving the hibernation image.
>
> Ah, that makes much more sense.
>
> > Our GPU is not involved
> > in it, it is not necessary to resume our GPU in thaw().
> > https://github.com/torvalds/linux/blob/v6.14/Documentation/power/pci.rs=
t?plain=3D1#L588 <https://github.com/torvalds/linux/blob/v6.14/Documentatio=
n/power/pci.rst?plain=3D1#L588>
> >
> > So another implementation is to remove the amdgpu_device_resume() call
> > in amdgpu_pmops_thaw(), and skip amdgpu_device_ip_suspend() call in
> > amdgpu_pci_shutdown()for hibernation.
> > Initial tests show it's working fine for hibernation successful case.
> > Should I switch to this implementation?
>
> No idea. Alex and the KFD guys need to take a look at that.
>
> > But thaw() is also called to restore the GPU when hibernation is aborte=
d
> > due to some error in hibernation image creation stage. In this case,
> > amdgpu_device_resume() is needed in thaw().
> >
> > So I need a method to check if hibernation is aborted or not to
> > conditionally skip amdgpu_device_resume() in thaw(). Currently I don't
> > know how to do this.
>
> Yeah that approach here looks fishy to me, but I don't know how to proper=
ly fix it either.
>
> @Alex any idea?

Yeah, I'm not sure how to handle that.  I don't see a way to avoid
having all of the callbacks.  We could ideally skip some of the steps.
Maybe we could optimize the freeze and thaw routines if we had some
hint from the pm core about why we were getting called.  E.g., thaw
after a failed hibernation restore.

Alex

>
> Regards,
> Christian.
>
> >
> >
> > Regards
> > Sam
> >
> >
> > On 2025/6/30 19:58, Christian K=C3=B6nig wrote:
> >> On 30.06.25 12:41, Samuel Zhang wrote:
> >>> The hibernation successful workflow:
> >>> - prepare: evict VRAM and swapout GTT BOs
> >>> - freeze
> >>> - create the hibernation image in system memory
> >>> - thaw: swapin and restore BOs
> >> Why should a thaw happen here in between?
> >>
> >>> - complete
> >>> - write hibernation image to disk
> >>> - amdgpu_pci_shutdown
> >>> - goto S5, turn off the system.
> >>>
> >>> During prepare stage of hibernation, VRAM and GTT BOs will be swapout=
 to
> >>> shmem. Then in thaw stage, all BOs will be swapin and restored.
> >> That's not correct. This is done by the application starting again and=
 not during thaw.
> >>
> >>> On server with 192GB VRAM * 8 dGPUs and 1.7TB system memory,
> >>> the swapin and restore BOs takes too long (50 minutes) and it is not
> >>> necessary since the follow-up stages does not use GPU.
> >>>
> >>> This patch is to skip BOs restore during thaw to reduce the hibernati=
on
> >>> time.
> >> As far as I can see that doesn't make sense. The KFD processes need to=
 be resumed here and that can't be skipped.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
> >>>   2 files changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index a8f4697deb1b..b550d07190a2 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -5328,7 +5328,7 @@ int amdgpu_device_resume(struct drm_device *dev=
, bool notify_clients)
> >>>               amdgpu_virt_init_data_exchange(adev);
> >>>               amdgpu_virt_release_full_gpu(adev, true);
> >>>
> >>> -            if (!adev->in_s0ix && !r && !adev->in_runpm)
> >>> +            if (!adev->in_s0ix && !r && !adev->in_runpm && !adev->in=
_s4)
> >>>                       r =3D amdgpu_amdkfd_resume_process(adev);
> >>>       }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> >>> index 571b70da4562..23b76e8ac2fd 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -2734,7 +2734,9 @@ static int amdgpu_pmops_poweroff(struct device =
*dev)
> >>>   static int amdgpu_pmops_restore(struct device *dev)
> >>>   {
> >>>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>> +    struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>
> >>> +    adev->in_s4 =3D false;
> >>>       return amdgpu_device_resume(drm_dev, true);
> >>>   }
> >>>
> >
>

