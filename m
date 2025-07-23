Return-Path: <linux-pm+bounces-31346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8AB0F732
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BFAC1062
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFA81FF1A0;
	Wed, 23 Jul 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lei4AiVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6F1F8AD3
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284979; cv=none; b=Ml30MLGoJy6TQrM4ygchs6Ox2zwC/ZMoRcGDEhZd9ubDcA2gFVnfr1rZAR+Uj1JpHitsDAmdQ6VPyFHwY3TtdStY70BUCbzAZCVUreckgewKhjxLuQwCKqdh3rHjuezmtnsnAT1uju+MRrtHvYRLMVUiIBC7CjNYesA/HKzrkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284979; c=relaxed/simple;
	bh=VA9c0QPMO5+Bov+cQomqLQw1whJoVSRf3QyImu7EoAg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GTyJM6YnzH1xuBy5y18h70HfdBSNMgZ4S0zShLkIWB2SWTo8v2OBQPsg1kEjmKMIJLHvRc9aGNczehcEYNMF36brfaMI0fxEoiWhPZG014L5mTSHgh1FA3LQJOxAr0nP+L+KFNqkDTnP6fpObwwGE01SXeBhaf6L/OP+PXIdhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lei4AiVg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45619d70c72so9999455e9.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753284976; x=1753889776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yopYTcaLHy/YngxUjGRVUYbmllYbCh12wVB+pNQbzC0=;
        b=lei4AiVgu1fISmd3tdJ1VZHkuQt/FJy6bpGQ+7cBfbD9IbsPjwsLT66kDkDpx71a+V
         tPYouNvAfeMQa3PwzDOisS1but6Zw9CxcNZVHsW5zQ060WTPj9zhmdVk2gXho80iUrtL
         MzPAOnv25PQposp+76XLEF5IgQ2K5derB5yfOHR/f5IX+NDG2l+TH4jSuO8Rau4RB3Tc
         W0ZWkhSRz4pHbPeajmO3V3KuUQpWdqRmohdQ/LN6xtiQKN4WyKy1nHxJvvi7qeRGMt65
         P6FMO29heFkE5R4aTZMKVvMoP7UQBPiJQTZHWhEd5ihxn8ZA/SFkIyUwYw2oH3I6BAdb
         0KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753284976; x=1753889776;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yopYTcaLHy/YngxUjGRVUYbmllYbCh12wVB+pNQbzC0=;
        b=bZR6pM7Y9vmHjMO/3tM3tFI1dN42np5IfFRlmh8WVjRAtbg35WOI0ruTjLF2k89v3W
         tvhcCSrkCO4Jaub6xTCXzNOgik/Mc/pLJ0+Yo8bGbLxSPPCxcMkWbM23n9E9fsF29fig
         BRINAnwD6z3Y37fkb0MQ1TX0mTJcOMm38HtetXF0/QpXm1ew6N5rDjlcjnqWG+ivH8pZ
         Y1EjgdNazVZ+Tgh7neTKO/NaYOj+n1fdvEo4vdmmu9tWRtTW+O+vbEssxTaW+e0J0IWU
         x00Zpy7I9RVgt/mB1N9crawWg9XkVhgynCwWlGvGN1Cr5YgcIxdJB2plp0elvKn3ev0Z
         15Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Xe9kZSb7gzGi1YAnfJJxnoUB40gX+eAQdzv4wxR6CY1CPQezfUGGkdWXHahw44MP89aAeTLnmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Y8ndw+IZs8CbNnAaPG0fe5cavWuDWpxriV93RjBOd4ANszPj
	rRSG4IN+l3vU5Z/+XnUWA4Pcz/Ew+P4rwUcFPJ/YgmIBbuQsDz1BTb9QJwHHfMuVaTo=
X-Gm-Gg: ASbGncsVlQdyopNFL+HHpzVG+Pe667WXZdNlV24XFFQ1ekJK+98GoiQvj2u1Yi0bj+Z
	7QrZbtj9Y8Lr+a/IeqbtEmj4zAFECCyU6PoytkTmus+B705D2unV5cJFPl5O5IdEojqZZgRub/Y
	cKDpC/jSJV2k2pXlJhoffEEMu6/Al/80+vCAxBl1PU0292WpDqOT2QSciONt7639Q/gAPff7zv+
	EFGfqCxr0dtchD7yy9uBihYFy8CDt35MkL0j2t2QtyS9Huzqk3Dy1EmlBwgALo9V5LNeIyjNy0Z
	/YRTDrljZ9csdra7HiB+gK3EXNmqE4x5B1hgB/CvPFCWuQb3AeQBtw2zQF7hI4BwJymsyPrgI2r
	Qxs3YHC90v3fIam8NzBRBQFP6CU/Yb2B/hBZpRUHeuRPKNy4WWSYuZ12RNTQrk8Y/BAaN2gdWgg
	lSz2+zWjFIrGtW
X-Google-Smtp-Source: AGHT+IE36FCAwkzfiHLT8YUTKB5dl8mhn5lwwrUiNUjYfXCamvnt7XB94dMS1C8m5vdXXhKPLuuwTA==
X-Received: by 2002:a05:600c:4fc9:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45868b23d24mr31817135e9.7.1753284975917;
        Wed, 23 Jul 2025 08:36:15 -0700 (PDT)
Received: from ?IPV6:2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1? ([2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918094csm26728745e9.2.2025.07.23.08.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:36:15 -0700 (PDT)
Message-ID: <268811ba-03c5-4957-b073-1dfbad77747b@linaro.org>
Date: Wed, 23 Jul 2025 17:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

<snip>
> 
>> +	pmu-a520 {
>> +		compatible = "arm,cortex-a520-pmu";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	pmu-a720 {
>> +		compatible = "arm,cortex-a720-pmu";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +	};
> 
> See:
> 
> 9ce52e908bd5 ("arm64: dts: qcom: sm8650: switch to interrupt-cells 4 to add PPI partitions")
> 2c06e0797c32 ("arm64: dts: qcom: sm8650: add PPI interrupt partitions for the ARM PMUs")
> 

Yeah switch to 4 cells now, so you can properly route the PMU PPI interrupt to the right core.

New SoCs DTs should have 4 interrupts-cells from now, I'll migrate sm8550 shortly.

Neil


