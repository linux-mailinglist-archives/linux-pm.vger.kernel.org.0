Return-Path: <linux-pm+bounces-23221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12357A4ACEF
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 17:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB87A7C8E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF551E2007;
	Sat,  1 Mar 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NQZf2PaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AE1BC4E;
	Sat,  1 Mar 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847977; cv=none; b=DlW6IuL88NYxDR+ISWEYrWgmlZNradxXMPYtJK0QGvnbrwCIQkQE/h5jN88vE7rqGq/B6aSQDyBddvhH/Ytd/2/BIVdK8w9t9W10VtLsCj6GGRpAnxrcaONhmreyAwhZBbyKuQOkRMmia3K8bxoaIVE/5f3tyJR+RNJu9rLkPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847977; c=relaxed/simple;
	bh=EtH6s5jgHBHpq+UeSpVmwS2IVll6p+F7gfz3idKWJes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3WN1ue42bkNh3WduHxpnZqT+joAHoIctAcAXBwPk4DogoxuRppA6s376MAieYiQkIxbsjwYSHVCny+6sFNv9/jS8spukePk5/qVKnwOCjtim/XUjfpItnzRhWCSwD0zGRfm4Daf71COnHeVagYuA/h2XIn3u8PCvlqZOsoCCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NQZf2PaV; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3B5412E091F6;
	Sat,  1 Mar 2025 18:52:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740847970;
	bh=/K+9yPV0rVI1Pu6RNGxoSlQNZJd9C3fezbM3H7s5WvY=;
	h=Received:From:Subject:To;
	b=NQZf2PaVT/ggTRC3lKb7OWk+4oNQzs7qlJhejIK+YkxKnU3T1tUqxQViPrWLmG50w
	 5bGPrzJ9sZOSbOboJcuAmZMeB5EEKg7irtovduGpGlKUM+lERS757zEwabo/LOeNMO
	 IQcBZ/hqkIPnpRWn2z1PdBN9kPIVWjfSpkKjgyHU=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-30baa27b209so3574691fa.0;
        Sat, 01 Mar 2025 08:52:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUOSb1Q3FKSVYBT4TDKUhZxJiTSSPfQRArqTuXcIFnpVfl9346PGYEm7qSIQc6F/vZ4/BqHo/vq742xAF5uEl60c6FOCw==@vger.kernel.org,
 AJvYcCVHCKcqeMfF4tepflqckRXc/wU8MSidCaypakkABECiNTVrzzTSQSmpOmHjMfk7AggE9UWsYNOwjVg=@vger.kernel.org,
 AJvYcCWJbRr/CAGT0Fw2gPeGCAJQdReeihcyJUaRtPq6d1TUKInEjfpYdA2iMrm1PCI5iepYxmCubEc10DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhj8OZsv68FaHuiHY42xDPsN6CePuC8qMYN06O1XzXyd/hRb1l
	uyNXBqCJIdPEx3DMSR/cDwZZLmvdsBVEVmWgfTedPF+vyVUVqiYFhQRuyLgk1zMeQaZbR4XoUr4
	DCXqSdAWPoOWfiMvdAcvkjZ7n/Kc=
X-Google-Smtp-Source: 
 AGHT+IGDs1MaRpOD4AHlBaR6b11hPeTB4lBrJBLU1S1N7P+E76x9HIXGgOF4b+S8s6+e/C1FkMeFtPjtI+J870dkMdY=
X-Received: by 2002:a2e:8759:0:b0:308:fa1d:1fed with SMTP id
 38308e7fff4ca-30b9345c27cmr26104851fa.34.1740847969510; Sat, 01 Mar 2025
 08:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222161824.172511-1-lkml@antheas.dev>
 <20250222161824.172511-7-lkml@antheas.dev>
 <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com>
 <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com>
 <611B4C30-091F-41BC-876C-59314D7F1E5E@gmail.com>
In-Reply-To: <611B4C30-091F-41BC-876C-59314D7F1E5E@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 17:52:38 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG6=XZyujL4CMhe8keqw879LNgZC7N+JQ2v8xrB=3KF-Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqSrC9X_VlRK5MW4MhIH3hSTUoP-RMmD5bTnoEKbVGQGkY0J_nyOctr8tg
Message-ID: 
 <CAGwozwG6=XZyujL4CMhe8keqw879LNgZC7N+JQ2v8xrB=3KF-Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] hwmon: (oxp-sensors) Add turbo led support to X1
 devices
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <174084797066.436.7521568956309165847@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 17:42, Derek J. Clark <derekjohn.clark@gmail.com> wrote:
>
>
>
> On March 1, 2025 7:54:22 AM PST, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >On Sat, 1 Mar 2025 at 16:14, Derek J. Clark <derekjohn.clark@gmail.com> wrote:
> >>
> >>
> >>
> >> On February 22, 2025 8:18:17 AM PST, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >> >The X1 and X1 mini lineups feature an LED nested within their turbo
> >> >button. When turbo takeover is not enabled, the turbo button allows
> >> >the device to switch from 18W to 25W TDP. When the device is in the
> >> >25W TDP mode, the LED is turned on.
> >> >
> >> >However, when we engage turbo takeover, the turbo led remains on its
> >> >last state, which might be illuminated and cannot be currently
> >> >controlled. Therefore, add the register that controls it under sysfs,
> >> >to allow userspace to turn it off once engaging turbo takeover and
> >> >then control it as they wish.
> >> >
> >> >As part of researching this topic, I verified that other OneXPlayer
> >> >devices do not have a turbo led, which makes this feature only
> >> >applicable to X1 and X1 mini devices.
> >>
> >> Antheas,
> >>
> >> Do you mean a turbo LED That can be set via EC? OXP devices have had an LED to indicate turbo all the way back to the 1S and mini AMD. I'm not sure if they can be set prior to X1, but this is incorrect as posted.
> >
> >Do not confuse the keyboard LED button with the turbo button. The X1
> >has two LEDs. Only the turbo one can be controlled.
> >
>
> This would be pretty difficult to do. On the 1S it has the text TURBO. This video shows it at 09:40
>
> https://youtu.be/AYrVKLD2J_k?si=bnwwQKY7MdqbbnCY
>
> It would be better to just point out that it became configurable on the X1.

I asked around and I think the OXP 2, MiniPro, and OneXFly models do
not have it. I can edit the comment and say I added it for the X1.

If you have an 1S, can you use rweverything and find the register for it?

> >> >Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> >---
> >> > drivers/hwmon/oxp-sensors.c | 84 +++++++++++++++++++++++++++++++++++++
> >> > 1 file changed, 84 insertions(+)
> >> >
> >> >diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> >> >index 1c01636582d7..9c43ec0fc994 100644
> >> >--- a/drivers/hwmon/oxp-sensors.c
> >> >+++ b/drivers/hwmon/oxp-sensors.c
> >> >@@ -101,6 +101,12 @@ static enum oxp_board board;
> >> >  */
> >> > #define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
> >> >
> >> >+/* X1 Turbo LED */
> >> >+#define OXP_X1_TURBO_LED_REG           0x57
> >> >+
> >> >+#define OXP_X1_TURBO_LED_OFF           0x01
> >> >+#define OXP_X1_TURBO_LED_ON            0x02
> >> >+
> >>
> >> Not a blocker for me on this series, but we should consider looking at creating some enums in the future to capture functionality in a more concise way. There are quite a few define's at this point and enums offer a little bit of value validation.
> >
> >There should probably be a refactor in the future. Yes. I would tend
> >towards using a driver struct...
> >
> >> > enum charge_type_value_index {
> >> >       CT_OFF,
> >> >       CT_S0,
> >> >@@ -466,6 +472,73 @@ static ssize_t tt_toggle_show(struct device *dev,
> >> >
> >> > static DEVICE_ATTR_RW(tt_toggle);
> >> >
> >> >+/* Callbacks for turbo toggle attribute */
> >> >+static umode_t tt_led_is_visible(struct kobject *kobj,
> >> >+                                  struct attribute *attr, int n)
> >> >+{
> >> >+      switch (board) {
> >> >+      case oxp_x1:
> >> >+              return attr->mode;
> >> >+      default:
> >> >+              break;
> >> >+      }
> >> >+      return 0;
> >> >+}
> >> >+
> >> >+static ssize_t tt_led_store(struct device *dev,
> >> >+                             struct device_attribute *attr, const char *buf,
> >> >+                             size_t count)
> >> >+{
> >> >+      u8 reg, val;
> >> >+      int rval;
> >> >+      bool value;
> >> >+
> >> >+      rval = kstrtobool(buf, &value);
> >> >+      if (rval)
> >> >+              return rval;
> >> >+
> >> >+      switch (board) {
> >> >+      case oxp_x1:
> >> >+              reg = OXP_X1_TURBO_LED_REG;
> >> >+              val = value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
> >> >+              break;
> >> >+      default:
> >> >+              return -EINVAL;
> >> >+      }
> >> >+      rval = write_to_ec(reg, val);
> >> >+
> >> >+      if (rval)
> >> >+              return rval;
> >> >+
> >> >+      return count;
> >> >+}
> >> >+
> >> >+static ssize_t tt_led_show(struct device *dev,
> >> >+                            struct device_attribute *attr, char *buf)
> >> >+{
> >> >+      int retval;
> >> >+      u8 reg;
> >> >+      long enval;
> >> >+      long val;
> >> >+
> >> >+      switch (board) {
> >> >+      case oxp_x1:
> >> >+              reg = OXP_2_TURBO_SWITCH_REG;
> >> >+              enval = OXP_X1_TURBO_LED_ON;
> >> >+              break;
> >> >+      default:
> >> >+              return -EINVAL;
> >> >+      }
> >> >+
> >> >+      retval = read_from_ec(reg, 1, &val);
> >> >+      if (retval)
> >> >+              return retval;
> >> >+
> >> >+      return sysfs_emit(buf, "%d\n", val == enval);
> >> >+}
> >> >+
> >> >+static DEVICE_ATTR_RW(tt_led);
> >> >+
> >> > /* Callbacks for turbo toggle attribute */
> >> > static bool charge_control_supported(void)
> >> > {
> >> >@@ -894,8 +967,19 @@ static struct attribute_group oxp_tt_toggle_attribute_group = {
> >> >       .attrs = oxp_tt_toggle_attrs,
> >> > };
> >> >
> >> >+static struct attribute *oxp_tt_led_attrs[] = {
> >> >+      &dev_attr_tt_led.attr,
> >> >+      NULL
> >> >+};
> >> >+
> >> >+static struct attribute_group oxp_tt_led_attribute_group = {
> >> >+      .is_visible = tt_led_is_visible,
> >> >+      .attrs = oxp_tt_led_attrs,
> >> >+};
> >> >+
> >> > static const struct attribute_group *oxp_ec_groups[] = {
> >> >       &oxp_tt_toggle_attribute_group,
> >> >+      &oxp_tt_led_attribute_group,
> >> >       NULL
> >> > };
> >> >
> >> - Derek
>
> - Derek

