Return-Path: <linux-pm+bounces-16531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7E9B20D4
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF883B2108E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8918800D;
	Sun, 27 Oct 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crnshk8j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12152F9B
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063830; cv=none; b=Rw3GfAGw22gha9dgsApSCFDD/22oAPtX3bxcQPQRdzceeNnrV+tKUTDMqammWJuy4hIO8mZCcZtftc7yeHQlXgKpmyAMCMk63QK1z99HgR1+XbjPV+SEo+mTQpvu/C6e/2KrPSlza3OOp/ko5EPRbqOQPZ9P3tQnXpX32lmFOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063830; c=relaxed/simple;
	bh=sS7MYxAn7hJ+M177SFR6s17RqucMLgUNbEifPJ2tY84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL6rrD5n3pXLXZj0algVmWTejsZJkyZ+LuaMxGCcPbMdhoLcM/LuhBJAaHJUGkKzcxwdv6fuFO4sqICxSY6fUlkI8xASZiCFr8ob6EbVUnZIOsZa7za3gd0eRxNQ7coKXMWcF8xDqYHbbFedzzsrsEaMH37lCWv7A6FhVwNZh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crnshk8j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431506d4f3bso3949865e9.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730063826; x=1730668626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XsEexGvhHKQ1pYH4CN0KdPK7AEaJvpVAX9sS/M7VWl0=;
        b=crnshk8jEOQ0UQZEqp8D3z1LxXizeqSTdxJPQrFAGYPWdg6Dq4SOnWRLY9keLjQmEY
         /f0zIFDAXFciuNsu7sZ+sY4ob70iaJ24POasSST61knK2qj4ut7lLzXObjmojhfjomHu
         bKHpJY4mq7x6aDyD3KSz/lg1trJbzi/BKcb8n3AkgzF5YjJ9ZxW9uENMF+T80LHVWVl8
         3iK1kcnvmdgdC5RZpGyLjR/670vQZfPYIABy+AlzMByL1OG7PykQHZeOVUZ9EEYdmCHa
         8K/PxqaEJ/bzdscAY5bt+diXDyG5N3tjoTQ56j0vJCymXn8gAVcFawUtugBIVLe6P5GP
         RILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730063826; x=1730668626;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsEexGvhHKQ1pYH4CN0KdPK7AEaJvpVAX9sS/M7VWl0=;
        b=LpK5rH8vgEPYndFJ8eh7M4dtby1CfE0lbWNP34AuZI6orX5oNLwuzuIlLp+p+WKaNz
         d1VcYV/vHDbfPY4CYOX5CiTsZyLPH2fXDgwZXdIURI/4sMBXIL9WICpZK5MPaxD3GQUZ
         p/pDEu4V5fhYO1RxyYTaWnZlI/tBlrocQ+4OiEbJ/rI/GtchK7DUduXCb+DV3yYDVvoB
         dcxgBaadoSG/cQo0srAWFc3BbxxZEJG/WXvU3UpOb1L650+cN06+WxGa3P/k0HYFdU4M
         Vh6trj5G0ZvakC/j3m8wpDHcjYskssscicc7cwr1RlV6QQD7hei2GXl5y89FTRFjPBU2
         G76g==
X-Gm-Message-State: AOJu0Yw/D+MUrrQa+6vOY/qPhsFZIqi64PUJ0AHmQr78ikCZH6K0Z5sb
	v3dAurXUdDSoI6x6k2V3mmFCOzoCL9KpfrkCEY3Zccf2g0rT/EQSQod1Mu1m5YE=
X-Google-Smtp-Source: AGHT+IFNYJ07pmV0/JmMd26x0jYk9K2bZfebhhFpSiKjL8w1ErRIJa66STzImt9eIgwQi5/x7M1XcA==
X-Received: by 2002:a05:600c:1d16:b0:42c:bb35:b6d0 with SMTP id 5b1f17b1804b1-4319ac72db3mr21060275e9.1.1730063825630;
        Sun, 27 Oct 2024 14:17:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b57b5d9sm116014695e9.44.2024.10.27.14.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 14:17:04 -0700 (PDT)
Message-ID: <abf7d194-80b5-410e-8f6f-b1f9e40cd893@linaro.org>
Date: Sun, 27 Oct 2024 22:17:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] dt-bindings: opp: h6: Add A100 operating points
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, Parthiban <parthiban@linumiz.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <treding@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-12-masterr3c0rd@epochal.quest>
 <7dybkf3zveidwapwfivvq3jk6qxntuqgycndff3ajjl2owhjhn@khqgycnzh76j>
 <13a5e833ce19df20b0420d7f1052fd96@epochal.quest>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <13a5e833ce19df20b0420d7f1052fd96@epochal.quest>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2024 22:13, Cody Eksal wrote:
> On 2024/10/27 5:47 pm, Krzysztof Kozlowski wrote:
>> On Thu, Oct 24, 2024 at 02:05:29PM -0300, Cody Eksal wrote:
>>> diff --git 
>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml 
>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>> index ec5e424bb3c8..603c6c88d080 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>> @@ -23,6 +23,7 @@ properties:
>>>    compatible:
>>>      enum:
>>>        - allwinner,sun50i-h6-operating-points
>>> +      - allwinner,sun50i-a100-operating-points
>>>        - allwinner,sun50i-h616-operating-points
>>
>> I have no clue why a100 is between h6 and h616. :/
>  From my understanding, the A100 was released before the H616, but after 
> the H6. There are not many sources to rely on for this, but the H6 
> appears to have launched in 2017, the A100 in 2019, and the H616 in 
> 2020.
> 
> I assumed ordering was intended to be in chronological order; perhaps it 
> was intended to be in lexicographical order instead? If so, I can move 
> this entry above the H6.

Most, really most of the lists in the bindings are ordered
alphanumerically, because that's the only order all people will get and
all people can really verify. There are exceptions. If that's the one
here, then sure, keep chronological order.

Best regards,
Krzysztof


