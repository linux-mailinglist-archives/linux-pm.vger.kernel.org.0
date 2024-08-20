Return-Path: <linux-pm+bounces-12501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68050957A96
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 02:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD311C2355F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D098A94F;
	Tue, 20 Aug 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmEVsdRH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA3A92D;
	Tue, 20 Aug 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114930; cv=none; b=rocjG5TsGhH0/KHC4CS0br7hyTcEcOdyZLipb9c9O8nxag+cV6CL/u1x2GuaxkPaLYfvZZ5YSCvf6c/NAV2t07oxBPs5hW02jkQJO/hFeqWrE89kvnaSOhL/fYm8l5l5UYBnhvIjQLGBi7BlW/WFSQjd1vQhtgVVlyUKsLRB16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114930; c=relaxed/simple;
	bh=S1yD5jjtloQRCRz1+d0jr0pqgFXrBjkSHQAMv9YOMiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smPT4vgowuXDwaUfrzw2PF+X2g104MEo/fAbo1beKb8THsZsqwC1byCu/k3n+Fg+c8XWRRRLKboplI4BMxcQ0uwUXEHiiEDuAawbsGQVzl0uIR+Z0qMV7p4DSXWr3q18atwerKJg2Bs5xNpdmO/yIztavJJSCLvoMzB9zDJslsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmEVsdRH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so524641966b.3;
        Mon, 19 Aug 2024 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724114927; x=1724719727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aak847kfGgqL39Kc/QBpkJh3q9r3EfbJoDakBsppDnM=;
        b=KmEVsdRHGlghGxICz21Zjrwi4eq1M80N2cOEcxNYV5G67bK8vifjZpJ4Ol23IhvMko
         LoQQXnvl28CrnauUHyxv382nlW1m5FsTJCahU/+W1w87FxX319r6WaHrrlB0cP33it6N
         hhFtfUD/Rcrkov/A9nuMUwTEPfp0VVd+nOzXeJERhIlM8bHwf0BX1kvbC5quM1yTbXfm
         dSj7jS5yfWAiw9nKP9e5eQBDKmMl6xG5+48AKCUFvm3TXn8s3ajWXTAnMQSOkhPnvolE
         eXFVyIRnaBpjJq3HTBNtQE4LRz6k+5XJWc7wBAnElDwTyDm+/QLLe2qcCC0CBHE3sIhH
         bbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114927; x=1724719727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aak847kfGgqL39Kc/QBpkJh3q9r3EfbJoDakBsppDnM=;
        b=lOziogqXz05WQHnSKXkH/6qEeFRTUNPmVQduSJ12WKfrpR/BrUamwYzRsQDLoIFXHP
         UzYKb3mciqXfifQuLr2zLH7wReExdrWWlBEdvllLSYgnHe9K7R0HbBt6RdDAV/lHGpDe
         q+9ECFq7hhoFpjp9Y9ozSk0+YN9RzEKXsPFYCv4ijuyuQtmEESXVHm1Jh0UjM5fxfnhV
         nhUh00tOKI15roCJjR9/X3hfCtdNYmcwMkgvu/Ahjh+YYxy9LbT5h9xiZEV0if7sRo6T
         laC7jV0zsXLdZpEF1ihzuc2MkpOz7ZKNZn5NOdK516wAbMs0ZgC8QCimDktdkYT8dX5G
         WKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUHBcmlXikwcbfTq4Bzhhh5+52FuISesBbni2T06uEg5KhegpxA0iSaiZ9MzYRIWo4HDR3znVJnhnucO5V9@vger.kernel.org, AJvYcCUnkpOM8LNxcbkYuQeleySdGv8swvW6BBO/QIkAWVne63Elp9DYEeOJrWO/cQwar90fb99ALQ3xbf73hlP0@vger.kernel.org, AJvYcCUsygNu3QTAXLzCXXnUgHsj8oMnCKDV+n6XQu3WnMtB/ft5RgwgMtuNQcR4fEFUaEAVrDjIyQRP@vger.kernel.org, AJvYcCW4qS5PU+OtM4zE94GG6N4jgZXsRBXP/89ViXuvePsyBx0AIeV464WQ+vwSkffurnZrHnmfzSCLmRMKTF1VEKab@vger.kernel.org, AJvYcCXYwnUyOeYRf4+KkCbAq2xJeIG8cKJ8kL8SjD2SBy8FFXwInT3t2dPdSqeJpmbm1VLEWzM+fDb6Ixg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnC0db6pLpcZLJs6s9i6WvwOo9//gQ0PHLiwWbtkBRxGiTuQ0
	4XwWRs8xYrIcWidy75dCC5Zm5Oo301UNVa8xc8SNjcJMaPvt5pGA
X-Google-Smtp-Source: AGHT+IEUbNzyKkL8AD794LCfaPtnP6kDKp9OUrsiw25fkzayVlzgeUWcLK6D0mUSHIMPsExRLInG/g==
X-Received: by 2002:a17:907:f169:b0:a7a:acae:3420 with SMTP id a640c23a62f3a-a8392a11c05mr869163566b.49.1724114926168;
        Mon, 19 Aug 2024 17:48:46 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344b5sm696714266b.118.2024.08.19.17.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 17:48:45 -0700 (PDT)
Message-ID: <90a95443-65c5-44e8-8737-26145cda1e35@gmail.com>
Date: Tue, 20 Aug 2024 02:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
To: Danila Tikhonov <danila@jiaxyga.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
 quic_rjendra@quicinc.com, davidwronek@gmail.com, neil.armstrong@linaro.org,
 heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
 linus.walleij@linaro.org, lpieralisi@kernel.org,
 dmitry.baryshkov@linaro.org, fekz115@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-9-danila@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20240808184048.63030-9-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8.08.2024 8:40 PM, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
> is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).
> 
> It uses the Kryo670.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
> new file mode 100644
> index 000000000000..5b4574484412
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Eugene Lepshy <fekz115@gmail.com>
> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
> + */
> +
> +#include "sc7280.dtsi"
> +
> +/* SM7325 uses Kryo 670 */
> +&CPU0 { compatible = "qcom,kryo670"; };
> +&CPU1 { compatible = "qcom,kryo670"; };
> +&CPU2 { compatible = "qcom,kryo670"; };
> +&CPU3 { compatible = "qcom,kryo670"; };
> +&CPU4 { compatible = "qcom,kryo670"; };
> +&CPU5 { compatible = "qcom,kryo670"; };
> +&CPU6 { compatible = "qcom,kryo670"; };
> +&CPU7 { compatible = "qcom,kryo670"; };

This is a meaningless marketing name. As you mentioned in your
reply, cpu0-3 and cpu4-7 are wholly different (maybe cpu7 even
has a different MIDR part num?), we should do something about it :/

Please post the output of `dmesg | grep "Booted secondary processor"`

Konrad

