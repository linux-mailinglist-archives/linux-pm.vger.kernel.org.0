Return-Path: <linux-pm+bounces-37763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A87C4941C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 21:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35784E0469
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20B2EE608;
	Mon, 10 Nov 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b="jZICoMmk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.dwurp.de (mail.dwurp.de [185.183.156.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39F2ECE9F
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.156.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806855; cv=none; b=JrgoMl7rPTj9eSR/T10Ypaz9qV8Y57SDqSkVmprUaoCSFNUZQ3cqjAbxORBmi2qkOVfZx+j3Bgjim3MWwgBkhsiAkpHZGrNTiNyJh/agGp82wVbTrEhKeJUSVliTWLy4Vh1h2PxFriyYzenmOUGnBG79BSZEHdmDMCconeVqqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806855; c=relaxed/simple;
	bh=hI+UHxow76PZXaYqgfVJUga4FWnH+Qi5/X+yWJf8dxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTAwf8DutcblvFIZ8UJTAu92PYsHmGFppgai2oZYSkBzisuvjkJYGUMrBPmpIcccX8TD2Vh4k/3qJbganl7UV1whqaJUL5cgbUZnmFn7WvMhAP5hzxDzRFkjKgtv7adI3mYS2fqPDJ2p6/9JezJw3HTHfB2Au2v0IotdGo1M5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de; spf=pass smtp.mailfrom=dwurp.de; dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b=jZICoMmk; arc=none smtp.client-ip=185.183.156.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwurp.de
Message-ID: <a024999c-34e0-4457-9fe4-69fe6b92d443@dwurp.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwurp.de; s=mail;
	t=1762806842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sd6x+dmxoN/hCDN4l2CgUzIn+1v8ZIL9hTUMEklU4VU=;
	b=jZICoMmkEzEOx8xodhj/K1g9XVCI/wBH6h/GDLRco7My1ltWzz79n32sEAnBynJe8B9gQc
	9bDd8xdbLiU8Z7FuTQbgJqrqezYbDcDPIiVf2VP2L1xFQaT/lDnrGtnYaldau0sf5Oo7VO
	O8MgAC6LZP2p6rEkTVBrIRCVkCT5hsQ=
Date: Mon, 10 Nov 2025 21:33:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: power_supply sbs-9-000b: driver failed to report `technology'
 property: -5 on rk3399 google-gru
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
References: <078eef57-07c9-420a-99b1-e47b3dd93204@dwurp.de>
 <5njqjtvi72z35b5chhgf66jqucvycy43ul3z4b35nfijhod2ah@v7mtbeb3mqp5>
Content-Language: en-US, de-DE
From: Sebastian Fleer <dev@dwurp.de>
In-Reply-To: <5njqjtvi72z35b5chhgf66jqucvycy43ul3z4b35nfijhod2ah@v7mtbeb3mqp5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/3/25 00:44, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Oct 31, 2025 at 01:03:02PM +0100, Sebastian Fleer wrote:
>> Hi,
>>
>> on an Acer Chromebook Tab 10 (RK3399 google-gru/scarlet) we see a lot of these error messages
>> (sometime multiple times per second):
>>
>> [  247.155467] power_supply sbs-9-000b: driver failed to report `technology' property: -5
>>
>> With POWER_SUPPLY_DEBUG=y these look like this:
>>
>> [  142.335138] power_supply sbs-9-000b: driver failed to report `technology' property: -5
>> [  142.352393] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 0
>> [  142.352437] sbs-battery 9-000b: sbs_get_property: property = 0, value = 1
>> [  142.353283] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 51
>> [  142.353310] sbs-battery 9-000b: sbs_get_property: property = 51, value = 0
>> [  142.355202] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 2
>> [  142.355231] sbs-battery 9-000b: sbs_get_property: property = 2, value = 0
>> [  142.359681] sbs-battery 9-000b: sbs_read_string_data_fallback: i2c read at address 0x22 failed
>>
>> Battery status reporting with upower seems to be hit or miss:
>>
>> $ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
>>    native-path:          sbs-9-000b
>>    vendor:               <unkn>
>>    model:                <BATT>
>>    serial:               ffff
>>    power supply:         yes
>>    updated:              Fri Oct 31 12:41:02 2025 (3 seconds ago)
>>    has history:          yes
>>    has statistics:       yes
>>    battery
>>      present:             yes
>>      rechargeable:        yes
>>      state:               discharging
>>      warning-level:       action
>>      energy:              0 Wh
>>      energy-empty:        0 Wh
>>      energy-full:         36.55 Wh
>>      energy-full-design:  33.78 Wh
>>      voltage-min-design:  3.84 V
>>      voltage-max-design:  3.84 V
>>      energy-rate:         0 W
>>      charge-cycles:       N/A
>>      percentage:          0%
>>      temperature:         23.9 degrees C
>>      capacity:            100%
>>      icon-name:          'battery-caution-symbolic'
>>    History (charge):
>>      1761910862  0.000   discharging
>>      1761910806  62.000  discharging
>>      1761910801  0.000   discharging
>>      1761910796  62.000  discharging
>>      1761910791  0.000   empty
>>      1761910755  62.000  discharging
>>    History (rate):
>>      1761910851  0.000   discharging
>>      1761910821  4.380   discharging
>>      1761910791  0.000   empty
>>      1761910760  1.658   discharging
>>
>> $ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
>>    native-path:          sbs-9-000b
>>    vendor:               <unkn>
>>    model:                <BATT>
>>    serial:               ffff
>>    power supply:         yes
>>    updated:              Fri Oct 31 12:41:07 2025 (18 seconds ago)
>>    has history:          yes
>>    has statistics:       yes
>>    battery
>>      present:             yes
>>      rechargeable:        yes
>>      state:               discharging
>>      warning-level:       none
>>      energy:              22.6548 Wh
>>      energy-empty:        0 Wh
>>      energy-full:         36.54 Wh
>>      energy-full-design:  33.77 Wh
>>      voltage-min-design:  3.84 V
>>      voltage-max-design:  3.84 V
>>      capacity-level:      Unknown
>>      energy-rate:         73.1904 W
>>      charge-cycles:       N/A
>>      time to empty:       18.6 minutes
>>      percentage:          62%
>>      capacity:            100%
>>      icon-name:          'battery-full-symbolic'
>>    History (charge):
>>      1761910867  62.000  discharging
>>      1761910862  0.000   discharging
>>      1761910806  62.000  discharging
>>      1761910801  0.000   discharging
>>      1761910796  62.000  discharging
>>      1761910791  0.000   empty
>>    History (rate):
>>      1761910867  73.190  discharging
>>      1761910851  0.000   discharging
>>      1761910821  4.380   discharging
>>      1761910791  0.000   empty
>>
>> These errors show up with kernel 6.12.55 as well as 6.17.5.
>>
>> More context is available here: https://gitlab.postmarketos.org/postmarketOS/pmaports/-/issues/2261
>>
>> Any idea on how to fix this is highly appreciated.
>>
>> Best regards
>> Sebastian
> 
> Looks like 'google,cros-ec-i2c-tunnel' being crappy again. Can
> you check, that you are running the latest EC firmware? Apparently
> things are being fixed in its firmware, see e.g. this thread:
> 
> https://lore.kernel.org/all/20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com/

It took a while to figure it out, but I was able to build and flash the EC firmware from
the following tree: https://chromium.googlesource.com/chromiumos/platform/ec/+log/refs/heads/firmware-scarlet-10388.B

I have no idea why the latest version never ended up in the official ChromeOS firmware
package for this device, but it apparently fixes the reported problems.

So thanks again for the hint!

Best regards
Sebastian

> Greetings,
> 
> -- Sebastian


