Return-Path: <linux-pm+bounces-15394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B59969CA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2E4283EAC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5B219408B;
	Wed,  9 Oct 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9T+kaxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80925192590;
	Wed,  9 Oct 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476287; cv=none; b=fINQaFNwu466GRgM5i/8SJBSfXJKACpUVp24qyr7dKGWhjFJcoZtsMIcqnO3Q1EOxoHeAzdtWN0F6oyiP3K9QryEom7RcAVufnauXk8iSXSBx6s/DT3EMicaBnhRNCTBqUXL/zmCMAnv24Tq90uCbdxXv6SLfLdQ3pUBm+aX3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476287; c=relaxed/simple;
	bh=7HzCyxRwDhDGiagq7ige4lIhgvZ3u2kLCfvJUX1acEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyVEQrnh7Yx/42u2u+HX8+oSPKiotppcg8UTSvqtLxzVGRYYtUWq6vuf2gNKH+CyXYhmkcJQp7ExwGXrYllIl/s2nWDpp872EOBSAoBlEmO1RN/IbREOFeYxZIi97V1hEqOjcay9FIjYscAmzwP8jeZCz9z8+UUcPRrKumq+g3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W9T+kaxx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F3A9E0004;
	Wed,  9 Oct 2024 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728476277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6T1AZ7MqtE1FYhDOn+D5C9fCeidV1a+LJ1diTcr0w=;
	b=W9T+kaxx6E7oXw19l6iEG+a9qNlgUvqL/LHpojNfKiIZHYhbMJ+Sd/LPUkh93WOmtArsVU
	QwiIiPdTdg9JxUhQ52yeEIfDYU6jzNr5CvDnzdyYEM5AjIp+lt4LW80YmOofMnJxdiNlmV
	UFdKOoCtnY+za91lhH+bBKN1JtE7eQZi6bzyRQ+/StabXoYjow78BH9yDemoG1ZWlbQLIQ
	hB5DPtpRxUWaS+lMYTia9JhM1bSou/BbXa2P+1l+lxTlTkkyZnv7PhHwHwwPpYw97N5uFx
	Na8JZlzQOAA7Of7u1O0ddlyHvaN7X3P865XdL7wScnXfhyNim9HuipMncz21Bw==
Message-ID: <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
Date: Wed, 9 Oct 2024 14:17:55 +0200
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
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 10/9/24 12:50, Ulf Hansson wrote:
> On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wrote:
>>
>> If the console suspend is disabled, mark the serial as on the wakeup path
>> to keep its PM domain powered on.
>>
>> Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index 88b58f44e4e9..6764fe2f9cad 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
>>         if (!device_may_wakeup(dev))
>>                 priv->wer = 0;
>>         serial_out(up, UART_OMAP_WER, priv->wer);
>> -       if (uart_console(&up->port) && console_suspend_enabled)
>> -               err = pm_runtime_force_suspend(dev);
>> +       if (uart_console(&up->port)) {
>> +               if (console_suspend_enabled)
>> +                       err = pm_runtime_force_suspend(dev);
>> +               else
>> +                       device_set_wakeup_path(dev);
>> +       }
> 
> Isn't this already managed by the serial core? See commit a47cf07f60dc
> ("serial: core: Call device_set_awake_path() for console port")

Yes you're right.
So this patch is useless.

Regards,

Thomas


