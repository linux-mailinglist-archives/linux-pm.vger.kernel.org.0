Return-Path: <linux-pm+bounces-16530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2309B20BF
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81D01F21AB8
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0E186294;
	Sun, 27 Oct 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="FuwAK7Nd"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B365684;
	Sun, 27 Oct 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063635; cv=none; b=eOGv3d5FKelLeA27SxJOPNn+15G1bHbRVrFBMiysL+/KZQ9qi968DepNK4+xpZx3ZRcc4L8abVl/cyC2JyZ9ofshSe+PjPwkvnZ8m1RjkajBQjC5L+VL72Y9lz5bcBJnNAcLVTq26kwxQrU+C9/oJ9kgmvn+G0+SNeIEUYdwQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063635; c=relaxed/simple;
	bh=9QcJyUO4rgbvh0nZF74gzlP4IEdWBHI4BsTfagAk9YA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cblmXGF/B0IA1nELwyTTs/F36aCH//vh7zxC9iM94YUPmkOQhqrwsZjWrlCovMva35QvliQLflMZZVEhX/Twu6cOeJW0bfmR5qJ1NZbqu+Rs/UBM+N3qh2XaPiUDDysxbpz5Zt3bORHwweZxNapCgFMX7E4FIq8lvC36r930MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=FuwAK7Nd; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730063626;
	bh=9QcJyUO4rgbvh0nZF74gzlP4IEdWBHI4BsTfagAk9YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FuwAK7NdLwxMj68iES/Wcypbkr/KF98eAUuzibyV5kzOusZ6ZXMDsDOywIk/orzv7
	 TwqwP0+JBShS3xV4i3E+vsNTTeC+Vhejc32LlyZ3CdUNffGawfFa67q48G+bIZkWG+
	 O5z0ZacO9KRdNjKzofE9pYO9KBKsdnAQSHci+buXGCtkYAiAQJqA7hK6RnQj3JsZiH
	 NzW1JP1YEEfNdhmOZ3tk0IThlPjILadtVNLoIcFTAvzuwFwSHFqXt+LTEBSA7tcaoi
	 9eMPTvYJ/twTrWe0s64rVk5POU6HonaUAYvKo8TBtxv/l38m9tf+J6ttt8Bl8yd+pd
	 y8kbFDqrL/i4A==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 18:13:44 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Andre Przywara
 <andre.przywara@arm.com>, Parthiban <parthiban@linumiz.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH 11/13] dt-bindings: opp: h6: Add A100 operating points
In-Reply-To: <7dybkf3zveidwapwfivvq3jk6qxntuqgycndff3ajjl2owhjhn@khqgycnzh76j>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-12-masterr3c0rd@epochal.quest>
 <7dybkf3zveidwapwfivvq3jk6qxntuqgycndff3ajjl2owhjhn@khqgycnzh76j>
Message-ID: <13a5e833ce19df20b0420d7f1052fd96@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 5:47 pm, Krzysztof Kozlowski wrote:
> On Thu, Oct 24, 2024 at 02:05:29PM -0300, Cody Eksal wrote:
>> diff --git 
>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml 
>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> index ec5e424bb3c8..603c6c88d080 100644
>> --- 
>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> @@ -23,6 +23,7 @@ properties:
>>    compatible:
>>      enum:
>>        - allwinner,sun50i-h6-operating-points
>> +      - allwinner,sun50i-a100-operating-points
>>        - allwinner,sun50i-h616-operating-points
> 
> I have no clue why a100 is between h6 and h616. :/
 From my understanding, the A100 was released before the H616, but after 
the H6. There are not many sources to rely on for this, but the H6 
appears to have launched in 2017, the A100 in 2019, and the H616 in 
2020.

I assumed ordering was intended to be in chronological order; perhaps it 
was intended to be in lexicographical order instead? If so, I can move 
this entry above the H6.

- Cody
> Best regards,
> Krzysztof

