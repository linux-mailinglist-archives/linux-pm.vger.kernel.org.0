Return-Path: <linux-pm+bounces-17830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C59D4243
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 19:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE1F28319A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35391B5ED2;
	Wed, 20 Nov 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcJUd8/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04003824A0;
	Wed, 20 Nov 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128879; cv=none; b=OhgV3X+BjSto34TVZ+EjsaZVIMj93AdUqiwZalaC95NBvUP4vQMmRv5A/BxJ8aaMUt5RwjUemvFwUGDu3Tfx5dGDvqu3/MyrLmwQtghtYZCooB5gMZNUPEivBzY9HTor4xn9Hreq/xqUPJo+cJ4QvJQDH46kgcxyTh+8RTr40Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128879; c=relaxed/simple;
	bh=pgZb7KzJR7PCND8fGLHmXt4q8yO1ZiQtgM9nsPkQEyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px3MdRS+EACxTSK6rbYNOAnP9vCXiiY2ZgUX91eWvHYor9sPcJyVJHWEUNN2iMDDsQWUQ/GoOKByNi04pLAoLCVwA1hzNCB+odW58ekP5GDbcQnXF79keVq2Bp+nVWBeXob3kkTLt3/9siJH9bAmfjUM4VV1Qt7+BfvXAeiYimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcJUd8/W; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aff992087so3757639f.3;
        Wed, 20 Nov 2024 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732128877; x=1732733677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywphHwRJ47bemIP9RZfgn34nLun0kYe1BEdTqOds8Rs=;
        b=RcJUd8/WKDmsJQINGxxLCPUAy4tta6TicnZjnKtZCizrEvIT8LaiCp0ybcmjd4v4Gv
         xTRdZ1Z7G9NiLldpKcl1MxhVioQphiHKDki3tsH/WqdNUSV++hA/cRW/h9TG05xqmBPP
         dIt40Y213M3/zgqDADMnNEex96DaRPcHkimT7UH/0++BKQ26SNyXz2HygXYphdY5DbES
         Q9LoAZVh0lxzUjvQNrRVGVsgDHEAy801zW7mM6Y2b8VQEv/OTNBYsT91MU2K1+Ot/ncs
         wATHOtK1LHPlTjquSETWY8uoSdGjdujmym8UrkdYk4xlq0M68viPnpupxLVWpp5sQRo+
         LeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128877; x=1732733677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywphHwRJ47bemIP9RZfgn34nLun0kYe1BEdTqOds8Rs=;
        b=qDBoKHCwaPCemxM48yAJLjuveer5HnfcIfmG4Bhe3Y+sBzTqHANtMcSHD1ZPsQBeDG
         JHIbIi5RPgQTpX0GUnWHBGPPgF2D5Kw+qyPQHUrAk6V0L+4ZUsgk8m8FhrIgPfkjOu99
         WT2rpqNITtJfL76383KJIpRZGQFYLrZnhdQ27OP8tBUWtBS5li72L/UVYzFA0MYys6Ov
         Ft4VdGEktEboFfTFpFt7ZPQDFiMIP7DhmSLLV7sgspNDx6dX9AgzGK/d6O85ZwwC1G/t
         UNlO60uqaCpCEs9mVFhGievVT2KTj6Ylw2GG033Ewd5hYbPnr+V4D0qNHTiyo/gwPPu0
         sC1g==
X-Forwarded-Encrypted: i=1; AJvYcCUR2LYHTMH1W0TVaO9ll19DsppF834T9vjPz9KjBXxIN5LUnjLt9hzWextUa2rlA0jtedW5HIaeEgk8Gboa@vger.kernel.org, AJvYcCUzH+TwUJYUzeS+kJZh82pN0jPPAzmzr15dBv7h4jEQfemNcrN6aN/koX3ZkOdETbDyVoY6khzGBJlHwgAFTQ==@vger.kernel.org, AJvYcCX3NAIEzmJEi1jQFhL4pezZVwUY70lxCP/qw+2VFZjCdLGdF40SfNQ4Qh+OJ+Lscpdt8zNLfvr6PBk=@vger.kernel.org, AJvYcCX3YhLPvB8J06Ap7p5Q28QYaX+mnwDB7baxroMrFvrbO4AGRuA+GC/adnW4JQRNEQJFN76ZMCDzVHG9@vger.kernel.org
X-Gm-Message-State: AOJu0YyThiuzgQxDDjSkX3F8UwWhjlQSmW0uVg0EUa6Vjv7Jjtrjx1Sz
	j71UJxl13cZdIYM5HnzVaP1NhckjTcWBsuuu3GSvLsvXes167ejIoxs4ro92vlGWlzPx6Mj+Dg8
	+BciGKyMMWl8XP4G8guo2DBWCMFw=
X-Gm-Gg: ASbGncuu8fkq/0mOY0dUsBE39D68tiFlMpVqtA8FgUoarYSRc5uvY4lA48zhrL/Kl9/
	OJ3NaXRuEu/z/A2cV82w9KRweaHszK/QFdgx3ajTEQ8XBNJQOQv20SxJBhcpm
X-Google-Smtp-Source: AGHT+IHd8C0gyOGxo8kEUV2MAn22vYluHbM6lDo81yALGvxv3opZ3P+eFDcZSWKWEXJFXyRB4VB0sPN5xiZpchHYexo=
X-Received: by 2002:a05:6602:6d8e:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-83eb5fce118mr454937039f.6.1732128877090; Wed, 20 Nov 2024
 10:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-3-4deb87be2498@linaro.org> <fkezpguictntg2wkouwqipnaaiauo6vu46n7a2xzvlorzvyeaw@bbcpj3bs5eko>
In-Reply-To: <fkezpguictntg2wkouwqipnaaiauo6vu46n7a2xzvlorzvyeaw@bbcpj3bs5eko>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 20 Nov 2024 10:54:24 -0800
Message-ID: <CAF6AEGs6zT_kaTXNohUaA7KWZxZTr4byaoMoLAceuyqA7S+2CQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/msm: adreno: move features bits in a
 separate variable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:18=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Nov 19, 2024 at 06:56:38PM +0100, Neil Armstrong wrote:
> > Now the features defines have the right name, introduce a features
> > bitfield and move the features defines in it, fixing all code checking
> > for them.
> >
> > No functional changes intended.
>
> I think it might be better to squahs this patch into the previous one,
> it would simplify checking that we use .quirks for ADRENO_QUIRK_foo and
> .features for ADRENO_FEAT_bar.
>

IMHO better to keep this separated

But we don't have _that_ many features/quirks so I don't find
combining them all that problematic

BR,
-R

> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 34 +++++++++++++++-------=
--------
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  7 +++---
> >  4 files changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/dr=
m/msm/adreno/a6xx_catalog.c
> > index 825c820def315968d508973c8ae40c7c7b646569..93f0d4bf50ba773ecde93e6=
c29a2fcec24ebb7b3 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > @@ -743,7 +743,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a615_zap.mbn",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -769,7 +769,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .a6xx =3D &(const struct a6xx_info) {
> >                       .protect =3D &a630_protect,
> > @@ -839,7 +839,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a615_zap.mdt",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -864,7 +864,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                         ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a620_zap.mbn",
> > @@ -892,7 +892,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_1M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a630_zap.mdt",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -911,7 +911,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_1M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a640_zap.mdt",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -934,7 +934,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_1M + SZ_128K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                       ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a650_zap.mdt",
> > @@ -961,7 +961,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_1M + SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                       ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a660_zap.mdt",
> > @@ -981,7 +981,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_1M + SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                       ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -1000,7 +1000,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_512K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                       ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a660_zap.mbn",
> > @@ -1028,7 +1028,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_2M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a640_zap.mdt",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -1046,7 +1046,7 @@ static const struct adreno_info a6xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_4M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                       ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a690_zap.mdt",
> > @@ -1331,7 +1331,7 @@ static const struct adreno_info a7xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_128K,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_HW_APRIV,
> > +             .features =3D ADRENO_FEAT_HAS_HW_APRIV,
> >               .init =3D a6xx_gpu_init,
> >               .zapfw =3D "a702_zap.mbn",
> >               .a6xx =3D &(const struct a6xx_info) {
> > @@ -1355,7 +1355,7 @@ static const struct adreno_info a7xx_gpus[] =3D {
> >               },
> >               .gmem =3D SZ_2M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                         ADRENO_FEAT_HAS_HW_APRIV |
> >                         ADRENO_FEAT_PREEMPTION,
> >               .init =3D a6xx_gpu_init,
> > @@ -1377,7 +1377,7 @@ static const struct adreno_info a7xx_gpus[] =3D {
> >               },
> >               .gmem =3D 3 * SZ_1M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                         ADRENO_FEAT_HAS_HW_APRIV |
> >                         ADRENO_FEAT_PREEMPTION,
> >               .init =3D a6xx_gpu_init,
> > @@ -1400,7 +1400,7 @@ static const struct adreno_info a7xx_gpus[] =3D {
> >               },
> >               .gmem =3D 3 * SZ_1M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                         ADRENO_FEAT_HAS_HW_APRIV |
> >                         ADRENO_FEAT_PREEMPTION,
> >               .init =3D a6xx_gpu_init,
> > @@ -1422,7 +1422,7 @@ static const struct adreno_info a7xx_gpus[] =3D {
> >               },
> >               .gmem =3D 3 * SZ_1M,
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> > -             .quirks =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> > +             .features =3D ADRENO_FEAT_HAS_CACHED_COHERENT |
> >                         ADRENO_FEAT_HAS_HW_APRIV |
> >                         ADRENO_FEAT_PREEMPTION,
> >               .init =3D a6xx_gpu_init,
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index 2ebd3fac212576a1507e0b6afe2560cd0408dd89..654d0cff421f15901cd4bf3=
3b41e70004634ec75 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -2478,7 +2478,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *=
dev)
> >       adreno_gpu->gmu_is_wrapper =3D of_device_is_compatible(node, "qco=
m,adreno-gmu-wrapper");
> >
> >       adreno_gpu->base.hw_apriv =3D
> > -             !!(config->info->quirks & ADRENO_FEAT_HAS_HW_APRIV);
> > +             !!(config->info->features & ADRENO_FEAT_HAS_HW_APRIV);
> >
> >       /* gpu->info only gets assigned in adreno_gpu_init() */
> >       is_a7xx =3D config->info->family =3D=3D ADRENO_7XX_GEN1 ||
> > @@ -2495,7 +2495,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *=
dev)
> >       }
> >
> >       if ((enable_preemption =3D=3D 1) || (enable_preemption =3D=3D -1 =
&&
> > -         (config->info->quirks & ADRENO_FEAT_PREEMPTION)))
> > +         (config->info->features & ADRENO_FEAT_PREEMPTION)))
> >               ret =3D adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7x=
x, 4);
> >       else if (is_a7xx)
> >               ret =3D adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7x=
x, 1);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index 09d4569f77528c2a20cabc814668c4c930dd07f1..11a228472fa0cef3b6e4e21=
a366470fbbc3ea8df 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -207,7 +207,7 @@ static int adreno_bind(struct device *dev, struct d=
evice *master, void *data)
> >
> >       priv->is_a2xx =3D info->family < ADRENO_3XX;
> >       priv->has_cached_coherent =3D
> > -             !!(info->quirks & ADRENO_FEAT_HAS_CACHED_COHERENT);
> > +             !!(info->features & ADRENO_FEAT_HAS_CACHED_COHERENT);
> >
> >       gpu =3D info->init(drm);
> >       if (IS_ERR(gpu)) {
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index 8782c25e8a393ec7d9dc23ad450908d039bd08c5..4702d4cfca3b58fb3cbb25c=
b6805f1c19be2ebcb 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -55,9 +55,9 @@ enum adreno_family {
> >  #define ADRENO_QUIRK_FAULT_DETECT_MASK               BIT(1)
> >  #define ADRENO_QUIRK_LMLOADKILL_DISABLE              BIT(2)
> >
> > -#define ADRENO_FEAT_HAS_HW_APRIV             BIT(3)
> > -#define ADRENO_FEAT_HAS_CACHED_COHERENT              BIT(4)
> > -#define ADRENO_FEAT_PREEMPTION                       BIT(5)
> > +#define ADRENO_FEAT_HAS_HW_APRIV             BIT(0)
> > +#define ADRENO_FEAT_HAS_CACHED_COHERENT              BIT(1)
> > +#define ADRENO_FEAT_PREEMPTION                       BIT(2)
> >
> >  /* Helper for formating the chip_id in the way that userspace tools li=
ke
> >   * crashdec expect.
> > @@ -98,6 +98,7 @@ struct adreno_info {
> >       uint32_t revn;
> >       const char *fw[ADRENO_FW_MAX];
> >       uint32_t gmem;
> > +     u64 features;
> >       u64 quirks;
> >       struct msm_gpu *(*init)(struct drm_device *dev);
> >       const char *zapfw;
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

