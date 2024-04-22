Return-Path: <linux-pm+bounces-6840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8B8AD89F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A791F21223
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC11C0DC2;
	Mon, 22 Apr 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMaRmnZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823211BF6C4
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826853; cv=none; b=puNNPUePYdDujvqCaVskUCrJ+Xfk2DpvSEJH5PqfRv+4NiJzzNiKEDMxera5nMvt6+2iutG9YBV6SPl7bFuUAf8Q0RVM369+HoEabF4Kb01d0+ykZ9SAWTn8bFTwBFu2p/vE9Gxw5efa7sDcmkBGVA0BbyB7KmncWRtQvTdK4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826853; c=relaxed/simple;
	bh=/jci29mGzzIavqEL2qT00cRZYvwPd29ad4CaRDp8/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gliTJMXRpXeXEtXo9UdAt8M3cyYUfvOWW7OGpEBHYDwTNE839UHIx67f9sU8A2eYMabRMIXUoeaxLhF0t0DhrVIcg5BuyI14UakuyDtCMHvq9jPvIWey1vENAALYTDstBoqAxhEzKRfHV3aJWw6oZyeeCrptJHivwxS8hu3/YiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMaRmnZX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518f8a69f82so6018704e87.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713826850; x=1714431650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kk8RZ3kIPMume4l3zZttutOgAKIxylCidZY2eGmr83I=;
        b=QMaRmnZXt3PXtMtQbha0JxDPw5DCEdF7dazfdKvpRdh/098lw1OODIEPMIBqBkJgKI
         ViV6dNEPJ8i43Y8WXXhDGJN3yjMbdyljRD1HKpjmr/v/DS7cPL8pyTTYeDTonLN3dq2J
         iC0tmz8HApS4FJpvniTgH9UcfJ14wUc/9lnNRU4twe05eZeZdJEMCknmzmlTQzFiv1s2
         T5JNkR3SfZWjCM5QHA3Ndk9XOJGETWxDbFfN3rstOViq8Akbjr1o8khQyQyGHZtcYQEF
         ahNBoQ4eheCQt4qvTzkXov1vTil/ka0dDGquS09oOTzrdWcq4HNcrIEcmjEs5crjkNrU
         VzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826850; x=1714431650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk8RZ3kIPMume4l3zZttutOgAKIxylCidZY2eGmr83I=;
        b=rK94fQmHdLt4DqS8eT44c2JGanH5KKB8QAAmCLj1MediQ0/+b/+5vtmh0SRUU4r8dY
         4svN5ICKAYPZErLxzrIw0Wddulinhsf49N/dZyQ4Wq+V9ikSejTZe0ujzKGTZNSLSGMh
         hm0/0S2JmJ5Zf4PQ14fmQb+0phE6WBUM71RAQhyaJqoyUR3R+hUR/nUT8W+ZEU5eiZpc
         B8ai/EYJ2c3nUS89D5zXnJq2Y4jdWHCLRUU+WDddIo+EOuEAk/RkHER+2+EnxwFK1Q57
         uNOBHrOJfMH5Jv1oQV+CbzZbtyXZ7BSfCj1/D2Cp6LChec8ITTDwuYOmH7nIJEPeIDCl
         xGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUoZXiGeLKWylLEMbxU68N6f0Org3dlIyzFL/noJRwRwcYrjow+KzceWroy7ZRUxfcnfjf+AOosEvoawwDQxBFjH/xZ4qcfPUY=
X-Gm-Message-State: AOJu0Yy8VN4Krvervj0Zh6ajyjDe6YT+vhVd0ZGJsEpa/jhl1xT7DZP+
	bJgQwUXKHCoTh7A5+R2/4y2tzwFZ0Hzr0JryyB3/Zpw39FDcSLQsav3JKHohDN0=
X-Google-Smtp-Source: AGHT+IEQ2a2C6x5MBOQkua4NvRFyZgVGrHQKhZtpBWTuE/jycfIwqTASlvwYmTONiFAlMbc33a9Fsw==
X-Received: by 2002:a05:6512:e83:b0:51b:64c3:8cfa with SMTP id bi3-20020a0565120e8300b0051b64c38cfamr2469243lfb.13.1713826849758;
        Mon, 22 Apr 2024 16:00:49 -0700 (PDT)
Received: from [172.30.204.103] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w11-20020a05651234cb00b00518c057e78csm1830167lfr.159.2024.04.22.16.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:00:49 -0700 (PDT)
Message-ID: <da8fc783-6b2b-495d-ab15-be297b0fa435@linaro.org>
Date: Tue, 23 Apr 2024 01:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240418092305.2337429-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/24 11:23, Varadarajan Narayanan wrote:
> Presently, icc-clk driver autogenerates the master and slave ids.
> However, devices with multiple nodes on the interconnect could
> have other constraints and may not match with the auto generated
> node ids. Hence, allow the driver to provide the preferred master
> and slave ids.
> 
> Also, update clk-cbf-8996 accordingly.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9: squash cbf-msm8996 change into this
> v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate
>      https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
> ---
>   drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
>   drivers/interconnect/icc-clk.c   | 6 +++---
>   include/linux/interconnect-clk.h | 2 ++

How is this going to be merged? :/

icc-next? clk-next?

Konrad

