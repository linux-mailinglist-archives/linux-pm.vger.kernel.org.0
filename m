Return-Path: <linux-pm+bounces-15397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCC996B39
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544B5287359
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B8193403;
	Wed,  9 Oct 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XecLw6eJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374A291E;
	Wed,  9 Oct 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478788; cv=none; b=IvDCv5Pnevdttkf4w3EB5BansI+5nhUmi8ZJAns5lTMgzPxY7+gKvAyia3YIdYBG2w1IFabnve/pDjWhXXW3/3PfEAgAABaoMnp757C+BkHM6Y5SXu7ewxi6B8K+8FlqCdL8Etr0n6gCNb/tDU0K3X8es+zBhbPzX0/laF+1C48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478788; c=relaxed/simple;
	bh=kIFgHgQ8YP8q/G9kmMv1+5aT1z6dyWRZHmjlmiJe4uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gtdg9LXEXKQNCDHXL4Lj9DK1Ljix1o14cV7l6ZEb9v4GH6Bb7uy6UVioeBYHZrJj6RKBAzd02AIbHKtvU2HGbrVDk2aS+QOBzQj+wmmD1a2EIfjZrMAyiNhS+6P3PvwspZJIKZRxpUxBIIKrpKp/uAILllCrarUmZDBNOJpsy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XecLw6eJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 056DBFF806;
	Wed,  9 Oct 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728478784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FBMJ9MfYVZ5+KZGpcbbHX+gTyoxYeYnRxdhFJ2lTaE=;
	b=XecLw6eJai1TPshIzxSR+CGuBVc4+2N6poQNQVOYp1SoN47BygwgSgoqmaZSxyxyouhHKC
	RFnVhAIPqeewIWjHUi5OfqfODW0qz6D74CvRenkJz/2AyXqfp/F4ogt1ocmwoAT1vXL15f
	TwYpEZYdx1oOpo7aGGfn9L1eZ3u2exsnFut8NEto+wTHuYk7Md1OcNuejwg2CKMHlBNeKU
	D5oDfx1HudjqnaqFXhsXKtgFIQ1TI76BQFtNwAvb5qnEov3tDEK7I5K8X6sRRE5/NhDSbW
	lhOthQ6MLcCbER1H9QclvM+kG9Nu6WlvNOqA4/gfTJBQGHHBXQmQWzHheoE3gw==
Message-ID: <ff50edb8-ec36-4cf4-b7d3-21ec01f6ff0a@bootlin.com>
Date: Wed, 9 Oct 2024 14:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com,
 khilman@kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com,
 richard.genoud@bootlin.com
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
 <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com>
 <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
 <CAPDyKFoOV00JzQ=+j7FJzVb0Zb4j-qjR5YPT020TzyJKngeFMg@mail.gmail.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <CAPDyKFoOV00JzQ=+j7FJzVb0Zb4j-qjR5YPT020TzyJKngeFMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 10/9/24 14:39, Ulf Hansson wrote:
> On Wed, 9 Oct 2024 at 14:17, Thomas Richard <thomas.richard@bootlin.com> wrote:
>>
>> On 10/9/24 12:50, Ulf Hansson wrote:
>>> On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wrote:
>>>>
>>>> If the console suspend is disabled, mark the serial as on the wakeup path
>>>> to keep its PM domain powered on.
>>>>
>>>> Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>> ---
>>>>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>>>> index 88b58f44e4e9..6764fe2f9cad 100644
>>>> --- a/drivers/tty/serial/8250/8250_omap.c
>>>> +++ b/drivers/tty/serial/8250/8250_omap.c
>>>> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
>>>>         if (!device_may_wakeup(dev))
>>>>                 priv->wer = 0;
>>>>         serial_out(up, UART_OMAP_WER, priv->wer);
>>>> -       if (uart_console(&up->port) && console_suspend_enabled)
>>>> -               err = pm_runtime_force_suspend(dev);
>>>> +       if (uart_console(&up->port)) {
>>>> +               if (console_suspend_enabled)
>>>> +                       err = pm_runtime_force_suspend(dev);
>>>> +               else
>>>> +                       device_set_wakeup_path(dev);
>>>> +       }
>>>
>>> Isn't this already managed by the serial core? See commit a47cf07f60dc
>>> ("serial: core: Call device_set_awake_path() for console port")
>>
>> Yes you're right.
>> So this patch is useless.
> 
> So patch 1/2 is all you need to get things working?

Yes only patch 1/2 is needed.

Regards,

Thomas

