Return-Path: <linux-pm+bounces-29189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE469AE29F9
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFAB1899359
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337722156F;
	Sat, 21 Jun 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZbuA+Ky"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0833DDC1;
	Sat, 21 Jun 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520828; cv=none; b=c5GD+h32zKHZI+YdFm0eiHhIgLuZffr0NzqY468vAaIRh+ivv2VxtjEkQi95PzJrXudbDv8/NkybmW6dLExbpvee9lM+9U33tP5OPCrUQeOBoJyU6mUWcbMRYy7a3FN2luvCesesuOr5idsZgPCZH6zxMtsjUEOeoVOPXDFEdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520828; c=relaxed/simple;
	bh=JGad2WjHIb8ZSwLQLKjJVJXPHLkmGN1ja8YbDynBoUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPJOOhd0K2lKzvgN6vxWNHDIlxbs/BPKQy+3E6JP2SCBBWHR2kgXHZtznvNsrrWVWby8pBespoR/hIX30dctyThrSlvVG6yz2W1YHNOsTKLOuGzySUpwUfK8VI0yv+kzvBfVk1d8vjB8K6Q4S3+RZZO+VMK9u3cSXTjDCm37Dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZbuA+Ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61972C4CEEF;
	Sat, 21 Jun 2025 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520828;
	bh=JGad2WjHIb8ZSwLQLKjJVJXPHLkmGN1ja8YbDynBoUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cZbuA+KySSuVFGKsiGCI9pOjANieYcLc7XUELfbiE3vzk2tXSaVt1N5GwnQzDrc0T
	 3W/U/LSC/cixWDosaQ4N2odQ3ebZSDzIbXRnLYrNO566BrNMETsK8BZRqs1WI8CS1p
	 bd6Z2lB8PxlHwZeA3YURkauE9yoalWD5Ji7QquHD+JSEsykO4aY/GXjCQBRFgIe7H8
	 VOdgEbm7MBiGzszmMLsPJE4mMoDFfu8D1YwBOtnLh0g/ezeSyxvgVRjNNe/j93HYnY
	 +apscx4V83cWAL3ZJQpfZKH0JRMqLm+7MWjlY9Be57P2zUcbt/D+zgr00sTGTy38Gi
	 146CWd1tJHHEw==
Message-ID: <d6b778ee-02c0-4dd2-b33f-cec16c17807c@kernel.org>
Date: Sat, 21 Jun 2025 17:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
To: Nick Chan <towinchenmi@gmail.com>, Lee Jones <lee@kernel.org>
Cc: asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Hector Martin <marcan@marcan.st>, Conor Dooley <conor+dt@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-7-556cafd771d3@kernel.org>
 <7297d4b1-84a2-4bb1-8a33-29c827247df7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <7297d4b1-84a2-4bb1-8a33-29c827247df7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 06:13, Nick Chan wrote:
> 
> 
> On 10/6/2025 23:29, Sven Peter wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> This driver implements the reboot/shutdown support exposed by the SMC
>> on Apple Silicon machines, such as Apple M1 Macs.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   MAINTAINERS                         |   1 +
>>   drivers/power/reset/Kconfig         |   9 ++
>>   drivers/power/reset/Makefile        |   1 +
>>   drivers/power/reset/macsmc-reboot.c | 290 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 301 insertions(+)
> [...]
> 
> It seems that the reboot driver still probes even without the smc_reboot node in the smc node:


That's odd...

Lee, is it expected that a mfd sub-device declared with
MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
is loaded even if there's no corresponding node in the device tree?

I'll have to re-add the check that makes sure the sub-device is 
available then.


Thanks,


Sven



