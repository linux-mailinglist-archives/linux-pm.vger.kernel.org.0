Return-Path: <linux-pm+bounces-4762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E73874B00
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 10:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552291F2A52D
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65083CD8;
	Thu,  7 Mar 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h551t8T5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96B83CD0
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804205; cv=none; b=g9qQCo8sG7rHpZxZd2DiV/DQLafljA000m5viEkpt5bcMsxjgbl+tG2HgX/XZvxUdmNdagj7kKxSO88BV1dU4sWcOZH1J5zuLO0G14AcoHqhOruHX4Irc0+vpUSjYqJENUSgdjHI7eDOoCmk/MkEfrq6b8GqxSV/7ULXryq5p5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804205; c=relaxed/simple;
	bh=YGXQZyA43MxFpMSkBG9HcAKzDDQ/XEwm+g2G+GfvRko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjTE5Zd/GLB1jRVlLaotJ0FTogvcdBDNI+f3J2VP1gvRz/q1TX87cb+elcYcO76Ytj2SUWPcrAv2Su5cwo9KN9Dm3XCCM9tcqSmodjcqFR6uFJicCQ/ZBJmM1rz56l076gP91udkWgV953DQhE5hoWrbr38xRxqndp/O1OLL4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h551t8T5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e4f15710aso425221f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2024 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709804202; x=1710409002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blXg0re3pMK1y8kknPqEyLHNcG5hpzcC6xBwN7/JFrI=;
        b=h551t8T5Z1idT1pd+Lgnb9Wh/V+kloiBt4wToeOw8T2SzZE2GPlWohXOUiULFphzP8
         Bzlwj67drKqNDKmxelctQZ7NcIkD4o8txo54bGBKacm/FZlXWmyfg8B3PmVws39/2brO
         OD+227GGyc4FTef7Py54aJuEJMDTsDiiZUdVowS3aBWJieEwJgU/aXjNXqi1xNTSgzR0
         zFAcvNEJELxNq9MBFnXr/BxEa3nYNVLWelFdRPTAab3CZUdBeeqdHi+ruYvn5OII/1AX
         psYzFXr4x4yUmPdhpm6sJPWRDu33EWndzpL1THVZM0OMfjcyT/oP2bLdGpdkcwo7fjC6
         yW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804202; x=1710409002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blXg0re3pMK1y8kknPqEyLHNcG5hpzcC6xBwN7/JFrI=;
        b=Ck7nJUFXEQv6kmYNGLK3kQtetHSSK22jDviHus1bcTvQ8lNJz+GNZmsYGRw65RkDrV
         c0U0Ff1oueTgHC/DFyHWR0GFQ7qSOO4lpK0/J9lbPvu2cC1LSNKnKCvINe34zN8K/oST
         m2rNrUgb/PPAMFQk97vipPQa+Da3YYoBONhPmOp3DNQ5UonSjKAE91YMeJNI3BW3K+oJ
         2GqWkjhL6BSzqq+BUSisenR5bMwGQJ+Ht4Q/DNhHDD8H09lFNKuri0EhQRDmVY3rXCHk
         ahxBdPt6dH6+wZr1TEqgbP5HflUGP3/0P7xA0nP9dG0yj9lPNIutbYLR4ex4pwEatjbl
         IPrg==
X-Gm-Message-State: AOJu0YwgMdMzl7giDmUonTOWsJSMRCLl3ySOVIkGq8a5g7x1pGtfXOtn
	9SXJZw1G0eTG/N+pRSZzUugvUqaLLU/eQtgGxCLOtZ+SnxXWg4yrDy13AVCEnjE=
X-Google-Smtp-Source: AGHT+IGJmUMGpzUunWLnUHl5R/CJ6c5Zf2CifilxJkYujlGC4l1Mt2ucbrRAbMbOWZupIS2ODMQklw==
X-Received: by 2002:a5d:550f:0:b0:33d:f883:4fae with SMTP id b15-20020a5d550f000000b0033df8834faemr12135601wrv.64.1709804201831;
        Thu, 07 Mar 2024 01:36:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bj1-20020a0560001e0100b0033e48db23bdsm7107211wrb.100.2024.03.07.01.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:41 -0800 (PST)
Message-ID: <1accaae2-b034-4afe-bb80-98209b42c348@linaro.org>
Date: Thu, 7 Mar 2024 10:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Assume polling-delay(-passive) = 0 when absent
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/01/2024 13:11, Konrad Dybcio wrote:
> As it stands, setting 0 explicitly feels like spam inside the DTs.
> This series simplifies it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


