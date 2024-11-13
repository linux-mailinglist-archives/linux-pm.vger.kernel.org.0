Return-Path: <linux-pm+bounces-17497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D629C769A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20A9283F61
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF21DF272;
	Wed, 13 Nov 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="av6kxhkq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE71684A2
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511305; cv=none; b=QRNkurDdSUXkjkn+ufO6OOoAtk93O+zjsvmhjr6B1WZk1ccvAg/7ql1SggHi7iJPVA7N52VE+TdA5Kh3oqmD2yTcdJBezjdoo9igCQBQwRdyrUBkf/78lO2WzCV2iQFcfokh9w0Kp8VvQLyblLe7szSBYquh7ida/8kXKUxgtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511305; c=relaxed/simple;
	bh=4LiMDBZ2BaPjcm4lQLrzPw+4IHjcexyzPDS6D111VAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jhb5NGyCFChIqsheC8OahlDYjRb46xPmyFVC2+566PKmmCz3j8CLQbQt1VOtwZ7JDI7LV2fpgYdVzcqhT1RjTBBtNGvH1oo1Xd2zuzMLaaqbg+bVIp93f79fsTQAEKkJa7ZNCoOMce2YoCCnHXcGTadiD4QnC9Y2Hc922GfAVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=av6kxhkq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159c9f617so56722985e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511302; x=1732116102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=av6kxhkquD5lNUzRIl2Q7dWCqz8TqW1Xk76y4g5PBwDlF88eseVChV8fSAf4PSJtCv
         VC9HBc+8Ts+QYOaw+FpRA/LLFkpcAP+9MtZUGUPfYwH3F9KZlPuSzWptcrE72iztK7MO
         smQIorFRn4vTKtKtaFa8nMCIu5njbW1U1HZ6oxoxZ6hrxCB+VHJrYOS/Z48QhsWuG8Q0
         ziLqD/kSQgeJ+T5RxibpCIyk2RZ0Cb2ei+M8ftHDbeme+VIrPWdBy569IZjxD3XktzG5
         noOIh0VF3DWjoyskH3yfXvOhRKl0tdeYlnjhtcCj3OZ7bZ7ueRf/ovZVdQaW3oFJUrv5
         8trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511302; x=1732116102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=T24Ofw1gxz+eNwvNFQFeK9xGFPxIxX5ZKSJI1evWcgRmBYS647QhgUCVmTS/JNLAXt
         gyAWgd0cb32mH1YuEIlYNYOLNs2VU/X0PCrCxk0YLNOejZqK5ZaD65ev2G93JFtLpv62
         CR8eEgD6Bv12EHiYbJWj5ath+y2WmQIjUONtVxJU9+RkFuf/Xso8cWbsDyKgS73SmNdg
         ViWngtWM3sfDdevxvPmaAUVaZseIRzSd1TSqYCykBI8fkP7ee5ag96Vx8cHzsLCoES+d
         9McDosCB/R7wj3r7ZxJ7GAdmvo80FOY/pvjo0jvjGlpNjkbVcmnZss2VltVHnzZ8bBCI
         uy8A==
X-Forwarded-Encrypted: i=1; AJvYcCXFyXMvAs/eXmyEM2lifTXIS0zXtmbLfGH6RI+2TUBe3k0w9QpHtWPdoS8KX/BMu1I3aPIejBZtNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf3iU6mRXrlLxcKRCVo35vnvqoXFR6D7ouKqj7j6HK0+ONV+t
	H3xZEUVT16L99wNIiX4unhdTf4DjsO9BNAYED7I179qkqb/eAKIZ8fEx0fZ0+u8=
X-Google-Smtp-Source: AGHT+IF0lRtjI2o7jj//l+xrcNOBKkeWPvh0yXKVaf2XDugcQj/I02Vc/Dy2jhxuVt1mr7E9yNfsxg==
X-Received: by 2002:a05:600c:4f4e:b0:430:5760:2fe with SMTP id 5b1f17b1804b1-432b75183d1mr175593615e9.22.1731511301811;
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d48bb442sm21749305e9.1.2024.11.13.07.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Message-ID: <3193901b-c006-4feb-af72-d8f74f2d6428@linaro.org>
Date: Wed, 13 Nov 2024 16:21:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] dt-bindings: thermal: tsens: Add MSM8937
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 16:11, Barnabás Czémán wrote:
> Document the compatible string for tsens v1.4 block found in MSM8937.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

