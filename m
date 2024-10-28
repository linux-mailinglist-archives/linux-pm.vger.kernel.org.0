Return-Path: <linux-pm+bounces-16596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C29B3644
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622D5B258DD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BF189913;
	Mon, 28 Oct 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="QjttJ2jj"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40C187858;
	Mon, 28 Oct 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132300; cv=none; b=ltZwpvRfaZRK2xjVO7UN9IHgjxNnqN7JrJ8+6F/s+3cl7E76SVWpBJlm+XwjjF/fk8qhzD80Ug8P77M/hr5T2N52YAaOHo0j/4CegLJhz5H7V6dl/y99Ff/vpSk6XDaEPPu/C0z+0a9shKoCJx/oB3vpAJAa3WldNadWmrUbn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132300; c=relaxed/simple;
	bh=YoAEfFnB+V3/NmHgOaM2JE6lzsCnn8ETFlwcY21yX/8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tNv+FxzAOG455uN0EzG0VnQoWSgoHgtX4UtMx7ROmAkBnuvWSFEebBQVY5s0GVkDAKmzJcvzzC7GRoLbXz3alfn2vf9xT/qH7OYX+YdwFFV9H9hRYzRAmEOaPZPgv3DS15GaHx3Yt4uUF/Ulnfuv8tpFjdcYNj1JWK8FZOWkTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=QjttJ2jj; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730132297;
	bh=YoAEfFnB+V3/NmHgOaM2JE6lzsCnn8ETFlwcY21yX/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QjttJ2jjANICFZZcgAkdevl4qluQAJt5palAzr2xB3gwWDo2dn6m6yNlzcN/CvKvC
	 WqnO3/eajzfFkkdfwd9cFHr5f+3Nwcm0u2CbnQ4t1+eSCK6odtSK+N4eyAmyJbNDgJ
	 hW0nUSZB9YRYmQUMu3f1y/8l0s1XkcTv2VGtu6lPmeUvX8+3CEd5LgYZY3y+fyoabg
	 C5izUBqMH1kIZ7TsjqpwL4myeXLafb5pO+jjWru0sUP+8GL5vPfc/EvlrH1wTLKEQs
	 Bhd64q2kqD2SDAv4Sotwc03IO4PzOGS2CoxpuvToKG3b3E9XjKoha4ywJMK6rIU889
	 Ag+CLOlXEJSiQ==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:18:16 -0300
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
In-Reply-To: <abf7d194-80b5-410e-8f6f-b1f9e40cd893@linaro.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-12-masterr3c0rd@epochal.quest>
 <7dybkf3zveidwapwfivvq3jk6qxntuqgycndff3ajjl2owhjhn@khqgycnzh76j>
 <13a5e833ce19df20b0420d7f1052fd96@epochal.quest>
 <abf7d194-80b5-410e-8f6f-b1f9e40cd893@linaro.org>
Message-ID: <5cd57cad0847d9c61955ea12b35f8457@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 6:17 pm, Krzysztof Kozlowski wrote:
> On 27/10/2024 22:13, Cody Eksal wrote:
>> On 2024/10/27 5:47 pm, Krzysztof Kozlowski wrote:
>>> On Thu, Oct 24, 2024 at 02:05:29PM -0300, Cody Eksal wrote:
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>> index ec5e424bb3c8..603c6c88d080 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>> +++
>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>> @@ -23,6 +23,7 @@ properties:
>>>>    compatible:
>>>>      enum:
>>>>        - allwinner,sun50i-h6-operating-points
>>>> +      - allwinner,sun50i-a100-operating-points
>>>>        - allwinner,sun50i-h616-operating-points
>>> 
>>> I have no clue why a100 is between h6 and h616. :/
>>  From my understanding, the A100 was released before the H616, but 
>> after
>> the H6. There are not many sources to rely on for this, but the H6
>> appears to have launched in 2017, the A100 in 2019, and the H616 in
>> 2020.
>> 
>> I assumed ordering was intended to be in chronological order; perhaps 
>> it
>> was intended to be in lexicographical order instead? If so, I can move
>> this entry above the H6.
> 
> Most, really most of the lists in the bindings are ordered
> alphanumerically, because that's the only order all people will get and
> all people can really verify. There are exceptions. If that's the one
> here, then sure, keep chronological order.
After reviewing other files, it seems like alphanumeric ordering is 
normally used in the bindings for these peripherals. I'll update in V2.

Thank you!
- Cody
> Best regards,
> Krzysztof

