Return-Path: <linux-pm+bounces-14288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360E97935B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 23:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBDB1C20F06
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE9135A79;
	Sat, 14 Sep 2024 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="accostl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378E47A73;
	Sat, 14 Sep 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726347780; cv=none; b=W0IMGOQx35AnBSaeJdSOQ+fjqKA7fLLsokEatXEttAY+x5H4lqsWyYSLW4wUZkFy8iKKMdxEIb3zeC8mq6jOVgK2OAymjgXqOTP4CtGEELAMjTDCpOPlSS8ew8jzPw9UvpQR7pqtVspdRi9FHD6gv+SWLbRxjLfSAw52x7vup4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726347780; c=relaxed/simple;
	bh=PKJfaPrc12Vv2JmLQQ4lqIi+mPQ9DeJWE/KuFMq55Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXk32xo9m7TLRedR7X3xD9JfAu7Wv7217Mhv9a6+xfbtNDiW2SMlreJrQcoixqZuTHysbutt3b970QH/syF4wZE2ndJ44tqZJA6TJAICPr2n42Gd3LrMoGkKaruOWDUzBtcPaxbF3Xrs9kIyqvAoF2+1WFp0Q86Crh7FnSdbkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=accostl0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so304021066b.0;
        Sat, 14 Sep 2024 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726347777; x=1726952577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSzJyxcwmwp8kDJtBoNBEY6FGBO0XHBvilUnLNtTZQg=;
        b=accostl03q/C5piaGqK1/zbX6Z/eZNB8tPbC2nr9qZjdNYnZqgny+QhLpCanh7eIod
         BuEs23ImaKDQygNbaq2k51G69+EPIa4nmF/nMLNQ0ahqgCR3CZRepCiVSZFmX+51sd+J
         u8HSMXttUkXsEshiAB9+kVyEjTiyN8sPnVe2KqvuuL6kk2iXt4yBMZbuXZEZdJTAn+CV
         +OnEhUMO7ohdipai9V/ty/Fkye8kk5lYntRq8a1LG52WXp0UuFzmOjj33WD2iWtEIj0Q
         IumNoIMyjAg9AWVXqp7j27RuGsqHzskdRgleiuRPae7dctLYGjA8W+F9DypTwJ6B3hnq
         lyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726347777; x=1726952577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSzJyxcwmwp8kDJtBoNBEY6FGBO0XHBvilUnLNtTZQg=;
        b=L/q09Yd2srDawtzZ0aWHXNiwsTPSUnBD0kCkkVY5N1IU+wXcLemuYHRjh3qjJKq87g
         5CaXkGIEpzeCt4aaSqapa/fQEGVCMBKxTRM3rfH2d4QiGbE1B6vXE6oxCsLEAsnqoZNv
         FUPe055bOE93djZMNLEHPs6RXY1iStsX5RrYdRdnzGjbiSGqgZxCNBPItzBTPm6cihsa
         P0Sy8dCxS3SdmOK2FSVLl9U/T0toYgxd4FwGHlZgw74Y+RPRkwA+LKG7WwgQ+O3rUKyO
         WeLepTlZMt8wqZlu+2DKZDwiI1e/zJ+7Vi3dBK4pFRFJYAIgeIolIgYz0k2m1uVNtXLy
         FPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0tt21xNCoRdvmtbfTDCXC1ojIEIAGjo5TUfT2/JZVIoPtBqOE4rf2Im6m0a2CQCxMxJ0RHOIUuN417g==@vger.kernel.org, AJvYcCVb3RlN5JP6TzGhGiM45w0zvKUMRYkhrhwdW/KXB0/GbCewl1UT0Y7ucjcSNb0tdvbeXQgNF/oAVIsQVoUO@vger.kernel.org, AJvYcCVyoMX3b4C47eGC3SL3oJQ2Yeht7Z3ONQ05WeHUCHtUCIdBtVEt6Vy9VywfcYtMXnZ50i6a50o9f2NmbwBKuCI=@vger.kernel.org, AJvYcCWvKWlmzuBOg6A6l9VPzp16rZz5j8XyuPpAECzR5WxFHQ92q75vrjdsKmTxQYRX2MY4ZRB/nNp17N4=@vger.kernel.org, AJvYcCXKg+1sWmOD75qpPEfDj6YFGnDOd46Fuyh51UcR2hn85BFTkiWbHT9Cm5Wr+GGfTGLuTaFgDLExrwTI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uVVm/JblG/nPjrW5d1EY8kDH6U2ts+3bg8s/Ppew68lvz7Bx
	7h723jlA0I0R0jqovs7TuaZ76hR3Bx5t9zhS5Y40UydJWlpRdCpP
X-Google-Smtp-Source: AGHT+IFyqjUnDNIwR3RJ+0vniYD91L8RSfXWK5QETpQHvM/YgLCbkWBuyyn1X2TT8x0asoAwDTnuWw==
X-Received: by 2002:a17:907:6d1e:b0:a8d:571a:e863 with SMTP id a640c23a62f3a-a9047ca46f2mr644871466b.25.1726347776948;
        Sat, 14 Sep 2024 14:02:56 -0700 (PDT)
Received: from [192.168.1.106] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9060f39a8fsm121066666b.0.2024.09.14.14.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 14:02:56 -0700 (PDT)
Message-ID: <34c748fe-89d2-d3a5-599d-52972c10f688@gmail.com>
Date: Sun, 15 Sep 2024 00:02:53 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 15/22] arm64: dts: apple: Add A8X devices
Content-Language: en-US
To: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
 <20240914052413.68177-19-towinchenmi@gmail.com>
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20240914052413.68177-19-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/14/24 08:17, Nick Chan wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
>
> Add DTS files for the A8X SoC and the only device based on it, the iPad
> Air 2.
>
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> [Ivalyo: system memory bits]
s/Ivalyo/Ivaylo/g
> Co-developed-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

You've confused me with Markuss Broks <markuss.broks@gmail.com>.

He was the one who brought up A8X. I brought up A8 (in particular

iPhone 6).


Regards, Ivo.

> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> [Nick: SMP, m1n1 and gpio-keys support, pinctrl fixes]
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/Makefile        |   2 +
>  arch/arm64/boot/dts/apple/t7001-air2.dtsi |  46 +++++++
>  arch/arm64/boot/dts/apple/t7001-j81.dts   |  14 ++
>  arch/arm64/boot/dts/apple/t7001-j82.dts   |  14 ++
>  arch/arm64/boot/dts/apple/t7001.dtsi      | 154 ++++++++++++++++++++++
>  5 files changed, 230 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
[snip]
> +			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};

