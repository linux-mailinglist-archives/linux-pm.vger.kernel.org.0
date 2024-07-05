Return-Path: <linux-pm+bounces-10708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB5B928CFB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB36286912
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99D16D4F6;
	Fri,  5 Jul 2024 17:16:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B51145B10;
	Fri,  5 Jul 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199779; cv=none; b=KU2zhnBUxiveTN7G3Yh2VNR7yODscZmUseGWj0dHnD9JHyCvtCHOyEr87lqlGkzaR6xloEpxGxDdpNQL1/QhJdU8CD1HPgeKMSuAkdoP29PtmIvt9ew4NcXqLJhjeRBlgWNBQS5Jn4uem49wHxZ46v/sXsiWC/WN0PbvwQLUs00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199779; c=relaxed/simple;
	bh=dyBujqfWYpPCAs4mHLwy33nhm7q7ECkO9yM4OZ211+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbI6+Y3dqbWSg4h5VAfp7rzibPxKOQT9iNVImV0ws43g4tZPvi5pxzrD7dgZzLcUBcvzGj1deCQkNbDby+1Sd3RTm7RtqxcmqJHZUpbU0AaNg5rSW19qiI/shuC6DYJkTRuDgjHkd/vb+qhEcJu/qnx/hXz8b3/W1SjW7vG4Mto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6356BDA7;
	Fri,  5 Jul 2024 10:16:41 -0700 (PDT)
Received: from [172.27.42.201] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 040D93F762;
	Fri,  5 Jul 2024 10:16:16 -0700 (PDT)
Message-ID: <38e46b44-6248-45e8-bdf9-66008a2fe290@arm.com>
Date: Fri, 5 Jul 2024 12:16:14 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] usb: dwc2: Skip clock gating on Broadcom SoCs
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, Lukas Wunner <lukas@wunner.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jassi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Peter Robinson <pbrobinson@gmail.com>,
 dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-10-wahrenst@gmx.net>
 <95762956-b46a-4dfa-b22f-bccbfa39558d@broadcom.com>
 <ZoezRpXBgB1B5WjB@wunner.de> <4502d826-d80c-4a98-a889-da7badfa698e@gmx.net>
 <ZogLXYopViQO11ta@wunner.de> <43fa421c-5e5b-40a6-a546-d80e753586e3@gmx.net>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <43fa421c-5e5b-40a6-a546-d80e753586e3@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 7/5/24 10:21, Stefan Wahren wrote:
> Hi Jeremy,
> 
> Am 05.07.24 um 17:03 schrieb Lukas Wunner:
>> On Fri, Jul 05, 2024 at 12:22:33PM +0200, Stefan Wahren wrote:
>>> Am 05.07.24 um 10:48 schrieb Lukas Wunner:
>>>> The real question is whether BCM2848 platforms likewise cannot disable
>>>> the clock of the dwc2 controller or whether this is specific to the
>>>> BCM2835.  Right now dwc2_set_bcm_params() is applied to both the
>>>> BCM2848 and BCM2835.  If the BCM2848 behaves differently in this
>>>> regard, we'd have to duplicate dwc2_set_bcm_params() for the BCM2835.
>>>  From my understand BCM2848 refers to the same SoC, but the ACPI
>>> implementation uses a different ID [2]. So I think this is safe.
>>> [2] -
>>> https://patches.linaro.org/project/linux-usb/patch/20210413215834.3126447-2-jeremy.linton@arm.com/
>> Careful there, the patch vaguely says...
>>
>>      With that added and identified as "BCM2848",
>>      an id in use by other OSs for this device, the dw2
>>      controller on the BCM2711 will work.
>>
>> ...which sounds like they copy-pasted the BCM2848 id from somewhere else.
>> I would assume that BCM2848 is really a different SoC and not just
>> a different name for the BCM2835, but hopefully BroadCom folks will
>> be able to confirm or deny this (and thus the necessity of the quirk
>> on BCM2848 and not just on BCM2835).
> could you please clarify this situation?

This id comes from the edk2-platforms ACPI tables and is currently used 
by both the rpi3 and rpi4, and AFAIK nothing else as the rpi5-dev work 
is currently only exposing XHCI.

The ID is strictly the USB controller not the SoC. Its a bit confusingly 
named, but something we inherited from the much older windows/edk2 port, 
where it appears that the peripheral HID's were just picked in numerical 
order.

[0] 
https://github.com/tianocore/edk2-platforms/blob/12f68d29abdc9d703f67bd743fdec23ebb1e966e/Platform/RaspberryPi/AcpiTables/GpuDevs.asl#L15



