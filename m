Return-Path: <linux-pm+bounces-30632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38640B00CF2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB721C41065
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D72FD5B6;
	Thu, 10 Jul 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PtWsIt+m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF32FC3B3
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178813; cv=none; b=ZMc4yddwgqHHUhqlmXIPvZQN1ZdKC/QjMyII4ubgW3GuYjObPtXMuPhLq9tVy1uVfCJINKqK/sMW6aXlOUGcWvW3QdVXhJBIx9djwM1VZ2mhieql8UqgxCFT83y9gpQI36iquFf3ZqwR6wxRIqfjLNQShkgJ5OEcCwAgrAcW3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178813; c=relaxed/simple;
	bh=EFpUUux5IGFLjI8F9dyw5URIdRYoHLpUtpWMUT+bYN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcT7JAOKEFeIU1Q2GmKgYvhGXyHiQECMtJ+r6Ch+F6F6hurlPR0VI1cVxMWdW6/5VbuiIagXYMJA0T4/plLLC/42eDQ9fHgRBCKCZwIQd/XKCTydElfrDCHUK847DAe6UkVWuXM7JKh32lJQLJIFGZk/Or4FU+F4p3ilUbtxut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PtWsIt+m; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1092791b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752178811; x=1752783611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fDA1snVpr4c+NFAM0uEmirZxMpXwZuvq35CUMbMBbtw=;
        b=PtWsIt+mkTOqqG26WG96b1qMA6jeH38ZRWXxG2M2exGEWi7aiHa+NBNu5N7pbQwL7f
         i7MAHSljI1W7Rt+gPgcOpbijdCk2o9E0naKrQ/qgc4vwAu5asr1nd0Zt06Nl7tyh/uRv
         GCGA/+55IMTYGVftSlUSTtrVTyGvDeoTHzoAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178811; x=1752783611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDA1snVpr4c+NFAM0uEmirZxMpXwZuvq35CUMbMBbtw=;
        b=n3Lc23hO+LwetOGkB0st7GGMJBLyU0GGuUUsCpa3uWfphusfMyFRA71+Q2I0i8RMcI
         wtShY2bXSgWlJqnTB4n9l15cak8kBVbonYE6zeUk5a0kdH0PnIyjwI3BW/bt1vHEOTzO
         gYmE4Jee7AsNR6O2zNoSL95d2JPIU4Q+pFl90XBX6VtvFC7UYovc/RnihT8pK3O7MAMZ
         klWV3L2Lz748Dq45FGc421i2SVSWHBkAvOJrm+3DoWw2fNHLp4s7dEFvouY8HcXXZRwO
         b46g+AOAOmppHU3okIoucsRJpenPK39yewhS8n041ICxH37cSkeFUe5sOevnpqjcxYCv
         W9uA==
X-Forwarded-Encrypted: i=1; AJvYcCVmS9DI5ApuLh23Ci7K+WqIjEPTFRExXJisAMJ0pMwxYePj3paU82XNrR62aG/CzdGUJxFlddXkIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyANnb7YqxZ45W6/o9+8ZdmaqGbl4RildcoqY7/SVl28eGYLLc1
	RKwCTvY71BGiEgzrvgiUUQUuqunytEUyTsGI7No5saCexvoOqTkWKRXW/i/ac9Eu1g==
X-Gm-Gg: ASbGncsx7T0CIatkAf9p1VH0Pr5ajwrRRWRbT3GAewpa9k/GS1QX4Ckprjj3Qku6IYi
	Af5QqqdKIxmm+mVE2AG70QjmjmKytH3ff5kLBm0KsDq3JlLvtgEU0vtwfK2+UzSunL/WLO6rvme
	6niFBqBCPy78v8egIzmeSHwNKlji/p4vdGs7AON/HWeOKXmXATvyUFusQYipDnS0NF86llieYf6
	cBzzavLiHQek46tpJYup7v+ijSMbJ2NdKzVqVe1bwtCTiO9poHVEaR8lNYy7+2o8gzo8RGQunT3
	IL+JYkI6G+aOFPnkCBLZ18hlP79r92kZ4aMVj4xOSUbVF+UhksDNoFGAJ/RRtszQWzUb8ucSiSi
	1K6kJtYieGudvBixoG6vugayLdw==
X-Google-Smtp-Source: AGHT+IFL7AIbBKtnmbpYy0bxdMeh4A8w6D5qedofW87hyUDv74Ybf7PLb906ZmUsinFv9/MPjCLj0w==
X-Received: by 2002:a05:6a21:a81:b0:21f:a883:d1dd with SMTP id adf61e73a8af0-2311e93bfbfmr940590637.14.1752178811479;
        Thu, 10 Jul 2025 13:20:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72f8a9sm2946867a12.74.2025.07.10.13.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 13:20:10 -0700 (PDT)
Message-ID: <34dde6a1-bb75-45ed-a20d-057e3f32f592@broadcom.com>
Date: Thu, 10 Jul 2025 13:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/10] Implement vendor resets for PSCI SYSTEM_RESET2
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, Konrad Dybcio <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Andre Draszik <andre.draszik@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Wei Xu <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Elliot Berman <elliot.berman@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/25 02:15, Shivendra Pratap wrote:
> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
> additional reset types which could be mapped to the reboot
> argument.
>   
> User-space should be able to reboot a device into different
> operational boot-states supported by underlying bootloader and
> firmware. Generally, some HW registers need to be written, based
> on which the bootloader and firmware decide the next boot state
> of device, after the reset. For example, a requirement on
> Qualcomm platforms may state that reboot with "bootloader"
> command, should reboot the device into bootloader flashing mode
> and reboot with “edl” command, should reboot the device into an
> Emergency flashing mode.  Setting up such reboots on Qualcomm
> devices can be inconsistent across SoC platforms and may require
> setting different HW registers, where some of these registers may
> not be accessible to HLOS. These knobs evolve over product
> generations and require more drivers.  PSCI defines a
> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
> firmware to take care of underlying setting for any such
> supported vendor-specific reboot. Qualcomm firmwares are
> beginning to support and expose PSCI SYSTEM_RESET2
> vendor-specific reset types to simplify driver requirements from
> Linux. With such support added in the firmware, we now need a
> Linux interface which can make use of the firmware calls for PSCI
> vendor-specific resets. This will align such reboot requirement
> across platforms and vendors.
>   
> The current psci driver supports two types of resets –
> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
> into the reset path of the psci driver and aligns it to work with
> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
> with a supported string-based command in “*arg”.
> 
> The patchset uses reboot-mode based commands, to define the
> supported vendor reset-types commands in psci device tree node
> and registers these commands with the reboot-mode framework.
> 
> The PSCI vendor-specific reset takes two arguments, being,
> reset_type and cookie as defined by the spec. As the
> vendor-specific reset needs two arguments reset_type and cookie
> to be passes to the firmware, enhance the reboot-mode framework
> to support two arguments (magic and cookie), for each reboot-mode
> command, where cookie will be optional.
> 
> Along this line, the patchset also extends the reboot-mode
> framework to add a non-device-based registration function which
> will allow drivers to register using DT node, while keeping
> backward compatibility for existing users of reboot-mode. This
> will enable psci driver to register for reboot-mode and implement
> a write_with_cookie function which will save the
> magic(reset_type) and cookie and then use it in psci reset path
> to make a vendor-specific reset call into the firmware. In
> addition, the patchset will expose a sysfs entry interface within
> reboot-mode which can be used by userspace to view the supported
> reboot-mode commands.
> 
> The list of vendor-specific reset commands remains open due to
> divergent requirements across vendors, but this can be
> streamlined and standardized through dedicated device tree
> bindings.
> 
> Currently three drivers register with reboot-mode framework -
> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
> list of commands currently added across various vendor DTs:
>   mode-loader
>   mode-normal
>   mode-bootloader
>   mode-charge
>   mode-fastboot
>   mode-reboot-ab-update
>   mode-recovery
>   mode-rescue
>   mode-shutdown-thermal
>   mode-shutdown-thermal-battery
> 
> Detailed list of commands being used by syscon-reboot-mode:
>      arm64/boot/dts/exynos/exynosautov9.dtsi:
> 	mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
> 	mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
> 	mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
> 
>      arm64/boot/dts/exynos/google/gs101.dtsi:
>      	mode-bootloader = <0xfc>;
>      	mode-charge = <0x0a>;
>      	mode-fastboot = <0xfa>;
>      	mode-reboot-ab-update = <0x52>;
>      	mode-recovery = <0xff>;
>      	mode-rescue = <0xf9>;
>      	mode-shutdown-thermal = <0x51>;
>      	mode-shutdown-thermal-battery = <0x51>;
> 
>      arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>      	mode-normal = <0x77665501>;
>      	mode-bootloader = <0x77665500>;
>      	mode-recovery = <0x77665502>;
> 
>      arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>      	mode-normal = <0x77665501>;
>      	mode-bootloader = <0x77665500>;
>      	mode-recovery = <0x77665502>;
> 
>      arm64/boot/dts/rockchip/px30.dtsi:
>      	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>      	mode-fastboot = <BOOT_FASTBOOT>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-recovery = <BOOT_RECOVERY>;
> 
>      arm64/boot/dts/rockchip/rk3308.dtsi:			
>      	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-recovery = <BOOT_RECOVERY>;
>      	mode-fastboot = <BOOT_FASTBOOT>;
> 
>      arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
> 			mode-recovery = <BOOT_RECOVERY>;
> 			mode-bootloader = <BOOT_FASTBOOT>;
> 
> Detailed list of commands being used by nvmem-reboot-mode:
>      arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
> 			mode-recovery = <0x01>;
> 			mode-bootloader = <0x02>;
> 
> Previous discussions around SYSTEM_RESET2:
> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Humm, something changed compared to the last version that I tested from 
Elliot which worked ok. With this patch applied and the following Device 
Tree snippet:

         psci {
                 method = "smc";
                 compatible = "arm,psci-0.2", "arm,psci";
                 cpu_on = <0xc4000003>;
                 cpu_suspend = <0xc4000001>;
                 cpu_off = <0x84000002>;

                 reset-types {
                         mode-powercycle = <0x01>;
                 };
         };

I get the following invoking "reboot powercycle":

# reboot powercycle
[   21.403188] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000 is not a phandle reference
[   21.412032] Mem abort info:extended_property): 
/rdb/waketimer@841a840:interrupts-extended: cell 0 is not a phandle 
reference
[   21.414840]   ESR = 0x0000000086000004operty): 
/rdb/waketimer@841a840:interrupts-extended: cell 2 is not a phandle 
reference
[   21.418601]   EC = 0x21: IABT (current EL), IL = 32 bitsparent: cell 
0 is not a phandle reference
[   21.423927]   SET = 0, FnV = 0: /rdb/xhci_v2@8d00000:phys: cell 0 is 
not a phandle reference
[   21.426988]   EA = 0, S1PTW = 0 /rdb/sata@8b0a000/sata-port@0:phys: 
cell 0 is not a phandle reference
[   21.430138]   FSC = 0x04: level 0 translation fault:phys: cell 0 is 
not a phandle reference
[   21.435054] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010112c000 
a phandle reference
[   21.441508] [0000000000000000] pgd=0000000000000000, 
p4d=0000000000000000handle reference
[   21.448318] Internal error: Oops: 0000000086000004 [#1]  SMPcell 0 is 
not a phandle reference
[   21.453990] Modules linked in: bdc 
udc_core/thermal-zones/cpu-thermal:thermal-sensors: cell 0 is not a 
phandle reference
[   21.458188] CPU: 0 UID: 0 PID: 1566 Comm: reboot Not tainted 
6.16.0-rc5-next-20250710-gdd78270edd5a #2 NONE 4)
[   21.468032] Hardware name: BCX972160DV (DT)ases property name must 
include only lowercase and '-'
[   21.472221] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)only lowercase and '-'
[   21.479193] pc : 0x0s_paths): /aliases:pcie0: aliases property is not 
a valid node (/pcie@8b10000)
[   21.481388] lr : reboot_mode_notify+0x64/0x80es property name must 
include only lowercase and '-'
[   21.485760] sp : ffff80008344bbe0iases: aliases property name must 
include only lowercase and '-'
[   21.489079] x29: ffff80008344bbe0 x28: ffff0000c3bb3d00 x27: 
ffff800080ab58e8ly lowercase and '-'
[   21.496228] x26: 0000000000000000 x25: ffff0000c3bb3d00 x24: 
ffff800082cf9bc8ly lowercase and '-'
[   21.503376] x23: ffff80008344bcb8 x22: 0000000000000001 x21: 
ffff0000c31b87b0
[   21.510524] x20: 00000000fffffffc x19: ffff0000c31b8780 x18: 
0000000000000000
[   21.517673] x17: 0000000000000000 x16: 0000000000000000 x15: 
0000000000000000
[   21.524821] x14: 0000000000000000 x13: 0000000000000000 x12: 
0000000000000000
[   21.531969] x11: 0000000000000000 x10: 00007fffc02bb958 x9 : 
0000000000000010
[   21.539118] x8 : 0101010101010101 x7 : 0000000000000000 x6 : 
000080c38080ffff
[   21.546266] x5 : ffff0000c3000000 x4 : 0000808000800000 x3 : 
0000000000000000
[   21.553415] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 
ffff0000c31b8780
[   21.560565] Call trace:
[   21.563014]  0x0 (P)
[   21.565205]  notifier_call_chain+0x70/0x120
[   21.569401]  blocking_notifier_call_chain+0x4c/0x78
[   21.574288]  kernel_restart+0x30/0xc8
[   21.577957]  __do_sys_reboot+0x1c8/0x268
[   21.581886]  __arm64_sys_reboot+0x28/0x38
[   21.585902]  invoke_syscall+0x4c/0x118
[   21.589660]  el0_svc_common.constprop.0+0x44/0xe8
[   21.594373]  do_el0_svc+0x20/0x30
[   21.597694]  el0_svc+0x18/0x58
[   21.600758]  el0t_64_sync_handler+0x98/0xe0
[   21.604947]  el0t_64_sync+0x154/0x158
[   21.608625] Code: ???????? ???????? ???????? ???????? (????????)
[   21.614730] ---[ end trace 0000000000000000 ]---
Segmentation fault
#

--
Florian

