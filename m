Return-Path: <linux-pm+bounces-29190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91632AE29FF
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8F16A9BA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162421771B;
	Sat, 21 Jun 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXtULFaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214861426C;
	Sat, 21 Jun 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750521100; cv=none; b=udTewYSw9AK+lB1CvnfDioTjWRk94WpWlhmQuxQn0t+MCVxElfAJgmhu6JSy+G1uikReKnEKfrYSRdiNDkZ5NrRmuK7p8cWxkTeLEfG5JABpVR4GCLvr5wYBlTD0fw+M+vHrEdNJSVgSSBRBkHBIhlwVe+qYngV/nDH0ivExc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750521100; c=relaxed/simple;
	bh=RwP81emvQorDLrxRkfUbpFTx2KvYq1XkDDhakXZLA38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elt1qELhyhj+FnWqUXwqz+VQP5VayAN8bxYY6HuYCQknhfoUInqaS8mMQgXy/6nXOdzseL+z+8atDTybUZiO6NxSFXUFsKR77xbbvodGRj8MI8+Qi68qY+uRrkxfXp4GsNeKc2zDkJuDVmmW6cVJOO9l4qIw83Y+KV/4MTk2z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXtULFaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78776C4CEE7;
	Sat, 21 Jun 2025 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750521099;
	bh=RwP81emvQorDLrxRkfUbpFTx2KvYq1XkDDhakXZLA38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aXtULFaVgekIStsylN4vdg7HUyzivNz0nR/MJSwVzTkpruzTLf09+mzKvXkhSxwD6
	 RfdN8Od5f/jxKMfkRbddhs5qxoS+QoS46W+d0+b1qS8+AJxa+pObgodXZycAnqJbL5
	 gem5fqZiCD+HRYOrXaZXZmKHTNeK1QgLdynUz9VXQ5u4JDhZP5nOO3CQXZfDQZudBp
	 d6cX58KTKDdUT5SRafdvX4onFl9UpYAy5YNgB7V0VjO2pugG98guCnmakD1DhOMOvP
	 IbTJOhfMjLOTL7cCYtNtILPzxbrr9AtexQUIJRZ/m8HT5DhA72WLDVkeB3m3VNKief
	 vEVYcskD2Qe6g==
Message-ID: <f30406ae-90ed-4f81-9519-e6ae2dcc9e03@kernel.org>
Date: Sat, 21 Jun 2025 17:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
To: Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>
 <20250619114958.GJ587864@google.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250619114958.GJ587864@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.25 13:49, Lee Jones wrote:
> On Tue, 10 Jun 2025, Sven Peter wrote:
> 
>> The System Management Controller (SMC) on Apple Silicon machines is a
>> piece of hardware that exposes various functionalities such as
>> temperature sensors, voltage/power meters, shutdown/reboot handling,
>> GPIOs and more.
>>
>> Communication happens via a shared mailbox using the RTKit protocol
>> which is also used for other co-processors. The SMC protocol then allows
>> reading and writing many different keys which implement the various
>> features. The MFD core device handles this protocol and exposes it
>> to the sub-devices.
>>
>> Some of the sub-devices are potentially also useful on pre-M1 Apple
>> machines and support for SMCs on these machines can be added at a later
>> time.
>>
>> Co-developed-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   MAINTAINERS                |   2 +
>>   drivers/mfd/Kconfig        |  18 ++
>>   drivers/mfd/Makefile       |   1 +
>>   drivers/mfd/macsmc.c       | 498 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
>>   5 files changed, 798 insertions(+)
> 
> This is ready.  Let me know when you have all of the other driver/* Acks.
> 

They've all been reviewed by the respective maintainers.

I assume you want to take this all through the mfd tree and we'll need 
acks from Sebastian for power/reset and either Linus or Bartosz for gpio 
then.

The one line change inside drivers/soc/apple would usually go through my 
tree and I'm fine with taking that through mfd instead.


Sven


