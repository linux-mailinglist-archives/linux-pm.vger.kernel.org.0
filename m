Return-Path: <linux-pm+bounces-12547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B0F958235
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8001CB24195
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BED18B496;
	Tue, 20 Aug 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/vnaulM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9F18A6C6
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146154; cv=none; b=SdpTsLHT976UCdGkda0vTNaIr4dPBC3zFsoabanRFbJWDjiM/DnasLq8w3mj5uCetns+xRrDY3W+f+fSI+d6n9RZ3lYHyBKBztLsCnusKag2QVkbN/CqYSS6r1GPDqGC1VyrnnH4No+6fpif5BaHuDCfi6se9n1yS5xQ+QQ2L1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146154; c=relaxed/simple;
	bh=N4WSEdNzQ6tacIiNUGKYQEurx2vHkhh7/5KrzRybMJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4RYbb9vdqLt5dxA81eYucWdDs28TPe34etEowY15Iq+tl52Kz+pxoj3K7bv1r7V749cIuvDiIYgW4E75ZqFcR0a86Bc/uj6D7XYlnwOiAv4leUfnnH8GbwwwHDPYP9LpPt7Nv8M5AfHVm28eoyt72uuzeWtw9F9aLhdldyZqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/vnaulM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e0d18666so41467045e9.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146151; x=1724750951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ivBmOEvLY8+21XD8B+T6OkZ7t7klTY/OPjkKL2J8uTc=;
        b=c/vnaulMkb5Q2WCfTOuNY9VdQP+QJDhHfYC1MesAVm30rjDTMzJuke6fDHXu/P1QM8
         2cUhbeRXEH9LEokBai89qFkOhFcs//SlPmhe88YGbB2G4Q6jLtji84JIrQu/p8zCn9Bl
         HMx8LO9Hl7VP9XN+2to9H4XuAmPMRZgNjf2KOeedKrol5C+TzeoQ+m2IX7UklPIoAYF1
         +6tj0VlJwLOgZ82hHSg4kklfEV9LjtoZJJYbZg8DQe1aKBXKY40oc885Ss+yCPVlaXF8
         mKBEciJkAoPMv4bGmppSsszlXIal6nBddDXY5HcJ3qrWmK23n3ETUxeWbOcDr7IM5wCe
         e2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146151; x=1724750951;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivBmOEvLY8+21XD8B+T6OkZ7t7klTY/OPjkKL2J8uTc=;
        b=O9oOMcgHBYExj5Pwj006QAzjyAAIvnxw7UFjbYcUhlRL2oZpijI6bvtxAFL8oQsqvI
         TR+SSly7C3yt90HrUadZbSdP/Mb78ICIlRhxk88jJEKT9HcN/BgwNRlefndlOqDZ3/u9
         kVcPjB28jkWX54vcNLVWNJ/x5iQjJoC+burlb7sfK40VE9OjvuRn/K6eBIchNfELKdqg
         xUohXH/9Evnl4jC/Eg2xz7coEk96g958D9dVUCYFYzOSm5MXg3JMgeMD9aKcstGL8u5g
         n2TQPDbADrEfFkX8SYRU/uy3ZbGS1m3iZaS1ph0Yw5uP8nAzWh5cnJDcwVoe+zYMc3ep
         vj5g==
X-Forwarded-Encrypted: i=1; AJvYcCVxez7qLlgjTxtu4/iwW7PQQQJ6qmxXT9mU7EnoxyL64MhYwVGzB2oaQxZpYVQZr4BiGKD+QJpc1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqk2qri4LOV0gq2CvMBAP7B/8wGqfUtOzjFl81zZKDFgT8w2I
	etrK60YyuzKwa0XBEKoYo96Xij6zNihqJQENzLB3yHmVwUOaOxwqlyI2QV0Li6c=
X-Google-Smtp-Source: AGHT+IGzHYVgNuPPuklz7BIbEFwfE3SMKsmmxyisrPKTcLAJxvBCk59VCsf/VZQKx+dMghAMJqq6uw==
X-Received: by 2002:adf:a35d:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-371946535f5mr7217989f8f.29.1724146150608;
        Tue, 20 Aug 2024 02:29:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2eesm12661135f8f.19.2024.08.20.02.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:29:10 -0700 (PDT)
Message-ID: <176bcb51-f343-47a8-a5d9-14e76a7a6139@linaro.org>
Date: Tue, 20 Aug 2024 11:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling
 to simplify error paths
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
 <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
 <20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
 <20240819171313.00004677@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240819171313.00004677@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 18:13, Jonathan Cameron wrote:
>>  
>>  	/* Parse SBI specific details from state DT nodes */
>>  	for (i = 1; i < state_count; i++) {
>> @@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
>>  
>>  		pr_debug("sbi-state %#x index %d\n", states[i], i);
>>  	}
>> -	if (i != state_count) {
>> -		ret = -ENODEV;
>> -		goto fail;
>> -	}
>> +	if (i != state_count)
>> +		return -ENODEV;
>>  
>>  	/* Initialize optional data, used for the hierarchical topology. */
>>  	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
> The handling of error ret from here doesn't free the node.
> 
> Bug or something subtle I'm missing?
> 
> If it's a bug, then fixes tag.

Yeah, indeed it is a fix.

Best regards,
Krzysztof


