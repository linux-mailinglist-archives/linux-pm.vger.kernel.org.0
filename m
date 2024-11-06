Return-Path: <linux-pm+bounces-17083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B4E9BF4A7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 18:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CAA1C21477
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6D20820C;
	Wed,  6 Nov 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m84woleR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213C20408D
	for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915552; cv=none; b=M1y3HXnmn2qWemoGB/OktuUvwzeE3MDFcBjSamYezZD+33/0TKFQO7uCSMos/3oUAZhxQjCW3S+i3Y/AmYOC5sM1UkpRtmPT/yR2xYqh0585LzKDJjm79yApBvSvHssfq3322sWRpJFF9+rWFV0Trn9Q3EYFHlQFHJfr1P2AH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915552; c=relaxed/simple;
	bh=QknsfhNJpkSWvghdqGJQydIO8NDXgigr6SsR14Z15QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h6NOxfSVI3EkWJvA1N1WuBmFcndqDGU6WJ4QFuEn9n0WbgvSHVI4KgstW6Jn/gQJ2HOqVkL1p9Wm187aiChjUeAPIBQ9mIE7u4QN79FVPm9szIUrZTE/SqTLxm2mJIhuiXoiNjd135OHmJHt+ntXNUlaQcxQXbICWPXVYAuSU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m84woleR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso672955e9.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2024 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730915548; x=1731520348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ipymvx1/6bALryF6zoyWfiFzrkoooAVpB7ONDyc7qcc=;
        b=m84woleRjYfb7Y4itCq43i2a0layn4LTdCQYuBAXCAY51PqzAZ5gWbGmUM+yC/Wfz7
         IjRBBok7Cm6ndQPQELN2KaWnN+ZGF7QsArFkYDPlMxxImMyN1mcbsqGQf7nYYG4dS3jp
         QVFlNH+kAXe9TSiy4taJFwivYIiZ2THF4HrDUgvQflnqBkp12/p7rlbNES6bcofCt5ei
         9tJ5LvDbFWTA50xeohBPnVasrKbvmVR+66WiIx14RcY4VAzBV0WbzwtiBYP8X3QJPSwe
         1svZh79ViOwvMqPKpe1dXZy6UDsf709yFuqJSXPeQyeU2oBjZuHTMi5NGPuIEXKKGWlO
         JbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915548; x=1731520348;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipymvx1/6bALryF6zoyWfiFzrkoooAVpB7ONDyc7qcc=;
        b=n/noaP+A1CXVfuk+ft7Fe2U3590NyJTrrv5HH2Dl2N2VmS8kottLZWiTYjON/KAIV2
         exv0WqGSHxpBR6mT47j/HIDZnF7oF7ZPC+t2TBHiSZ90lOqInXGV2ec/98HuisLRDzh8
         0ZmNncjdjTVr+psxl3CG5mpnJE/ED0cjuRfTi3sI0QSKe/8EM4nKVEhJ8hbo/eRwjPGN
         /HF0MEALRqBmIhTbPvICcPWlIu1QC2NzdKO/6+CkZVO8yhVySAsw5epPWkXBS9SZxlzV
         82h6ASzSmH+5J3nYS/jWtPL1ie/7QEo/ZqLlzXI4a2i0g676TVM79YYQquqEsji7eLOK
         VOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCBEI5iWa7tR84uTAlLxl+Kw6SdMDtVINaKqMdxKPSMztZ6Gb0vHIUyxALt49ONdpnwbOjypI9jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYSDHOw8ZPGTT9x+z8khq0LKTUhKijj6+tH3Gpne5D+U3Muh/
	tq8vcKTnKt/buGH4QcBjryO/cIWdYnrc7t4kSTa09+MyX9aLywFTzzKAKkxKQ6k=
X-Google-Smtp-Source: AGHT+IFIGPqnuhGsKt9HNzG2CjyeWY7ObH0ZmvhCUaj02z3qP4fB3YkNaT4JK7o3DTcS9aJDv9+AHg==
X-Received: by 2002:a05:600c:4583:b0:430:5760:2fe with SMTP id 5b1f17b1804b1-4319ad04fa0mr375752515e9.22.1730915547682;
        Wed, 06 Nov 2024 09:52:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4b82sm19841073f8f.43.2024.11.06.09.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 09:52:27 -0800 (PST)
Message-ID: <b8633534-d0b0-409e-98ce-1cb7966e98e2@tuxon.dev>
Date: Wed, 6 Nov 2024 19:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] Add support for sam9x7 SoC family
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, tglx@linutronix.de, sre@kernel.org,
 p.zabel@pengutronix.de, mihai.sain@microchip.com,
 andrei.simion@microchip.com, dharma.b@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.09.2024 09:39, Varshini Rajendran wrote:
> Varshini Rajendran (11):
>   ARM: dts: at91: sam9x7: add device tree for SoC
>   dt-bindings: arm: add sam9x75 curiosity board
>   ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board

Applied to at91-dt, thanks!

