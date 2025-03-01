Return-Path: <linux-pm+bounces-23220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88FA4ACE4
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 17:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B7916A1D7
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708191DF986;
	Sat,  1 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXFEe1jw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADA157A6B;
	Sat,  1 Mar 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847274; cv=none; b=fOL9s7qzTqJ/743KMXZOsjg8IKjJYvFVkZCKVurBs8zKqxL0lSgfR/qalTNRbjAefwXlEfd0qNkkYucTJrTpCsplzg+ob+nvAO+h7k6SIANvu9dxteENvcd5fQGy0npU8rVV66ORRbSvIibtCQNpFmQUi01BRzBFZsGtJvbGTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847274; c=relaxed/simple;
	bh=TPGLOfhPKFHuWO6v+WVIGLlZyWZwj2s0MJ3khkVAP90=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HOY9tQ92WmQZvJM43lThu1lsFF7uWPXbvzOhTTtHzbYZ1NOZNkTH7bJeI9OLr49hThkDgz5p7bUMcaJsaOd07aVUJ8qH6Mel6YWSHeszKzFEadM+GmWY+StG2Nbf2IzF+9dFphSfvfgmi++j6gRIkqA6tPJ3NmFOTtB76spxHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXFEe1jw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22339936bbfso47070155ad.1;
        Sat, 01 Mar 2025 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740847272; x=1741452072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNY8iykVmTHciG8sQ3c71EAHhWBg8n+6+aPGU9wjfCc=;
        b=RXFEe1jwKIaORMmNoJZ18SrYIrRymmAVZplLuNbW4U04cQ9VqXA9JVRYnKOu9hYkGn
         v8denJphRcIWR9HT6bbzB+w4I8GCavyEcN0TWiXy7eKgWCan5/L2wzBRDBKm2Z/taTKP
         u8WspMEmFN7KAodKtuQQDRkC7P59OiUFLvyJV4RVekSYcrhqtTl5tlVU3/2NkHxoXFgW
         HvSxk+tjmKogPOJM/S1o8qQx1YZq7SYbfOHU9vEq7xeVVBorttZoCf5uboa10LULWLuI
         3YeYtxaA3NDBXavodz/NQCp0yYGNGxVbq1+p8mkSvqLz/YuS8pZ6c4dhNSasmQCkKe0D
         CJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847272; x=1741452072;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNY8iykVmTHciG8sQ3c71EAHhWBg8n+6+aPGU9wjfCc=;
        b=HgVfj/1TNDx2JUCPQ6MWQi6DGVdAtDElp7j7Gdd6duxFK6xTIMCEfLhDt1zsQ8z7Yn
         D+cRBovtmVa3X/GsB4s2skKbTUjkRiBXbg278CB2xCOz5+2JTfo2HcBfyiAcbAzwaTjH
         tutvDgwbPz4vcQGOxxjIqCP8neNq9rK3MaOINXMRyas137JA1c0ZLbvCHb779URAH0oA
         GrKKgHBn3FSx0aYlSs6SxF64ZeuEkOiT1yTfVZYt4cZxjW317GxMuGWPwLErqBjiYOKe
         4cULz9wBNVCsMVkzDPy9WYW4rpDmt3H0Ysy/6kCQbYy1R0w722oHfNq7j6+Bp06A2pt0
         DikQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJarSNbclkHmFLZ0mF6Qk+OADL6o6tBpl8SZfeDgCY352Gs/fUtV1r55rFTxtZqegEZbxF6PVgzE8=@vger.kernel.org, AJvYcCUaUIcgSQaYVOK2sw3RL62lxkm3vfw2oTpNgTMlUrX9KYfoFtNWUomnHIYrCTvXn7yzscJSku//v4IiEtZiOQMAoXtxyw==@vger.kernel.org, AJvYcCWsBD5s5Kr2rEGQSqcME4AC2tjH2h5jyvQHg+6nECweYU0vTbyILm61RDOIDsZJNO4HeyL5g6IA9tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN32oBW9JNymHQcLGoXVVNMAcfrZb0rZwCzVs0cNUw2uhjht/Z
	UBYzH884jRln3lkpTLh8Hqe7tikoOFY7pIR9XgVPt7Xmu+iEHilU
X-Gm-Gg: ASbGnctAMWd0LJfOc/RGI+Rcljq3aAADwRuolTrdUpwquMNFhfSb+Ai8JCSr/jU5ext
	6wT6vtVsTJQqnADYQnDmC/ExwxmlPr3jSbJrW8BvI/saDwnvgqsNS6/gkjQofw1DmQ5EnEOe3c9
	Q+UGTsw70YTnXhX2IBqzluMer5kFu4O13ploQLS3QVYDbITCi/hrf0Utn28H1WMZscPRKWGDtvh
	9dLszrP9bvzn4D9JDMvbRx+7SSnwVn4WBA4wEzGcKPIXggY6Q2fRH0kKdsKP8Cx710WhZdJQQZj
	t74/H3ODe32t3zw3GppvEGBEuuPVFY4/boayO1YUnrlQgYlg/OQ=
X-Google-Smtp-Source: AGHT+IFX7mjzDy/1O1JzQZlKiw8E0u/wLjW85gGqI4XSoZzxxntcgqJpBq67ViNKlhEpvsZqLvJ1AA==
X-Received: by 2002:a17:903:1790:b0:215:9894:5670 with SMTP id d9443c01a7336-22368f9d1acmr117373745ad.16.1740847271979;
        Sat, 01 Mar 2025 08:41:11 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb91:161:844d:ad2:fe52:5203:b867])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5a69sm50272285ad.120.2025.03.01.08.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 08:41:11 -0800 (PST)
Date: Sat, 01 Mar 2025 08:13:54 -0800
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
In-Reply-To: <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com>
References: <20250222161824.172511-1-lkml@antheas.dev> <20250222161824.172511-7-lkml@antheas.dev> <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com> <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com>
Message-ID: <611B4C30-091F-41BC-876C-59314D7F1E5E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 1, 2025 7:54:22 AM PST, Antheas Kapenekakis <lkml@antheas=2Edev> =
wrote:
>On Sat, 1 Mar 2025 at 16:14, Derek J=2E Clark <derekjohn=2Eclark@gmail=2E=
com> wrote:
>>
>>
>>
>> On February 22, 2025 8:18:17 AM PST, Antheas Kapenekakis <lkml@antheas=
=2Edev> wrote:
>> >The X1 and X1 mini lineups feature an LED nested within their turbo
>> >button=2E When turbo takeover is not enabled, the turbo button allows
>> >the device to switch from 18W to 25W TDP=2E When the device is in the
>> >25W TDP mode, the LED is turned on=2E
>> >
>> >However, when we engage turbo takeover, the turbo led remains on its
>> >last state, which might be illuminated and cannot be currently
>> >controlled=2E Therefore, add the register that controls it under sysfs=
,
>> >to allow userspace to turn it off once engaging turbo takeover and
>> >then control it as they wish=2E
>> >
>> >As part of researching this topic, I verified that other OneXPlayer
>> >devices do not have a turbo led, which makes this feature only
>> >applicable to X1 and X1 mini devices=2E
>>
>> Antheas,
>>
>> Do you mean a turbo LED That can be set via EC? OXP devices have had an=
 LED to indicate turbo all the way back to the 1S and mini AMD=2E I'm not s=
ure if they can be set prior to X1, but this is incorrect as posted=2E
>
>Do not confuse the keyboard LED button with the turbo button=2E The X1
>has two LEDs=2E Only the turbo one can be controlled=2E
>

This would be pretty difficult to do=2E On the 1S it has the text TURBO=2E=
 This video shows it at 09:40

https://youtu=2Ebe/AYrVKLD2J_k?si=3DbnwwQKY7MdqbbnCY

It would be better to just point out that it became configurable on the X1=
=2E

>> >Signed-off-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>> >---
>> > drivers/hwmon/oxp-sensors=2Ec | 84 ++++++++++++++++++++++++++++++++++=
+++
>> > 1 file changed, 84 insertions(+)
>> >
>> >diff --git a/drivers/hwmon/oxp-sensors=2Ec b/drivers/hwmon/oxp-sensors=
=2Ec
>> >index 1c01636582d7=2E=2E9c43ec0fc994 100644
>> >--- a/drivers/hwmon/oxp-sensors=2Ec
>> >+++ b/drivers/hwmon/oxp-sensors=2Ec
>> >@@ -101,6 +101,12 @@ static enum oxp_board board;
>> >  */
>> > #define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
>> >
>> >+/* X1 Turbo LED */
>> >+#define OXP_X1_TURBO_LED_REG           0x57
>> >+
>> >+#define OXP_X1_TURBO_LED_OFF           0x01
>> >+#define OXP_X1_TURBO_LED_ON            0x02
>> >+
>>
>> Not a blocker for me on this series, but we should consider looking at =
creating some enums in the future to capture functionality in a more concis=
e way=2E There are quite a few define's at this point and enums offer a lit=
tle bit of value validation=2E
>
>There should probably be a refactor in the future=2E Yes=2E I would tend
>towards using a driver struct=2E=2E=2E
>
>> > enum charge_type_value_index {
>> >       CT_OFF,
>> >       CT_S0,
>> >@@ -466,6 +472,73 @@ static ssize_t tt_toggle_show(struct device *dev,
>> >
>> > static DEVICE_ATTR_RW(tt_toggle);
>> >
>> >+/* Callbacks for turbo toggle attribute */
>> >+static umode_t tt_led_is_visible(struct kobject *kobj,
>> >+                                  struct attribute *attr, int n)
>> >+{
>> >+      switch (board) {
>> >+      case oxp_x1:
>> >+              return attr->mode;
>> >+      default:
>> >+              break;
>> >+      }
>> >+      return 0;
>> >+}
>> >+
>> >+static ssize_t tt_led_store(struct device *dev,
>> >+                             struct device_attribute *attr, const cha=
r *buf,
>> >+                             size_t count)
>> >+{
>> >+      u8 reg, val;
>> >+      int rval;
>> >+      bool value;
>> >+
>> >+      rval =3D kstrtobool(buf, &value);
>> >+      if (rval)
>> >+              return rval;
>> >+
>> >+      switch (board) {
>> >+      case oxp_x1:
>> >+              reg =3D OXP_X1_TURBO_LED_REG;
>> >+              val =3D value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_=
OFF;
>> >+              break;
>> >+      default:
>> >+              return -EINVAL;
>> >+      }
>> >+      rval =3D write_to_ec(reg, val);
>> >+
>> >+      if (rval)
>> >+              return rval;
>> >+
>> >+      return count;
>> >+}
>> >+
>> >+static ssize_t tt_led_show(struct device *dev,
>> >+                            struct device_attribute *attr, char *buf)
>> >+{
>> >+      int retval;
>> >+      u8 reg;
>> >+      long enval;
>> >+      long val;
>> >+
>> >+      switch (board) {
>> >+      case oxp_x1:
>> >+              reg =3D OXP_2_TURBO_SWITCH_REG;
>> >+              enval =3D OXP_X1_TURBO_LED_ON;
>> >+              break;
>> >+      default:
>> >+              return -EINVAL;
>> >+      }
>> >+
>> >+      retval =3D read_from_ec(reg, 1, &val);
>> >+      if (retval)
>> >+              return retval;
>> >+
>> >+      return sysfs_emit(buf, "%d\n", val =3D=3D enval);
>> >+}
>> >+
>> >+static DEVICE_ATTR_RW(tt_led);
>> >+
>> > /* Callbacks for turbo toggle attribute */
>> > static bool charge_control_supported(void)
>> > {
>> >@@ -894,8 +967,19 @@ static struct attribute_group oxp_tt_toggle_attri=
bute_group =3D {
>> >       =2Eattrs =3D oxp_tt_toggle_attrs,
>> > };
>> >
>> >+static struct attribute *oxp_tt_led_attrs[] =3D {
>> >+      &dev_attr_tt_led=2Eattr,
>> >+      NULL
>> >+};
>> >+
>> >+static struct attribute_group oxp_tt_led_attribute_group =3D {
>> >+      =2Eis_visible =3D tt_led_is_visible,
>> >+      =2Eattrs =3D oxp_tt_led_attrs,
>> >+};
>> >+
>> > static const struct attribute_group *oxp_ec_groups[] =3D {
>> >       &oxp_tt_toggle_attribute_group,
>> >+      &oxp_tt_led_attribute_group,
>> >       NULL
>> > };
>> >
>> - Derek

- Derek

