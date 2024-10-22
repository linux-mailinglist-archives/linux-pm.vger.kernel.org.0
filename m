Return-Path: <linux-pm+bounces-16228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83649AB1DA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326ABB217B3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8D1A2C29;
	Tue, 22 Oct 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFC7M17f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45A19C547
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610361; cv=none; b=g2Wz6zDAPeB/HKZCoNW8YK/2f48uOQ6tj7pjFesLTlwf5fpimn5HXcrdi0PZWLW5dxDmipNMTyVPrZaujoziJr+q13Stid9qPweyIoJLHxY/+ABdbHkUsc/45tteLhR1/6vtVQdyJN619MGvPjl9Ghwc39iwyIW6HQzp57Cr3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610361; c=relaxed/simple;
	bh=QzvuJn0s1kTTw5tzBhbJ7khuhCfuw386kCmtx0JL0dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=WQ1ErOHjuSmOAjRkO8ShfKcEb+8nLebjQh2W2DFRQi6oSWofTZol0yCq4RgnAb65OJ44Tm+NCaj0PdyTbH9CwxSlXFpcYOP7DckJRz8xKY16ydZJLZJc9I5hcQfnf1KWvgAW8my/uli6BNamm0XqX+EhQYOWzeILeYtMvp+/t8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFC7M17f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so906960a12.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729610358; x=1730215158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHk83XdJqpp+kMg0Xa8M6xJC2TZ2L4+OXertTWs8y+4=;
        b=rFC7M17fbrWTnEOpru1xpTzWmSmp59/AdIEen8it9MJsKwXr43ASYxs7wY/hhFXXc+
         Bciuy9DE2yrcG7SxB20wCZfEyohV6XBxexc3P31di1E6j3DqfoLOHWXimbQNcKF4+u77
         NiaEnfMqD+mbH9sSbivR53fN/e8cJu5fYT2SzeRNVeqtVtnvhYCKVorkWNe9w1w0HGMn
         1lQuBVKl8HcEcZSmPlyoXu+pH2PSrXvN6NsMn3N6G4qMSarhCLhnUrVarRaD8HzZoMT/
         zZ7AD4PqI8A0rLOVEGkbKCEcX2Q4Bl8I06zWDUaxPtIGFtpz36rjDt2TP+yKQqJ0UgIs
         Kl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610358; x=1730215158;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHk83XdJqpp+kMg0Xa8M6xJC2TZ2L4+OXertTWs8y+4=;
        b=lbBl5XVOBdbdpyJOeWofHyubOVnKqsj08iw7DDe6v9x45jVCr5QT1atCf34i0QBTCL
         CgbgCdfm6ZeLIA+TodPClrCYxWjHCw4/f7KRtDNUVJYO8RfIr+jG/Pj9uc37wTgOezAu
         pUNcLMIjlhUvBrdJU3alup6fBDlGC+PtV0L7Wi7pKNHzZlmqAgnxgaPgLcLYphkX6XwZ
         rt3Tf1/KAfSMI9WMw4qxGr2quikF0jMCZax+KCozLEPaHjZvYA1KKmHYpF7tFmnJlkP7
         iEEhERrnZXjYhLcl1dEvs4TWlAmskN/jiZyPaBCg+0tllzKHV531ibX36tMmuICsl3rK
         ci3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+vC5Pe73wPdg40p9Zqhe80gBRTbJ9Zt6cK78RLLvNJ1KO7V9MlT1g1O7XWXNeKk+BlSEeCqXxsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbXMoOsggzf0qFXlgfMamCglsrTknni+B0gUBHSOfSzHFcbef
	4HKxho0tQ1Qmhj6R44xLmU6QkY8TUkFYgf7Wt2Tu18lwAPUhI8BRBdQJShee84S7KGCCGZlVfjA
	q
X-Google-Smtp-Source: AGHT+IE4gz0g5zTuDXzoO13kjQie03jzxkk8PGBN2tXsNf6/M39hcnJGF/C0FhTs8xmYWFxRleF3qw==
X-Received: by 2002:a17:906:4113:b0:a9a:7f84:9408 with SMTP id a640c23a62f3a-a9a7f849ed7mr487814366b.3.1729610357590;
        Tue, 22 Oct 2024 08:19:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d65adsm354475366b.27.2024.10.22.08.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:19:16 -0700 (PDT)
Message-ID: <30697312-010e-4ed8-9d17-9076b61e6d9e@linaro.org>
Date: Tue, 22 Oct 2024 17:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: msm8937: constify pointer to
 qcom_icc_node
To: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905151636.280065-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240905151636.280065-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 17:16, Krzysztof Kozlowski wrote:
> Pointers to struct qcom_icc_node are const.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This was sent 1.5 months ago. Any comments on it? Can it be applied?

Best regards,
Krzysztof


