Return-Path: <linux-pm+bounces-9737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F1911C0D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CA7B24FDB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550115A49F;
	Fri, 21 Jun 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmxpHqj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C515665D
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952270; cv=none; b=mQjoL035VBoUg+7ble4lJmQ79Bcl8suBwYcocd9z8AGxqH/OI5I9tCrD3qrBxBjjpoK5oAaDcFGASw1kJxYW/tTmVPT0qUQj8/k78KiRpILfm+hKaOfvuvdnFzaBUl7OdJjR0gC5vvQmaAmZppdbOy8vn/aOiJKlCoMdpuylrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952270; c=relaxed/simple;
	bh=/yxkQ34OZIgJLtm6k+/Jx5eQffI42lQD+HuqdNrmnYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN16hg6a+T7REZziIMK6RAN5XIt6l9AH5S4WIhCbod/FMjGsF9Mr2xgP/wexTxDAeVzn3cYi04z9Ane8yXoZNFvc2wFxKqV8Q1/YNxLcCamyYB9GqBdWQyl7BKWm0QS6yGGJeNZQneUwif7sD2w9bPe/1X8/d+WYUkV8aL1Rh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmxpHqj1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso19443365e9.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718952267; x=1719557067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1PfObMgRM9iWVHsZSbl2B9P1fV+BWqU1Qg+2Z3qw8Zg=;
        b=nmxpHqj1erm9uCj2b0SqRwsKs6zl/M1JnOyzg6M73qsakcWdYTyKW5IwEk0shnljfW
         3Sd0u6meVr4vhyimnDazXa9nGgR51MXAgqvQ8YDhySuhbJ/3CXqeWOZaQVzKA+aEa0HR
         /wtLiOXitC9g1OodCgsRSu3d/AXmWwI2sGnHR/eLpfnrw+6tqUq65Z8GeHglF+qxb7FS
         QpWnwwT7qSZGbCsSlryxdYmTCTVFJcKOHlAzZGJy0z2CfSCk8Y0tuVNLk+IFOKiywILo
         AqNpwkIgQ8J3NhC73cQhFuAZ7xKjYnzAvmmiQIkbgyw59AEiRdUegkOvMFL8uUWsQn3E
         Xcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952267; x=1719557067;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PfObMgRM9iWVHsZSbl2B9P1fV+BWqU1Qg+2Z3qw8Zg=;
        b=rcXnOJDTNWuHPY+h2LWjkhAdNRj/osYGSQfn3aIWJywDKbq4IcyE20JnTGUoGOHisp
         YYJIovEj8/oTrmWMKQH4c5f9uJohfjwhPJOMVRn/+Hq/LuoA79qq65l5CZUIjscjzeJo
         a+cONjkRePl0fGAqXi9ZauOBgNbcw6ovBldkXOTlchNeMVkel2TTs5C3LLnrRn+h1yrO
         wP8gZoLwoK6ffnAhglHr/Ph/L30NQlUIKLCx0DBpAOfwnmYbrXsx4d6mDFnmLIYpWGCt
         p0vk+2tvgLCzgm7rrt11iFjjb0pAP3HzxIw2cwSZd4mfaEfYxHz0qVHyONQM/c03Cix2
         NBvg==
X-Forwarded-Encrypted: i=1; AJvYcCUXNWmVnVSqrXRsb6gR1l+vypBfWEcX14KjX+PoWsrq55GqUukb6G2qh7aV03FYnPZhSTcaKWJEMWRbwRFveDiIu8Rc6tQea6M=
X-Gm-Message-State: AOJu0YzfUJp51EoBytSFO4wEcFJ4S51nR3GdGxqordVTSFhS7tHzlK7C
	lYSAUKA/D096oUVCb+iQo9YcwJruLEWf80a0jmNW9Sv4amLte2GYzuFKFNgf810=
X-Google-Smtp-Source: AGHT+IFIFkPNAqsU4kpceTCO5/VxjwkFxtTxPWOo7jibcO33gtxBKvlv2ksAEKUs7USMYXU4w0vOCw==
X-Received: by 2002:a05:600c:15c5:b0:422:aca:f87e with SMTP id 5b1f17b1804b1-42475182567mr73513005e9.19.1718952267141;
        Thu, 20 Jun 2024 23:44:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be836sm50290535e9.12.2024.06.20.23.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:44:26 -0700 (PDT)
Message-ID: <eda0d218-aba0-4ade-8a9f-51b4591a32d2@linaro.org>
Date: Fri, 21 Jun 2024 08:44:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 X1E80100 BWMON instances
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-2-quic_sibis@quicinc.com>
 <d09aa84c-dc75-48c6-b91e-c0dbe3d2e06f@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d09aa84c-dc75-48c6-b91e-c0dbe3d2e06f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2024 18:02, Konrad Dybcio wrote:
> 
> 
> On 6/18/24 17:43, Sibi Sankar wrote:
>> Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
>> instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
>> path. Also make the opp-table optional for the X1E cpu-bwmon instances,
>> since they use the same opp-table between them.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> I think we can just drop the opp-table child node from required altogether,
> bindings shouldn't care about where the OPP table (which is referenced in
> the operating-points-v2 property) comes from

I agree.

Best regards,
Krzysztof


