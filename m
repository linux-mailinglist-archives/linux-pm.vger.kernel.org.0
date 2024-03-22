Return-Path: <linux-pm+bounces-5212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F0886663
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 06:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B03CB22237
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A278C1F;
	Fri, 22 Mar 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqtN94WJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1BBA39
	for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2024 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086339; cv=none; b=EtOldkAyn7jd2rv9t8mSUv1sqlz2AMs967ZczG7d65k/XmO4Z3/IKRq5+RFifCi/aOGMcVrGEgapeZwjZnzM1GX8yiUBseL0WczZunTBA/g/fg7lbzFkVQAN62A1fqXBeyLrW1VtGFaH2BRzzJBWfXZ81TT2wqepGmhVmpXXvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086339; c=relaxed/simple;
	bh=m+xtxXrjwcetnFQbzF9BIF47u1pNPnKMbu4D+kyqqkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTudCgp01LVVnoKr8tdnlwg98XkbYUJQulIWQgN/7E+8DLSl042AJvxum4djdSG1s2AznuW6hl0a97wzGR9wgkz2vm93O8aDBAloQxbH+vqSXvWd1dz3AzvOZGWwfYgcvz2G3NOly0uTl1ppEXVhKo0uHoO1ORYGvvJJpBjKRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqtN94WJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3417a3151c4so1341525f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 22:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711086336; x=1711691136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MkFAmC+2FK4ht3eTsZWzjqwcgcYA/tAPnTXmCidIbM4=;
        b=aqtN94WJkgZa16Klhyj86sGvFzw6J7NI4ZbB2A0yqO7RLmdlS7Zwj4hubjUOCPSmPk
         ACE8Vdwa2R8oUsQlZRj1N/Gxe2Kt51nyI9NBrjjoHGrl1NfDfegrQ+9w5Bavir1q1Vdp
         YD6Bfqm5cK0Qr0kBgGmyAGiJui5JjAgdk0DiYChis0UiJkkuYNa3x5XBf9+gDjcvE8FI
         YXERXnXg+ZrlRYhdvJxdEgdVktaauHsS612RqSrMvdZ/DCoK63ZTE2lkzPQRhK1bbRY0
         UOLpgLEym3y7q2TUsTN6aZOvQ40Ukao/pAFBSXs3G1Yf4vzYGdkz8qYO9GEt46XTV2xk
         Yx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086336; x=1711691136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkFAmC+2FK4ht3eTsZWzjqwcgcYA/tAPnTXmCidIbM4=;
        b=KOH9TQa8yEfdgP7XRk9N/Ba3zcMtFOZ8N/nbKSk61jScOe90PeC+/ZeH/caKoxxulZ
         zSjbt8789CuTnkWVtMbRjPNhIS7nu9kNL+PBQTyjA31oWl+5hP0I/ysKFLbDuZP+MPNO
         bhlkC3mBfado6Ab1wh0UwidrlvKP9XnkcB8tqJnyFMJVYZmdzAMpFJdGrVxdE6tpBBT0
         BQQukDMRSdP2hE3orSP+DZgh2shVL5koPFDZuNr4W2nfCPc8FjAQulonEZOmbau2nb5F
         5qHh0yatO4NV0S8ymKU0b2Uu2GRfEwl5L8OexlkJR4ow0MSOcrI3BdzDVzyNN+nnOTqf
         C7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUkJerbEkFPq6VyyiCb8ki/CUYOrf/YSJpMRUTYfJ8qWezraBNESDyOSi45CK6MCpw6R46GLGrpxf8DtmkVfvnPMzPuuCH7Sos=
X-Gm-Message-State: AOJu0Yx2soB04bFVh19kANE9YD/VlC9OlJxcXaXSnEY8gi7hbQtcBNst
	KcNKim/kAw99r38odn4Vcx0syUqAhstj9xnJknrQkPn1WZ2u1VxPtkax2YcKlnE=
X-Google-Smtp-Source: AGHT+IG09f3nMQjPFTGhbvqw1bkRjjmxyDkfTjJR7qm/soiCrhTRjHLcsz6KrpBAj99xkB25s4o3Ww==
X-Received: by 2002:adf:ec8f:0:b0:33e:cf4d:c583 with SMTP id z15-20020adfec8f000000b0033ecf4dc583mr892321wrn.16.1711086335711;
        Thu, 21 Mar 2024 22:45:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a46cc25b550sm639326eja.5.2024.03.21.22.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 22:45:35 -0700 (PDT)
Message-ID: <abd29b47-a8ab-4e2a-8147-d5d8ded98065@linaro.org>
Date: Fri, 22 Mar 2024 06:45:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, djakov@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-3-quic_varada@quicinc.com>
 <4079ddcf-425d-4194-93b8-ee113864541e@linaro.org>
 <ZfwEMUBdlQHYz/+h@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZfwEMUBdlQHYz/+h@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 10:56, Varadarajan Narayanan wrote:
> On Thu, Mar 21, 2024 at 08:25:15AM +0100, Krzysztof Kozlowski wrote:
>> On 21/03/2024 05:31, Varadarajan Narayanan wrote:
>>> Unlike MSM platforms that manage NoC related clocks and scaling
>>> from RPM, IPQ SoCs dont involve RPM in managing NoC related
>>> clocks and there is no NoC scaling.
>>
>> If these are clocks, expose them as clocks, not as interconnects.
> 
> Earlier IPQ9574 PCIe patches were NAK-ed when these were exposed
> as clocks. Please refer to the following discussions
> 
> https://lore.kernel.org/linux-arm-msm/CAA8EJpq0uawrOBHA8XHygEpGYF--HyxJWxKG44iiFdAZZz7O2w@mail.gmail.com/
> https://lore.kernel.org/linux-arm-msm/CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com/
> 
> Dmitry had said
> 	<quote>
> 	I'd kindly suggest implementing the NoC attachment
> 	properly. In the end, other Qualcomm platforms use ICC
> 	drivers, so by following this pattern we will have more
> 	common code paths.
> 	</quote>
> 
> Hence posted these patches to get feedback.

Then explain the rationale in commit msg.

Best regards,
Krzysztof


