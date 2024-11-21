Return-Path: <linux-pm+bounces-17894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6A9D52B7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5301F226B2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A01BC9EC;
	Thu, 21 Nov 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcQSqRec"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB21BD9EC
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214688; cv=none; b=lhT0NuHdkr2C+xu/7YaUiP6+wYkqsyDpXRWdz7RgTNDkYd14VtLHr36XmVWOLAnnZoyL4NIPqNGymUhY2rRkT8KbxzvDx9QKBUXmMUw1l838cCKBInGIq2la7cnsNYjswfDPvIlnieXEgrSy4Jox9zOLaH7T7pPdym7v8E3+pZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214688; c=relaxed/simple;
	bh=hCbPp2TQVuNBNMscwjo+U4IAaocSAWYpWyCvDy2yg0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9bfu2SQrA6Ab2WEhQ35dwbFqsr6j2XM4nHwUuLouxPVR7kEpScjimjzFAKqIwfueUo9xIKf9tP88jKIz0rOXDXgsaRpVMrPoihhz4sy+/9p87WXP92wi4152QopEbxNT1FmW+28c++jW65BLJHATY7CDExOwZuPz8WHdP4AAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcQSqRec; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5743074bso11182911fa.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732214685; x=1732819485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf6pEyNqxMlUop78/qMKAZ8N3+EDKOTAPwM9hjCyqUs=;
        b=AcQSqRecKeBMJ37iqF8ZHM6C89NsowqOu/ET3FgyuPz9wpi5UgUIqB45ajNHYyw4YB
         SJpeDyuJspi5hqvSj5BxF9d9JDQcMgaAoMGyQTPqQdECnKt2DTNCb0+VcoskezjG0olF
         wHdiZ+NhXOrKUrFqiDSTH1HVOWayd3jXwfmUN+X45NcY2dSYoaKqwXXMKJBY85sz1Cje
         Er++0kDhBKmmBqtlJS9iI95r5QaiZIITFu21vcCqGOEiKnRdMCW2JvLe+HjviteCQPSc
         v38shaHdKDomWk7lMjFX4xyaEXLF9oPIG5OcSEcM6V3E2o/GC0giJbV6hIKif5lyfGfG
         diyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214685; x=1732819485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf6pEyNqxMlUop78/qMKAZ8N3+EDKOTAPwM9hjCyqUs=;
        b=L3U5ehmzA6FqiDUZE3hhawPMKD2f6YdUPWRlzd42c6p0SYt81JRfY0CKVoKAMI4wsj
         MpSA7PmiBFQM0mZr/XSWKC3JqJJQHIUfWTDYuPM9yze3mPRnHajYYu1h/3LKBpN8RBxZ
         +VF0V88FTmwdjtnOjqDNahCZzqG3ihubzowu+ATzMfv73+EAPJzGoAgHmK2hFWpR6JYt
         yMGBmQg1WUjd8+52coAxpKCx0dB49oAR3Q8G+cvU2VbFStfpicMCKTrTh6Lz0/vM9GGP
         eCPs7ZA/S7uXdyPWzBpw3Gk53oWJylNwlhDl9yV41VKBqnSBacO1j6V7TvWMKrdfpK7o
         B9IA==
X-Forwarded-Encrypted: i=1; AJvYcCX7NU8bwPGF4Etfeb4wTK4fIOSghuAlOywJKTsm8bAWOr2Ud9xBrMS4FNCnhIVj+qrkhDJFrT5Pgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/jFFixbyJRpsWZ80o6aLyNCAD6REoDvhIz1p3nrwBp91hahN
	o5eha4jXG665Z5r9m7uv4VDBaftF4RwEUjgnMv3cB9DrZp0+e8x0kEdOTKKF+Rc=
X-Gm-Gg: ASbGncsfNplLd90pmnFQZlAfXZki7zkKtY00RthPp3zhwrYE2ep24soj8QPfGoa6vla
	mn8Sw+geI28gzPyt7xCNReLgNdlExNBijlLGJzWxzIipByoFjONm3ykkrKiUOb90KmzJpMH3jiE
	u11VvF/RFSKw0ymiHaJ64K/cvbObt4cssHeFFsmtX7NgZQf+LQZJQgvxXcAKWvqpciFXz81aLS+
	aoQdvgYmFuQI02QMjyvhu1jusx1ZGh7S5mM/Rs4069V3LfGo1F1OC62TKutRy2ryFAdjlubO1yq
	WZxe57nisE9rsun3X9q+olTmHwuYgw==
X-Google-Smtp-Source: AGHT+IHi1NhWVZuelCT/g+ME6q6BNS23Y6fXekmq883H2WMs3ZLySQ3u7RX7hB18doxDPGP3Av5AMw==
X-Received: by 2002:a05:651c:1612:b0:2fb:4da8:1e6a with SMTP id 38308e7fff4ca-2ff9697ce2amr15005151fa.7.1732214685212;
        Thu, 21 Nov 2024 10:44:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d40257sm177041fa.46.2024.11.21.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:44:43 -0800 (PST)
Date: Thu, 21 Nov 2024 20:44:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
Message-ID: <4sxmrx3raiz2n3wz75n7gc6eekuh7nnox3xbau6dbyqyo3mzj2@jmml4c6lesgv>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
 <iw75ptavkqw3vybfov2f7koz5nh5lfzxcou3wey7rdsqt2gj5n@7luy2kqrzkj5>
 <8218a053-6b69-4e1f-adb0-4c11930412ed@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8218a053-6b69-4e1f-adb0-4c11930412ed@linaro.org>

On Wed, Nov 20, 2024 at 01:37:48PM +0100, Neil Armstrong wrote:
> On 20/11/2024 12:19, Dmitry Baryshkov wrote:
> > On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
> > > The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> > > along the Frequency and Power Domain level, but by default we leave the
> > > OPP core vote for the interconnect ddr path.
> > > 
> > > While scaling via the interconnect path was sufficient, newer GPUs
> > > like the A750 requires specific vote paremeters and bandwidth to
> > > achieve full functionality.
> > > 
> > > While the feature will require some data in a6xx_info, it's safer
> > > to only enable tested platforms with this flag first.
> > > 
> > > Add a new feature enabling DDR Bandwidth vote via GMU.
> > 
> > Squash into the implementation patch.
> 
> Which one ? the flag is use in the next 3 patches

First one which uses it

> 
> > 
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > > @@ -58,6 +58,7 @@ enum adreno_family {
> > >   #define ADRENO_FEAT_HAS_HW_APRIV		BIT(0)
> > >   #define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(1)
> > >   #define ADRENO_FEAT_PREEMPTION			BIT(2)
> > > +#define ADRENO_FEAT_GMU_BW_VOTE			BIT(3)
> > >   /* Helper for formating the chip_id in the way that userspace tools like
> > >    * crashdec expect.
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

