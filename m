Return-Path: <linux-pm+bounces-20578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFEA1403D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EA13ABA79
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99022F847;
	Thu, 16 Jan 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdeE0d38"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CA22B8B3
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047130; cv=none; b=VCZZCu7JTTm/up1roR99WGawNF5XkQRFI9aEQFjVUX0BwGOTFxLL43paN9aYJz3vm80mHqFBo6O3sw3bWygutgWOaQw+47TybByCWrv05/3uoM/QLk+ck6c91nQlfht6ypxT7Yj3yketUqIlHFJ62BPwUS5IdPVl9PPldcRY4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047130; c=relaxed/simple;
	bh=fM5I9GHoHMCA0Lg4ON7OCXeTs1Wova5Z+8bR/0rTTQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASDGXcnJBWhbLNwvOR0sjcsIF/v1U1dMCp5g1tzT2M/smirKq8eIB+RbcXzMz8TJQAQYV2CPmCY0+ALmV3UYtbaXiDZ0/2RITZtoDQAijMM4O3m2E1KcLuKZYCcQHsMtq9glfJj6vLLwlm6Nu+pv8yPUFb6WEzh9+kV9dLJEFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdeE0d38; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa689a37dd4so247991466b.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 09:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047126; x=1737651926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtqkGBz5EldVcum4M1/PkK69H6/PIvSUrlZUqRXKsUI=;
        b=CdeE0d386JNYN7wRlqYQ80JsxGvM1ocPdcd8PfXO20g2sjMWek1QtNACM9yDZ3mDKM
         N0X44TRO8a2mIZAsbiyRyJm8HcIb3aW1WbqdWy9GUwUBeHb2du6tvlUek4QsmFUIeaqW
         caWVpzQtbkSpU4K3nuDp7W5H5CgfzZoeUBxyK7iXielJm+vHXpaP+gcoKepX9ziNU5cL
         MmIOjOyI6z+Tlk0vHQTWyO6mdJhcygU9FxmsI+EYZUl9eaL0/jr+Lq0eYblN46flsNpx
         F2zfCzO9iLPVawSOE+2OSKHIzK+zGXtSWuf/MuxLzfRgRNMKC+hBt+CwtQwAzS4DlZcB
         UIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047126; x=1737651926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtqkGBz5EldVcum4M1/PkK69H6/PIvSUrlZUqRXKsUI=;
        b=gySJyQ11YBptE14O9aKmbiMUb3tLcGgm34EV8hOQI8zeQEckg4kg5jn12+Dmvl5Wju
         3zCBV3sv3mVPXA6Ynn4TcWiaHI80GDEkRqeyNHA7X6jsFMyplr1R/3srFtiBpN/4Jz/Q
         LvEmHGm++/rQAJVefbGfKmw19e3rqfgmU1Z6jjylsVCzWZPkriCdc4N2iehcjOizEh4g
         916Iz38tZS0RgGYt1tiCPu0/0/jRjjIFRnR09h8SmJaCG3odG/w9rZKbIfeDiLtmKkMS
         uu0SSK5TN0Mp85zLRiucv6JTUHcgdOhRfggwxHXLoPY+bDkrW9FXKIq3HQ9UnSxy921+
         Tcdg==
X-Forwarded-Encrypted: i=1; AJvYcCW1lkgulRN9JCakS4toAOGjZWXyOHIIIRrW0fjKRrNRhX6gpRlyy65zi5SnOOv5wIlb5aHGxqujjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7bsVArcRl9lFdWxqD1uwGkvzf5adteR4QHRTx7s1Tb9kmV0A
	GG9YPjVbMNu20p6M+E6asaV9X+9gLQF+hGH6mHOJT+YPdydJ3JHKd+VeDZPdYGc5QD2c6Lb7XWo
	G
X-Gm-Gg: ASbGncuO2F6PnjxqLuqhym4XRBJ/DV2M5FYEPxutuH5EMkPU9H9hTZYCDsgXES+86Cj
	blZuQPeO43H2vCfVVSvZ+mpSA5DAUJICHLRMrQYsiLUf0eyAhN7XjKrGYoUXcGbevQQS4okA6Q/
	Be1SubzB4Ze6rIVv7NU7r+54vCtTMFN68z2eX3LVARwHqZdRt3k2+7PlXrc8ZGWzkwVeari0ONa
	qxTqXewEZB9GCoqR/yBkQXoiopyIlLQgg8gmkjUSnA/V8zg34MTSfSk7lH/hYKvQkgb
X-Google-Smtp-Source: AGHT+IGQwH9VK+ITSXPqiXT+6WmJreamVlwpYOx5oDkYfmjm8Bdo+i6oCALmzIKHRXzb/M/vletJrg==
X-Received: by 2002:a17:907:3d89:b0:aac:1ff1:d33d with SMTP id a640c23a62f3a-ab2ab740dd9mr3087672666b.30.1737047125884;
        Thu, 16 Jan 2025 09:05:25 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:d082:eaaf:227f:16cd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670ddesm195646a12.21.2025.01.16.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:05:25 -0800 (PST)
Date: Thu, 16 Jan 2025 18:05:19 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add BWMONs
Message-ID: <Z4k8T31cw_CxHFLC@linaro.org>
References: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
 <20250113-sm8750_bwmon_master-v1-2-f082da3a3308@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-sm8750_bwmon_master-v1-2-f082da3a3308@quicinc.com>

On Mon, Jan 13, 2025 at 01:08:18PM -0800, Melody Olvera wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> 
> Add the CPU BWMONs for SM8750 SoCs.
> 
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..09fe3149da1926b74a98280fe209ae7f423db864 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -2802,6 +2802,80 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
>  			};
>  		};
>  
> +		/* cluster0 */
> +		pmu@240b3400 {
> +			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
> +			reg = <0x0 0x240b3400 0x0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;

The start of the interconnect path is QCOM_ICC_TAG_ACTIVE_ONLY, but the
destination is QCOM_ICC_TAG_ALWAYS? This is strange. Interconnect used
by the CPU should be QCOM_ICC_TAG_ACTIVE_ONLY.

Stephan

