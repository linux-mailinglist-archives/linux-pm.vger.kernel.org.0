Return-Path: <linux-pm+bounces-23218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F958A4ACA8
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7E87A8D92
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9D1E231F;
	Sat,  1 Mar 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DlfPLH1p"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B591487D1;
	Sat,  1 Mar 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844481; cv=none; b=pI2PODk0s1lbKtmQyqQRIak8dBFO/+Magl0VL95yvTwJ7j6cVlGEkSUudhl+ClgAEIyne0rhFu8wV8VOTj9ChK4eOc4k9awbsX6tta9gLfmsmO5DA5k9WP14pib4Zm2jxFlvjKMN2BxwhqV/Pa4tAzLHsuxAHvU81GkiNANOfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844481; c=relaxed/simple;
	bh=dtnzXltyasYHRCSQ1AlFDyPS7ICdlStcr8mufnA3UuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTVudhgsXF/KbeFkf+EjkpfaZy4yBBNAGGaFN5vKc+dbZhQMXVWwwSIfbp0sHYxfRZbxV797J/ybAOCH7sB3pg040qmbYyLxt4NmTY1px7rvrHO4AFaShO/eENCSiYgRsYE5C/7vuJITgaVaB4RX2qMmagX8Tgjc5mwb/4ru0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DlfPLH1p; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 669CC2E09130;
	Sat,  1 Mar 2025 17:54:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740844475;
	bh=82NSOsqgfyZpR37HSRikOqIAj2yD02FhL1hyfsn1S74=;
	h=Received:From:Subject:To;
	b=DlfPLH1pcA100gsxaffVQLjhvN3Bpn5stSUcscEPbR/jjaZBWdMJI2xyJe3+0MiLm
	 J5ToUdTWwLq9WdiCtMDO9VvZe89UnZnp22WyIhkZneJxmgcClDlhtidAKkmI7fdKnB
	 Yz6ECn036EbhhIo0oLO5KwJr+D4aWJQRyQlStOns=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-30613802a04so32072471fa.2;
        Sat, 01 Mar 2025 07:54:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUcBJFelRTLw9vzauUtUftKyYVFuTONwj/whpOPOi/LxJMVyzS+NtZOCYtWK6twxBgAxZDXHIxVPyE=@vger.kernel.org,
 AJvYcCW62JYdxw2DicOIWVLS3RFIVUfjU0kumpXBb1olpNbmme2OaLEwR/BF56SwPTt/00zaoE64Iqwqu+4=@vger.kernel.org,
 AJvYcCWAy0B1gp4FVOpzAiQrHWymrCHEfU4Euw7a7SR9VJafAF1+L8vuGg9YnqdFGFqTN6Zuu9I2EdBGu51cIJJ5jKxHUh0mBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/IwWl7HxQZVsoXdCRvxgT+NCAFOQ80QNgZKA5M0/jI8TAV6D
	7WBfSfBvsOoY39f1b+t7ZFB5pg5laYVztvNvRBPGexEYJekYLmrrltnQAKn0Q66xR5sOnrX0hSf
	NzBhZmujSK/JY7sJtdiXtq8t3HrI=
X-Google-Smtp-Source: 
 AGHT+IFBngRplVEatJIVCeh7k+j1wiELnYUTPv0XXKDM1M1dqicIoPl+R8LiFIVgk5IaCQPbuqRKewzxPLLm1WQPZBs=
X-Received: by 2002:a2e:be21:0:b0:300:317c:9b75 with SMTP id
 38308e7fff4ca-30b93215452mr25927981fa.12.1740844473688; Sat, 01 Mar 2025
 07:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222161824.172511-1-lkml@antheas.dev>
 <20250222161824.172511-7-lkml@antheas.dev>
 <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com>
In-Reply-To: <7C8385B2-9E18-4AE2-A3C3-A4F2E0931D53@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 16:54:22 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp-pF6wUIYXF7SJ45aZwZu1uvYTud-wsi88G8QcItsQBzNLmes4FtGDZic
Message-ID: 
 <CAGwozwFFOCE0J7FLUgDHnd5xEgjSpAhM02UTSBnXJq1YsvdYFg@mail.gmail.com>
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
X-PPP-Message-ID: 
 <174084447479.27238.3525200851648633294@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 16:14, Derek J. Clark <derekjohn.clark@gmail.com> wrote:
>
>
>
> On February 22, 2025 8:18:17 AM PST, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >The X1 and X1 mini lineups feature an LED nested within their turbo
> >button. When turbo takeover is not enabled, the turbo button allows
> >the device to switch from 18W to 25W TDP. When the device is in the
> >25W TDP mode, the LED is turned on.
> >
> >However, when we engage turbo takeover, the turbo led remains on its
> >last state, which might be illuminated and cannot be currently
> >controlled. Therefore, add the register that controls it under sysfs,
> >to allow userspace to turn it off once engaging turbo takeover and
> >then control it as they wish.
> >
> >As part of researching this topic, I verified that other OneXPlayer
> >devices do not have a turbo led, which makes this feature only
> >applicable to X1 and X1 mini devices.
>
> Antheas,
>
> Do you mean a turbo LED That can be set via EC? OXP devices have had an LED to indicate turbo all the way back to the 1S and mini AMD. I'm not sure if they can be set prior to X1, but this is incorrect as posted.

Do not confuse the keyboard LED button with the turbo button. The X1
has two LEDs. Only the turbo one can be controlled.

> >Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >---
> > drivers/hwmon/oxp-sensors.c | 84 +++++++++++++++++++++++++++++++++++++
> > 1 file changed, 84 insertions(+)
> >
> >diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> >index 1c01636582d7..9c43ec0fc994 100644
> >--- a/drivers/hwmon/oxp-sensors.c
> >+++ b/drivers/hwmon/oxp-sensors.c
> >@@ -101,6 +101,12 @@ static enum oxp_board board;
> >  */
> > #define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
> >
> >+/* X1 Turbo LED */
> >+#define OXP_X1_TURBO_LED_REG           0x57
> >+
> >+#define OXP_X1_TURBO_LED_OFF           0x01
> >+#define OXP_X1_TURBO_LED_ON            0x02
> >+
>
> Not a blocker for me on this series, but we should consider looking at creating some enums in the future to capture functionality in a more concise way. There are quite a few define's at this point and enums offer a little bit of value validation.

There should probably be a refactor in the future. Yes. I would tend
towards using a driver struct...

> > enum charge_type_value_index {
> >       CT_OFF,
> >       CT_S0,
> >@@ -466,6 +472,73 @@ static ssize_t tt_toggle_show(struct device *dev,
> >
> > static DEVICE_ATTR_RW(tt_toggle);
> >
> >+/* Callbacks for turbo toggle attribute */
> >+static umode_t tt_led_is_visible(struct kobject *kobj,
> >+                                  struct attribute *attr, int n)
> >+{
> >+      switch (board) {
> >+      case oxp_x1:
> >+              return attr->mode;
> >+      default:
> >+              break;
> >+      }
> >+      return 0;
> >+}
> >+
> >+static ssize_t tt_led_store(struct device *dev,
> >+                             struct device_attribute *attr, const char *buf,
> >+                             size_t count)
> >+{
> >+      u8 reg, val;
> >+      int rval;
> >+      bool value;
> >+
> >+      rval = kstrtobool(buf, &value);
> >+      if (rval)
> >+              return rval;
> >+
> >+      switch (board) {
> >+      case oxp_x1:
> >+              reg = OXP_X1_TURBO_LED_REG;
> >+              val = value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
> >+              break;
> >+      default:
> >+              return -EINVAL;
> >+      }
> >+      rval = write_to_ec(reg, val);
> >+
> >+      if (rval)
> >+              return rval;
> >+
> >+      return count;
> >+}
> >+
> >+static ssize_t tt_led_show(struct device *dev,
> >+                            struct device_attribute *attr, char *buf)
> >+{
> >+      int retval;
> >+      u8 reg;
> >+      long enval;
> >+      long val;
> >+
> >+      switch (board) {
> >+      case oxp_x1:
> >+              reg = OXP_2_TURBO_SWITCH_REG;
> >+              enval = OXP_X1_TURBO_LED_ON;
> >+              break;
> >+      default:
> >+              return -EINVAL;
> >+      }
> >+
> >+      retval = read_from_ec(reg, 1, &val);
> >+      if (retval)
> >+              return retval;
> >+
> >+      return sysfs_emit(buf, "%d\n", val == enval);
> >+}
> >+
> >+static DEVICE_ATTR_RW(tt_led);
> >+
> > /* Callbacks for turbo toggle attribute */
> > static bool charge_control_supported(void)
> > {
> >@@ -894,8 +967,19 @@ static struct attribute_group oxp_tt_toggle_attribute_group = {
> >       .attrs = oxp_tt_toggle_attrs,
> > };
> >
> >+static struct attribute *oxp_tt_led_attrs[] = {
> >+      &dev_attr_tt_led.attr,
> >+      NULL
> >+};
> >+
> >+static struct attribute_group oxp_tt_led_attribute_group = {
> >+      .is_visible = tt_led_is_visible,
> >+      .attrs = oxp_tt_led_attrs,
> >+};
> >+
> > static const struct attribute_group *oxp_ec_groups[] = {
> >       &oxp_tt_toggle_attribute_group,
> >+      &oxp_tt_led_attribute_group,
> >       NULL
> > };
> >
> - Derek

