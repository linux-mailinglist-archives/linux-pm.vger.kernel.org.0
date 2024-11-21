Return-Path: <linux-pm+bounces-17925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F099D5397
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BC51F22196
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50519FA93;
	Thu, 21 Nov 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmna5D7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A99200A3;
	Thu, 21 Nov 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218629; cv=none; b=OokVBdhJAAY5isL8GFJUqAFCvOpVcbuTG2Idb2hrBOovqPyOih8eGt4fzBtslV1GBfBMvvyn/mYk9lQBReCOYEow9Sgi7j1ie4UF7bBpdC9bJA7Nc1TC63ATb6oO++bDzkyPBIjwG40dqrfW+ipfAfb0gMcN5N1cdJMzXQM5Iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218629; c=relaxed/simple;
	bh=7hzcrmCtwuNvAxC+vOI8qVzf+tjBP4ZaOWNH/zYFyJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGWR6ML78z6DuMv9KGm2bH8x04+i+S7JJkZRNkE7B4z4zy1aleu1EknTCf+n+cefvZsMwnEtQ99e/llU+OuMBIHfA/Zjhs1tTFheAI8EG5E7QAbA7qQR6lHDUKudxiqmdoLiFH5aCZuViN0BDu33P5F76toiQ3euTn4O5XxaNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmna5D7o; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so44207539f.1;
        Thu, 21 Nov 2024 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732218627; x=1732823427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz3fx5gVJ4M22KYICfDKkgkAafxEBWal+eeMe1wl3mY=;
        b=fmna5D7oME6EhKZEYOPlzdY/M8kIR8zP+AsoGgQs1dfIFVsRgukwoiH/IjgTlF/pgH
         /yT/XUiYyo8c4lnu8s/7M9KQ8Re/cZe3hlxDUzUn9ls7Y/3T64ErPXF0UiTji9dZoFO7
         tfdNzkkyErstPw1myab65rv/YFpsSo+OIUwlJuJ6qd/6cF8F+mDLAF2yli3uXFH4MnGM
         a4oOgz+I5ySNVVdP5UvlHP3gW49wKED0KKBv97IUiPfuCyjAo12qhBW8NaOgS/m5rz9c
         lpz34sI+PCDPhTAAWwx0An6exeGxpp5Apd7ZJvKuiuYQmrL3nuNj3uavlCl/rXJxT+kI
         0AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218627; x=1732823427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz3fx5gVJ4M22KYICfDKkgkAafxEBWal+eeMe1wl3mY=;
        b=mdSpvDocUEeOsBsFcqkvRgoZDSUEQ82xYDwedhU8hoMrhsQxMRQOEZjGFahZm69dq5
         7fjXbBxzgyU+rdOeUG9RmJcsbzvx4KMddCTKUl/6P8a03JtIIL1TkOhZ11vRZXwpCWAI
         YraZIFGCw17WPnZioKmiPpAYCvvzEGfY/7DY2KTWCJri+ED5wMblz+pxX68OZWyYrrWo
         JIBbd0qDOjK1Kfnwyg1J28mKv/nwnYtJ8iph44iFOagNpAFO+xFgfS9YMFmW5eC6NxrN
         q4h5QntGp2GKHCxYaFnJrI1X2GHoX2DoPt+PZlId97BlsmbnMmiso9OHDgTds/9SZwrW
         MLlg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQpEldzLe3RHr9PY91WhiZ8klcf6UhyQJzLQw0bDoIvxK5Wlxth6ltNBCJGD7n+cNd/XRbrSW9o6ze8Dm7g==@vger.kernel.org, AJvYcCVf9KGx9kp+GDW7eYxmfseBbVe3jKR7k96hd+QBI7Z5eXwjfG74FUTbjEPMkwGvFcpjFSN48xbSV3E=@vger.kernel.org, AJvYcCWnqcLODDqaBiM3HzRtVXON4zsaN4gFsYyl5vHhndu37ZnyOHPajC3yf4+5jC1YX/ro6Gbdrwp0Bakmic9y@vger.kernel.org, AJvYcCXj4gRHpTBrK3ypCK1VUxivmViz/D8IqOwzMAV9/fqvYY8V7ReBa41sKenrTXwwWtwRGtro/vQxMyT+@vger.kernel.org
X-Gm-Message-State: AOJu0YybGSC4XuTUgEOdkPut/ZxI1E7FKPwi/lDRKaKSmDN8Y8CAW2S5
	f1xvjOq9648ZtdmobypN0WT4W5djToZCIU3+c9CyomDFQP2sxn0Lp4QGhxAViZPWhojFTCbQ5Oo
	y6Y5jah7Mcc3ilqutnw2E7aXe8dI=
X-Gm-Gg: ASbGnctuQbl5zWZ0IVRaf7JhxetmAeZjGL8rVOntqz/dPcnUvlMNOg8KH34qxP4DN3/
	sHQ1HqyeeWMVYya8FmETkfc+FeKhQwZbCTbfIq+Fb3OygifBjmXcH0pZ5CKYwkQ==
X-Google-Smtp-Source: AGHT+IEcsVwQ+z53GhnAADuTWAgvyRSNn8jsJyjBPVBj9ItLAQIvxVXOd4pN8tYTG8mbfrhPL5pOlY7qrsRsAh+b038=
X-Received: by 2002:a05:6602:1610:b0:83a:c242:82aa with SMTP id
 ca18e2360f4ac-83ecdd15ebcmr16360939f.13.1732218627229; Thu, 21 Nov 2024
 11:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org> <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 21 Nov 2024 11:50:14 -0800
Message-ID: <CAF6AEGtBVDERQjcoXriKK3d2VZy2QMUxZZJbFdSgbpvue=0QNA@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 9:56=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth

nit, s/GNU/GMU/

> along the Frequency and Power Domain level, but by default we leave the
> OPP core vote for the interconnect ddr path.
>
> While scaling via the interconnect path was sufficient, newer GPUs
> like the A750 requires specific vote paremeters and bandwidth to
> achieve full functionality.
>
> While the feature will require some data in a6xx_info, it's safer
> to only enable tested platforms with this flag first.
>
> Add a new feature enabling DDR Bandwidth vote via GMU.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b5=
62bedb96cd391dd 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -58,6 +58,7 @@ enum adreno_family {
>  #define ADRENO_FEAT_HAS_HW_APRIV               BIT(0)
>  #define ADRENO_FEAT_HAS_CACHED_COHERENT                BIT(1)
>  #define ADRENO_FEAT_PREEMPTION                 BIT(2)
> +#define ADRENO_FEAT_GMU_BW_VOTE                        BIT(3)
>
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
>
> --
> 2.34.1
>

