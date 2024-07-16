Return-Path: <linux-pm+bounces-11175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77324932F2D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208DC1F23B86
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2A19FA99;
	Tue, 16 Jul 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ5M3Mzb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099619DF87;
	Tue, 16 Jul 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151316; cv=none; b=Ku+WusXNV0amap7LQjFhMY19vyjeU+eHttNpBNWOsZmzpPW+N1ESEZzToz8M14FeItOs69OFzOcmZW+TCvFDwuIpBUkKH381GuzkEUeFDCEoU8LpR2cYR5MwD4JV4kCulAR22NaW3ayY4qO7wuC64XPT/daoRalkC6eGfUF6c4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151316; c=relaxed/simple;
	bh=x9IikHbyBVVijgjWkItmyxDW+2/bZ36MDO5Jtixmhbk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SWYN8hq4tLWsCW8+L24jc7NaskyBiT0pKYTfDL6WhxzhLz9klRCRHFH30VFye3+uYtpGMGnrwR7bgcvrhY69IZhxt90KNT2GZ2ALo9F8ItU2n5NnU/7SevmbSzvCKo8IlU2/I+p+5ZZEYu9YpYBMUrsYtllkCpiBNgsABcKRPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ5M3Mzb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9fe05354so8065276e87.1;
        Tue, 16 Jul 2024 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721151312; x=1721756112; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kchnNo8yPLFh2dK5IcV05EsWvdVMiZ16c0fFJ750TxA=;
        b=mJ5M3MzbFZB5soIVsqcR3xJyJaUKWTZLIbFx3NUK84V1odGRk8KLfv78ll6cIcRpUc
         yvzAvtuKVMQJMXAn/4x9pSvLKk+tProahUaIarJTLqSekxG3rbc/kHWFkbzj5ahWvdR1
         NnbLP4uAfw7aDRoc+ZubwLMxf3N/I7InBwKnAAC2kQcO8a/ZOAZ0T8DyzJtn1gC/FHn5
         oD+A8MzgNNsnqJ27Qnom7jyXdCe1lsYu4ntad/CTezmb6S5Mx+PhqmxmML+4nff4gwtl
         6OJd429Zy52BUEZxQXItGsUXXbL1II0aPlEkm4Qq5rS2aAbx21IpgbsE3UFxmk64SQbu
         Uu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151312; x=1721756112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kchnNo8yPLFh2dK5IcV05EsWvdVMiZ16c0fFJ750TxA=;
        b=KJtrjVvxIw8tpeed3xSIqQmkri6aFNeoW6HYs85suSgu7hQjVOz7ttcZ03z+ZcbpXk
         bT6C2XDsmBLbpsAGiwTelCw+zyUBNzy80qWfs9NIU1EAXsUFkVkdFSO2xSx2rguE+54+
         vvWboHbE+6gQDUiN/cofoUQm4UpYo026Ubw69CNxglcoCnhKohB5Y+nTW3Pw5MH4TeUI
         ohvcQ5rc+VgzlCoi7oC9ExeHVpkwVyQ5lsTPGDmTnROXnP8R7RbVeQR4jZNSKcahoLEo
         15eDjs7540rA8dmdbu/zDd+ukCQUMtj61o4yZmxOZB/jNgiM+f3oafPtgX9H6kCtDy78
         95Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVY7XxV53kGLYb3HN7OCJz53pRWqY3y1eEl26W54jKHltOURMhMJqAa1RhU8paZiw7s4QbBo21w8Sk3FRCfIERy5h5o3Vgc6qbEo24In1JuuVkxYhgyTfQmTbIo8JNkoj8oB5tdRw9Biw==
X-Gm-Message-State: AOJu0YyZB67kyOJ4iCQLzoJoVIbdCvADCtbOWc33fCv6xgx0Ck/IO5PJ
	UIln/vsSQHPXs/kbuQVSULmxV0dXVs4Nbi6JY3JamCcvwW4sDkHV
X-Google-Smtp-Source: AGHT+IE2mB4oZTOTvFDO5DkXK2tpo0pPHe/jgiUbxjLLBf4wAR3RggsbcbiEp4YgqrGFa1ldiV2H0w==
X-Received: by 2002:a05:6512:e93:b0:52c:8e00:486a with SMTP id 2adb3069b0e04-52edf038979mr2407374e87.55.1721151311803;
        Tue, 16 Jul 2024 10:35:11 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2397easm172599675e9.6.2024.07.16.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 10:35:11 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v4 0/2] Add thermal management support for STi platform
Date: Tue, 16 Jul 2024 19:34:50 +0200
Message-Id: <20240716-thermal-v4-0-947b327e165c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADqvlmYC/2XNTQ7CIBCG4as0rMUUGCx15T2MCwpDS9IfA02ja
 Xp3aTcYXX4TnpeVRAweI7kWKwm4+OinMQ04FcR0emyReps24SWHUjJF5w7DoHuq3IVL4EobV5P
 0+hnQ+ddRuj/S7nycp/A+wgvbr/+NhdGSVtYZLdCChObWDtr3ZzMNZG8sPLv0W3Y8ucYpIQGtZ
 Ii/TmRXMchOJKeU46BqdJWV327btg/VmqHEDgEAAA==
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
Changes in v4:
- [2/2] optimize dependencies
- [2/2] do not return devm_* exit code
- Link to v3: https://lore.kernel.org/r/20240714-thermal-v3-0-88f2489ef7d5@gmail.com

Changes in v3:
- Fix unmet dependency in [2/2]
- Remove no more used variable in [2/2]
- Remove already merged patch in soc tree
- Link to v2: https://lore.kernel.org/r/20240625-thermal-v2-0-bf8354ed51ee@gmail.com

Changes in v2:
- Add Patrice's R-b
- Edit patch [2/3] to remove unused struct
- Link to v1: https://lore.kernel.org/r/20240518-thermal-v1-0-7dfca3ed454b@gmail.com

---
Raphael Gallais-Pou (2):
      thermal: st: switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      thermal: sti: depend on THERMAL_OF subsystem

 drivers/thermal/Kconfig                |  2 +-
 drivers/thermal/st/st_thermal.c        | 32 ++++++++++++--------------------
 drivers/thermal/st/st_thermal_memmap.c |  2 +-
 drivers/thermal/st/stm_thermal.c       |  8 +++-----
 4 files changed, 17 insertions(+), 27 deletions(-)
---
base-commit: 4f40be61af99a67d5580c1448acd9b74c0376389
change-id: 20240518-thermal-8f625428acf9

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


