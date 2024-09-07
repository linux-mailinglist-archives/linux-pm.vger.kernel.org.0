Return-Path: <linux-pm+bounces-13839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB49702B9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1441C21D6F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470115CD64;
	Sat,  7 Sep 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="DSNlpm8V"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B91DF53;
	Sat,  7 Sep 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725719643; cv=none; b=OhTpi4ifz/V5xbrSpTN1O5Z8f4NA4K6zBf4ACVKi0yJv/CR1D4OMWe2pe6PmsguKCFLqoKu8j0FI2M4K7CCjL6QdVlXGWP5oBsReiY/c6Hw2wg8O48PM2CkuO4fDSdRxqlP5uvvxf676Hjj5dHzgHEb5uyUPkqG1aiJVa9wxGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725719643; c=relaxed/simple;
	bh=uzKsDDJjS7gq8EcZmXUPlxPJDGZWlwn06A72RrFvCaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqlKBXsdRv4Fm79YBA9UqFKc/VwIh9/bRUA5k3ykAe8dxEaGwBYlt0MJXTqmsWNF57rYI+ofTIsi4x5bkWeOtzQP+SRsINzBndXjX2kES+Ss614Bzkk0Myy/Oh6jChJDyUlGp8b1oaefZIKBQYoL7FBVQsa3J8ICqEQoVLrebwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=DSNlpm8V; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2278778A01;
	Sat,  7 Sep 2024 22:33:56 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2278778A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725719638;
	bh=gG2BH1+dXG7ZoJOt2ZX2FJLzrZcgshauVLlXVmZq6sM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DSNlpm8Vqtpho/RR7/MrKCNIEHFUFwwo/5l+BjIiUEgoS/ohM5XFx/jEygmd6VrWX
	 Ficq4hrX/KNy045+dpBwYrC5HAtq1+QfDxuRCBmvXQ8b82WTjXTLr797wpeVzIyaVz
	 0LwzUe5E6XCPOlgoplXM/RpP0R2GK63DfSfLnJsU=
Message-ID: <43918eda-c4e8-471a-9de4-ea72bb090803@classfun.cn>
Date: Sat, 7 Sep 2024 22:33:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
To: Markus Elfring <Markus.Elfring@web.de>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20240906093630.2428329-2-bigfoot@classfun.cn>
 <de5c9c27-56fa-4163-98e1-9a98400d2408@web.de>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <de5c9c27-56fa-4163-98e1-9a98400d2408@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/7 16:44, Markus Elfring wrote:
> …
>> +++ b/include/linux/mfd/photonicat-pmu.h
>> @@ -0,0 +1,86 @@
> …
>> +#ifndef _PHOTONICAT_PMU_H
>> +#define _PHOTONICAT_PMU_H
> …
> 
> I suggest to omit leading underscores from such identifiers.
> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier
> 
> Regards,
> Markus

Thanks for your suggestion, does this look better?
#ifndef MFD_PHOTONICAT_PMU_H
#define MFD_PHOTONICAT_PMU_H

Best regards,
Junhao

