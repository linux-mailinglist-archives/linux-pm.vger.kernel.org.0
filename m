Return-Path: <linux-pm+bounces-17626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2B9CE9D0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC8FB382F1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221961CEAD5;
	Fri, 15 Nov 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nR05r7Nv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1A1BD4F7
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680340; cv=none; b=hSCQW1MJeYq8pEy4QLLQFZqGQ9MM5RSmwmDS4eUMmWAvXPJs7iR4nnfjJuytRx9cQqL3uFwMkSw+NnwprJl4my/5nEBDe4O6tXfE5Dr0U9lJytnqwO52Edm4pPy3/Y0yg5q+r3iztBfiHGJwYxTPb89eprqw22p/bgU0UQaWknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680340; c=relaxed/simple;
	bh=ZIPyT8dx+eHreBugSxOn3Ptl0BOPxKH7//P+XwhpvVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6avy59Uz1beSqVf9NjUgrNVcVJt7iJ1QsQohkK2E8Dl/D5zDmxgHkU87mam63A45HUQg3JKSGOChfe6bhdvE6djibwhHHuy9zvRpr8pp0Z3yO+au4lu1fJdI7qT8wuTIkbt0prxwieI8Gd1wFUE2ykE2mfZj+b9TQBYnXhZp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nR05r7Nv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea8419a57eso20570677b3.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731680337; x=1732285137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhxBFTVLr9CXs7yVyXnjqOaOGkDhEtwnjzGXMrCkuoY=;
        b=nR05r7NvBkkADilYRK6uzNCYjpnUGZtXbIkOVJsZT2VzuneOW/jJcogANkkNvUkN+v
         FMm7JwgAeQg6tIVVqBLfSa7QhJp3iSk7de0l8/Hg9zlrVi6UQjdK78W0rgLMM3Xja9le
         FWYp4n10nzWu1DHldcMiN5jcUKsrqbej5hAuPJ8DinZl99LHZBwjTzOlP7DSer85eCfi
         Aorc4daP4kvr1+tyqXn9gOGbYDauDaXhG37D2KmcQhQa4YuCrnBtPm3VFiRJB7E98eZv
         uBNcpodd0ill9fUDH/fbLmVZkF0gcaAyyxf4ITVmVmJkfaebtBibnwDhJB2gCYHxDicj
         6oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680337; x=1732285137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhxBFTVLr9CXs7yVyXnjqOaOGkDhEtwnjzGXMrCkuoY=;
        b=pohCvupIRXxGSMvLK6fF98Bp1RAa3bNBbhJ/B0yKgTxMWpm1nT6rNjdJnonkElR0Uq
         NABZioSCG7eSqY4sp3Reh/x3zzFydCCI6UGz/zCGcK95TRYtN/z/FeriD6N8oGDjwqmJ
         wAztTbMw81HdchX9uKdR2yw7svw82BuYzau0PUyoD+P7JxOT0CRNH3VvqG2IGR4QUL11
         dRlbA0FeslvFuNrxSwayDQC+HCBSmkZlA3ddxI6pXPAyiMx0wcfOxtiqo2dQzMBBNg7F
         7b30cC90X3NsozpDQZ5NWWU7nXHppz4lkRrlMvPxiYjQeG3DdMflotDvEuwBiZBiCBKS
         dEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCq3O5cCYvT1iTJdTTcdWQl7+wouq1WwrToUjv7iEMkDEd/DQjMwMbhy3MqkSzhBHUwa3UGWhMqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQr0SE8alsH91GRskz0UPSitE7ldg7g6se9gNA5+DYbMc4dJBz
	OpcZia2hs/v6zs2mWe6wo6fY9dgF2EAWPJ6un26UpOMmfIhR8c6M9ZbbONFwmarxiypvflzUu3O
	3xB9lZa+kHw83HvZjEkIVoQpfekLkNbVt+fTTVg==
X-Google-Smtp-Source: AGHT+IHAutNFbQIYrWEa7iEgXdJ0MlhAPiCQSjQjzOFudXA+GpwEclomXP7Hjrwzw+jQnjMyfUPPdwlemfoRMd5mMNo=
X-Received: by 2002:a05:690c:7309:b0:6ee:36be:64b0 with SMTP id
 00721157ae682-6ee55bf0725mr36374547b3.16.1731680337418; Fri, 15 Nov 2024
 06:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>
 <sgz4h6rlmekiwypaisjbnej326wv4vaqt3mgspp4fs4tg3mdfx@cwmdqcu6gwbf> <63a2b391-8b71-41cb-bed2-3bc7fd2154ab@linaro.org>
In-Reply-To: <63a2b391-8b71-41cb-bed2-3bc7fd2154ab@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 16:18:45 +0200
Message-ID: <CAA8EJpoFm8EjfBq70RTPtwR7Y7Rm24kHO20NukGiLGRYD0p9Tg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] drm/msm: adreno: add GMU_BW_VOTE quirk
To: neil.armstrong@linaro.org
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

On Fri, 15 Nov 2024 at 11:21, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 15/11/2024 08:07, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 04:48:28PM +0100, Neil Armstrong wrote:
> >> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> >> along the Frequency and Power Domain level, but by default we leave the
> >> OPP core vote for the interconnect ddr path.
> >>
> >> While scaling via the interconnect path was sufficient, newer GPUs
> >> like the A750 requires specific vote paremeters and bandwidth to
> >> achieve full functionality.
> >>
> >> Add a new Quirk enabling DDR Bandwidth vote via GMU.
> >
> > Please describe, why this is defined as a quirk rather than a proper
> > platform-level property. From my experience with 6xx and 7xx, all the
> > platforms need to send some kind of BW data to the GMU.
>
> Well APRIV, CACHED_COHERENT & PREEMPTION are HW features, why this can't be part of this ?
>
> Perhaps the "quirks" bitfield should be features instead ?

Sounds like that.


-- 
With best wishes
Dmitry

