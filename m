Return-Path: <linux-pm+bounces-17895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFB9D52BC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1771F21066
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C11AAE13;
	Thu, 21 Nov 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKtDv2sS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F7200A3
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214765; cv=none; b=eRMExm0YDQB4+Hai0pHzJ1UmZKaRzC1j3BzfX2+AsA1FmcyrZUPAq+WhBXZNkQVXkKlnpRwIRX+sYWJIOUqLGiEKGyX7S3LLJXhLmVzBzD0JEMSSISMyqIQY+cBxgUz+qeJavsSCI4LAgym2g5BqdMOrBB8QEjETDdApUc6NNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214765; c=relaxed/simple;
	bh=3UUlF0HmxlSVz8Df4mv35dnQDsPGSDO7wbgueULFr/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV5k7JltiAfTEGrr/Xdz04N9oaptsIlNAvdpnvdJo/nCLL2EJvuD4h0b2BG7NCi7h7NFQCerZH8hyZ5qprS8nXhihRn21IalNoz/iWrNCFLkOIHZ41J+M7Ky4eK2VetP+wYCa0qyGxhYUBvEP413I4ol+NJKkJKYdqYwGVHKe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKtDv2sS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f84907caso1338270e87.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732214762; x=1732819562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnablajdzkJVJy6Wp4cRfkLe1DSYH+fJmZ0JrWl5Hcs=;
        b=TKtDv2sSEGqIKmg0RK6qiMmKkwmtE1dQGguTGiu9XutIdt36vETisvDh3szpJIqw8E
         OFlqDE+drW6IWw7YDLcsUiiwn4sYfT0/Q3zXrirbVbP/vRd79Ys2xe0qNJKreVyFKsTF
         Hq92KvSfEpQtmTkJO+eDGiX+nECVtSJmS2ltuqjRfKuimEp8T6YaA/RXqtkDxr+3p05+
         W69eOKgPuMWx330i5qPiqGOUuznaYUCX2LMdKxGktdzXLWq55xJgmejSpR3NUq/PV43P
         ceUcIebASRm3vFuJOV9iumZYIJ0CJJy+u0PiGR7ExuRtPSZhcuIADU0nZm9v2qLMlqI3
         Hzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214762; x=1732819562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnablajdzkJVJy6Wp4cRfkLe1DSYH+fJmZ0JrWl5Hcs=;
        b=a34kO8UHsdTo03Wp0nf/oCp6w+hkUnEv57p7ZbSG5eOdAQM+TuIjaJPC6cG/P0j7pq
         3jcSNbUbzYPd7q+Zywvgr/lQ1Kbz0kc15dOgH7fdJ6ovNtXDeK4VgYAlKnsn/nfDN1Yp
         wPWuqSAtEb/oKyIxnj3q8xHRrZb5wmJvNHB7kqefe66j+rB6H5gtFMFiqWatw7IdJ+bO
         QxjjcN8p72XNuh2YdX1rzbJmaoca+kELQLOmsuvOw0ZjUXxxBti9qLGdSfUMUT3iyLfL
         FnB6jDXtMObw4EExcgXReyl2d2urNViR+45qk8cPyCStTOZY44V3D70rrsXHEj5CdDFU
         gZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUWFbMgKpwzHRyQfMteAHCZ0kMXphNANR0eTWuvP/Wtr5HBEsUQP8n1hPciXAD4AUCi3qcb5NTmXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VMscuaWR5JZXSLIBr0ak+RrLOcjrbpkk5nAiypBKCpHvUZ6J
	Gx0Sgtt9aM514M86csacUtmzvf1otNg//mb7sq74paK9jzZOVRJdZZTcy6adQqw=
X-Gm-Gg: ASbGncveSLwrz+vWb7QFOSCFI0UldtMuHJ3PtX54hSc0xqXQ8WmfUjsdWaGiOp54GAL
	cufv/QgkWDsggdasGHnpW8G8dAwIwyA8dcWh/yrO9RyFAxfAZGuZdcRjUGxPqctbHjydl+VgZAh
	QuoAMRTJZyl+hV77cUZMd4F4BuGzv9RHostZFHBVHui7CXZ7IMO/tZBrUOewZcLIDECbOjNWHgS
	HaAYpwFtnKK3dkseESkAVVtdc4BZX4E7fswNNix//le+VOoPIIpbV54UJVa8pCJH44PnS/S92an
	Z2sGTu0QdncDF4MdEr06IU4Sf7Lr3w==
X-Google-Smtp-Source: AGHT+IEFMJhZvAQ6Q6Wl16HShSZo5FGRcfel9GsUflAZEQIhYBQDxaV99Gquo8VIj1VgFnA8lOzrRw==
X-Received: by 2002:a05:6512:2383:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-53dc13417b0mr3615259e87.25.1732214762476;
        Thu, 21 Nov 2024 10:46:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497dbfsm44161e87.244.2024.11.21.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:46:00 -0800 (PST)
Date: Thu, 21 Nov 2024 20:45:58 +0200
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
Subject: Re: [PATCH v2 05/11] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
Message-ID: <yo7silisbeesgdn54x7wsy2tgqw5wcjzdbm7ay7htajk3k6xib@v45gfvdtlaie>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-5-4deb87be2498@linaro.org>
 <stifp2gtqxmegysrewfuwdsxpqin6zznvqndw7rj5nysi6rq4g@543stomenpvf>
 <a1aa497f-3be9-4870-a09a-d91f10091308@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1aa497f-3be9-4870-a09a-d91f10091308@linaro.org>

On Wed, Nov 20, 2024 at 01:37:16PM +0100, Neil Armstrong wrote:
> On 20/11/2024 12:42, Dmitry Baryshkov wrote:
> > On Tue, Nov 19, 2024 at 06:56:40PM +0100, Neil Armstrong wrote:
> > > The Adreno GMU Management Unit (GMU) can also scale DDR Bandwidth along
> > > the Frequency and Power Domain level, but by default we leave the
> > > OPP core scale the interconnect ddr path.
> > > 
> > > In order to calculate vote values used by the GPU Management
> > > Unit (GMU), we need to parse all the possible OPP Bandwidths and
> > > create a vote value to be sent to the appropriate Bus Control
> > > Modules (BCMs) declared in the GPU info struct.
> > > 
> > > The vote array will then be used to dynamically generate the GMU
> > > bw_table sent during the GMU power-up.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > 
> > LGTM, two minor nits below.
> > 

[...]

> > > @@ -82,6 +92,10 @@ struct a6xx_gmu {
> > >   	unsigned long gpu_freqs[16];
> > >   	u32 gx_arc_votes[16];
> > > +	int nr_gpu_bws;
> > > +	unsigned long gpu_bw_table[16];
> > > +	u32 gpu_bw_votes[16][GMU_MAX_BCMS];
> > 
> > We still have magic 16 here. GPU_MAX_FREQUENCIES? GPU_FREQ_TABLE_SIZE?
> 
> Yeah it would be max frequencies.
> 
> I tried to replace this 16, but it's used as ARRAY_SIZE(gmu->gpu_bw_table)
> like the other gx_arc_votes & gpu_freqs.
> 
> So I don't know what do define and where, and how, a separate patch ?
> 
> The define would only be used in the struct, not in the code, or whould I
> drop the ARRAY_SIZE and use this define ?

I'd say, define in struct, ARRAY_SIZE in code. And yes a separate patch
changing gpu_freqs / gx_arc_votes would be beneficial.

> 
> > 
> > > +
> > >   	int nr_gmu_freqs;
> > >   	unsigned long gmu_freqs[4];
> > >   	u32 cx_arc_votes[4];
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > index 4aceffb6aae89c781facc2a6e4a82b20b341b6cb..5b80919e595fa1ba0a3afcca55feb89e60870cb1 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > @@ -44,6 +44,7 @@ struct a6xx_info {
> > >   	u32 gmu_chipid;
> > >   	u32 gmu_cgc_mode;
> > >   	u32 prim_fifo_threshold;
> > > +	const struct a6xx_bcm bcm[GMU_MAX_BCMS];
> > >   };
> > >   struct a6xx_gpu {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> Thanks,
> Neil
> 

-- 
With best wishes
Dmitry

