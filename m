Return-Path: <linux-pm+bounces-18521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5A9E3582
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B75281EA6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2E198E84;
	Wed,  4 Dec 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMrvv+lC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797B1946BC;
	Wed,  4 Dec 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301205; cv=none; b=ikt4dBHcjHq18Oj5QBdONEG8+QxAx5/qN1ZBoZvqIC644BOirgS8y6NMe5TG14nFt9Q7LPyItgDEfWq2xyrTFnvXcur4xeT2ejfgu38yoHFXeq0vJO3kD95+zJcP+y5YbUEsa47Z7w26yUupUyg/FqaaltPIq+h80wuWeZgTPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301205; c=relaxed/simple;
	bh=GWGeP4DIiM2Yt9NtZsGqv6R8dlTBpDAiv8TM2B3SX+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6YreeRV5Imt5Pr/IbRxymhj/w8rz8t2lVaJcV9l85jj1IVAZtJUpUzzr+2Q7iNRzKkk46OsEqp1Ur6MsIlPeH6qhhL6cmpE9QxqQW1RgZcavqudjHcEGWCs5rJIP9s8G0l37rCmuRJbiZBpswyEz7AV+VoFnWhPD6XBcRqYE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMrvv+lC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efa1e49ef0so32439287b3.2;
        Wed, 04 Dec 2024 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733301202; x=1733906002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqgcCQZXvVp4Bfem5Yv6XqnOFFpUID6nHSIu6ZBoJFY=;
        b=TMrvv+lCt8Eqw3P9wxIMg/6I8O/RBi3n0mVrr2Ohgzf0fNS62bl+5kZpuee72hm9ka
         Yb+uSQpAsToocRggXs0fe/vbgA58z562sD0n0i7RhijM1C4fx3pI16n/GQr09yH8k9JC
         V2J07m7kHocBT1WYcJd7InSAwdFHHqraSJ+0E1Y+sR9KK4ZSNr5mr+qGAktJ6Fht3H3E
         GQ8zlX+w+pNPk1XWBggJ7HzuTBA7htEpshVycQoyuGz6v+ru7HXNo1vFEkCV3tNCX1zz
         pkoppNWDzofu3V3VcOFm+nUD2Nxgx9HkOxLOq+51/dOT7g4LiW/aka4nqoTLvuu/yhL2
         I85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301202; x=1733906002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqgcCQZXvVp4Bfem5Yv6XqnOFFpUID6nHSIu6ZBoJFY=;
        b=lvtY2516OkGcfzwM0tMoVXG7g4t2PG0gkvpAftBXBQT4rga6PLels20OlLXjA6N2R9
         /QHSQ0/53rkbnGfftrM267BZqQUJQ0ZHNzEXFw2st0B6na9WYNnNarEbSenjC8wLSj9J
         5gJx6T+L677d3WKya4WUnP0sZCpuL8XjskkK/Wj2e3/QPGgLU3hWLfxJoQmE3c6QO3tj
         faCau55KPFpbeBf7yozSAxFvfRPNg2UIn+/Xrs85ZEaSMesFXq4ywm1vbTKQTzkJx7Wj
         o8UUusDuSxHQ7mMnorWwxEwBhwS/zFLdMOBR7n1VAincHHjINexPJ4VJvDYz8p13DzwE
         bFvg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Zrhhtz6e5jYhx8LGMa5Gv9bWyaglv+hfaDmRZkRLq8snoxTcNZ8E4wsKCzQLOQf8hVQfZa8wFydtkd2V@vger.kernel.org, AJvYcCVTgh0R8FLbHOgdhV47A67Kr1N6dMgiQGXtMU0Z1ef1DrRj/PEw3Tg9XDCqrkmXbuXu0WMf8fT3CXQ=@vger.kernel.org, AJvYcCWoCEe+JDfSXm0tim5T8RyYb6Xoax61xObOS5Mngs7AY2FAv/11AWyW/x9Yz6ypnF6zcwyL0ZCOr+kK@vger.kernel.org, AJvYcCXoJbav8TqoAFNAjEiC/3Hi2ZLuvqA25Y8FagXVQpNMl3asd2RLNaIRXvxwl2Hff9bHfqu+HZuN+q42VfbV0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3om7I+0p77s7Aj1hn615NHu8A3TXeJq3IXo8nDNBt5HeXDSJJ
	TVidI/oC7odk+OYLhokBPrw6Rzc/rWUg1mrmJfE7VArrf0oxsFGc63w59T6a5ktUim7r2u9XOlI
	DOhWFSuKyOoc+tECf42yx/MIr/CYWDvo4DaaUvew/
X-Gm-Gg: ASbGncvImFLsK2dVUhZbSuUBordW7kl/9OW7ZB6XM63TeV4EAa7D2mh4rerF1EfVDyv
	S3AfsSX/12e0SsSgMIHF6SpJbEBY2dw==
X-Google-Smtp-Source: AGHT+IFw774SQc5f/E3/qKNgVjFvhg5SBOnKwWNF0IB05KgUZjFgT5iwuKqww2EKSOoPqGsXNx9Fv0RKwOHRybGib+M=
X-Received: by 2002:a05:6902:2803:b0:e38:b3a2:6bc4 with SMTP id
 3f1490d57ef6-e39d436e234mr5853142276.42.1733301201994; Wed, 04 Dec 2024
 00:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1ASwcMuxEWmudzP@gmail.com>
In-Reply-To: <Z1ASwcMuxEWmudzP@gmail.com>
From: Luoxi Li <lee.lockhey@gmail.com>
Date: Wed, 4 Dec 2024 16:33:09 +0800
Message-ID: <CAL7siYM7MMrYtARvicp0+AAdP=drufHVgCAgcTOmSJxvS5_mvg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
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

sry=EF=BC=8CPlease ignore this email forwarding=EF=BC=8C thks.

Dmitry Baryshkov <lee.lockhey@gmail.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=B8=89 16:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 20, 2024 at 01:37:48PM +0100, Neil Armstrong wrote:
> > On 20/11/2024 12:19, Dmitry Baryshkov wrote:
> > > On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
> > > > The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwid=
th
> > > > along the Frequency and Power Domain level, but by default we leave=
 the
> > > > OPP core vote for the interconnect ddr path.
> > > >
> > > > While scaling via the interconnect path was sufficient, newer GPUs
> > > > like the A750 requires specific vote paremeters and bandwidth to
> > > > achieve full functionality.
> > > >
> > > > While the feature will require some data in a6xx_info, it's safer
> > > > to only enable tested platforms with this flag first.
> > > >
> > > > Add a new feature enabling DDR Bandwidth vote via GMU.
> > >
> > > Squash into the implementation patch.
> >
> > Which one ? the flag is use in the next 3 patches
>
> First one which uses it
>
> >
> > >
> > > >
> > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > ---
> > > >   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/=
drm/msm/adreno/adreno_gpu.h
> > > > index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae00=
8b15b562bedb96cd391dd 100644
> > > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > > @@ -58,6 +58,7 @@ enum adreno_family {
> > > >   #define ADRENO_FEAT_HAS_HW_APRIV                BIT(0)
> > > >   #define ADRENO_FEAT_HAS_CACHED_COHERENT         BIT(1)
> > > >   #define ADRENO_FEAT_PREEMPTION                  BIT(2)
> > > > +#define ADRENO_FEAT_GMU_BW_VOTE                  BIT(3)
> > > >   /* Helper for formating the chip_id in the way that userspace too=
ls like
> > > >    * crashdec expect.
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> >
>
> --
> With best wishes
> Dmitry
>
>
> ----- End forwarded message -----

