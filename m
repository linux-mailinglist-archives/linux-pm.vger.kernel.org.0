Return-Path: <linux-pm+bounces-31587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891AB15AD9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681CC7A44D9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810A266B64;
	Wed, 30 Jul 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbBc57Fo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AC262FC5
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865094; cv=none; b=gdUEaibJH+Z+QCQurKVQ+4kLV0+60Zrc1CsMBtw/XM7/vGnmZck8H792HcOy3G6KtTvUWlongHDyXR7+YaFk/jo3cpGSSV2Il6RPsAu5IhU273cVz430aJwzNfMGuVUaV5b+31W881eQx/whytpExdD5UC/3v6ACf1+NiGg8nP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865094; c=relaxed/simple;
	bh=KS6CpywbDKcHmTP1nnteF89ocRiwmP3ar/5/P7NA3rA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNPDEm00rnQXxtVrZyYMimB0VBQ+VLlgwEP4wyQt6DrdIeLazOq+9nBvfNtXSzdA4BmX8EclrvaUwvzz6o+FYjndCRHFOVqYeYQrSgnGhQh+727SznvPFWjdWNUpdSmiOAJYKoHz84H3wP9yll+J/zimGm3nB0+pu7IiZ4N8J28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbBc57Fo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so3431715e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753865090; x=1754469890; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pNJc0MhKyem6DJ9KMPfzr1zes3FYUQgDKGyo+jiBCKA=;
        b=fbBc57FoBs/F82t6bpHXOBDQvzT6XvgDDf5b9KAX++WmEGuopMzuQ3MACuQpoY3aJL
         Kan0LLLVt+muBW1x3JXDcTNs3A0MscdfsINnkamkdI/aPe5pcIZ2iGgptQc2aEr/nFka
         2OdWVDVYQdOjTePTBQ+olJ7LpkO8NczOrNmU88ftlwLYuqMH5Yz24bnSpgWUYN7ovrGI
         Kzdf93lUxQVgVHKJSJOmOYBS6pHzPAZTTg09v+A4dw5LesjxyqLCyPjjq2ETHQOXFGPb
         v+uvboEY0V4hx2S2lzB3NrF5MqxaqMT5d4kx0RjrtNnRruzR6zewBDb906aAtOPm6r41
         1vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753865090; x=1754469890;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNJc0MhKyem6DJ9KMPfzr1zes3FYUQgDKGyo+jiBCKA=;
        b=HHYR48iXbZFf5VvF7J/S0XTsPFjI/yyAV0L7ewPnashLLZ+I5oWtu19T5fbf4/WX3r
         BGV3PflpzhQrJO0XaBm9SZmZJXeivfmgt2PV6wkWPjBrhQCsojQVJjhOornwLDPg08oQ
         LxO86Ja++rorymMBpEiRQ4vSlkdPt8P7W2Hor+KDxwea1LCkqL7u/U+710yuKpBMgKj+
         p4K48EnECW59DHxpEM3iXFP/86pdgqpcrA2l8qufjQYx4+No0UyDdZFHnBxxtzSiG42Z
         lwtAChDJXHljzS2LYrUWCEWKQk+oj9hHrk+5t3070AnR0o6Xhmyxu/qW73SClINvRbol
         LnoA==
X-Forwarded-Encrypted: i=1; AJvYcCWhoQM0aKFTXxQHeCKYcu3cVKg5jLHgzdiOKzqECIKTgycqf4GYsCXKpDzSLlAgUBwIZFgwlI7Pug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHH2FkeArKu7zw5NL4ii+PWdF7Afi4XQiOv2MRPU5EdfHihaXr
	Y90In0gOpAPVLt4a+2CBptCjbFUxvaIpHwDHRZzrNSTaU+PtkrO4VavgQHIzYqCbjbo=
X-Gm-Gg: ASbGncuX/s9awyGQcR+btzrJM3gRnsw97uga4Gc0DsycEL7s3BuU9avIROPQT8XlI1o
	741J295mpvFeU/ewZYu0zC80DEdC/RaSQxMOJ3tdQDXxAZdS1cn0hmkd61SiUgXJh/BzwNca5fX
	Nm1yKrP581TOrUTR9H6BWtuma9t4/uGCGjG1UGPrK5nwE3NlTehvAkK+T2FqHvGlLJNqgx89TBP
	HgEovtB4LG6S8yb/pmmtBzeO1/YALwrgyRPgnNISgntiDNpHXOdyNjw7K6U9tzW7JMh7KBzqJqz
	nmfUNB3OuPN7b9AmRWBhMW7haRKjsoLpg5g8Sq7i5rMBVdYiLKJzxbJLyv0YA/vQ88efPbe+oGh
	UlaOnk6P41DgcnbsLno2pVevFTA==
X-Google-Smtp-Source: AGHT+IFifdJ3RFvCYy7icV5bmFoBw6S3AjQmM0nH3OcGn2ldcETMHgAeTiCZi2wsWZ7N/6oYzxdvqw==
X-Received: by 2002:a05:600c:78f:b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-4588d17968dmr38218165e9.14.1753865090327;
        Wed, 30 Jul 2025 01:44:50 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b785258135sm11141357f8f.42.2025.07.30.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:44:49 -0700 (PDT)
Message-ID: <b45b157593f1865a402f4098cdeafc298a294c6d.camel@linaro.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
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
	 <srini@kernel.org>
Date: Wed, 30 Jul 2025 09:44:48 +0100
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
References: 
	<20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
	 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
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
> SoC vendors have different types of resets which are controlled
> through various hardware registers. For instance, Qualcomm SoC
> may have a requirement that reboot with =E2=80=9Cbootloader=E2=80=9D comm=
and
> should reboot the device to bootloader flashing mode and reboot
> with =E2=80=9Cedl=E2=80=9D should reboot the device into Emergency flashi=
ng mode.
> Setting up such reboots on Qualcomm devices can be inconsistent
> across SoC platforms and may require setting different HW
> registers, where some of these registers may not be accessible to
> HLOS. These knobs evolve over product generations and require
> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
> reset which can help align this requirement. Add support for PSCI
> SYSTEM_RESET2, vendor-specific resets and align the implementation
> to allow user-space initiated reboots to trigger these resets.
>=20
> Introduce a late_initcall to register PSCI vendor-specific resets
> as reboot modes. Implement a reboot-mode write function that sets
> reset_type and cookie values during the reboot notifier callback.
> Introduce a firmware-based call for SYSTEM_RESET2 vendor-specific
> reset in the psci_sys_reset path, using reset_type and cookie if
> supported by secure firmware.
>=20
> By using the above implementation, userspace will be able to issue
> such resets using the reboot() system call with the "*arg"
> parameter as a string based command. The commands can be defined
> in PSCI device tree node as =E2=80=9Creset-types=E2=80=9D and are based o=
n the
> reboot-mode based commands.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
> =C2=A0drivers/firmware/psci/Kconfig |=C2=A0 2 ++
> =C2=A0drivers/firmware/psci/psci.c=C2=A0 | 57 +++++++++++++++++++++++++++=
+++++++++++++++-
> =C2=A02 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfi=
g
> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733=
e6bc5654d56a17f 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -1,6 +1,8 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0config ARM_PSCI_FW
> =C2=A0	bool
> +	select POWER_RESET
> +	select REBOOT_MODE
> =C2=A0
> =C2=A0config ARM_PSCI_CHECKER
> =C2=A0	bool "ARM PSCI checker"
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..e14bcdbec1750db8aa9297c8b=
cdb242f58cc420e 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/printk.h>
> =C2=A0#include <linux/psci.h>
> =C2=A0#include <linux/reboot.h>
> +#include <linux/reboot-mode.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/suspend.h>
> =C2=A0
> @@ -51,6 +52,14 @@ static int resident_cpu =3D -1;
> =C2=A0struct psci_operations psci_ops;
> =C2=A0static enum arm_smccc_conduit psci_conduit =3D SMCCC_CONDUIT_NONE;
> =C2=A0
> +struct psci_vendor_sysreset2 {
> +	u32 reset_type;
> +	u32 cookie;
> +	bool valid;
> +};
> +
> +static struct psci_vendor_sysreset2 vendor_reset;
> +
> =C2=A0bool psci_tos_resident_on(int cpu)
> =C2=A0{
> =C2=A0	return cpu =3D=3D resident_cpu;
> @@ -309,7 +318,10 @@ static int get_set_conduit_method(const struct devic=
e_node *np)
> =C2=A0static int psci_sys_reset(struct notifier_block *nb, unsigned long =
action,
> =C2=A0			=C2=A0 void *data)
> =C2=A0{
> -	if ((reboot_mode =3D=3D REBOOT_WARM || reboot_mode =3D=3D REBOOT_SOFT) =
&&
> +	if (vendor_reset.valid && psci_system_reset2_supported) {
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_=
type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vendor_reset.cookie, 0);
> +	} else if ((reboot_mode =3D=3D REBOOT_WARM || reboot_mode =3D=3D REBOOT=
_SOFT) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 psci_system_reset2_supported) {
> =C2=A0		/*
> =C2=A0		 * reset_type[31] =3D 0 (architectural)

I don't know the PSCI spec, but it looks like with this code it's not
possible to set=C2=A0a reboot mode (in DT) and at the same time instruct
the firmware whether a warm or a cold reboot was requested.

Doing warm reboot is useful if e.g. RAM contents needs to be retained
for crash recovery handling, or other reasons, while in normal cases
doing a more secure cold reboot.

On the other hand, of course it's useful to be able to specify the
reboot target for normal reboots.

Is this a problem with the PSCI spec or with this specific change
geared at the Qcom implementation?


> @@ -547,6 +559,49 @@ static const struct platform_suspend_ops psci_suspen=
d_ops =3D {
> =C2=A0	.enter=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D p=
sci_system_suspend_enter,
> =C2=A0};
> =C2=A0
> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot,=
 u64 magic)
> +{
> +	u32 magic_32;
> +
> +	if (psci_system_reset2_supported) {
> +		magic_32 =3D magic & 0xFFFFFFFF;

I believe usual kernel style is to use lower case for
hex values.

> +		vendor_reset.reset_type =3D PSCI_1_1_RESET_TYPE_VENDOR_START | magic_3=
2;
> +		vendor_reset.cookie =3D (magic >> 32) & 0xFFFFFFFF;

dito.

Cheers,
Andre'

> +		vendor_reset.valid =3D true;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init psci_init_vendor_reset(void)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device_node *np;
> +	int ret;
> +
> +	np =3D of_find_node_by_path("/psci/reboot-mode");
> +	if (!np)
> +		return -ENODEV;
> +
> +	reboot =3D kzalloc(sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot) {
> +		of_node_put(np);
> +		return -ENOMEM;
> +	}
> +
> +	reboot->write =3D psci_set_vendor_sys_reset2;
> +
> +	ret =3D reboot_mode_register(reboot, np, "psci");
> +	if (ret) {
> +		of_node_put(np);
> +		kfree(reboot);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +late_initcall(psci_init_vendor_reset)
> +
> =C2=A0static void __init psci_init_system_reset2(void)
> =C2=A0{
> =C2=A0	int ret;

