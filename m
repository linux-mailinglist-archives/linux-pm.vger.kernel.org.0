Return-Path: <linux-pm+bounces-11330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964893A056
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FB628355F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7E15216A;
	Tue, 23 Jul 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgBVQbAj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F981514DE
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735917; cv=none; b=jcdEA7CuCZJaRa0rUEFKkjueASTZ4EaYz1+eec4USjvzvODH3ssnT0rj0KJ9DpP31hAXmZw0HWyDaR+ESZZjntitIPuJh/vFVkFuQvy8hTkJXCcX9JSA2DNph7+nU2CPrITcnCJJUa0oKIJuVqCDwRPRE1fo48SWIx5nkxdIGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735917; c=relaxed/simple;
	bh=C1tz8K/u7VRu4jwZF1eRtTzAwuj9hXTHoeZsW7ZHnjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhaxv/47EOk8ZHqEDWoVSWOZoOoF7HotISL+AAvANBg4i3g0AGMnXkaAzN+8b3zVrTXs6g0hZHqzWzXWu1ARRubfuaCLJisjlzftNTQSJtB0pMFmVPQesQAyUcAtq17B6E/xZhyyDLXGgkHmytwiwx/05JuSJhjfrmZabm+UJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgBVQbAj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5124059a12.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721735914; x=1722340714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P+djReoRTIhBXyvCN8UfaYCI1awzWvkrD6U3A9THW/Q=;
        b=lgBVQbAj89iEgiNC85CWg64GA+/2J4e6UOtiVR2zyPBBiM1r6seDDlPhPL+4wZxy6k
         9MhPPb4g+7xfYwwn3SQS71aFB6wa6jELwM+7zXsEer+Zo0pEPKECsqXv8fuZmbnrguuV
         JziblqEuFZ0LkUudcocsO8d6DRaa75S8JDTUlYutxvtzJvhBtCoMLeMggb8bta1nrXU+
         Ru9YZRsKnHaK+bFqmDYYsrXZ84UE1JvTqxnlSW/+9c6Lst1otaTjlGn51VXnBzLBDUTZ
         9glHxQHAb49mS8Ed/wdCd4ul0R/l+01Jv5VPDzKLzqg5Xx0AoCtYNJn1AGnWtyVwwGyk
         wiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721735914; x=1722340714;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+djReoRTIhBXyvCN8UfaYCI1awzWvkrD6U3A9THW/Q=;
        b=fEw+A6TRcFMxipKAbcgKN1uTpYQ4jdxMUGwXr6Hfx5dTQbgEm1MPMsZdVlKEIO4Fau
         FIy2jZZ9QW6ka6nLhE3UQJM0Qn2MJGVA+Q7a4N0Jtku6QqRecxfbdRIARbtEjtzG41uQ
         b+1dCEJ/lqwKv+p8xcklBYapsk0EmUpSrJTduy9jfrlyV73+lsrX3n5aYc76HhnO5/WO
         abLH0KNo0UmXz8T3KG22RfJKcq6L5gIx8KAu2xX7lNll9Sta8sRVZAzPz6iIJDje4BYO
         sxLxzDxYBS4h1vMwc3Zb0nxVuF7ob0enKAmtb8AeNcQanhduIGXuZ40SMRxM7q/goIRt
         Emjg==
X-Forwarded-Encrypted: i=1; AJvYcCX7twbSB62TNqbvopXiZjYYhTBFJsAA+h3pN+GJZSI6uzeBwJT1hof7D9S0Qfq3EYtmTEKRWnpcBhnRklc9yAe+sAB/8Ndg7rU=
X-Gm-Message-State: AOJu0YycA5VV4PrHdOxMK0Zllf7oI5G1xMk4vR8mg7NmhddWZIJkv12n
	RRMQFqPRp5WTTWTbGZODT8DPZdnMKm1xkZdvz5k/wkm+S7MYNxFprzLbibIzCFk=
X-Google-Smtp-Source: AGHT+IFGPFk3/DBxWgzuM2E00MW1mfvZYKIspK21ddEFkKQ9CsbeM3pj3Wy64tvPUlWKA6N3EvZHCw==
X-Received: by 2002:a50:8d4b:0:b0:5a3:41cb:676a with SMTP id 4fb4d7f45d1cf-5a9438290famr1983315a12.27.1721735913896;
        Tue, 23 Jul 2024 04:58:33 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d38f7sm7479874a12.88.2024.07.23.04.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:58:32 -0700 (PDT)
Message-ID: <3b00372c-0c81-4d0d-ac41-96020eef1580@linaro.org>
Date: Tue, 23 Jul 2024 13:58:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] dt-bindings: interconnect: qcom: msm8939: Fix
 example
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rohit Agarwal <quic_rohiagar@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Bjorn Andersson
 <andersson@kernel.org>, Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-8-a39.skl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240709102728.15349-8-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.07.2024 12:22 PM, Adam Skladowski wrote:
> For now example list snoc_mm as children of bimc which is obviously
> not valid, drop bimc and move snoc_mm into snoc.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

loool, thanks


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

