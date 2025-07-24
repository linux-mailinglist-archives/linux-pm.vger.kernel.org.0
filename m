Return-Path: <linux-pm+bounces-31358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED6B10060
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 08:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EF7561558
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3171FE461;
	Thu, 24 Jul 2025 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfynuZ5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0C19A;
	Thu, 24 Jul 2025 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337323; cv=none; b=Fn4YPlXjbIFsZ5FVu36eAqczfZ1bQttxI+z31RRnuPIoU6vCCC72nmJFFAPXMxgVZIQjAlz27Bhcuvnr9EH/wmnkH9bVakBxhp2dRvN/M2GfzCBvKki7tp4MW9RTWmCV49j3ywwiJw2kLilz/DlTC3lPOEksTTh/ETN3GnMKGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337323; c=relaxed/simple;
	bh=jnPA+iA9iLU7wadXEwXs4NfK0RtdyekHzyBGX5AWZsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjzmdfNZ9eo2juwF/WKSg57r44HSJzllnxskyV59J9lHSFrmnGPMPU2whCo/YRaYr7NEJn6QrO4jBBkiwG7cquq78ErwWIhbbux4oQPoMnfw1uedohHioQ7jMiXJVRqI6mqH8N21jgo9RSaRN/COr7moYGuiD7+vyzqhL+UPHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfynuZ5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E60C4CEED;
	Thu, 24 Jul 2025 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753337320;
	bh=jnPA+iA9iLU7wadXEwXs4NfK0RtdyekHzyBGX5AWZsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EfynuZ5+9ifm4K+Q8RJf9Sc8h4rtAfwGv0gCHr2fvS4/5hlRSmSzyWCqdSeQFIdUv
	 epQpwWEsigEcs12RdptljlIbcrSzmQfzy80xDo7W0irii5/Ytz+AVy/gVz+aION58e
	 1NKWSAB4vMKZ2qk2Ba10DWpey7rUXVbAdjaiiqfS6z+9FsK9uyRQPfkCjGfvdVW7jm
	 Qgvc0UYoncG6e3iwlztNMLAhE3yv3hqqpaNckyQxlqPLsJLSYckcgfJCtvhAA5JsBz
	 PY13RW7hyRpf4H7n9nbf6DzqOgvgwZSG5jJt39SC0MhBWaGqfZksc2E4eN7L6n6XrP
	 Pd+e+HqYUSojQ==
Message-ID: <fd0770c8-e5e0-4bdb-a3da-b4b39f664e61@kernel.org>
Date: Thu, 24 Jul 2025 08:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
To: Lee Jones <lee@kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>, asahi@lists.linux.dev,
 Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
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
 <d6b778ee-02c0-4dd2-b33f-cec16c17807c@kernel.org>
 <20250723080615.GM11056@google.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250723080615.GM11056@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 10:06, Lee Jones wrote:
> On Sat, 21 Jun 2025, Sven Peter wrote:
> 
>> On 16.06.25 06:13, Nick Chan wrote:
>>>
>>>
>>> On 10/6/2025 23:29, Sven Peter wrote:
>>>> From: Hector Martin <marcan@marcan.st>
>>>>
>>>> This driver implements the reboot/shutdown support exposed by the SMC
>>>> on Apple Silicon machines, such as Apple M1 Macs.
>>>>
>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>> Signed-off-by: Sven Peter <sven@kernel.org>
>>>> ---
>>>>    MAINTAINERS                         |   1 +
>>>>    drivers/power/reset/Kconfig         |   9 ++
>>>>    drivers/power/reset/Makefile        |   1 +
>>>>    drivers/power/reset/macsmc-reboot.c | 290 ++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 301 insertions(+)
>>> [...]
>>>
>>> It seems that the reboot driver still probes even without the smc_reboot node in the smc node:
>>
>>
>> That's odd...
>>
>> Lee, is it expected that a mfd sub-device declared with
>> MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
>> is loaded even if there's no corresponding node in the device tree?
>>
>> I'll have to re-add the check that makes sure the sub-device is available
>> then.
> 
> Yes, that's expected.  MFD is orthogonal to DT with respect to device
> registration, unless you specifically disable the node in DT.  If the
> node is missing, the device will still be registered, but no link will
> be made from the (non-existent) node to the 'of_node' pointer.

Makes sense!

> 
> You have 3 choices; provide a DT node and explicitly set the status to
> 'disabled', optionally omit registration from MFD (i.e. do not call
> mfd_add_devices()) or check for (!pdev->dev.of_node) in the sub-device's
> .probe() and bomb out early if true.
> 

Alright, so everything's working as intended then and the series has all 
required Acks. I'd suggest that we take it as-is then  (either now if
you're still picking things up before the merge window or after -rc1 is
out otherwise) since it only adds support for M1 and later and those
have all subdevices added here.

Once Nick adds support for pre-M1 SMC we can do one of those three
things to disable the reboot sub-device then.


Best,


Sven


