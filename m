Return-Path: <linux-pm+bounces-8745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A931C8FF7F0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 01:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272B41F23D5E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993D13C9AF;
	Thu,  6 Jun 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q6gQnW5b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A2535C8;
	Thu,  6 Jun 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715423; cv=none; b=RsIivA2gUSgbHWSHVw4IwafTsquJMFEBha4nhBokWB6FyZdoHFNOlJOebH8xAzIB7adLqWPGsovW7Vo/zCQmUX6YhQJEx91B+guogYrZct0cAZBNVBkvFEdJ5igdx/LJ+qa3HJcDmtMIv6NTiJ8l4ca+8RB6IN7LhCsO62+ACww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715423; c=relaxed/simple;
	bh=uZpkgoX0ZHSHKRvOkliopYBpBqKI54AIsFmuJuGonpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgDST6D1mQq9GJW7ZE5uaJKiUmKhvW0CjqfwYy/oQQjSninrC9+iVV68zx/RP2ShTNIK7EhRxcopr3VC6igpqClXa2Bzy92dValULIkZ2/sd4R6YaCWLIivJwy0oCVPHDLr4JzLXQ77ycgnAh5bDpePSH3EwCIUGy52JCyKeCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q6gQnW5b; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717715406; x=1718320206; i=w_armin@gmx.de;
	bh=r3UGZP34pSdCmuoOJgMLTbyJg868znqcxvx43HN2viE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q6gQnW5bOtCEi1nVGIYxOcAaBidptP7+BrLsnZg9avgowE50UZV9iwyKRFNjrDuC
	 x5Y0TiClPTp+sddKKPgODlZ790UGsU+aVV2TGG4o5Zww1fH6lCbix2AxEnWeIZMCt
	 JY4nHotNpQUA23uJK5tU2kKIw2eg5MIeFJuVyreff19Sva3k4fM0LOPDMBukW8nE7
	 BO1P4Dt7cqa5HQPAR31+kVIM00epm8dvvF7OKoW060xftdQjcU5Gp2H9f0r33tgQV
	 7lR249t/jW8yoaijCJWSNSEWwr1eYcvyjI0dgNABx6mTsxh+B+tVmgUmcXjiTL0UG
	 4yt91Htsroe3Ss6ScQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1sLi2I3U79-004ZsM; Fri, 07
 Jun 2024 01:10:06 +0200
Message-ID: <41964782-222c-45fa-846e-3656eff5b3a9@gmx.de>
Date: Fri, 7 Jun 2024 01:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] power: supply: extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XnmGkXgamiaRxbeD1IgTCuqVk0j44qy6FU4T+qzoOk8JwvhHzkv
 YWoTQXvyvgvBhvD0ChNHo3jLStW1ghBT4BArjhDhFTXAiknsDMFIabIuzXgqb/UH9lCTOTw
 cMXs0pWkNAMPFWgEYcuTVfw5y05Xw7LKcuwBXKIjhWCP2RNmXKbELwxw5yAw9phpqJDugsL
 YlWXebXi0sAXHDnHVWzZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8wTKlJo3rsU=;SqIwOCNJCMxsa8ebkdNaNyBqs8Q
 zoSwcJsNH5kreIpL5om/BP5kCqirGqrg6lkcwNqMgO0i118AI8cTU30HRAcrTIRxoE/TpV4I5
 gWniWCYXI4lpIu+KdUS/WRF9wc3HrMDe4hWRHTeNCWRviGX9mr7MpuLi0ZcxbiRkmHxDmuA8F
 n/T5Pw0TeaIclOV9P9dIzcbud4dsZMQqwlkAFnlQgxYOSw/9V1LCIDbfKumyVBxvQ+TVTdWyS
 daFu0MwdnZ6oTCrA0H/Pz7u2ggPTmavD535yKYhyQ3O+kGaKbR6ZlqWsG+xUFKuBupQiBgFx8
 pyGfD1CZPiSNunQORGpVyr7K/5LBIprPNLJXUTiP2gsWf0IoaHOelsco2G6ISsCOBrlco7+45
 WNrOA2rij2E8PeemO4Z4PdVKMsxj5cPvu/C8co9rQtlvGAa2JW/0U9SKIi67d/AVoBDxz+nn0
 VemW/lhxkY65QC0tm1xe62c2tABLdJBysEAmmB/esq9nlUkReM+tuNAp/8iD60AXskPqk4bly
 +eYtgFWdNBmm9LtPfNFsf6Ch3t/OsK5IozgHtKKQ+2WgP2bU8LwJVEYgCB/+IdSmW2o32ymvx
 x8N7BLea37/9c0zaBvEL0t2f5yEFV6QgDB81MTfzqQz6OW55YGCGgJi/WwytwP7kJYiDYW9X4
 EUve18pVY1YTgNJHMD4T9tqs0HwB8xQthn7zfF/WBIEQGyKEQON9nKGagMy/fV/9bblcUFmXB
 ItjPIh4UBwGmfE/c3BCI333wHnAvUpc7DGkTTsu1RgOn+PwMZBPItZ7m6HO9oH5mWqM/pqzkT
 Mfyvwh4NgRP0JoRaUnaSTShUJm+8araJLJ/lN8m87WYuY=

Am 06.06.24 um 16:50 schrieb Thomas Wei=C3=9Fschuh:

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
> * Properties can not be properly overriden.
>
> The proposed extension API avoids all of these issues.
> An extension is just a "struct power_supply_ext" with the same kind of
> callbacks as in a normal "struct power_supply_desc".
>
> The API is meant to be used via battery_hook_register(), the same way as
> the current extensions.
>
> For example my upcoming cros_ec charge control driver[0] saves 80 lines
> of code with this patchset.
>
> Contents
> --------
>
> * Patch 1 and 2 are generic preparation patches, that probably make
>    sense without this series.
> * Patch 3 implements the extension API itself.
> * Patch 4 implements a PoC locking scheme for the extension API.
> * Patch 5 adds extension support to test_power.c
> * Patch 6 converts the in-tree platform/x86/system76 driver to the
>    extension API.
>
> Open issues
> -----------
>
> * Newly registered properties will not show up in hwmon.
>    To do that properly would require some changes in the hwmon core.
>    As far as I know, no current driver would extend the hwmon properties=
 anyways.
> * As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
>    it also be gated behind this or another config?
> * Only one extension can be used at a time.
>    So far this should be enough, having more would complicate the
>    implementation.
> * Is an rw_semaphore acceptable?
>
> [0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81=
fb27e1cff4@weissschuh.net/

Nice, i love this proposal!

I agree that the hwmon update functionality will need some changes in the =
hwmon core to work,
but there would be at least one driver benefiting from this (dell-wmi-ddv)=
. Maybe we can add
support for this at a later point in time.

The possibility of registering multiple power supply extensions on a singl=
e power supply will
be necessary to support battery charge control on Dell notebooks in the fu=
ture. This is because
there will be two drivers on Dell notebooks which register battery extensi=
ons: dell-wmi-ddv and
dell-laptop (when support for battery charge control is supported someday)=
.

How difficult would it be to support such scenarios? If its very difficult=
, then maybe we can implement
this later when the need arises.

Thanks,
Armin Wolf

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (6):
>        power: supply: sysfs: use power_supply_property_is_writeable()
>        power: supply: core: avoid iterating properties directly
>        power: supply: core: implement extension API
>        power: supply: core: add locking around extension access
>        power: supply: test-power: implement a power supply extension
>        platform/x86: system76: Use power_supply extension API
>
>   drivers/platform/x86/system76_acpi.c      |  83 +++++++++---------
>   drivers/power/supply/power_supply.h       |   9 ++
>   drivers/power/supply/power_supply_core.c  | 136 ++++++++++++++++++++++=
++++++--
>   drivers/power/supply/power_supply_hwmon.c |  48 +++++------
>   drivers/power/supply/power_supply_sysfs.c |  39 ++++++---
>   drivers/power/supply/test_power.c         | 102 ++++++++++++++++++++++
>   include/linux/power_supply.h              |  25 ++++++
>   7 files changed, 357 insertions(+), 85 deletions(-)
> ---
> base-commit: 2df0193e62cf887f373995fb8a91068562784adc
> change-id: 20240602-power-supply-extensions-07d949f509d9
>
> Best regards,

