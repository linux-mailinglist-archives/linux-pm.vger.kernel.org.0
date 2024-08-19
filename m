Return-Path: <linux-pm+bounces-12426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF8C956BF0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B21A1C2364A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12716B396;
	Mon, 19 Aug 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDk/K3A4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A516C857
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073778; cv=none; b=LGKZo78yoUMjG0aOL4wCy7CIyHyotQXFm/3sZSg5uldAovG0m+l1ZXi/gIUGmzauRvv1G9igqbdQAcDex8gwFRCmwXDXDuKwCraxkRDG8fVpaQjmro548hXwAQXoK8iMqi5K8OSYqLj4mZZe8Ib1SMelxep6vQ5uSV7+7DmhHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073778; c=relaxed/simple;
	bh=O2MwCfLhtuz3WtZXy/MYatQ0Sno9ksR85Gi+1RqITFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWXtz27PDvD7WhFgTNUzlVZ0Q1xs07mAuP/42yspu1N54FhSndF6Lg6w7Mp+vFAsVFLL+0EYhdKAk7vZ7liSAbvE+imYKpaPjJr0YP3I4PLtzRWFRUgkiCdju5KmZeUoTlJBPasoLNR7IvcB87Y5oMjMmimSKdBsLQULXec6Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDk/K3A4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928fso47739465e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724073775; x=1724678575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuyNk5fVdyh6epV9U4Iq9p9Lvv3ALtYfwMJQqqgo6Yk=;
        b=yDk/K3A4AZrayhh2VHwN98Zfi9uulq1lRuePuwUVBT92asa1xO/LJXdVWkOy9XUVle
         g39Tn/s6mXGRNHIgV6hVoLJOBiHkg16ApaSQEi55x2bg/qAwCmcW9UWHzTi1oiS3gppc
         HUJominY65l9ehZBFDkXuU9UrEDisBKLAs6A95KOerXO9MVVG0UxchEyGawsd95SsubL
         v4ho8UremKnbYINTxJmtFjreqmrgvcqlCeHqrEbGrPG/rH2uSolLVE67ac+FnxV7jOlX
         VQ3fvoEwa/x65Zp0OOX+ht4pQL7Sh2DEXlDUGBbH8ZOGFxAuwOvVt+tpbjY3izEkIXtH
         9QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073775; x=1724678575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuyNk5fVdyh6epV9U4Iq9p9Lvv3ALtYfwMJQqqgo6Yk=;
        b=FNIFByMNmXpJ1L+vNxpaa9iS0e1DP9MMyEHu9V1w2neMBWcu7lwg7qrBYdjYFEGQU9
         oz/F6v0Zae446Ty9xu1TcELOvmlEs3He7YrVBFH30ljr+gPS4F00igyA3B0LKoYwRznb
         seLEYLkU1ozCZaJIRZls2JK3J05DDvV76ImUmsayIR5oqOzdZfZR0WRr+VgNWrCkfCzS
         VCQ4kvFRtlJ6Nsfu2q3IQimwAfojuri0xgp273CgwU0w+tGuMdqDtTJCiiULPBkaci3n
         tMPZqoAIXHVgapTE4+mp4X4SHBxcCihQAygzUV/GSJm+umjsGE4e+z5nbkZNtoa1yCqz
         mnpA==
X-Forwarded-Encrypted: i=1; AJvYcCXpqy/Mt9YsW4yiNGE478vjADYTkSWgKQiBQlqg/6+0KR5p72xOJXAF0y7pvtVba1qcv6EI/naFLjQvhEKjar3x8S4ItIqKIMU=
X-Gm-Message-State: AOJu0Yy+SXLRieGMoUoQVLoTOBScpwMZVFSvQUV0vVUcJzyf2VxVgvUP
	vTiqQJHjlY9LevOEDufILBJlFCGKQghxAStqPWFM25wRZA1S/aSjjmO04aSdmwA=
X-Google-Smtp-Source: AGHT+IEPz54Ns7DkJpUWWgC/R1C4JWEbFnoSanERwA9Q7te9U+I6z6L41rY0uwvrgLlKgxD0fLi0cg==
X-Received: by 2002:a05:600c:4753:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-429ed7ed62fmr88977775e9.32.1724073774440;
        Mon, 19 Aug 2024 06:22:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a6d1sm10654962f8f.57.2024.08.19.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:22:53 -0700 (PDT)
Message-ID: <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org>
Date: Mon, 19 Aug 2024 15:22:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
 <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 15:20, Rafael J. Wysocki wrote:
> On Mon, Aug 19, 2024 at 12:12 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
>>> Terminating for_each_child_of_node() loop requires dropping OF node
>>> reference, so bailing out after thermal_of_populate_trip() error misses
>>> this.  Solve the OF node reference leak with scoped
>>> for_each_child_of_node_scoped().
>>>
>>> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> Applied, thanks for the fixes
> 
> Is there a place from which I can pull these?
> 
> It would be good to include them into 6.11 as they are -stable material.
> 
> Alternatively, I can pick them up from the list.

I'll send a PR for fixes only. Let me double check if there are other 
fixes to go along with those

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

