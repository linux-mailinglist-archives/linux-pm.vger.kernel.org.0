Return-Path: <linux-pm+bounces-19944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FFAA00C27
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F455164305
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AF1FBEB3;
	Fri,  3 Jan 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZtVRxumZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0959B71
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922312; cv=none; b=PloZjdtBEm60vyNtk7Piaazs5Ze5Q26Z7w1tRCAP0YWtKcwKyqZ/8NeJQosPUPGV9icZ3nmv6HqGKqNqLAXNlZAtRQWdstzbkzgqU4Gyh8PHLTt/98eZjpmkiHfLymoyalX6WbSvChc+GjFwhQJ8dvwDMQOms/EPe3pfxrvXVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922312; c=relaxed/simple;
	bh=yivWCk87L5Kn1vLLCLSBD23i/m0z9LXbY0astKk0t14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+ZLwaAzGmZxvddngjpCrv+5AmgYZqt/JvQLax+nUOkQ27SLUOR2EBdF+fiQQl7JwyviTFlzKsjMkhLGF4FpoEsvQXVAH5sX3H05AwAtvjeraj8p/Q3Ulz9dhpbsYgVKQEo2b4VffRgjyNcKSQgRHTIAzYQK+A4NY2kn1obct/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZtVRxumZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1966672566b.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735922308; x=1736527108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z12n6pwBuO+Lp/RU6Y/RGTOaXGSjqsnsbDrc/bXr6NI=;
        b=ZtVRxumZi6oAhVXSSG6Z9GCRYi7LXtt+pArtl/iylPnSZQtPviVxWoDbiUNgXEHAWj
         BesXaS3E2LRXKY7r/lp+9inSCoN4ZdJi1IJb25/dUWYY9LJHEf6pYoumM3kplxK8zPQ7
         98ccXllrKaXDCpelj8IRmDNg2cr9XcAE36Jn+mB0+7BVJa0BE+7GHo7fpedpx0mU9plh
         j2nilDpNY/hOTaJh0d7G82Jmaf6T5FdOEw/NhmzvwJP9/vYXK8YIsGY/zLh5Y6+q8bql
         YkQl8J+Y7zaBfna2NkQL5+2oVjoZFf+HlAKHDiqwMK2Xzw7bwYKrh4/Ks6VloIHwNwtn
         2peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922308; x=1736527108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z12n6pwBuO+Lp/RU6Y/RGTOaXGSjqsnsbDrc/bXr6NI=;
        b=gvUuyUEnZlayCXmH6YL0cbFOGXlbU4kvS1ewAl2yq7xMojiQAJPNB6okPUHywBIogr
         Jjp1o06gL2/XbA+2t2ANSFdrlMACOIjAvcWbEBmeoKn7D78pcdpi52jU1o3J12CZMkWN
         aQYZKvBEOBITxjTvOTfifutoamsGcyJhudNtKnAYJH2msFzEyZD/WxrDR5mrs5oab7B+
         EAYuR03g19Gtn5F/gZ5vvhtO6AKz/F0dLZzi4kNgvzcKGmN3fp/nRj2uimp88cxCMRcs
         nJ9IhvmqLw+vm4yZKz0jzsz4G+XC/yitZegKTBmbbEhCPc+Y9RdlIqtK7FPHnieVWmMh
         0suw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwAl7cWHN78EF9zoVOHujwS5EVRqb4yWH6Yer9EyEhbWR8f6XRYwWmhulQ4Bz8zMufSln2h6gNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oROghYf5kyX+5UGPNIubrbLpxVoxZwHdnonD4iDE8PU7mqPd
	2zde7v+D4C8/Kx1QVASMlqTl8tqq7+VU5bPCoFl10C0V3WYS1bKXCf7BL3MRahU=
X-Gm-Gg: ASbGnctA8w2C9icNXkkpZQhrNl/x+0iZ3w5vzO5Rf2XAQRNYqSXsiUgsWg6Dt3ku1o9
	FNIbu78wAitZP5G3okBcYUR4P9BA7OkM7G0M/HCpK7NWt0PioqRZ0gmKkXv3RYeMKDxcaI38ME+
	jthkGCTgKkWIiVMQItb7LhU0vNfjohpf5MZeC82Kg/G8/VAwbcmGrYlEsIUwWjQKQXR+M+sx66S
	KcCg/FCGnsHVV/tKbrPvw76sgq0QaCWyHvoKGetwaFF+0mI3xwws1LmvGKHPzrF84hJWbMxjrN3
	u+1JGjEfAbQ=
X-Google-Smtp-Source: AGHT+IHvB3jSYSwVEdM8kpizh++WgojhHChTKlXDXhzjvg/G2jGnSPtOR2X4YibeMuE1jT2+Wk3xTg==
X-Received: by 2002:a17:907:7dab:b0:aa6:98c9:aadc with SMTP id a640c23a62f3a-aac2d45fb01mr4593376466b.31.1735922308221;
        Fri, 03 Jan 2025 08:38:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8953b6sm1932984066b.65.2025.01.03.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:38:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/6] thermal: renesas: Add support for RZ/G3S
Date: Fri,  3 Jan 2025 18:37:59 +0200
Message-ID: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds thermal support for the Renesas RZ/G3S SoC.

Series is organized as follows:
- patch 1/6:		adds clock, resets and power domain support for
			the thermal sensor unit (TSU)
- patch 2/6:		adds support for non-devres thermal zone
			register/unregister 
- patches 3-4/6:	add thermal support for RZ/G3S
- patches 5-6/6:	add device tree support

Merge strategy, if any:
- patch 1/6 can go through the Renesas tree
- patches 2-4/6 can go through the thermal tree
- patches 5-6/6 can go through the Renesas tree

Ulf,

I've added you to this thread as well due to patch 2/6 that has a similar
root cause as [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (6):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the TSU IP
  thermal: of: Export non-devres helper to register/unregister thermal
    zone
  dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
  thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add TSU node
  arm64: defconfig: Enable RZ/G3S thermal

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  43 ++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   4 +
 drivers/thermal/renesas/Kconfig               |   8 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c       | 301 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  |   8 +-
 include/linux/thermal.h                       |  14 +
 11 files changed, 476 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

-- 
2.43.0


