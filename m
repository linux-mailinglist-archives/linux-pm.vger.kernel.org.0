Return-Path: <linux-pm+bounces-10363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171509243E3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9AE1C240B8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8721BE85B;
	Tue,  2 Jul 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8GhtMwK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A51BC08A
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938731; cv=none; b=Jg3zGHvsmXdjec3TxZUsDCTCdD4LqcNLsbL1wRz0WlXsYF4/gMHBq3Fe0NdCHZIhuUerignhPaLOzR2TG3Y5tEna5DFNCr8X9QhbQjYmoPe6GdsuocDX4tnzU7I6Q3/gZzzcib66wuf2wg/WdRJUUIqwvxOWRQIiJthHtd9Wc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938731; c=relaxed/simple;
	bh=3nXRptT3XS6fYDJodDzbr5a10QmaOR61M/sAVY5ilFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiH7TWeEZRXR0k0gPNslPm0TGyLYnFDv9k5b6obdgpstzkSySCz2+vGa2I9Riu0BjUnTmGMmBWb+hU4fcVgwfBlLJpZclxvYZ3O2oCAKv4HLLvvkzE1w5g7BYH7DRNfeV0mTU/HV1qMZo0wXfdvaXMtGw1UCqNCPf9MY5GMOsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8GhtMwK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4256742f67fso32222525e9.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719938727; x=1720543527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1cYREOP31EywM3h1j7bQokqdAVYFNs0tCc9+hVliZ8=;
        b=t8GhtMwK5v6OMokGoZ2KrG75BU5zgnVGWmb1mNaHKPwusEZ0JzzWlZ0ccU+hzrbfzg
         5WG0rxfvIW2EdKT83ouzixsIzeWh8rFAw8fBxOVE4kxLUAWitPHq4lY4yEQlbuceUE4+
         Tg0vjzaR+lB8AKIkoMS7eTHliA0wCPtFSnJFOygUKjNo7i5rls8CWB64ZGXQk7/FI0Wg
         hutunNt53BIlGqCqr6yA0uQgzsTTalhHsunozgaZBTOctVcvjz+aYt+001xBI4msk8fF
         iQOdZyT7y1RY8BNNYTbW9VnprSieAQ1KS+ECXTGYG7+u5Kr4yivsbZmw4GNrvkhSyK0A
         IAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938727; x=1720543527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1cYREOP31EywM3h1j7bQokqdAVYFNs0tCc9+hVliZ8=;
        b=LVAgTMRgGu2pzzXqRlYchlMkDJr2BcBdRkHxaFA3pHgusxYrbs1OK9eX5qnwIk7CKa
         k/45FQD09wOwbAJKagsVKjcUOOmeh9HlcWppbgmZX49k+H781o4ek4RDRe9qaHHgbfVP
         V9UlEuRq6wseJtoWLB3I92P8qL4HCNz5baTxpYWzBw0Xe4eM9EG+zG2CTvhGWd2XeUq2
         leE4eETIY6hCtOrOnd8xTpsOqytEkVHE+dJAMjjx0Ft1Gtj37954LgZh4UnuJRD+xT4A
         ze2UaB66N3iiFuRExdAiE9KBywGx/NUnWmQ49ZOKNurxgT2a2wzwyEtqdg+HF2hJZ4gL
         fRFg==
X-Gm-Message-State: AOJu0Yzq++ekEE3jTwUzYV4SYeuhbLcZYCeJrFi9Ku8nfEgcAXh9N6Iy
	3nG9m6hU6kaL3ld2jPE0d3KOkOwm/I+lcl9qk4ZuKFTs8SOsBPJfjkK0iAocS+4=
X-Google-Smtp-Source: AGHT+IEBWDV+60MU01aANMdE0q8VPO+1pvEuf1/jB7KUviux2SJyGN5NunN+2vpKZtK1cjg9X7ncWQ==
X-Received: by 2002:adf:db50:0:b0:367:880f:b8a7 with SMTP id ffacd0b85a97d-367880fb9cfmr1348950f8f.8.1719938726969;
        Tue, 02 Jul 2024 09:45:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0fba0bsm13698885f8f.69.2024.07.02.09.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:45:26 -0700 (PDT)
Message-ID: <5b2806cd-467d-41d2-b205-e34f9f281294@linaro.org>
Date: Tue, 2 Jul 2024 18:45:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the
 X1E80100 Temperature Sensor
To: Abel Vesa <abel.vesa@linaro.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240628-x1e80100-bindings-thermal-qcom-tsens-v2-1-4843d4c2ba24@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240628-x1e80100-bindings-thermal-qcom-tsens-v2-1-4843d4c2ba24@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 10:31, Abel Vesa wrote:
> Document the Temperature Sensor (TSENS) on the X1E80100 Platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


