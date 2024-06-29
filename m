Return-Path: <linux-pm+bounces-10239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED991CD39
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EF71F222A5
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4780604;
	Sat, 29 Jun 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBFu7S1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BA7CF18
	for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668184; cv=none; b=G/lmqsgACXuNKU2XalfI1dtu03I3h43vVx7SFKI/hdYdTCmcVbWev3Y5M6S0qg+p5LYbNh3+tL+vpJlBa3W2bEDQv+YXS9SPGfmuloOVA0hJC4ri43FB/uprmY5tXEDmj0T8aE5wrXWtIoC3LsVcIZg8K5j1Cbc+A9iTad9MDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668184; c=relaxed/simple;
	bh=TBujtsgPSMyOfLYZxDA3iP9CsxfxpL2YehAcFvxFxZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y6fnWHLbR6948AYs1K/US2Os088aT7/ei5et1jLKIIWZ18oXFq9dka8cowkw62rNOU/jaiIpewQJXVzmhVs58mRcCW5kfcVuBeIo0eTTPBDFLH0G5UqavW8o2TQk8w2qlq7HTSAAtHOmpD3nLbz+7RZW7gUptslXWTLeaSCquMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBFu7S1r; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso23194991fa.1
        for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719668181; x=1720272981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D38SN9broVRElDVJrNbH9lpxn7RrifUECcswQJGhmS4=;
        b=RBFu7S1rGVA1zR/tHC/+ZGJ/3iEPPWavUXnpDjTV+M8UAwhWbl/M8sGCYYDkHz9rzy
         Ez8uKS1ULDIU/oewcRnvp9fMhDsU0VSx/xwsGB0lL2KqfovW2UEcXua7kyx5JDSgSi3g
         Hy4t6OBnmF76HmJcgsonyF0sFyNGSLBGnxW5h9dBQJG3NAvCfrLiooQXDube9HgcLpOo
         wJkkoirWXR3+BGSEYFByc88PiJB5H/xLCqyW0WYMO4Xj3CmmtIn5qg7XvtLtREN+QRgc
         t+t0PVsRtPCayiAWjg3ivaILYrO8NnSW2GKJoH1WT4F47qeV+RHyCs0LXGJAAriZEk5h
         DaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719668181; x=1720272981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D38SN9broVRElDVJrNbH9lpxn7RrifUECcswQJGhmS4=;
        b=UW/q3eHg/ru+D/p3fBy74ve8wFSr15lluWUkXfm1H46mrWuStwuBF+Vo1zwPCNOq8+
         8S6yKOEtKZkoMJ12Zlhcw1RnaSUrZagiD3LEKMQt4K04wL7ZhN5ckHPMqMUdWXfrM9Ne
         Wm55b/++eZz96/M4p5uglppZa52rSS7vKJ3al3DGNK0OC4O2NpqOi6RArYEBWFFh6I1I
         s6df1g+BCA9OtRd927uF70iD5NRaa22jYGmTrK70mD9m4fkGYQK0P75vwhYsPgc9GoJJ
         mx7+uNOEWiaU8fZ/RTXQPYzKZrAmvNmM8SsQCdrDoNjnmGPoMTIb9z6KOQWGm6oISmjt
         KH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6JbLexuRxs1vXrWW8ukiqcbEE0h+aEnCgypjhp8oNkaDqmke1wr7/g/DrKGgCZ6WhwhB2IROcW4h1jYasdeB4Ddj8IsUouOo=
X-Gm-Message-State: AOJu0YzMSw4rXuu4Q7R1CrL+V96FnoTuJ4zfQh5y6tQ2I8yXnold8z8I
	Sl55acJ1n4gj4hnpk351X/7QNONCUxWlOdxst5jjq6EVklhv4EIJ1AlDVuShQ4I=
X-Google-Smtp-Source: AGHT+IFJB16j6hMGw+LMqnNbELLe+/Lcybj4FJLisCZYX8Q5AVwCXH9TyN/LbqPZoyd4YuHSimyCtg==
X-Received: by 2002:a05:651c:221a:b0:2ec:4f0c:36f9 with SMTP id 38308e7fff4ca-2ee5e6f628fmr12224891fa.36.1719668179689;
        Sat, 29 Jun 2024 06:36:19 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1d201sm162949566b.9.2024.06.29.06.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 06:36:19 -0700 (PDT)
Message-ID: <53356c90-ec68-46fe-8e0b-0bcead54c39f@linaro.org>
Date: Sat, 29 Jun 2024 15:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, bryan.odonoghue@linaro.org
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
 <20240430064214.2030013-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240430064214.2030013-6-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.04.2024 8:42 AM, Varadarajan Narayanan wrote:
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

