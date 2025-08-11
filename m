Return-Path: <linux-pm+bounces-32147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE577B2032C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019863A7587
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FC2DCF41;
	Mon, 11 Aug 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnXipBWe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737A2D879E
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904127; cv=none; b=BfSPeJSRqwifxxAI0Jkk3zASsLCq63gaLAbLNdksTIRETKkEiQaTwyTcaomz20TJGiCAbKAD1QWTyJvI3g6Dxi8LDMRZeGTPN6lLfz4tmcXnDfbzhpGgDAvxMsI2L6ZymSSfRa7HMU3x12q6GW4SCiuH5+hg7tTYcYnFy8um3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904127; c=relaxed/simple;
	bh=K/zPVqxGg7tPN+JbH7RDbuwnwSJKsZfgYcJ/y4119IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d54BXbaPqfQhwXQU5ND0f6DkzvMppGKU3ecwVY2jWv083/Yqnu1fJGYdW1V3VsQHrKFZrDraWYPnQKOcRT6mgW5iEma7loSX40QdDHlOz380+jFD6/M4igKGnSQZcjTCSoWeR7my3BR8ifIgTMAFNfimtxk33xaFlcUkf+ApZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnXipBWe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bde897110so3192201b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904125; x=1755508925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n44ROEDa3iRmjIj2E/S0tuIP2QaLePXT+HAKtrIXfuc=;
        b=PnXipBWeA2oYugnfcYMhifxpADIJqd+BzdtR/6Btms/qY7WjTCaCaTLicn36cZCZtp
         SL6URDZief23E7YUR2GB9QKopMU7aWlVEWBTPLRVDszIDU04d90n0khK4r3RysZWVTdv
         H2CrOc2bByNGC7n8+yVXXoemyInOdZCrLLzUbvOIse1HYoo7tuM/MQbhg4fY2AM1ZLTU
         c956F3p8roLky8nVAD6fRssdntkdUilIWe6SJdiI0xPJGXFr0I1X/Twi7B+vT2y9tpdE
         8Dvcl3sFEQur2SELjc8TBmyoY7NaCN1B+yBYuEWtZ84oCSW0PgNsMTxsknebkW+H0Nyt
         OcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904125; x=1755508925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n44ROEDa3iRmjIj2E/S0tuIP2QaLePXT+HAKtrIXfuc=;
        b=N8FWFbaMhpDVac1fKkV57uxaQwwhswmlf15jRrM1tkqzzBE17VE1XRwc94/jC5Hn4z
         JhgYNB2Nx9vpQbOVvtcvesYO802YAVbW3BG5MmYDtq2l1G/VzoZU/Kc520aw0ARV3dY9
         cTx9vGRvpnPxbL2/+UxrfESd0nnSFmH04TJFgF6Q9cdUFWh3ooRnFeZfmFsx6VBzzMkx
         fzPnXgMNwt1C83axG+iy9HyOEGQjtrmD0VyywbsUNfj+CdJAWMOlSsWkAi5R6KZAq2dW
         UxfpF4ETsN4+cE2fMjT1wXClMpYfy/Ij9FUQW0jKAW4xouzPVs6jDXyTyMm0yWOSGi+j
         7/1g==
X-Forwarded-Encrypted: i=1; AJvYcCXsx5PjXcUX5WusGEV++AUzpdYDufk3p0heUsnat6VPtfSfWNuwbgx8txwNi/ZlNWWXF7cDCBqCsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZPqQicUXl1CZA9PROP/lWl4PIxFJQ0poa+On512a3Hp5SgZS
	+dpuVVAcLWVAGw+4F/XzfrQN0nQuR+4as4ZbgiobG5KmAgr+yvf578vpSSVWj0L/5dg=
X-Gm-Gg: ASbGnctwiwUTwL3AUwPxQNk//0iHEx+PwaTc1FiAG2psAgXiuNf3jQecZjJj0JSFpoN
	ScWxAX8edQ/XsT7FJPkGho4FiwGqn7y/nzOaZi6y071ljNoFPv4StoYPkKdR0lZCM1EHL8ykrwg
	gczNdcaAOZdPdW7OfmK/gefxBNgu5u73Cz/DzeIxwcQpftwg/5z+KtUh3zf7io9yeM1EHvh0IPs
	3/8cW7a6te/z3oBDCSvezjrExnZSWL05B+NTbiFm2wkCuf1Kznhs9ym7tpahZkAJAgSQIqGG9Pi
	YcnF0m13askkQQcKXM5Wh+tBxq/VE0aoDlKY+MxCpNTGeAJ8xxwHNGQXNpsRVGK5polJecki7CK
	xdY2I4YQNJ8tnv/KaW9Ct5ENi
X-Google-Smtp-Source: AGHT+IEY0nvgGQRFqL9yezJOvWADh1/cHUUmKJ7QswLrUeIJdU75UuZ8LO0U21sJdWveXkp3OX6rWA==
X-Received: by 2002:a05:6a21:32a3:b0:23d:de52:a5f0 with SMTP id adf61e73a8af0-24055204322mr19749640637.42.1754904125252;
        Mon, 11 Aug 2025 02:22:05 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f5035sm20840763a12.39.2025.08.11.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:22:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:52:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250811092202.auarwnyoagebcw3o@vireshk-i7>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811090954.2854440-4-quic_varada@quicinc.com>

On 11-08-25, 14:39, Varadarajan Narayanan wrote:
> From: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> IPQ5424 have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Added support for ipq5424 on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
> 
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> [ Changed '!=' based check to '==' based check ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Add 'Acked-by: Viresh Kumar'
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)

You should have dropped this one now, as I already applied the
previous version.

-- 
viresh

