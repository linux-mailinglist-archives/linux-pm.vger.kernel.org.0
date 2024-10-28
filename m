Return-Path: <linux-pm+bounces-16604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF39B36DE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A484D1C21C09
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F661DED5B;
	Mon, 28 Oct 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nes21o4g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C88186E27
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133783; cv=none; b=CuosNIHZU6X+DUBiQDGp6AiSLYkebAk/Ft/GEfSM8QMXpgL68UpkxWYRpSES8kLhSNhxCDNCP+fQUuMKyFmVrV/UzqAnjukP4ZB2ZoHquu713com53RwLidE8jFFKqkqQwOszRzbk5WjRmdQ3bsJU6+YlqefCmFQDPDAUEdyf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133783; c=relaxed/simple;
	bh=S9uDLqURc4GOloYqd9jMMosEJtFBODWkzZ32p3r1fQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIqGYYRoZsTVKhuT1s9jbsc6xaCbUmzM8eZ+B5neGirrfUDs22TkQ7o+ezyfEYIowI+85zvhiA1G6qb9nXPx7Am6WWkwLtFRO9zARTzusjdd/59ogllZldZacSPI4264p6ugUKv/qt9Pf1qiS9j4/3zyTDYnAX7Vcs10YVpXKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nes21o4g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so45682085e9.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730133779; x=1730738579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIlV2N08KcymoaFKtsfUV9P6s6ll957h+IdgsPENuPQ=;
        b=nes21o4gJVp0T6rXv1uAG4Tfjsdi1Qmi18lmaAT1wfkRkp0TyRQk47dmKdTdv+aaXz
         OW/P1KzQ9+wvmtfjTc4MPyRMkVTXFf5C7pkmlPp2Aq13dFzfg8JaUOjJfHk1zTETkPXi
         Csk2dlBvMz/mnOFzVZYqMObERiTw/JIIp9r/cavPPxlB7Ueon0DsdnRysqccno5/ZgOO
         imqXcjevCGNQ7EqMSDuAFdoKyxohgGKdVaIJC0ul/goo2XLZZuEnElOgh2nq3yLDpRap
         OtihGBj4SkKqdKkdLzx0Nly+xpVIiEQzOhjOn9s6Yeg03LfpJDWV5IfeFOueEHtS1wLx
         S6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133779; x=1730738579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIlV2N08KcymoaFKtsfUV9P6s6ll957h+IdgsPENuPQ=;
        b=kxLB7w3zJsAG9cGG2aC0/2H64+SvHdnTa+ZBGaIk0f8rlVpnrR6ncKwqXEZ5z8Tsn/
         F2eCSUKRZkNuQDX1greWSRmzfglu9AkGugc7DvSQ82EG/otZZScumcqOtxapibZ2l6Qy
         5JwVghEj7mG4gXA0bm1v5x5DsQT4EFh6E/NnQ7bA5J8yXtq62iscsCqOYnaAamkMAJt5
         9CTl+xBkd3nQXcGitadSZ/RF9m6Eh4YirsWsrQxwVZ4/uV/icPHL+gErtlGLXE8gtUuu
         LO9N9+d8nR8/nOPA491ne8VedMTnptnPzmBKm1akiotFD/8vZHT2hgpMGzK8aAwfg59A
         WloA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZ70t1jcm0Y667/H9XxwSFLDAAGXzgi2KJ4Mkroup05MIpsEye6q9GI2bpDguclePxaYL2bp4gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Sam0Kb1tDgvxpoQOaM4JaLNT3hdzEQXhmuEoL2ZGFQqqv8Cx
	eA6yuqp+sNBrybDDrkeVuwzniuCTQncFoOGI+N04wclr4Iegcl7iBJUAL646HJU=
X-Google-Smtp-Source: AGHT+IFubNfmbzdMvEDWhZwdQWZg64Ts8Y29+5XLDl8PxLLPf7L/mVmSd01Kf+suARM9Crh/4qXL9A==
X-Received: by 2002:a05:600c:46c8:b0:431:4f5e:1f61 with SMTP id 5b1f17b1804b1-4319acb01ccmr82163395e9.14.1730133779156;
        Mon, 28 Oct 2024 09:42:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b55f719sm144090375e9.15.2024.10.28.09.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:42:58 -0700 (PDT)
Message-ID: <72487251-dfcc-4a37-a19c-c4f7f8cb2786@linaro.org>
Date: Mon, 28 Oct 2024 17:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/10/2024 18:34, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/thermalto use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> On the way make a few whitespace changes to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

