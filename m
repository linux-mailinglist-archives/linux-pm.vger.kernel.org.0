Return-Path: <linux-pm+bounces-27680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE08AC4C67
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F93189EA48
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185025486D;
	Tue, 27 May 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPZIf2Pr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A72417C5
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342942; cv=none; b=K9sfSDATDncJB40XRoV8Ui/3Xs3As/jnUapBnuRPIuJGKHWMXMnknZFZENtYhLk26CaJVT7op2VbFR4wQc62nnf67Q5YeQH8JESfFXoJheRJeR/qXlf8/c1YifXE69Aknjhfa5BD49hb9kBIdzRmqwPlwOd9hO5s9tWvPoF5vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342942; c=relaxed/simple;
	bh=rT3q0/T/n/OdvtUzIiOBBIlKN3tNijY7T1rLOkW+cJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgJuzHEQ1UuqfqQE2Wgdsr8jz2mEktfMsXcNbVnk7zCVCWMla7whtGaBGMZc1pZMxZ+x4ynr+9yhfIRiAzJEibMM7QBG7RlNLddcLLoiJlMkctAWHPfcccvLeKLdNTlB7/mOlI0/055yPapg5VAp+s9e6eqJ7sZKuEmYFa/iSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPZIf2Pr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32934448e8bso32819821fa.3
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748342938; x=1748947738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vKSPPco8uaYslgb3qMpB6uZMQh78r5qUBilSeR1pXE=;
        b=NPZIf2PrvkpDNdTkUIqrut2Ru31geLumiZl7kyegRCZl9nnPkJEZNvXOkwkZ6yGDSg
         EdbWs/Ggzh8gyc5Z88xQUbMg+MVcobfX5jGPNR29r+WaIjM6cEKq1PBRPf/b3CP3y/yY
         Qi8gGmQti5XBazufep4U9Uk+udoPGJvoFm01y/+GfKwqVVn8xGbZq/wj/yg3+fLEMHtp
         YWhc85/B33j5c6h0w3JEfRmP7Jd4sxegT0SohBS4pnErbcDd/uMSx39FWj6++YxieBGx
         3ALxrPjFFPwk23KZEJ26J2i+LxvgS8pMi32AxR6p2lzOZV7RSwRZ13e0SgBOF6THJtJp
         BOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748342938; x=1748947738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vKSPPco8uaYslgb3qMpB6uZMQh78r5qUBilSeR1pXE=;
        b=um2U4o8d080mITL+R5y/N4oEM8KCZknE2VcQhze84U83fc8KJSLcIWhhBsRE9ORmqa
         7dJJxS5HDJp9ScUXyC9aUgiaHkdXjKq7MaLeIEyJtl2dkxfyFkPm9mY2QhGMqoRjygBr
         Ll2hGrmnbmbcztFKlL4DycO7YDVXokw0MvneXf3Frqd0bgyas8Jw4kPGwPo/rq4BWbKw
         RnJIa0vNLhwQtFxaEKcO+4azuDZHrdBNqMOrBvh3UCWBD1pPfawWWIK7z1Wsx6Zwzo6Y
         NWD6GMOEAYPv/g6mhNTJJipIECj+Yy4DjyC2uM7R9Eq7yTCR20HB6um/iCcqXmjAk9CM
         pl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm7Etr6OQdLaX/KGjv9jdIk2h1Ra2daGXcZDk7U+GOU1iz5q05Bc9+zLQaV2YlFym9TNyDU+qddA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycnlY6x8AdWjoRNKjjAKQdTZK94xENR6WL+4sP3qQXBrKKm5gM
	JxNhaxXZkdjLPmyY6PDFxWJ6sAVpc/IFtXGU0iaP5xlYu3YeNY5ZKVFnZqVoKkteAPs=
X-Gm-Gg: ASbGnctt4BAqXNenh3y50Nxg7+QgCHCmQQxYMqyYXA4gBicyYaflh3o8WSBFhqo5Ins
	mYOwi32NrdNsMnNyj64Vv6gIa/U2c8mQUjnT6yl7oJ8ApUdH3iLSnpZdrn8+AGtrL+ZDIcWO4NF
	2Bx1je7pOG1gGSZ45Rl0P2++d4U9w8DfwmrT5SEAWgECIJ2pWhtk0yGNwjRLbz2HfM3iwbvRJeW
	hSAf2dsTNLBm+M97iwi/H5+3JD5o60QtaRo1gpDZKXWwJUU+QypUO9kYwO39WXo19FGDIHVNuPw
	3PnmR90XW+m5Bi/EDs+CexUsRZV4cMJBYQ7b0xTocJfbQRggN9EX3wkF96dMMlPtqhN/IC4IAjK
	/YpoJ9yqsXfUl25FFXu6GJeIn0Q==
X-Google-Smtp-Source: AGHT+IE9g01utC6Y6xeS//vjJ++/Yn75a8WpLtE+4tobVTnoaHBMkS9DP3t1Hn0PzpUeqXgyM5sSjw==
X-Received: by 2002:a05:651c:146d:b0:30b:b7c3:949a with SMTP id 38308e7fff4ca-3295b9f26cfmr30739661fa.18.1748342938112;
        Tue, 27 May 2025 03:48:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a6cf9c68dsm2674441fa.58.2025.05.27.03.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 03:48:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.16
Date: Tue, 27 May 2025 12:48:56 +0200
Message-ID: <20250527104856.206797-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain and cpuidle-psci updates for v6.16.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe:

  pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id() (2025-05-08 13:29:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16

for you to fetch changes up to 36795548dcc841c73f03793ed6cf741a88130922:

  pmdomain: ti: Fix STANDBY handling of PER power domain (2025-05-19 16:11:05 +0200)

----------------------------------------------------------------
pmdomain core:
 - Add residency reflection for domain-idlestates to debugfs
 - Add genpd helper to correct the usage/rejected counters

pmdomain providers:
 - mediatek: Add support for Dimensity 1200 MT6893
 - qcom: Add support for SM4450 power domains
 - rockchip: Add support for RK3562 SoC
 - sunxi: Add support for Allwinner H6/H616 PRCM PPU
 - ti: Fix STANDBY handling of OMAP2+ PER power domain

cpuidle-psci:
 - Correct the domain-idlestate statistics in debugfs

----------------------------------------------------------------
Ajit Pandey (2):
      dt-bindings: power: qcom,rpmpd: Add SM4450 compatible
      pmdomain: qcom: rpmhpd: Add SM4450 power domains

Andre Przywara (2):
      dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
      pmdomain: sunxi: add H6 PRCM PPU driver

AngeloGioacchino Del Regno (3):
      dt-bindings: power: mediatek: Support Dimensity 1200 MT6893 MTCMOS
      pmdomain: mediatek: Bump maximum bus protect data array elements
      pmdomain: mediatek: Add support for Dimensity 1200 MT6893

Chen-Yu Tsai (1):
      pmdomain: mediatek: Add error messages for missing regmaps

Christophe JAILLET (1):
      pmdomain: amlogic: Constify some structures

Finley Xiao (2):
      dt-bindings: power: rockchip: Add support for RK3562 SoC
      pmdomain: rockchip: Add support for RK3562 SoC

Krzysztof Kozlowski (1):
      pmdomain: arm: Do not enable by default during compile testing

Stefan Wahren (1):
      pmdomain: bcm: bcm2835-power: Use devm_clk_get_optional

Sukrut Bellary (1):
      pmdomain: ti: Fix STANDBY handling of PER power domain

Ulf Hansson (15):
      pmdomain: core: Add genpd helper to correct the usage/rejected counters
      cpuidle: psci: Move the per CPU variable domain_state to a struct
      cpuidle: psci: Correct the domain-idlestate statistics in debugfs
      pmdomain: core: Add residency reflection for domain-idlestates to debugfs
      pmdomain: core: Reset genpd->states to avoid freeing invalid data
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: core: Convert to device_awake_path()
      pmdomain: Merge branch fixes into next
      pmdomain: core: Convert genpd_power_off() to void
      pmdomain: core: Simplify return statement in genpd_power_off()
      pmdomain: core: Use genpd->opp_table to simplify error/remove path
      pmdomain: Merge branch fixes into next

 .../power/allwinner,sun50i-h6-prcm-ppu.yaml        |  42 ++
 .../bindings/power/mediatek,power-controller.yaml  |   2 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   1 +
 .../bindings/power/rockchip,power-controller.yaml  |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c              |   2 +-
 drivers/cpuidle/cpuidle-psci.c                     |  40 +-
 drivers/cpuidle/cpuidle-psci.h                     |   4 +-
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  78 +--
 drivers/pmdomain/arm/Kconfig                       |   6 +-
 drivers/pmdomain/bcm/bcm2835-power.c               |  16 +-
 drivers/pmdomain/core.c                            | 131 +++--
 drivers/pmdomain/governor.c                        |   2 +
 drivers/pmdomain/mediatek/mt6893-pm-domains.h      | 585 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  17 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   2 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |  16 +
 drivers/pmdomain/rockchip/pm-domains.c             |  48 +-
 drivers/pmdomain/sunxi/Kconfig                     |  10 +
 drivers/pmdomain/sunxi/Makefile                    |   1 +
 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c        | 208 ++++++++
 drivers/pmdomain/ti/omap_prm.c                     |   8 +-
 include/dt-bindings/power/mediatek,mt6893-power.h  |  35 ++
 include/dt-bindings/power/rockchip,rk3562-power.h  |  35 ++
 include/linux/pm_domain.h                          |  10 +
 24 files changed, 1185 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
 create mode 100644 drivers/pmdomain/mediatek/mt6893-pm-domains.h
 create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
 create mode 100644 include/dt-bindings/power/mediatek,mt6893-power.h
 create mode 100644 include/dt-bindings/power/rockchip,rk3562-power.h

