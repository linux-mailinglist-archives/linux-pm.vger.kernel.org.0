Return-Path: <linux-pm+bounces-23495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB7A50689
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 18:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888AC188BA68
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EA250BE2;
	Wed,  5 Mar 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B9Ndt8Jr"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA719F121;
	Wed,  5 Mar 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196360; cv=none; b=eJPfrlTpM2+yzigLMGbCImxHaaW4lsGl1mjZpxkFWf1p5aTwWbjwW7JOf+aE0NTOHya0C55V0Cy6JM+wBN7qezrRzqmWjv55a2szJ0CFIGAWn7fojkf88b5jsqNuxOEuuP0tAxDLNQvdv2M9oc96/RCq9O3zfYfkoES4VXzimV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196360; c=relaxed/simple;
	bh=x06wZ4JzzQdXv+skj8Mdw6FwOmNgc2Hi3vw3FdY5VlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cUjYeYz6Kdgu/cnb9vXnUoRKgmwapztWJZnhqUYBX8HOJBrP9jkz8YQc15ioQIFlI2dI9Oi1flohb5TjBlmxR6rCBl6Y/y1PWWOGfQKpxHj26zVSWhcyEL7LkRCoRLC8vedV/ATjQsuZfdqPT5gRHDsJ251R4tJ9BTlwqnOXOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B9Ndt8Jr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741196359; x=1772732359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x06wZ4JzzQdXv+skj8Mdw6FwOmNgc2Hi3vw3FdY5VlQ=;
  b=B9Ndt8Jrt9F/t8dghQ6FZpkCMmqN/FiEBeF0FdVjFXeHwEbEz8ydJ3fq
   FnZxphr38Ahrg+4Y9zqmbQh/9U0ap0SKylnOCIjCe55jMFRlMko+BOr1v
   HJAp+UqAxZk0O4q76GoLk9OENWkdMNN6OtTmd1im63XKSR9RcGk6Jctxa
   YwlVQ0ChitFOGAlA/0CEJ1PbPSRC+LltMmSzzG7CbLeHBkHXZLjG0lK7L
   asfklyrlgj9MV9a7rRlXdZxvpeG0wb3HIJcNaGbftxEc/j//RESrTqfE0
   Cfz6W4Ud7dElYaVkMaZaIz/o9z/PA8ma2Gq0dTl/ylDXR/bpXGqD1YYgR
   g==;
X-CSE-ConnectionGUID: aDhkZa15Rdq5O/AlBZMFPg==
X-CSE-MsgGUID: Xn9qTDuOTZypoTdWoRNdMg==
X-IronPort-AV: E=Sophos;i="6.14,223,1736838000"; 
   d="scan'208";a="269856430"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2025 10:39:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Mar 2025 10:39:07 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Mar 2025 10:39:07 -0700
Message-ID: <ebb161f2-632b-4d10-8c5c-4187a06a06c8@microchip.com>
Date: Wed, 5 Mar 2025 10:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<sre@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <2a18e305-090c-41fe-9b27-97ebe93fd4e4@tuxon.dev>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <2a18e305-090c-41fe-9b27-97ebe93fd4e4@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 3/3/25 01:40, Claudiu Beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 27.02.2025 17:51, Ryan.Wanner@microchip.com wrote:
>> Ryan Wanner (20):
>>   ARM: at91: Add PM support to sama7d65
>>   ARM: at91: pm: add DT compatible support for sama7d65
>>   ARM: at91: PM: Add Backup mode for SAMA7D65
>>   ARM: at91: pm: Enable ULP0/ULP1 for SAMA7D65
> 
> Applied to at91-soc with some adjustments, please check!
Checked! This is correct.
> 
>>   ARM: dts: microchip: sama7d65: Add Reset Controller to sama7d65 SoC
>>   ARM: dts: microchip: sama7d65: Add Shutdown controller support
>>   ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
>>   ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
>>   ARM: dts: microchip: sama7d65: Enable shutdown controller
> 
> Applied to at91-dt with some adjustments, please check!
Same here

Thank you!
> 
> Thank you!


