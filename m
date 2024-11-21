Return-Path: <linux-pm+bounces-17926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ABA9D539F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A5E1F2279C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACA1C7B69;
	Thu, 21 Nov 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4k2SthJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F93C47B;
	Thu, 21 Nov 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218798; cv=none; b=affIviAfzO/38w4cYFfRZlwAzVTSw0Myte26qDZTMd9RbKM9b9GqcfXxY08KJa8FJIEQhTt2pMK0iesrEkmVkm0VS4U+tLNhWiMnUTADSFaKVEtGU/L1eeVUnInw6brJY01S52W2Zcvy/uMZ2KfIsMUmr4B4Yf5KNh5ISbbgPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218798; c=relaxed/simple;
	bh=L+PEngRCazXOIXtZ+LN5E7TP0Zee2Caw9NzrRmAHe/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJET2GipngHxSj14CYO/5xQQAvL/ML4usv/WEVnQbTQ0kKZHZKCrfF1GrRKrxD1R9irUUgb8FLZglIiQjLI4UNzoRQvUMikYYCNXkuhBwnijbul3/WRT6yWO3L2FLee/3f6WAx6Q7/cPYcgr0aUETVkm6GR8XIzEJrUhCqitLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4k2SthJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83e870a646dso36069639f.3;
        Thu, 21 Nov 2024 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732218796; x=1732823596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diAZCrMsMB3HqFx9gMbdYj2qxdjUwPEtwF8yqOBUtUA=;
        b=l4k2SthJece5m25NkOMUbRrUjmG++Vm9NIXLnisV1x3S7dVARQv5P1bd2AZHKXc1W7
         JQzbd/hS9f39uFLSXBG0kfY2pkJpCUNx28IMdKgiqwcd3e0ypMpZsQVtrGb9ldputud9
         2iupk0uZuL+5174w9ulFFAa8trOM0/4A19Q+cz6dBB0kCNFUnvE15g8TYDxsHYeRC91E
         YWnRVdV7PqOMKBMxGHoJs+9lbvGwUbUqUtwrbIgPX867z7r09LHertSIcVib1iThbPhO
         9LWRkmco02n4VoT8JnT6QwWAOLM93pIicJkcKj6i+GcM1POVX0qdjv88gNFAt6F46JZJ
         Basw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218796; x=1732823596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diAZCrMsMB3HqFx9gMbdYj2qxdjUwPEtwF8yqOBUtUA=;
        b=opWFnIcSqvdCovzuJJd2bX0U79+dSoRygoxIAAwxpJUDAy5rXCwb9FVLGTEsn4Kjk5
         PU5LDl75iXu8SQZqQLyMkeUaYL32Mu1OrK1FhphcdK3rNiE/5tN6URhvGSreuOJzY4tw
         Pr5qUd4tDill0915AiDuqL8+DZLOvybTPjZp2vfJIjplRPH1onez+SrOIgArWtJ4CUCx
         AxdStTuyaIviPS0XF0LuN1G7LMFVvRan65mWnrd+qhsTnf+02Rq/UACBWXRu273d3J0I
         P+RUTM6tB/QQfTxWmIvPPhBrar1+0cOBtOhDEzlFuaG8tcx8c5jYz1w7TdAOBRKmcikO
         XjMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3pQQ154rmqBZaTWDEXvjWWSdmtWw4HNsIf651XMpWSztEORXdSJDfi/qd1pKtoPuJiyF6m0GyES4=@vger.kernel.org, AJvYcCWAroouALWTRbr4SzX1mHWnarIWOXHMmWwxifwoglqEJUNkYtbFjlPn6lWOl1RsV4wKERwVwfmUY9c8@vger.kernel.org, AJvYcCXLDjnGQGvobBV+pip4JYd+dKJ7YBDBzUl60vd8N7QgCNlhqDiwsv9vlBsSMKbVouIwe+f+V2y0B3c0gZPQ@vger.kernel.org, AJvYcCXwrMfhQR7+jg8DQge26w4rUiRnxWiWGDZPmR1ZdAVKbcNGWwskyD+iSuIM5R0ak61qg7pppFrjcQ0rqfLUSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMm9WiygQpEfDpw5fmS653BxUxNgEvGjx5ihdeQ0JZ31tQdUWv
	aGeyASZkJpg3sg5rxZRFwYK5nh3xumDC64gjpusq9tTA1QW1zDp+But4/qlKDgamvLIihW+7KEK
	CIFseu65rxxwOHnXdNO/DVEQNxXA=
X-Gm-Gg: ASbGnctR1HODIuvCczXsdvLtlaRGxi6wV6Cmh2wQCK+Sqv3Tejy67FQ7whbRCbzGKvl
	pZrt4nrLh5uPLIn24lSRatUG+6p19E3rb25Nc7xx9Awxx8b6F45cmpH3T69YjeQ==
X-Google-Smtp-Source: AGHT+IGVvKdxeJ2KfZ5TpOhV5e8CaKf2OdRVRdRq27Mf98UYeu0Bs53rOSroYiruS8NzSiyjkP/fPk3EC6WgTw+tzqg=
X-Received: by 2002:a05:6602:3f83:b0:83d:ff89:218c with SMTP id
 ca18e2360f4ac-83ecdc8f12dmr23501839f.7.1732218795759; Thu, 21 Nov 2024
 11:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org> <CAF6AEGtBVDERQjcoXriKK3d2VZy2QMUxZZJbFdSgbpvue=0QNA@mail.gmail.com>
In-Reply-To: <CAF6AEGtBVDERQjcoXriKK3d2VZy2QMUxZZJbFdSgbpvue=0QNA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 21 Nov 2024 11:53:03 -0800
Message-ID: <CAF6AEGtrs8175V1+onoH4p6u4benT_tzz-Gg3JkNA+WE9Ltcsw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:50=E2=80=AFAM Rob Clark <robdclark@gmail.com> wr=
ote:
>
> On Tue, Nov 19, 2024 at 9:56=E2=80=AFAM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> >
> > The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
>
> nit, s/GNU/GMU/

And I guess you meant "GPU Management Unit" (presumably this isn't yet
another recursive acronym

Same comment in the next commit

>
> > along the Frequency and Power Domain level, but by default we leave the
> > OPP core vote for the interconnect ddr path.
> >
> > While scaling via the interconnect path was sufficient, newer GPUs
> > like the A750 requires specific vote paremeters and bandwidth to
> > achieve full functionality.
> >
> > While the feature will require some data in a6xx_info, it's safer
> > to only enable tested platforms with this flag first.
> >
> > Add a new feature enabling DDR Bandwidth vote via GMU.
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15=
b562bedb96cd391dd 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -58,6 +58,7 @@ enum adreno_family {
> >  #define ADRENO_FEAT_HAS_HW_APRIV               BIT(0)
> >  #define ADRENO_FEAT_HAS_CACHED_COHERENT                BIT(1)
> >  #define ADRENO_FEAT_PREEMPTION                 BIT(2)
> > +#define ADRENO_FEAT_GMU_BW_VOTE                        BIT(3)
> >
> >  /* Helper for formating the chip_id in the way that userspace tools li=
ke
> >   * crashdec expect.
> >
> > --
> > 2.34.1
> >

