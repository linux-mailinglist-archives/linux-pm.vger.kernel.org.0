Return-Path: <linux-pm+bounces-16803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585989B757F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3501C21A8F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88414A09F;
	Thu, 31 Oct 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vbackqv/"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CB148850;
	Thu, 31 Oct 2024 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360370; cv=none; b=RviN/6Sxomerp0YfMxKjdbNqxU3TuTyMhgJ4o451quWUx9c+/jN85rz63+tHoHKr0fZaSH8eGAFczzd81I0/qiukzi+G/Jp0NnPN4WyrIciksfb4Pwb6iKOUxUZXOm5GiTCuBIow0hrI7ylJZ/Yv0RZfqJXG4pFRjmWiaWmWAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360370; c=relaxed/simple;
	bh=5OUdyC0bM1AnsKb82PzzKkb/lXhjvRSYV60BNbDHQKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4yM2NNEInCqoRTjrm7IYQL8aeScavhJLLC0hXkjRbjbn1wuXH+TZlINB0/oEJSo34W1lS7pUVamltO910sbg1tJDiRdiSPzmFgG7pNSSxDz++HssDi26P5vlTozafd/L09Zj3M7PXlZNnluu7YhiGW75s+iMA7BafXvwpwZXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vbackqv/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9347842;
	Thu, 31 Oct 2024 08:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730360362;
	bh=5OUdyC0bM1AnsKb82PzzKkb/lXhjvRSYV60BNbDHQKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vbackqv/jsgLSQ4uWZMC3/zLnQzT28ye2qcvMkF3kPtFouz4/LY/wWLGt8+Fx7RNi
	 vVBLLY8VqZkCLFGZOg9tk2B4IkLyrbDvwPKvue6jiMmd5cI2rLufef9fDBeZ7n+fst
	 oGp2w/GEtSq5J3K85gJGuj+1WyX5+QW34Oo9OIqU=
Message-ID: <0f027b8e-9c41-4754-923b-2a285fb9593a@ideasonboard.com>
Date: Thu, 31 Oct 2024 09:39:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
To: Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vishalm@ti.com, sebin.francis@ti.com,
 d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
 <7hmsilqrw3.fsf@baylibre.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <7hmsilqrw3.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30/10/2024 22:04, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:
> 
>> At the moment the driver sets the power state of all the PDs it creates
>> to off, regardless of the actual HW state. This has two drawbacks:
>>
>> 1) The kernel cannot disable unused PDs automatically for power saving,
>>     as it thinks they are off already
>>
>> 2) A more specific case (but perhaps applicable to other scenarios
>>     also): bootloader enabled splash-screen cannot be kept on the screen.
>>
>> The issue in 2) is that the driver framework automatically enables the
>> device's PD before calling probe() and disables it after the probe().
>> This means that when the display subsystem (DSS) driver probes, but e.g.
>> fails due to deferred probing, the DSS PD gets turned off and the driver
>> cannot do anything to affect that.
>>
>> Solving the 2) requires more changes to actually keep the PD on during
>> the boot, but a prerequisite for it is to have the correct power state
>> for the PD.
>>
>> The downside with this patch is that it takes time to call the 'is_on'
>> op, and we need to call it for each PD. In my tests with AM62 SK, using
>> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
>> feature is valuable, so in my opinion it's worth it.
>>
>> The performance could probably be improved with a new firmware API which
>> returns the power states of all the PDs.
> 
> Agreed.  I think we have to pay this performance price for correctness,
> and we can optimizie it later with improvements to the SCI firmware and
> a new API.
> 
>> There's also a related HW issue at play here: if the DSS IP is enabled
>> and active, and its PD is turned off without first disabling the DSS
>> display outputs, the DSS IP will hang and causes the kernel to halt if
>> and when the DSS driver accesses the DSS registers the next time.
> 
> Ouch.
> 
>> With the current upstream kernel, with this patch applied, this means
>> that if the bootloader enables the display, and the DSS driver is
>> compiled as a module, the kernel will at some point disable unused PDs,
>> including the DSS PD. When the DSS module is later loaded, it will hang
>> the kernel.
>>
>> The same issue is already there, even without this patch, as the DSS
>> driver may hit deferred probing, which causes the PD to be turned off,
>> and leading to kernel halt when the DSS driver is probed again. This
>> issue has been made quite rare with some arrangements in the DSS
>> driver's probe, but it's still there.
>>
>> So, because of the DSS hang issues, I think this patch is still an RFC.
> 
> Like you said, I think that DSS hang is an issue independently of this
> patch, so it shouldn't hold this up IMO.

In current upstream, if the bootloader has enabled the display, we most 
likely won't hit the DSS hang issue as the PD will stay on until the DSS 
driver has had a chance to probe, and the driver takes actions to avoid 
the hang issue.

With this patch applied, the PD may be turned off before the DSS driver 
has had a chance to probe, causing the board to hang when the DSS driver 
probes the first time.

That's why I'm a bit hesitant to apply this. It could mean that for some 
people their board stops booting.

I'm not even sure what would be the perfect fix for this hang problem...

We could have some built-in early boot code which checks if the DSS is 
enabled, and disables it, so that the hang issue won't happen. But 
that's not good if we try to keep the boot splash on the screen until 
the userspace takes over.

Alternatively we could, somehow, mark the DSS powerdomain to be handled 
in a special way: if the PD is enabled at boot time, it will be kept 
enabled until the DSS driver (somehow) changes the PD back to normal 
operation (and if DSS driver is never loaded, PD will stay on).

  Tomi

>> Hopefully we can sort out all the issues, but this patch (or similar)
>> will be part of the solution so I'd like to get some acks/nacks/comments
>> for this. Also, this change might have side effects to other devices
>> too, if the drivers expect the PD to be on, so testing is needed.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> We already discussed this a bit off-list, but for the record, I agree
> with the approach.
> 
> I also tested it on k3-am62a7-sk where I've been doing the other TI SCI
> pmdomain work and everything still working fine.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> Kevin


