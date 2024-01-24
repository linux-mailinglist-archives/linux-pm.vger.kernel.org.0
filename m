Return-Path: <linux-pm+bounces-2690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0A83A9EB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 13:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0431C21001
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258A77644;
	Wed, 24 Jan 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnOffR6i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2F6311E
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099727; cv=none; b=Z7+0YBbu3MMovGaepUtXQqyKmpogKIONetbS9Bz1hGtr/vm0NqcwMxKH2ccZ97tD64E7tSmVEKlhoXRGlkBRpIh0ahYnFwXWuA1o6eO403RVFbBrzaD8qtoIB64saHUM6Ic+wLz2vOiCRYq/GzfUK4m3sORdb6K66g+QY6+9LJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099727; c=relaxed/simple;
	bh=c/wbv776yHXlcIjGaa1CUq07U8UdLr6hbZt1Z8dRt+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJJbItqs7FxI/XRwZPGpuuCUAyFLEZ3jbWTFZc4EWAszS+AfKzyWKuD/nqfNdP7AzgDvI+rhiP7fNarv8/yRg5PtoZFgl1gdtveKbyzjLvpbtYCfhP8fxBTSzaVkS2+HDC6lSjVQwQS2aG/P0meNtWMNr4G+4qSiksIvbatn9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnOffR6i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51013a784easo480144e87.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099723; x=1706704523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJmAdCvO6+tFmNrPTtHuSYeZGmOUYLVSRqizHwM/BN8=;
        b=vnOffR6i0VHWTT9Xi3kz3p5WXGJ5U0oRyGZgqbB6mQ9oZoyzJ5lE5UjjUp2miOK4jU
         Vvjg6jQY0aK56xs/K+mVFBvKE30I29jiEcVZt18VroWqcLbxmbVjF2OE8HJ0HZdr65vN
         6qrL/tURLCX6XpLiVXnAc6zYzf8avBHh19ENKPy05/CO+g7fSlcT2C1wtPoOp3t+GD/T
         vK3IBoJUEZOoYlAjeHEO+7WWK8S1y1JMwwCGKj3Gxz4y4NMTfx/hidWq3gm0giqDxPJo
         py55VGJFPRWm4SyW2Y22nKUkhBVkrHAcfHI2LIsW+QCUfrnm512SWGCmFdQf26PQwprG
         gicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099723; x=1706704523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJmAdCvO6+tFmNrPTtHuSYeZGmOUYLVSRqizHwM/BN8=;
        b=SboRGWp5LcV0LWb5VmUcp78MEbon3op2ODmSqPtZDq4breU89IfJgCiw8YKyMnr0XP
         iCz/zRpAoQK5p2GJihoTI8Xrf66Rme4kJOSWU5gNbT6wteRNNoHXWn63V1LBg2QLJZPL
         l8rEhvNLkIDtqycpF10udvfPXBfBrvhq/lxgTBa5WTtYaZeEF8npI2IJIk1h7kqjaxDO
         UU52hcApoKSuwd6DDPaQgfHMagXSwAvLm4YFyGnmL76Msz5nn9rPidgOH9q7eEc1p2d2
         EFqoEOEiJEbNU27m+op+Gky/gset6IH4uRKQd6bz/B4W/raDCn/wgkEBr5M32rq/AjEH
         iRNg==
X-Gm-Message-State: AOJu0Yx9BaHdyPQPYUUb7UX30NurnOFy/xtRC17sKCvvkIJjshyHvdUt
	XbgwiM0jhiZIUTjdoiu3lfmfxXlhOM/lTfU1GtzyHqU6s6iatOa77P1NQ4weKJU=
X-Google-Smtp-Source: AGHT+IG/RAqUc+nQAB0NUWmj2/eeOO3TTTYg07Lqf04FmywtcbDbjvXf27Zz9Ub6B0SlPtqeFVlS9g==
X-Received: by 2002:ac2:55bb:0:b0:50e:76b8:e754 with SMTP id y27-20020ac255bb000000b0050e76b8e754mr1401740lfg.141.1706099722880;
        Wed, 24 Jan 2024 04:35:22 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p26-20020a19f01a000000b005100ed58b76sm207756lfc.308.2024.01.24.04.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:35:22 -0800 (PST)
Message-ID: <b52017c5-683e-404e-8165-c393f6224095@linaro.org>
Date: Wed, 24 Jan 2024 13:35:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
 <20240123-sa8295p-gpu-v3-6-d5b4474c8f33@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-sa8295p-gpu-v3-6-d5b4474c8f33@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 05:25, Bjorn Andersson wrote:
> From: Bjorn Andersson <andersson@kernel.org>
> 
> The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
> VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
> bus.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Missing submitter signoff, but I'll trust you're the same Bjorn
Andersson!

> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

