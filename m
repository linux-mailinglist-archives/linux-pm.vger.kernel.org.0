Return-Path: <linux-pm+bounces-9975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48642917387
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 23:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E673D281F08
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505217BB3F;
	Tue, 25 Jun 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBlBkXdv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532EB74BF5;
	Tue, 25 Jun 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351196; cv=none; b=lbwJi71MNrPMcDO5yAdSuzlxOJd6w+kw/3/AuVTwzivp81G0Dk6idOUCOBHpvQWCYiNUMsusDHkFdLV1F+NnoHAAJPQCOzgdbn3B9TGMlSdMQdCj3Bzj07nFj/tddzHFC2U1b7m+czJu/YnelxbV6bGZaxsQ8+u4JeOKWnjLksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351196; c=relaxed/simple;
	bh=rgXmkJyZskVdJ6xIe3kzAza4wu/UsnK3TBlaawnVSaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kA0pZYuCxnLyhnWwtS6mVVcJgSKxTiNWy7EBEWo2PeXpO/tsatHZxim2sdrWTQoT7ZFZ91yfFNqRA6qdHhdnKETiXs1LpS0MvNFyIeXTgNXbqrpq5j6Ak6kRdMy9gKoqOZvuLOpPMq1aRoqJ782t+ZzimDdPXMhVDKld9nEKFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBlBkXdv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so4501616f8f.3;
        Tue, 25 Jun 2024 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719351193; x=1719955993; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkKB4GxtrWlg/r+kXFJYqrA8LJ2kMmmjaxb+VTbBkRE=;
        b=ZBlBkXdvcU8OVXuqP7HaZhBEsQGGWScqAyCqLLF72N5H5rR7xzmGSY0dVbNoDRmKIk
         J/Ek8+VcJi0BGYyfL9mBR1i8GWYYNO5oN46Z32FHQb2bjIVgoOGC9N6B0ek3yyet5R23
         8knMieOMLKx2eMl15KkKGn3AtGptjpYsJZeeb5tY71PXtnVP3P4FBgB0UAD8bhamfZT1
         boEZ1q0KUp2JSMUwYrRz65yLvjfT04y52V8nTVJU24SYwa5GBu5gKmoGUho2O2F1KNwh
         +IIycRo0L1KX4VUvyyGNwrDEcSthYtFIQ89jwMQQwS2shviHuxBzRI7wOW3eoK7sw1jy
         EouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351193; x=1719955993;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkKB4GxtrWlg/r+kXFJYqrA8LJ2kMmmjaxb+VTbBkRE=;
        b=P4ZN0MlOz5tOt3q3eUhnoq2yDHDWre61nFNB3yfiFlfcfcadZaGChRtYDcqE7k1FFB
         ZjgiZw8GmHK/HHjs/94Y0OG86vfnF2tGESLlBEONNbNbCJsOn7pJzo/fqSMLNsaV50rO
         CC6gDNc272g31cV3eE43vPTIJ8/nqJhCjMfvWwXx2Ybr7H2FbAuT2W/lp66bTGJIifdq
         S1BmN4nbkcjaxlVdAI3xkMwW4pGI9iK9dnL39FbG9dKkgX1WsIiSy+9Xv7+BIgCsAlL1
         D3N2BzEMTqD0m6GORZkzxOaQ+x7XIJlk8kKgrvyEQvOhYZ8VlNh31UnE7ksUfVVBWnxm
         FP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFPvxrnbnMHtMNT7f/6EmuweGIack2Orf8ozM+Mc0wNZd+0OJMQUAw96AtcdlVUz08kMKpjOF4ErWGmAvP+vzlNIpvcASV23guPRD4gZZQCymSJP8Big/Ku3hKrBO84cf4Nqag/xmATQ==
X-Gm-Message-State: AOJu0YxgsRGvint83EPR6lnzE+TCYXlPmaOEzIs7ajxf+3Eaw2aglK3W
	pNrFkpG9EgOrjIoB9LKwdwqDNtqIsbcYiF59/KqwIRGbdkRcE8S/
X-Google-Smtp-Source: AGHT+IHJsvMy2gyT8lX6O4uQaNgdEVNrVh/pEyToiulrY3Z1uOuSVV5HU3UP95uu+B3Bbmdmm1Rm+Q==
X-Received: by 2002:adf:fa41:0:b0:363:7788:b974 with SMTP id ffacd0b85a97d-366e96b234emr5482775f8f.53.1719351192919;
        Tue, 25 Jun 2024 14:33:12 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8251dc1sm1785695e9.17.2024.06.25.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:33:12 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v2 0/3] Add thermal management support for STi platform
Date: Tue, 25 Jun 2024 23:32:39 +0200
Message-Id: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHc3e2YC/2XMQQ7CIBCF4as0sxZTEBRdeQ/TBcLQTlKKgYZoG
 u4uduvyf3n5NsiYCDPcug0SFsoUlxbi0IGdzDIiI9caRC9kr7hm64QpmJlpfxZKCm2sv0J7vxJ
 6eu/SY2g9UV5j+uxw4b/13yic9ezivDUndFLJ530MhuajjQGGWusXECQ1zZ4AAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

This patch series enhances the st_thermal driver in order to enable
support for thermal zones. The changes include:

1. Replace deprecated PM runtime macros with their updated counterparts.
2. Implementing devm_* based thermal of zone functions within the driver.
3. Updating the stih418 device-tree.

The device-tree patch depends on an earlier patch sent to the mailing
list [1].

As it is currently implemented, an alert threshold of 85°C is set to
trigger the CPU throttling, and when the temperature exceeds the
critical threshold of 95°C, the system shuts down. There is for now no
active cooling device on the platform, which explains the use of the
cpufreq framework.

[1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
- Add Patrice's R-b
- Edit patch [2/3] to remove unused struct
- Link to v1: https://lore.kernel.org/r/20240518-thermal-v1-0-7dfca3ed454b@gmail.com

---
Raphael Gallais-Pou (3):
      thermal: st: switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      thermal: sti: depend on THERMAL_OF subsystem
      ARM: dts: sti: add thermal-zones support on stih418

 arch/arm/boot/dts/st/stih407-family.dtsi |  6 +++--
 arch/arm/boot/dts/st/stih418.dtsi        | 41 +++++++++++++++++++++++++++++---
 drivers/thermal/st/Kconfig               |  1 +
 drivers/thermal/st/st_thermal.c          | 29 +++++++++-------------
 drivers/thermal/st/st_thermal_memmap.c   |  2 +-
 drivers/thermal/st/stm_thermal.c         |  8 +++----
 6 files changed, 58 insertions(+), 29 deletions(-)
---
base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
change-id: 20240518-thermal-8f625428acf9

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


