Return-Path: <linux-pm+bounces-12494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D326C957590
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306ECB20BAB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 20:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F8158556;
	Mon, 19 Aug 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKWVrB1F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84749627;
	Mon, 19 Aug 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098921; cv=none; b=KV3OhZQzlFhYeU3GtDp2reMMEfgn4MmnZaloAij3YYryUxK1ouwlplgP35JX0ZDEFxGG6aAcFXfq5ASxBCMx0gQbS48js9sxxA6VHeqmGLFUydsao37NsP1jeFIl59WWfiQn6zMcYU9cMLfSNRbC6cochOijPNLe3j7buNU/xDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098921; c=relaxed/simple;
	bh=YmPOdBHOOhyh3w2DYhiuqYlTkgCyCKlILJ31UvbzFsg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n4UY7wI0oS75qqTlS2F9N1sDvEElvw83tMYCXR92JKQ2GBWDWFi7eH4Z3iAtXuSJf0t0KPQNTai1H2BXqxR6E7nmyHHitAd32fgcHx7ZULsNRZEHgz94N/i7Pgn9PNKO9PKGS9SYrumqvl/ZgzytAEKLTsOE+6+/ywvLds9mGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKWVrB1F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428141be2ddso36821985e9.2;
        Mon, 19 Aug 2024 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724098918; x=1724703718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vaS84ttcu/4010Fv9HBj9GzkRV/n79iBXqj2pli8Tbs=;
        b=KKWVrB1FEIlj9U7Oyffem9qWdu1FBN7wTvTlBJbBEpD++IsFlaO9qQoWxpOXOQlM1b
         2fbiOyVpUzM7IioqqtgAsyBlRV3Ikp5P0RYg33LPnCqaIRzYO24VuJuBlw/8f7JImiJi
         2zXBxkTMBWFRx3qmBwr2TF89EUbKTTMmroEMEB8C5PbvZU8E8AenW/TQ9SYTAOEc8z2N
         7V3clAjJezXi9dSIQhzCLzNkj9spuLcs3FjgjYlG9EFsAt6KaggZ4WXQN0wUmsi20hiO
         +FdVjVReephwoQhtM2wvwTH7e/yP80jlSS9ToiTgSh3LTnDG/xdKQ0EMzZcDYlzGiabc
         Pkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098918; x=1724703718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaS84ttcu/4010Fv9HBj9GzkRV/n79iBXqj2pli8Tbs=;
        b=h3USDPnAwIWla/OOYOVCnpyFPPaR5wQjcPQApchzjpIhLHPOOkyx6K4a3f/95D7jde
         V7/PytPonI3EV9gK9fp95VkinvB8GdLhgs40dKM+vrJETYDk5KP/rYC6fkBy/qBSTM4B
         djxvR0IRrF8rFMBToRgyNIby1VYkB4mFV753wBbUNB0RijcyJPiizYT00lkYBkRPGOks
         0AB8eC+1PIEdc6sLtLHQYkSpki83NrXf8GDtEWOmzi0pyR8ezZSj+HKrRU4WEvV/ZY29
         SIXZjE9Ei8AKYHp0pgdZppa4Vx6eFEmMIkeS+HRIzvfv5qEBPNSf29DSEaZonZ8MVVT2
         hmgg==
X-Forwarded-Encrypted: i=1; AJvYcCUZW1whbe6HRlkAfxY1H0GyAwdxD25ZyjTjBokR5AV9RJlIE7OZKIIKDchP1Z8db+VGkiS8ndonhyE6@vger.kernel.org, AJvYcCXFSeW++yPzMgqYF2uNKxIowi4HUKctUDpsPcNO98NqasfxyBtc7FaQZddkFsFw/wzSv8FFGtHrOHWSTtEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjvgYCbAumgAARdiMc5W8cW0wSjFHDU6LtpwecNbVQQh6CPTp
	NVUNlSZKWLz0I7h75jBma9AeTp0LmJN22FEqd+KRIXuW6LFB/NC3
X-Google-Smtp-Source: AGHT+IGSRZAWyt+DnYIwf5njkpB6uItML2uqPjDLE5kTdpFc+m+lKakFrb+klZliHoHggbI0Xsx4Qg==
X-Received: by 2002:a05:600c:1c0a:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-429ed79be6dmr88973655e9.9.1724098917396;
        Mon, 19 Aug 2024 13:21:57 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm173247315e9.21.2024.08.19.13.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:21:57 -0700 (PDT)
Message-ID: <85eedb28-c02f-40ef-9d65-e8689b3f7dbd@gmail.com>
Date: Mon, 19 Aug 2024 22:21:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add thermal management support for STi platform
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20240716-thermal-v4-0-947b327e165c@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20240716-thermal-v4-0-947b327e165c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Le 16/07/2024 à 19:34, Raphael Gallais-Pou a écrit :
> This patch series enhances the st_thermal driver in order to enable
> support for thermal zones. The changes include:
> 
> 1. Replace deprecated PM runtime macros with their updated counterparts.
> 2. Implementing devm_* based thermal of zone functions within the driver.
> 3. Updating the stih418 device-tree.
> 
> The device-tree patch depends on an earlier patch sent to the mailing
> list [1].
> 
> As it is currently implemented, an alert threshold of 85°C is set to
> trigger the CPU throttling, and when the temperature exceeds the
> critical threshold of 95°C, the system shuts down. There is for now no
> active cooling device on the platform, which explains the use of the
> cpufreq framework.
> 
> [1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v4:
> - [2/2] optimize dependencies
> - [2/2] do not return devm_* exit code
> - Link to v3: https://lore.kernel.org/r/20240714-thermal-v3-0-88f2489ef7d5@gmail.com

Gentle ping on this serie :)

Thanks for your time,

Regards,
Raphaël

> 
> Changes in v3:
> - Fix unmet dependency in [2/2]
> - Remove no more used variable in [2/2]
> - Remove already merged patch in soc tree
> - Link to v2: https://lore.kernel.org/r/20240625-thermal-v2-0-bf8354ed51ee@gmail.com
> 
> Changes in v2:
> - Add Patrice's R-b
> - Edit patch [2/3] to remove unused struct
> - Link to v1: https://lore.kernel.org/r/20240518-thermal-v1-0-7dfca3ed454b@gmail.com
> 
> ---
> Raphael Gallais-Pou (2):
>        thermal: st: switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
>        thermal: sti: depend on THERMAL_OF subsystem
> 
>   drivers/thermal/Kconfig                |  2 +-
>   drivers/thermal/st/st_thermal.c        | 32 ++++++++++++--------------------
>   drivers/thermal/st/st_thermal_memmap.c |  2 +-
>   drivers/thermal/st/stm_thermal.c       |  8 +++-----
>   4 files changed, 17 insertions(+), 27 deletions(-)
> ---
> base-commit: 4f40be61af99a67d5580c1448acd9b74c0376389
> change-id: 20240518-thermal-8f625428acf9
> 
> Best regards,

