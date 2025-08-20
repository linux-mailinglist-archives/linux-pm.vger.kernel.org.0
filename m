Return-Path: <linux-pm+bounces-32706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81310B2DB68
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233B217467E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCF2E2EE4;
	Wed, 20 Aug 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjfNk6M5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495A242D72;
	Wed, 20 Aug 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690181; cv=none; b=JhD7dqUuZw2uxo3O+8TrVGdsuOsfpe0G6BB6KBpX5ORoo9SHWLq+74OIOzocMrINlQnN7ZrVMXV8bJbHZVO4swnlHmuigVysVOfjigyfZl0bpZjFxEmOIh4JTcpacTilyLjAftIOuw9QqCviXhybKOAj7Bk+ZGVUotQOhNCuZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690181; c=relaxed/simple;
	bh=0nOC8WD4XjC1p1Onq7FgBg1DbdXb/Ajql1bTdvsPtn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2pbhlbFOk3KgX5FJqp/jnSKr/5VakxRPrKHQKoDMtu0PA31pzCbfqVmH885b6jjPBFOvTbpbj+Ecl9bLYSEh4dcVE3qMYBVpYXb1HLEN+s4ZcIdqfJqqbrxr9mj8SPkvOnyvIs8jqx1DnFJlbCBRMCcr7GvFoobYImGv5wJx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjfNk6M5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7acfde3so916004566b.3;
        Wed, 20 Aug 2025 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690177; x=1756294977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KULDlNgkmvRvA7vpAhRs9doDkFcWkJMR6necqXvdLkM=;
        b=QjfNk6M5FL9VkRW1rmfP7JwnQeSRdGNjszcBKjfoVqqd+gEH3cuhE02pIrTTlTJlxZ
         29kuo8RsqFt53TuL6N99aaF28zRoOF4xVu6fz9BZozCacl8I/tzCDNnn47ODnDPi/fmu
         6XzhpUOkyLrLQpgM2xJb4IA7cr546/HrSVpG1nVThFlhMOHo+3Xhm51y5cTYYoJE47H6
         50RSaoogB+nBZ+yve+e7uUw3XWqlSnkQ/HLqF7q7Oi6OLsoWHY0hfC+bFKxbCOhuu+Et
         bNBXm+n5VrgMnLeNLgEmsEMpYT0j5xD7VGP/SBsH26fWC3D0EzIekfIyI/mVWMoFucCN
         edqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690177; x=1756294977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KULDlNgkmvRvA7vpAhRs9doDkFcWkJMR6necqXvdLkM=;
        b=F3kur6ctOBbcfP8HK1B8qxay53/HangpRbDpTv1367Wnu3eDmnOj+ZQUIm1rSQyyr6
         x579QYr2jqk2dq54LihFz82NiJyjIyglWshUGMiDEbSGu0SGtmC4VvZYkvYd7Ey5vRZL
         JzgwRAQHmcPkRT4Hwaja6St68eq6AAvoc0eiBXvvwyHgtBYTIuLF/0ZiHBM5g1EDTuxF
         0n+OGJDj+LdOh2w78/bEoV2s6b3EruZJscjz+g5Ris1ZRW1OsruvtZ/r0DPYUxj3RyAY
         rOd1pzH6oxjmOkVkQvPHo7IYbUXfBp7gP7H2qhXhJkP0wCVJ2ejJnROo+60RHPXIqfMS
         9dcA==
X-Forwarded-Encrypted: i=1; AJvYcCU2yVa55Al4yjs06bSUDpfsynOosLs2ykBqfAxUR6Y6Ad5ngsiv88UE8OG21RW10McPsGiZf+LHcALt@vger.kernel.org, AJvYcCWLDHVzrNs9lu7LFwohmd8M0+kxJS7XTjj0VBUKbJAOZzhi98qgQUVrbeeQEHFwn+4MFiopJuuowhi1nZFz@vger.kernel.org, AJvYcCWeHDrkoKfun7viGVtR4p/MISC++J6KvJWhBK/jK1MBIHEqf1CKBLug0qfnstEtrMKqowgLzXrezVDGH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyj5vPPg+gmHUiP9D6xHScTvtgHywJIS3PZwkUUj3B2yVNeXwt
	jvUKnQ35/8omXzBwY4FycXCXwj1QjeBgtKlXK0U8feBvrraUNGbSnq43
X-Gm-Gg: ASbGncuD7uH17jMTK+YGjQSb9V6t3tgayzjOScaVQtxhokzNWUzLt6hUwTwG7DAPzYi
	a969kMJ3o5q4EerCe0wFd9PLtEuX2OxshzqD0LjLDrCTjguHCR6ofz+2t93+QT/rCH7lueETfID
	4jxIwvPPJsCTxPRiR8ynR9gzbWvFi8ScdYF/HQLEFEnyNIF9RFAk5AUrl20bWgn5HwfoFT9CebN
	dhrBDVuuXAiTG19tMI3z58BlQqahl44wZYRJ/MiWVjn10HDnnxmRaZOiCLExmap/BkBjarfS6oe
	x+Bw9cCdY6WpFgw0yyTFkDJq7a2dUbwu6hW/IiQImbwh4VOJ6SWxCTSaiRL/BxIAf6WLoGYek85
	znLXpDxkJ2Za9FA==
X-Google-Smtp-Source: AGHT+IG/hefWtYD1eWDIgqXND7NoDeahDYRYO+aregWjbaemborHNsSsAqKvTHzqRzE275+MxG7UTQ==
X-Received: by 2002:a17:907:7e81:b0:afd:c31c:2488 with SMTP id a640c23a62f3a-afdf01ba466mr190898066b.39.1755690176321;
        Wed, 20 Aug 2025 04:42:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:42:55 -0700 (PDT)
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
Subject: [PATCH v3 0/6] thermal: tegra: add SOCTHERM support for Tegra114
Date: Wed, 20 Aug 2025 14:42:25 +0300
Message-ID: <20250820114231.150441-1-clamor95@gmail.com>
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
---

Svyatoslav Ryhel (6):
  soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
  dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
    System
  thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
    support
  dt-bindings: thermal: tegra: add Tegra114 soctherm header
  thermal: tegra: add Tegra114 specific SOCTHERM driver
  ARM: tegra: Add SOCTHERM support on Tegra114

 .../thermal/nvidia,tegra124-soctherm.yaml     |   2 +
 arch/arm/boot/dts/nvidia/tegra114.dtsi        | 197 ++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c         | 122 ++++++++++
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/soctherm-fuse.c         |  31 ++-
 drivers/thermal/tegra/soctherm.c              |   6 +
 drivers/thermal/tegra/soctherm.h              |  12 +-
 drivers/thermal/tegra/tegra114-soctherm.c     | 211 ++++++++++++++++++
 drivers/thermal/tegra/tegra124-soctherm.c     |   6 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   6 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   6 +
 .../dt-bindings/thermal/tegra114-soctherm.h   |  20 ++
 12 files changed, 610 insertions(+), 10 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
 create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h

-- 
2.48.1


