Return-Path: <linux-pm+bounces-31379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6AB10A9B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F735456E8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB32D7809;
	Thu, 24 Jul 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr4J9atw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAB2D4B52;
	Thu, 24 Jul 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361331; cv=none; b=t8OhhW6zinj8Qoqyf/IKGnZ1mgHheNJpSv0plxvwsOAA6rhHa3WAqaE8JPKoE4e6cDkr2tT+3D4MsP6KoT5PaEMq11vFmcAN+o9aYzKKnG/s16SpXomRogwgu0Z2Y756XXIuQbl/VleFDPhD/BdnVvL1TTrocTlydy3nRCcksF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361331; c=relaxed/simple;
	bh=67zSSZqwjYr+8xiodgrBVucxwVcgdz0AdZGug76g45Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odM+722EKVJ2COQAnlxine+E0IrD+o9k+u8shOTn00GV2vRN5dr0hBjbLih/Fu/ZSNe4ROWHeZ26VeGoP05kFbObmgIJMDFvdrlXEaBNVo9Rtwxg4b1FqLlF85BfYNuSXeHr5K0OPAFPKGrsnPeP0JK7mPmQRsyMPYnk8FBEAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr4J9atw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEF3C4CEED;
	Thu, 24 Jul 2025 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361330;
	bh=67zSSZqwjYr+8xiodgrBVucxwVcgdz0AdZGug76g45Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vr4J9atwTvFQBKVjyBN1+tXzUOgNd8TF7KxCKa5tFOQCtHcGfx0qQ/8jJSqVzp/Se
	 8qlyeeXuXcxCEduLQyQecvD6I4pF6GBaNQk+v4/Z1cWIN2hRRrdLam2kdbrvaWC6Vt
	 3Pj8p25iWKewHj8CK85BTEjGw3ESqcIGEz2AjOmf41XljzC890GR9UxLe7gM4L3HA+
	 0h4aF9vlewntB2Urab0++/Qp3v38FS61Dd/vFDBlw+jH68sKO7Hd0OYJdq+XYKKkFD
	 CAkmQzKaNtUyzrH/3XNaGBt9EvH8rTcUIiZJ/lBo2LY5CbTytV3B0uW4EMWhgG/fBx
	 UI9tP7XD0FTlQ==
Message-ID: <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
Date: Thu, 24 Jul 2025 14:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/8] Implement vendor resets for PSCI SYSTEM_RESET2
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Stephen Boyd <swboyd@chromium.org>, Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Elliot Berman <quic_eberman@quicinc.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Elliot Berman <elliot.berman@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <beb26682-d2e4-40e6-89ac-87f18c0401d0@broadcom.com>
 <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/07/2025 14:24, Shivendra Pratap wrote:
> 
> 
> On 7/24/2025 5:46 AM, Florian Fainelli wrote:
>> On 7/21/25 11:28, Shivendra Pratap wrote:
>>> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
>>> additional reset types which could be mapped to the reboot
>>> argument.
>>>
>>> User-space should be able to reboot a device into different
>>> operational boot-states supported by underlying bootloader and
>>> firmware. Generally, some HW registers need to be written, based
>>> on which the bootloader and firmware decide the next boot state
>>> of device, after the reset. For example, a requirement on
>>> Qualcomm platforms may state that reboot with "bootloader"
>>> command, should reboot the device into bootloader flashing mode
>>> and reboot with “edl” command, should reboot the device into an
>>> Emergency flashing mode.  Setting up such reboots on Qualcomm
>>> devices can be inconsistent across SoC platforms and may require
>>> setting different HW registers, where some of these registers may
>>> not be accessible to HLOS. These knobs evolve over product
>>> generations and require more drivers.  PSCI defines a
>>> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
>>> firmware to take care of underlying setting for any such
>>> supported vendor-specific reboot. Qualcomm firmwares are
>>> beginning to support and expose PSCI SYSTEM_RESET2
>>> vendor-specific reset types to simplify driver requirements from
>>> Linux. With such support added in the firmware, we now need a
>>> Linux interface which can make use of the firmware calls for PSCI
>>> vendor-specific resets. This will align such reboot requirement
>>> across platforms and vendors.
>>>
>>> The current psci driver supports two types of resets –
>>> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
>>> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
>>> into the reset path of the psci driver and aligns it to work with
>>> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
>>> with a supported string-based command in “*arg”.
>>>
>>> The patchset uses reboot-mode based commands, to define the
>>> supported vendor reset-types commands in psci device tree node
>>> and registers these commands with the reboot-mode framework.
>>>
>>> The PSCI vendor-specific reset takes two arguments, being,
>>> reset_type and cookie as defined by the spec. To accommodate this
>>> requirement, enhance the reboot-mode framework to support two
>>> 32-bit arguments by switching to 64-bit magic values.
>>>
>>> Along this line, the patchset also extends the reboot-mode
>>> framework to add a non-device-based registration function, which
>>> will allow drivers to register using device tree node, while
>>> keeping backward compatibility for existing users of reboot-mode.
>>> This will enable psci driver to register for reboot-mode and
>>> implement a write function, which will save the magic and then
>>> use it in psci reset path to make a vendor-specific reset call
>>> into the firmware. In addition, the patchset will expose a sysfs
>>> entry interface within reboot-mode which can be used by userspace
>>> to view the supported reboot-mode commands.
>>>
>>> The list of vendor-specific reset commands remains open due to
>>> divergent requirements across vendors, but this can be
>>> streamlined and standardized through dedicated device tree
>>> bindings.
>>>
>>> Currently three drivers register with reboot-mode framework -
>>> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
>>> list of commands currently added across various vendor DTs:
>>>   mode-loader
>>>   mode-normal
>>>   mode-bootloader
>>>   mode-charge
>>>   mode-fastboot
>>>   mode-reboot-ab-update
>>>   mode-recovery
>>>   mode-rescue
>>>   mode-shutdown-thermal
>>>   mode-shutdown-thermal-battery
>>>
>>> Detailed list of commands being used by syscon-reboot-mode:
>>>      arm64/boot/dts/exynos/exynosautov9.dtsi:
>>>     mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
>>>     mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
>>>     mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
>>>
>>>      arm64/boot/dts/exynos/google/gs101.dtsi:
>>>          mode-bootloader = <0xfc>;
>>>          mode-charge = <0x0a>;
>>>          mode-fastboot = <0xfa>;
>>>          mode-reboot-ab-update = <0x52>;
>>>          mode-recovery = <0xff>;
>>>          mode-rescue = <0xf9>;
>>>          mode-shutdown-thermal = <0x51>;
>>>          mode-shutdown-thermal-battery = <0x51>;
>>>
>>>      arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>>>          mode-normal = <0x77665501>;
>>>          mode-bootloader = <0x77665500>;
>>>          mode-recovery = <0x77665502>;
>>>
>>>      arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>>>          mode-normal = <0x77665501>;
>>>          mode-bootloader = <0x77665500>;
>>>          mode-recovery = <0x77665502>;
>>>
>>>      arm64/boot/dts/rockchip/px30.dtsi:
>>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>>          mode-fastboot = <BOOT_FASTBOOT>;
>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>          mode-normal = <BOOT_NORMAL>;
>>>          mode-recovery = <BOOT_RECOVERY>;
>>>
>>>      arm64/boot/dts/rockchip/rk3308.dtsi:
>>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>          mode-normal = <BOOT_NORMAL>;
>>>          mode-recovery = <BOOT_RECOVERY>;
>>>          mode-fastboot = <BOOT_FASTBOOT>;
>>>
>>>      arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>>>          mode-normal = <BOOT_NORMAL>;
>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>             mode-recovery = <BOOT_RECOVERY>;
>>>             mode-bootloader = <BOOT_FASTBOOT>;
>>>
>>> Detailed list of commands being used by nvmem-reboot-mode:
>>>      arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
>>>             mode-recovery = <0x01>;
>>>             mode-bootloader = <0x02>;
>>>
>>> Previous discussions around SYSTEM_RESET2:
>>> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
>>> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>
>> On ARCH_BRCMSTB:
>>
>> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> For the sysfs bits, should not we be seeing "psci" instead of "reboot-mode" twice in this path:
>>
>> # cat /sys/class/reboot-mode/reboot-mode/reboot_modes
>> powercycle
> As per current patch, we create a class named - "reboot-mode".
> /sys/class/reboot-mode
> 
> Then comes the DT node name of the registering driver.
> /sys/class/reboot-mode/<DT node name of the registering driver>/

This means that node name becomes part of the ABI? I am not happy about
it. Where is such ABI documented? Because your last patch tells
something completely else!

I strongly insist using compatible as way to find your device, not node
names.

In any case you need to document such ABI in Devicetree bindings,
because sysfs ABI is not enough.

Best regards,
Krzysztof

