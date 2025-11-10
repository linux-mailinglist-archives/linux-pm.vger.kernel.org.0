Return-Path: <linux-pm+bounces-37709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698FC460A6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6357C3A572A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14E301010;
	Mon, 10 Nov 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agia5V3S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC427301034
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771631; cv=none; b=GYPfafsxpho8HtoxneDutCgBpiwrrpM9Aql3JfdFgosPZdFmK8jmO7ec9LJPQPn+Q2vPNb9Da/v8T9CGu/VQmAjnAJ4l7sqRgceZdgqSGjgtbJ6f90rcOvE21TAXDVP3GQw9ynPb+Neb4uRuuCfskEfKJ5juqxDbdqvpkYeI5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771631; c=relaxed/simple;
	bh=KWD0dSUvwuItAstvLunIOIEZaKlPBNCzkWHJb6tbpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES30UU2Wqe1PZAybydFeWSdKDZh5IZwWY6JdfQILFi/MR+9ICC9lRgkuTl/eYHHwMZ28+bkqDgD5ty9wkGZVqLG85YWE76cpDRK9D0y5CwA9XFnaim/zFb6O2lqozgfhNOTZOIlKyRK7r25lCzooblOfB3yCdwth34jsRb3zJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agia5V3S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980d9b7df5so9049605ad.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 02:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762771628; x=1763376428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQGzwKFQ+Rtg1mWaUwQhxw/U0dzqmCy2pKOiipYqOes=;
        b=agia5V3S5b6p8rNCtswM2bwpKA2BcIZN3zwGq/H4x9Reiy+69Mrag/JDp8TKRYhX2k
         JXgFq4h90CGcbWwlHOvicKRM4IQwVxLlpF6UIaL5RLSQf0RoH8KPvApcPoQ3gHW1HU6S
         RKUoOJrCH2/iQUIm8yNqen2ZfcHKhVOnj1fWhgUp/sXw4YFPUQ93IUT3WLK5zqNxiAvM
         JWc6kChJfnR82ToN812xj+HuHKuoOl0A8nJEltYzU1hLP+XIJ4x04DyMmNWCEWCUoDWN
         KNh0f8YDC5xz5+xiBclkanJA5vzHjvDCbKG5Yi9CB7kpxI+bhRkFl8UTugirGfReI41l
         WXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771628; x=1763376428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQGzwKFQ+Rtg1mWaUwQhxw/U0dzqmCy2pKOiipYqOes=;
        b=QXiQMxMR+tC/FQOoBZAxgdwYg6RVoRWk5CfingaaFHgh+lzN8XzrrliEhueKm1lGlL
         bQrOXxF/UplCEGNavjdnTiZwXIIAliuNY/TgzovFsGFvQK3Z3CI8qbQst3dn6SYiKtUO
         iwDSKrSjtVMxRSHZQAZzfxLLX1/Z45qbFmffnmZHA+AirBY3eEIBJEE1q1XW1TPgnTl/
         oOLpWhtj78ASAPf7jZxyqIr8iVdwacWO7wVrNomUXkGC7SyfVVGS9RkVQuQ+IT4JkztA
         Y5oNcU7g+Q20334gYXIrrb99FCq4w70//Z0cOCcUdjXT3Lf6BBex22Ygg1lybTU+9Iwh
         vKMA==
X-Forwarded-Encrypted: i=1; AJvYcCWhBWMNgEh/P52JsUVCmj1/iPh9V+QafhVV3TrBTGK0r3ksS3k3AOBltZ12Qe2JN1+R8FRDPgBrVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXB1xwUe1+KDvbQ+zgqGapC3bHzBGH8qBK5Q8YGSRguYUQX7A
	++XFEpFe76pRq6TXvjjJVDc8jIzVBLKwCScXdns6LAlm/wuS/2gHrtptqsRNnfOTUWE=
X-Gm-Gg: ASbGnctyCch7HyRqMlLcdObdMw39QhzYIK9VYwf2hyi9YOGdhrW5iqZ13wv0YMqCcQ8
	E+ikTrEtleYh6ByqHzaniy+YxKio3t/1nOCmJA1bITlPQG9TmQrlIbcZeaPcS0bFC23M/8bUmxF
	E5fmSM/DQjgz3p+CLrZpWm1GuyuZGvBffKfWJYJYhwsdL7Fn4QXfigo9XBmc5IMxWPbzXTR7Vgw
	qmbRplQANbooqUI8+TZC5t+SlYihTnXRbjrsllkmOoyW4Rr+T90Nkt0XyjP4AcUL29gnTX9jXbj
	/MjYNQGMIL6cr6t0hTqbp5GOlkDcniokPPhXtUAxHCbF6d4AXr4e5LfEIYOXyHuedRFqcum6Svp
	Iv1JlwwZusZsHsFGVCOEDtZZDEimgukSci4C8aL0LLoZisx5mnoqEnS6ZbKFdNfhcAqXv5FMYcG
	vHk2wu7HadXY0=
X-Google-Smtp-Source: AGHT+IHg+DThhk+gJUORdYe/ePATJKcs+WA9A2y1rPJPIsw5mDbwrRCWQvQPcr7jYbijEjp+p5km1w==
X-Received: by 2002:a17:902:e888:b0:295:1aa7:edf7 with SMTP id d9443c01a7336-297e56be1c6mr87877225ad.30.1762771627875;
        Mon, 10 Nov 2025 02:47:07 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11235385b3a.34.2025.11.10.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:47:07 -0800 (PST)
Date: Mon, 10 Nov 2025 16:17:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <y4ys4cp42vp3air2lnlbcglfbh42siguh5zpo3hxugqswwzrdy@qz7mrdzzmhnt>
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
 <20251105112136.371376-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105112136.371376-2-ansuelsmth@gmail.com>

On 05-11-25, 12:21, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID (and socinfo can't be used either as it does
> depends on SMEM presence).
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

