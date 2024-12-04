Return-Path: <linux-pm+bounces-18520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACF9E354C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 09:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8FD167D37
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C313F193091;
	Wed,  4 Dec 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX5cXpuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EB192D87;
	Wed,  4 Dec 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300940; cv=none; b=pUC2tozQFqorQINEsWBBh6yGY4khRRCIQYse6MJ7yzpsgd87UeEFj7us2FyH3Iok1OaEOAqlViNvEdZ1WgyCSM+diY+V4tf3e2E8aj38KXtL4Ca1HQDhA0JiHxTthH3pzcLBh41NdY5rVcc1i2imgzTo4KxyBfaSnl9Bk+195fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300940; c=relaxed/simple;
	bh=txIE/I72Y8y4XvomCX31CWB0nBeznf49Izae2g+/X2U=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J+HIOC1K5EIxj4QQAkLDaU8cva4FkIgJ0NxTAEojeHMoogSGbEM59hkQOVDO2Jz11vTVi5OhiswlcqfRTrvgacIJ15YcBr/pAcUUFWFEszAZZ3P/hqafVWLEW6xKqyIBMbuDrj6mVxq8lVkqtXXZGG+Ul9B1gI85z1dSWkrRaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX5cXpuX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215c4000c20so15207445ad.3;
        Wed, 04 Dec 2024 00:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733300938; x=1733905738; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUWkO09ScmfYLGTWW9HNvL8CRZ3OvigAhD+dzpuCh8U=;
        b=nX5cXpuXM0a0Mx2y3z/bi2a6yjHfKST1i7eM3FoW1P9dpa+3gAyGVuKUBuA2VTtPhD
         RSNyJ0ybJtD3hIv4mTzNFerTVPVMpx6RwrHx8tcW5xLKv4l3OQUhH1vvYfgFF3QKX5BE
         b2bxI+KUKmRa2JYt/L4ClRfQjpvzVoctppXxmN+hdzoGGSOkFBnDSXgFi525taT3t8+M
         2goVZN/ZNQLTMrf2UQrzpR9gkx5kXGM+2aLtTDanLbekP0WjAVORhKlbFSFjxMn2cxtt
         V8u3AWzRjuxt4R8ysShn16pmB+KQ3ZhETGDB9MW4y2Qzuk0b4wz4z3nUdeXrTYWWm5fB
         YCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300938; x=1733905738;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUWkO09ScmfYLGTWW9HNvL8CRZ3OvigAhD+dzpuCh8U=;
        b=lHH2yGK/5osigesCNuKplcUBPyBusz+aWGAKs+GhVqMEThxtXo7roWwJZDAZ5SPQ2y
         QM2GA1S7Kq4eVC+rH7zUAFUs6VR/x6Y4/gR9PJZD8C3D1vgDjIz+xAFoeCZlYJu1Bt7c
         lvlcH3Bq2wWMpe5g5oCAkLOgwlzbAxIMl8SY/MivhGF5s9vmokMp00CWH4ICLFZmaTj9
         3E6jyRmJ7NSWMa0SgrSpWi7IYObH+njJs+VSH7YUHjGHhvojI6vPy3MVsHV9sFVA3IYS
         db7SENKVSGE0ByqdrupzHrkp5HOR8o/cYD19ZKq9K5VXXqjRDtqqaYvpgNXggWJIRFSx
         w5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5xlHMdY80Htvk8DA9vQSBiTlGqB+QW6AsT10/fE+bCCFui2XAGAaMMPZBJ1UmNQLwlsslwTWw+LHboSj1@vger.kernel.org, AJvYcCVw4/K2qV7aI7qjbBfj5yV+BcBepoZRUIh+y7oPguJegWHU6PHAQ4ucNx1Iu02tZBZbfviAthcOCmv9@vger.kernel.org, AJvYcCWL4xK3gPH98v+P5o2qT4D7BEAZEmoB73Fd1a8a08q3hFZyf9u8QnNiwfQEBzAt5Vzp8rqgmVzviZI=@vger.kernel.org, AJvYcCX40PDvodNOjapy37hxSXwttG4MuEd4dkU8GTPEzXK1q7GehvqKpVWN9vXc0R9KOMvUlBu3Exdofn7Q8x/8TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjYGJ9aaoR20kIwkJnY9YWkBcXfq/NjrNdKA0WCBY8P0GyZwZ
	9visETcJaMjLWbo4BDraaEizLZmmgxFw8ADUb55icSi4UpSr+FJ0
X-Gm-Gg: ASbGnct3Inkv9ipearv8OgYsN6dXXP+F5hqFZ1R8OSW3dm4oddCXHpgVZPDuSGbPIIu
	JNNyS/2HsHDHfmLL1aamw++hX0mwLfgLX23aN1w+y+sRTwq/2QDAfbV+FjWsyM/l0w9R54cEV33
	UVcDxPKJ3rsd5s/bLfFap4T8lYsCaEU+8j76vMlSS2MV7scDtXOn+ioJSQnwBUsKZbGLte9WlJb
	fnb2mnHsr/qu51zjAmWY9LhWALGe9mSkrJb1ON9lOIq8E7YhU1Vd+x5RpM=
X-Google-Smtp-Source: AGHT+IHBB8zm57kTineu1HQVncxbz7lNJJvZp2gDMacf/P23sMkeqR8Um6ILeNeARtCklWIsKTJOgg==
X-Received: by 2002:a17:903:183:b0:215:acb3:375d with SMTP id d9443c01a7336-215bd1ce3a6mr68186245ad.18.1733300937791;
        Wed, 04 Dec 2024 00:28:57 -0800 (PST)
Received: from gmail.com ([113.240.217.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155f195b2asm71157375ad.273.2024.12.04.00.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:28:57 -0800 (PST)
From: Dmitry Baryshkov <lee.lockhey@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 4 Dec 2024 16:28:49 +0800
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
Message-ID: <Z1ASwcMuxEWmudzP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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


----- End forwarded message -----

