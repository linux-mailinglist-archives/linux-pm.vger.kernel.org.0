Return-Path: <linux-pm+bounces-33213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E28B3934E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9E20245A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6002765F3;
	Thu, 28 Aug 2025 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjqTzMII"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED13DDAA;
	Thu, 28 Aug 2025 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360279; cv=none; b=MuWdNRtohCJ9oa9c67YTZyvKh1E1ZtUAwYE9zwXY5mf6GDmipU4HssnWkAdIzgKInx3D/vJjB6wBJzHYaAy7UPwhHTseWJ6zgCDdZCjdRYuQCqcpuFdyxkhEizozTuw1c4Zbnxdv7VSOLoKsbL4OVn6UOdmybrWOaLE9SzpI58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360279; c=relaxed/simple;
	bh=+pfpRU6cabBtHkFAx6wTGtIX59QJm0xSyvDCbivVAgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iq0AUkSG/4qspBh6+kmnS5DKeWeQvFdKxyMv63QyrYVXYvPKLTPUtU07mljoY9KaiIRqvecLcIE1N8oeyNHV+i2xAD1BFqGXeEYI5qftlIY711XM4c6axSth/WOW9HErXuwjibPJGXteV8+iRMctpR4eDjzdF/LA7W2E/8hhjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjqTzMII; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afeba8e759eso70755866b.3;
        Wed, 27 Aug 2025 22:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360275; x=1756965075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFya9Xxo8UcEycSGJ2X5jKskyF1P+mQblpuWkIk96ag=;
        b=AjqTzMIIn0T55ZEjtO1JoRQI+lgIJQh9DzGGg14ckWSP6Az2W7P23FubbXPM3tFS+P
         okvnY//Im0zSo0NWHFV+1lyOrWsASAKGogLwDDjMJUTEZjQ3SqYFCSuPtDUj8UNI1HTo
         ptQE8o2ovKQVBOuAJQX5Z/MuFEreETjRPoBqiFGntDVSAhqQUmFkXvP2dL9s5cYxgib3
         eDUfxBMk2J/2HCZjITs/EObu57TLvEBKDJM/+Ckd1tJ2aM47HAz4IW5oPmPyvTHX9Ssj
         9MJfeO82Ar29xbNnoCp3vLkHgObkK87lo6BkMMqPJGCEPCrA+S5G6kCM5BskMtqZz/sK
         qdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360275; x=1756965075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFya9Xxo8UcEycSGJ2X5jKskyF1P+mQblpuWkIk96ag=;
        b=hsO8xu488WHcmQ5MbyR4KTleq0D2IJjQphRgINLQAO1rn+709ZALYO7CCSnJbBGZvJ
         Y1BMluKYmE1i+T3xUGSeeclo4HU95BdXa9WYQT0DkAdF+XJESthCJpmxZimMh7doWF65
         2P5O5s6RgEckjfBIva03nfXsfNNwNIAtB0pfSZz7ZETkvgEOju7nX/h/ExnRHbtig0Kv
         zdcU3W8en2yYcf4Ec+pv1wRUW/Kn7gAVV5pPcoCouQ4x37soTqobOATlZ6jNB+G/XG4+
         eEqL1U83Ew03NwmNb8R28FDSMy7BgJT3NKo0I7EVCRS+lVF7FSXx/3hR201Ex0+mm1XY
         QkAg==
X-Forwarded-Encrypted: i=1; AJvYcCUxi5oKvYRTtsXNARWQhLnzEG27djX4ZlM78VU/3/zwA1sawtLunFdrpXAVF3JUIZdQGaQc4X0nObOHTcy8@vger.kernel.org, AJvYcCVyYl4QrjYeXv5wZjnyvpdIm3wTm2R5+ChfS8pV4sQgq7ytGPypIoEHZ29EUh7rY3SJrdPV56AYLIRSLzE=@vger.kernel.org, AJvYcCXq4+Y5FGl8TYO36iSat+fddOiOYmNW0NLOWxnqUwjs0wE1sZ/oVTXYhPG2ozjuTAbXNZhA+ylREXp2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi64K4AeeR3l8MdNumo4WgE69bsiwdHdkHqNFp0vEmtq8Ah80G
	iNN2g4zg1SFdEayGH0fmc6ibqhLaFcIanLEn3AzZ/iAZlrPl4BUzJeXb
X-Gm-Gg: ASbGncu95TGPDBy4SmaqBadA6euO6UQad/FM3BZNwXQPE2unH1V/NA9zD3zcNBkUQv8
	Vd8NSiLmIRnwXXPPLtBeDviSot5aeZo4RGHBqdzK7JX6LgmDqwrS1TENloTlAYsUzqK66fuTaiz
	fll4OQJVfZM0NjJjtvjHvMhK6zkGKOyspQ1atHGCQQmjqaBig8oDsiYuuXqq6vMp+eE7SzKHd98
	fliJKTLZyGRlt8t3s2/u8h9n7+SejU6ZpEGDExUW5279PxfMmUDMvaJw9TP6I2Z9CF2Io5FIl2t
	BTO7DmuMk7nCeuI9ISyuoTEcbu7ae2ScJGit4nAIOBnEh4sTxCA5bvZiEYXbdXO4nQA+oQQYxL2
	aEtHCFppSuCTexA==
X-Google-Smtp-Source: AGHT+IGkbSKUmtKl+t2HMM8Z0djNlIXB5RaRs8RVann/Uman2nhF1Cd2k7tfpmn06Wjx1rXIkPsv0g==
X-Received: by 2002:a17:907:9725:b0:afe:c7a3:c6a5 with SMTP id a640c23a62f3a-afec7a3c889mr448362566b.26.1756360274724;
        Wed, 27 Aug 2025 22:51:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:14 -0700 (PDT)
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
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
Date: Thu, 28 Aug 2025 08:50:58 +0300
Message-ID: <20250828055104.8073-1-clamor95@gmail.com>
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

Changes in v5:
- fixed CPU and GPU hotspot offset values
- added static_assert()s to assert the TEGRA114_* and TEGRA124_*
  counterparts are equal
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
 drivers/thermal/tegra/soctherm.c              |  13 ++
 drivers/thermal/tegra/soctherm.h              |  11 +-
 drivers/thermal/tegra/tegra114-soctherm.c     | 209 ++++++++++++++++++
 drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
 .../dt-bindings/thermal/tegra114-soctherm.h   |  19 ++
 12 files changed, 597 insertions(+), 7 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
 create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h

-- 
2.48.1


