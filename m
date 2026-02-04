Return-Path: <linux-pm+bounces-42087-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJtaM8pmg2ntmQMAu9opvQ
	(envelope-from <linux-pm+bounces-42087-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 16:33:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CCE8DBF
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5AB6309A0A8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C44423A8E;
	Wed,  4 Feb 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TClKHmka"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96512D8773;
	Wed,  4 Feb 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217574; cv=none; b=l3oKJxllPP05KqzPZmCrpAYEYbbqastCv06NUTbIs5h9Jy55gclESE5CmduMRa07jAuQus2Lz4tR8K0PFHrrkb+8YmMS6eUxrUDY6oTiVpciI9/pfq/oP7sAXHTWRkXAtvZx6pPY02nJpyH/VbUCJ8O5eNxxCMhfJvGZmVpzTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217574; c=relaxed/simple;
	bh=l4UJ93xL7RIvdoXEwAso2k8G0XekRBNduqBjM9EsFKA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jwrSCaafHJ+XrqxfnaF4FDEpXAql0kagqOcpH/JKammmXQshtBcWd1syXK7FMXnlGS5NfC8sPbCDYSxAsq+OHqxBQ3mDTqKLlnzBh9wsjrdhV8NzuWLP/MCKA9p1RPSn5vNafquxJuBDrJDB335gCV3xSvqnb+oi+vaUdpNRoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TClKHmka; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C697125C1C;
	Wed,  4 Feb 2026 16:06:04 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cgbYDkk9oG5; Wed,  4 Feb 2026 16:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770217564; bh=l4UJ93xL7RIvdoXEwAso2k8G0XekRBNduqBjM9EsFKA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=TClKHmkaMrFhD2NWust0LeIqUxfXPqLuyUNrUESirdCylnARh3eREhXvCxJX8+nBw
	 mBNS1XqGzDNcDP4XeNf/7ZJuLZtCTDYCnmJsGIDB8qz9Nx/Zo6gxCLXHLmtt2wntJ6
	 UqTjXrveWdYxFWQNkAYG4dAAh/903R/yr1aV0/IO++l0+ZNJTsBRJSB5mtRcqQepjM
	 EzuP8xCz6ryTm8HEpbLRK6mznhVyGK82C8oHH3OaxKjxeJw5is3Iewr/p8TLuB4+Zc
	 LxXPGguOCvhEfwgDkJt8ZbPf2lDk5Ct4q8Hc/BqXeob2MU+kJSKC6DzL14HKMy+SQO
	 7wTLS16k/hvsQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 20:35:49 +0530
Message-Id: <DG69QZBG97G3.1458CJYT0YG9C@disroot.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] mfd: sec: store hardware revision in
 sec_pmic_dev and add S2MU005 support
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>, "Lee Jones" <lee@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "Sebastian Reichel" <sre@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-7-78f1a75f547a@disroot.org>
 <f6d1340062448cf52e4c034d250524e030877898.camel@linaro.org>
In-Reply-To: <f6d1340062448cf52e4c034d250524e030877898.camel@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42087-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,disroot.org:email,disroot.org:dkim,disroot.org:mid]
X-Rspamd-Queue-Id: EB4CCE8DBF
X-Rspamd-Action: no action

On 2026-02-04 14:17 +00:00, Andr=C3=A9 Draszik wrote:
> Hi Kaustabh,
>
> On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
>> The device revision matters in cases when in some PMICs, the correct
>> register offsets very in different revisions. Instead of just debug
>
> s/very/vary
>
>> printing the value, store it in the driver data struct.
>
> Please mention that you're not doing that for s2mpg1x, though.
>
>>=20
>> Unlike other devices, S2MU005 has its hardware revision ID in register
>> offset 0x73. Allow handling different devices and add support for S2MU00=
5.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> =C2=A0drivers/mfd/sec-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 41 ++++++++++++++++++++++++++++++----------
>> =C2=A0include/linux/mfd/samsung/core.h |=C2=A0 1 +
>> =C2=A02 files changed, 32 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
>> index bc2a1f2c6dc7a..069a1ba9aa1f1 100644
>> --- a/drivers/mfd/sec-common.c
>> +++ b/drivers/mfd/sec-common.c
>> @@ -16,6 +16,7 @@
>> =C2=A0#include <linux/mfd/samsung/irq.h>
>> =C2=A0#include <linux/mfd/samsung/s2mps11.h>
>> =C2=A0#include <linux/mfd/samsung/s2mps13.h>
>> +#include <linux/mfd/samsung/s2mu005.h>
>> =C2=A0#include <linux/module.h>
>> =C2=A0#include <linux/of.h>
>> =C2=A0#include <linux/pm.h>
>> @@ -111,17 +112,38 @@ static const struct mfd_cell s2mu005_devs[] =3D {
>> =C2=A0	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb=
"),
>> =C2=A0};
>> =C2=A0
>> -static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
>> +static int sec_pmic_store_rev(struct sec_pmic_dev *sec_pmic)
>> =C2=A0{
>> -	unsigned int val;
>> +	unsigned int reg, mask, shift;
>> +	int ret;
>> =C2=A0
>> -	/* For s2mpg1x, the revision is in a different regmap */
>> -	if (sec_pmic->device_type =3D=3D S2MPG10)
>> -		return;
>> +	switch (sec_pmic->device_type) {
>> +	case S2MPG10:
>> +		/* For s2mpg1x, the revision is in a different regmap */
>> +		return 0;
>> +	case S2MU005:
>> +		reg =3D S2MU005_REG_ID;
>> +		mask =3D S2MU005_ID_MASK;
>> +		shift =3D S2MU005_ID_SHIFT;
>> +		break;
>> +	default:
>> +		/* For other device types, the REG_ID is always the first register. *=
/
>> +		reg =3D S2MPS11_REG_ID;
>> +		mask =3D ~0;
>> +		shift =3D 0;
>> +	}
>> +
>> +	ret =3D regmap_read(sec_pmic->regmap_pmic, reg, &sec_pmic->revision);
>> +	if (ret) {
>> +		dev_err(sec_pmic->dev, "Failed to read PMIC revision (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	sec_pmic->revision &=3D mask;
>> +	sec_pmic->revision >>=3D shift;
>> =C2=A0
>> -	/* For each device type, the REG_ID is always the first register */
>> -	if (!regmap_read(sec_pmic->regmap_pmic, S2MPS11_REG_ID, &val))
>> -		dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", val);
>> +	dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", sec_pmic->revision);
>> +	return 0;
>> =C2=A0}
>> =C2=A0
>> =C2=A0static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
>> @@ -262,9 +284,8 @@ int sec_pmic_probe(struct device *dev, int device_ty=
pe, unsigned int irq,
>> =C2=A0		return ret;
>> =C2=A0
>> =C2=A0	sec_pmic_configure(sec_pmic);
>> -	sec_pmic_dump_rev(sec_pmic);
>> =C2=A0
>> -	return ret;
>> +	return sec_pmic_store_rev(sec_pmic);
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(sec_pmic_probe);
>> =C2=A0
>> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsun=
g/core.h
>> index 43e0c5e55f5d3..56aa33d7e3d60 100644
>> --- a/include/linux/mfd/samsung/core.h
>> +++ b/include/linux/mfd/samsung/core.h
>> @@ -70,6 +70,7 @@ struct sec_pmic_dev {
>> =C2=A0
>> =C2=A0	int device_type;
>> =C2=A0	int irq;
>> +	unsigned int revision;
>
> kerneldoc needs to be updated.

Seems like it needs cleanup anyway, I will send a patch for that
separately (if this patch gets dropped in the next rev, see below).

>
> Given the LED driver is the only driver & device so far which needs the
> PMIC revision, maybe for now that driver could determine the revision
> itself instead of adding this new member for everybody?

Hmm, implementing that would make this patch redundant. I'll do so.

>
> Cheers,
> Andre'
>
>> =C2=A0};
>> =C2=A0
>> =C2=A0struct sec_platform_data {


