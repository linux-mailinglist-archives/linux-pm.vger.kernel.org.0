Return-Path: <linux-pm+bounces-10356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358BA9241EF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C77B2812E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2ED1BB695;
	Tue,  2 Jul 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbn7Iixo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7CF1DFFC;
	Tue,  2 Jul 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932985; cv=none; b=BUuI/6nwO5vdP3IVr3aW/nkyl2C5gNuXC6ncORIgf7uZ6it3SfCQWsBAWWxTQO1MPwmKItpFmJU6JhvZ4LQM/lop8batbrJEJqBjb7bJ+2sdzfhS70pyJ3wB9mTx3HaVjB1F61U+ShzwTSj6rihF+40Zkp0JJUqVIEFt5proXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932985; c=relaxed/simple;
	bh=3rky5boCD+BEu0E1VUYi9tbu3OeD4rpuUTcTyB8aeuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unhfSsv5lN0V53LllPiXabP7ofW6RDPm1o8GEyfAhwva7dcrdYF0iW83bW4Re46oEpqZgBVaeisTXWjbhQ/0hEDg+qIB7BeOz94UueL7Xb4SDYz07EslkNeIeka3rZ99RixmOzIe1I9Uei/2r/jIo6cpO1syfL34Nw/3WvgXXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbn7Iixo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802E3C116B1;
	Tue,  2 Jul 2024 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932984;
	bh=3rky5boCD+BEu0E1VUYi9tbu3OeD4rpuUTcTyB8aeuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cbn7Iixol4kRCfBatC8RPwq5Jt2TggorrBxyqyhZ+3agbEQGTo6wPjp7TPxJSkp8n
	 ZJnarubL0csXGLcuD7QWf2NnEHjae2E+qB6sd74a1UO+u/4WxmezzYOdBXBZ6qGKwf
	 3HGuMTr7p+r6vf1mC2bGFKLadaNA37NIa0mtSUwkuNTKgusQtn6heJMMB3d0/zb/+5
	 JJSgyWeYYqqvL+YhRGbnOKXontoCi/S0LFC0cNvh7p72657c5M9cmh2bqC0n8kFZav
	 seO/UHKBBm0TFEiYmvNMJXkt9xKz6/2Mll3vy+4grva6wj4DY/IG4RrMsrO//7zUjJ
	 t28zE4GD/VhBQ==
Message-ID: <d4b71376-2864-45af-8ad9-92c8a7cde291@kernel.org>
Date: Tue, 2 Jul 2024 17:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
To: Conor Dooley <conor@kernel.org>, Haylen Chu <heylenay@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <20240702-aptitude-overripe-8ac9aa3c6b90@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240702-aptitude-overripe-8ac9aa3c6b90@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 17:00, Conor Dooley wrote:
> Rob/Krzysztof, Haylen,
>> +
>> +maintainers:
>> +  - Haylen Chu <heylenay@outlook.com>
>> +
>> +description: Binding for Sophgo CV1800 on-SoC thermal sensor

Drop "Binding"

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sophgo,cv1800-thermal
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: The thermal sensor clock
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  accumulation-period:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Accumulation period for a sample
>> +    enum:
>> +      - 512
>> +      - 1024
>> +      - 2048
>> +      - 4096
>> +    default: 2048
>> +
>> +  chop-period:

period in what sort of units? Sounds like time to me, so this would
require proper unit suffix.

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: ADC chop period
>> +    enum:
>> +      - 128
>> +      - 256
>> +      - 512
>> +      - 1024
>> +    default: 1024
>> +
>> +  sample-cycle-us:
> 
> the more common term btw would be "sample-rate" rather than
> "sample-cycle".

yeah, sample-rate-hz

> 
>> +    description: Period between samples. Should be greater than 524us.
> 
> The constraint here should be "minimum: 524". What's the upper limit?
> 
>> +    default: 1000000
> 
> Rob/Krzysztof, could you comment on the suitability of the three custom
> properties here? I know if this was an IIO device, these kinds of things
> would be controllable from userspace, and not in the binding. I
> mentioned this on the previous version, but I'm not really sure if
> thermal devices are somehow different:
> https://lore.kernel.org/all/SEYPR01MB4221A739D0645EF0255336EBD7CE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/
> 

Why would different boards have different values here? Does it affect
accuracy? If so, how much?

I doubt there are any boards with different values, thus it sounds like
unnecessary tuning parameter.

Best regards,
Krzysztof


