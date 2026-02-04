Return-Path: <linux-pm+bounces-42090-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN8JEi1ug2kFmwMAu9opvQ
	(envelope-from <linux-pm+bounces-42090-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:05:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FEE9D5A
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 046F830A547C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA98423173;
	Wed,  4 Feb 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxzEONpf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB35423163
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218592; cv=none; b=tf9k+uD0lU+/s7yZTxfit00l9bONgXEr13709haSAH98aJyhEQOcnHggkO1UUs7pUQbRTa15GF/k9qgBb+VvO/QHULufdI51kbZ8Gt5fGarOCah0VqqkiVorldzP8+k9kleh8ebkHSMURkljqGPBmenvvSGUZjL3vsOYAcbAmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218592; c=relaxed/simple;
	bh=vsYZmcckO1XNxa2VaS1P/tT5QfvsMDqiUNvTivmqcGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEvUFuyCKZE1vb+tVJFT61cewyFGzt4kErr8FrCDOPHMp8qfGJbtzR1FSw/2HKCBuj9PMzwiBeyzCxEcnAw9Z7sYZU5T0Ieqyq7+0Z0L7VdaORBL5JbYRve71hZuVoapf22ib79Ynj8rgK2+4r05BriCKjAzVE7wiE7zBgQ6ubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxzEONpf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359a302794so4850717f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770218590; x=1770823390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1qnKwov5rrZ01ui9I8cNzqi3dNNcpLkVKDUPSdHgq0=;
        b=dxzEONpfQIDX66/QL9Y1kpSk/oaWmE711Ei/9+jFac0xG1JdecudX3ECBB5ZoOX0fB
         JfWU2iznyLDO7IC6j34gEcmFko+gHzM+Tb+KvUmk/VBxEK68B86rSUi97rsbYGXqLBoF
         S0Fz68J3yTv8rJiK3E7k67Lzja9+NY7LeCq1C59iHa2XdCIxV42FdiPjqJh+wlIrfDpO
         0pN0G6wBHMWU1dtGIoXI06GTkInFzphK3+Fn3AeTM7etVozF8dOdymWZPVAP7kDAh6ea
         hhS6oCV1gcBUCgvRB8qVfjrIDEsW0iTBx/KyWAGUjzGVPwd/FoxEKk8oxZ76zZknwKCQ
         1WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218590; x=1770823390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1qnKwov5rrZ01ui9I8cNzqi3dNNcpLkVKDUPSdHgq0=;
        b=OZ5c/enVGX9D5/BHHpCnvW/H/jAIifcmvBIMeqbeogDM80TLg8/MIkWbiYvsUDUwRg
         M5ArekIdH0eHFlrI516WKFAmgi5EiIsRWumRfgseUs+zye00a2jTSS2M4bbDO2NKXVLX
         Z1yr6wGGHiIis0es2Em3RnzIG5WuzMjm1lOV19jsO6qDtj0/eQk9PRlAxPjvbKYsj2Ut
         Irlquu5d3P+8xBYeZONNIuZ2zWm0h13czT1wTg5fsRXhGIR+ff8VNfcfFUig94g8LhhD
         QLV9R7Xnw0coS9377VmQUm+I36ButyfWBKHjEDPu3zl4taY4ca6Co2KKGGILKEdS5Wa2
         e8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWfhR9Px1CKFkOc6oOCbW4bKzwORO3C40jtdK4xv/WvIjUDpLUIau/+2mjIAqB1VO/R9iFtI28GSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQX21BF9pXz4L2OrNFdhD7LeU3pQo2K3VaPy5tPtAi6j51c7TV
	gTojsLHrgYBcWpNhZmBOO+Mh0b1TjlaGfIopplBKmIi2PWDDGmDuQa3tnMTjLWlsJZE=
X-Gm-Gg: AZuq6aIS9HkHJ2nZ07C35eYRbAZDYx+nRMoufZGVTri91+gZVJoQrZy3Bz47RTmcREI
	8R++wXQMx4sGql4N7gd10TFCiQGt8VUW+ehQ7Fz89BTQ2e2XhKyUV89q97mI6TIw4nDzH+qEwoV
	9SZ+2J443RJg2R6+1FsO0j+XyFgPBqWEVu6cODItOAkhNvQBMbD3frVNQkfpUlnZCcoCecQcPIK
	UyOu8fOK3qp6RPSfBBeKttoG0tewOPlWpXgnS2YSNM9N94c0vNmls/FyuhqFGWRTg4/PVsUeFi7
	OWoA7jomuZPmwk0ZFxsxaEQaxepDWd1NkLTOBwpRN5FFdw18eaFlVBTnlPhUBbzGL/g7RQaQhAs
	Ia9vWxMoxfWHTGTbSychSO4dm2FKrZqx9RfrFLlAgxAQxqBlmFsrGNchgH4efmsDZGu79lFuRSj
	7IlFDJo/NoTSsWbAykLA==
X-Received: by 2002:a05:6000:420a:b0:430:f255:14b2 with SMTP id ffacd0b85a97d-43617e351bfmr4799085f8f.13.1770218589768;
        Wed, 04 Feb 2026 07:23:09 -0800 (PST)
Received: from draszik.lan ([212.129.76.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f8c1sm5951629f8f.37.2026.02.04.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:23:09 -0800 (PST)
Message-ID: <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Lee Jones
 <lee@kernel.org>,  Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo
 Choi	 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Wed, 04 Feb 2026 15:23:25 +0000
In-Reply-To: <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
	 <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42090-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 3C8FEE9D5A
X-Rspamd-Action: no action

Hi,

On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
> Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
> USB Interface Controller), and flash and RGB LED controllers.
>=20
> S2MU005's interrupt registers can be properly divided into three regmap
> IRQ chips, one each for the charger, flash LEDs, and the MUIC.
>=20
> Add initial support for S2MU005 in the PMIC driver, along with it's three
> interrupt chips.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> =C2=A0drivers/mfd/sec-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++
> =C2=A0drivers/mfd/sec-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> =C2=A0drivers/mfd/sec-irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++++++++
> =C2=A0include/linux/mfd/samsung/core.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 =
+
> =C2=A0include/linux/mfd/samsung/irq.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66 =
++++++++
> =C2=A0include/linux/mfd/samsung/s2mu005.h | 328 +++++++++++++++++++++++++=
+++++++++++
> =C2=A06 files changed, 497 insertions(+)
>=20
> diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
> index 0021f9ae8484f..bc2a1f2c6dc7a 100644
> --- a/drivers/mfd/sec-common.c
> +++ b/drivers/mfd/sec-common.c
> @@ -99,6 +99,18 @@ static const struct mfd_cell s2mpu05_devs[] =3D {
> =C2=A0	MFD_CELL_RES("s2mps15-rtc", s2mpu05_rtc_resources),
> =C2=A0};
> =C2=A0
> +static const struct resource s2mu005_muic_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(S2MU005_IRQ_MUIC_ATTACH, "attach"),
> +	DEFINE_RES_IRQ_NAMED(S2MU005_IRQ_MUIC_DETACH, "detach"),
> +};
> +
> +static const struct mfd_cell s2mu005_devs[] =3D {
> +	MFD_CELL_OF("s2mu005-charger", NULL, NULL, 0, 0, "samsung,s2mu005-charg=
er"),
> +	MFD_CELL_OF("s2mu005-flash", NULL, NULL, 0, 0, "samsung,s2mu005-flash")=
,
> +	MFD_CELL_OF("s2mu005-muic", s2mu005_muic_resources, NULL, 0, 0, "samsun=
g,s2mu005-muic"),
> +	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"),
> +};
> +
> =C2=A0static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
> =C2=A0{
> =C2=A0	unsigned int val;
> @@ -235,6 +247,10 @@ int sec_pmic_probe(struct device *dev, int device_ty=
pe, unsigned int irq,
> =C2=A0		sec_devs =3D s2mpu05_devs;
> =C2=A0		num_sec_devs =3D ARRAY_SIZE(s2mpu05_devs);
> =C2=A0		break;
> +	case S2MU005:
> +		sec_devs =3D s2mu005_devs;
> +		num_sec_devs =3D ARRAY_SIZE(s2mu005_devs);
> +		break;
> =C2=A0	default:
> =C2=A0		return dev_err_probe(sec_pmic->dev, -EINVAL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Unsupported device type %d\n",
> diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
> index 3132b849b4bc4..3f1d70cc3292b 100644
> --- a/drivers/mfd/sec-i2c.c
> +++ b/drivers/mfd/sec-i2c.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/mfd/samsung/s2mps14.h>
> =C2=A0#include <linux/mfd/samsung/s2mps15.h>
> =C2=A0#include <linux/mfd/samsung/s2mpu02.h>
> +#include <linux/mfd/samsung/s2mu005.h>
> =C2=A0#include <linux/mfd/samsung/s5m8767.h>
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/module.h>
> @@ -130,6 +131,11 @@ static const struct regmap_config s2mpu05_regmap_con=
fig =3D {
> =C2=A0	.val_bits =3D 8,
> =C2=A0};
> =C2=A0
> +static const struct regmap_config s2mu005_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};

No cache? And what is the .max_register value?

> +
> =C2=A0static const struct regmap_config s5m8767_regmap_config =3D {
> =C2=A0	.reg_bits =3D 8,
> =C2=A0	.val_bits =3D 8,
> @@ -203,6 +209,11 @@ static const struct sec_pmic_i2c_platform_data s2mpu=
05_data =3D {
> =C2=A0	.device_type =3D S2MPU05,
> =C2=A0};
> =C2=A0
> +static const struct sec_pmic_i2c_platform_data s2mu005_data =3D {
> +	.regmap_cfg =3D &s2mu005_regmap_config,
> +	.device_type =3D S2MU005,
> +};
> +
> =C2=A0static const struct sec_pmic_i2c_platform_data s5m8767_data =3D {
> =C2=A0	.regmap_cfg =3D &s5m8767_regmap_config,
> =C2=A0	.device_type =3D S5M8767X,
> @@ -217,6 +228,7 @@ static const struct of_device_id sec_pmic_i2c_of_matc=
h[] =3D {
> =C2=A0	{ .compatible =3D "samsung,s2mps15-pmic", .data =3D &s2mps15_data,=
 },
> =C2=A0	{ .compatible =3D "samsung,s2mpu02-pmic", .data =3D &s2mpu02_data,=
 },
> =C2=A0	{ .compatible =3D "samsung,s2mpu05-pmic", .data =3D &s2mpu05_data,=
 },
> +	{ .compatible =3D "samsung,s2mu005-pmic", .data =3D &s2mu005_data, },
> =C2=A0	{ .compatible =3D "samsung,s5m8767-pmic", .data =3D &s5m8767_data,=
 },
> =C2=A0	{ },
> =C2=A0};
> diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
> index 4c0faf4c99893..44a1eb074a082 100644
> --- a/drivers/mfd/sec-irq.c
> +++ b/drivers/mfd/sec-irq.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/mfd/samsung/s2mps14.h>
> =C2=A0#include <linux/mfd/samsung/s2mpu02.h>
> =C2=A0#include <linux/mfd/samsung/s2mpu05.h>
> +#include <linux/mfd/samsung/s2mu005.h>
> =C2=A0#include <linux/mfd/samsung/s5m8767.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include "sec-core.h"
> @@ -164,6 +165,65 @@ static const struct regmap_irq s2mpu05_irqs[] =3D {
> =C2=A0	REGMAP_IRQ_REG(S2MPU05_IRQ_TSD, 2, S2MPU05_IRQ_TSD_MASK),
> =C2=A0};
> =C2=A0
> +static const struct regmap_irq s2mu005_irqs[] =3D {
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_DETBAT, 0, S2MU005_IRQ_CHGR_DETBAT_MASK=
),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_BAT, 0, S2MU005_IRQ_CHGR_BAT_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_IVR, 0, S2MU005_IRQ_CHGR_IVR_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_EVENT, 0, S2MU005_IRQ_CHGR_EVENT_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_CHG, 0, S2MU005_IRQ_CHGR_CHG_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_VMID, 0, S2MU005_IRQ_CHGR_VMID_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_WCIN, 0, S2MU005_IRQ_CHGR_WCIN_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_VBUS, 0, S2MU005_IRQ_CHGR_VBUS_MASK),
> +
> +	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_LBPROT, 1, S2MU005_IRQ_FLED_LBPROT_MASK=
),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_OPENCH2, 1, S2MU005_IRQ_FLED_OPENCH2_MA=
SK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_OPENCH1, 1, S2MU005_IRQ_FLED_OPENCH1_MA=
SK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_SHORTCH2, 1, S2MU005_IRQ_FLED_SHORTCH2_=
MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_SHORTCH1, 1, S2MU005_IRQ_FLED_SHORTCH1_=
MASK),
> +
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_ATTACH, 2, S2MU005_IRQ_MUIC_ATTACH_MASK=
),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_DETACH, 2, S2MU005_IRQ_MUIC_DETACH_MASK=
),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_KP, 2, S2MU005_IRQ_MUIC_KP_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_LKP, 2, S2MU005_IRQ_MUIC_LKP_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_LKR, 2, S2MU005_IRQ_MUIC_LKR_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_RIDCHG, 2, S2MU005_IRQ_MUIC_RIDCHG_MASK=
),
> +
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_VBUSON, 3, S2MU005_IRQ_MUIC_VBUSON_MASK=
),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_RSVD, 3, S2MU005_IRQ_MUIC_RSVD_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_ADC, 3, S2MU005_IRQ_MUIC_ADC_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_STUCK, 3, S2MU005_IRQ_MUIC_STUCK_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_STUCKRCV, 3, S2MU005_IRQ_MUIC_STUCKRCV_=
MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_MHDL, 3, S2MU005_IRQ_MUIC_MHDL_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_AVCHG, 3, S2MU005_IRQ_MUIC_AVCHG_MASK),
> +	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_VBUSOFF, 3, S2MU005_IRQ_MUIC_VBUSOFF_MA=
SK),
> +};
> +
> +static unsigned int s2mu005_irq_get_reg(struct regmap_irq_chip_data *dat=
a,
> +					unsigned int base, int index)
> +{
> +	const unsigned int irqf_regs[] =3D {
> +		S2MU005_REG_CHGR_INT1,
> +		S2MU005_REG_FLED_INT1,
> +		S2MU005_REG_MUIC_INT1,
> +		S2MU005_REG_MUIC_INT2,
> +	};
> +	const unsigned int mask_regs[] =3D {
> +		S2MU005_REG_CHGR_INT1M,
> +		S2MU005_REG_FLED_INT1M,
> +		S2MU005_REG_MUIC_INT1M,
> +		S2MU005_REG_MUIC_INT2M,
> +	};
> +
> +	switch (base) {
> +	case irqf_regs[0]:
> +		return irqf_regs[index];
> +	case mask_regs[0]:
> +		return mask_regs[index];
> +	}
> +
> +	return base;
> +}
> +
> =C2=A0static const struct regmap_irq s5m8767_irqs[] =3D {
> =C2=A0	REGMAP_IRQ_REG(S5M8767_IRQ_PWRR, 0, S5M8767_IRQ_PWRR_MASK),
> =C2=A0	REGMAP_IRQ_REG(S5M8767_IRQ_PWRF, 0, S5M8767_IRQ_PWRF_MASK),
> @@ -259,6 +319,17 @@ static const struct regmap_irq_chip s2mpu05_irq_chip=
 =3D {
> =C2=A0	.ack_base =3D S2MPU05_REG_INT1,
> =C2=A0};
> =C2=A0
> +static const struct regmap_irq_chip s2mu005_irq_chip =3D {
> +	.name =3D "s2mu005",
> +	.irqs =3D s2mu005_irqs,
> +	.num_irqs =3D ARRAY_SIZE(s2mu005_irqs),
> +	.num_regs =3D 4,
> +	.status_base =3D S2MU005_REG_CHGR_INT1,
> +	.mask_base =3D S2MU005_REG_CHGR_INT1M,
> +	.ack_base =3D S2MU005_REG_CHGR_INT1,
> +	.get_irq_reg =3D s2mu005_irq_get_reg,
> +};
> +
> =C2=A0static const struct regmap_irq_chip s5m8767_irq_chip =3D {
> =C2=A0	.name =3D "s5m8767",
> =C2=A0	.irqs =3D s5m8767_irqs,
> @@ -358,6 +429,9 @@ struct regmap_irq_chip_data *sec_irq_init(struct sec_=
pmic_dev *sec_pmic)
> =C2=A0	case S2MPU05:
> =C2=A0		sec_irq_chip =3D &s2mpu05_irq_chip;
> =C2=A0		break;
> +	case S2MU005:
> +		sec_irq_chip =3D &s2mu005_irq_chip;
> +		break;
> =C2=A0	default:
> =C2=A0		return dev_err_ptr_probe(sec_pmic->dev, -EINVAL, "Unsupported dev=
ice type %d\n",
> =C2=A0					 sec_pmic->device_type);
> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung=
/core.h
> index c7c3c8cd8d5f9..43e0c5e55f5d3 100644
> --- a/include/linux/mfd/samsung/core.h
> +++ b/include/linux/mfd/samsung/core.h
> @@ -46,6 +46,7 @@ enum sec_device_type {
> =C2=A0	S2MPS15X,
> =C2=A0	S2MPU02,
> =C2=A0	S2MPU05,
> +	S2MU005,
> =C2=A0};
> =C2=A0
> =C2=A0/**
> diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/=
irq.h
> index 8402a5f8e18ab..936369a733a1c 100644
> --- a/include/linux/mfd/samsung/irq.h
> +++ b/include/linux/mfd/samsung/irq.h
> @@ -303,6 +303,72 @@ enum s2mpu05_irq {
> =C2=A0#define S2MPU05_IRQ_INT140C_MASK	BIT(1)
> =C2=A0#define S2MPU05_IRQ_TSD_MASK		BIT(2)
> =C2=A0
> +enum s2mu005_irq {
> +	S2MU005_IRQ_CHGR_DETBAT,
> +	S2MU005_IRQ_CHGR_BAT,
> +	S2MU005_IRQ_CHGR_IVR,
> +	S2MU005_IRQ_CHGR_EVENT,
> +	S2MU005_IRQ_CHGR_CHG,
> +	S2MU005_IRQ_CHGR_VMID,
> +	S2MU005_IRQ_CHGR_WCIN,
> +	S2MU005_IRQ_CHGR_VBUS,
> +
> +	S2MU005_IRQ_FLED_LBPROT,
> +	S2MU005_IRQ_FLED_OPENCH2,
> +	S2MU005_IRQ_FLED_OPENCH1,
> +	S2MU005_IRQ_FLED_SHORTCH2,
> +	S2MU005_IRQ_FLED_SHORTCH1,
> +
> +	S2MU005_IRQ_MUIC_ATTACH,
> +	S2MU005_IRQ_MUIC_DETACH,
> +	S2MU005_IRQ_MUIC_KP,
> +	S2MU005_IRQ_MUIC_LKP,
> +	S2MU005_IRQ_MUIC_LKR,
> +	S2MU005_IRQ_MUIC_RIDCHG,
> +
> +	S2MU005_IRQ_MUIC_VBUSON,
> +	S2MU005_IRQ_MUIC_RSVD,
> +	S2MU005_IRQ_MUIC_ADC,
> +	S2MU005_IRQ_MUIC_STUCK,
> +	S2MU005_IRQ_MUIC_STUCKRCV,
> +	S2MU005_IRQ_MUIC_MHDL,
> +	S2MU005_IRQ_MUIC_AVCHG,
> +	S2MU005_IRQ_MUIC_VBUSOFF,
> +
> +	S2MU005_IRQ_NR,
> +};
> +
> +#define S2MU005_IRQ_CHGR_DETBAT_MASK	BIT(0)
> +#define S2MU005_IRQ_CHGR_BAT_MASK	BIT(1)
> +#define S2MU005_IRQ_CHGR_IVR_MASK	BIT(2)
> +#define S2MU005_IRQ_CHGR_EVENT_MASK	BIT(3)
> +#define S2MU005_IRQ_CHGR_CHG_MASK	BIT(4)
> +#define S2MU005_IRQ_CHGR_VMID_MASK	BIT(5)
> +#define S2MU005_IRQ_CHGR_WCIN_MASK	BIT(6)
> +#define S2MU005_IRQ_CHGR_VBUS_MASK	BIT(7)
> +
> +#define S2MU005_IRQ_FLED_LBPROT_MASK		BIT(2)
> +#define S2MU005_IRQ_FLED_OPENCH2_MASK		BIT(4)
> +#define S2MU005_IRQ_FLED_OPENCH1_MASK		BIT(5)
> +#define S2MU005_IRQ_FLED_SHORTCH2_MASK		BIT(6)
> +#define S2MU005_IRQ_FLED_SHORTCH1_MASK		BIT(7)
> +
> +#define S2MU005_IRQ_MUIC_ATTACH_MASK		BIT(0)
> +#define S2MU005_IRQ_MUIC_DETACH_MASK		BIT(1)
> +#define S2MU005_IRQ_MUIC_KP_MASK		BIT(2)
> +#define S2MU005_IRQ_MUIC_LKP_MASK		BIT(3)
> +#define S2MU005_IRQ_MUIC_LKR_MASK		BIT(4)
> +#define S2MU005_IRQ_MUIC_RIDCHG_MASK		BIT(5)
> +
> +#define S2MU005_IRQ_MUIC_VBUSON_MASK		BIT(0)
> +#define S2MU005_IRQ_MUIC_RSVD_MASK		BIT(1)
> +#define S2MU005_IRQ_MUIC_ADC_MASK		BIT(2)
> +#define S2MU005_IRQ_MUIC_STUCK_MASK		BIT(3)
> +#define S2MU005_IRQ_MUIC_STUCKRCV_MASK		BIT(4)
> +#define S2MU005_IRQ_MUIC_MHDL_MASK		BIT(5)
> +#define S2MU005_IRQ_MUIC_AVCHG_MASK		BIT(6)
> +#define S2MU005_IRQ_MUIC_VBUSOFF_MASK		BIT(7)
> +
> =C2=A0enum s5m8767_irq {
> =C2=A0	S5M8767_IRQ_PWRR,
> =C2=A0	S5M8767_IRQ_PWRF,
> diff --git a/include/linux/mfd/samsung/s2mu005.h b/include/linux/mfd/sams=
ung/s2mu005.h
> new file mode 100644
> index 0000000000000..32ad35dda661d
> --- /dev/null
> +++ b/include/linux/mfd/samsung/s2mu005.h
> @@ -0,0 +1,328 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd
> + * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
> + */
> +
> +#ifndef __LINUX_MFD_S2MU005_H
> +#define __LINUX_MFD_S2MU005_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +/* S2MU005 registers */
> +enum s2mu005_reg {
> +	S2MU005_REG_CHGR_INT1,
> +	S2MU005_REG_CHGR_INT1M,
> +
> +	S2MU005_REG_FLED_INT1,
> +	S2MU005_REG_FLED_INT1M,
> +
> +	S2MU005_REG_MUIC_INT1,
> +	S2MU005_REG_MUIC_INT2,
> +	S2MU005_REG_MUIC_INT1M,
> +	S2MU005_REG_MUIC_INT2M,
> +
> +	S2MU005_REG_CHGR_STATUS0,
> +	S2MU005_REG_CHGR_STATUS1,
> +	S2MU005_REG_CHGR_STATUS2,
> +	S2MU005_REG_CHGR_STATUS3,
> +	S2MU005_REG_CHGR_STATUS4,
> +	S2MU005_REG_CHGR_STATUS5,
> +	S2MU005_REG_CHGR_CTRL0,
> +	S2MU005_REG_CHGR_CTRL1,
> +	S2MU005_REG_CHGR_CTRL2,
> +	S2MU005_REG_CHGR_CTRL3,
> +	S2MU005_REG_CHGR_CTRL4,
> +	S2MU005_REG_CHGR_CTRL5,
> +	S2MU005_REG_CHGR_CTRL6,
> +	S2MU005_REG_CHGR_CTRL7,
> +	S2MU005_REG_CHGR_CTRL8,
> +	S2MU005_REG_CHGR_CTRL9,
> +	S2MU005_REG_CHGR_CTRL10,
> +	S2MU005_REG_CHGR_CTRL11,
> +	S2MU005_REG_CHGR_CTRL12,
> +	S2MU005_REG_CHGR_CTRL13,
> +	S2MU005_REG_CHGR_CTRL14,
> +	S2MU005_REG_CHGR_CTRL15,
> +	S2MU005_REG_CHGR_CTRL16,
> +	S2MU005_REG_CHGR_CTRL17,
> +	S2MU005_REG_CHGR_CTRL18,
> +	S2MU005_REG_CHGR_CTRL19,
> +	S2MU005_REG_CHGR_TEST0,
> +	S2MU005_REG_CHGR_TEST1,
> +	S2MU005_REG_CHGR_TEST2,
> +	S2MU005_REG_CHGR_TEST3,
> +	S2MU005_REG_CHGR_TEST4,
> +	S2MU005_REG_CHGR_TEST5,
> +	S2MU005_REG_CHGR_TEST6,
> +	S2MU005_REG_CHGR_TEST7,
> +	S2MU005_REG_CHGR_TEST8,
> +	S2MU005_REG_CHGR_TEST9,
> +	S2MU005_REG_CHGR_TEST10,
> +
> +	S2MU005_REG_FLED_STATUS,
> +	S2MU005_REG_FLED_CH0_CTRL0,
> +	S2MU005_REG_FLED_CH0_CTRL1,
> +	S2MU005_REG_FLED_CH0_CTRL2,
> +	S2MU005_REG_FLED_CH0_CTRL3,
> +	S2MU005_REG_FLED_CH1_CTRL0,
> +	S2MU005_REG_FLED_CH1_CTRL1,
> +	S2MU005_REG_FLED_CH1_CTRL2,
> +	S2MU005_REG_FLED_CH1_CTRL3,
> +	S2MU005_REG_FLED_CTRL0,
> +	S2MU005_REG_FLED_CTRL1,
> +	S2MU005_REG_FLED_CTRL2,
> +	S2MU005_REG_FLED_CTRL3,
> +	S2MU005_REG_FLED_CTRL4,
> +	S2MU005_REG_FLED_CTRL5,
> +	S2MU005_REG_FLED_CTRL6,
> +
> +	S2MU005_REG_RGB_EN,
> +	S2MU005_REG_RGB_CH0_CTRL,
> +	S2MU005_REG_RGB_CH1_CTRL,
> +	S2MU005_REG_RGB_CH2_CTRL,
> +	S2MU005_REG_RGB_CH0_RAMP,
> +	S2MU005_REG_RGB_CH0_STAY,
> +	S2MU005_REG_RGB_CH1_RAMP,
> +	S2MU005_REG_RGB_CH1_STAY,
> +	S2MU005_REG_RGB_CH2_RAMP,
> +	S2MU005_REG_RGB_CH2_STAY,
> +	S2MU005_REG_RGB_TEST0,
> +	S2MU005_REG_RGB_CTRL0,
> +
> +	S2MU005_REG_MUIC_ADC,
> +	S2MU005_REG_MUIC_DEV1,
> +	S2MU005_REG_MUIC_DEV2,
> +	S2MU005_REG_MUIC_DEV3,
> +	S2MU005_REG_MUIC_BUTTON1,
> +	S2MU005_REG_MUIC_BUTTON2,
> +	S2MU005_REG_MUIC_RESET,
> +	S2MU005_REG_MUIC_CHGTYPE,
> +	S2MU005_REG_MUIC_DEVAPPLE,
> +	S2MU005_REG_MUIC_BCDRESCAN,
> +	S2MU005_REG_MUIC_TEST1,
> +	S2MU005_REG_MUIC_TEST2,
> +	S2MU005_REG_MUIC_TEST3,
> +
> +	S2MU005_REG_ID =3D 0x73,
> +
> +	S2MU005_REG_MUIC_CTRL1 =3D 0xb2,
> +	S2MU005_REG_MUIC_TIMERSET1,
> +	S2MU005_REG_MUIC_TIMERSET2,
> +	S2MU005_REG_MUIC_SWCTRL,
> +	S2MU005_REG_MUIC_TIMERSET3,
> +	S2MU005_REG_MUIC_CTRL2,
> +	S2MU005_REG_MUIC_CTRL3,
> +
> +	S2MU005_REG_MUIC_LDOADC_L =3D 0xbf,
> +	S2MU005_REG_MUIC_LDOADC_H,
> +};
> +
> +#define S2MU005_REG_FLED_CH_CTRL0(x)	(S2MU005_REG_FLED_CH0_CTRL0 + 4 * (=
x))
> +#define S2MU005_REG_FLED_CH_CTRL1(x)	(S2MU005_REG_FLED_CH0_CTRL1 + 4 * (=
x))
> +#define S2MU005_REG_FLED_CH_CTRL2(x)	(S2MU005_REG_FLED_CH0_CTRL2 + 4 * (=
x))
> +#define S2MU005_REG_FLED_CH_CTRL3(x)	(S2MU005_REG_FLED_CH0_CTRL3 + 4 * (=
x))
> +
> +#define S2MU005_REG_RGB_CH_CTRL(x)	(S2MU005_REG_RGB_CH0_CTRL + 1 * (x))
> +#define S2MU005_REG_RGB_CH_RAMP(x)	(S2MU005_REG_RGB_CH0_RAMP + 2 * (x))
> +#define S2MU005_REG_RGB_CH_STAY(x)	(S2MU005_REG_RGB_CH0_STAY + 2 * (x))
> +
> +/* S2MU005_REG_CHGR_STATUS0 */
> +#define S2MU005_CHGR_VBUS		BIT(7)
> +#define S2MU005_CHGR_WCIN		BIT(6)
> +#define S2MU005_CHGR_VMID		BIT(5)
> +#define S2MU005_CHGR_CHG		BIT(4)
> +#define S2MU005_CHGR_STAT		GENMASK(3, 0)
> +
> +#define S2MU005_CHGR_STAT_DONE		FIELD_PREP(S2MU005_CHGR_STAT, 8)
> +#define S2MU005_CHGR_STAT_TOPOFF	FIELD_PREP(S2MU005_CHGR_STAT, 7)
> +#define S2MU005_CHGR_STAT_DONE_FLAG	FIELD_PREP(S2MU005_CHGR_STAT, 6)
> +#define S2MU005_CHGR_STAT_CV		FIELD_PREP(S2MU005_CHGR_STAT, 5)
> +#define S2MU005_CHGR_STAT_CC		FIELD_PREP(S2MU005_CHGR_STAT, 4)
> +#define	S2MU005_CHGR_STAT_COOL_CHG	FIELD_PREP(S2MU005_CHGR_STAT, 3)
> +#define S2MU005_CHGR_STAT_PRE_CHG	FIELD_PREP(S2MU005_CHGR_STAT, 2)
> +
> +/* S2MU005_REG_CHGR_STATUS1 */
> +#define S2MU005_CHGR_DETBAT		BIT(7)
> +#define S2MU005_CHGR_VBUSOVP		GENMASK(6, 4)
> +
> +#define S2MU005_CHGR_VBUS_OVP_OVERVOLT	FIELD_PREP(S2MU005_CHGR_OVP, 2)

With definitions like these you can't compare to FIELD_GET on the register =
value
anymore, i.e. this doesn't work:

reg =3D readl();
val =3D FIELD_GET(S2MU005_CHGR_VBUSOVP, reg);
if (val =3D=3D S2MU005_CHGR_VBUS_OVP_OVERVOLT)
  ...

or FIELD_PREP() or FIELD_MODIFY() won't work as expected.

I would expect such code to work using usual semantics.

Just define your field values without FIELD_PREP(), e.g.

#define S2MU005_CHGR_VBUS_OVP_OVERVOLT	2


Cheers,
Andre'

> +
> +/* S2MU005_REG_CHGR_STATUS2 */
> +#define S2MU005_CHGR_BAT		GENMASK(6, 4)
> +
> +#define	S2MU005_CHGR_BAT_VOLT_DET	FIELD_PREP(S2MU005_CHGR_BAT, 7)
> +#define S2MU005_CHGR_BAT_FAST_CHG_DET	FIELD_PREP(S2MU005_CHGR_BAT, 6)
> +#define	S2MU005_CHGR_BAT_COOL_CHG_DET	FIELD_PREP(S2MU005_CHGR_BAT, 5)
> +#define S2MU005_CHGR_BAT_LOW_CHG	FIELD_PREP(S2MU005_CHGR_BAT, 2)
> +#define S2MU005_CHGR_BAT_SELF_DISCHG	FIELD_PREP(S2MU005_CHGR_BAT, 1)
> +#define S2MU005_CHGR_BAT_OVP_DET	FIELD_PREP(S2MU005_CHGR_BAT, 0)
> +
> +/* S2MU005_REG_CHGR_STATUS3 */
> +#define S2MU005_CHGR_EVT		GENMASK(3, 0)
> +
> +#define S2MU005_CHGR_EVT_WDT_RST	FIELD_PREP(S2MU005_CHGR_EVT, 6)
> +#define S2MU005_CHGR_EVT_WDT_SUSP	FIELD_PREP(S2MU005_CHGR_EVT, 5)
> +#define S2MU005_CHGR_EVT_VSYS_VUVLO	FIELD_PREP(S2MU005_CHGR_EVT, 4)
> +#define S2MU005_CHGR_EVT_VSYS_VOVP	FIELD_PREP(S2MU005_CHGR_EVT, 3)
> +#define S2MU005_CHGR_EVT_THERM_FOLDBACK	FIELD_PREP(S2MU005_CHGR_EVT, 2)
> +#define S2MU005_CHGR_EVT_THERM_SHUTDOWN	FIELD_PREP(S2MU005_CHGR_EVT, 1)
> +
> +/* S2MU005_REG_CHGR_CTRL0 */
> +#define S2MU005_CHGR_CHG_EN		BIT(4)
> +#define S2MU005_CHGR_OP_MODE		GENMASK(2, 0)
> +
> +#define S2MU005_CHGR_OP_MODE_OTG	FIELD_PREP(S2MU005_CHGR_OP_MODE, BIT(2)=
)
> +#define S2MU005_CHGR_OP_MODE_CHG	FIELD_PREP(S2MU005_CHGR_OP_MODE, BIT(1)=
)
> +
> +/* S2MU005_REG_CHGR_CTRL1 */
> +#define S2MU005_CHGR_VIN_DROP		GENMASK(6, 4)
> +
> +/* S2MU005_REG_CHGR_CTRL2 */
> +#define S2MU005_CHGR_IN_CURR_LIM	GENMASK(5, 0)
> +
> +/* S2MU005_REG_CHGR_CTRL4 */
> +#define S2MU005_CHGR_OTG_OCP_ON		BIT(5)
> +#define S2MU005_CHGR_OTG_OCP_OFF	BIT(4)
> +#define S2MU005_CHGR_OTG_OCP		GENMASK(3, 2)
> +
> +/* S2MU005_REG_CHGR_CTRL5 */
> +#define S2MU005_CHGR_VMID_BOOST		GENMASK(4, 0)
> +
> +/* S2MU005_REG_CHGR_CTRL6 */
> +#define S2MU005_CHGR_COOL_CHG_CURR	GENMASK(5, 0)
> +
> +/* S2MU005_REG_CHGR_CTRL7 */
> +#define S2MU005_CHGR_FAST_CHG_CURR	GENMASK(5, 0)
> +
> +/* S2MU005_REG_CHGR_CTRL8 */
> +#define S2MU005_CHGR_VF_VBAT		GENMASK(6, 1)
> +
> +/* S2MU005_REG_CHGR_CTRL10 */
> +#define S2MU005_CHGR_TOPOFF_CURR(x)	(GENMASK(3, 0) << 4 * (x))
> +
> +/* S2MU005_REG_CHGR_CTRL11 */
> +#define S2MU005_CHGR_OSC_BOOST		GENMASK(6, 5)
> +#define S2MU005_CHGR_OSC_BUCK		GENMASK(4, 3)
> +
> +/* S2MU005_REG_CHGR_CTRL12 */
> +#define S2MU005_CHGR_WDT		GENMASK(2, 0)
> +
> +#define S2MU005_CHGR_WDT_ON		FIELD_PREP(S2MU005_CHGR_WDT, BIT(2))
> +#define S2MU005_CHGR_WDT_OFF		FIELD_PREP(S2MU005_CHGR_WDT, BIT(1))
> +
> +/* S2MU005_REG_CHGR_CTRL15 */
> +#define S2MU005_CHGR_OTG_EN		GENMASK(3, 2)
> +
> +/* S2MU005_REG_FLED_STATUS */
> +#define S2MU005_FLED_FLASH_STATUS(x)	(BIT(7) >> 2 * (x))
> +#define S2MU005_FLED_TORCH_STATUS(x)	(BIT(6) >> 2 * (x))
> +
> +/* S2MU005_REG_FLED_CHx_CTRL0 */
> +#define S2MU005_FLED_FLASH_IOUT		GENMASK(3, 0)
> +
> +/* S2MU005_REG_FLED_CHx_CTRL1 */
> +#define S2MU005_FLED_TORCH_IOUT		GENMASK(3, 0)
> +
> +/* S2MU005_REG_FLED_CHx_CTRL2 */
> +#define S2MU005_FLED_TORCH_TIMEOUT	GENMASK(3, 0)
> +
> +/* S2MU005_REG_FLED_CHx_CTRL3 */
> +#define S2MU005_FLED_FLASH_TIMEOUT	GENMASK(3, 0)
> +
> +/* S2MU005_REG_FLED_CTRL1 */
> +#define S2MU005_FLED_CH_EN		BIT(7)
> +
> +/*
> + * S2MU005_REG_FLED_CTRL4 - Rev. EVT0
> + * S2MU005_REG_FLED_CTRL6 - Rev. EVT1 and later
> + */
> +#define S2MU005_FLED_FLASH_EN(x)	(GENMASK(7, 6) >> 4 * (x))
> +#define S2MU005_FLED_TORCH_EN(x)	(GENMASK(5, 4) >> 4 * (x))
> +
> +/* S2MU005_REG_RGB_EN */
> +#define S2MU005_RGB_RESET		BIT(6)
> +#define S2MU005_RGB_SLOPE		GENMASK(5, 0)
> +
> +#define S2MU005_RGB_SLOPE_CONST		(BIT(4) | BIT(2) | BIT(0))
> +#define S2MU005_RGB_SLOPE_SMOOTH	(BIT(5) | BIT(3) | BIT(1))
> +
> +/* S2MU005_REG_RGB_CHx_RAMP */
> +#define S2MU005_RGB_CH_RAMP_UP		GENMASK(7, 4)
> +#define S2MU005_RGB_CH_RAMP_DN		GENMASK(3, 0)
> +
> +/* S2MU005_REG_RGB_CHx_STAY */
> +#define S2MU005_RGB_CH_STAY_HI		GENMASK(7, 4)
> +#define S2MU005_RGB_CH_STAY_LO		GENMASK(3, 0)
> +
> +/* S2MU005_REG_MUIC_DEV1 */
> +#define S2MU005_MUIC_OTG		BIT(7)
> +#define S2MU005_MUIC_DCP		BIT(6)
> +#define S2MU005_MUIC_CDP		BIT(5)
> +#define S2MU005_MUIC_T1_T2_CHG		BIT(4)
> +#define S2MU005_MUIC_UART		BIT(3)
> +#define S2MU005_MUIC_SDP		BIT(2)
> +#define S2MU005_MUIC_LANHUB		BIT(1)
> +#define S2MU005_MUIC_AUDIO		BIT(0)
> +
> +/* S2MU005_REG_MUIC_DEV2 */
> +#define S2MU005_MUIC_SDP_1P8S		BIT(7)
> +#define S2MU005_MUIC_AV			BIT(6)
> +#define S2MU005_MUIC_TTY		BIT(5)
> +#define S2MU005_MUIC_PPD		BIT(4)
> +#define S2MU005_MUIC_JIG_UART_OFF	BIT(3)
> +#define S2MU005_MUIC_JIG_UART_ON	BIT(2)
> +#define S2MU005_MUIC_JIG_USB_OFF	BIT(1)
> +#define S2MU005_MUIC_JIG_USB_ON		BIT(0)
> +
> +/* S2MU005_REG_MUIC_DEV3 */
> +#define S2MU005_MUIC_U200_CHG		BIT(7)
> +#define S2MU005_MUIC_VBUS_AV		BIT(4)
> +#define S2MU005_MUIC_VBUS_R255		BIT(1)
> +#define S2MU005_MUIC_MHL		BIT(0)
> +
> +/* S2MU005_REG_MUIC_DEVAPPLE */
> +#define S2MU005_MUIC_APPLE_CHG_0P5A	BIT(7)
> +#define S2MU005_MUIC_APPLE_CHG_1P0A	BIT(6)
> +#define S2MU005_MUIC_APPLE_CHG_2P0A	BIT(5)
> +#define S2MU005_MUIC_APPLE_CHG_2P4A	BIT(4)
> +#define S2MU005_MUIC_SDP_DCD_OUT	BIT(3)
> +#define S2MU005_MUIC_RID_WAKEUP		BIT(2)
> +#define S2MU005_MUIC_VBUS_WAKEUP	BIT(1)
> +#define S2MU005_MUIC_BCV1P2_OR_OPEN	BIT(0)
> +
> +/* S2MU005_REG_ID */
> +#define S2MU005_ID_MASK			GENMASK(3, 0)
> +#define S2MU005_ID_SHIFT		0
> +
> +/* S2MU005_REG_MUIC_SWCTRL */
> +#define S2MU005_MUIC_DM_DP		GENMASK(7, 2)
> +#define S2MU005_MUIC_JIG		BIT(0)
> +
> +#define S2MU005_MUIC_DM_DP_UART		FIELD_PREP(S2MU005_MUIC_DM_DP, 0x12)
> +#define S2MU005_MUIC_DM_DP_USB		FIELD_PREP(S2MU005_MUIC_DM_DP, 0x09)
> +
> +/* S2MU005_REG_MUIC_CTRL1 */
> +#define S2MU005_MUIC_OPEN		BIT(4)
> +#define S2MU005_MUIC_RAW_DATA		BIT(3)
> +#define S2MU005_MUIC_MAN_SW		BIT(2)
> +#define S2MU005_MUIC_WAIT		BIT(1)
> +#define S2MU005_MUIC_IRQ		BIT(0)
> +
> +/* S2MU005_REG_MUIC_CTRL3 */
> +#define S2MU005_MUIC_ONESHOT_ADC	BIT(2)
> +
> +/* S2MU005_REG_MUIC_LDOADC_L and S2MU005_REG_MUIC_LDOADC_H */
> +#define S2MU005_MUIC_VSET		GENMASK(4, 0)
> +
> +#define S2MU005_MUIC_VSET_3P0V		FIELD_PREP(S2MU005_MUIC_VSET, 0x1f)
> +#define S2MU005_MUIC_VSET_2P6V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0e)
> +#define S2MU005_MUIC_VSET_2P4V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0c)
> +#define S2MU005_MUIC_VSET_2P2V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0a)
> +#define S2MU005_MUIC_VSET_2P0V		FIELD_PREP(S2MU005_MUIC_VSET, 0x08)
> +#define S2MU005_MUIC_VSET_1P5V		FIELD_PREP(S2MU005_MUIC_VSET, 0x03)
> +#define S2MU005_MUIC_VSET_1P4V		FIELD_PREP(S2MU005_MUIC_VSET, 0x02)
> +#define S2MU005_MUIC_VSET_1P2V		FIELD_PREP(S2MU005_MUIC_VSET, 0x00)
> +
> +#endif	/* __LINUX_MFD_S2MU005_H */

