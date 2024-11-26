Return-Path: <linux-pm+bounces-18126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF619D96F7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009A0283CC0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA91D0F46;
	Tue, 26 Nov 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2rmipEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D61CD219
	for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622789; cv=none; b=IO5spbgY4grSikYDrrBu4EfHEn3NL6HfIIxUVUw0oU9aLXSPg3RRTmbT575SJoMF6ay0cbZBW3lse8MBg8KrOLJGFEpRBflAVid/gA4Rsre/xYn4Xmsv7+B+h7kJIls3WvntuA74nGlHUWAsbtx3Q+SQUFC/EErFLsh2hDwMZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622789; c=relaxed/simple;
	bh=aBSMl3iGqThIGaN66zqIdpUQTca2RSFo61QoNLW+2/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZgVHcwrklcRJNkNVVGG8m365NY3nYzZnzEQmo7S9abRrah3zvxZgtO3i3yUtx8dCIzriJtYMssjUD+XmPHGavYcQ8txd+8CxvUDoHxVocULIep9zQJqm/r2Kf04Rbwmlu4STN+z9S2KNPuqwiqWufzuVO4TdBfHvvYqs6kOYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2rmipEs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso54009621fa.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732622784; x=1733227584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24+yU80mKSXh87Yxf0+WEn3/JZAgNat7qgThUG2HLHk=;
        b=v2rmipEsioRpnft20Y5Iz7j4C45+3zZDFyIs/+rMw1JzOQupWIQHL6QCg4DtnmUh3U
         ShCLD6x7JrZAJdhxAoD9EXqocFRYMkmcluwbrYURog7xbL8DQU6CiiCiiyD86lOAIeBQ
         EXdq2L9++Brjf43mLMD2/KyOBhvHJrbJH6she9sE3+mQqH8/XJ7IPuMtpfVoAaFsCwD4
         McsDdYDtr5+nfKkpIXAwRMEpDj8qVZI9mcLqNMGc+fbBl9NljjmZXdSzUUW15iJk0Rb8
         XmxgBDsUTDvir4hDDGvoexHAv1jXobJys1DrAOOWw4tJRDEz/tEC9dcEeYNJzSkxs3QG
         b69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732622784; x=1733227584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24+yU80mKSXh87Yxf0+WEn3/JZAgNat7qgThUG2HLHk=;
        b=Ut8aV8pPPCQup4C257svFiJOOyx7/I7uQwLrqGa/rNI0rl9a1aLD4SVzbXGTcgN+E9
         hpYU6m4NWDWiU/GNYcmgtnvWPtlzkSrl4dFCZH0svWuF+xc7iZwBBllNTadfHKsM8chF
         i5FHrUb6haS0PUwGRjMYh9A2vFRCZSv1Ke9uBElbjD0kiY78LzsWGTxff3Kbx17UFciy
         FFzQkHTVrcvf+YxJvsntNr31ElBbXibIozcb0y8oPsnAyQW3G3BpNydBH5qPvqdWEeWB
         6pIze9el6XpduyA+i2JyF+UQ3Omu21jQD1C1qeIDyVRd6MC9wcLlAfkKNwaM+RoIVThi
         5+AA==
X-Forwarded-Encrypted: i=1; AJvYcCU8a2m8KRRJjCG1ORlB0s4POherLTLrGIaSW3km67g5pfpnCSKXR3r/bF3rPrve0lsg3Yjml8ailw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvAjAEQi9YJEqQvCrq0+ZuUe9+Xuc1QuyHVdqM7Ny/omrwP7I
	9soe78C1nHmPH3Jp5ff+Mdrjvzc0cbk1zSFf1VWE/4fKewXlxJ0njei+P+sGFe0=
X-Gm-Gg: ASbGnctxFb85E1vNV4EInLTC5OMn/t6kxMRtXY9ktCHTd3tQpqBu/MbM7J7J4ox5yBE
	b5iu8Vw38ytr5s8JPqUOk8bS17OTGcS3ZcgjHNk7G4MsKG6cQ/8hIsnK6ifsPAo5STa/eqTgM2j
	bDB9HQ7UqlXh1FXgQpxW4ISoXWU6eOZs5GJ2S6PuUyC62/zLfk84NjqlurpTwK++E7qw9DvsfVc
	jD/p3F9XJVq2hyyC5Vcvp5YV7EUX7DSektqw06W4HatRUlYaPlN4kOjhZjoAVRZ5ycm8qlVwReE
	o6dUv3/Zo+EmXBQbuqaBJ6OJ2Ggjgw==
X-Google-Smtp-Source: AGHT+IFsGQmOebH7tN67AoV1IxaFR1B1MXlotxDp/bRA7hKzT6XbBkXI8ArKgYdjdZCKUAoytEK3JA==
X-Received: by 2002:a2e:a5c1:0:b0:2ff:552c:290b with SMTP id 38308e7fff4ca-2ffa711b581mr69039891fa.10.1732622784527;
        Tue, 26 Nov 2024 04:06:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d1693bsm18921321fa.14.2024.11.26.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:06:23 -0800 (PST)
Date: Tue, 26 Nov 2024 14:06:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v9 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <n325yyrj5le46bockmua5iebbxgyqe5vet5navn7gnmets4lle@ak6kgoaer46r>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-4-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125050728.3699241-4-quic_mmanikan@quicinc.com>

On Mon, Nov 25, 2024 at 10:37:24AM +0530, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> SoCs without RPM need to enable sensors and calibrate them from the kernel.
> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
> Therefore, add a new calibration function for V2, as the tsens.c calib
> function only supports V1. Also add new feature_config, ops and data for
> IPQ5332, IPQ5424.
> 
> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
> is used to enable the relevant sensors.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V9:
> 	- Update variable declaration order in tsens_v2_calibrate_sensor()
> 	- Replace tab with space during the 'val' computation in the
> 	  tsens_v2_calibrate_sensor()
> 	- Update 'RSEULT_FORMAT_TEMP' to 'RESULT_FORMAT_TEMP'
> 
>  drivers/thermal/qcom/tsens-v2.c | 178 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |   8 +-
>  drivers/thermal/qcom/tsens.h    |   4 +-
>  3 files changed, 188 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

