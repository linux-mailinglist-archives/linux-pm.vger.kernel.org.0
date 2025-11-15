Return-Path: <linux-pm+bounces-38085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07668C607E7
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C335F129
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E922877D6;
	Sat, 15 Nov 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Cq3CwOBr"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A2224AF0;
	Sat, 15 Nov 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763221510; cv=none; b=mGMSran2WnoWuSpD0eOOdWbCKVHnyPJa3KPGdMJlPQbLbHRCcaocReUTuKECfpJOPLYzUJFDX3HBEULao3ZwtJMfftO6X3ORDD5LqkjInKKHGm8mNH2lMpXnghtD/p+4n2bjny+4/2ZjuToDfScmPs0xDLgSwlS+iCdVayb3qE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763221510; c=relaxed/simple;
	bh=Gyudq4S0PXURJ1G6M09B9etnlI7DjqgFnLsAvK6sZrQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MnJ1vim0tt00Yg+ioyFppWTpuR+tAGgcjN2oi7kjDPbJjpFm1hXcppI7OWhFmDT5VkxDfl7l/Hq+jxIkQYx6C5Aj2hhIkI5n9mQAF2zpETbaLbb4zhyQW9RN1Xb/b6MgjNYP/hTgB7ewuuhszYYYI2Pyz8ad4cwCB8pHtgbKFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Cq3CwOBr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EFB6B25F6C;
	Sat, 15 Nov 2025 16:45:03 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsCnIKgPNtPw; Sat, 15 Nov 2025 16:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763221503; bh=Gyudq4S0PXURJ1G6M09B9etnlI7DjqgFnLsAvK6sZrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cq3CwOBrBz8UtUgIqT3ZyZIeqpI6ItiBbXnl7RML0b/SPP+jmtZ9s/pDm6P6CW1nd
	 Nso0e7QvwFm3grc0NnozIg8YAnHtdt8WqXsMdlDO9zzYCK4axH2vknnNNDB5kN0NJS
	 y9vdojWjFuDOtiO4KWZDIlB2t3rKxLtWvTz/DoKgbBkN+UTdKP21cVlUsqFXCZaSS1
	 ttFE/K6+m9Ei1m8LfJkCIY5vcyY4Q7erdBl/ySUfwRO0I1ddroz5UETu5TVbyqBuWR
	 2XQdvcZZ8702F4KDbcfHcuJ54P1Drdt7dqhNRodAfFEtv7At9gRrSKgH5NtGKFEjcQ
	 0PKfI9u1xOjlA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Nov 2025 15:45:02 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/13] mfd: sec-irq: add support for creating multiple IRQ
 chips
In-Reply-To: <6479a8d84052b326ffeb5609959aaf3a1aac9ff8.camel@linaro.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-6-9e3184d3a0c9@disroot.org>
 <20251114075004a444bff0@mail.local>
 <6479a8d84052b326ffeb5609959aaf3a1aac9ff8.camel@linaro.org>
Message-ID: <efb5bdb045116ef467cdfa64b09d309f@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-11-14 11:55, André Draszik wrote:
> On Fri, 2025-11-14 at 08:50 +0100, Alexandre Belloni wrote:
>> On 14/11/2025 00:35:07+0530, Kaustabh Chakraborty wrote:
>> > The current state of the driver only allows creating only one IRQ chip
>> > per PMIC. On some PMICs, such as Samsung's S2MU005, there are multiple
>> > interrupt blocks, for which the current implementation stands insufficient.
>> > 
>> > Add support for creating multiple IRQ chips for a PMIC. Every IRQ chip is
>> > given it's own index, which is used by sub-device drivers to request IRQs.
>> > 
>> > A macro is defined which states the maximum number of chips supported.
>> > It's set to 1 as currently, no PMIC requires more than one IRQ chip. The
>> > value must be changed accordingly on adding new PMICs requiring multiple
>> > IRQ chips.
>> > 
>> > Moreover, adjust the s5m RTC driver to initialize IRQs with the
>> > appropriate IRQ chip index.
>> > 
>> > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> 
>> > ---
>> >  drivers/mfd/sec-irq.c            | 163 +++++++++++++++++++++++----------------
>> >  drivers/rtc/rtc-s5m.c            |  15 +++-
>> >  include/linux/mfd/samsung/core.h |   5 +-
>> >  include/linux/mfd/samsung/irq.h  |  14 ++++
>> >  4 files changed, 127 insertions(+), 70 deletions(-)
> 
> Your patch reminded me to finally send
> https://lore.kernel.org/all/20251114-s5m-alarm-v1-0-c9b3bebae65f@linaro.org/
> 
> If applied first, you wouldn't need to touch rtc-s5m.c I believe.

Oo, this cleans things up greatly!

> 
> Equally, I can rebase mine on top of yours - no strong feelings.

I will wait for your series to be applied. Your series is much shorter,
so wouldn't hold that back for this. :)

> 
> Cheers,
> Andre'

