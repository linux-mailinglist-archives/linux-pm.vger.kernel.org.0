Return-Path: <linux-pm+bounces-23216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB9A4AC7E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE861897396
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D31DF974;
	Sat,  1 Mar 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK0rOdXA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83A22F19;
	Sat,  1 Mar 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740841998; cv=none; b=IrhOyzn4e1e2Kayn8aCbnDkEh2LiYv1W6Z/oGEHOSYFz1z0MfVcuICzjKzuVAn7Qe/UHYgZtaqYp1If9LSCV/bXQ/uvghQ2sbWqSZpQ0q5z4YNdLjG88fr75suybLAGbt05FM71t0iCey4Q/r0aJTlZ+Yw6wRkwhDbPL/BoHPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740841998; c=relaxed/simple;
	bh=RJfTnQpAz/RRRgszJiQUnFupQrKNtHysMMEQP63QBaM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nVJwmL5qNOjK0Gm9YVdHIwUS/hbFSdFTFN6zf8US3kDuT2NC90W4GET1284BHzs+wWGwclhbVemp26RICbUjk+ZQSUyKUHFLDqdovv8MDp245ffxeSsj1MKKBVfrgnvhcO1AZmixvjQUuPXBw/MiO0M5wRUZqa4zAcDrdUF6QfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK0rOdXA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349dc31bcso56304625ad.3;
        Sat, 01 Mar 2025 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740841996; x=1741446796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODIcGwRHRh6aQTwwRIZoOJAusC4ghvwZIA6N5D8WLr8=;
        b=LK0rOdXAI7kQ7YaZp8nn/uZNBo2IlhYamXr6XrXqjMYudvgdj5YNjg5j++DhxMyr8w
         ipeNRsulIJO/Ea++cP6pKWocTXAMGPeh5B6XSEVB/A8D3uuhp60hD58jsWI1HS4Mt7zq
         tyXHZgSxY8CrKQPIeRSOGea54Y7gmME2BNh2abFRbPsVx3PQy1yS2bqxT0U2qzhZ+kO8
         mOiP4lBnOTucld+9Mx378UVvPeIiLNvl+rVUHtFCDjqqbRTcllyjiuYjgF61r4YUZIqm
         xPxsORbHMaQotE9eGavbsnJ/+cmdzXjsVpeeB/CtqSbBeiDBB4zbXL7JePFzhIWpstCV
         uMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740841996; x=1741446796;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODIcGwRHRh6aQTwwRIZoOJAusC4ghvwZIA6N5D8WLr8=;
        b=hgqLHzaXdxQG54gBL+rTkVJ3sBQ+4rT44sAktX6b7dzW4m+EAA0I8vOLwkG/viA5+A
         tTnJJ5frc1uRjpU92v6axQbRN5+W9eeav7IZp7Bv2Ex9FbmhYnQkp3Pi7ogn4dzFP1rr
         9/H2f57/jlM/X1r5RCJtt/oZagKJE7iWWNJaqDjomSwYUmaRchU9T1sisqV97WsxmQOr
         dpv1RyLCtso/jPVPRzqQz79ubz8HB4XlnopLhlZTgNtMCY2Qsyi7ww38KSgJ+52LxWcB
         9bj45JVXxGfyAy1dSvpqZyCZDuwgOrfK+3ODfSHRA6kOCM44+JtpoIsTeuOIAUsg3gu8
         cMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mlQzYDFS3wtopEft3ye/KAOyhX+3QovoHs1hmcT7xZm82hgKrzPIhVKWaqk7nRlnYoswdZMOQ74=@vger.kernel.org, AJvYcCWGnltBaFVaeyhlIx9Kd9arYXAVh5vfm9xWvROfC48HepPBXItB5aOLmO5HzJqbSBqC9f/gzKNFzwFIQA==@vger.kernel.org, AJvYcCXT+mAUdRSPayR8alb0hMl3kxWVEI8SZhrcOZmJV4fLx7BLzImQsDrFmIhrqhTn1yyKXsqgzvfB5Foi0Ppa8l3QJYcI+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZU45sevHbFZwblEpU85WKzFGrQ3PFiQ9SMqBnmQeoQQ3CbYta
	0BO+BrOHHr4WAgR1W+C8HA4YweSzlwySqXl8nHkavRi6zBHlLwFv
X-Gm-Gg: ASbGncuppQuhLxFFQSvXJuQtxk9L+Epy2movuQBIIHAJKLxZ3nTi022mGfhIwAoEOyX
	oS6l9AehsOWi+zrngzZQbLiRUoBB87X7zVZbDksnRkfHkAEKv1ItXwKZxykkX3tk7fw3axtekzV
	bEPFNpUSIX8QDtrqc4AuRLR187DTP2BnhKpuF0zEd/iwMTPdBlKpl0nqUcfg1sSChDd2O+4S6xf
	KZR9UMMjzGjw9X/+z878mhnCVNON0IOzDnO8rqwZbg0O+D7mwvTRL3b5bjEJ7SMGH0nGAfreJM3
	i9na29YhqzMlWwEyoIqSTiySExCsoffkJGvmBXAWLqaX0KddH7k=
X-Google-Smtp-Source: AGHT+IFor2fMv5zICiAM1CbtTznLv0RxTOK03VURXaSuAYkuaNZDW3IBgNDc749CiGJodiRFgcAjiA==
X-Received: by 2002:a17:903:32cf:b0:223:4ddd:bcdb with SMTP id d9443c01a7336-22368f9580fmr114769075ad.19.1740841995676;
        Sat, 01 Mar 2025 07:13:15 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb91:161:844d:ad2:fe52:5203:b867])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm5780083b3a.132.2025.03.01.07.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 07:13:15 -0800 (PST)
Date: Sat, 01 Mar 2025 07:13:12 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-hwmon@vger.kernel.org
CC: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_06/12=5D_hwmon=3A_=28oxp-senso?=
 =?US-ASCII?Q?rs=29_Add_turbo_led_support_to_X1_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250222161824.172511-7-lkml@antheas.dev>
References: <20250222161824.172511-1-lkml@antheas.dev> <20250222161824.172511-7-lkml@antheas.dev>
Message-ID: <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 22, 2025 8:18:17 AM PST, Antheas Kapenekakis <lkml@antheas=2Ed=
ev> wrote:
>The X1 and X1 mini lineups feature an LED nested within their turbo
>button=2E When turbo takeover is not enabled, the turbo button allows
>the device to switch from 18W to 25W TDP=2E When the device is in the
>25W TDP mode, the LED is turned on=2E
>
>However, when we engage turbo takeover, the turbo led remains on its
>last state, which might be illuminated and cannot be currently
>controlled=2E Therefore, add the register that controls it under sysfs,
>to allow userspace to turn it off once engaging turbo takeover and
>then control it as they wish=2E
>
>As part of researching this topic, I verified that other OneXPlayer
>devices do not have a turbo led, which makes this feature only
>applicable to X1 and X1 mini devices=2E

Antheas,

Do you mean a turbo LED That can be set via EC? OXP devices have had an LE=
D to indicate turbo all the way back to the 1S and mini AMD=2E I'm not sure=
 if they can be set prior to X1, but this is incorrect as posted=2E

>Signed-off-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>---
> drivers/hwmon/oxp-sensors=2Ec | 84 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 84 insertions(+)
>
>diff --git a/drivers/hwmon/oxp-sensors=2Ec b/drivers/hwmon/oxp-sensors=2E=
c
>index 1c01636582d7=2E=2E9c43ec0fc994 100644
>--- a/drivers/hwmon/oxp-sensors=2Ec
>+++ b/drivers/hwmon/oxp-sensors=2Ec
>@@ -101,6 +101,12 @@ static enum oxp_board board;
>  */
> #define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
>=20
>+/* X1 Turbo LED */
>+#define OXP_X1_TURBO_LED_REG           0x57
>+
>+#define OXP_X1_TURBO_LED_OFF           0x01
>+#define OXP_X1_TURBO_LED_ON            0x02
>+

Not a blocker for me on this series, but we should consider looking at cre=
ating some enums in the future to capture functionality in a more concise w=
ay=2E There are quite a few define's at this point and enums offer a little=
 bit of value validation=2E

> enum charge_type_value_index {
> 	CT_OFF,
> 	CT_S0,
>@@ -466,6 +472,73 @@ static ssize_t tt_toggle_show(struct device *dev,
>=20
> static DEVICE_ATTR_RW(tt_toggle);
>=20
>+/* Callbacks for turbo toggle attribute */
>+static umode_t tt_led_is_visible(struct kobject *kobj,
>+				    struct attribute *attr, int n)
>+{
>+	switch (board) {
>+	case oxp_x1:
>+		return attr->mode;
>+	default:
>+		break;
>+	}
>+	return 0;
>+}
>+
>+static ssize_t tt_led_store(struct device *dev,
>+			       struct device_attribute *attr, const char *buf,
>+			       size_t count)
>+{
>+	u8 reg, val;
>+	int rval;
>+	bool value;
>+
>+	rval =3D kstrtobool(buf, &value);
>+	if (rval)
>+		return rval;
>+
>+	switch (board) {
>+	case oxp_x1:
>+		reg =3D OXP_X1_TURBO_LED_REG;
>+		val =3D value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+	rval =3D write_to_ec(reg, val);
>+
>+	if (rval)
>+		return rval;
>+
>+	return count;
>+}
>+
>+static ssize_t tt_led_show(struct device *dev,
>+			      struct device_attribute *attr, char *buf)
>+{
>+	int retval;
>+	u8 reg;
>+	long enval;
>+	long val;
>+
>+	switch (board) {
>+	case oxp_x1:
>+		reg =3D OXP_2_TURBO_SWITCH_REG;
>+		enval =3D OXP_X1_TURBO_LED_ON;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	retval =3D read_from_ec(reg, 1, &val);
>+	if (retval)
>+		return retval;
>+
>+	return sysfs_emit(buf, "%d\n", val =3D=3D enval);
>+}
>+
>+static DEVICE_ATTR_RW(tt_led);
>+
> /* Callbacks for turbo toggle attribute */
> static bool charge_control_supported(void)
> {
>@@ -894,8 +967,19 @@ static struct attribute_group oxp_tt_toggle_attribut=
e_group =3D {
> 	=2Eattrs =3D oxp_tt_toggle_attrs,
> };
>=20
>+static struct attribute *oxp_tt_led_attrs[] =3D {
>+	&dev_attr_tt_led=2Eattr,
>+	NULL
>+};
>+
>+static struct attribute_group oxp_tt_led_attribute_group =3D {
>+	=2Eis_visible =3D tt_led_is_visible,
>+	=2Eattrs =3D oxp_tt_led_attrs,
>+};
>+
> static const struct attribute_group *oxp_ec_groups[] =3D {
> 	&oxp_tt_toggle_attribute_group,
>+	&oxp_tt_led_attribute_group,
> 	NULL
> };
>=20
- Derek

