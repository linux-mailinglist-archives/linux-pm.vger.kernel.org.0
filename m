Return-Path: <linux-pm+bounces-30769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A3B0396A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CF18837CA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E66923B60D;
	Mon, 14 Jul 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Gm9kQO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E288223DDF;
	Mon, 14 Jul 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481393; cv=none; b=EMjmoAm19R4reF5YlnlPJny+BSROzwYSdu9JurRsmVKnFvjaBAahhHuJBkVVJYBxdrCkHT5T9QyBCqxRDQNJuSTVXG63sXjbKwNbk7tiClxaSvnCr/3RwpLvA7Wkv/R02ZzBnqFQbn6wDeBsJ+wPiFr8srQf6sPwztol8Hltam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481393; c=relaxed/simple;
	bh=RfqUbaa9s7JOmh2LfjwsNwwwmm0uXMw9G0+7rubVqf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYiJnav/kxEVCZ1VHyfmJ+zFRn1hFMgsp80CsaGJvq9Dnyj9rx8/mJJ2+lGAQBo5nzoJQ1E+k+X0DAZGy69tm0aNSbBJsoHca8/Y2FGrM8iRgiXHE50S5zDYQIPvj297gdRSwHtW0QzTl29/s4uL4+1NgWj0kPlPWsg4D871yjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Gm9kQO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b6a349ccso4957109e87.0;
        Mon, 14 Jul 2025 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481390; x=1753086190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6hrDr1ho+LmcOihDF5/afd2FJMkMgiWJJggRREgOis=;
        b=l5Gm9kQOhNOq8P3wMqU7GZN56IfjuaW/38XOm3/e/CQokank9pGHLTAC/3S3wPtCEe
         KGW1Ev+3gbCMMC96ghjPI2M0+EiCdLNUqrDWpm89Fa+HdkllBsKWw+4d8LjYaLob4dWD
         QdkMwYt9Zext5uj2aqR9VrXQeK6NXTc7WSZ1QmMPFedQ6sauFfvL8Z5ggxHYZFNuqGtz
         I5WEdJb44gBPVeoXpEHV79jMAAFCDoq1nk5jj2id78OeiA3T1huwlDyuX08BV3K8mfcc
         mWk5yH7v8L5Ar5hcByFPBV12L7VLDauAr9msqTJz6lfZdEchzVCeMP1mXbaSxVzJr/WA
         iFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481390; x=1753086190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6hrDr1ho+LmcOihDF5/afd2FJMkMgiWJJggRREgOis=;
        b=tobn41OZRCV2ViYKWt2779kTszWfNF+9jvknShZuJpLF5qT36iiZirfFKG48HN3TsU
         XmsNdwxPTdlsIszmVZ7jP9D2mRTy5q8JdPXtGOij1zX/BwQAXgZyodfxhvx7Bl7/kl9u
         13rCuX9puvxyR3jzK66WanN9PTCsE3rn8DbvToNvFYNCp3god1WlYVcp8fu/iMEe2J4Z
         9e2wtS9mA7/Ejm0grDhOiwn8T4kbOa988f1eo3+lL7ysQneA1L41E8hxG5NE/NZIn57w
         UguylOuPqilduefuKKjC+vLzde9d5hU8M2vmMd0NxW7Tek+aq7jG5eHv+58nPCmNzn30
         H/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVfVcOU+4wfIR7ZClZteJrHMdC4ZSQ8gl00o/RVEVEQbUOvTNfoUFR0tA8vB+eMM9GnAkNcc56yVQrP57Cx@vger.kernel.org, AJvYcCWB+p+3rLB0ad0tnIwW1TilBH3XWlOZ8+63I8E8/onDU0gZgtlY7aBtsDuZRhgCws6CdHdpeG98vOLfJNE=@vger.kernel.org, AJvYcCXMs0l03OsaU36qk8C0FMbgDIHqOfZsmy36Tutp71npLYXMNVfMavIlD1kPPu8iczCJxI1GbURPnGze@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfsebK61BxoPeP3+Z/aSG3/g+ySdmfm4IkDDKJSDOPM4TfrXb
	Dlaa2+H+ZaLkQGy4TglfTDvJZSRXcsA4LJFDSfUqXsFN+JH6TCSkmNFX
X-Gm-Gg: ASbGncufocJ2n8i+ksHl5iG+zn3H75BzdFpAxah/IevFFtpACUCUSsTlegEbdhAaIXU
	7OJSRpsQt42eGygWEm1075cIX01RDwu2C0PXA6PDo8MjmLhkDhWo86FC77ibW0XlOq3yTWN2JiN
	b2HItVsIVNpP5iZXM9vQrrlU/eGk4txu4l+hW5dVJJZHkSGxx1X9Hw/WxXNoBPA6CiTFwLwTfs0
	YT5gMO3DXKpOS2hJaduzEtwjMqVjXgaSLbO4ScxDuUvApn5cMkKk8u1Dk8axUbycRrWPo6Tw3Dw
	nhdPydWNCLxwBk9Z63nPcdQFfO2i1Jr9dItkGZrFx7TX5ztIChE9x8C/QCO2jcNCoHKl5xOpmil
	nNVyaFG6QhmHUPw==
X-Google-Smtp-Source: AGHT+IE/cT/hjY2GCM1WSnH0h5q/mZeYUgMYbbjoyfEzTj0kg7wgS9qDCIngeBrTB4ZjtayJ44GjnA==
X-Received: by 2002:a05:6512:31c8:b0:553:296b:a62 with SMTP id 2adb3069b0e04-55a0448b825mr3586374e87.12.1752481389417;
        Mon, 14 Jul 2025 01:23:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] thermal: tegra: add SOCTHERM support for Tegra114
Date: Mon, 14 Jul 2025 11:22:47 +0300
Message-ID: <20250714082252.9028-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SOCTHERM is thermal sensor and thermal throttling controller found in Tegra
SoC starting from Tegra114. Existing Tegra124 setup is mostly compatible
with Tegra114 and needs only a few slight adjustmets of fuse calibration
process.

---
Changes in v2:
- no changes, resend.
---

Svyatoslav Ryhel (5):
  soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
  dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
    System
  thermal: tegra: soctherm-fuse: parametrize configuration further
  thermal: tegra: add Tegra114 specific SOCTHERM driver
  ARM: tegra: Add SOCTHERM support on Tegra114

 .../thermal/nvidia,tegra124-soctherm.yaml     |   2 +
 arch/arm/boot/dts/nvidia/tegra114.dtsi        | 197 ++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c         | 122 ++++++++++
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/soctherm-fuse.c         |  33 ++-
 drivers/thermal/tegra/soctherm.c              |   6 +
 drivers/thermal/tegra/soctherm.h              |  17 +-
 drivers/thermal/tegra/tegra114-soctherm.c     | 213 ++++++++++++++++++
 drivers/thermal/tegra/tegra124-soctherm.c     |   8 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   8 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   8 +
 11 files changed, 604 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c

-- 
2.48.1


