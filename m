Return-Path: <linux-pm+bounces-40599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D027D0D7A8
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 15:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93BD43013552
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A743451AA;
	Sat, 10 Jan 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EecNqfHS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515021CC64
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768056544; cv=none; b=thMFtaU4oKPp+SuB7hB47fN2JBVRHSGPNgEKTBHKDC+YAZb92XtcWL6quWaWhygpiBhh0U0faUYh3LYALE9TicGJiBnTJSdflqGDG9qul6ABAtjiTDEJmAdoTIE41Vj2sHUIeiJgA83P9mILsLY9g/3iwKKszaxv8OxztlRV7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768056544; c=relaxed/simple;
	bh=8cZF88ZHHeswEWIoZ1XSpuokeFUHz2t/rDtmfT1Fb54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0vIoduMBxi2HHSaNClPC6XJwrp7DtPSHmQBXX6rj6hSmW79Iz/j3EmEuOWM7ozJsYlRl2Enqjgs2QYOKFsVwPUHOhHLJM6AHKUJj0XS1gUppCVGWUTmQPMWnzhUgbqh/wtqjvAsYNQjE7oFlSLo5YjOws00cjoq3VxpJhdTmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EecNqfHS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb2314f52so2657562f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768056540; x=1768661340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHk6EgoNk8lP2vqJMYUzvRzyl3K2JzNhjFEm/rJg//s=;
        b=EecNqfHSZs06v18jqARlP9k1rRdjxC5rUdz/jxGgFVrZljBbTmYS9L0TQobkdqccxN
         TTe2xjZtAdjKQ57catv9RuhOA2LeI5qXpQYtyGFLy1B8mUnqC+1Wfrc4bF+zjsQjK4en
         V9sGY/5D9wzFWxSLIrSHmL6MnugPw62J02oboA4OVLBToaF0g1oEbYvWvK9PBC0QAqxm
         X7DfQ1R3AeNHbmI6nAlJTc569VGTwaIOA4MTx25J+sVjBzQW9DAOpbZyVU3yMYPSVaOR
         vn/4Gg+tvob/2yq4G0xQEIgD6SjeC4Fn4rnONlaSH7sfgZxhEnI/kLpOQMR0nl82B0Wt
         AJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768056540; x=1768661340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHk6EgoNk8lP2vqJMYUzvRzyl3K2JzNhjFEm/rJg//s=;
        b=OZIs6iN+jWiTJ2G3UmVxckRg3dfO9x2c42E5gSpr/9FiWYusSv6kdfnbC03kqkbEYf
         9TITmnLiU/BDjiGP75hz6DPwrYP7PDkywn0jsHpvRwQF6m3R2ktnGANkieXorLgETYqq
         rQOyTd0mBGIZNAdRBiBrAMXUJIeNjSm5jE0ELxPqWKXjT0bZqhnDpyhc+eUGUi8feyCQ
         sVfhShsE8AImY/1O9bnVZi73V1/5wTnJEe7R5WZXkS55LSotro8aTvLOg4r8mVFvtj7r
         70RRagevMekG+2fpYUisuXR0qun4sQ3M9XVugS7qXCYioLZdgHiiMvmXhzDB68EVN5HW
         dvdA==
X-Forwarded-Encrypted: i=1; AJvYcCW6JvCeY+vlUKO/+eOBd3bvumlVoNaor0AYeKz2EIm+VLGXczlNBFa7xG4paymmmXQYt0j6ecxcRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhV9pQKrosL6eieG3lmMfKn3BCVhSBoA/TvRlTdYkP77euucVk
	zK9K2UW4dAG9hfzPtSdM1ntwNKFHcylcj3COGxuh3IUuAlvX5ET39R3Q8VMbpsqVm9A=
X-Gm-Gg: AY/fxX5pMUu1xtUi6Z8hgeLk9CtLsouiqTMmM+VwoGOfXyJk4gddprcnVsX6pr1bTc0
	rnrgnrvkiYKpw0sDzRf5UuDukdDY+KpaP6vDH2rgeznFBUHFKPa933lur+dYsQR8MErr9XZNqOQ
	jw1zqSgnsJcAli+45H3oK+w2htoTSTvev3gzfcSdUammIPEvElflYzFtIEhCs/HX4sKd/f88LaG
	c42gXR5b2t3S0+1QRytcaRANR3SB9S8La/UL/IeqyJ4n/aKlcA/B9JLCFONER4eHoicxBR4yMJ4
	axBB2JGuJyNrbyx0/8CZXYlzSbCx2ppFUDDqodzLrFSFFlpmWFEc89E2XnymSlVAg5znRikmkZk
	8Y9hW+pSm1r+DgJ/mGOYwwNr3rKSdVkBDrK5J2WiALzY52wRuOP2f9kn6vJikT8fdnJhukjOZcS
	tHdPWFiz/w5RPEMvzttfTXoLNfqQZ/
X-Google-Smtp-Source: AGHT+IExDiyl6+cMqnLU0OScR46v/DhXxaFlI7KfbIz5c0gjBYd8wiO/Eo5iH1Cn00OMlkpwekH3Hg==
X-Received: by 2002:adf:f54f:0:b0:432:e00b:866f with SMTP id ffacd0b85a97d-432e00b8b14mr2891143f8f.60.1768056540373;
        Sat, 10 Jan 2026 06:49:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm27764794f8f.4.2026.01.10.06.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 06:48:59 -0800 (PST)
Message-ID: <b0dec3fb-51df-4bcd-ba13-c2049695266e@tuxon.dev>
Date: Sat, 10 Jan 2026 16:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] ARM: at91: Simplify with scoped for each OF child
 loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/5/26 15:33, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

