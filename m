Return-Path: <linux-pm+bounces-23222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421DA4ACFD
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 18:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D376E18975AF
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7D1E47A9;
	Sat,  1 Mar 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRjk3SAx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87C23F383;
	Sat,  1 Mar 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740848511; cv=none; b=QZVAnIxUq2xel4B36HLMgwWetbKu7RWzxAP0t8aCuOK2ZW4+f5/y7sof3JqrdkWfWt0W7bKlDssJzpuRPoUH64W/2c3G8oiIk8SlavrXPttrT1eSjBbyhsdUd6TCrGz9uVQPO/k2JiLbtPs/3G9giTi93ENBYy4EosA7VkVCKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740848511; c=relaxed/simple;
	bh=Kbeiv5NmwYXQwTc/Blhda4uepZd7xSzOcK2EtIq77w0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bwSE4+541MX9EppOul7b8YEbyNaXLK6z/Z6m7cwTpkaAFyX6IXkqEvQxJz6pD4vOj9qbUgfGZ3m9KjbWO/9rIOr0wm66hNXR24MNsgszdOpagf1JvO/duCgDNlliw66XjRGWfPId11Q+f24s3byMhcmY8ltsor6bHwnhuNWiqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRjk3SAx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso5140765a91.1;
        Sat, 01 Mar 2025 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740848509; x=1741453309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/2X3E+ufEyGacyHRfP/J9mxx/bJpOOjwIZygGFz1oo=;
        b=mRjk3SAxou9u+Oo/OoKw3RhLlI04nwim16rzrK0ZpcFTGIQlhtB6fWrpG3R9F1IlN3
         dOjLXZjSfhbHkH2r4fvF5Rz9YN8uTh4A4M3imfpfWBaxIwdoBXgqkwrnTDqmFJhTDjKp
         UahskqTZHwP31QVvNb5tFYkZFCvSjWjaP+kzlWY3xZKm/tqIFFFQMckQqaLIINlx020t
         ZJO1STC4EVQn91XsdzRXs7wZ/AguijvMAaKK9Jumu3KBbw7Axt1rzLBHvb20RlBQAWD6
         w1NVUXNe5EAwkmaqd+kHyrccKvDp9Mm/xVOzk9h/LwU5+kHuGN+KW5fo9xRG6YOs9jXP
         B4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740848509; x=1741453309;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/2X3E+ufEyGacyHRfP/J9mxx/bJpOOjwIZygGFz1oo=;
        b=eEUreIyBMvipo7wHvg2JyIpWkaURWlZGTeXbJfz1r855fhAlAFwGi4z2bBBpsWNo8i
         GM760G8ikBCXJxXyK/pH+jkPokRKAeX4do13dfSO+8ZiO7W4I2vSZ2L2KJGcTNBRj5ot
         d+hj183ipS1YK27qnxg7M+G4JuX9OybSAG9BULGFvqUc7L06n0/qlfDxvmCT0Iq8qK0m
         epwz3pXaNOcGnTlTp2qzb11vKYv9hW77SaR+X0V66XJ2i2dlEeN0p2u4+8bKiVW+tire
         AczC8agAthhlg9If7B5v+Up8n6AMratHmAkSCo1GGM1MKMZSbXRZcsGTj1KSZb2kc4o0
         cw9g==
X-Forwarded-Encrypted: i=1; AJvYcCV0jJZd9NpUp7HIjF72EnHpvPTd+OPojvX0Z+j6WtAmUwMWA6La0GYApE5h2pHjaUIWWPQmvBENTNE=@vger.kernel.org, AJvYcCVI0njHZiO+aNZhDuKfkYeWssUvUKDYBvzHQzDkqahRsp388y4XDj00tnGSK4ALZLJNDEtk+TTC94M=@vger.kernel.org, AJvYcCXACzN8Ule6kZsghdKBDiBtlwPs4mZ1lXHbsrt8Nt7v5YKC7MhMuzgj7KIiHxpvHVCOW0K8dXZgkSlmvRHAztMoHa5+Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+lzxrdEgxvT4fgyBf+03v82hCR0q/ASjnJrQEBvxV6pOJ6Ub
	FSkI2LOOY6IenJEDFyeiOfvvqehD4cmN06D+mTutUlBdKUYuV16l
X-Gm-Gg: ASbGnctti8L2G+8u4FaEipf0vayLI9POkWDK706gMULCGwSUSn1KDtAC3C6Lg1mS1/W
	yD4P5NCpWNNEqyEO+Mstq77mNH1LEGDc8FkuZTGT0iv8tX5cPpZ+E+mf2zHijfu65v7r0xdCQQP
	f07hl9nz2AZ+OW2jeiqDcqOmvT16UhJx9vVb6WDpJUsS3iunWl/kRsiXMps0Klh5rUN6JGRMI8R
	vmj8U+jK58LQMPez2v0j0YuGa4sBFiGjf9WNqDnuniFb7CT4QWFR8lApaGcmbBTbFtPO4kQ7byS
	RR1+B8FS0NWnZNRvUkkAqxzXGrrfAbB4JaW3uPMeRabGWauSIHI=
X-Google-Smtp-Source: AGHT+IHyO3wrPQCGOPeX5LnNaDczUa1xTdaxB9NgvmydCUW6cwYbJHsEjZfmhFSXX3H6LuhcFdlf1Q==
X-Received: by 2002:a17:90b:3909:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-2febab2ffa0mr11971600a91.2.1740848508543;
        Sat, 01 Mar 2025 09:01:48 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb91:161:844d:ad2:fe52:5203:b867])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b66sm7987062a91.22.2025.03.01.09.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 09:01:48 -0800 (PST)
Date: Sat, 01 Mar 2025 09:01:43 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
CC: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_06/12=5D_hwmon=3A_=28oxp-senso?=
 =?US-ASCII?Q?rs=29_Add_turbo_led_support_to_X1_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAGwozwG6=XZyujL4CMhe8keqw879LNgZC7N+JQ2v8xrB=3KF-Q@mail.gmail.com>
References: <20250222161824.172511-1-lkml@antheas.dev> <20250222161824.172511-7-lkml@antheas.dev> <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com> <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com> <611B4C30-091F-41BC-876C-59314D7F1E5E@gmail.com> <CAGwozwG6=XZyujL4CMhe8keqw879LNgZC7N+JQ2v8xrB=3KF-Q@mail.gmail.com>
Message-ID: <8AA8A9D6-B07E-4D6A-B4A7-EFDA5AF881AD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 1, 2025 8:52:38 AM PST, Antheas Kapenekakis <lkml@antheas=2Edev> =
wrote:
>On Sat, 1 Mar 2025 at 17:42, Derek J=2E Clark <derekjohn=2Eclark@gmail=2E=
com> wrote:
>>
>>
>>
>> On March 1, 2025 7:54:22 AM PST, Antheas Kapenekakis <lkml@antheas=2Ede=
v> wrote:
>> >On Sat, 1 Mar 2025 at 16:14, Derek J=2E Clark <derekjohn=2Eclark@gmail=
=2Ecom> wrote:
>> >>
>> >>
>> >>
>> >> On February 22, 2025 8:18:17 AM PST, Antheas Kapenekakis <lkml@anthe=
as=2Edev> wrote:
>> >> >The X1 and X1 mini lineups feature an LED nested within their turbo
>> >> >button=2E When turbo takeover is not enabled, the turbo button allo=
ws
>> >> >the device to switch from 18W to 25W TDP=2E When the device is in t=
he
>> >> >25W TDP mode, the LED is turned on=2E
>> >> >
>> >> >However, when we engage turbo takeover, the turbo led remains on it=
s
>> >> >last state, which might be illuminated and cannot be currently
>> >> >controlled=2E Therefore, add the register that controls it under sy=
sfs,
>> >> >to allow userspace to turn it off once engaging turbo takeover and
>> >> >then control it as they wish=2E
>> >> >
>> >> >As part of researching this topic, I verified that other OneXPlayer
>> >> >devices do not have a turbo led, which makes this feature only
>> >> >applicable to X1 and X1 mini devices=2E
>> >>
>> >> Antheas,
>> >>
>> >> Do you mean a turbo LED That can be set via EC? OXP devices have had=
 an LED to indicate turbo all the way back to the 1S and mini AMD=2E I'm no=
t sure if they can be set prior to X1, but this is incorrect as posted=2E
>> >
>> >Do not confuse the keyboard LED button with the turbo button=2E The X1
>> >has two LEDs=2E Only the turbo one can be controlled=2E
>> >
>>
>> This would be pretty difficult to do=2E On the 1S it has the text TURBO=
=2E This video shows it at 09:40
>>
>> https://youtu=2Ebe/AYrVKLD2J_k?si=3DbnwwQKY7MdqbbnCY
>>
>> It would be better to just point out that it became configurable on the=
 X1=2E
>
>I asked around and I think the OXP 2, MiniPro, and OneXFly models do
>not have it=2E I can edit the comment and say I added it for the X1=2E
>
>If you have an 1S, can you use rweverything and find the register for it?

Not necessary, 1S EC predates the one they started using in the Mini AMD a=
nd has no configurable options=2E The original mini AMD is also unlikely to=
 support this as only my unit with an experimental BIOS nobody else install=
ed can even do the takeover=2E X1+ should be fine=2E

- Derek

>> >> >Signed-off-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>> >> >---
>> >> > drivers/hwmon/oxp-sensors=2Ec | 84 +++++++++++++++++++++++++++++++=
++++++
>> >> > 1 file changed, 84 insertions(+)
>> >> >
>> >> >diff --git a/drivers/hwmon/oxp-sensors=2Ec b/drivers/hwmon/oxp-sens=
ors=2Ec
>> >> >index 1c01636582d7=2E=2E9c43ec0fc994 100644
>> >> >--- a/drivers/hwmon/oxp-sensors=2Ec
>> >> >+++ b/drivers/hwmon/oxp-sensors=2Ec
>> >> >@@ -101,6 +101,12 @@ static enum oxp_board board;
>> >> >  */
>> >> > #define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
>> >> >
>> >> >+/* X1 Turbo LED */
>> >> >+#define OXP_X1_TURBO_LED_REG           0x57
>> >> >+
>> >> >+#define OXP_X1_TURBO_LED_OFF           0x01
>> >> >+#define OXP_X1_TURBO_LED_ON            0x02
>> >> >+
>> >>
>> >> Not a blocker for me on this series, but we should consider looking =
at creating some enums in the future to capture functionality in a more con=
cise way=2E There are quite a few define's at this point and enums offer a =
little bit of value validation=2E
>> >
>> >There should probably be a refactor in the future=2E Yes=2E I would te=
nd
>> >towards using a driver struct=2E=2E=2E
>> >
>> >> > enum charge_type_value_index {
>> >> >       CT_OFF,
>> >> >       CT_S0,
>> >> >@@ -466,6 +472,73 @@ static ssize_t tt_toggle_show(struct device *d=
ev,
>> >> >
>> >> > static DEVICE_ATTR_RW(tt_toggle);
>> >> >
>> >> >+/* Callbacks for turbo toggle attribute */
>> >> >+static umode_t tt_led_is_visible(struct kobject *kobj,
>> >> >+                                  struct attribute *attr, int n)
>> >> >+{
>> >> >+      switch (board) {
>> >> >+      case oxp_x1:
>> >> >+              return attr->mode;
>> >> >+      default:
>> >> >+              break;
>> >> >+      }
>> >> >+      return 0;
>> >> >+}
>> >> >+
>> >> >+static ssize_t tt_led_store(struct device *dev,
>> >> >+                             struct device_attribute *attr, const =
char *buf,
>> >> >+                             size_t count)
>> >> >+{
>> >> >+      u8 reg, val;
>> >> >+      int rval;
>> >> >+      bool value;
>> >> >+
>> >> >+      rval =3D kstrtobool(buf, &value);
>> >> >+      if (rval)
>> >> >+              return rval;
>> >> >+
>> >> >+      switch (board) {
>> >> >+      case oxp_x1:
>> >> >+              reg =3D OXP_X1_TURBO_LED_REG;
>> >> >+              val =3D value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_L=
ED_OFF;
>> >> >+              break;
>> >> >+      default:
>> >> >+              return -EINVAL;
>> >> >+      }
>> >> >+      rval =3D write_to_ec(reg, val);
>> >> >+
>> >> >+      if (rval)
>> >> >+              return rval;
>> >> >+
>> >> >+      return count;
>> >> >+}
>> >> >+
>> >> >+static ssize_t tt_led_show(struct device *dev,
>> >> >+                            struct device_attribute *attr, char *b=
uf)
>> >> >+{
>> >> >+      int retval;
>> >> >+      u8 reg;
>> >> >+      long enval;
>> >> >+      long val;
>> >> >+
>> >> >+      switch (board) {
>> >> >+      case oxp_x1:
>> >> >+              reg =3D OXP_2_TURBO_SWITCH_REG;
>> >> >+              enval =3D OXP_X1_TURBO_LED_ON;
>> >> >+              break;
>> >> >+      default:
>> >> >+              return -EINVAL;
>> >> >+      }
>> >> >+
>> >> >+      retval =3D read_from_ec(reg, 1, &val);
>> >> >+      if (retval)
>> >> >+              return retval;
>> >> >+
>> >> >+      return sysfs_emit(buf, "%d\n", val =3D=3D enval);
>> >> >+}
>> >> >+
>> >> >+static DEVICE_ATTR_RW(tt_led);
>> >> >+
>> >> > /* Callbacks for turbo toggle attribute */
>> >> > static bool charge_control_supported(void)
>> >> > {
>> >> >@@ -894,8 +967,19 @@ static struct attribute_group oxp_tt_toggle_at=
tribute_group =3D {
>> >> >       =2Eattrs =3D oxp_tt_toggle_attrs,
>> >> > };
>> >> >
>> >> >+static struct attribute *oxp_tt_led_attrs[] =3D {
>> >> >+      &dev_attr_tt_led=2Eattr,
>> >> >+      NULL
>> >> >+};
>> >> >+
>> >> >+static struct attribute_group oxp_tt_led_attribute_group =3D {
>> >> >+      =2Eis_visible =3D tt_led_is_visible,
>> >> >+      =2Eattrs =3D oxp_tt_led_attrs,
>> >> >+};
>> >> >+
>> >> > static const struct attribute_group *oxp_ec_groups[] =3D {
>> >> >       &oxp_tt_toggle_attribute_group,
>> >> >+      &oxp_tt_led_attribute_group,
>> >> >       NULL
>> >> > };
>> >> >
>> >> - Derek
>>
>> - Derek

