Return-Path: <linux-pm+bounces-31591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA72B15B38
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03459542F82
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3AD26A0A7;
	Wed, 30 Jul 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehAtk7ZL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06351269B0D
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866402; cv=none; b=GdYgfPggoUqr6ZDAm249SALi012ML20y+TkuJ8uZWYVCWUpVGYMW3dMU1g/AfDbn0nx5GcHRJP97Hg6DHCQjeQpmDzzpLXZr5mXFBwXBMty6dZIa7qzZK+UbtNRSDCgCMLKgtVX2VXD0jT7iU2ufChvsEqxi7JUop57EvnfFae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866402; c=relaxed/simple;
	bh=Q5x39miEvnyELWRml8u2bUeF3gEXQOyITf6/yX7xoCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTQaE+L3xmTwCEukTCf5pTG9bTuy20BCuSfNMtYxSjwvPcRFz8PfhSFwLmL7kVfHo/b578j00eVG/jdS8cXfegnxbSNM5pZ43yqLuHxrgICaaWGbuSHdhR6OeCD+zoNfmTAAbhglJoUTVURGBfxrrmB3PT4dCyLsnTpoeFWLXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehAtk7ZL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso63608425e9.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753866399; x=1754471199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=amCpS6Biku5UkvGCeY8Q3zKrvNs8l+NdNFt807Gj1q8=;
        b=ehAtk7ZLD4jF6mj+YB+znklz88s3nHDIS0ISkj0du9ONL1zw0Win+48TeYLdYJolLR
         x4AOO1Rk5oWPJckkEqltXIZSuvixZMWGZPCi37ixk8+/vycCU4ZRx4E+WfSLMQ39jcTk
         heP0t1sLrWy7v6Lg3+8ybRk8IMBHpHTM86ICWUgMtd8d56LTgAvuNAl7hZORZ/kN3RMe
         jcnvSCWtwM18PsV8gSB9tOVz/H5paOVfXxcXfQkoB/KZv6sAp2S7Ub3FfYbE2frD/zix
         dOKkSYbyrzsfY6riZt0N+7p2inKLOPr22zWCb01IGTxO0XcWOIo1qVL0T6N0U3ecgWwS
         ghRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753866399; x=1754471199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amCpS6Biku5UkvGCeY8Q3zKrvNs8l+NdNFt807Gj1q8=;
        b=lwc2R896+BQtJaMPYWz+sZiZM8OoyZRiYkCBtLcuxvAaJ5656JO/62PoBmlfOI4a71
         he5ue//WbHlORIWXws8BOY7qK44IMDNR9W+yQlFybxSagDWTC0QK+nRmFGXf20HqmANf
         DxY86X1FKMefknxcx1LjvR1N+Mr4tt8nHPRrUz17wC0luWOunbrNYrAz4eWCSS8dlvlE
         P1uB4WPKyRJCnWqNwEM4fKLB7rRYVQhSKl/HJaTnq4npYGZc+H19wi0zohi/FltmaU5V
         6s6FsgkAD9R19LIlqRIjs93El5La2VwbCv12btU3jw8Ls3M7b09Heb61YqupQcecoP71
         RCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcrxfARRWRvqyC9wfk/7zFo1JNkoycoSWVogqJW7mWu+aAHBlV34g/vGmcFoZEkoaUIjBC6XatkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwy9MRyZpcgolJUO0tyO1Q+8F8C5q0+7+yXreaDUq1WD8xaMJi
	BEO9vEJ7G5NyKbzmb6wn/92HOSULkXoNtSDl0f7lW21E+03+dFZUypjGzCjAmHQmsm4=
X-Gm-Gg: ASbGncvqKwH2GiJUxHySyVCL36f6EKLXAUgEFbKYnZNL2ZC75YdW96rgAaJCqf9OMBN
	Y5MYJOukPaXGHwfso6+WPngTZlHy9u9yW4mRmDK25iXd0eeeF2kDdoViW+fZolEq+cViozuMYVn
	RV4+7mWqnz/1y2TGc+sqoYydlfEuPAlWoMFYgccoKCiksQCIjcLPrWToEnNs1NXCegxZsDSf1Hg
	87Q9EMUPtxYvD+EjcspMvRIGjvi1vNGv/T64YosjuUJk/YsQF13XJvz0q2tQWKzv9oOeuq5ihFf
	ApbNMBW57z5gzXOSDXXOOH9ZpQL5KMchVoyQRtNZgIXk5Ooh6EbutAhnxgPaPsdQ6FrbJpUs2yf
	qHAKZOlL29UIUOMGv4wfbKtDjnA==
X-Google-Smtp-Source: AGHT+IGu9BTjzxVnqGeLDV3BoeEs9yZzpZzfEcV+C4Pb53LxtnI2Wds8ED4FoqgjBE3qk36pQJS9SA==
X-Received: by 2002:a05:600c:6995:b0:456:2cd9:fc41 with SMTP id 5b1f17b1804b1-45892bc44a5mr21276705e9.20.1753866399264;
        Wed, 30 Jul 2025 02:06:39 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7973a9422sm814667f8f.21.2025.07.30.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:06:38 -0700 (PDT)
Message-ID: <b1b34e31904f711e7cf82394843a9966238f2896.camel@linaro.org>
Subject: Re: [PATCH v13 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
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
Date: Wed, 30 Jul 2025 10:06:37 +0100
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-4-6b8d23315898@oss.qualcomm.com>
References: 
	<20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
	 <20250727-arm-psci-system_reset2-vendor-reboots-v13-4-6b8d23315898@oss.qualcomm.com>
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
> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
> a read-only sysfs attribute exposing the list of supported
> reboot-mode arguments. This file is created by reboot-mode
> framework and provides a user-readable interface to query
> available reboot-mode arguments.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
> =C2=A0.../testing/sysfs-class-reboot-mode-reboot_modes=C2=A0=C2=A0 | 39 +=
+++++++++++++++++++++
> =C2=A01 file changed, 39 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_mod=
es b/Documentation/ABI/testing/sysfs-class-reboot-mode-
> reboot_modes
> new file mode 100644
> index 0000000000000000000000000000000000000000..7147a781e5d4d11977c3a156b=
f4308aa13310e39
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> @@ -0,0 +1,39 @@
> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
> +Date:		July 2025
> +KernelVersion:	6.16

The version should probably be updated.

> +Contact:	linux-pm@vger.kernel.org
> +		Description:
> +		This interface exposes the reboot-mode arguments
> +		registered with the reboot-mode framework. It is
> +		a read-only interface and provides a comma
> +		separated list of reboot-mode arguments supported
> +		on the current platform.
> +		Example:
> +		 recovery,fastboot,bootloader

I'd personally find space separated like e.g. in files below /sys/power
and many other similar files below /sys easier to read.

Cheers,
Andre'


> +
> +		The exact sysfs path may vary depending on the
> +		name of the driver that registers the arguments.
> +		Example:
> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
> +
> +		The supported arguments can be used by userspace
> +		to invoke device reset using the reboot() system
> +		call, with the "argument" as string to "*arg"
> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
> +		Example:
> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LINUX_REBOOT_CMD_RESTART2, =
"bootloader");
> +
> +		A driver can expose the supported arguments by
> +		registering them with the reboot-mode framework
> +		using the property names that follow the
> +		mode-<argument> format.
> +		Example:
> +		 mode-bootloader, mode-recovery.
> +
> +		This attribute is useful for scripts or initramfs
> +		logic that need to programmatically determine
> +		which reboot-mode arguments are valid before
> +		triggering a reboot.

