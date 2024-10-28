Return-Path: <linux-pm+bounces-16590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8389B35A5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC641C21A11
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A5190664;
	Mon, 28 Oct 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="gcagMSus"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777E1CF2A6;
	Mon, 28 Oct 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131378; cv=none; b=FTquaUHoIYKgQLua3iL8N1eSyuI7EOSVrkoZLBuR1y37GQgI6gtB6/L/tu5GgwKfjo6x3J99QuXgJDvE+RG1aN/5R0zKPJgMr9VSAwixhHaa4wiR4ITyKk1p4GLji87nlAErcWMxutP2XShYZUabwCzdKHU7tvfJsukFNW+aouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131378; c=relaxed/simple;
	bh=sGz1MZtYtIAXCdIv2GYocDtQn9poOcj8dVPhnWb0PYY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qa/y6n2mDd2UdFH+JN62wixVUK97vDRSSf8JZDKKvk3Ogb9Fle7riU6CcbjUVWp9zr7aGBjgc/tkPTDAFAEGabBIb3pYksmCXssIiEoCgDt/SCc8T/SgZMANWMwvFFA2iTHoYSRcuDvJHX79v90KT1Jy1S49OWAX5a3dIwBy0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=gcagMSus; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730131373;
	bh=sGz1MZtYtIAXCdIv2GYocDtQn9poOcj8dVPhnWb0PYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcagMSusHy1ACi/Ypcm2ButvGGg3WyRpHpAQ3vvktCAOaTDx+T7ghwQlXxq4XCn1a
	 GFxkunPHHdItCgFmDb7ca+o0t0L+mYL0oe/ykXK1M+kjt0yAh4X4qpQkQNyUYeG89U
	 O9ynTWBHiV0Nhf51J6mmMBO/0K9VkfnDYmvOD1ZphmQUefhT2vdKRxWtj8QamTcJ4A
	 pzaXixyp5eEE7BYZ2FGxlmQWVa18ggjr7LupZy6u7jvi84+udIbgkqgBDrziSZEzEy
	 NG3vqot4ywjU8hxFqPbwLi6nlHos29LkfCWmPHjbEZQD/gA+UVUg0acK5zy0GuX985
	 EoyOSwey4ogsQ==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:02:50 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-sunxi@lists.linux.dev, Yangtao Li
 <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, linux-pm@vger.kernel.org, Andre Przywara
 <andre.przywara@arm.com>, Yangtao Li <frank@allwinnertech.com>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Linus
 Walleij <linus.walleij@linaro.org>, Parthiban <parthiban@linumiz.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, linux-usb@vger.kernel.org, Samuel Holland
 <samuel@sholland.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding
 <treding@nvidia.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: usb: Add A100 compatible string
In-Reply-To: <20241027212253.GA98977-robh@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-5-masterr3c0rd@epochal.quest>
 <173006354857.88418.13246529686874362124.robh@kernel.org>
 <20241027212253.GA98977-robh@kernel.org>
Message-ID: <e3c1d138f2916736dc2a825a0f431066@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 6:22 pm, Rob Herring wrote:
> On Sun, Oct 27, 2024 at 04:12:29PM -0500, Rob Herring (Arm) wrote:
>> 
>> On Thu, 24 Oct 2024 14:05:22 -0300, Cody Eksal wrote:
>> > The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
>> > controllers. Add their compatible strings to the list of
>> > generic OHCI/EHCI controllers.
>> >
>> > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>> > ---
>> >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>> >  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
>> >  2 files changed, 2 insertions(+)
>> >
>> 
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Well, except that the compatibles should be alphabetical order.
Will be fixed in V2, thanks!
- Cody
> Rob

