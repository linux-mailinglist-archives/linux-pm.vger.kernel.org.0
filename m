Return-Path: <linux-pm+bounces-16399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18729AEB06
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD131F21594
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250F1EF096;
	Thu, 24 Oct 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNnfcoFH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050121D63F3
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784950; cv=none; b=IQr0JpVsNilM285Kn6WH9VZvRZxU5ja3ajb0vvLt4mNdR73WX3XNRHlCIunt8q1rmVcUzhRnmDhU30x1JpITLz3uJVYJq34klZCMy6SX2LqLbSE8AoDAMaTk7HBwAbiGmsyjASAM0mCk1yZcO7dlhlv0A6b6bHRvZsVNICOJGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784950; c=relaxed/simple;
	bh=vgVvpewAMbmcyjF0eSzY8JeXopWO++3oaFfos5J5nXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjBHgn64lhoRlW2sdAm3pnirpk2ugPWWuiNDB8nYe0eD1LZvmi77AGD7cL2+uBkTPcEHcpyFwRwURw7yHS1h9gCS1vZG1Skak+PAOijPE8/2oqduy25W1nhlqXBOQkgOK0Z7hCeUQ4ekHKQnl8asvi/8mgYjZGDajHPQotptkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNnfcoFH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so10751931fa.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729784946; x=1730389746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=296p0H1Vg2Rj5TTzmKs46/UNrkxr+6q9tiB7yK0RNAQ=;
        b=DNnfcoFHkStOj5jz86Mq0r64dpJFlhnWeKgpT1QLdSFTgjls+fX8k/R45RX8C//3Eo
         gs65eSjzQ+rvtjGgTGhx6NnDxxlz3SxrEvPZytqpPIeYRXtzCR50JAHPSeHFYtxfKQ6v
         jUHq5B8xooz/UmFJhyM6byRjSQgSuVbSyrjdYN8HVjW/Aaxn+NIrmpYi7DRZOwaQX0b2
         DHfa42mzq+bxLVZYFuSsW3dWzZP8q9gRb0UriQNZ0cOMw75AN4iz1W1GqN4uP/KGwdcO
         mEWKG9Gyvd4JgRZPowjVK8ZFGFF6ZieSPY2Vq1gibQXDxmy7T5DbgU+baZ9mIAI9ewfp
         GtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784946; x=1730389746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=296p0H1Vg2Rj5TTzmKs46/UNrkxr+6q9tiB7yK0RNAQ=;
        b=lhH2fpGbRw1xABNKX0Kg4MAF+yoDYJveejeGa9gc529Dh++2NJWwlYnIUr1eV6n1M2
         0efGI64lHiM+AfS6W0vSkL4mf4Ojz8HlU1QR4whVMsQXJ01krYayj02aSoQYImFkUNSe
         QlMgmEN3n9hEwJUei0NZiZO60Q2ngHyaV1cGe2YKPaAx/lSV3biBW/QT0rDrdq8CmDzK
         mvchnQO46S8Hzok10XDuiG10OoifSjQThJvcpx9kbMzsf6KTZlpDVUPKa3EP79sCBk0X
         2ZYCDJ3fjt8/OIsIqzsDj2ZE2FrKg3CtMNpAiOEZvdsi1SwmjINVlkFzD2pgeN/gMIqd
         4uAw==
X-Forwarded-Encrypted: i=1; AJvYcCVikWXWB2jw5S/WU6e6KDrYStHN8eWo7nZjpnekiwOvP4tyF67VwvVKZqkLMdnDioapx7F+zG+2vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZ36ZsN8dWuPd64pWJIb6zOcAHfH0uo0BQhRwR8Z11TqUyQXB
	0265uvtwDMsZJqg1XMo2FcSGwz2dmpzgFaFzIjppiU9sql+nKCg/Uj9IdsgEqhM=
X-Google-Smtp-Source: AGHT+IHdsryVFnNHDvLRD43FvHMGTM2ITuF16eHf56R4P8i8A4ALesN7EP9WtQa5wv2YRSvHbm32qA==
X-Received: by 2002:a05:6512:6c3:b0:533:46cc:a71e with SMTP id 2adb3069b0e04-53b23e9d2e4mr1860939e87.54.1729784946007;
        Thu, 24 Oct 2024 08:49:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243eb09sm1402372e87.245.2024.10.24.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:49:04 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:49:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: sm8450-hdk: model the PMU of
 the on-board wcn6855
Message-ID: <c3yzrhf5ev5fvu42mr6qe55odha4v6mjzjauskkq2u4rzqd5qm@o7csb6pdhppo>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
 <20241018-sc8280xp-pwrseq-v6-6-8da8310d9564@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-6-8da8310d9564@linaro.org>

On Fri, Oct 18, 2024 at 02:49:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add nodes for the WCN6855 PMU, the WLAN and BT modules and relevant
> regulators and pin functions to fully describe how the wifi is actually
> wired on this platform.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 157 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8450.dtsi    |   2 +-
>  2 files changed, 158 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

