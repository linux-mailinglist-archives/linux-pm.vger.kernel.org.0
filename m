Return-Path: <linux-pm+bounces-5478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FB88DA34
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 10:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E831F2AE7A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174A376EB;
	Wed, 27 Mar 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIMtOwEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BF1F606
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531403; cv=none; b=ao0lQhn7R958od8U6cTJM0+GzhozPpDn/Ec0eLq4f9Q27mpRKDVnfJCRuiOupuMHi8SD/W6+dHDfLbpzgWMDw6HaA8xU3ay3hUy94TShcTw2+OD0ILxQrzQPftvbBVo23pvMoenm4Cj64OdjSU1Dz//gK0uwOrKMj7XW1yIQ4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531403; c=relaxed/simple;
	bh=9iX7b9GD7uvh5Hbkv7+dsefgSwYEYSZcj+k4pzrjb9o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AvkET5hMQL2P3iL/sKQqwRvB3+IZ6rtuYJdjWHDXDMB8xqOoTK81f6trx0swm7VjctxoLEzHPDuCPArWJTDgFEGlAJ3+lu4+KcZUrUPS9AEa18eSHpNNyNAzfJs54xIz8MdsD11FeR3hRhBy3u4w/aSzITvtelz9aGJG7t6yKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eIMtOwEn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a47385a4379so119356066b.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711531400; x=1712136200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U9VA56VrFWmCSGuSnKV8c60GKZ/E4BlEsHm8F89QPoQ=;
        b=eIMtOwEnDVGTaNInTQf7g2bW4W4aWC0e/NDJcumTxm1uT15eA3ERznN24nm1bH/yvq
         szMNC/933kMw4cAkz0c6Sx3UCSDYJEzzUi+Xdgloc2zpPTAFmVoBR9JvkaYkLdmAKlAh
         ItioN/SxbNTNZkfxkq0KJxaT4VKnjUotHOJUaCAeG+NVKRTqfF3LMgcD213kSYiaQhJM
         0BIYyCZBWi5UyvhXagAFlKcQ83AOddzSGym3jAjjLt5lxzjny8655BnYTLGUwU/my9xE
         CoF8e9FCcVxTo6dmSJckM79pS1DFu2UqdhcYWTo53tHssm/mcAMWdbyuSSnlmmmL/SrW
         W1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531400; x=1712136200;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9VA56VrFWmCSGuSnKV8c60GKZ/E4BlEsHm8F89QPoQ=;
        b=jXZDIkhwpTLjt7nBB5uvJKK/05dLNHoLjr+ghubu51DwnWqExAD5WQK7TZOA8310z7
         7xVlZBwM+Q/MMumMNzh03UtPDmL8d/TiQv8wQCcS5eazsRy6bs8m19Qaawu8fVsH8gz/
         Vz2guGOyGn89TR9JrDGR6pHQj8KqBGbj8b4GjHTJHioKW1zNtSEEER+NMa2PCCdPzS8K
         MdsOa52Ungo5686Ny0iW7V3nckWhicZxwOO0LnvAMUAcrT/TrMv4R7Wh1MZ80mph7Zjs
         hw9bjpwpHKfzr5Q3bTDVVornb7/VqH7p6incQG8Zh6YZ5FCou6QoOwvfbNu26S3jaB2A
         G0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXVYTnru4DcZXYPfASbnfTaw3eMAEMq3cJnI1DqF1gc327PsKVCGB9+xpcHdclMem6ziCMa6nK1CoXJ1SwrZ6mG/zikqrLxNwQ=
X-Gm-Message-State: AOJu0YxTLP5/HDQgewKY0ypMexvkisjKfkOhGDJSD9hOgjcwZCdS54ya
	/cVo8CCP+iSD5ZZAJjiexsSAKoiAujCmCnjbF9Q5RmE6D2N9Xf0SLQVVOki4n38=
X-Google-Smtp-Source: AGHT+IHOTEmL5nnAkaZ43sMnfmXMPzU1hxieecDn0KTOMb9akiksiLfGJLOnOIYjYs+Tzeyvsdi2eA==
X-Received: by 2002:a17:907:7d8f:b0:a4e:14d:69d6 with SMTP id oz15-20020a1709077d8f00b00a4e014d69d6mr1513670ejc.36.1711531399781;
        Wed, 27 Mar 2024 02:23:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060dd600b00a4df7d02395sm1406144eji.86.2024.03.27.02.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:23:19 -0700 (PDT)
Message-ID: <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
Date: Wed, 27 Mar 2024 10:23:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "yu-chang.lee" <yu-chang.lee@mediatek.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, fan.chen@mediatek.com,
 xiufeng.li@mediatek.com
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 09:39, Krzysztof Kozlowski wrote:
> On 27/03/2024 06:57, yu-chang.lee wrote:
>> Add Smart Multimedia Interface Local Arbiter to mediatek
>> power domain.
>>
>> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
>> ---
>>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> index 8985e2df8a56..228c0dec5253 100644
>> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -125,6 +125,10 @@ $defs:
>>          $ref: /schemas/types.yaml#/definitions/phandle
>>          description: phandle to the device containing the SMI register range.
>>  
>> +     mediatek,larb:
>> +        $ref: /schemas/types.yaml#/definitions/phandle
>> +        description: phandle to the device containing the LARB register range.
> 
> Why do you need it?
> 
> Plus I also see mediatek,larbs and mediatek,larb-id... so now we have
> third one similar.

... and not even tested!

Best regards,
Krzysztof


