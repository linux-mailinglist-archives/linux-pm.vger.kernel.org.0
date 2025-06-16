Return-Path: <linux-pm+bounces-28772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD411ADA710
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB01188A335
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 04:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA161A5BA0;
	Mon, 16 Jun 2025 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Fxlm0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21872607;
	Mon, 16 Jun 2025 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047237; cv=none; b=Ip8N8ScoezQTjNWHDzEVunvzrfPQykGJ37QZToBy8tpGzFDIzeywbJzh0PKDeeIi+baZAqvXtPCIQeuO4hMhWlgWgdrsXKVtis36CODv++23jr6x6TkyVvFp7h5maDCAUPZVKLfRzepu5wNhUU+yho/9/sVPtv7blofVvT1cXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047237; c=relaxed/simple;
	bh=+q0guN9PwSiS5EAbareskBIti2BmPJU9JVXqOz/iUbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vuyp6S2u3v3H5/PU2GDg6UFgZ5vZV/CfJxDIRodOq6tczErvWOj3MBOOZE+r/igLibwD4GuVZWcxMdRsLaYGJNMCQYT34P2rWa5fhxW4ChkS75RfSj5eDGLPtieeWul+pNzHut4cxna8a531wlmR+UyjJUSSWd79vvkZatDjqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Fxlm0E; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3316202b3a.3;
        Sun, 15 Jun 2025 21:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750047235; x=1750652035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P80b7O3kBzCHZeyPaqEFw3rG2WMhfBLYf+jpLfD2cC0=;
        b=J3Fxlm0EKALYEBLHNAI6MTCGq9uYYKTCI0hHyVU9MtknUDeOLc9FDj4qAirVKclS5V
         yok0r5bw4tGiPRNnI/4w1B84m6lQ+SEnRN6VeoVrowHm0J5ALmD6LPeIf+STvkEwcqSs
         Xw1lQAWoC8mKa/ci0KY6SLazGXBnRgYu5k4+3yX8SJPFmAi0L6CNs3G8ILl6lK6DYU4e
         pE7O4lIBUCsX29whQqZJbp8jWtts6SihIRcrXATOHK75rKWSSMHYMrnbcTQepTVOvIGC
         RrwlLUwu7UD8e/q2i0b8Wr/7BqCX/USrRnnMLF1dt4NDNK+pkRcObF9VI0doaS5BHByJ
         VbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750047235; x=1750652035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P80b7O3kBzCHZeyPaqEFw3rG2WMhfBLYf+jpLfD2cC0=;
        b=dfSU6RyV8zlkJT7fzQz1OJR7p8AUF1Rqg++y/78PpB344wIf7gF5Nn/FOz2WAKEnWM
         DCq9zhvWp1bUI6Zd1PR/h9ZvDOoXA2M97sZwVY1RnVXyEPWYQdHXCToiUu4Idj+/AJ/Z
         Lvg7pnxFm8ChuizHtc6H+PAml61UDxUtKiA4Z6DJ4JckgeB2VXMLS0n5NqTkDHfuS+17
         xs1tJauFnF/5C791EiL8Uw/6FFSrjlXpDu6ecOudLhvUfAf6BMMpIUfANDW7UKJBruFo
         mjlrAOhRN8oruDmC+V992/IWLK4uv1Ikg0Y5vTkRQh/TWIa0p6WDI/sN/yCX1Ni/rmRA
         lOWA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/jxl4Vc5dvzIStz2WZCrgg0iI1lWg/YTICMbn3F/QZuUWkMK0vs3GlOMeUgXReo6buvBWSIIjNAWeA==@vger.kernel.org, AJvYcCW9/vP5SQ1jfTnkLdTMwSqw3QMWlm1zFL6n+cvdWYmauKY/Fu960T+UBGKWNRtVmVZg6PqZkqyF2UM=@vger.kernel.org, AJvYcCXi/AhJLqfJQl8jiW/JACqP/AJdVX866wYq6JFjx4V6b3I5FRyzUn5s0dnPCoOAB2B7GItWeuKSOZI3oPWT@vger.kernel.org, AJvYcCXpTx0NlOuTCnDqHjZPMLUgVdttNVCZi3gnCNW3/+GWuYkq8dzOdVR4dR5d9GcxAicdsS3hJISR1wo4@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLHY3i9JzxsL1MrhSbOvgFTo1RBh/3LiHiGSYN8bB6k3i2oVh
	4V4bd7GcoWKDSYQAtqMdSiQmtqUz5Px8AA7FGPTCvMm07/+9gEJYklgU
X-Gm-Gg: ASbGncvwhPeWVbT2+rcfspyb1s1K7kP0zKeUeM1uiAlm8cOJ//UxqCTjUMWlxcyaPPc
	PLY6rhfHXgqFbjlY+MhceofbhpCX3N/Qdu4/mcIKBgUtSNa9NpzNI2v31GkrNTBkYJB14nXPKZx
	zMf25JZ5twZ6j/SFMAQSpHyKydKHCR635aRP7ncLuqTtSYNftGO29IFQXbJm6iggszqb8WtBdIa
	cV06nDx+gnXxnOU+9POmH6rvUIj3nZtVEB3IGhgp/tkXhQHqs2eIM7K6FHYgUeSpkoxnH0KVnEP
	aqk+a7GEKvr4FVhZIUOelgnGwLFk2j93MaucFCMYyEoswaBPVQck/K0ixZWEhGjK+SXV+KUg0wj
	R7rwu3rXb
X-Google-Smtp-Source: AGHT+IGj8afwiQBWMnNFiO8CZX12Uzqm0farJp4iABQXPdiIhq7hSOMuLQDUrIeTYhq1s+E7XXHTwA==
X-Received: by 2002:a05:6a00:21c1:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-7489cf5c8c2mr11015493b3a.1.1750047235481;
        Sun, 15 Jun 2025 21:13:55 -0700 (PDT)
Received: from [10.89.152.134] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006059sm5937252b3a.55.2025.06.15.21.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 21:13:55 -0700 (PDT)
Message-ID: <7297d4b1-84a2-4bb1-8a33-29c827247df7@gmail.com>
Date: Mon, 16 Jun 2025 12:13:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-7-556cafd771d3@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250610-smc-6-15-v7-7-556cafd771d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/2025 23:29, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This driver implements the reboot/shutdown support exposed by the SMC
> on Apple Silicon machines, such as Apple M1 Macs.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/power/reset/Kconfig         |   9 ++
>  drivers/power/reset/Makefile        |   1 +
>  drivers/power/reset/macsmc-reboot.c | 290 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 301 insertions(+)
[...]

It seems that the reboot driver still probes even without the smc_reboot node in the smc node:

[    0.994942] macsmc 236000100.smc: RTKit: Initializing (protocol version 12)
[    1.002862] macsmc-gpio macsmc-gpio: First GPIO key: gP01 (0x67503031)
[    1.013156] macsmc-reboot: Failed to locate of_node [id: -1]
[    1.048188] macsmc-reboot macsmc-reboot: Missing NVMEM cell shutdown_flag (-2)
[    1.055359] macsmc-reboot macsmc-reboot: Missing NVMEM cell boot_stage (-2)
[    1.062332] macsmc-reboot macsmc-reboot: Missing NVMEM cell boot_error_count (-2)
[    1.069799] macsmc-reboot macsmc-reboot: Missing NVMEM cell panic_count (-2)
[    1.076902] macsmc-reboot macsmc-reboot: Handling reboot and poweroff requests via SMC

Best regards,
Nick Chan



