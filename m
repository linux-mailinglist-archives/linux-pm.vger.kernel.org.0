Return-Path: <linux-pm+bounces-23219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25739A4ACAC
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7084316B499
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1641E260A;
	Sat,  1 Mar 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="pEMAGqoZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DC1487D1;
	Sat,  1 Mar 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844568; cv=none; b=oKZ+rXrEPH8nUKUXfo/cwy9tX8yS71ESwzsZc6h+KtwFA7E9q7MXx7gpGQPRMJ6FnkBg7MPheqlj/k90qA+uBlbmLTBP4XFhK2hIl2/2r/P+kpr1HTS2I6YGicc0zwUZ8lgC0Em6NIYLUaNVvVtSSEqxTyHqD+zKOhzLd/rmrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844568; c=relaxed/simple;
	bh=NIqL8hGrsJATCA+dT2perFa5d3gcwP5HTyaVYpxAEB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+s9+jdXbDDio9vCvjaV2WkOCJkJsIJ1jslq0DGN6ZeYimGTZgUTWdnPnpEKEPHCImgQi1z7YJYt7y3lbbXeF0emBIXxQ0yu+jcb4u//ANXNEzcycia0InXnE6T4Syx2ks4TI0gwnkeOxS4xROr8gLpjCw1VvZIWnFrahnYygIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=pEMAGqoZ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3C4752E09122;
	Sat,  1 Mar 2025 17:56:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740844563;
	bh=FoAP55sxsjPGW40zZ3pv/kjYegOuf4agryCQ87sBqF0=;
	h=Received:From:Subject:To;
	b=pEMAGqoZpjK9CLtvssNQECUsQDoSpXNajUrtO2n3IdDxuC5bJNQEKKhCIYKPnwnG4
	 H5H+eTc04MyBvrilImj4/YeDocklPi2FMgeVhiw5uU/b+mQgmebacKGy06mBoKml7M
	 kgoQqI/vxngI8+OEKb028/rHGZ+VbH9qQ2V0VieA=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-307325f2436so32680451fa.0;
        Sat, 01 Mar 2025 07:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMyyS1Di+8OkfMMeVFWcN0pjbMb2A8ogY/vxjBu7+99EpskwiMaRMHLeFOQ/1xuRZEebwnN9Ns4dQ=@vger.kernel.org,
 AJvYcCXQ1aWzh2OHUAs74qwS8I2aANFMlTJuLELSuCEVPA9MXzPLiQrVmde4Pc5OOKOJhkmcZy/84R0SrWxpIUCqxg6dw0m8Pw==@vger.kernel.org,
 AJvYcCXn2JjIghNJE3jIdsznYlXkN57IiN52BzX/BWxKmRGbDVg1ui2yKSK54PwAlHhS27JImd/wg3CNjto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUOfWBSyuINZCIuW8LEf4SWRFsB0KXQQiKKCFkpbHpJSnskah
	gOskte40v2pPWXMeDlqSACYjayJe9mX4UPc+Qg5EX7AdHxYxUyGLFWiQ5ntQyDeQ0f+bhG4nhK/
	lKfKQ6l5voX1+FV7Ibiqj8N8k9Nw=
X-Google-Smtp-Source: 
 AGHT+IERQNIqjY3OwTbS9MIXsWTeJdIc5u4VbvpQMMpMu9Qo0GcgXat1TEfOrguJmnA3XwdNGXRWo0B8Am8v0268njE=
X-Received: by 2002:a2e:b892:0:b0:308:f4cc:952e with SMTP id
 38308e7fff4ca-30b9323689fmr27912661fa.11.1740844559596; Sat, 01 Mar 2025
 07:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222161824.172511-1-lkml@antheas.dev>
 <20250222161824.172511-8-lkml@antheas.dev>
 <45CB603E-1CD9-4BC8-80C4-107A4943E9CC@gmail.com>
In-Reply-To: <45CB603E-1CD9-4BC8-80C4-107A4943E9CC@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 16:55:47 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwH6Jb9Mgan9FrfUOs_1Y96JYT5WzG1s4LbQkv-WE3F0eA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp0lvLwZZLkqdaGnC0y5Ekpuxav1OWL7T-nuSDTUUrRo7WZo8xvR23ESjQ
Message-ID: 
 <CAGwozwH6Jb9Mgan9FrfUOs_1Y96JYT5WzG1s4LbQkv-WE3F0eA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] hwmon: (oxp-sensors) Move pwm_enable read to its
 own function
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
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174084456063.31626.4334524677069695525@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 16:22, Derek J. Clark <derekjohn.clark@gmail.com> wro=
te:
>
>
>
> On February 22, 2025 8:18:18 AM PST, Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
> >Currently, this driver breaks sysfs by using auto as 0 and manual as 1.
>
> It breaks hwmon ABI convention, the sysfs is fully functional. Please be =
more accurate as maintainers may misunderstand the problem here. This comme=
nt applies to 8/12 as well. You should probably link the discussion where t=
his was identified as well for context.
>
> <https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjohn.clar=
k@gmail.com/T/#u>

Sure, I can add a closes and tweak the wording.

> >However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
> >For the correction to be possible, this means that the pwm_enable
> >endpoint will need access to both pwm enable and value (as for
> >the 0th value, the fan needs to be set to full power).
> >
> >Therefore, begin by moving the current pwm_enable read to its own
> >function, oxp_pwm_enable.
> >
> >Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >---
> > drivers/hwmon/oxp-sensors.c | 50 ++++++++++++++++++++-----------------
> > 1 file changed, 27 insertions(+), 23 deletions(-)
> >
> >diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> >index 9c43ec0fc994..1da1e1655f96 100644
> >--- a/drivers/hwmon/oxp-sensors.c
> >+++ b/drivers/hwmon/oxp-sensors.c
> >@@ -762,6 +762,32 @@ static int oxp_pwm_disable(void)
> >       }
> > }
> >
> >+static int oxp_pwm_read(long *val)
> >+{
> >+      switch (board) {
> >+      case orange_pi_neo:
> >+              return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, va=
l);
> >+      case aok_zoe_a1:
> >+      case aya_neo_2:
> >+      case aya_neo_air:
> >+      case aya_neo_air_1s:
> >+      case aya_neo_air_plus_mendo:
> >+      case aya_neo_air_pro:
> >+      case aya_neo_flip:
> >+      case aya_neo_geek:
> >+      case aya_neo_kun:
> >+      case oxp_2:
> >+      case oxp_fly:
> >+      case oxp_mini_amd:
> >+      case oxp_mini_amd_a07:
> >+      case oxp_mini_amd_pro:
> >+      case oxp_x1:
> >+              return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> > /* Callbacks for hwmon interface */
> > static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
> >                                      enum hwmon_sensor_types type, u32 =
attr, int channel)
> >@@ -859,29 +885,7 @@ static int oxp_platform_read(struct device *dev, en=
um hwmon_sensor_types type,
> >                       }
> >                       return 0;
> >               case hwmon_pwm_enable:
> >-                      switch (board) {
> >-                      case orange_pi_neo:
> >-                              return read_from_ec(ORANGEPI_SENSOR_PWM_E=
NABLE_REG, 1, val);
> >-                      case aok_zoe_a1:
> >-                      case aya_neo_2:
> >-                      case aya_neo_air:
> >-                      case aya_neo_air_1s:
> >-                      case aya_neo_air_plus_mendo:
> >-                      case aya_neo_air_pro:
> >-                      case aya_neo_flip:
> >-                      case aya_neo_geek:
> >-                      case aya_neo_kun:
> >-                      case oxp_2:
> >-                      case oxp_fly:
> >-                      case oxp_mini_amd:
> >-                      case oxp_mini_amd_a07:
> >-                      case oxp_mini_amd_pro:
> >-                      case oxp_x1:
> >-                              return read_from_ec(OXP_SENSOR_PWM_ENABLE=
_REG, 1, val);
> >-                      default:
> >-                              break;
> >-                      }
> >-                      break;
> >+                      return oxp_pwm_read(val);
> >               default:
> >                       break;
> >               }
>
> - Derek

