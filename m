Return-Path: <linux-pm+bounces-16591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3D9B35C5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C79B22118
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4D1DED66;
	Mon, 28 Oct 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="IM7SQiOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF21DED5E;
	Mon, 28 Oct 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131613; cv=none; b=I6d/qPFQV32qQ+HkdYBa0WN/1AHFWB7an8+x1T//cPHcpuXMZOCtz5o+hYKFTwcTZs6b3H8FYUHiqU21DCqsz1TDzbxZUJ3ZBudQqxB5KAHh3G52DFel6gavkPrPu8B3G1B++lIlEANx38YUEaggeyOeQpK/nAna1Mrx53VQMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131613; c=relaxed/simple;
	bh=Bu58v2gr38UKxgFPQsmkozo+upmq0xR+OgYGP8APTu0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A1Q/AkL8sJJkB3xMDuD/qPmu3rIHwqTZvX5QL9VistQXxbwtaMaHbOnNkzLV85TPM8eS1BAryyNeCkQdLDMfv2VQYM0jOiEr1ZC2p1V2neuqLQj9WmWjVucTOfSMhIeaHcNHAGJNnyFmazlb6xByN+sv2FnRcstGQS5rtkAzPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=IM7SQiOv; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730131609;
	bh=Bu58v2gr38UKxgFPQsmkozo+upmq0xR+OgYGP8APTu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IM7SQiOvG7FJObmipWN8JTq47jKeael3a2b8Q6gnuceSY6J+yNMxhDmxAmuWj7EkP
	 YuV92LsR4eoZvbj4dnYwmDRIV/S1AEqQ+kidPEm42ZjWfu+dYcu9DlcYoJJn89i8CP
	 WhhNvG52oeCzbGaB4InOH+YCHsC+0f+OT4qPUEYHOi4nwQiSpj+IMsfyVZAU9cqUeM
	 iMvgq1Ek/lqRbMk/xeCB3dQWrvMQBneH5vdSGfXvJXlM+t8Lv6F20fUEDC/hROSHO8
	 8Y5TvAWX/92Q2t/G7gFHn8jNsYr7Nk3UYO9Hq4jt6krloaONiYqfBW9XDWI9tEqZvw
	 tv/pc+yqAHLGw==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:06:48 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Parthiban <parthiban@linumiz.com>, Yangtao Li <frank@allwinnertech.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Vinod Koul
 <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 05/13] dt-bindings: usb: sunxi-musb: Add A100 compatible
 string
In-Reply-To: <cdfocja5u4jh6xh2jkouzyztsjinggep45ymbdwxc4zpscy376@i5voj36oqrrf>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-6-masterr3c0rd@epochal.quest>
 <cdfocja5u4jh6xh2jkouzyztsjinggep45ymbdwxc4zpscy376@i5voj36oqrrf>
Message-ID: <91fc635a58ce647a3183d17c35e33ba4@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 5:47 pm, Krzysztof Kozlowski wrote:
> On Thu, Oct 24, 2024 at 02:05:23PM -0300, Cody Eksal wrote:
>> diff --git 
>> a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml 
>> b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
>> index f972ce976e86..d4993336a29b 100644
>> --- 
>> a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
>> @@ -24,6 +24,7 @@ properties:
>>                - allwinner,sun8i-a83t-musb
>>                - allwinner,sun20i-d1-musb
>>                - allwinner,sun50i-h6-musb
>> +              - allwinner,sun50i-a100-musb
> 
> List looked ordered, now doesn't.... are you sure you keep intented
> ordering here?
I'll move this entry to fit the expected order for V2, thanks!

- Cody
> Best regards,
> Krzysztof

