Return-Path: <linux-pm+bounces-17810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F39D39C0
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD71F22A0C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF321A08C5;
	Wed, 20 Nov 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qD1ptUYi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C516F907
	for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103063; cv=none; b=C06pjUfOAbEZT/9CrKCpWp3pLrCv1HaFPLzOXfJT7/ZubdonDl8hGxb8Ucch5zPHwWCf3xfVrbipXEGAA4L+26GmIM56Nb+F0cRP+2WmXNE9CBRfmWxfpdMJhGJguCTMjVcZD8NWPUueV2MMJXz2cuH/yrBzKCi8GoO1F1V3FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103063; c=relaxed/simple;
	bh=MBY1tocOleXSubrnmqvjhWAnctlm34fJboe09gcAvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzqslKWzI290iBkiZ6y9suEt5pN0178NFWhnRHJ/TQm1JHorezopQU450Hq4oe0JutECLB8nyc/xbBGqc7YsK0GJcQpqUNIa5AFf3XT5XPVLuS7qY0Czlds8b5ev2cRZLmDeA+T9ypXKinloGTXZQhjKBU5vzQ8JLPyh/4Wt/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qD1ptUYi; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so5076354e87.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103059; x=1732707859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DRvXARQ1UdTvlDiFS+YRmTlgOqmMlEKwZDmn4BjfP0=;
        b=qD1ptUYiHUivPQZ6A7SShnaZZFwfLl1WJuEzAN76hTAEn6Op8yKKTQ8I/XGvCN2Apr
         bcbpWNOi1/sPWALTio/b6m0V6fKxj4btHa3VkoZU1lBGvvy+p8A3YWGOe/u6XDEbiEaa
         +efLHGEt7YjTfbol66haK5LTHh3Uck0OYKwLJ9uuM5Gb4ApfKR4a1AxFWDQKE2Pg66w7
         A/NzmAyYmpgiDXbHt+WFwMGV/6zDwvWqGMZQfDmhhUSSQiQEek6YQbgBnSWPL5QSQFcn
         gxt87gfvCrojtVtHgiJX99ihyCdS/BUsA+ozALim55VQaL4t7+NzBw/D9mUbruvdG1Ew
         9SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103059; x=1732707859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DRvXARQ1UdTvlDiFS+YRmTlgOqmMlEKwZDmn4BjfP0=;
        b=RhvrdFH+Eh2kfyjLk//MlpJc1NXp22SR0mQI6gW3wwdOLtxzKt8VWoYi56qmQYGfot
         MpL7X0wJ8djCd0kueIL1a0rclXyG8AjH8mAYMgIS86PLjAMnEIbMq2rr+TSVEO0Utexg
         HsTS2M102lKhl7qoDEs1vPnPMFPw/D5H3OkUs+bWFat8EKKFcsmpS0SCbrMGc2E+0/fH
         V1A6mw0DR2QR8fLLy+6GBxbwxMLo26QyfAwbNcudCg7KPtcy6vce00HFTR9M8SpDgJD6
         /xgJH7RLf0fYDPASWulfXVS/Jlcn1hEkRjdyo8sd9l4MmIGEVSBQ+V6zTIauHJMwbBT4
         SLQw==
X-Forwarded-Encrypted: i=1; AJvYcCU2NwmBsmjw4gy89IN2JNW4X1Mxl3VgNSNBKh1121ud32ZT/uet8OmxX2aoy+qERf1M8jStsWgC5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfXTz44mlaexQm6q4A2ar3u0MCYScw4+mZ31P+tDEZ3vbrEhg
	Dpi7w6jfnTFfKH6GyX5hho6BA4BCzGogUY6UZFRfG7jmytGHRY6xEwoxyCyB1Jw=
X-Google-Smtp-Source: AGHT+IENehDPBicxK9JfxLgvExZQ3j1PXy75ftMbSZQj8HtpOt2sSHv8gorwetAxqzmU4d1aWMiGlA==
X-Received: by 2002:ac2:4551:0:b0:539:8bc6:694a with SMTP id 2adb3069b0e04-53dc136aa08mr913736e87.43.1732103058604;
        Wed, 20 Nov 2024 03:44:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd47285fsm604802e87.225.2024.11.20.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:44:17 -0800 (PST)
Date: Wed, 20 Nov 2024 13:44:14 +0200
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
Subject: Re: [PATCH v2 07/11] drm/msm: adreno: find bandwidth index of OPP
 and set it along freq index
Message-ID: <xm2pic3yixhlsktaqnux7uvoxbxpvcmkcurylydifbqpx24x4i@lj65uktyscdq>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-7-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-7-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:42PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GMU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, until now we left the OPP
> core scale the OPP bandwidth via the interconnect path.
> 
> In order to enable bandwidth voting via the GPU Management
> Unit (GMU), when an opp is set by devfreq we also look for
> the corresponding bandwidth index in the previously generated
> bw_table and pass this value along the frequency index to the GMU.
> 
> Since we now vote for all resources via the GMU, setting the OPP
> is no more needed, so we can completely skip calling
> dev_pm_opp_set_opp() in this situation.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 +++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

