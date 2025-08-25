Return-Path: <linux-pm+bounces-33007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C781CB33CED
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F6F203FF5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC82D6E40;
	Mon, 25 Aug 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SluLDVwc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57B29AAF3;
	Mon, 25 Aug 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118450; cv=none; b=eG0NRHNdt2eCmtABW52uoQ+lS88jII0g5NKeywIXKEi9ki62+tQFaMgkKuv1PcGJsBbZ/TKhAsVZ0tf5o9AXGYzvIMmmT2CymiGi0/5ytVaAKxZJCM1xWHxvK0o8/ztdpJ5fXu9zvZ/ghQcdJ8Hy1lwKiXEhEbLtk+hFP1eU2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118450; c=relaxed/simple;
	bh=dwbjXN62hs5aH+pcwVLD8QOs+OgfVEQXSgGD9/tbyWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8b5YcWloVVqLyVew01DMXzSNhDkAi3AKyTD31H3VpEy3P3P3E1QARxZWTy4kLyWfIGC9jGcxHyrZ2vcpjXteeSWwg5COJpKs2ZAAtd6Jwo1nsIwQ8FYNhI5VhL14zOqGoNgRmD7UO5l58Zd/QLBKjv2rabKz/bM2wdmvG9UaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SluLDVwc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb6856dfbso777529266b.1;
        Mon, 25 Aug 2025 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118447; x=1756723247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXnajAPtPyfcQV8mlMnbRg5CJBG7SJVAjuv/H154t9Y=;
        b=SluLDVwcZFzO1GUs5eoPsE6/7XyINTeGPcPFqj+PImQF3goWP9bOVcFeIPxAo0AWeq
         JiD1Vbj0KLJx7yu75s5dAcfypMM6Mv6w/hkatsiMU+pzknNvsCt37lx//xRmwdPKdVVm
         XKBWEnsFTilbflsKBVY4Sal7ee4ypgj83sipH4HhA9etlmjYbId63t8rSphrX9RC42uW
         Gvvl+KYjLThr2L/m24Cdvqv3mIGdl7+VlzEvPcsAmpaME/V/4RHzzxRjIovfOclX1EIq
         tLN8uhWoIlkTWPHjLC2SkszKyaSyIUlBUU+9bBbX6zS4L5cDpdX2EnffZhawQBsWAbOg
         9sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118447; x=1756723247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXnajAPtPyfcQV8mlMnbRg5CJBG7SJVAjuv/H154t9Y=;
        b=qaFM/YK8fl012OLUQeENC8MqeF2s56dHRiiyZL7RV5iZ0K5sth7mki68ePtskuSjds
         4BUwPtGXkfWqak/P7HXfx330gNVAh1Q3JStYc++VIScO+1mnUI8KTmaqxlGg0U3/6GxI
         Jb3azXilc+YkKD20SxbDww8h5TU0qBZ6XoODnUO52O6jOZWqCH6DFoRPPol2SPsChd3j
         Zut8405Yv1gr/QZmMmYLRALEK2CGJcSuz47gG5GuRm+fNpxrK6bxoJq/ZaJ8o280Nzx1
         BtYENZYy9EUMHXb5rZlnRoiEZv50Hen5Vlp6IUlJJqY0Rv7Z7TPphTR2j9NeG8a8TKI3
         dk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQn8ZaDQ8BuLLhk0SCWktUD4OYtibflFrxobcW2uW4eAixsvnxR7GrzZXI9RfFx1GRtWFwXhnz+ul2@vger.kernel.org, AJvYcCVgGK1mSfal6SRr1d7EkgjIhB8jq/g42mBw6zVrJE/x3PKMFS6mArEIIpLHQHdbDPd8EiQnThjnbOogjfYL@vger.kernel.org, AJvYcCWvDxmIbF0HfIg2AsfRXNjyWzZt5lCZrwb6PpIVIjrkNF99rQDXY8bXuwPkK5DB67tO7/REBTYGANKP7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypjrmd2D6qelQnVUFiSNWATLBNoyBAwTY1ormZ/DPWvPC0wHqG
	EP2Z5ecLt+h1zqn9MnT27LSPwE/VMCPPx97wXA22RsQMHdMRbY4VIrlN
X-Gm-Gg: ASbGncud+rFeT0YrG9l0qV+EJ/ynXb00dt9GSnZYkW6h2zW3/9+ttdPjtt4guSr9hss
	FZ83+yCgsEZNjts2S+CbENv6vZKTGcxStkJPjll2hOVGYCXbNHxvaeplbQjLhoJ+uqAFbcmDQzQ
	0mLlQtn4n5jLvx6PsGe/UGhigNIbL1QzmFTV9f3eUbcBUh2nPYJFZfaqcpFV7jWwHfnbdCu2yAg
	o7rVCj+abu9BhgdgzhahOWyoZwJ/HlXmoSzLCICbRNitVhOA+hn3Ango0PzQsGuHFumRzYg9Si/
	nevX7tIIOcphyJzBTltMYFlc5mWnTkTzy91nrZGzxmASqfiU35PLUfwWIol35jJ+Aly2Teuv/ZF
	AnRA0o/vd5ulTZQ==
X-Google-Smtp-Source: AGHT+IH7A17+Ab+4WuAYxIQ9fwfvGC/wG/QoFcXUzOkb0240ftIdL4lSciKaTsYBWsqOeljGKB+4/A==
X-Received: by 2002:a17:907:9410:b0:af9:70f0:62e3 with SMTP id a640c23a62f3a-afe0b3072a0mr1417947866b.15.1756118446865;
        Mon, 25 Aug 2025 03:40:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] thermal: tegra: add SOCTHERM support for Tegra114
Date: Mon, 25 Aug 2025 13:40:20 +0300
Message-ID: <20250825104026.127911-1-clamor95@gmail.com>
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

Changes in v3:
- expanded desciption of "thermal: tegra: soctherm-fuse: parametrize
  configuration further" commit
- changes title of "thermal: tegra: soctherm-fuse: parametrize
  configuration further" to "thermal: tegra: soctherm-fuse: prepare
  calibration for Tegra114 support"
- Tegra11x > Tegra114 and Tegra12x > Tegra124
- ft and cp shift bits dropped
- clarified tegra114 precision
- lower_precision > use_lower_precision
- nominal calibration ft and cp hardcoded into SoC specific structures
- added tegra114-soctherm header into dt-bindings

Changes in v4:
- fixed Tegra124/132/210 cp mask
- dropped TEGRA114_SOCTHERM_SENSOR_NUM from header
- TEGRA_SOCTHERM_THROT_LEVEL_ made SoC specific
- adjusted soctherm node and inclusions in tegra114.dtsi
- dropped use_lower_presision and nominal_calib_cp options
---

Svyatoslav Ryhel (6):
  soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
  dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
    System
  thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
    support
  dt-bindings: thermal: add Tegra114 soctherm header
  thermal: tegra: add Tegra114 specific SOCTHERM driver
  ARM: tegra: Add SOCTHERM support on Tegra114

 .../thermal/nvidia,tegra124-soctherm.yaml     |   2 +
 arch/arm/boot/dts/nvidia/tegra114.dtsi        | 197 +++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c         | 122 ++++++++++
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/soctherm-fuse.c         |  18 +-
 drivers/thermal/tegra/soctherm.c              |   6 +
 drivers/thermal/tegra/soctherm.h              |  11 +-
 drivers/thermal/tegra/tegra114-soctherm.c     | 209 ++++++++++++++++++
 drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
 .../dt-bindings/thermal/tegra114-soctherm.h   |  19 ++
 12 files changed, 590 insertions(+), 7 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
 create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h

-- 
2.48.1


