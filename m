Return-Path: <linux-pm+bounces-27845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B0AC8A02
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B874A3490
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287E21ABC1;
	Fri, 30 May 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYM3JQng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C021931C
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594134; cv=none; b=nFKOtJ8K+wC/9mUrpWOC1GyOFwlpDQchHTGOEEKAKW2aUuYM5XbO73vu4/GiXMOZ6y67MJ/NWfy41BiuVFO1e2JFzYpyKIWVsOxWkPa7pkcZVaEWogbpTJbpvrzIqtIyzuMNfhWiaHnKEOV1odlT+NdYDhqyS1uiwxrlGWlBC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594134; c=relaxed/simple;
	bh=h33LQrSnZ+i8qVEFwmpF+DBn7mv4bG9TT0CnxcqbDcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbUrAuDRpEBoTrgVJu+gQKAi43YrrUDL90zIUv97tIXsBWfPD04VU3f3kaH3fM0wNfk+Jrh7CDUcVzXvd6B1qJCHA/eF7l32zp1wkcFiass8pAweerkgRgjGoGSvJdCrQVW6cp+0uQbUQsTKpipDTuiNAjJQhOJsEPoMNN6M2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aYM3JQng; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450caff6336so10119175e9.3
        for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748594131; x=1749198931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLQbWS2tM1c5F0xZTSwzJwZIihpwvcGvimBEFrvn6y4=;
        b=aYM3JQng0blGw3SmaQI5JmljMBday+4uJAlvvlTqIlSYT851VrQDqpofaGRYsEmrTk
         92HsXvbpqk5Q/t+TvX1rT5lNNxLwnPPmFIp/BHhDqf1Oi44ZGVaJUXTrTpI/FitO+Qmy
         K1PYALKE1wwn6Gk8bxvCOPxDUEp/fsM2AIOd0rPzbpvvGIetIHA0WMIK/DmLkNTZQCkg
         YyPg30fFCD4ZPA+eSDK2BV0ZopWlDhwohe4FhV7av+AZMq391q2U5+y6b/oqoYqA9Et3
         H/42pOp05GjQ4e9CUixM4tIGuRObzCAuXxnPj7qAQHrLnUTzdnEEUoy2j3qSnXsYMDmG
         7YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748594131; x=1749198931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLQbWS2tM1c5F0xZTSwzJwZIihpwvcGvimBEFrvn6y4=;
        b=srAeS+k0fIx0fPKAvxsw3xqJjW8ZZBQqTA+qg/aM9EjdtBLtnQGl89XidveMJCObqW
         ztpeVn3OGwuVJDXKxm+HYi/nB489D8S9ADe3PPov8k+L9ceiC1JSV9VjzdyuLmTZZ3WT
         +yyYkMAf3aFKtA883U4Mk7CLMbSTpkTyEEtkB1EbBPyvxy9r/tb2UbNX1w8r+4Q5BXKP
         eh3HNKHQO0sNv/xqKlNjm31Z1tzepkUG9dD2GHyAnLO05O/v9Us7luHUWm1HgfHWwKI3
         +MBRJ+Po19cFEuerl50ENND7CY0ZGHFP5VyqB6qvh2oSn0rUu+tUNsizWBvw5ROT3EEb
         rH0A==
X-Forwarded-Encrypted: i=1; AJvYcCV9TW9mwwyvBu3c0njnQdFUcWNOy8Yga/Mn6Ql10r8scAjcl09QxvZkmn1OdHtKK5C558IgopLi5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4Zd9EWKb6I3stX5d1j8B794neE0UZtnoi6k3bIZatP4wcacB
	Z7RCa92Ymlc/8rAskuOuWVnIXoXVUf2dglfYypIgYsugJAMMOIE9qO00OtsOyk4kiR8=
X-Gm-Gg: ASbGncsnpP1QvS6zoU4DJlscRZR1AaKj0oP3Q79EK4ReUFBG9qwsQnMkMTeodIRAjyK
	fnPzlm0Ht1KrItg82ie964lVUiaEyTQOGlnFUg8o1c9uFXDe3vuZC0ck4k2xnD8DgEyFaYguOf1
	0sUgw8SBvKkq+3vPTRcLzraYsAd+0dABd0wF0/yRGR1Jqo2y/jqN6PcNxWc27FyRbJK9tJInj8u
	J1HiNEXFLRO33HVdIA7HLVSBZcSxmBahB7/zQRB6wQOP0xeICwE4zd6U9fgXw9eQCtmrQmTcT2B
	WXKV+noFTHiB2GVhwhSOLAumz+Qpxg8CCoCKmgAbuGm3U6fwtbQcHIu4+2vqTWZcwlcj84dMkRL
	lIwid+ddlTbr3IISb
X-Google-Smtp-Source: AGHT+IHehfnKYCHEwgQg2UA1/7tKSJAulXBmZ2VniP+tL7uxdRKGux7eY9b2KcvJXyj56PkW8C6bfA==
X-Received: by 2002:a05:600c:45d0:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-450d882b456mr9757105e9.5.1748594130712;
        Fri, 30 May 2025 01:35:30 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb80e9sm11450035e9.27.2025.05.30.01.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:35:30 -0700 (PDT)
Message-ID: <e8f3386b-de5b-447f-af7d-5f521662ba31@linaro.org>
Date: Fri, 30 May 2025 09:35:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] usb: typec: ucsi_glink: Add UCSI quirk for
 X1E80100 platform
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <grJaz_699sNeLfZ0Kp0u8e13em1Y1VWTlH3dSqSpQE_mHdD7iVKUwHkrvjZ74i3nDzn9c5_Hwg-8IAW40N1iPA==@protonmail.internalid>
 <20250530-qcom_battmgr_update-v2-7-9e377193a656@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250530-qcom_battmgr_update-v2-7-9e377193a656@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/05/2025 08:35, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Currently, the Qualcomm X1E80100 is treated as a fallback of SM8550
> in pmic-glink support. However, the battmgr driver, which uses the
> same pmic-glink compatible strings, has implemented charge control
> functionality differently between SM8550 and X1E80100. As a result,
> X1E80100 is no longer a fallback of SM8550 in pmic-glink support.
> 
> Therefore, add match data for X1E80100 separately in ucsi_glink driver
> but keep the UCSI quirk the same as SM8550.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Small suggestion for your commit log.

Call out _which_ commit makes that change.

---
bod

