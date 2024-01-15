Return-Path: <linux-pm+bounces-2199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008482D87C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92317B2182D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A242C683;
	Mon, 15 Jan 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es8YCWNF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBF2C68C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2ac304e526so810020666b.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705318765; x=1705923565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3frZZSaJ0FqqnRHcXPzH/pZUPe1LoezaNa34iVa8Bg=;
        b=es8YCWNFHPE2gr2fy7H/6KSELLKLMDuNkVbF+Kz3dn8JjTTVjyAIZUWTI//koa/iMX
         vprov5bL3hEMQHBtwtxe8ffvyuA1T/H3LlGlE7f/fWJRd+X4IN70DSRw3O4R+5PFCSr/
         AVQ5qsgsL5NWkbvB4Ya3QlZ5lJifQTZ0FaZE4Y5HysU9o52LiJOGQRvybapL0azCxdtw
         W0xBQkkg134x8QoLBExamy7y31og1eBezXE4BCgk4H3ae4rApFeEXo0VVsOpdUzHEnEa
         Y9G5boHWkTVD6Tr74e6kpHUbKd+0dZdSDt2V/sP97+nUFc/2k0SWx9PfdHvLr/eXCIWj
         mA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705318765; x=1705923565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3frZZSaJ0FqqnRHcXPzH/pZUPe1LoezaNa34iVa8Bg=;
        b=vD3MBdcLS8u79xMGGcY7LSvBCVX8EG0+1Tasz83W1t7YFtdLoB//PYCYTO3QkIy/pU
         zDaDWjb6WoTps3hKnB0TcBOdAheGS6dbM+UiRkY+T5lAOJbkrXmFCbyNVlajbcVYiKDT
         dS1Q+ScRBwebEowq0Q2CmDupFn+ufLZeCVj2MS2Bp4jccUWzWS6davUTdfGdI9hkas5G
         yYB+GKtPXkgKvlomQAxmnGLQIcv7cxvMzyqiI/mZ8k5ZQMtFjb+ukCBrnR57FZRxTbd1
         d7tYu7wd19IP0rnljHeFHQRRvR52SxnTnhV6GyW8z8PVcvDE9d02X1nJiXjjYdFOEkR7
         lBYA==
X-Gm-Message-State: AOJu0YxexCJ0wkGFOQszelhygbNysxHjp6O6Q67pt1RSsytW78qpkZqh
	Cj8//89Y78fCL0+Qd5A1ji8TIU7n6Xp3FA==
X-Google-Smtp-Source: AGHT+IHiXIWP+10j7TO4GK7Xp69CrOm3VKfG7rCFmd5MmDfqZGjVwTJTMs3juUrFE9gIYsiR+38Ffg==
X-Received: by 2002:a17:906:19d3:b0:a26:e760:40ba with SMTP id h19-20020a17090619d300b00a26e76040bamr2294148ejd.46.1705318764912;
        Mon, 15 Jan 2024 03:39:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gc9-20020a170906c8c900b00a26f1f36708sm5178658ejb.78.2024.01.15.03.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:39:24 -0800 (PST)
Message-ID: <f354cfe1-88eb-4daf-aea3-7acd2de5d106@linaro.org>
Date: Mon, 15 Jan 2024 12:39:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock
 Definitions
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Magnus Damm <magnus.damm@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Cong Dang <cong.dang.xn@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Linh Phung <linh.phung.jy@renesas.com>, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1704726960.git.geert+renesas@glider.be>
 <2e083461752c9d52fdb251ad9071f6111f13c3c5.1704726960.git.geert+renesas@glider.be>
 <ca0cb671-43ce-4bda-aad5-da38bace4132@linaro.org>
 <CAMuHMdUJYH7YhQ65Bh1K8F2earTM60VwBd2=LH2vnGbaGPU53w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdUJYH7YhQ65Bh1K8F2earTM60VwBd2=LH2vnGbaGPU53w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/01/2024 10:27, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Jan 9, 2024 at 8:21 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 08/01/2024 16:33, Geert Uytterhoeven wrote:
>>> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>>>
>>> Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
>>> V4M (R8A779H0) SoC.
>>>
>>> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
>>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> Changes compared to the BSP:
>>>   - Drop POST* clocks, as they are internal clocks.
>>> ---
>>>  include/dt-bindings/clock/r8a779h0-cpg-mssr.h | 96 +++++++++++++++++++
>>
>> Mediatek was able to switch to vendor,device naming scheme, so Renesas
>> should follow as well.
> 
> For new bindings, or also for existing ones?
> Doing the former means there are inconsistencies among different SoCs
> in the same family.

For the new ones. It's just naming inconsistency which does not cause
any issues. Otherwise you never move to vendor,device.h format... which
is not that critical, but in the long term brings uniformity.

> Doing the latter requires keeping the existing header files as wrappers
> including the new header files, because the binding definitions are
> part of the stable DT API.

This could also work if you want all the filenames to be consistent. I
would go only with new ones, though.

Best regards,
Krzysztof


