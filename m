Return-Path: <linux-pm+bounces-20430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C893A10FED
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531AF1888633
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBD1C2DB2;
	Tue, 14 Jan 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axtxMwGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3461662F6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879034; cv=none; b=Uc3YIdlJQj33Z8mHxEnAsj4WBq733R81ZtrJFCxqvozUbONCK+UzRBgrjlzxGWpQgYHTZZCthB5LAsW7ptW+IWkh4afGaiQmblHPwheTYGbVOiD4UPn+Sf7q8+ObmixNqIg7L2QRCRRlpTIC2EKmvnhvJGXNPpSeDBxnD399UTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879034; c=relaxed/simple;
	bh=4SWXiGaQo1HkVH2HUj1yUbURrhz1CjvRMqo5Spc8lcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y+CjxJTuph9Fucqmk9Mq24W+4pl0/mO7M7xbnVn3dBaFu73u1PKeumvZheJS7V8854X14T0y/Dig3cm7WOeRynJqR5J8nWGduJvmk1XtOPMI4ezUyofcmQ978l5z0iTyC9R2cTWZ3IdcIi90+W8fGT4F3X3oWrkJS/ErW7Xl0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axtxMwGe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so7336505e9.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736879031; x=1737483831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUqL9QrhUm9MgALIjYATxNORXILfn/rkRDPpzfOF40I=;
        b=axtxMwGeIQQa475gGV4Lu3K1y6qh5HiyMcnQWKU07vlegZqPzNa7MRnCWNnrs4EM2m
         w/z6cfX72oMzCK89ceubN3ZpCTkBqsJ37SR+WqNafvXMH+CTSi9QQL3A2DxMxaMmENlE
         mzEWYXXEOpd3ICIiUyHLQaJRTB/LttRk+tAbFOsHYpmqHwK0eqSciWsZ+QSwqKqGtmMh
         uyc6XvQSMLCS4b3QPK/1iJnPyjVD/XHrax6R+2JMsepbOm5pgEn8yyCLlOgXBHpTKz5d
         LD5m0t9pfsZvj3FukSxkxzRV3j+NRC4fB/K7TXqjOPh3meMqAy7QVd8oaMEorIOJ9nCJ
         U/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879031; x=1737483831;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUqL9QrhUm9MgALIjYATxNORXILfn/rkRDPpzfOF40I=;
        b=hI9x9tKmhJynpREvs7Y9mAL5nUNQuqoYr4MzqYhNzBSPLm9wlPlhS3rWnMATc1cXBC
         OowTmBSUr4eIUgSrWzL+ale5ABxILgyLs7Q2UU3WzPmrSyMvETnD/ivx/+7PQv9zkfRV
         RAGdfM4Ea18XPgXFlRzbXlAjvj7ktuwlCR6bjOMwDblVBfXtGbB8L8nFVDJu062wawuH
         6QveO239222rRu80XxyFhzIlkxW+AUVIYocNUQth0iXuGipURG7BmPFJpXfgwWapypyw
         3ET/13SAkqJYwsazg3b6HoyPgOL1t3uZjaOw5MB7sfbQcvhCNpj0WXSprjjN8Ei/gCUp
         ifbg==
X-Forwarded-Encrypted: i=1; AJvYcCVPzJRoZ6YeT4Q4sSoSjsUEKWKlv1u1tNqVJpZc3409qu1oCKWS3oTEdgIx+siJNyt1EscS7PR6eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyumL8cJrKUC33p9L6o9OnlXcnJ8elESvgNLulsOJG31lIAXaaf
	hW805QgWgCWJyXe7DhqBIv3l/NOAE+C85KH5z4c+04iAD3bzz39wMlz/LMUv2o0=
X-Gm-Gg: ASbGncv5qVZWtv9AlPKDM+LZKeed7u2V8TI1hwptspGl5ESNC1Ki/johAWHzVKCfR2M
	LVOUY/4ZINJP7bhnO8tJ/pLLkZji8Ih+EPh/Du2CVciM45eS/V1D89FmNqkx60uzb8cTFZ7OrXj
	CktKzcUbXVxnrm3AV4gjSCVC/QdLCWZ/ehu9fH83Ts71jxS6ul4wwLFXbplqcOibjGeIJJsqTON
	5j1o5rGLreLR/kMP7GLsGXGr3GU0L5anMMZ45ISBO2vefkF0IYC6CPwW8UJwf84w6FGfZHXQZDk
X-Google-Smtp-Source: AGHT+IGtIenA3f6iiGnwlD3ARMP6mMv7fFe+fyygz40yBDhc9W3UIiuhWYPynYhF7A00tP/tplnUiA==
X-Received: by 2002:a05:600c:5112:b0:42c:baba:13cb with SMTP id 5b1f17b1804b1-436e267f035mr101854795e9.2.1736879030982;
        Tue, 14 Jan 2025 10:23:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bdc0d8e4bsm6454046f8f.42.2025.01.14.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 10:23:50 -0800 (PST)
Message-ID: <2f263350-a455-45a8-86d3-314b5d7a7e26@linaro.org>
Date: Tue, 14 Jan 2025 19:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Use str_enable_disable-like helpers
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20250114105611.273202-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250114105611.273202-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/01/2025 11:56, Krzysztof Kozlowski wrote:
>  	if (cpufreq_boost_trigger_state(enable)) {
>  		pr_err("%s: Cannot %s BOOST!\n",
> -		       __func__, enable ? "enable" : "disable");
> +		       __func__, str_enable_disable(enable));
>  		return -EINVAL;
>  	}
>  
>  	pr_debug("%s: cpufreq BOOST %s\n",
> -		 __func__, enable ? "enabled" : "disabled");
> +		 __func__, str_enable_disable(enable));
This needs fix - enabled, not enable. V2.

Best regards,
Krzysztof

