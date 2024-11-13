Return-Path: <linux-pm+bounces-17498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAF9C76B5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B47B2840EC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57F200BAE;
	Wed, 13 Nov 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvypvoiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412513B29B
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511346; cv=none; b=O8pbfyLKY7jiUMkIVL5DmzVPIRW3XyKJqSO2GG8vWSVdWK23BJ7PvlXhunSlk2sO9l/z3r2gtfCkPWKIwqHxzxTJakwxZPkE8oxNedIKLb2GB1JChwaNO8C741PTJlt304n71nvUIqy74HsMvDVKQauQN+RafeFWZ+gEr193gbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511346; c=relaxed/simple;
	bh=HhOwop9BJOKj5T+Nes36w0KnTxUb3W599pW6+HWRufM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se5uPmK+JiarzYqxpk55HG68tvZSX7h7qj4CHSO9pFoEDFGOX7fjCNyRZNBtwCG18J8zYNDN9UWE48C4jbCh5vVPoDpXC/tbTHyXWQmk5V9/aSeHCxze5T+xPqI58FOXzerNDgI419AWAhywdTbFqvsgnIvVPXzBVkqvPUMVqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvypvoiL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d41894a32so521806f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511342; x=1732116142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyz8CAV7UjnZy1sBo5de6wt5Xr9fxxfh9Ju5xZPyESI=;
        b=ZvypvoiLGObdI4KrWN+1x9ps2JqhAUf1HvISHylTFaTGM+hD6xJQ3JQEjTa9kgZbQY
         kKYZFhV1jiNqV4yrfToK9XZJwvRSmIqmlrtK2W0zJEu3lSXPBbKvP8SB83qag+dwC0TM
         xzIbvJPeV3oKe90AUlHit41TVUWwiv8wmlr7xDJa05q93n5a4nAmCjflysbPN40Kx4pl
         SDTsLcEKzGj8O7ipUyyeZHYW9Rjx5Dj73ZKIIBHxqYhjOWZx2ixvxXernl3iZWNCtSiQ
         2gISQUDpUP1ZtpNa1hiiMjxHKllwBDxkYQp9cghn4NTlVHumlKmLA/l4n/AiEC77/Z9s
         mOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511342; x=1732116142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyz8CAV7UjnZy1sBo5de6wt5Xr9fxxfh9Ju5xZPyESI=;
        b=b0szLuh+y5r9pSxlK0dwUKE0VISfnTefhibcCeUyRPMcqpVPW18/6d8IVJN6iyIjmu
         KDPR2crzYN7GsSh9ULRufxjpwKHROe3SZcCuz9Tsqy5W6GaHdYUbMdJo4YmQN1YOyIEp
         dfCkUjEa0kad3Cyl6qxCJgq6TjDYx5Cimui9JwC5hS3NYJd75OvS6wFvh2rE5OLKpSr3
         ZC35FyF5cgXPngv5wnkIg2fCIzdEf2VYv8FQ0DFy0luTibe3yx5bUs4y6FwdKXwQ99HR
         8bepHPrB9FF0tDUJQkPA9BdbZWYpczK6hQ9QqIP/R7/oqW4OsB2bs8QoSGno7K6Ikywx
         hmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlVy2jGVFV6IE9ssreimII3tp2R1wbbWT/w9I4G4qG6WlToUKFO1oZ5XyI1Pn+abmjeUjdkPapaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQq5Slw3jW+Z/R6AN/Y2s4FofxQKfrsqTcPY3j27vZqgLb7Cka
	D6clyAd0PtWNQP2ar21dQfcbDugKqpXdO2yEcJlFTvo+Z5Jw7WniiMisNrZS6Vg=
X-Google-Smtp-Source: AGHT+IGkBBKScUdnq+eFrrUWl5WZg/WDJVAp06eoD/G82CPwKOfPCXQv+8oY7dXz8ArJe9wVy2UbvQ==
X-Received: by 2002:a05:6000:1f87:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-381f0f5e2ddmr18929643f8f.14.1731511342593;
        Wed, 13 Nov 2024 07:22:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d54e2cbesm28265185e9.4.2024.11.13.07.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:22:22 -0800 (PST)
Message-ID: <cfe27773-383f-4178-9aea-d92c2bcf8991@linaro.org>
Date: Wed, 13 Nov 2024 16:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-5-c348fb599fef@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113-msm8917-v6-5-c348fb599fef@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 16:11, Barnabás Czémán wrote:
> Add support for tsens v1.4 block what can be found in
> MSM8937 and MSM8917.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

