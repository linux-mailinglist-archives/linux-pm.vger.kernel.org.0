Return-Path: <linux-pm+bounces-19136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDBF9EE8C2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACE282729
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B41215048;
	Thu, 12 Dec 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UTCMwipG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0942147E3;
	Thu, 12 Dec 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013685; cv=none; b=NZFme7H8Tb+eiIHo5ndACuxOhI71DOWvMBnf2uvv2nt1kPFIwwt570D292cP/HskBjhDGd11F0s1Um8HJsWMjyvCrfr1FtiP8yt8yTew9SKDqbOryuQgI96jJB6eHsSPFJwSFLXnFkKzpkuiVZkAUP1TD7/lDWMmLXORFAfkb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013685; c=relaxed/simple;
	bh=zhbWlbfmCT2R0OnXcZwGTaUYbhyJtBWfLrYAfXhKGAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiA63rB1UvJ18QB6PLzownT+kVgJik48k9mJWjO35Q3WQYjCCcV7NQ/S31xjykXIpbuEr3bR9Cl1MfnDg+yZi8OaHWIHUDdOMa4lx4EMWCndGaesICHLxnqYoYOsvvKz4JVu0o+oiidbO8rJM3HrI3Mtipr+fbojSXYfqq0r1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UTCMwipG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734013673; x=1734618473; i=w_armin@gmx.de;
	bh=gBO0h3mLD00rm/CE/bkTi0A3SpHw5vASQnim86ZPijs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UTCMwipGh9hwCseroJ5piu4qvZgnYkINmW9nsBZ3QHSB9MCM2GDN2cjjbNtWQtDd
	 QMWrUxzLn56HrwOQR24h+vhQkz+68pRaKzVDTcsWaB4jCWrCGyL3oHpWKk2ANndxt
	 eLhw5xyzsDIfgNZHjqLzBZsRsu0Zo+Nuc6GUN3IaDcjiOJ13dCXGfbE5tCVabd9xU
	 cWRajQj6EMKv4P3bTXJqICandg9UW9sLqQ27sAgu5bbkEfvOVPC0F9/mNqqw1UJbG
	 E3seexqY/h/TlP4YL5dDUmJlPdv6pa7IpAXdMXraUWJN6zu5VEOiIDz0hSfIbZ46V
	 ePr29r6oZ0QON3yPPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.42.132] ([141.76.178.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1tH3D032wN-00GllY; Thu, 12
 Dec 2024 15:27:53 +0100
Message-ID: <2e2f4845-7500-40ec-985d-3a495842e020@gmx.de>
Date: Thu, 12 Dec 2024 15:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] power: supply: extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K4Q5wxQsGKPsci0M0ApYakQMV8M0E6bpoyZdHGjpQ3Z7+7AhLMR
 lRSliIne7RKZuAB8fO0tzzlQuQ5dGwxPTxJYor1myGKDgpEgCdwkbGzKxCuP84yYktzxUVm
 5H6XsPqJPD/U+h/OGsqxhJolz+AgSY2I3ZVhkYwzSamin8rt4AjvrP1G/D2dISV9Lv/BUe5
 gkpZ3TFohGshh5xxH9pfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4pLWmrWe7W0=;mzg2ZehVALyF+rvW/20+kkVWeio
 45oRq0QYMTgtCWcTlehvCTOPpz4dQZKkJmYMWt2YzlJzPdzlR8dvFK6T2bdT+zuXA+EfSfAup
 0JxJlU6FWNBpHNFV2MY/aP+r8PamDpk0+tkP6MJADyNxmqTWrQFxyU3xPzqShXWzIexqgkyFn
 iiybogy0cZt2V3mqxQ1R+O2uIKphvx2FHzmHvq4sS+2lZB0e0CDKF23HmR0l3XbN+/l3a+nlZ
 i9K3Bi6VpeuUP5RBxQ0BcKgvoiOdkfgjxd9cspffqsaEK1WdB0xwEEJFnCaaXBnzQADqWEpVY
 HRIxE5xPtPGmTu5MhCczLFwxNrZw98quqhNDz+7b9GrWWYeRsy+2rMJEdpPblDqWNmJRtifGZ
 lCt/f9Rm3ye4sgH4HMd86LCMvceCxeic22jSc/i5nTS91tiz7MMSb3k9QY4aUwB8HuoS2wOxM
 KRXDX0vA5U8QS+X0Igeq4sAuXFbtxm+qL0EXqCYfC0EXgjRUvwGTj0ybH7Lt+kZP3ng141SEq
 mpkigP/x/2XYGjlBd1nkMJlKisx7LAqeum9CUGoI36cSk+Zx6WSCr1vGozhrCtwxwc5UItEMe
 KRvoiVtVkPd9Bs8yyekegWDlA04aTpbDh5SaRB/yThiu6jNdYIq0BfrUFGFQuwvCuuPtAmUUa
 y9MsTeqCgv2IPEEp+/tI0O7jcsG8rQazvU/VmzKBNqf1+BnjPfLLCNvrSQA8gh+EcfCpMqHAM
 TAIHI1fFT60hRw663fGCr7oWrWujE4tg6ikIhG+PkuMx6i7K1lYBpfiKTxUgWGjU0Xedb7d5v
 FnvGnd83E4TEsJqTACy/UiWurvt74/4yMQeFiTNHoGijTzl/njKyRZk8kzf7Zu78p4noMhqVR
 4SPSUHQ6RTk6tXklqKUed0RNJan2Tn/OsOQ6ytKicJ/De9TuDuB5PhPJu+G58hNvuG6AaDxYm
 Zx7V8ibeBVR+sXKV4eHrolL9HGU0bCsDndRw7BufTz5CR/LFiGc8VKsckWYtSeCE/eIMZWU7e
 Z76olwJeA9AQNIHlvvO3XOQFQr8iPdSb9K9SSZxZ4YT6VSDlUQ80Rn+W/5tCBrxmM0J/5h5QV
 KqVOQ+9R8sf61k9r375JT6RMn5upls

Am 11.12.24 um 20:57 schrieb Thomas Wei=C3=9Fschuh:

> Introduce a mechanism for drivers to extend the properties implemented
> by a power supply.
>
> Motivation
> ----------
>
> Various drivers, mostly in platform/x86 extend the ACPI battery driver
> with additional sysfs attributes to implement more UAPIs than are
> exposed through ACPI by using various side-channels, like WMI,
> nonstandard ACPI or EC communication.
>
> While the created sysfs attributes look similar to the attributes
> provided by the powersupply core, there are various deficiencies:
>
> * They don't show up in uevent payload.
> * They can't be queried with the standard in-kernel APIs.
> * They don't work with triggers.
> * The extending driver has to reimplement all of the parsing,
>    formatting and sysfs display logic.
> * Writing a extension driver is completely different from writing a
>    normal power supply driver.
> * ~Properties can not be properly overriden.~
>    (Overriding is now explicitly forbidden)
>
> The proposed extension API avoids all of these issues.
> An extension is just a "struct power_supply_ext" with the same kind of
> callbacks as in a normal "struct power_supply_desc".
>
> The API is meant to be used via battery_hook_register(), the same way as
> the current extensions.
> Further usecases are fuel gauges and the existing battery_info
> properties.
>
> When testing, please enable lockdep to make sure the locking is correct.
>
> The series is based on the linux-power-supply/for-next branch.
> It also depends on some recent fixes not yet available in the for-next
> branch [0].
>
> [0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81=
fb27e1cff4@weissschuh.net/
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v6:
> - Drop alreay picked up ACPI battery hook rename patch
> - Only return bool from power_supply_property_is_writeable()
> - Improve naming for test_power symbols
> - Integrate cros_charge-control fixes from the psy/fixes branch
> - Add sysfs UAPI for extension discovery
> - Use __must_check on API
> - Make power_supply_for_each_extension() safer.
>    (And uglier, ideas welcome)

Maybe we can use a do { ... } while (0) construct here.

> - Link to v5: https://lore.kernel.org/r/20241205-power-supply-extensions=
-v5-0-f0f996db4347@weissschuh.net
>
> Changes in v5:
> - Drop already picked up patches
> - Simplify power_supply_ext_has_property()
> - Handle failure of power_supply_update_sysfs_and_hwmon()
> - Reduce some locking scopes
> - Add missing locking to power_supply_show_charge_behaviour()
> - Improve sanity checks in power_supply_register_extension()
> - Implement writeable property in test_power battery
> - Rename ACPI battery hook messages for clarity
> - Link to v4: https://lore.kernel.org/r/20241111-power-supply-extensions=
-v4-0-7240144daa8e@weissschuh.net
>
> Changes in v4:
> - Drop RFC state
> - Integrate locking commit
> - Reregister hwmon device
> - Link to v3: https://lore.kernel.org/r/20240904-power-supply-extensions=
-v3-0-62efeb93f8ec@weissschuh.net
>
> Changes in v3:
> - Make naming more consistent
> - Readd locking
> - Allow multiple active extensions
> - Allow passing a "void *ext_data" when registering
> - Switch example driver from system76 to cros_charge-control
> - Link to v2: https://lore.kernel.org/r/20240608-power-supply-extensions=
-v2-0-2dcd35b012ad@weissschuh.net
>
> Changes in v2:
> - Drop locking patch, let's figure out the API first
> - Allow registration of multiple extensions
> - Pass extension to extension callbacks as parameter
> - Disallow property overlap between extensions and core psy
> - Drop system76/pdx86 maintainers, as the system76 changes are only RFC
>    state anyways
> - Link to v1: https://lore.kernel.org/r/20240606-power-supply-extensions=
-v1-0-b45669290bdc@weissschuh.net
>
> ---
> Thomas Wei=C3=9Fschuh (4):
>        power: supply: core: implement extension API
>        power: supply: test-power: implement a power supply extension
>        power: supply: cros_charge-control: implement a power supply exte=
nsion
>        power: supply: core: add UAPI to discover currently used extensio=
ns
>
>   Documentation/ABI/testing/sysfs-class-power |   9 ++
>   drivers/power/supply/cros_charge-control.c  | 200 ++++++++++++--------=
--------
>   drivers/power/supply/power_supply.h         |  19 +++
>   drivers/power/supply/power_supply_core.c    | 177 ++++++++++++++++++++=
++--
>   drivers/power/supply/power_supply_sysfs.c   |  36 ++++-
>   drivers/power/supply/test_power.c           | 113 ++++++++++++++++
>   include/linux/power_supply.h                |  35 +++++
>   7 files changed, 467 insertions(+), 122 deletions(-)
> ---
> base-commit: 810dde9dad8222f3b831cf5179927fc66fc6a006
> change-id: 20240602-power-supply-extensions-07d949f509d9
>
> Best regards,

