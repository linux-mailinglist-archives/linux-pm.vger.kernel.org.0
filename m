Return-Path: <linux-pm+bounces-23974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E5A5EF76
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455C316CDDF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C882620EA;
	Thu, 13 Mar 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZ1WbZmm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808714AD2B
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857750; cv=none; b=GfKd9UfL0Fan3xBDhSjkQV+LdhNBpn45Gj06oN2FCQHMMMR7E9r22RCRagKLrLtEvsGAFmlhcoKHA8Uam/OZ6RJ1sm0b2JWktwnxvZONtNjgJr7UkjitjHXNyTAxKzc1zXF/gKZoyWZY6LMCZTG1Ka6HKZQD35iqZQSA8Iierxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857750; c=relaxed/simple;
	bh=ktoJZcUuNE51foi86M7z0+pzYcNczlKGfxSZor+wLo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWySsv9lHStmc6s4Xf7rCepJSljbElP3E8HljD7GNtbROFEMx63HA3NjRHLQ6JqhsHqTCOyxzHJ9KovJUOgCMSvmzopTItwSFgOTdAZoSZM9LefoFMHhc6FyWhYLbS7NkKFdD/C3c+ky+uIt7gUTrH7zVAI0JJ1UuVFzgXFQEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZ1WbZmm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac30d4ee0f5so7694966b.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741857746; x=1742462546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jXK1DIb5xkIxEbvpqAVoszYcIf/CO7AFtIcHi2IdL/s=;
        b=iZ1WbZmmQ9nbSAOLHS0G/yEO9BNrYB1yEEljTY/fAcclg7+4MmxWgNytlp66kpqfE9
         r3V3Vl5KNxzc0xjCLUQMS8FTBTPzhV7TmQyMn0Y+pE7t4424ctj8J6tXpcn1I9BXzOZV
         fcen8su3Dm/cIq17Q0K88BQCGJ4BxXaxPH6sXndbQUQ3LIXp0FPNxQNX/VHflULfm250
         fvXr2KUmYKN6HmTIu3phrbhbCgn7py4hWMC3rebrWVKrN1t7xkfvPi9lJz3CKZ4vB2Rq
         WXr3TSCKe8O/d6I5iJfOVbwVDxtvUtSrbpH9D+ANL5fY8fFtEcpTDSSlY3FubJWKyP05
         P+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857746; x=1742462546;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXK1DIb5xkIxEbvpqAVoszYcIf/CO7AFtIcHi2IdL/s=;
        b=n7kH2t+BItJuXPAcw+Z/hQj51ywfWrikVI99nGWcDOvBhtkAs0WUG71k1ZQbjMN5Ch
         gRLKrHcRdsysQ+iQFoSvvJOfEW27tTuxdpLfSOexh+kurziX9korcv4iRB19FH46Zk6i
         UhJdjYmkyggKhfJesIdvs2DJPOfk9ycuoXIj+Uq4FVK5ODUrC0Ah6mM1bpsDRa1Xng8+
         WWHp+4ZqM28WhkJF9kWjJNITDE5IGZozX8IEHeb4uowbiUXq7vdAQ7x4dQbDjNgFCozh
         4K9NZvK49AT/yIQwT/uYTJAnFMCEWJQmfbOi6N2v6ham1vLv7QMMnVdzpLnEjHQe6WHc
         VIyg==
X-Forwarded-Encrypted: i=1; AJvYcCVjEK3fQu14DE6/jdx0dBnIl7dLG0y1ELmUWwNkAO74wqRR3zIFbX/Wo8DVHiGMZgwEkS6iQ4Nu/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6qR0XbxwZcsYGDSJ8j7nWRS8L/1yDwpfyFJ6pjoE22pF9Hav
	eQ3IL4pjOjyR0+NQqhN0c94PWOt871bX/mLJsl6Gj/bMY8HX3JuPSkTAaXLW0DM=
X-Gm-Gg: ASbGncuMx3mVXXcfNwEvhA+0WQiWfCUkG4/c3XCogTtaaQJ+yYbGJYtH6tzSWQRVHax
	6fzkgvMl22q4Xf4JGAesVQnKiKF7Z9D707El08AaPlawlUer07411YlkCpzX91kuX440clksFD5
	+hpU9j3VOX6YdiB7E5f+SvO93sI3UHuRQk6tIBBHqHKJMu0azU4ASVzrS7EHQmYYcHWZTt4MZnT
	bApEYaqOQzDjjXiRNlMvb1rtYLSkaNrSFjN7tYJmvLtmKCtMg1oANCzgtQm5lbSypAsyjXLiD8+
	f9LmflxmALbI9RPKvmyCE7o047BFK7LZhDsDO4RlPBPJQ96DIYRL5UwDix6tlAw=
X-Google-Smtp-Source: AGHT+IHRTaoYuJcMTzihYUuSgWV28l4o4//3Oshe32dYNy+k2nhv/+45RjGWtzerBd3yTG91JCT1ig==
X-Received: by 2002:a17:907:2ce1:b0:ac2:4e22:e31e with SMTP id a640c23a62f3a-ac2713ebd5bmr1013462566b.7.1741857746390;
        Thu, 13 Mar 2025 02:22:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0e4esm57785266b.72.2025.03.13.02.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:22:25 -0700 (PDT)
Message-ID: <34de7c89-3862-44bf-9680-1ea62a4cd8b1@linaro.org>
Date: Thu, 13 Mar 2025 10:22:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: MAINTAINERS: Drop Len Brown
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
References: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2025 10:14, Krzysztof Kozlowski wrote:
> Emails to Len Brown bounce with:
> 
> "If it is importnat that I see your e-mail, please let me know via
> instant message."

I shortened to relevant parts, but full responder is:

"If it is importnat that I see your e-mail, please let me know via
instant message.

I'm sorry, but I have to recognize the reality that I frequently receive
much more e-mail than I can possibly have time to read."

and with that last part I sympathize fully. I also have too many emails.

Best regards,
Krzysztof

