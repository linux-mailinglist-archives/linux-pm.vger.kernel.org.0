Return-Path: <linux-pm+bounces-32132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6DB20133
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145DC3A18A1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909642D94AC;
	Mon, 11 Aug 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcOiqKQ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDE1EB5E1;
	Mon, 11 Aug 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899488; cv=none; b=HzcCOKwwy6Aqy2Sv4hYbnS5BzSdJ/fML340/aXIxi/VX709VyRGSUi0bGQDl9CS5Z0rRpvMKXrSo1rQ+FbY7Mf69XHXOHI+74pQuQZrJHolX65/Nh0M0R1XuiIpj+TKe3esBiUxZ++dIC6T7i2EQRgtIDb2gvBlH8AAtyFBWbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899488; c=relaxed/simple;
	bh=RfqUbaa9s7JOmh2LfjwsNwwwmm0uXMw9G0+7rubVqf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d93bEpDMrBf3fmviuqRbYAVKfn5aOuGENdK+R+r4CNGBW6dfghfynEtvhmQokaCKQRWTof3TWAKGOdAYbP5seza/DoTpLVD1Qen2zLIl6pr8Y8Gx6fEyQHorAPHeXB1A8Ne5eE6cQbJN3W1u0N1tPChzpMPkyWxbfOioEZ53LuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcOiqKQ3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af94e75445dso725734466b.0;
        Mon, 11 Aug 2025 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899485; x=1755504285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6hrDr1ho+LmcOihDF5/afd2FJMkMgiWJJggRREgOis=;
        b=IcOiqKQ3hoDD0W9XYGZyoqDUFzu+NqzL0Mk1cO6sVf9F0NR7pU6qvHyIqELyIoZ2gt
         LR0+fWwbn8bmdz7XfIa5Saj/litrlWtQF2xuRSFcl22bWgsQxlhqOQY1XWB/mNISArK5
         S2Hwmpb9dZ/caRZdHcT+y90h61J8cJw4QYgn5xOpI3oAef6OBy5sP306cOQpweWOX+7g
         WPNUzhk4zWWATF5BK9SrRpM7Ewmgq4d3GvlZpMgEVqk8kvzy0nDoH4/KLZo+1vEBjyGP
         /PsDyAQhaYw+gOM9emvH5GFHjtfNuFhMgKv77Hx28yuApEQSSgQIeRBg0SBc3nal18wA
         CyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899485; x=1755504285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6hrDr1ho+LmcOihDF5/afd2FJMkMgiWJJggRREgOis=;
        b=BlRxvVO52+oEcZVvDcrjs2ag0YU4kxWD8+VhiUAKzDhGyvNhtbsRZamVRNigdHmrBV
         Q6VkGEJoAqQE1/TkUccLRwZIwXHWttZyqASzTauH9ymbI8j4cwwpNDYrZ0aUryzbFxhC
         IeVJpePPNY1xkCKPglJi8v9Nh8L+KrgDS60Jywlif6hTb3OFQaXp4N1yLDD9+LBIzMWa
         DKVGizUDRtsjpAqFcibw6uD/6qBQ5PrHY3o6ycvt1c5u5qNNK6n/onew1gtmeWgFrznQ
         2KalyAcQmTSOFOEe1BF4H6fZqry2gY79NK4NdlubOzoUfRdSTLnNBu73EXrz2k1m8HRH
         AycA==
X-Forwarded-Encrypted: i=1; AJvYcCU0VYK8OrBiSn7RoRX7po//6hlOfCSE+Qcj3tE6MMn5Ot8QWER3exE2v3cTzQMRCp72g440ovgfqqSspg4=@vger.kernel.org, AJvYcCW3D6McVMtAO/Yn/LojfkxVdrBWDzsHfeWGpLp+IWcIxTld5rKkxqfugez+L56RKrwgOM4V5Iv9szQX@vger.kernel.org, AJvYcCX/epmKhEaPVfirLx+v7UQ2V06VD/raYhr8uRmlEAgElFrxugHv+FW8ImdHpLDqb52RvU0A13wP1RGMcY0x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mh3pKFKeEcvUbkYnEv6mlYgUkqQaOXq7dl7x7SoexAYeEQqz
	zoSt9qukB5WBkDdkXxLSCgBYJe65UF8YkGVslvNGbLDoVolrX8A/JNIC
X-Gm-Gg: ASbGnctKdVVTEraBD/CZ4QtV2Mf5wMS5mOC+M2uagm4vZeswlc3DzQ+KR9yg0p6x9Mk
	WYq4QS4ZzONJI26+EQ7+cVWdMtAvHaUQsYhv3HIFvi2SU3pXyKx+RwE7ElvFBDKmYgfgyrQId4W
	135OYOn7KplnIem4X/ija3Dwd1swVbBBjc7y3aQpC2b9LDBK+wvvY8bTZwI0o+xh7mzw68SiOZn
	cpBD+Xxix/u9Y7y7+lzmHWqsu6JAQ/QqCDrNf7+llD53NCfjlOstGGVwa4Gx+uz819v5uxGUBgH
	YKjLl4b+29tKW5r1wBFrmqZocI3m+/iCH4AkfcW445m+USuieWyTULnPvxbkygFINCuqkz0/eoQ
	sAjOe/71/oiFEWg==
X-Google-Smtp-Source: AGHT+IEtHXo+fztQkhpk6ZRQbC3R8fp8OUp3I7mzBide/4wx9z/CJVbiAPNZatH1C9egBfNknbVreA==
X-Received: by 2002:a17:907:3d12:b0:af9:71c2:9fa with SMTP id a640c23a62f3a-af9c63b0ae7mr1181315566b.4.1754899484762;
        Mon, 11 Aug 2025 01:04:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1956446566b.97.2025.08.11.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:04:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5 RESEND] thermal: tegra: add SOCTHERM support for Tegra114
Date: Mon, 11 Aug 2025 11:04:17 +0300
Message-ID: <20250811080422.12300-1-clamor95@gmail.com>
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


