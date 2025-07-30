Return-Path: <linux-pm+bounces-31588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEDB15AEA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A90818A39DF
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21DC291C3E;
	Wed, 30 Jul 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/ERrKBa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E931290D81
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865419; cv=none; b=dQ7bIniODeHvEsTt0c5BpmX29W/h2+cefc+Pz94APJSuvcJ+Wz2M1y/l3Yl3dloFCvewYFGGQV5Vz4ea7DBId1KcV5Mvkau9xdDCetkwD1xq4eIM+xbglIO/7Wm8Y/ID9VjlXlaG5D0XW45IHgQh8tN69gNKgZoZ6YrJS8UJXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865419; c=relaxed/simple;
	bh=ljTXndF1vbp9IbkKsk1YK6cLijz/AzgIMTH2K+NqXEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORZAeB7rPl5Xz8xVBTKQoY4+w53140sAh2QxvpIq7C4fQ27/4Qql2i1bQJ+zJgl6Uy5Z2VuWw/3z9KJ9Xh+7TrHJpUMLnTHw8snR/ce0Vp3tSZEruSaDVMr02FS6c+CN03OxKgvImlJ8XnSeNSyl/dYqganraj0VqvrzAzu2mDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C/ERrKBa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b780bdda21so3886114f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753865414; x=1754470214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7BSR2H09GSO3RFnS7EoSmvDfZjaApJ8e7UO2X4YOog=;
        b=C/ERrKBa2t/zwxDAcI/Y+D+WLJmtX7l+Qt1+BuY1Hd9MY879XPG8GpWSwqkZ+79I5L
         k/+CN8DhRSsetZ3M65qY7D34TjdSZK8FOH/Hg1UlNhoaQDKznsxtzYsIBdT/ZBWL2BAh
         f/syZRbHTvdvQmCduaysn/IcoFnQqZu7kyiDBvmyFWn7+bb0cz8C3Y2TPhmzVPI5iyKC
         +JDlFIEcHMMwgczRJr0nTTf34IysH4PQpU7zcy7dw15EpFVI/cnmDqDhjNkoP+Eq40D+
         fw2f32S3GULOBFV93xJwJg1yVcUAX+HiG7BCeZDgIjSzIzort66LJe3NSTMAAONC0Kpy
         9THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753865414; x=1754470214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7BSR2H09GSO3RFnS7EoSmvDfZjaApJ8e7UO2X4YOog=;
        b=CBTo01sh8qdHQ9eWX7zheBOPV6AhipDlT+872vkmSecgvIiAFQmQ7ACACQj2/nxWcA
         cDeyRvcN9Hzl4ccbl0H3llO70iS+cbOUzMzP4s03MX6RWDrX00bYotHSYck6p6Nmu7NP
         F2Cypaa0zcxdfLPCy0+1bpNHyxpl++epwrZxGk0zbWJ+tjOPSbjICiHWTci7oMX5Qpf/
         wBlAbCpCfMMjRwSQg6mMs58CHzRgeP5YMQteGvg8TBRz62dSVRQkaBIa1c24zqej37Y2
         ewq09MPYkLxYPnjul6RtHDXtQepaIE/cQlIjK/BsHu/K7tNWHJSy6OG1STMN+WlhLJ1h
         i72g==
X-Forwarded-Encrypted: i=1; AJvYcCWgBqqoWueHAX1PFyHsT9YXMRL7mLJ4TxgPCK0I42/RNKXiqSaLsQ3jcfzGw9EA2WaEQWU9Q4bhvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznJeNuLH/kVtwS23fA/GUnywzh1EfL2wWb3iyGcQ+Iwm5VsqRv
	MzKVaTqujajG4YFgWh0ejJxMfA5QZSIr862Cyt2zoRMs7PmbcEImRvn2GrYLEvtRWEA=
X-Gm-Gg: ASbGncun0iA2/D582wDtCykZDZfGlLEmIntEceEjPPVfSTTIyHf60lyzGvfx6wvZYPq
	QF6ItBBxQCCFCmzSlMdxNggNTdAuZ/bw9KO4Fwl3w4fk4vA+/QwEqwIXqw6XcxMC+3CHgHPEbr6
	stqYx7NRYqb5gbNfCGzDneUnnSs4erfzPKSOC2K+6jyApN+6Hp3XKtgXR3Lvq2izsUAwc8y41PN
	4ssx2smD9bGnEF97kYwSAp14Qdnor6zJ9KRkqa7Oh9mnJJaooqZUKY967XUd5TOYHC5pTjmbl4X
	eXiz+Hkr5350V4QXyLE6NmMhbTMGRbFxJtb65KuoXE5kuUMxpt14BvVYyNws700/XcWswb8HAhx
	uZf1dGN7r5TTinkGi1jMrFqzoGw==
X-Google-Smtp-Source: AGHT+IEg1BQklZ5Qkv0BR0xWFD6Q0Ud2HpsszYAgNSY4ON6m/7RU/WLZYwZcm23/t+H+TEY1JJPw9Q==
X-Received: by 2002:a05:6000:1a86:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3b794fc185dmr1673402f8f.9.1753865414385;
        Wed, 30 Jul 2025 01:50:14 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78a9d3d03sm8391452f8f.2.2025.07.30.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:50:13 -0700 (PDT)
Message-ID: <a4d937482f2a94fbb822150fbc6c06c914940e1a.camel@linaro.org>
Subject: Re: [PATCH v13 00/10] Implement vendor resets for PSCI SYSTEM_RESET2
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, Bartosz
 Golaszewski	 <bartosz.golaszewski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>,  Sebastian Reichel	 <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Sudeep Holla	 <sudeep.holla@arm.com>, Souvik Chakravarty
 <Souvik.Chakravarty@arm.com>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Yan	 <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio
 <konradybcio@kernel.org>, 	cros-qcom-dts-watchers@chromium.org, Vinod Koul
 <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Florian Fainelli	 <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha
	 <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
 Srinivas Kandagatla
	 <srini@kernel.org>, Elliot Berman <elliot.berman@oss.qualcomm.com>, Konrad
 Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 09:50:11 +0100
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
References: 
	<20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-27 at 21:54 +0530, Shivendra Pratap wrote:
> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
> additional reset types which could be mapped to the reboot
> argument.
>=20
> User-space should be able to reboot a device into different
> operational boot-states supported by underlying bootloader and
> firmware. Generally, some HW registers need to be written, based
> on which the bootloader and firmware decide the next boot state
> of device, after the reset. For example, a requirement on
> Qualcomm platforms may state that reboot with "bootloader"
> command, should reboot the device into bootloader flashing mode
> and reboot with =E2=80=9Cedl=E2=80=9D command, should reboot the device i=
nto an
> Emergency flashing mode.=C2=A0 Setting up such reboots on Qualcomm
> devices can be inconsistent across SoC platforms and may require
> setting different HW registers, where some of these registers may
> not be accessible to HLOS. These knobs evolve over product
> generations and require more drivers.=C2=A0 PSCI defines a
> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
> firmware to take care of underlying setting for any such
> supported vendor-specific reboot. Qualcomm firmwares are
> beginning to support and expose PSCI SYSTEM_RESET2
> vendor-specific reset types to simplify driver requirements from
> Linux. With such support added in the firmware, we now need a
> Linux interface which can make use of the firmware calls for PSCI
> vendor-specific resets. This will align such reboot requirement
> across platforms and vendors.
>=20
> The current psci driver supports two types of resets =E2=80=93
> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
> into the reset path of the psci driver and aligns it to work with
> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
> with a supported string-based command in =E2=80=9C*arg=E2=80=9D.
>=20
> The patchset uses reboot-mode based commands, to define the
> supported vendor reset-types commands in psci device tree node
> and registers these commands with the reboot-mode framework.
>=20
> The PSCI vendor-specific reset takes two arguments, being,
> reset_type and cookie as defined by the spec. To accommodate this
> requirement, enhance the reboot-mode framework to support two
> 32-bit arguments by switching to 64-bit magic values.
>=20
> Along this line, the patchset also extends the reboot-mode
> framework to add a non-device-based registration function, which
> will allow drivers to register using device tree node, while
> keeping backward compatibility for existing users of reboot-mode.
> This will enable psci driver to register for reboot-mode and
> implement a write function, which will save the magic and then
> use it in psci reset path to make a vendor-specific reset call
> into the firmware. In addition, the patchset will expose a sysfs
> entry interface within reboot-mode which can be used by userspace
> to view the supported reboot-mode commands.
>=20
> The list of vendor-specific reset commands remains open due to
> divergent requirements across vendors, but this can be
> streamlined and standardized through dedicated device tree
> bindings.
>=20
> Currently three drivers register with reboot-mode framework -
> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
> list of commands currently added across various vendor DTs:
> =C2=A0mode-loader
> =C2=A0mode-normal
> =C2=A0mode-bootloader
> =C2=A0mode-charge
> =C2=A0mode-fastboot
> =C2=A0mode-reboot-ab-update
> =C2=A0mode-recovery
> =C2=A0mode-rescue
> =C2=A0mode-shutdown-thermal
> =C2=A0mode-shutdown-thermal-battery
>=20
> Detailed list of commands being used by syscon-reboot-mode:
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/exynos/exynosautov9.dtsi:
> 	mode-bootloader =3D <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
> 	mode-fastboot =3D <EXYNOSAUTOV9_BOOT_FASTBOOT>;
> 	mode-recovery =3D <EXYNOSAUTOV9_BOOT_RECOVERY>;
>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/exynos/google/gs101.dtsi:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-bootloader =3D <0xfc>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-charge =3D <0x0a>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-fastboot =3D <0xfa>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-reboot-ab-update =3D <0x52>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-recovery =3D <0xff>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-rescue =3D <0xf9>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-shutdown-thermal =3D <0x51>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-shutdown-thermal-battery =3D <0x51>;

Just for completeness, on gs101 we also pass kernel-generated
modes from kernel_restart() or panic(), specifically DM verity's
'dm-verity device corrupted':

        mode-dm-verity-device-corrupted =3D <0x50>;


Cheers,
Andre'

>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-normal =3D <0x77665501>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-bootloader =3D <0x77665500>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-recovery =3D <0x77665502>;
>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/hisilicon/hi6220-hikey.dts:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-normal =3D <0x77665501>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-bootloader =3D <0x77665500>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-recovery =3D <0x77665502>;
>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/rockchip/px30.dtsi:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-bootloader =3D <BOOT_BL_DOWNLOAD>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-fastboot =3D <BOOT_FASTBOOT>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-loader =3D <BOOT_BL_DOWNLOAD>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-normal =3D <BOOT_NORMAL>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-recovery =3D <BOOT_RECOVERY>;
>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/rockchip/rk3308.dtsi:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-bootloader =3D <BOOT_BL_DOWNLOAD>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-loader =3D <BOOT_BL_DOWNLOAD>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-normal =3D <BOOT_NORMAL>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-recovery =3D <BOOT_RECOVERY>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-fastboot =3D <BOOT_FASTBOOT>;
>=20
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-normal =3D <BOOT_NORMAL>;
> =C2=A0=C2=A0=C2=A0=C2=A0	mode-loader =3D <BOOT_BL_DOWNLOAD>;
> 			mode-recovery =3D <BOOT_RECOVERY>;
> 			mode-bootloader =3D <BOOT_FASTBOOT>;
>=20
> Detailed list of commands being used by nvmem-reboot-mode:
> =C2=A0=C2=A0=C2=A0 arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
> 			mode-recovery =3D <0x01>;
> 			mode-bootloader =3D <0x02>;
>=20
> Previous discussions around SYSTEM_RESET2:
> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quic=
inc.com/T/
> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicin=
c.com/
>=20
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>=20
> Changes in v13:
> - Split patch1 into two (Synchronize list traversal and DT node-based
> =C2=A0 registration) - by Dmitry.
> - Move mutex lock inside get_reboot_mode_magic - by Dmitry.
> - Reorder the patches =E2=80=93 pull patch8 for exposing reboot-mode sysf=
s before
> =C2=A0 psci patch - to align the change in reboot-mode sysfs patch.=20
> - Update patch- reboot-mode: Expose sysfs for registered reboot_modes
> =C2=A0=C2=A0=C2=A0=C2=A0 - Introduce a driver_name in reboot_mode_registe=
r. This will be used
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in sysfs creation=C2=A0 -=C2=A0 by A=
rnd.
> =C2=A0=C2=A0=C2=A0=C2=A0 - Update documentation and commit text for above=
.
> =C2=A0=C2=A0=C2=A0=C2=A0 - Fix release function to properly call delete a=
ttr file.
> =C2=A0=C2=A0=C2=A0=C2=A0 - Fix sparse warning for devres_find.
> =C2=A0=C2=A0=C2=A0=C2=A0 - Add error handling for devres_find.
> - Split ABI documentation as a separate patch and update ABI documentatio=
n
> =C2=A0 for usage of driver-name in sysfs - by Arnd
> - Update patch - psci: Implement vendor-specific resets as reboot-mode
> =C2=A0=C2=A0=C2=A0=C2=A0 - Fix Kconfig for CONFIG related warning.
> =C2=A0=C2=A0=C2=A0=C2=A0 - Add driver_name as "psci" in register call to =
reboot-mode - by Arnd
> - Link to v12: https://lore.kernel.org/r/20250721-arm-psci-system_reset2-=
vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com
>=20
> Changes in v12:
> - Added lock for list traversals in reboot-mode - by Dmitry.
> - Added proper handling for BE and LE cases in reboot-mode - by Dmitry.
> - Removed type casting for u64 to u32 conversions. Added limit checks
> =C2=A0 and used bitwise operations for same - by Andrew.
> - Link to v11: https://lore.kernel.org/r/20250717-arm-psci-system_reset2-=
vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com
>=20
> Changes in v11:
> - Remove reference of cookie in reboot-mode =E2=80=93 Arnd/Rob
> - Introduce 64-bit magic in reboot-mode to accommodate two 32-bit
> =C2=A0 arguments =E2=80=93 Arnd
> - Change reset-type to reboot-mode in psci device tree binding =E2=80=93 =
Arnd
> 	- binding no more mandates two arguments as in v10.
> 	- dt changes done to support this binding.
> - Remove obvious comments in psci reset path =E2=80=93 Konrad
> - Merge sysfs and ABI doc into single patch.
> - Fix compilation issue on X86 configs.
> - Fix warnings for pr_fmt.
> - Link to v10: https://lore.kernel.org/all/569f154d-c714-1714-b898-83a42a=
38771c@oss.qualcomm.com/
>=20
> Changes in V10:
> - Change in reset-type binding to make cookie as a mandatory
> =C2=A0 argument.
> - Change reboot-mode binding to support additional argument
> =C2=A0 "cookie".
> =C2=A0From Lorenzo:
> - Use reboot-mode framework for implementing vendor-resets.
> - Modify reboot-mode framework to support two arguments
> =C2=A0 (magic and cookie).
> - Expose sysfs for supported reboot-modes commands.
> - List out all existing reboot-mode commands and their users.
> =C2=A0=C2=A0 - Added this to cover letter.
> =C2=A0From Dmitry:
> - Modify reboot-mode to support non-device based registration.
> - Modify reboot-mode to create a class and device to expose
> =C2=A0 sysfs interface.
> - Link to v9: https://lore.kernel.org/all/20250303-arm-psci-system_reset2=
-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com/
>=20
> Changes in v9:
> - Don't fallback to architecturally defined resets from Lorenzo.
> - Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-v=
endor-reboots-v8-0-e8715fa65cb5@quicinc.com
>=20
> Changes in v8:
> - Code style nits from Stephen
> - Add rb3gen2
> - Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-v=
endor-reboots-v7-0-a4c40b0ebc54@quicinc.com
>=20
> Changes in v7:
> - Code style nits from Stephen
> - Dropped unnecessary hunk from the sa8775p-ride patch
> - Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-v=
endor-reboots-v6-0-50cbe88b0a24@quicinc.com
>=20
> Changes in v6:
> - Rebase to v6.11 and fix trivial conflicts in qcm6490-idp
> - Add sa8775p-ride support (same as qcm6490-idp)
> - Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-v=
endor-reboots-v5-0-086950f650c8@quicinc.com
>=20
> Changes in v5:
> - Drop the nested "items" in prep for future dtschema tools
> - Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-v=
endor-reboots-v4-0-98f55aa74ae8@quicinc.com
>=20
> Changes in v4:
> - Change mode- properties from uint32-matrix to uint32-array
> - Restructure the reset-types node so only the restriction is in the
> =C2=A0 if/then schemas and not the entire definition
> - Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-v=
endor-reboots-v3-0-16dd4f9c0ab4@quicinc.com
>=20
> Changes in v3:
> - Limit outer number of items to 1 for mode-* properties
> - Move the reboot-mode for psci under a subnode "reset-types"
> - Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
> =C2=A0 sc7820.dtsi
> - Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-v=
endor-reboots-v2-0-da9a055a648f@quicinc.com
>=20
> Changes in v2:
> - Fixes to schema as suggested by Rob and Krzysztof
> - Add qcm6490 idp as first Qualcomm device to support
> - Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-v=
endor-reboots-v1-0-03c4612153e2@quicinc.com
>=20
> Changes in v1:
> - Reference reboot-mode bindings as suggeted by Rob.
> - Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-=
vendor-reboots-v1-0-dcdd63352ad1@quicinc.com
>=20
> ---
> Elliot Berman (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: arm: Document reboot mode mag=
ic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: qcm6490-idp: Add PSCI SY=
STEM_RESET2 types
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: qcs6490-rb3gen2: Add PSC=
I SYSTEM_RESET2 types
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: sa8775p-ride: Add PSCI S=
YSTEM_RESET2 types
>=20
> Shivendra Pratap (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power: reset: reboot-mode: Synchronize lis=
t traversal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power: reset: reboot-mode: Add device tree=
 node-based registration
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power: reset: reboot-mode: Add support for=
 64 bit magic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation: ABI: Add sysfs-class-reboot=
-mode-reboot_modes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power: reset: reboot-mode: Expose sysfs fo=
r registered reboot_modes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware: psci: Implement vendor-specific =
resets as reboot-mode
>=20
> =C2=A0.../testing/sysfs-class-reboot-mode-reboot_modes=C2=A0=C2=A0 |=C2=
=A0 39 +++++
> =C2=A0Documentation/devicetree/bindings/arm/psci.yaml=C2=A0=C2=A0=C2=A0 |=
=C2=A0 43 +++++
> =C2=A0arch/arm64/boot/dts/qcom/qcm6490-idp.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0arch/arm64/boot/dts/qcom/sa8775p.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0arch/arm64/boot/dts/qcom/sc7280.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/firmware/psci/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/firmware/psci/psci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 57 ++++++-
> =C2=A0drivers/power/reset/nvmem-reboot-mode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> =C2=A0drivers/power/reset/qcom-pon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0drivers/power/reset/reboot-mode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 174=
 +++++++++++++++++----
> =C2=A0drivers/power/reset/syscon-reboot-mode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0include/linux/reboot-mode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A014 files changed, 342 insertions(+), 44 deletions(-)
> ---
> base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
> change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
>=20
> Best regards,

