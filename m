Return-Path: <linux-pm+bounces-38307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8EC749C0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EB304E9509
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703F23CEF9;
	Thu, 20 Nov 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwL7wWdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873223B605
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649187; cv=none; b=GJEkKNO5D5VAuzO9uL9SYxookB+PQoAmT4Im9x2tBqEdkgaqIDkk8xLcuUlrQBTE07Sv7V/dtR5djhlQJWnhbCdlrgP+0HlTa5rKQnUj+eUcC54wy6wncMqCzwgC/GuE/ZOOlo7KMK99RMnhihBeqzew5euZn+GtmQZMLyTGoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649187; c=relaxed/simple;
	bh=g94W2Q/Kh6Xh7xJQTHuKAVhkV024rb3AUOYTPf2JMdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j00AVJgdufNqLG6d1Wg0sI9Ae74XbCTsCQHp6zTVjfYv315RYw+qihdllDfB4P3V9KeWzJ5HJaGqBE1hpKQcTijGHwzUveQzlo/usMk7rBwzJzDcBLcb80iTuo5KI+Mjsgp28Dii6N1HYxeljWcLct7I2uidKa92X95Pv3Hdzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwL7wWdI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso9543835e9.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763649184; x=1764253984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjRZENQ+4nAVbqIuxdQaWCBPLWKLGcvWPo37O81CXX0=;
        b=rwL7wWdIeGJ/bWutTMbSJYCelDrPrMNqMljH5M3WJzYd7pwQVd4LBKlB1pit4MyEJs
         i8xVAfhepbECjsvhK/cQefgx/UDSLC0Cem3WZ30Ijt9fOZ9RyjibHMAiXNSmqdUU/Cul
         ctQcgBcwjiTvWe95Ec7KGsuZ67pQxQG+WGEhJmHCSO2EMK8aItWJ+v4VyooeWNVLfYeP
         dNc8AXGw1FvHw73RnckLNufcelH9ei3Vc1iTyoLabANTFD78itLxzTt0S/UAKg6d9Rqc
         Y/ybG6gLC4KEzVxGBQmWQCAsQZG8d6QAJFxgxOIsKB8NneelfJSZs6ap8v8eb+mf0GFb
         bLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649184; x=1764253984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjRZENQ+4nAVbqIuxdQaWCBPLWKLGcvWPo37O81CXX0=;
        b=D9q67YSDn+mBd4hquARVYKM63Z/2Lxn6huU4Xcu4dXbEAL8RCFYcuGW5FJaYuDk9IU
         EFUDDh8uoZEO9HtbrtOz2XBRt4i/zHHLK8ySTUElrijbHohgeCi9QWY+PRm7hZKZMtB/
         L994Eb/yHtfJErKH0/KAOyDESi5kYUbzrcVzJgZGQ0qM5kFhmZs0Itg89J11WD8BJWho
         4K9XvfMyn3ntz4GHi84D6dsDRkQ6w+eM9Ejbc7KI1FCAlr3dYGClrGFow3vj66NYr35Q
         q9JI21hVYr8Zs692HrKhl+TNcT8vBWIgT9lH6WW9eMQ48icZWvk78MkzDtFxX/zt0bxr
         TACw==
X-Forwarded-Encrypted: i=1; AJvYcCXFcmOyQmGC25jN0QnvLlexR6yAY9rv5bDW/9RQgcc1Ei5hRabhy57dpajGi0LoEzh+/PN3KNbV0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZFKJCaB1DZnu8nCwDMlLLZ9HspZnGSS3fT4aXh8wK4DeyDpe
	9omLo5CD55Zsvg9GUwNrEQQQly5RuVOT8i1cNm9m6gENbq2qlf+uD1beXx3pqnF7XGE=
X-Gm-Gg: ASbGncs2Pa2r3PZrescIxDqDBWOV6zHkrG+vD5db56zzOxshrAQLE4nP2IQhvJmXv1P
	FitodCd2RchfF2x1R0TbSLYueQeUEsXFFW6awmfHp684gAtXBpko+W8HW3A5c4fBHZmM/Bh4/+T
	RMs2KsyMlIyTelRvOJPjBGPEJ6Kj8MwfHog7Oe4RASY65wNcjUD2gWBnqbZJuNiGYttfWQd40up
	NDUOPi2WiEjQXJ+72WHD/B7hTSJltGoEVRW7doAII1QzIpp1IYSkxCcVTsy5ROJqKHMgLBXjHn7
	17cF/Nlp98jFhlgtN70ETfsgczitwsEU2SrNT3opspd9iPvefiYnCIaC6veO/GmN1YvmaOe8uLg
	GcIHmodwjyaxJ8RK4EUrpo6+CHo/DkSuc9ze/MVQc9YDKneoh259JRolczYxu4rSt1GPWZnwP8g
	hfmBaQhnaltWz3kCsA+hIQ/NauMnFsHoaB2meIS4aVwyWvuKvu8vS1v/7aLU2iJgJizA==
X-Google-Smtp-Source: AGHT+IFrm7f3D4ZpMOXc9Qkx58CciFrYbEpo9cBF72r6dlhpL8LKHFoMnR3Nqr9ZhUCz2EUoKnZBLQ==
X-Received: by 2002:a05:600c:46cb:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-477b9dc06d4mr31332835e9.7.1763649183596;
        Thu, 20 Nov 2025 06:33:03 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477a96a58c5sm68949695e9.0.2025.11.20.06.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:33:03 -0800 (PST)
Message-ID: <c9166508-88ce-471b-95f1-65a6bd5152b3@linaro.org>
Date: Thu, 20 Nov 2025 15:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <ee03ec71d10fd589e7458fa1b0ada3d3c19dbb54.1763117351.git.geert+renesas@glider.be>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ee03ec71d10fd589e7458fa1b0ada3d3c19dbb54.1763117351.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 11:50, Geert Uytterhoeven wrote:
> Convert the Renesas R-Car thermal driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> check for CONFIG_PM_SLEEP, and reduces kernel size in case CONFIG_PM or
> CONFIG_PM_SLEEP is disabled, while increasing build coverage.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

