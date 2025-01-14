Return-Path: <linux-pm+bounces-20406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45151A105F9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B377A3009
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20160229611;
	Tue, 14 Jan 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0BU05vq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AC234D03
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855688; cv=none; b=NNuuSc9mZ2acN5EjNY9Pf3TBxK5H2Xb48S/1VNxVuRT8Wit72FMXaB1sOUSAiBvwdeQ/jirnyAaeeDF1tXY0duPR5E1t2KLCHAEgHSdkBLJgqjiS8tvqZmEP2kIZYKhBlvT2rHO0JpMLEdWOpNyFgaDAYFFVJ1ccmtTKYOQUZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855688; c=relaxed/simple;
	bh=fEDej9nAUZIT3iZUHPHO5YoBQzGTiWDJOevOdtjt7NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC3Z6+uJmhr2EtFTzOJka/H7uN0k1w+CfeeI9GJ2D3I10Wv0H3KcGyVfSpZKxApa7kbhfR4VzIWefHegUYW3FqmHlmExbblQeVYCVzLcDOvgMm+oduqTfAoJZf8VUv+bjMbyWyOQEaK46a18djXm9tt70rCGT3SSsbMhwqw8UT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0BU05vq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436345cc17bso38574295e9.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 03:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736855684; x=1737460484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbJZNH3I2kHSJ3p3lZHpAuzG4uICLJvj/AiJ0Ww5yMA=;
        b=r0BU05vq0UG9S/cKonr0ojd4GQYt9tp1ihp6z/PQXI15eL2WJ15jbGzuQ1IzmpWmf9
         Nj2geYIoKgLpJKO2BLpYep4OU6uP80jMEiioLLRkJWuKiGPO9M1E/nVsj4d3RVn0CRR4
         XcHs9qS5kZFdaAzzN/hmeAfpiue/wW6caDKJC9xKjmox4zCZoahuF0ld7lgtkMnq2d0m
         M3mloHq3rTF0BY4lg1yWBzfgGr14xfsSAjrU5OQ7cv+70tc+9DN3EZqBr+wb1L3NfqGC
         D94cbvjdskoOcv/sfANOshoSLyatqVMqNE7lOdDWIGAbQx2FvCqSLCxWymul67ukwWrE
         o6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736855684; x=1737460484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbJZNH3I2kHSJ3p3lZHpAuzG4uICLJvj/AiJ0Ww5yMA=;
        b=u8ffQZJ3eQDNBcIlBidAOydJEZY+D4WsfdyHGOtLhBPH6EGaamhI/qftO68v46sJ98
         7M6pOHMs4VXY+McU8iaG3Q83SNn2vU2cx0nj2DFDvvrwzG8lw5rm2mAF7fkXj1eRTB6p
         sfrBGlmppakwPRYlH29le0cjssoZBa/Jl5R4uh8V6Uepiby+k1Nzx5zpELPymu2XNSIt
         6EZw77DnJsTT+oRWjctcVbX96GDkI5R9t/uqusA7Uksvh2SBV9F4uzTDRkbdb1AkrkDX
         jtgjiEgRcbtWfemOamTqNWTIuAWL4rMa2txWTS+Wn8RZWrMSVrao/p2UNAnNNJbLeCuB
         hWgA==
X-Forwarded-Encrypted: i=1; AJvYcCVy4xhujbtG/TUOVBporbD73/slbK5Tjm/DrVnTMMCSbJ0jSD9FpZ6k9VgCMLCdcLxUoMNXuaWbVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycM8w7yUpHLCIBhJidyTYcHzZmhXLe4kPJcZNgZWQW/rfUAkd7
	qNdTUhi0ayuXF5+E+cwCJFO4OxYUfpZ8gwXxfKkxA0p3/5/mkeIM5lKq4EqHUCo=
X-Gm-Gg: ASbGnctZtLwBZIHNW96BpdWEwga/n9g2bABwWFRyu26Tvo7cS810zp/ScVu7FIRQ+YA
	LdNRi21qf9TqLdZiOgKfqCrgUf6WOkA1gcWgRrLcG2yXJcBSjGhFo9dIPmN7GM6SGntA1WhMDAJ
	XX6WGDC+pQVVAnTBJC4um6ihirxJmE9s5sQMQFYYn51k2L3doN0qlQ74Ola+9PRrYLxgPQq1Fgv
	yobxUOhXgAY/Pzn1NyMKPkGXiYqn3dTQ1jHRCKawBBKnROS/qukrr2ye1pAdLvpTnSOcs8vbboe
	SSsKkt8E3wxE0a9SDiZ0
X-Google-Smtp-Source: AGHT+IFlWMbt6nrzrirx/rDmydW/pVj5xprtbzyuAVBQY0lAHuDRdBjo+/B7yttkEhzKPsZ0JknC1w==
X-Received: by 2002:a05:600c:283:b0:434:f1e9:afae with SMTP id 5b1f17b1804b1-436ee0f8783mr124040565e9.1.1736855684496;
        Tue, 14 Jan 2025 03:54:44 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm13710775e9.0.2025.01.14.03.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 03:54:44 -0800 (PST)
Message-ID: <53f3803f-c6ef-40db-9794-6c90b37659c1@linaro.org>
Date: Tue, 14 Jan 2025 12:54:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/5] thermal/drivers/mediatek/lvts: Disable
 Stage 3 thermal threshold
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> The Stage 3 thermal threshold is currently configured during
> the controller initialization to 105 Celsius. From the kernel
> perspective, this configuration is harmful because:
> * The stage 3 interrupt that gets triggered when the threshold is
>    crossed is not handled in any way by the IRQ handler, it just gets
>    cleared. Besides, the temperature used for stage 3 comes from the
>    sensors, and the critical thermal trip points described in the
>    Devicetree will already cause a shutdown when crossed (at a lower
>    temperature, of 100 Celsius, for all SoCs currently using this
>    driver).
> * The only effect of crossing the stage 3 threshold that has been
>    observed is that it causes the machine to no longer be able to enter
>    suspend. Even if that was a result of a momentary glitch in the
>    temperature reading of a sensor (as has been observed on the
>    MT8192-based Chromebooks).
> 
> For those reasons, disable the Stage 3 thermal threshold configuration.

Does this stage 3 not designed to reset the system ? So the interrupt 
line should be attached to the reset line ? (just asking)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

