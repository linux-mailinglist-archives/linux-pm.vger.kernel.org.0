Return-Path: <linux-pm+bounces-25613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27CA915D4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FAB4408B0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11422331B;
	Thu, 17 Apr 2025 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2LOoIeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EE221F3C
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876554; cv=none; b=m/aP6HsQ9vveVMfs+rhYdaB78efi082Pfy0V1TpGFlFeznMD2pj/FVuHOH3yoRIsY/SBCEVhlZtRt6uNwyTVGsBlUb+myR2E++aOEm+lwQxtT22b5wdj9KmKR+8AAOyo/98uXuWQwIuJ5BBjWNWnE3nkDmd4m/8ZYnpF+vMDLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876554; c=relaxed/simple;
	bh=e6mFxcB2v21c4S506XttT3JLcoSFRJDd1JrtFUAPIc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG8QLZ9XQ+UvvSw3iOt3FaI2f2zL8lhZdJL+6sMbCA+cRDJd1NSyd9aJ4DLbyucTs727tWrl0arNw/4z1ufK73UgF7UhBT6BBazA1fuuJla2l/KM0+9TqrzvMt+vO68Y0GWg4eC9yIEbzPA90jR/Z/BSEAUdLbZVy+BT5QZ3RFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2LOoIeM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39127effa72so77672f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744876551; x=1745481351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iYBp8bXwTSPvop/uN9QKUwhG4aPmw7LiXiOg4yRVMEY=;
        b=E2LOoIeM1XVb+o2WvWGmofV+EGtd+0Ya53O6OIVI7QolZe40W1nG7pMrt4QsiNGP8m
         h2+Z/IMt5K9cFmQEJrtF4PmLCWXQ0WJhoC1pKLegJ4xrpqnIjha14I5dIOQ+6I7FtyRr
         /kUrCdaJNU795SFHqefnNuEV8XCjQ77xtqZ89nmjck49hiiAzRfNlGhyDunoWqh7HN9c
         00fY+VBRBTEnpCs3wSjOp5AbYL4bPCL8Z0zHFxTeZbY2O8PcZjFAiA4KUXxLNAHICYpj
         RcQkND01aMrEo/JLGtdQrwX8BRlwGwcJA/CHREIjUZO/V6uFZVtedIyCROUaU64ZDnrg
         N7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876551; x=1745481351;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYBp8bXwTSPvop/uN9QKUwhG4aPmw7LiXiOg4yRVMEY=;
        b=scJYjIxMvngSLqN/TiOFifCxcwQO7lokgwe9SxXesY96MoY1nrtv09mfSYLCJqhiRz
         J+T4WtRjPjpUAt8rQmF/aWxbmmPrm+TbU0zA+NCSs70deMu6TKdPFG7ZebgpHD52DdKU
         VgF1tJeEL8yVf+NvrWzltYkp3+NQQ7u1fzClMdRMzHYByzKXu0f9Fl8yOwAbLQ0157Ds
         TM6A0OEHTzeH0sulBzOd+xBYHQ8cLXPNu44c9b3aQpg3KCKR64eu/EdvT+lVggtH1bUc
         SspxUzZC5tjjDHanbkvy/CAApxmGzUneAZYs/Tl/ZWWKEry1uDTOTZWwr3LMdU/fQwO9
         zxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2cmTbK/PNGWX607v33BrYqsz/RHR/3k51W8jqYUvCMHYtmDky41nwzpwjXoHxkRnhCQBx3hoAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGUlShRcO/HKxi0iN+5wEiF8pQeBQKEAaZXZB91i+al1F/gXR
	ER3XEL1ylMwrRf53ZUDGKZ/pKBkWBFK9g/RO4h5q2rotgnMJ5yjuAWxBPSn/KcnSCyhf3lusMFt
	n
X-Gm-Gg: ASbGncvyOw9LvepLmlk+ymJ3lIKEIAnJVDZ6Pbf+JmsOQNKDMgr5vt+6P4PugqqVm/p
	QLDCIWZ0M7vl1YlthLqrYPpmbKMT/JUFI1d6LSddUHYGkerjSISVj0J+YP+XVLktcdOEdew+XK1
	DMApnkEt0X78CFuC1H2Wtm9hKPegcGGn95hU/AHa1W0SVOCiYHUFRZzz75MAubLq00uSCqjqTAp
	b9yDEZ1Q3XPtxKAHIzRzKw8d4XMLnwq7gZB0mxIfjUzrM67WPX4VabRrTd4K1GPh8Egr42hHMqZ
	maTgm5eaqUlXnxqUP+/gBOUKv9AXpIo0NCGJrAijNHY/I7YYpuYiKuW31pJIajMiILFcghuNP2f
	rnYZVW8IT1PV0pxKF
X-Google-Smtp-Source: AGHT+IEmso3cvRkXN4G0w7P3zUeOJ/AYGl3CfSoHEUSAeWv2i/wwasHzOdYuG2WhGIQmSBdmKfYRGg==
X-Received: by 2002:a5d:584a:0:b0:39a:be16:9f1e with SMTP id ffacd0b85a97d-39ee8fd638cmr693229f8f.12.1744876551057;
        Thu, 17 Apr 2025 00:55:51 -0700 (PDT)
Received: from [192.168.0.101] (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b58cc4csm44522675e9.25.2025.04.17.00.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:55:50 -0700 (PDT)
Message-ID: <36939c30-3cbb-43cb-aacd-aeb7b1f6973e@linaro.org>
Date: Thu, 17 Apr 2025 09:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: fix compile-test defaults
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250417065535.21358-1-johan+linaro@kernel.org>
 <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>
 <aACsQUADxYHTQDi1@hovoldconsulting.com>
 <f957e366-51e1-4447-982c-93374d0fde2e@linaro.org>
 <aACxzWi4KqDdylfj@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aACxzWi4KqDdylfj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2025 09:46, Johan Hovold wrote:
> On Thu, Apr 17, 2025 at 09:28:43AM +0200, Krzysztof Kozlowski wrote:
>> On 17/04/2025 09:22, Johan Hovold wrote:
> 
>>>>> Fix the default values for drivers that can be compile tested and that
>>>>> should be enabled by default when not compile testing.
>>>>>
>>>>> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
>>>>
>>>>
>>>>> Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
>>>>
>>>> That's not correct tag - it introduced no new issues, did not make
>>>> things worse, so nothing to fix there, if I understand correctly.
>>>
>>> Fair enough, I could have used dependency notation for this one.
>>>
>>> Let me do that in v3.
>>
>> OK. I have doubts that this should be marked as a fix in the first place
>> - even skipping my commit. Some (several?) people were always
>> considering COMPILE_TEST as enable everything, thus for them this was
>> the intention, even if it causes such S3C64xx cpufreq warnings:
>>
>> https://lore.kernel.org/all/8b6ede05-281a-4fb1-bcdc-457e6f2610ff@roeck-us.net/
> 
> Sounds like you, me and Arnd and least have the same understanding of
> how COMPILE_TEST should work.

Yes. It does not make it necessarily a bug (It's not a bug, it's a
feature). Anyway, I don't mind so up to you folks.

Best regards,
Krzysztof

