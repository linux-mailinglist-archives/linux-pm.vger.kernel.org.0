Return-Path: <linux-pm+bounces-8407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05C8D4792
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEE128370C
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52821448E1;
	Thu, 30 May 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBpXHacA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DE6F2F4;
	Thu, 30 May 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059389; cv=none; b=hapBDxpUuES7p9cxvQAV1/vcRvyWfmcD5XUCnlMLJZg42agXw3JS0xtQ+VCN7d8xN1kXwE5ZK8r99Ou0crjR3UXkA3pFgmlTq5RwNUOByM1WqyPL0R6utYu8rfS7ZdxiFJ0tQYr33kw3mdNsoTJbrGvqnLwP0UwiH84Mpd5r4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059389; c=relaxed/simple;
	bh=qOadE76vLdaIplciF8D6zHAXndcfCGT/osoFvr6KlEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GznVRRLn1CQCwiMeA1U6UwMxd0s4anVGLLE+AxtVpT63Oy8q/CR+WtrY2fLE8eMrxYGGZkVpYkokd3DOucxeulhi216/xTcMQtrObGIEV9HgjugJcxp3Yt5ALCwFvv1Xk0CUEstaWdr0hEs1r7IuUZY2HojWMU0U6jRzVAysD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBpXHacA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so301146a12.0;
        Thu, 30 May 2024 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059386; x=1717664186; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJbFOMieqUJ1HvhG4PnEYVJKF/U/LFck+FVCHvfSXS0=;
        b=YBpXHacA1eDj9F2y9pU6rVlNOJg2O+Zbb/k6Zw7cBmd65pgQHIbSUqibnTQXFKSNfI
         H6tXfvJr/5W3radVQD6z5ysa4fi/uGdIt7/K/ZgNagMBaawVAerdWb5g39lmMZvNfh+g
         xU4k2ybHSQdfaaOgtnpm4UV2nrzYUpg9m2OJToILdKPLti4NJN2wvk3h6KZ+N51wu5so
         F6HKpkrvUo1EFfffHMAFUzg/l9yzGbPymYZpgcafH9uzx2+nIEtXftoox+Q/cQvXQBlS
         FosvQEeP9PCMoeHtqWgCQQOqEvmmAZj48pgCFHdWYsuIEHEdcfgGsQZh3KDG2Fz2RdAT
         CH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059386; x=1717664186;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJbFOMieqUJ1HvhG4PnEYVJKF/U/LFck+FVCHvfSXS0=;
        b=D0EmXdeSHDvvwK1Y3UEX13vEh89L9EXayVrziZSSHu0lLRQDwuTSn+PS3/AsYIfGQm
         TL3gwAP9C7CqawnGS174GoJhZmi09lbziUKwI77kA/Byz8XWgZHuIui4b9I+Ev+Y919k
         kPN7MuErGkhfkM0gzA8TRkr6WfxvMaEYHnaVDTGTomSPJ/pLjYYdqPQU+FyXB40yrAMK
         Bxorbn+f2UcKs+anLliaAp6VH36JkcZXwgScMc8cgXPdCFCZLreBszyc9V72lWV8HUn9
         ur2IFwUjng+JEXh45pw9cguOH7aXZ3kGF3rcRx4e2OkZdGzK+AKqquCKNpXcaIt3uFgy
         rfcw==
X-Forwarded-Encrypted: i=1; AJvYcCVLd2xE/DM+qKcVXSwbGAmcQi+Bzyw1D450zuDTCihhexq3gxBT2xF20eqtEv957pVxR28FQMUojiOFqJTVEWFLdvHk36SwsilHyJNkfcoEAkCCt8f+W0mBiZ5gDgBJuRBY7ZJEIKITETEHxFeJQO52lbIg5o5kDRc2nSzOVTnXcfliZyvH3UWH3G7G+Wp9tVkLFtBfuh8bWhUTwz9DZUAYlgCcsPg=
X-Gm-Message-State: AOJu0YyjFhHLTwJZ0+GbSpXcyHK+MDsHAuDtP0Qwcr7/sueNjiBKczJo
	hRHNWHRVG46eowl1gHp6UVaJe5z8xzOt4LfBw/2mm08y/PKgtIe2
X-Google-Smtp-Source: AGHT+IEKymx3ifIQOa5BXuhl+5X0zN/+cM7GQF9Ej5dDfbtdj4YsozuxlRJoa3tJo6QcZv/W0pOI2A==
X-Received: by 2002:a17:906:70c:b0:a5a:5b8b:d14 with SMTP id a640c23a62f3a-a65e8f7b58fmr91646866b.40.1717059385883;
        Thu, 30 May 2024 01:56:25 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:25 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH RFC 00/11] power: supply: max77693: Toggle charging/OTG
 based on extcon status
Date: Thu, 30 May 2024 10:55:50 +0200
Message-Id: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABY/WGYC/x2MzQqDMBAGX0X23AUbf1L7KsVDEj91D41lUyQgv
 rvB4zDMHJSggkTv6iDFLkm2WOD5qCisLi5gmQqTqU1bd6bjr8vW9kPDResCZeR/2CIP8N56N72
 aACr1TzFLvs+f8TwvQw6C9GkAAAA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=7625;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=qOadE76vLdaIplciF8D6zHAXndcfCGT/osoFvr6KlEk=;
 b=MMtU+GPWlwCX0PoSEku/V91gjQOS+G/MXBGM8VPiwgMRwiRu56xv0CqcQUQT5CiqwS3RIBZBn
 nd+dmF9GoxmCzDiJrOArIdCmggW/bE8oKrBrk0QPkcIrP/w0iqPrpRp
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

This patchset does the following:

- Add CURRENT_MAX and INPUT_CURRENT_MAX power supply properties to
  expose the "fast charge current" (maximum current from charger to
  battery) and "CHGIN input current limit" (maximum current from
  external supply to charger).

- Add functions for toggling charging and OTG modes.

- Add an extcon-based handler that enables charging or OTG depending
  on the cable type plugged in. The extcon device to use for cable
  detection can be specified in the device tree, and is entirely
  optional.

The extcon listener implementation is inspired by the rt5033 charger
driver (commit 8242336dc8a8 ("power: supply: rt5033_charger: Add cable
detection and USB OTG supply")).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
This started off as a cleanup of "[PATCH 0/3] max77693: USB event listener
for charger"[1] (and its later iterations[2]), but I ended up replacing 99%
of the code and adding a few more additions on top.

This patchset was made for two reasons:

- I noticed that charging on my Galaxy Tab 3 8.0 seems to "work", but is
  so slow that it starts to discharge during normal usage. After some
  investigation I found that under the downstream kernel, the charging
  limit registers (two of them! see patch descriptions) are changed to a
  higher value when plugged into a charger, and adjusted based on the cable
  type.

- I was investigating what was needed to get OTG support running, and
  found that some OTG mode bits had to be set in the charger when an OTG
  cable is detected, and that required me to modify the charging driver.

That's why the patchset includes *both* charging detection and OTG support.

== Kernel-side charging management ==

The original patchset this was meant to supersede was denied because,
among other reasons, upstream did not agree to having the charging be
controlled this way in the charger driver, suggesting that either
user-space or the charger-manager driver should do it[3][4].

charger-manager is not used in any devices, plus the already mentioned
patchset comments suggest that it's not the correct way to do things
("DT should be used for concrete hardware, not glue drivers")[4].

There are also some drivers that already do this sort of kernel-side charger
toggling/management: other than the aforementioned RT5033 driver which this
new patchset is based off[5], there's also the MAX8997 charger[6] (the patch
for which was merged just a year after the MAX77693 discussion[7]!) and the
AXP288 driver[8]. Still, that's just 3 out of many more drivers...

For this reason, I'm sending this first version of the patchset as an RFC
for further discussion. I've done some thinking about what a potential
implementation allowing for controlling charging from userspace might look
like, and here's what I came up with:

- Allow for setting the charging input current by setting the INPUT_CURRENT_
  MAX property of the power supply. (Leave current from charger to battery
  set by the device tree in the kernel, since it's arguably more dangerous.)

- Allow for setting the CHARGER regulator on/off through some sysfs property.
  How this should be done is tough to specify; there seems to be a few
  ways to do it (e.g. setting the STATUS property[9]), we could use a custom
  sysfs property.

- Add a custom sysfs property to disable kernel-side charging.

About that last one - I'm convinced at least *some* level of kernel-side
charging control should exist, and that's for a practical reason:

A reccuring complaint[10] is devices that are low on battery and plugged
into a charger shutting down before they can fully boot. If we set up
charging during boot, the charger driver can handle charging until a
userspace daemon appears and takes over.

Of course, this is all up for discussion - comments appreciated ;)

== CHARGER regulator ==

I think it's worth also analysing the role that the CHARGER regulator plays
here. At the moment, the CHARGER regulator (managed in drivers/regulator/
max77693-regulator.c) handles:

* the CHGIN input limit as the regulator current limit;
* charger enable/disable as the regulator enable/disable.

A comment in the regulator driver suggests that this should in fact manage
the *fast charge* current, not the CHGIN input current, and that "this
should be fixed"[11]. But now we're managing the fast charge current in
the charger driver... and, if the regulator driver ever was to be "fixed"
this way, it would break the charger driver's ability to set input current.

We could potentially drop the CHARGER regulator and manage these registers
within the charger driver, but since it's not causing us any real problems
at the moment (and the "fix" scenario mentioned earlier is very unlikely),
I decided to keep it and use it to handle the two functions mentioned above.
(Although one of the reasons for the superseded patchset being denied was
that "[this] power supply driver should not manage regulators"[3]...)

---

Special thanks to Wolfgang Wiedmeyer whose original patchset[1] served as
the base for this one, and to Henrik Grimler for helping me out with
figuring out how the input current/fast charge current registers are
used.

[1] https://lore.kernel.org/all/1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de/
[2] https://lore.kernel.org/all/20190910200233.3195-1-GNUtoo@cyberdimension.org/
[3] https://lore.kernel.org/all/20160927081344.GC4394@kozik-lap/
[4] https://lore.kernel.org/all/298d81d5-fe41-e2d1-32a7-d3dc35b0fe25@kernel.org/
[5] https://github.com/torvalds/linux/blob/v6.9/drivers/power/supply/rt5033_charger.c
[6] https://github.com/torvalds/linux/blob/v6.9/drivers/power/supply/max8997_charger.c#L98-L141
[7] https://github.com/torvalds/linux/commit/f384989e88d4484fc9a9e31b0cf0a36e6f172136
[8] https://github.com/torvalds/linux/blob/v6.9/drivers/power/supply/axp288_charger.c#L617-L673
[9] https://github.com/torvalds/linux/blob/v6.9/drivers/power/supply/rt9471.c#L370-L371
[10] https://gitlab.com/postmarketOS/pmaports/-/issues/2594
[11] https://github.com/torvalds/linux/blob/v6.9/drivers/regulator/max77693-regulator.c#L45-L54

---
Artur Weber (10):
      dt-bindings: power: supply: max77693: Add fast charge current property
      dt-bindings: power: supply: max77693: Add maxim,usb-connector property
      mfd: max77693: Add defines for OTG control
      power: supply: max77693: Expose INPUT_CURRENT_LIMIT and CURRENT_MAX
      power: supply: max77693: Set charge current limits during init
      power: supply: max77693: Add USB extcon detection for enabling charging
      power: supply: max77693: Add support for detecting and enabling OTG
      power: supply: max77693: Set up charge/input current according to cable type
      ARM: dts: samsung: exynos4212-tab3: Set fast charge current for MAX77693
      ARM: dts: samsung: exynos4212-tab3: Add USB connector node

Wolfgang Wiedmeyer (1):
      mfd: max77693: Add defines for charger current control

 .../bindings/power/supply/maxim,max77693.yaml      |  13 +
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |  14 +
 drivers/power/supply/Kconfig                       |   1 +
 drivers/power/supply/max77693_charger.c            | 291 +++++++++++++++++++++
 include/linux/mfd/max77693-private.h               |   9 +
 5 files changed, 328 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240525-max77693-charger-extcon-9ebb7bad83ce

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


