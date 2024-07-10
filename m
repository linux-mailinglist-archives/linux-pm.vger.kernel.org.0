Return-Path: <linux-pm+bounces-10936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7992D552
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657AD1C21144
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1119346A;
	Wed, 10 Jul 2024 15:50:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A6192B7F;
	Wed, 10 Jul 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626626; cv=none; b=Org9euPnZI2j8wTeJRSDbxsU2VzCWNoNSgDKLtFoJFc5d2/WURG0JH/siy4OUylaoDURgti4naH1qQwtMaOkr3qaCYYW9k74/V/8BlkAbSSfcIIrLafBSTRUzsauTRz35+cKLUq719W20nlj/xTRw86g06mpD93NLmURsgBQFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626626; c=relaxed/simple;
	bh=XF44xrSUK2QFKEPGQz0Jr1oXHtQLyZPOUdnO+XzlNks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imQBc/sCXWA9zse1/57t+PTaDMgV+C9afrRD/Eqw+MQ3orZIryHyT49RyewkW4gIgqiV/v0wDNFwJ8QGgXQ/koC4f/zA06IsxJ0qp5Cz6BJWDCODBtYG+BgKcknar1MsjE2DZZFHqmCGSyzinHPEmI8duUCRxM0+nU5ZXkV/jPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC2F7106F;
	Wed, 10 Jul 2024 08:50:49 -0700 (PDT)
Received: from [192.168.47.77] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A873F762;
	Wed, 10 Jul 2024 08:50:19 -0700 (PDT)
Message-ID: <88dd08fe-5a69-48b2-8838-8231928d29ab@arm.com>
Date: Wed, 10 Jul 2024 10:50:17 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] usb: dwc2: Skip clock gating on Broadcom SoCs
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Stefan Wahren <wahrenst@gmx.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
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
 <38e46b44-6248-45e8-bdf9-66008a2fe290@arm.com> <ZohiJgyaDwAoGtAx@wunner.de>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <ZohiJgyaDwAoGtAx@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/5/24 16:14, Lukas Wunner wrote:
> On Fri, Jul 05, 2024 at 12:16:14PM -0500, Jeremy Linton wrote:
>>> Am 05.07.24 um 17:03 schrieb Lukas Wunner:
>>>> Careful there, the patch vaguely says...
>>>>
>>>>      With that added and identified as "BCM2848",
>>>>      an id in use by other OSs for this device, the dw2
>>>>      controller on the BCM2711 will work.
>>>>
>>>> ...which sounds like they copy-pasted the BCM2848 id from somewhere else.
>>>> I would assume that BCM2848 is really a different SoC and not just
>>>> a different name for the BCM2835, but hopefully BroadCom folks will
>>>> be able to confirm or deny this (and thus the necessity of the quirk
>>>> on BCM2848 and not just on BCM2835).
>>
>> This id comes from the edk2-platforms ACPI tables and is currently used by
>> both the rpi3 and rpi4, and AFAIK nothing else as the rpi5-dev work is
>> currently only exposing XHCI.
>>
>> The ID is strictly the USB controller not the SoC. Its a bit confusingly
>> named, but something we inherited from the much older windows/edk2 port,
>> where it appears that the peripheral HID's were just picked in numerical
>> order.
>>
>> [0] https://github.com/tianocore/edk2-platforms/blob/12f68d29abdc9d703f67bd743fdec23ebb1e966e/Platform/RaspberryPi/AcpiTables/GpuDevs.asl#L15
> 
> So BCM2848, BCM2849, BCM2850 and so on are just made-up IDs
> for a Windows/EDK2 port that got cargo-culted into the kernel?
> Yikes!

You could say that, but there was some due diligence a couple years ago 
to track down the owner of the pnp id/information at broadcom, and it 
didn't yield anything helpful. Whether they are legitimate seems to be 
lost in time. At this point they are widely/publicly known Ids, without 
apparent conflict.


> 
> Has anyone checked whether they collide with actual Broadcom products?


