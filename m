Return-Path: <linux-pm+bounces-29978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9610FAF5A46
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BDE442FE7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3327E1DC;
	Wed,  2 Jul 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBZ3QUvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812625CC40;
	Wed,  2 Jul 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464495; cv=none; b=WLGvYGXKAS3TT+YGOZXlj81jNEl/voM3k6wZ2ZT2NKplGlSp2O3X+Ig3a5hhFdclvCs4OGqYx4VW4aJK9BMGO+Y2N1kqH5HFV2hwQKcS/QNsVzOvS5Rr299fHYWZ7bh71fgSiw4YLjhveruabAUpYO1iZUSraOxSWzkPAmqnjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464495; c=relaxed/simple;
	bh=3zvdBVFljoLJVgwcrueuE3wpbqS6pt/N2C0eXTnOCj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpOM2GaldHOs2IBDSZLdPK/9wlIbNVVcdDrDXUXbBvzsQ4iKBLYrMP6ch0HHn8v+Ph2cmKUyHShTwtANDmuv7JGYuB0rhrzNgq1OMK4vUy4t8Cs7Yp+JCsK+rjSF5fULUwjO+OI07H9J/ha5uGNJXS6/6AtEmCGF7jurs+qIF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBZ3QUvR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313862d48e7so820254a91.1;
        Wed, 02 Jul 2025 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751464493; x=1752069293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guEO+X2TlstsCPyD5rnbkNBVqzNfH7Sc2OBJNfyq+ZM=;
        b=JBZ3QUvR831gRYUkSr8puPn+p90QHa+5N5SwLfJ5zbDe4bp1OZYKvq7l31zgrv+gJX
         GVm8v7TIWN0LCQh6R9C4HDy91haaI/zSY9F0VP28EemCsc+NcE/BKV/CuLbInWns8+e+
         SxEfXICPXGCrnnQkoFGbBwW/XZcSuIco97NF0Ms7UoSWkxoZXtg8cljg2RkzYbswDOTF
         RPaUh1NqCwNUf+SPOfZjFYUQH+CEsi1moL1+TOslNMCiQRa2lBkqVRsn0iCc9Vpq74Hp
         FK2iK/NFjJ+G1D3xBhhh/JIGmlYZ0qgSTSaV/vqSivTE4Tl2spmKnfvLvTn8B0rCVBWY
         b2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464493; x=1752069293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guEO+X2TlstsCPyD5rnbkNBVqzNfH7Sc2OBJNfyq+ZM=;
        b=PukY1uSRWghBj8GzfsD5+I0KLrxvJzD4rSr7ZplxNcRcl6BYjcrjVn98kTNidU7lNd
         iv4avIsBjC7aYI1er/T1vXEHs7OQlrDHZiJVJg3B5H9/CNqMAVvVBPbxhEydHEAZ8sIi
         U+MtLR72kA8yb9zv3TwFH70wWlPhQV22cyvYM1F4b+/ApcgKV22mpOlkhl/3/EWGLr7z
         Rsk0pSNNSbWSGihxO48TgI8slrIbeI4IrZhJ6+pZZjvnlX1J1NHOTnG/ssSafjN1iswW
         3B9bybVcEeqNpzZ/yo/Q/Ikr2QlBt1UrCEOIuzqtnG7JYwQtPMp5Ul4SCc04VL3DH/EG
         kTjA==
X-Forwarded-Encrypted: i=1; AJvYcCVlBMWVnArbNeB8RN8pNluNNZd8yKxoG6b212hpetpDNV5RpK4irq9ccY+MqvJXACTv5K2S6qiZBG0=@vger.kernel.org, AJvYcCW7jHjsr9q0ZkzsXoVclK7mx4cePTCHZwwbHJlgSblO/xfbKtYI5l0sX6eQn8wulwV/NqMnTdtg6WdGJ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUeYTSRDP5ecDRVUOz64ehTrooJjqZSqYnE0Yq7rXusTUxjMm
	V7DboI4ckhnrqvBywGFCDUjeAb5xW84ah7NY2ipHhHuaWj+9QJgvdLKzXwo/4O4tKWIHD0adGB6
	dSXUVeuJu7gd30rxWSLi2pRqMGmFy4GOsIg==
X-Gm-Gg: ASbGncsAdv2zCHzncTCaUgH3AcHFLumXX9plxGGPuNgpi/3zpgiNRioyo//MFINAS8B
	RAUdbJ9yNnuJ5Uxxxn1PZ3WsWXCZbjiLVQ0hyjkyC+V7TceyFvclE1lFpQVDD4KmU4uiv3efVC8
	eV0l5kw21uzNZkErZZyZQdDqF9XLI6zZ4Y4zvYhVA7cO/Q
X-Google-Smtp-Source: AGHT+IGz9xeZKYvy5a2NukWtiE7Le0rFEBMYvJw3zExK04u12YuSeV52WPllxSnaAX6EzjHaGyjLIxgzJ53817LFsk4=
X-Received: by 2002:a17:90b:35c5:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-31a90bdc410mr1767000a91.3.1751464493199; Wed, 02 Jul 2025
 06:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630104116.3050306-1-guoqing.zhang@amd.com>
 <20250630104116.3050306-4-guoqing.zhang@amd.com> <8806781b-90d1-4b99-a798-dd1d29d4c8c0@amd.com>
 <8eb1700d-4d60-4a1e-9d09-718f65baaf1e@amd.com> <019a15d5-142f-4761-9408-58c103d3922b@amd.com>
 <CADnq5_PHfNTbLL7Xmb9HFgtZemDVaLSqbrONWWEf9hjwk1rF1Q@mail.gmail.com> <1e82f0af-daf6-4dd6-bc43-2969ac970589@amd.com>
In-Reply-To: <1e82f0af-daf6-4dd6-bc43-2969ac970589@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jul 2025 09:54:39 -0400
X-Gm-Features: Ac12FXyRsLYdypBJymECkaaNjTssfLfSQkcuc1lxngJzDfTT75YxJid0fH1rcK4
Message-ID: <CADnq5_M_NWSbqJUrBcDy_bARrPcQDDhSvHCKCqEoTWijBWHxGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: skip kfd resume_process for dev_pm_ops.thaw()
To: Sam <guoqzhan@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>, "rafael@kernel.org" <rafael@kernel.org>, 
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

On Wed, Jul 2, 2025 at 3:24=E2=80=AFAM Sam <guoqzhan@amd.com> wrote:
>
>
> On 2025/7/2 00:07, Alex Deucher wrote:
> > On Tue, Jul 1, 2025 at 4:32=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >> On 01.07.25 10:03, Zhang, GuoQing (Sam) wrote:
> >>> thaw() is called before writing the hiberation image to swap disk. Se=
e
> >>> the doc here.
> >>> https://github.com/torvalds/linux/blob/v6.14/Documentation/driver-api=
/pm/devices.rst?plain=3D1#L552 <https://github.com/torvalds/linux/blob/v6.1=
4/Documentation/driver-api/pm/devices.rst?plain=3D1#L552>
> >>>
> >>> And amdgpu implemented thaw() callback by calling amdgpu_device_resum=
e().
> >>> https://github.com/torvalds/linux/blob/v6.14/drivers/gpu/drm/amd/amdg=
pu/amdgpu_drv.c#L2572 <https://github.com/torvalds/linux/blob/v6.14/drivers=
/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2572>
> >>>
> >>> This patch is skip amdgpu_amdkfd_resume_process() call in thaw() duri=
ng
> >>> hibernation. it is not skipped in restore() during resume from
> >>> hibernation when system boot again.
> >>>
> >>>
> >>> I just found the following kernel doc. Thaw() is intended to resume t=
he
> >>> storage device for saving the hibernation image.
> >> Ah, that makes much more sense.
> >>
> >>> Our GPU is not involved
> >>> in it, it is not necessary to resume our GPU in thaw().
> >>> https://github.com/torvalds/linux/blob/v6.14/Documentation/power/pci.=
rst?plain=3D1#L588 <https://github.com/torvalds/linux/blob/v6.14/Documentat=
ion/power/pci.rst?plain=3D1#L588>
> >>>
> >>> So another implementation is to remove the amdgpu_device_resume() cal=
l
> >>> in amdgpu_pmops_thaw(), and skip amdgpu_device_ip_suspend() call in
> >>> amdgpu_pci_shutdown()for hibernation.
> >>> Initial tests show it's working fine for hibernation successful case.
> >>> Should I switch to this implementation?
> >> No idea. Alex and the KFD guys need to take a look at that.
> >>
> >>> But thaw() is also called to restore the GPU when hibernation is abor=
ted
> >>> due to some error in hibernation image creation stage. In this case,
> >>> amdgpu_device_resume() is needed in thaw().
> >>>
> >>> So I need a method to check if hibernation is aborted or not to
> >>> conditionally skip amdgpu_device_resume() in thaw(). Currently I don'=
t
> >>> know how to do this.
> >> Yeah that approach here looks fishy to me, but I don't know how to pro=
perly fix it either.
> >>
> >> @Alex any idea?
> > Yeah, I'm not sure how to handle that.  I don't see a way to avoid
> > having all of the callbacks.  We could ideally skip some of the steps.
> > Maybe we could optimize the freeze and thaw routines if we had some
> > hint from the pm core about why we were getting called.  E.g., thaw
> > after a failed hibernation restore.
> >
> > Alex
>
>
> I just found pm_transition variable can be used to check if hibernation
> is cancelled (PM_EVENT_RECOVER) or not(PM_EVENT_THAW) in thaw(). I just
> need to export this variable in kernel.
> https://github.com/torvalds/linux/blob/master/drivers/base/power/main.c#L=
64
>
> Provided pm_transition is available, should we skip
> amdgpu_amdkfd_resume_process() only, or skip amdgpu_device_resume()
> completely?

Hmmm.  Still not sure how best to handle this.  For entering
hibernation, all we really need is freeze().  Once we are done with
that we don't need thaw() or poweroff() for hibernation as we've
already suspended in freeze() so there is nothing else to do.  For
exiting hibernation, we need freeze() to suspend and then either
thaw() (if the hibernation image is bad) or restore() (if the
hibernation image is good) to resume.

Alex

>
> Regards
> Sam
>
>
> >
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards
> >>> Sam
> >>>
> >>>
> >>> On 2025/6/30 19:58, Christian K=C3=B6nig wrote:
> >>>> On 30.06.25 12:41, Samuel Zhang wrote:
> >>>>> The hibernation successful workflow:
> >>>>> - prepare: evict VRAM and swapout GTT BOs
> >>>>> - freeze
> >>>>> - create the hibernation image in system memory
> >>>>> - thaw: swapin and restore BOs
> >>>> Why should a thaw happen here in between?
> >>>>
> >>>>> - complete
> >>>>> - write hibernation image to disk
> >>>>> - amdgpu_pci_shutdown
> >>>>> - goto S5, turn off the system.
> >>>>>
> >>>>> During prepare stage of hibernation, VRAM and GTT BOs will be swapo=
ut to
> >>>>> shmem. Then in thaw stage, all BOs will be swapin and restored.
> >>>> That's not correct. This is done by the application starting again a=
nd not during thaw.
> >>>>
> >>>>> On server with 192GB VRAM * 8 dGPUs and 1.7TB system memory,
> >>>>> the swapin and restore BOs takes too long (50 minutes) and it is no=
t
> >>>>> necessary since the follow-up stages does not use GPU.
> >>>>>
> >>>>> This patch is to skip BOs restore during thaw to reduce the hiberna=
tion
> >>>>> time.
> >>>> As far as I can see that doesn't make sense. The KFD processes need =
to be resumed here and that can't be skipped.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
> >>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> index a8f4697deb1b..b550d07190a2 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> @@ -5328,7 +5328,7 @@ int amdgpu_device_resume(struct drm_device *d=
ev, bool notify_clients)
> >>>>>                amdgpu_virt_init_data_exchange(adev);
> >>>>>                amdgpu_virt_release_full_gpu(adev, true);
> >>>>>
> >>>>> -            if (!adev->in_s0ix && !r && !adev->in_runpm)
> >>>>> +            if (!adev->in_s0ix && !r && !adev->in_runpm && !adev->=
in_s4)
> >>>>>                        r =3D amdgpu_amdkfd_resume_process(adev);
> >>>>>        }
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_drv.c
> >>>>> index 571b70da4562..23b76e8ac2fd 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> @@ -2734,7 +2734,9 @@ static int amdgpu_pmops_poweroff(struct devic=
e *dev)
> >>>>>    static int amdgpu_pmops_restore(struct device *dev)
> >>>>>    {
> >>>>>        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>>> +    struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>>>
> >>>>> +    adev->in_s4 =3D false;
> >>>>>        return amdgpu_device_resume(drm_dev, true);
> >>>>>    }
> >>>>>

