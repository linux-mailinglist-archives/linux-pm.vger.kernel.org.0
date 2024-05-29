Return-Path: <linux-pm+bounces-8392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DB8D3BC7
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1445AB282D5
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21B1836D9;
	Wed, 29 May 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zz3xb9b+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3A181D1C
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998736; cv=none; b=DFJ5V0wgCXSLH2cE6vcNP0taLP4cie2AbiwkjqRNn7POjnl7yPTeHT+9yuPxUm4K71aLXt9G3YvbHpQQlVsxwsrnVcvkx4Py5AHudnjuwD3JrJATLq1bh5dWYFojX4gJVSqsluIUOTMRAiwI25xOgr7tU70ruJeBG1h3IZ9HkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998736; c=relaxed/simple;
	bh=5EqQiL0r6nrlB8yB3smf+mNsb51Fy6uJGMh8nFFXn3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBYDEK9p5VZ7elJ8l9vJILTdSemTydViqfQMxz9wILeyhDq9POjeZDGXwKKnbYYsR/HYi+QF1FMnamFH1UJkRVdkCcNqoga7Tl8mPTS6f7MhnL7HYy9IBIcfBdPkKpCC+tzwRJ0jxrbbx5o+nexL9k2KbwxG4esY/bf+IofqVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zz3xb9b+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4211249fbafso18941315e9.3
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716998733; x=1717603533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzg/EUp61JlYQ5Fn3RoqiX5YzTeWEt7sibQ+Ig9ys7c=;
        b=zz3xb9b+8hH7dFFsUJuhdXgxwesTvJgzyqx6yn84U6iWHcaJtdB3WDxuPMZojS5UZO
         upI6/oQMfBEi7R/K/c1eCmsQ29GYcswvzB164F6tTOjbtcCCFSNIkPgOrwciuWn7Ays1
         qRThpvEo6KnTrAlt5Jsz9fm8R94VPwkJNfBr97EypnL6nvKZ63s+wFO2NVsElrZ4qFW6
         Mp+K9Ef28LkRJz1lFoNuWvOvY+7i+TMpfCnIMzQFND0obzGVmpdkKckBRWKgPkcLcfG5
         rAubOIc5FIMv9x6DEVf3AfwE0CptqkAmt2VZmQX32LzPcOxehxko/2srlVTR9iVuXviS
         VDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998733; x=1717603533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzg/EUp61JlYQ5Fn3RoqiX5YzTeWEt7sibQ+Ig9ys7c=;
        b=o/uxSpfTI7o0Nk/HCq7346283nEcXnlasQzfQROspf0V965x7oYpYX7byjqNUXzvtA
         0oQS/lccT1mClFe0nW2sr9XVawSO+FE5rof701blY0U75HjBlV07VrZo6AqxPRl/pSdL
         OEYBknfW+VeXR8wyqZNnMEP9aJPha1nfha3MoTj2C1xaQmo5K81gS7Ee7S96096ikmYt
         U4YN4X0so91EqWwebrAZX5ygqtf33NTlzm00pBMWqUPprEXCsd0GmYoCLDG4IH8sueso
         EaXavLBazH5pJexoSxa1VbNUIXoNmn1Kob9iXLZy+Ggigr2ymNLg+6Q/AtTQylTr2gsR
         d4sg==
X-Gm-Message-State: AOJu0Ywr8IM84slbpLCmjFk6R0WB5w+5BEW64O4wcjpZRpU2Y+OT3647
	OqyFRsqieyFPraV9ozMd26zal4P0ee+JqKc+rKRTImlypOl/T8iapMCX+iAAlZk=
X-Google-Smtp-Source: AGHT+IFn5yfhHaTTN+Su9cNWOuzz33Y8aCh2kF8VjN3dvPJFe21uC4x828bSQeCJe0tkWLUWOBFKRA==
X-Received: by 2002:a05:600c:3145:b0:419:f9ae:e50 with SMTP id 5b1f17b1804b1-42108a2145bmr119611935e9.37.1716998732678;
        Wed, 29 May 2024 09:05:32 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccfacsm181684255e9.45.2024.05.29.09.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:05:31 -0700 (PDT)
Message-ID: <6326960a-ba5a-430c-a423-571a0a4a8502@linaro.org>
Date: Wed, 29 May 2024 17:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: sdm845: describe connections of
 USB/DP port
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nikita Travkin <nikita@trvn.ru>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-5-4fa8dfaae7b6@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240528-yoga-ec-driver-v4-5-4fa8dfaae7b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 21:44, Dmitry Baryshkov wrote:
> Describe links between the first USB3 host and the DisplayPort that is
> routed to the same pins.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 53 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 26b1638c76f9..5276ab0433b6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


