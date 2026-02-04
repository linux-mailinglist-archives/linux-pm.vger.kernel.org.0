Return-Path: <linux-pm+bounces-42085-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FmkKoZVg2mJlQMAu9opvQ
	(envelope-from <linux-pm+bounces-42085-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 15:19:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A0E6F83
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3A173013717
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88A410D1B;
	Wed,  4 Feb 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsGX0+oe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB219413244
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214641; cv=none; b=G1vhDFv8Dj40mBECGq32VdnUSvNUITLGrYMt0DyoPTGz3xcqXhgMP5k5pyJ/E0iB/rbOBbtTmtgcAPPGu7P2qWjjmJCaXilf9egs2lpI3uimlEIxBAhYt4PV1DQp0WF7z38ILDmIb6YiGIMH6O861rgg24R7+/fhzzRW6tfw8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214641; c=relaxed/simple;
	bh=fqK/sV1/SV/2SRm0hf98CdMaH9ntyCY9/h5a4/cBf9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzsCM5caVRXXXAubDPNgs/MzZ8sLUVYjHLcsjqXxXI3Xoko2Ap3OOOMYoYJtNms/xWD+1SfcEvVRF9jmNFAKODslNaHsMmp+5VSqNZR5Nqe4g9Wh22wZN0OdiKAori7mXA6CQjyt/PbFcBavKDJ6XFt1QOnp1kJ+bM0glKSOX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bsGX0+oe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so991095766b.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770214639; x=1770819439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tf4Ir5IFLu+SmMvPSgo65r/HAkUdr4ohgIhUVdFKVQ0=;
        b=bsGX0+oe2f6kv1WuWDGyQq47Hdrkes/K8kavT53wP9EcH4dF4drmeiFGOx+QezlfhL
         yDQjdFEp6vjBFkNX2wUXPEl/X+yJmAo6H9BMcC54fRPWClUb0MwejiDUX83I904oq8u0
         hh1sQA/yVGKoIgVrhZ0rCEbqMxEqR2gJLpFc2onS7bvZWCyjPOWTF9MQnXm4tOvfzzMM
         Bo+ooU702vGUm1uVlM7Q9+wtf5H9d0Bf+ruq7qi/4d4zX2ab2hVrIZgHNykm7l2mMl9k
         ZHd5wsIInLssCDc/cCAjQtCZyvan7OO4WTZT+Ws/Ocw8kwgjGieMnsdz0GyGC6G7w51O
         kCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214639; x=1770819439;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf4Ir5IFLu+SmMvPSgo65r/HAkUdr4ohgIhUVdFKVQ0=;
        b=bLaEjWLU8JoRyl8LZ11wfIhoeOPGUoaR/SrzRLK0/szQilmOWDj3EwhKSg55nn8fi3
         pU9DfvAbkZ6OSn97pMD3oAscGT3cyKP6w2QX/0inlk8xHSDLWLBaYqLpwEhpfyK2Fq9o
         pz203jtHgKiTXt8T5jaFqB05BtpRpqam0bWGo5bBoS9odALLv+8/dIP2I4RbBt2nH1R6
         ldmDpaVQqgsFMyBiDTUW7pt2jkGK6pWSWqX2DKkB7jwUYatatHPLjA6WDLqx/GBKm6oz
         zq+ICJGRK1aZMyY3kcH+WKMKb2SKj85n0x6HCmagrERaO0X3eEZU1NYBJuryH70Rpklg
         xGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSWFdyVr1MuWYivpYbHWjQVlHRun50VzxuL0bA/LFUufyD6XPUY9O9ckwXzxrj1JzST6gQ1j9VMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CTqpfQTB1una4UXTJo9VeAOUkQ7vNWQW1/OG+nG0GMvjzTFR
	E28MeehERxNUvxi2DuCI4Beog6w37p8cZNwLP/TLjMH7lZZKFw9riTPJ9k3xqv/sTaE=
X-Gm-Gg: AZuq6aKmNQNqFo2CQvNhpwt/FCyJJ2df8n6cTP44s5VsAeZiIRMCAoAC0ptIAMQRuzE
	UG+eSJF1XgV6Cc472XOUB44osQByeEo2fJhMtt5VtoUdC4VEFJ6Svp7ZbM875saVG5xaUxmfvyU
	buiMDyEHEDBXeTSBvFY3nEod5jP6pH449Bclk4JRGH3q4xUzCdrOPi7ymFjTVpESm0REjE7WMUP
	LA07gMDi0cJaWq1+tpU9/MIDT/Gbu+WXmyjIzqxTZWsgTnKdIf6LWnUYH79c+DjqY4erX/zE3Dq
	qFYS/zBFKJe5bMjeG6pzX0OUzkGy3GyspTQ56uzSLiUO3yiN9lgWuPU/Q/nqo9iOzIrJR5mpVBf
	GiqImhLQehNAlmhBOrOd1b8bIaF200I1zqDkSIHdau3RI6lqXv6eUdyEnTe3nP4B0XvDohSKQ8X
	UVCF1iCHC0oO1uoqlEWw==
X-Received: by 2002:a17:907:72d0:b0:b87:6:371d with SMTP id a640c23a62f3a-b8e9f42bb01mr227190666b.49.1770214639112;
        Wed, 04 Feb 2026 06:17:19 -0800 (PST)
Received: from draszik.lan ([212.129.76.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0044a09sm125346166b.56.2026.02.04.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:17:18 -0800 (PST)
Message-ID: <f6d1340062448cf52e4c034d250524e030877898.camel@linaro.org>
Subject: Re: [PATCH v2 07/12] mfd: sec: store hardware revision in
 sec_pmic_dev and add S2MU005 support
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
Date: Wed, 04 Feb 2026 14:17:35 +0000
In-Reply-To: <20260126-s2mu005-pmic-v2-7-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
	 <20260126-s2mu005-pmic-v2-7-78f1a75f547a@disroot.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42085-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,disroot.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 235A0E6F83
X-Rspamd-Action: no action

Hi Kaustabh,

On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
> The device revision matters in cases when in some PMICs, the correct
> register offsets very in different revisions. Instead of just debug

s/very/vary

> printing the value, store it in the driver data struct.

Please mention that you're not doing that for s2mpg1x, though.

>=20
> Unlike other devices, S2MU005 has its hardware revision ID in register
> offset 0x73. Allow handling different devices and add support for S2MU005=
.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> =C2=A0drivers/mfd/sec-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 41 ++++++++++++++++++++++++++++++----------
> =C2=A0include/linux/mfd/samsung/core.h |=C2=A0 1 +
> =C2=A02 files changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
> index bc2a1f2c6dc7a..069a1ba9aa1f1 100644
> --- a/drivers/mfd/sec-common.c
> +++ b/drivers/mfd/sec-common.c
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/mfd/samsung/irq.h>
> =C2=A0#include <linux/mfd/samsung/s2mps11.h>
> =C2=A0#include <linux/mfd/samsung/s2mps13.h>
> +#include <linux/mfd/samsung/s2mu005.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/pm.h>
> @@ -111,17 +112,38 @@ static const struct mfd_cell s2mu005_devs[] =3D {
> =C2=A0	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"=
),
> =C2=A0};
> =C2=A0
> -static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
> +static int sec_pmic_store_rev(struct sec_pmic_dev *sec_pmic)
> =C2=A0{
> -	unsigned int val;
> +	unsigned int reg, mask, shift;
> +	int ret;
> =C2=A0
> -	/* For s2mpg1x, the revision is in a different regmap */
> -	if (sec_pmic->device_type =3D=3D S2MPG10)
> -		return;
> +	switch (sec_pmic->device_type) {
> +	case S2MPG10:
> +		/* For s2mpg1x, the revision is in a different regmap */
> +		return 0;
> +	case S2MU005:
> +		reg =3D S2MU005_REG_ID;
> +		mask =3D S2MU005_ID_MASK;
> +		shift =3D S2MU005_ID_SHIFT;
> +		break;
> +	default:
> +		/* For other device types, the REG_ID is always the first register. */
> +		reg =3D S2MPS11_REG_ID;
> +		mask =3D ~0;
> +		shift =3D 0;
> +	}
> +
> +	ret =3D regmap_read(sec_pmic->regmap_pmic, reg, &sec_pmic->revision);
> +	if (ret) {
> +		dev_err(sec_pmic->dev, "Failed to read PMIC revision (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	sec_pmic->revision &=3D mask;
> +	sec_pmic->revision >>=3D shift;
> =C2=A0
> -	/* For each device type, the REG_ID is always the first register */
> -	if (!regmap_read(sec_pmic->regmap_pmic, S2MPS11_REG_ID, &val))
> -		dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", val);
> +	dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", sec_pmic->revision);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
> @@ -262,9 +284,8 @@ int sec_pmic_probe(struct device *dev, int device_typ=
e, unsigned int irq,
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	sec_pmic_configure(sec_pmic);
> -	sec_pmic_dump_rev(sec_pmic);
> =C2=A0
> -	return ret;
> +	return sec_pmic_store_rev(sec_pmic);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(sec_pmic_probe);
> =C2=A0
> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung=
/core.h
> index 43e0c5e55f5d3..56aa33d7e3d60 100644
> --- a/include/linux/mfd/samsung/core.h
> +++ b/include/linux/mfd/samsung/core.h
> @@ -70,6 +70,7 @@ struct sec_pmic_dev {
> =C2=A0
> =C2=A0	int device_type;
> =C2=A0	int irq;
> +	unsigned int revision;

kerneldoc needs to be updated.

Given the LED driver is the only driver & device so far which needs the
PMIC revision, maybe for now that driver could determine the revision
itself instead of adding this new member for everybody?

Cheers,
Andre'

> =C2=A0};
> =C2=A0
> =C2=A0struct sec_platform_data {

