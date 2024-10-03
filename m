Return-Path: <linux-pm+bounces-15106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4D98F39C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A710F1C20979
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391891A7044;
	Thu,  3 Oct 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HXNRVvxh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414EC1A4F25;
	Thu,  3 Oct 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971690; cv=none; b=VuIuncGrNcwigdEtdXb+3fgA5jb/SwOdUoqznVbcWgYtFmC3gyiWJNyul/P0q9X+T5AcsABl4JMclFLQ2yS+Jx/tirP1yatPY1/kQb81klf19lp3V2ybSgjCB4wPPE9tf/E/gxALhTLRATpIf/SnB5xatVAx7dMcHUg4aPGKGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971690; c=relaxed/simple;
	bh=PuxGYKkgO89wMpd84+jo7uDfhXlwBQz2azp6oxMgkfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeP3byuBo7wuDS5y7b1nUh0d37TUPgcnc+z8hyU5Y22ac+PENC1nRz2tJs1e/H1mtWsRgXdf+4Ts++fh2YGl/lTzx7Km5eb/CjMu0riuPq9aeO+OUoEup/avZx9Zm2xgIBxIer7XJEW190Xaa0vjQRT6Zj2E/u41A/G4Pu8XVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HXNRVvxh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727971686;
	bh=PuxGYKkgO89wMpd84+jo7uDfhXlwBQz2azp6oxMgkfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXNRVvxhkf69StUkFUdq3YT3bbby40eacs9Rp2afZBkucUBEszAtpkzaUdYXBF5Qh
	 k9715amVaUim9usnO43x3gtaMiU3IzLWqoiRKxvBV5zrmZH+ikvz/Ai4DAWayB+Ic9
	 D/ppX8EgSu8wf1B0T3LXFj6ZgQT0FmvkdmUGQ5NEqSay4C6Jn7vUTQKsw39Y+stAwu
	 NzG4bbelCFyy1UWvRNdixNn8noWGx+xIRvLH1C+YRVXXNxGDYYechstYO9cUc5a7y7
	 IWiUcXEUoKYlOXFyowkSkdW5Z7VqXrpU46qB7ixChWmsSoXn7tBIGVUbtuVe99urzB
	 LKdJhaYsdvdmQ==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3412F17E3611;
	Thu,  3 Oct 2024 18:08:05 +0200 (CEST)
Date: Thu, 3 Oct 2024 12:08:03 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Pin-yen Lin <treapking@chromium.org>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Erroneous sbs-battery sysfs info a MT8173 Chromebook
Message-ID: <a83e80f7-2bb8-423d-b24e-e793ce5da988@notapiano>
References: <6e341522-70f6-413c-b9ba-8ac86a19b5f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e341522-70f6-413c-b9ba-8ac86a19b5f3@gmail.com>

On Thu, Oct 03, 2024 at 06:15:49PM +0300, Alper Nebi Yasak wrote:
> Hello,
> 
> I have a MT8173 Chromebook ("Lenovo 300e") where I'm getting a lot of 
> battery-related errors:
> 
> [   34.678473] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> [   34.702079] power_supply_show_property: 5 callbacks suppressed
> [   34.702096] power_supply sbs-6-000b: driver failed to report `technology' property: -22
> [   34.754401] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> [   34.782568] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> [   34.806020] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
> [   34.826135] power_supply sbs-6-000b: driver failed to report `technology' property: -22
> [   34.844078] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> [   34.864128] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> [   34.889015] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
> [   34.895486] power_supply sbs-6-000b: driver failed to report `technology' property: -22
> [   34.945035] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
> 
> These infinitely repeat because upower keeps trying to read them. I also 
> see this which might be important:
> 
> [   18.111500] cros-usbpd-charger cros-usbpd-charger.7.auto: Could not get charger port count
> [   18.197166] sbs-battery 6-000b: sbs-battery: battery gas gauge device registered
> [   18.248105] sbs-battery 6-000b: I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.
>                Fallback method does not support PEC.
> 
> Properties seem to be stuck to weird values (0xffff ?):
> 
>   $ for f in /sys/class/power_supply/sbs-6-000b/*; do
>       printf "$(basename "$f"):  "
>       cat "$f" 2>/dev/null || echo
>     done
>   capacity:  100
>   capacity_error_margin:  0
>   capacity_level:  Full
>   charge_full:  65535000
>   charge_full_design:  65535000
>   charge_now:  65535000
>   constant_charge_current_max:  65535000
>   constant_charge_voltage_max:  65535000
>   current_avg:  -1000
>   current_now:  -1000
>   cycle_count:  65535
>   device:
>   energy_full:  655350000
>   energy_full_design:  655350000
>   energy_now:  655350000
>   health:  Calibration required
>   hwmon2:
>   manufacture_day:  31
>   manufacture_month:  15
>   manufacturer:  
>   manufacture_year:  2107
>   model_name:
>   of_node:
>   power:
>   present:  1
>   serial_number:  ffff
>   status:  Discharging
>   subsystem:
>   technology:  Unknown
>   temp:  62804
>   time_to_empty_avg:  3932100
>   time_to_empty_now:  3932100
>   time_to_full_avg:  3932100
>   type:  Battery
>   uevent:
>   voltage_max_design:  65535000
>   voltage_min_design:  65535000
>   voltage_now:  65535000
>   wakeup10:
> 
> I suspected a hardware issue, but I can get battery info from the EC 
> just fine with the same kernel:
> 
>   $ sudo ectool battery
>   Battery info:
>     OEM name:               LGC
>     Model number:           L15L3PB
>     Chemistry   :           LiP
>     Serial number:          0E0C
>     Design capacity:        4050 mAh
>     Last full charge:       3341 mAh
>     Design output voltage   11100 mV
>     Cycle count             115
>     Present voltage         11671 mV
>     Present current         344 mA
>     Remaining capacity      2734 mAh
>     Flags                   0x06 BATT_PRESENT DISCHARGING
>   
>   $ sudo ectool version
>   RO version:    hana_v1.1.4824-d58e50539
>   RW version:    hana_v1.1.4825-1473136d99
>   Firmware copy: RW
>   Build info:    hana_v1.1.4825-1473136d99 2021-09-11 00:11:48 @chromeos-ci-firmware-us-central2-d-x32-0-jx9e
> 
> I have _another_ MT8173 Chromebook ("ASUS C202X") where things work 
> fine. But I couldn't find a good mainline kernel version for this one.
> Anyone have any idea what is going on?

FWIW, I have also experienced issues reading properties from the SBS batteries
before on chromebooks:

https://lore.kernel.org/all/924db470-8163-4454-8f59-f7372a132186@notapiano/

In those cases it was due to the EC firmware not implementing the SBS commands,
but that had already been fixed in the latest EC firmware release, so simply
updating the firmware fixed it.

I don't know how ectool works, but it might be fetching the battery properties
through a different mechanism (ie not SBS commands), so this might also be a bug
in the EC FW despite ectool working.

Thanks,
Nícolas

