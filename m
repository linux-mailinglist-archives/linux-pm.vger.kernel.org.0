Return-Path: <linux-pm+bounces-25304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AAFA86AA8
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 05:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E387AE5DD
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA401624E8;
	Sat, 12 Apr 2025 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3g/8nXc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14091155743;
	Sat, 12 Apr 2025 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744430009; cv=none; b=mO6nvgdFAJHrEPIq4em9ttuESgugxdVyfEVeSZuSTw66fqbQeyMb6YoTMIx1/SryqdfPrt1IWOHcvTfQ7nPmCO1qD5i1yEFZSXy+QaruCnQnn84y63Czgo95smiXLfd1K+YMjQYjzslqXjGGBFp6/ff6FLqHyJphTBKayS9ug2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744430009; c=relaxed/simple;
	bh=wTzkihgJDk+PfgalYMEfICtXY4uHOcjzu9cQSMU9SvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gkNw0E3XED1Mi/DPRHX1fh3qtAA4cz5Eo4GS7IxOETFFlK0YG3iCU2BXNQmorlQFVriYpVkd3f9hjYef71QrBwmKqza1+62oEGJ3ITLcuUaE5f3JL1xihMB6i+3C2VqeKe0DV7WLykx+csoL4IEhc1XNosf21A+qUEby8OpNCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3g/8nXc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so3256190b3a.0;
        Fri, 11 Apr 2025 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744430007; x=1745034807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cCaU/9pItXeyQyKncm+hw9C0oW5ARKbMzPEkSk/lu0=;
        b=N3g/8nXcC63yd8R5bLzSfi6P/qDJfvtchPmhEGa6m15WKADcOposL3Z99bRBJ2vBiF
         lrg12fzCaKK66NRYx0tE1oY1dUHNI84pkrFX5p96zIT5/3CSh8ak2DJZ+8FfPTv+qLsS
         K7U+Xo6BWrybAsxz53/Gq68B3c9OxrJl9TZ7tExrZqAcg7fJFoKlxa4x7Vr8Gmh1p+1Z
         BCtP7e7Kx9AaXiNHKGAXkY/1/m4WDpX452Nemtzk0IWv/TmNOKWDGavgrypEqAPN8iGS
         TAX61GFd7tRETWaxVrOlDYFIcge5rYyX1fJp8PeMT5nJ1iTFbmudHxOprwzqk071ehvb
         g3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744430007; x=1745034807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cCaU/9pItXeyQyKncm+hw9C0oW5ARKbMzPEkSk/lu0=;
        b=YgUzaXW5t7s/QhxVjFOPdE8j8he2qk3jHoV2qluthLHJbWiuuYBOxmqj3PWVTPrf+j
         0Y5VarOf5CCYUnuYunrCsfT5NEmqETPP+A+k/rF0AgHVwaHL9oMqtnklk62ocWepNcNf
         hOJBbDeB0fUVV4aixWjIdjd5YdKJpDvYjdrj4tXWCROdsc8ASKHMYn6pk6D2Bq/OLygt
         XxbIyGepcT/g6PSsb4qANhr92UIkBzJRpYLextbBi3BNzLDCXHJngCoKRWOkwueatatD
         zt9BQvGz+UDnsAmbntzTO64Kaw80wqDSsR+7NevuSGcrptlH2sMNMPzgeJHgRzstB3y8
         wlZA==
X-Forwarded-Encrypted: i=1; AJvYcCVX89rz8A/Ol/tGUkZH2Z4kZWKjmad945Wy+MY5sJS9Do/ada9I4o8SIFzFCNr+shl/bD6IGW1kYB3lRjyE@vger.kernel.org, AJvYcCVdakyic5D4CmefWgPkyEcrr8syUjkI63JcQ8gMBkOMyUg/8UzodL131rZhw6UzsrXBUHW6/vdkWx0=@vger.kernel.org, AJvYcCWRBaenYOI18hidoEoRL1if2leb1lxCcSDr2I++kUMsoey8ahspiyzkXpUdQZY0ljQAXo3dsKWDbAhF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16QyxhN+rB81xfH3MDDp+FSmiVlDb6EG7/5iTwUdgHieI473F
	JeIwLaVAfMhTak0WRGOX553pwXOYHl8Oj7dhXBX+l1Y31s41iCco
X-Gm-Gg: ASbGncuvgplU+8bdasapTVoE3xtZKXXvraWc0ZI+q9AEAlWhYkrnB0D76JZiBk/SGIZ
	MjaynB/P1DvuF1Elc55wUhtnXP4z0BG1FoxGABME0rU9pO/ePxPS+7YXCErOqV60Rirk7v99/+g
	5PrHJagQe4RH3ayPnFCjv/RBsWXd2h6aw8AcjhdEtrvIIjNnoHj6UeNgS7FBGiS40C1L/FZ8PUJ
	k+o3x7PgrZFegLn4FdEVx8X+yHBD2TAfROTN+cURjTQYhr6uxbhGxt9c4u/+IprD20w9X+KxNyh
	12NsFugVqOIXGM1XBqmOktlzhZ/Z3jI9oEsxNZKKETI5
X-Google-Smtp-Source: AGHT+IEIMF5fg8Rc1Bjc1V7Y1P75rom0e3KD+7LFsWsIXn/FP8KnbU+SQpMciMlE4vYfRTYAuGDRbQ==
X-Received: by 2002:a05:6a20:6f08:b0:1f3:1e5c:c655 with SMTP id adf61e73a8af0-201795227d9mr7520801637.6.1744430007203;
        Fri, 11 Apr 2025 20:53:27 -0700 (PDT)
Received: from [192.168.101.248] ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198c00sm2594765b3a.10.2025.04.11.20.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 20:53:26 -0700 (PDT)
Message-ID: <5084c2dc-d268-4268-a827-2ae445782a4e@gmail.com>
Date: Sat, 12 Apr 2025 03:53:08 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add support for A523 Thermal system
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
Content-Language: en-US
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/11/25 03:38, Mikhail Kalashnikov wrote:
> This patch series adds temperature sensor support for the Allwinner A523
> family of processors (same die with H728/A527/T527)

Based on 6.15-rc1 with dts patches from

https://lore.kernel.org/linux-sunxi/20250307005712.16828-1-andre.przywara@arm.com/T/#t

> Mikhail Kalashnikov (6):
>    thermal/drivers/sun8i: add gpadc clock
>    thermal/drivers/sun8i: replace devm_reset_control_get to shared
>    thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
>    arm64: dts: allwinner: A523: Add SID controller node
>    arm64: dts: allwinner: A523: Add thermal sensors and zones
>    dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
>
>   .../thermal/allwinner,sun8i-a83t-ths.yaml     |   5 +
>   .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 145 +++++++++++++++++
>   drivers/thermal/sun8i_thermal.c               | 154 +++++++++++++++++-
>   3 files changed, 300 insertions(+), 4 deletions(-)
>

