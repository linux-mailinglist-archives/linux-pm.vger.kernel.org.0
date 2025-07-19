Return-Path: <linux-pm+bounces-31085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B8B0B01E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5E8189CC58
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 13:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D3287275;
	Sat, 19 Jul 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXg9BoHT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE93597E;
	Sat, 19 Jul 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752929867; cv=none; b=qzJJoR47VKFLcs9ergKK4KBh3ZW8kBu5wQEycXstGS26MZnLNQDLuApV/vaCrpU45Ff0Hpy7MT4wtCBXfctWuFZDx+zG5PSIfjSUQbudhLJZ7EVcZqFvSCVXhU3z6lowTlCA+WDGHjvvAIElUe5Sgh5LG+SMaeP3Wvz+RIsogu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752929867; c=relaxed/simple;
	bh=C37ie8I+20jkjConEf+5/eKxSa7Tx/KOav8UbMQf704=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9XMffLrrr36iPZWDBnG0l8bvdN2VBtxb5uMSSJQmWk3N7CvXNqLv3UlgeXL6iobL1ZHK9fIqZMgttiOkHNDBNMevwG4Q90Kt+Vuz55gE8u9NMwnZyB6u9upH8nWJ4bzLsGGt+rfLGxh3Z+a+u+zADjW4IhpVo49tRVDH1oy8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXg9BoHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D56FC4CEE3;
	Sat, 19 Jul 2025 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752929866;
	bh=C37ie8I+20jkjConEf+5/eKxSa7Tx/KOav8UbMQf704=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jXg9BoHTkrXiMC1Pu4Xx63OY4txlLPVfqDoPW8+rAwgY4KYJ5FRtMkkCHC1gZ5G2J
	 Xrc/Q5JAA723pP0cTOovmNBwdENUYnElmVoX8GvqJY793dZYwUhJCXo/xa9lf4h3XY
	 ap2rFNFvAmSf2F3TBOpSuBNrzkQDz5wVuuT99uJwVC/3YNtQh1BYlvmtxkN/VjwEIM
	 ldnaIFVtbyDLvOrhyyQ9o5dpdzE5JZmvlxhyupDUriINIb3FkqhO3OwDdR3nvbBbNp
	 kpOdS4ojfgAqsOX+4U5Kz8nLwO/mGZ7pJqMcLmaBqZHTdXFaChaP8vSB1DDX54eUDa
	 p7CgfqmR7PvUQ==
Message-ID: <a67fcfc9-e708-47db-8605-e20a8b54b0d1@kernel.org>
Date: Sat, 19 Jul 2025 14:57:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
To: Lee Jones <lee@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>
 <20250619114958.GJ587864@google.com>
 <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>
 <20250624155340.GL795775@google.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250624155340.GL795775@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.25 17:53, Lee Jones wrote:
> On Sat, 21 Jun 2025, Sven Peter wrote:
> 
>> On 19.06.25 13:49, Lee Jones wrote:
>>> On Tue, 10 Jun 2025, Sven Peter wrote:
>>>
>>>> The System Management Controller (SMC) on Apple Silicon machines is a
>>>> piece of hardware that exposes various functionalities such as
>>>> temperature sensors, voltage/power meters, shutdown/reboot handling,
>>>> GPIOs and more.
>>>>
>>>> Communication happens via a shared mailbox using the RTKit protocol
>>>> which is also used for other co-processors. The SMC protocol then allows
>>>> reading and writing many different keys which implement the various
>>>> features. The MFD core device handles this protocol and exposes it
>>>> to the sub-devices.
>>>>
>>>> Some of the sub-devices are potentially also useful on pre-M1 Apple
>>>> machines and support for SMCs on these machines can be added at a later
>>>> time.
>>>>
>>>> Co-developed-by: Hector Martin <marcan@marcan.st>
>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>>> Signed-off-by: Sven Peter <sven@kernel.org>
>>>> ---
>>>>    MAINTAINERS                |   2 +
>>>>    drivers/mfd/Kconfig        |  18 ++
>>>>    drivers/mfd/Makefile       |   1 +
>>>>    drivers/mfd/macsmc.c       | 498 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
>>>>    5 files changed, 798 insertions(+)
>>>
>>> This is ready.  Let me know when you have all of the other driver/* Acks.
>>>
>>
>> They've all been reviewed by the respective maintainers.
>>
>> I assume you want to take this all through the mfd tree and we'll need acks
>> from Sebastian for power/reset and either Linus or Bartosz for gpio then.
> 
> That's right.

Can you maybe comment on 
https://lore.kernel.org/asahi/20250610-smc-6-15-v7-0-556cafd771d3@kernel.org/T/#m25fe0bd8fe5fa47ed63f4238da80d7186a65450c?

A sub device declared with

MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot")

is picked up even if there's no corresponding node in the device tree.
Is this expected behavior for mfd? There are some pre-M1 iDevices that 
also have a variant of SMC that doesn't have the reboot functionality.
We can always special case it with a different compatible but just 
dropping the sub-node from the device tree would've been neat.

> 
>> The one line change inside drivers/soc/apple would usually go through my
>> tree and I'm fine with taking that through mfd instead.
> 
> If there are no build-time dependencies on it, you can take it.

Okay, I've picked it up now.

> 
> I'm happy to take only the inter-dep ones or all (except the arch/ ones).
>

Sure, I'll take those as well once the dt-bindings are in.


Thanks,

Sven



