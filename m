Return-Path: <linux-pm+bounces-16601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2B9B369C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398CD285FB7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526501DED7F;
	Mon, 28 Oct 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="ZgS7BZdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AB1DE4D5;
	Mon, 28 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133351; cv=none; b=LULxMDN2iCDOp9kbNA+2JyusnFZOYXRaOOvQ7o9s+BE9vhckrwMiGhGZi+266Dp2qtM4+UUAEHsRWQHjd5/pkGTMUQ9eV14cXgL+hyisswnHM3eOOBYM+iiWo7LaUdVokI3GAx3z9UkwKrigCOAAD/c4F2BZ8vVNsiPwvEZ8s2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133351; c=relaxed/simple;
	bh=SgbZ6d/TsfOwGbc31ZKuYuZl628O9USHtGUALdy8B+A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ij2wFfVjDjTc18Yob7pRoOShiQcvj2CNUyZ2osx2PtarrZX8c3+nYpE5b4cer5ENRZfnUotU/CfpAEiIZbyTvk9W4pXrky8eiiA5H7QTjnh7JgyrWmIGvulyICSqAkmoLL9sHPuR6ZaUgHlJNyaYJtk9stLlu/9BRKCSYeCjT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=ZgS7BZdH; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730133348;
	bh=SgbZ6d/TsfOwGbc31ZKuYuZl628O9USHtGUALdy8B+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZgS7BZdH9XB4Xl54n/5i1z3TmXuFPGbZT7e1yyh6uidffhW5fJX3UtOgD2UeUYK1h
	 aPieFahk0TWr7mrR5UR2vvYcP5G9n0GfgeYuBZezw2UKR5niDymDl8Chm2YXq1yxqd
	 vV4KAWsY0azGRYxHjbp5QIGL1rr6H6czLNQ6yUZmoFu5Ga1u8VcJoyhLXkD0lsoVNi
	 T2CoAgCcSGveBqJ5QOz7kqvpbcs/+pHyUxwaXhJI4d0jDTHHpou488yykXHXa3FNB2
	 SauQb81+iQBLuqZg93k1S5j7eQe03frPSqwIwgzzfHf1Vz5qoXIeBK2irb+YrAK9yQ
	 VpuH4DjlbmtDw==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:35:46 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: wens@csie.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Parthiban <parthiban@linumiz.com>,
 Yangtao Li <frank@allwinnertech.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 07/13] arm64: dts: allwinner: a100: add usb related nodes
In-Reply-To: <CAGb2v64tQ_9C3mwJqt-tm-6SV=SHAk75sO5Ho7gT=p=iyRfLcw@mail.gmail.com>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-8-masterr3c0rd@epochal.quest>
 <CAGb2v64tQ_9C3mwJqt-tm-6SV=SHAk75sO5Ho7gT=p=iyRfLcw@mail.gmail.com>
Message-ID: <542c16a63ab228a7ed1cc81fc91b961f@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/25 10:29 pm, Chen-Yu Tsai wrote:
> On Fri, Oct 25, 2024 at 1:09 AM Cody Eksal <masterr3c0rd@epochal.quest> 
> wrote:
>> 
>> From: Yangtao Li <frank@allwinnertech.com>
>> 
>> Allwinner A64 have two HCI USB controllers, a OTG controller and a USB
> 
>             ^^^ Please update this.
I wasn't sure if I was supposed to update the commit messages; a few 
others have grammar errors as well. I'll fix those alongside this one in 
V2.

Thanks!
- Cody
>> PHY device, let's add nodes on dts.
>> 
>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>> [masterr3c0rd@epochal.quest: fallback to a33-musb instead of h3-musb]
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>> ---
>>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 
>> +++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>> index adb11b26045f..0aee1b578661 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi

