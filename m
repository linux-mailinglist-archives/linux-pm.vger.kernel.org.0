Return-Path: <linux-pm+bounces-42078-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMGnJalBg2kPkQMAu9opvQ
	(envelope-from <linux-pm+bounces-42078-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:55:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B4E60EB
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C133A3024A76
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5433ED108;
	Wed,  4 Feb 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQ+sdFP7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40B3D4122
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209334; cv=none; b=mx9ZXqffgk2zyxwwuu8XD5oS73d2/l1DvOfM+Z5SGd/bDwLZY4KFFZVOy3hTJQLqU7R3T3iwsVROXiS4jwqYRACm6oQwufAr1eEZ/QI30yUxGIRoCooA1l0M+inXbxVdjMsWKl5zKMxgFxXQnSvaUNUZtVlp9fFjpkWc+9wBP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209334; c=relaxed/simple;
	bh=7KU+ckH1gHvFNr2M/yzEemVGi5R3GImt57MYtyBldSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJdZYJ2s+HJJRkis15LmGlb+PNRHRCA/xvFMbMfOR+Rj0PxUyDPke4M/snrABsJbs1FU8Qle0rRXoFe78/tSUiV/GBjHa4RBzrR5M5LXo9OR4y0wMxkrSLZMRc4lW3Thq3SNVo0UCmZuPii/P+xdpo+b866H7KrHSZxwFqPx5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQ+sdFP7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8849dc12f6so973198266b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770209332; x=1770814132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7nQS+b1C7TnjA3qx1zycIJ3zbrllhDogxrXEMKQCQM=;
        b=XQ+sdFP71kQg6WPUxzd4xAnaZKh9DjUzqxl0Hyza/sSuRnxYIr080i7QM8XFApAYnD
         DsWjxkyWt2z2BJxu86qMC2l9IqH9DFcfjHF2QqzlKxK8GjnQmC0H5Plfm44YpxQN5NEY
         XdIH6UlH4tVfxISK5abTd81LUnFR/5ONMC6fgx+W18gXJgzakBoMRbd8+pAUuSiRYZKm
         JAvDBJgoCC4j/0udM/eMt/zDaU+tommjjtznFzhBu9sPskDOlvN7cs5gHB+G9RAMublS
         6itJho2qiJMpX7/KzBUg3fZgNgiAkHc2L3V2dfPzKdLhGRbtx04hjv3Fj0f9hsbJlBj8
         hFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209332; x=1770814132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7nQS+b1C7TnjA3qx1zycIJ3zbrllhDogxrXEMKQCQM=;
        b=RlaCqgGMBjra+tTmElzZQGbrPYZ5RgDyh0bksbIky92phv4qWdDSoCqRiQ+dmRdyQp
         Ll6Czop2+ZAevCummV3idwrXXuRmfXjvffk/vl2NOp5KVlgq6QI5NlN3zVMrdpOQqnBw
         qRtA/PsHaHOAG+4unUECyWKEHWucrP53lRLgyGsU0DSrcPxtk28PdZLOlsGTnVXbqvYt
         BM8aLzQlEWAbuXFlMU4OF55xZ674ARaIYmsy2wTyTHJ3NeGBRdu8MhF5Y8aPZ1qdzghB
         0eiXqG9aYCqWDqcvbWVMoouJBPjCgLSrwMpIg6k8AJFyg0XdQ1PjKZomDN7x8QSJ0y8l
         JWxw==
X-Forwarded-Encrypted: i=1; AJvYcCVpzLghcbI/sx3hiydN4dOZN7H+FATe4k8n22oc/RjoDiQCJWyrSKdecuzTRkqeIZXlkjwLJz+Nkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPgn3JG1fhi5IJT31Jc6U92fauzMaKoyI1fZLMfIaNEgOV5V/
	yTQFS1SMTKKuq1qvtsdG8yIlwTgJqPxUz4/wYMHmdLExalsLBc8ZtF0vWb3mJ701nMI=
X-Gm-Gg: AZuq6aLPqdqCyKsIwb4htASVSMZiaLNHNmrLtYgGPNyKr4mOR8oYaLlGh3UKG+O4W4N
	mjmoMb6qa83f6Pf4AYz12k0fyjpkoPB3fc6x789CKxy8PpB8rqmorqTUTG2QIQEMp6LCU5np8qT
	/77mS50KHNiHIBmeSBdkwsynxelvpETGLgXl8N+78Q1IQqeGWGoqjDlDI8L0TnXXsXmz/3ka+e+
	yqEneUxQkOJstSRk09Q9fm/csmCQaPEByaEz6xEsCK2Jj4z64Q3g+csVxTy9bnkEdspZgdoZH7H
	iO8ep+MFfypw2Seemc4R3AsPGbtmsQf87sZyjln4eUjSi/pUC/YWeeXsoEF1FbX6ldK2iKDJh13
	SC9FxefSgIpyDX9qJL16Bu5z8dpmgOzog+4zq/40IWxhdMgCEvesADWc58oZKY4lCEVnn9wgm4k
	/D49zBZk5mKSWpnSo2uylYwn6caCrM
X-Received: by 2002:a17:907:7b82:b0:b87:1c20:7c63 with SMTP id a640c23a62f3a-b8e9f070f41mr222195666b.20.1770209331712;
        Wed, 04 Feb 2026 04:48:51 -0800 (PST)
Received: from draszik.lan ([212.129.76.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0006sm121834066b.41.2026.02.04.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:48:51 -0800 (PST)
Message-ID: <3ab2d8cd112441dc1d7ab5097f5b1b64c7e415ab.camel@linaro.org>
Subject: Re: [PATCH v5 4/5] power: supply: max77759: add charger driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Wed, 04 Feb 2026 12:49:07 +0000
In-Reply-To: <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
	 <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42078-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[psy_work.work:url,dowhile0.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 331B4E60EB
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 22:50 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
> Li+/LiPoly dual input switch mode charger. While the device can support
> USB & wireless charger inputs, this implementation only supports USB
> input. This implementation supports both buck and boost modes.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0drivers/power/supply/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/power/supply/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/power/supply/max77759_charger.c | 777 +++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 795 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67db88b04537b431c927b73624993233eef43e3f..7f6d1c5c2569a1d1536642b07=
5b3e6939553382a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15553,6 +15553,12 @@ F:	drivers/mfd/max77759.c
> =C2=A0F:	drivers/nvmem/max77759-nvmem.c
> =C2=A0F:	include/linux/mfd/max77759.h
> =C2=A0
> +MAXIM MAX77759 BATTERY CHARGER DRIVER
> +M:	Amit Sunil Dhamne <amitsd@google.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/power/supply/max77759_charger.c
> +
> =C2=A0MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
> =C2=A0M:	Javier Martinez Canillas <javier@dowhile0.org>
> =C2=A0L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 92f9f7aae92f249aa165e68dbcd4cebb569286ea..3a2cdb95c98e44324151ac2b8=
6d740ae2923ee77 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -631,6 +631,17 @@ config CHARGER_MAX77705
> =C2=A0	help
> =C2=A0	=C2=A0 Say Y to enable support for the Maxim MAX77705 battery char=
ger.
> =C2=A0
> +config CHARGER_MAX77759
> +	tristate "Maxim MAX77759 battery charger driver"
> +	depends on MFD_MAX77759 && REGULATOR
> +	default MFD_MAX77759
> +	help
> +	=C2=A0 Say M or Y here to enable the MAX77759 battery charger. MAX77759
> +	=C2=A0 charger is a function of the MAX77759 PMIC. This is a dual input
> +	=C2=A0 switch-mode charger. This driver supports buck and OTG boost mod=
es.
> +
> +	=C2=A0 If built as a module, it will be called max77759_charger.
> +
> =C2=A0config CHARGER_MAX77976
> =C2=A0	tristate "Maxim MAX77976 battery charger driver"
> =C2=A0	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 4b79d5abc49a7fd1e37a26d0c89f94d9fe3a916f..6af905875ad5e3b393a703040=
5355b9a975870f6 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
> =C2=A0obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> =C2=A0obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o
> =C2=A0obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> +obj-$(CONFIG_CHARGER_MAX77759)	+=3D max77759_charger.o
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8c7465c1e7cdd0ff7e8d2a134=
752ebf7812f28ac
> --- /dev/null
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -0,0 +1,777 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * max77759_charger.c - Battery charger driver for MAX77759 charger devi=
ce.
> + *
> + * Copyright 2025 Google LLC.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/linear_range.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/max77759.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/string_choices.h>
> +#include <linux/workqueue.h>
> +
> +/* Default values for Fast Charge Current & Float Voltage */
> +#define CHG_CC_DEFAULT_UA			2266770
> +#define CHG_FV_DEFAULT_MV			4300
> +
> +#define MAX_NUM_RETRIES				3
> +#define PSY_WORK_RETRY_DELAY_MS			10
> +
> +#define FOREACH_IRQ(S)			\
> +	S(AICL),			\
> +	S(CHGIN),			\
> +	S(CHG),				\
> +	S(INLIM),			\
> +	S(BAT_OILO),			\
> +	S(CHG_STA_CC),			\
> +	S(CHG_STA_CV),			\
> +	S(CHG_STA_TO),			\
> +	S(CHG_STA_DONE)
> +
> +#define GENERATE_ENUM(e)		e
> +#define GENERATE_STRING(s)		#s
> +
> +enum {
> +	FOREACH_IRQ(GENERATE_ENUM)
> +};
> +
> +static const char *const chgr_irqs_str[] =3D {
> +	FOREACH_IRQ(GENERATE_STRING)
> +};
> +
> +#define NUM_IRQS			ARRAY_SIZE(chgr_irqs_str)
> +
> +enum {
> +	MAX77759_CHGR_RANGE_CHGCC,
> +	MAX77759_CHGR_RANGE_CHG_CV_PRM_LO,
> +	MAX77759_CHGR_RANGE_CHG_CV_PRM_HI,
> +	MAX77759_CHGR_RANGE_CHGIN_ILIM,
> +};
> +
> +static const struct linear_range chg_ranges[] =3D {
> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHGCC, MAX77759_CHGR_CHGCC_MIN_UA,
> +			 MAX77759_CHGR_CHGCC_MIN_REG,
> +			 MAX77759_CHGR_CHGCC_MAX_REG,
> +			 MAX77759_CHGR_CHGCC_STEP_UA),
> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHG_CV_PRM_LO,
> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV,
> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG,
> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MAX_REG,
> +			 MAX77759_CHGR_CHG_CV_PRM_LO_STEP_MV),
> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHG_CV_PRM_HI,
> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV,
> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG,
> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MAX_REG,
> +			 MAX77759_CHGR_CHG_CV_PRM_HI_STEP_MV),
> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHGIN_ILIM,
> +			 MAX77759_CHGR_CHGIN_ILIM_MIN_UA,
> +			 MAX77759_CHGR_CHGIN_ILIM_MIN_REG,
> +			 MAX77759_CHGR_CHGIN_ILIM_MAX_REG,
> +			 MAX77759_CHGR_CHGIN_ILIM_STEP_UA),
> +};

I wouldn't use macros for the selectors and values, as that makes it very
hard to reason about. Please see existing regulator and power supply
drivers, which almost all use the values directly for legibility. Then you
can also drop them from the header file.

Also, the linear range APIs support arrays of ranges, so
MAX77759_CHGR_RANGE_CHG_CV_PRM_LO and MAX77759_CHGR_RANGE_CHG_CV_PRM_HI
could be moved into their own range[], allowing to simplify some code
below.

> +
> +struct max77759_charger {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct power_supply *psy;
> +	struct regulator_dev *chgin_otg_rdev;
> +	struct notifier_block nb;
> +	struct power_supply *tcpm_psy;
> +	struct delayed_work psy_work;
> +	u32 psy_work_retry_cnt;
> +	int irqs[NUM_IRQS];
> +	struct mutex lock; /* protects the state below */
> +	enum max77759_chgr_mode mode;
> +};
> +
> +static inline int unlock_prot_regs(struct max77759_charger *chg, bool un=
lock)
> +{
> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_06,
> +				=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT, unlock
> +				=C2=A0 ? MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT : 0);
> +}
> +
> +static int charger_input_valid(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &val);
> +	if (ret)
> +		return ret;
> +
> +	return (val & MAX77759_CHGR_REG_CHG_INT_CHG) &&
> +		(val & MAX77759_CHGR_REG_CHG_INT_CHGIN);
> +}
> +
> +static int get_online(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D charger_input_valid(chg);
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_02, &val=
);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&chg->lock);
> +	return (val & MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS) &&
> +		(chg->mode =3D=3D MAX77759_CHGR_MODE_CHG_BUCK_ON);
> +}
> +
> +static int get_status(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val=
);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
> +	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
> +	case MAX77759_CHGR_CHG_DTLS_CC:
> +	case MAX77759_CHGR_CHG_DTLS_CV:
> +	case MAX77759_CHGR_CHG_DTLS_TO:
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +	case MAX77759_CHGR_CHG_DTLS_DONE:
> +		return POWER_SUPPLY_STATUS_FULL;
> +	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
> +	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
> +	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
> +	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	case MAX77759_CHGR_CHG_DTLS_OFF:
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +	default:
> +		break;
> +	}
> +
> +	return POWER_SUPPLY_STATUS_UNKNOWN;
> +}
> +
> +static int get_charge_type(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val=
);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
> +	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
> +		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +	case MAX77759_CHGR_CHG_DTLS_CC:
> +	case MAX77759_CHGR_CHG_DTLS_CV:
> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
> +	case MAX77759_CHGR_CHG_DTLS_TO:
> +		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +	case MAX77759_CHGR_CHG_DTLS_DONE:
> +	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
> +	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
> +	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
> +	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
> +	case MAX77759_CHGR_CHG_DTLS_OFF:
> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
> +	default:
> +		break;
> +	}
> +
> +	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +}
> +
> +static int get_chg_health(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_00, &val=
);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_OO_CHGIN_DTLS, val)) {
> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE:
> +		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
> +		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
> +		return POWER_SUPPLY_HEALTH_GOOD;
> +	default:
> +		break;
> +	}
> +
> +	return POWER_SUPPLY_HEALTH_UNKNOWN;
> +}
> +
> +static int get_batt_health(struct max77759_charger *chg)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val=
);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS, val)) {
> +	case MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
> +		return POWER_SUPPLY_HEALTH_NO_BATTERY;
> +	case MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY:
> +		return POWER_SUPPLY_HEALTH_DEAD;
> +	case MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
> +		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +	case MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
> +	case MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
> +		return POWER_SUPPLY_HEALTH_GOOD;
> +	case MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
> +		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
> +	case MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
> +		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	case MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
> +		return POWER_SUPPLY_HEALTH_OVERCURRENT;
> +	default:
> +		break;
> +	}
> +
> +	return POWER_SUPPLY_HEALTH_UNKNOWN;
> +}
> +
> +static int get_health(struct max77759_charger *chg)
> +{
> +	int ret;
> +
> +	ret =3D get_online(chg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		ret =3D get_chg_health(chg);
> +		if (ret < 0 || ret !=3D POWER_SUPPLY_HEALTH_GOOD)
> +			return ret;
> +	}
> +
> +	return get_batt_health(chg);
> +}
> +
> +static int get_fast_charge_current(struct max77759_charger *chg)
> +{
> +	u32 regval, val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	regval =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
> +	if (regval <=3D MAX77759_CHGR_CHGCC_MIN_REG)
> +		return MAX77759_CHGR_CHGCC_MIN_UA;

I'd reference your linear range here, instead of open-coding/duplicating,
making it less likely to reference a wrong value, or helping to avoid mista=
kes
if chg_ranges[] ever changed in the future:

+	if (regval < chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min_sel)
+		return chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min;

> +
> +	ret =3D linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
> +				=C2=A0=C2=A0=C2=A0=C2=A0 regval, &val);
> +	if (ret)
> +		return ret;
> +
> +	return ret ? ret : val;

The above is duplicating the test of ret. How about:

+	regval =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
+	/* use max() here because first few selectors are valid and all same */
+	regval =3D max(regval, chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min_sel);
+=09
+	ret =3D linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
+				     regval, &val);
+
+	return ret ? ret : val;

> +}
> +
> +static int set_fast_charge_current_limit(struct max77759_charger *chg,
> +					 u32 cc_max_ua)
> +{
> +	bool found;
> +	u32 regval;
> +	int ret;
> +
> +	ret =3D linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE_=
CHGCC],
> +					=C2=A0=C2=A0=C2=A0=C2=A0 cc_max_ua, &regval, &found);
> +	if (!found)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02,
> +				=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
> +}
> +
> +static int get_float_voltage(struct max77759_charger *chg)
> +{
> +	u32 regval, val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	regval =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM, regval);
> +	switch (regval) {
> +	case MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_H=
I_MAX_REG:
> +		ret =3D linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_=
PRM_HI],
> +					=C2=A0=C2=A0=C2=A0=C2=A0 regval, &val);
> +		break;
> +	case MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_L=
O_MAX_REG:
> +		ret =3D linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_=
PRM_LO],
> +					=C2=A0=C2=A0=C2=A0=C2=A0 regval, &val);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret ? ret : val;
> +}

For the case statements, I'd again reference each linear range's .min_sel
and .max_sel here, instead of open-coding.

That said, if you switched to using linear_range_get_value_array() instead
of manually determining which range to use, you wouldn't need the switch
statement in the first place.

> +
> +static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_=
mv)
> +{
> +	u32 regval;
> +	bool found;
> +	int ret;
> +
> +	if (fv_mv >=3D MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV &&
> +	=C2=A0=C2=A0=C2=A0 fv_mv <=3D MAX77759_CHGR_CHG_CV_PRM_LO_MAX_MV) {
> +		ret =3D linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE=
_CHG_CV_PRM_LO],
> +						=C2=A0=C2=A0=C2=A0=C2=A0 fv_mv, &regval, &found);
> +	} else if (fv_mv >=3D MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV &&
> +		=C2=A0=C2=A0 fv_mv <=3D MAX77759_CHGR_CHG_CV_PRM_HI_MAX_MV) {
> +		ret =3D linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE=
_CHG_CV_PRM_HI],
> +						=C2=A0=C2=A0=C2=A0=C2=A0 fv_mv, &regval, &found);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	if (!found)
> +		return -EINVAL;

If you're only going by found, you don't need ret.

Is there an underlying reason to use linear_range_get_selector_high()?
Could it use linear_range_get_selector_low_array() instead? Or maybe
it'd make sense to introduce a linear_range_get_selector_high_array()?

> +
> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04,
> +				=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM,
> +				=C2=A0 regval);
> +}
> +
> +static int get_input_current_limit(struct max77759_charger *chg)
> +{
> +	u32 regval, val;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	regval =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM, regval);
> +	if (regval <=3D MAX77759_CHGR_CHGIN_ILIM_MIN_REG)
> +		return MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
> +
> +	ret =3D linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGIN_IL=
IM],
> +				=C2=A0=C2=A0=C2=A0=C2=A0 regval, &val);
> +
> +	return ret ? ret : val;

Similar to get_fast_charge_current() above.

> +}
> +
> +static int set_input_current_limit(struct max77759_charger *chg, int ili=
m_ua)
> +{
> +	u32 regval;
> +
> +	if (ilim_ua < 0)
> +		return -EINVAL;
> +
> +	linear_range_get_selector_within(&chg_ranges[MAX77759_CHGR_RANGE_CHGIN_=
ILIM],
> +					 ilim_ua, &regval);
> +
> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
> +				=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
> +				=C2=A0 regval);
> +}
> +
> +static const enum power_supply_property max77759_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
> +static int max77759_charger_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *pval)
> +{
> +	struct max77759_charger *chg =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D get_online(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret =3D charger_input_valid(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D get_status(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D get_charge_type(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D get_health(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret =3D get_fast_charge_current(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		ret =3D get_float_voltage(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D get_input_current_limit(chg);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	pval->intval =3D ret;
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static const struct power_supply_desc max77759_charger_desc =3D {
> +	.name =3D "max77759-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D max77759_charger_props,
> +	.num_properties =3D ARRAY_SIZE(max77759_charger_props),
> +	.get_property =3D max77759_charger_get_property,
> +};
> +
> +static int charger_set_mode(struct max77759_charger *chg,
> +			=C2=A0=C2=A0=C2=A0 enum max77759_chgr_mode mode)
> +{
> +	int ret;
> +
> +	guard(mutex)(&chg->lock);
> +
> +	if (chg->mode =3D=3D mode)
> +		return 0;
> +
> +	if ((mode =3D=3D MAX77759_CHGR_MODE_CHG_BUCK_ON ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D=3D MAX77759_CHGR_MODE_OTG_BOOST_ON) &=
&
> +	=C2=A0=C2=A0=C2=A0 chg->mode !=3D MAX77759_CHGR_MODE_OFF) {
> +		dev_err(chg->dev, "Invalid mode transition from %d to %d",
> +			chg->mode, mode);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00,
> +				 MAX77759_CHGR_REG_CHG_CNFG_00_MODE, mode);
> +	if (ret)
> +		return ret;
> +
> +	chg->mode =3D mode;
> +	return 0;
> +}
> +
> +static int enable_chgin_otg(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON);
> +}
> +
> +static int disable_chgin_otg(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +}
> +
> +static int chgin_otg_status(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	guard(mutex)(&chg->lock);
> +	return chg->mode =3D=3D MAX77759_CHGR_MODE_OTG_BOOST_ON;
> +}
> +
> +static const struct regulator_ops chgin_otg_reg_ops =3D {
> +	.enable =3D enable_chgin_otg,
> +	.disable =3D disable_chgin_otg,
> +	.is_enabled =3D chgin_otg_status,
> +};
> +
> +static const struct regulator_desc chgin_otg_reg_desc =3D {
> +	.name =3D "chgin-otg",
> +	.of_match =3D of_match_ptr("chgin-otg-regulator"),
> +	.owner =3D THIS_MODULE,
> +	.ops =3D &chgin_otg_reg_ops,
> +	.fixed_uV =3D 5000000,
> +	.n_voltages =3D 1,
> +};
> +
> +static irqreturn_t irq_handler(int irq, void *data)
> +{
> +	struct max77759_charger *chg =3D data;
> +	struct device *dev =3D chg->dev;
> +	int i;
> +
> +	for (i =3D 0; i < NUM_IRQS && chg->irqs[i] !=3D irq; i++)
> +		;
> +
> +	if (i =3D=3D NUM_IRQS) {
> +		dev_err(dev, "Unable to handle irq=3D%d", irq);

This needs to be dev_err_ratelimited() as mentioned before. You don't want
to render the system unusable due to excessive potential logging.

> +		return IRQ_NONE;
> +	}
> +
> +	if (i =3D=3D BAT_OILO)
> +		dev_warn(dev, "Battery over-current threshold crossed");

dev_warn_ratelimited()

> +
> +	power_supply_changed(chg->psy);
> +	return IRQ_HANDLED;
> +}

It seems the i=3D=3DNUM_IRQS test is only required because it's trying to
figure out if it is the BAT_OILO irq. How about instead:


static irqreturn_t irq_handler(int irq, void *data)
{
	struct max77759_charger *chg =3D data;

	power_supply_changed(chg->psy);

	return IRQ_HANDLED;
}

static irqreturn_t bat_oilo_irq_handler(int irq, void *data)
{
	struct max77759_charger *chg =3D data;

	dev_warn_ratelimited(chg->dev, "Battery over-current threshold crossed");

	return irq_handler(irq, data);
}

and then in max77759_init_irqhandler(), you pick bat_oilo_irq_handler()
for i=3D=3DBAT_OILO and irq_handler() otherwise? This way, lots of unnecess=
ary
tests are avoided for the usual cases, and even for unexpected ones.

Would that work?

> +
> +static int max77759_init_irqhandler(struct max77759_charger *chg)
> +{
> +	struct device *dev =3D chg->dev;
> +	int i, ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(chgr_irqs_str); i++) {
> +		ret =3D platform_get_irq_byname(to_platform_device(dev),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chgr_irqs_str[i]);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get irq resource for %s",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 chgr_irqs_str[i]);
> +
> +		chg->irqs[i] =3D ret;
> +		ret =3D devm_request_threaded_irq(dev, chg->irqs[i], NULL,
> +						irq_handler, 0, dev_name(dev),
> +						chg);

Could you supplement dev_name() here with the irq description please,
to e.g. give more meaningful output in /proc/interrupts etc:

	name =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s", dev_name(dev),
			      chgr_irqs_str[i]);

(+ error handling), and then use name in the request irq call instead of
dev_name(dev).

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to register irq handler for %s",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 chgr_irqs_str[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77759_charger_init(struct max77759_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	u32 regval, fast_chg_curr, fv;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	chg->mode =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
> +	ret =3D charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	if (ret)
> +		return ret;
> +
> +	if (power_supply_get_battery_info(chg->psy, &info)) {
> +		fv =3D CHG_FV_DEFAULT_MV;
> +		fast_chg_curr =3D CHG_CC_DEFAULT_UA;
> +	} else {
> +		fv =3D info->constant_charge_voltage_max_uv / 1000;
> +		fast_chg_curr =3D info->constant_charge_current_max_ua;
> +	}
> +
> +	ret =3D set_fast_charge_current_limit(chg, fast_chg_curr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D set_float_voltage_limit(chg, fv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D unlock_prot_regs(chg, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable wireless charging input */
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
> +				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
> +				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
> +	if (ret)
> +		return ret;
> +
> +	return unlock_prot_regs(chg, false);
> +}
> +
> +static void psy_work_item(struct work_struct *work)
> +{
> +	struct max77759_charger *chg =3D
> +		container_of(work, struct max77759_charger, psy_work.work);
> +	union power_supply_propval current_limit, online;
> +	int ret;
> +
> +	ret =3D power_supply_get_property(chg->tcpm_psy,
> +					POWER_SUPPLY_PROP_CURRENT_MAX,
> +					&current_limit);
> +	if (ret) {
> +		dev_err(chg->dev,
> +			"Failed to get CURRENT_MAX psy property, ret=3D%d",
> +			ret);
> +		goto err;
> +	}
> +
> +	ret =3D power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLI=
NE,
> +					&online);
> +	if (ret) {
> +		dev_err(chg->dev,
> +			"Failed to get ONLINE psy property, ret=3D%d",
> +			ret);
> +		goto err;
> +	}
> +
> +	if (online.intval && current_limit.intval) {
> +		ret =3D set_input_current_limit(chg, current_limit.intval);
> +		if (ret) {
> +			dev_err(chg->dev,
> +				"Unable to set current limit, ret=3D%d", ret);
> +			goto err;
> +		}
> +
> +		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
> +	} else {
> +		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	}
> +
> +	chg->psy_work_retry_cnt =3D 0;
> +	return;
> +
> +err:
> +	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	if (chg->psy_work_retry_cnt >=3D MAX_NUM_RETRIES)
> +		return;

I'd say this final giving up could benefit from a dev_err(), while ...

> +
> +	++chg->psy_work_retry_cnt;
> +	dev_err(chg->dev, "Retrying %u/%u chg psy_work",
> +		chg->psy_work_retry_cnt, MAX_NUM_RETRIES);

... this one could be demoted (but doesn't have to).

That'd make it easier to determine if it's still in the process of
trying, or if it has given up fully.

> +	schedule_delayed_work(&chg->psy_work,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(PSY_WORK_RETRY_DELAY_=
MS));
> +}
> +
> +static int psy_changed(struct notifier_block *nb, unsigned long evt, voi=
d *data)
> +{
> +	struct max77759_charger *chg =3D container_of(nb, struct max77759_charg=
er,
> +						=C2=A0=C2=A0=C2=A0 nb);
> +	static const char *psy_name =3D "tcpm-source";
> +	struct power_supply *psy =3D data;
> +
> +	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
> +	=C2=A0=C2=A0=C2=A0 evt !=3D PSY_EVENT_PROP_CHANGED)
> +		return NOTIFY_OK;
> +
> +	chg->tcpm_psy =3D psy;

Do you need locking here? What if this is changed while a previous
psy_work_item() is still executing?


Cheers,
Andre'


> +	schedule_delayed_work(&chg->psy_work, 0);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void max_tcpci_unregister_psy_notifier(void *nb)
> +{
> +	power_supply_unreg_notifier(nb);
> +}
> +
> +static int max77759_charger_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config chgin_otg_reg_cfg;
> +	struct power_supply_config psy_cfg;
> +	struct device *dev =3D &pdev->dev;
> +	struct max77759_charger *chg;
> +	int ret;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +	chg->dev =3D dev;
> +	chg->regmap =3D dev_get_regmap(dev->parent, "charger");
> +	if (!chg->regmap)
> +		return dev_err_probe(dev, -ENODEV, "Missing regmap");
> +
> +	ret =3D devm_mutex_init(dev, &chg->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize lock");
> +
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	psy_cfg.drv_data =3D chg;
> +	chg->psy =3D devm_power_supply_register(dev, &max77759_charger_desc,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &psy_cfg);
> +	if (IS_ERR(chg->psy))
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register psy, ret=3D%ld",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 PTR_ERR(chg->psy));
> +
> +	ret =3D max77759_charger_init(chg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize max77759 charger");
> +
> +	chgin_otg_reg_cfg.dev =3D dev;
> +	chgin_otg_reg_cfg.driver_data =3D chg;
> +	chgin_otg_reg_cfg.of_node =3D dev_of_node(dev);
> +	chg->chgin_otg_rdev =3D devm_regulator_register(dev, &chgin_otg_reg_des=
c,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &chgin_otg_reg_cfg);
> +	if (IS_ERR(chg->chgin_otg_rdev))
> +		return dev_err_probe(dev, PTR_ERR(chg->chgin_otg_rdev),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register chgin otg regulator");
> +
> +	ret =3D devm_delayed_work_autocancel(dev, &chg->psy_work, psy_work_item=
);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize psy work");
> +
> +	chg->nb.notifier_call =3D psy_changed;
> +	ret =3D power_supply_reg_notifier(&chg->nb);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to register psy notifier");
> +
> +	ret =3D devm_add_action_or_reset(dev, max_tcpci_unregister_psy_notifier=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &chg->nb);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add devm action to unregister ps=
y notifier");
> +
> +	return max77759_init_irqhandler(chg);
> +}
> +
> +static const struct platform_device_id max77759_charger_id[] =3D {
> +	{ .name =3D "max77759-charger", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, max77759_charger_id);
> +
> +static struct platform_driver max77759_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77759-charger",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe =3D max77759_charger_probe,
> +	.id_table =3D max77759_charger_id,
> +};
> +module_platform_driver(max77759_charger_driver);
> +
> +MODULE_AUTHOR("Amit Sunil Dhamne <amitsd@google.com>");
> +MODULE_DESCRIPTION("Maxim MAX77759 charger driver");
> +MODULE_LICENSE("GPL");

