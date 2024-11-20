Return-Path: <linux-pm+bounces-17808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C249D9D3969
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86D4B26618
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142E19F421;
	Wed, 20 Nov 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sglkLF7R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F319DFA2
	for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101565; cv=none; b=qpcLhxFOmDAhusaYzKncctr9Df+TMdobY8ER/FdEWDYVv5fRx/WNh3KLBf3bwOiVvW+iMqM6gIAqchfOrtDFay/lwnCfd3ZrAxz9mgj3oiDuG6+wQgW88QMZM1wZr+MLL9bm9cP7/TOWKuJvNoG9dwjw6cl3wDcND6v/HFglDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101565; c=relaxed/simple;
	bh=92Dmkw67Yjgb/1xLInbl4rH+zqF32qiTgg/ksPzkVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfITZd24HfYTSK/n4sEa+T3aWqvioa0OV3DAKVnuRnep0BUys8umE94wk7d/OTnXzTANApysfk5qSnhybNygf9SlgEjYsTR8P1/895GRAUf/uLZY6K3eyfKuxPXr6HzAiYD1mUS7ow9MOSQt+9enn41kI6RsMkjJJ3Ujb1HHL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sglkLF7R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b34ed38easo2157968e87.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101562; x=1732706362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rdRMEcIeKMxsgTSwvPC2Ggi3/Ka8/LNcXy0+kUwfLg=;
        b=sglkLF7RQfwdkl6WwhseePbAlmVCwE7AAenf/kPDt+/3lGZ+Zfdv1ALOuqO3bea6YV
         JEfrDY+EtRlwwcEW/5xgy0YrXWnvd24RabkFrOO2gwMxk7h4FfA8xI7qvjgCW+XoZuYa
         nNkFzHg/feCHL8jNR01T3gxg1nzw3lP7cPCYcVqPiq/YzFcnqr5musqsbP/q5xAqF+x7
         QUCKGdK1N02GFgkt9VstF4maOXvA6plbTwOnrnt5T+xJXxtmYEOvbACeIS9JC8UYrwKT
         G1iPx8OTn279uqKv9KYSXym7uWX7W6T3io7tvCPjNyO3Rms08uY3cWp7qSxu4+p8PrnQ
         EIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101562; x=1732706362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rdRMEcIeKMxsgTSwvPC2Ggi3/Ka8/LNcXy0+kUwfLg=;
        b=bIyUU18MNzdDGljj98x8vRY6PBdcda9u+4DPOjq3F8zmZEphej67SkmkfeOL6BBm8N
         tWqMFX70i85ZMBm3iEe2yavRqfJAPg8/UpTDmxqhV57QZlhP0lHrWvywJC//1mtNiJk4
         VjvX5r8ZyEfHZXI8VbxaVWqr2+y0X767i566AGzv0k/XWlmH+za+o/pSJ0z0yFdTOFTB
         qZrh4OVxBIuWfnpSZ09Hh2hEKH43Yg1Bo2J6etPGllviEUSJurPr0lerHcoQGotuACHs
         mM7sbpDikQsIL7hIayc18Jhfocj4VAa7Vs4Su0Qe1x7vqVpho9ABJF/PwpUffIf9XXco
         bmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpvSyTrQTeGTQ+BEWee7Fo66ERqicEZUmwVZjsAxz5Sd8zo0FS9L1OAhegNljt+ha6HGw28u/D2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+A3Avzr9rs0dZCDzuZBTiMZkZlco7kt3psOvsEV74ER8gil3
	ovtVgDYOqOCMF0Z/7gkgzyerAg2sTP/2D4MSDBiN9JI8hrv8MUXx9ghpsWSv9Z8=
X-Google-Smtp-Source: AGHT+IFz4/wMpaCWcpDGZw/e6uCaZaeyezhXZTQfdXVBkzxU2f5cPxItg85GBW91OdibreTQE0mP0A==
X-Received: by 2002:ac2:48ba:0:b0:53d:ab10:234a with SMTP id 2adb3069b0e04-53dc1333888mr741916e87.21.1732101561756;
        Wed, 20 Nov 2024 03:19:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4670e6sm595236e87.159.2024.11.20.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:19:21 -0800 (PST)
Date: Wed, 20 Nov 2024 13:19:18 +0200
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
Message-ID: <iw75ptavkqw3vybfov2f7koz5nh5lfzxcou3wey7rdsqt2gj5n@7luy2kqrzkj5>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
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

Squash into the implementation patch.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -58,6 +58,7 @@ enum adreno_family {
>  #define ADRENO_FEAT_HAS_HW_APRIV		BIT(0)
>  #define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(1)
>  #define ADRENO_FEAT_PREEMPTION			BIT(2)
> +#define ADRENO_FEAT_GMU_BW_VOTE			BIT(3)
>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

