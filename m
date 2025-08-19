Return-Path: <linux-pm+bounces-32594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D504AB2B879
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C885E13ED
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834D270575;
	Tue, 19 Aug 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SoXSkFxL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC94214210
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580042; cv=none; b=bWJz8RYuWsiAU/3mFX5W7yFgzwmC4hD7C6VkZ4GzyDgCvguoiCLD/I5PP0SurEsugT4O7ZUlydQbY4+x7opsw3xytxLkyVgr8CV4/k1DU/jsbTKTJMT6MNFw5+wOYYdFN8qWvDWdmlJ3mxh42Fjzo1i7cLsXglgUnu/8Y4CYWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580042; c=relaxed/simple;
	bh=ltXNHRhOhUUl4xR8T4+Ojndq1rFeuYUH2BMxeu0RtmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKQNJxxpdImJ9ZsNMZ5L/pireHy13oqTokugVPYd55EJCYJWaJfUVKkOUAWX7V8GmhY4gwVIS+jvZqKa8tEHMU7CjEvup9ZJSdk9ucZRRQKTMPgmhVirkc5T3kzhSwYpiWuqOhV7e+0/li+8wHI0x0PXmIkfF8h/uVwWDKpkxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SoXSkFxL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so2350250f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755580039; x=1756184839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fga+lbodUmPAZazOf43yy1bTgzdU2LByeFqojuOQ83w=;
        b=SoXSkFxLAXwWKCM+ck4BQyG3Kz10Cs5HOEmcjcltNTbDIwHOC2NcX6ZR2ICOcmUNST
         7xGqEImExFpdAq/UFWqdegH0yflXjYvP+BgczT6shJ+am5rgG2vEtDimk9T+y46sqCWA
         tQwnxvxw63Mz37Pi2WtjyNSLe0Glwo6y1SsQtbA7Nns9qM9RfzYEy/Ghsca28B3oeTxi
         /CCHU6aHXS6A11DwC1s47+bAYeQKTTJ3f4tffSwJnt0ADdABgAum5xOjTSqo9pLf0G8l
         /DfrLBj/wSiVcgHPHfX2ZVnlwGdGeOp3mHl+cT4L28njTrhX95MSNL+G6N057lcG17yT
         MOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755580039; x=1756184839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fga+lbodUmPAZazOf43yy1bTgzdU2LByeFqojuOQ83w=;
        b=S4l3b/BFeJ0njWoFr2iAtvpC0kNviCFG8UzKeBQbmrw+RefY6b1yiiFwPWkxJBJBLJ
         yic9F1jQrmH1KXVndyloXxlt+lM7Lfu5aVdrL1v+VbgKS0RMLeDMTqMrAShlaoTGChUT
         aubb8aUM+ivO8tYH21fEGMZE151e4LLY2JjyN5rrDdJSduSMCmes0fkGzCIIX3usxRA0
         4jE4N2QQz5NQlImfU2id3lwtBN9VptCRP3hZJTyLwF8rbVd+IjLZIR9SLn8q+nqqGAZC
         lLjxJdaYjU6weZqvI6qNAQ7u8hGOw4+dSvI2F+aSaojzGyW/nNqp19tvC0elXMK5pSas
         nW9g==
X-Forwarded-Encrypted: i=1; AJvYcCUNmHfCV+gkqPFEXvplRMAjB+MRFuumlCU4VVzPoRddmyWXTRwRPAUyrGvXHxzNXl+c0sCBGpsZzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb42Rg4IhMjNpOTaR0RdlYoAVB9+cyF3iAoDnem2rXimLDRh8
	6VSVBhBflrliRo0cD/t/Ikx7Xiln7tSMWvmhc3vXD9dUYhBUbpKXlMjvFhfvWeGF7qE=
X-Gm-Gg: ASbGnctuSjaKWMx9K/rudAsa3KIxv70DtOohyZtWZF5JSG7ZGHwiHSwAOkwC5rP4bda
	WSe7UaI61POgggdAAjP2ACcJcMwop1aCFNZlPPnqw3A93COTrRfbUvjYQmD3uKAXzL8R48MiVEa
	AztAMsuG8XJIssNxQHLbhqxCykf29Zb0o/hj6N50hdisaAlkmFOKq8emPaBR2DdaV7rgcKSk+N7
	AHMr9WIT1CkiiarQ3vBuTA0kOuUhBSFWEe/dUPQunxZjx0VmEbFDIToYLg3bC7AepMaQXEPCw58
	J6OI2iDumUO+QwcQ3HWnqznnEO/tb2eUcjMsZxF7ux+N5tf3qmCKEgwbim1sU7u79byxQl9twM+
	gqGQfLICeFZOvdM/cVVxF7+1X9R8rbgRQhYJsv6a4cri4kffvdr0gn+hu1fi/I049FB95BHOMql
	DIaw==
X-Google-Smtp-Source: AGHT+IEGAIFSV01YojFxZG6ti+gZSOdnTisUwlACnGc8HPzYTSLd/Yrx6ey+bzDVw52KF6DYn9VA+A==
X-Received: by 2002:a05:6000:2485:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3c0ecc31e8fmr784959f8f.37.1755580039233;
        Mon, 18 Aug 2025 22:07:19 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:620a:8b00:4343:2ee6:dba1:7917? ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879fe5sm2018512f8f.2.2025.08.18.22.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 22:07:18 -0700 (PDT)
Message-ID: <d00ce701-2ddd-485e-8bfd-12cddec62fef@tuxon.dev>
Date: Tue, 19 Aug 2025 08:07:16 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] soc: renesas: rz-sysc: Add syscon/regmap support
To: John Madieu <john.madieu.xa@bp.renesas.com>, geert+renesas@glider.be,
 magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, catalin.marinas@arm.com,
 will@kernel.org
Cc: john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, biju.das.jz@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
 <20250818162859.9661-2-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250818162859.9661-2-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/25 19:28, John Madieu wrote:
> The RZ/G3E system controller has various registers that control or report
> some properties specific to individual IPs. The regmap is registered as a
> syscon device to allow these IP drivers to access the registers through the
> regmap API.
> 
> As other RZ SoCs might have custom read/write callbacks or max-offsets,
> register a custom regmap configuration.
> 
> Signed-off-by: John Madieu<john.madieu.xa@bp.renesas.com>
> [claudiu.beznea:
>   - do not check the match->data validity in rz_sysc_probe() as it is
>     always valid
>   - dinamically allocate regmap_cfg]
> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S


