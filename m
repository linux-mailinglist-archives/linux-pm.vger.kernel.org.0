Return-Path: <linux-pm+bounces-33903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD93B44E72
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3233B7C37
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6AD2D6E63;
	Fri,  5 Sep 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms4kB5hR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F602D320E;
	Fri,  5 Sep 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055419; cv=none; b=EjRv+4DrDR9qgh9YFj5fIqWLRjSXWSy56TfIIxa1rLGsItNLI6C6lUgMqzeBJ9EujPT65f3kNu83TVrpyV6UmlNuGwVDNV7bmsWNGJzxoQpTuEYii9oaiM946qRmuBsbwLEJgyHu1nDFxNWZOmrQLA4DwUNQMPoBx7QBPc5ZrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055419; c=relaxed/simple;
	bh=uyFr8wxxfdR7aQYmyIRkP6+JdlV8SLol7rwk9pzJiHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9usu1k7g7TeV3irZyFFFY2TzNIp0K9WFawjBQJldaebQMf2oyAzebEGXnjEGJTncGIWkG6GQBPPfVKG7PhsSX1oOdh1K4SspjHYOLNGYCGzcQgMISi67xW1637SJceRxL1vaX0/NCSuzqQQX294hPREQAHAObkSMHa+EOjkhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms4kB5hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B87C4CEF1;
	Fri,  5 Sep 2025 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757055419;
	bh=uyFr8wxxfdR7aQYmyIRkP6+JdlV8SLol7rwk9pzJiHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ms4kB5hRXdSwJtIEDgY176SzYJ9i7DwB6lYiJLEo7v2gsHfkawDrVvJxqcy5OkaZP
	 eK/D6IvM6esNyKcKvI3475cQVfDQ675K1YAVUpfgDS8etfrbPYX7NeBYS2GAhFfYhN
	 NddOOi3O9Ui9M4yFx4U5d6QacamueHaUSi6AeJg+Rtg8Kvh00dRLtQoPJQ7vDQ0xgn
	 uTz/VyJeBAAVE/WViT94o+vXysBHUdKlcyRn6C/QxHFmG8v9WAQ3zwhWLmQYfF2OwP
	 /lzkdwtBh9FnTwt0mAw6hiRlWgwghjM1GkVVG+w6GN6iNY+KYzmeObBrfcXsGUq90G
	 Hc7YpocH8z04w==
Message-ID: <c64f09f5-440f-411d-b2f1-6c85b9adffb7@kernel.org>
Date: Fri, 5 Sep 2025 08:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: memory: tegra210: Add memory client
 IDs
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com>
 <20250904-honest-accurate-bullfrog-fdeaf9@kuoka>
 <CALHNRZ8DEYq-DOC6jV8TAqGznd8e2mzfS7Xs61Gp3R5visPFzw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CALHNRZ8DEYq-DOC6jV8TAqGznd8e2mzfS7Xs61Gp3R5visPFzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 19:33, Aaron Kling wrote:
> On Thu, Sep 4, 2025 at 3:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Wed, Sep 03, 2025 at 02:50:07PM -0500, Aaron Kling wrote:
>>> Each memory client has unique hardware ID, add these IDs.
>>>
>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>> ---
>>>  include/dt-bindings/memory/tegra210-mc.h | 58 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 58 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
>>> index 5e082547f1794cba1f72872782e04d8747863b6d..48474942a000e049142014e3bcc132b88bf1a92d 100644
>>> --- a/include/dt-bindings/memory/tegra210-mc.h
>>> +++ b/include/dt-bindings/memory/tegra210-mc.h
>>> @@ -75,4 +75,62 @@
>>>  #define TEGRA210_MC_RESET_ETR                28
>>>  #define TEGRA210_MC_RESET_TSECB              29
>>>
>>> +#define TEGRA210_MC_PTCR             0
>>
>> There is no driver user of this ABI, so does not look like a binding.
>>
>> You have entire commit msg to clarify such unusual things, like lack of
>> users. Please use it.
> 
> The tegra210-mc driver has these hardcoded and should probably be
> updated to use the bindings instead, but I think that's outside of the
> scope of this series. I will clarify such in the updated message.

If you introduce the binding, change the drivers to use it. Otherwise
there is no point benefit in this binding, really.

> 
> Aaron


Best regards,
Krzysztof

