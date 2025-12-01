Return-Path: <linux-pm+bounces-38996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE224C989DF
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066373A7049
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417593385B9;
	Mon,  1 Dec 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO7631K1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6433859B
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611493; cv=none; b=MR+rZPc75rn5/8oOgh/AFNZ1FBONQD1ErJsZQpwdmHh2XTHxwSYX7iAoFGbo9OtEszMC1+52G1OrZu2wrW9coF7zgTUsqw8rhF5woeMuLrJ8iFqvlm3AVJlbj/nYMkZ89NFxLVR/sAk19qiwzKwGaSxCYInk4DNTWr5P3mGVDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611493; c=relaxed/simple;
	bh=NWxBOV8G+uX6EdRDI3s/sdgxK15h9hF+3FIWvt4TO+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpapiUgg3yxHdpLdQ/+JYww87ZdevR03/MvZ8XCQp/RXte2X0y1PWyxMdON1/9FtTJST+yshl5Rjnx1AgMto3Tt13+9cLP/hNP9pdogF/sXKFUycGlIw2yFLCvE0rlXSV5WVKgxNxHPN6/YG4t5OvptrkD6hr1DxhC5dmn4HZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fO7631K1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957f617ff0so5108487e87.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764611489; x=1765216289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQAmSf/I/r1AJACdEyDQZKuMSYhZU2RwlU93Oa7O8sU=;
        b=fO7631K1tuyVb4hlRETIHVpdQ+y2ATigRfkKWLwfKrLFCbTZouPwUPZ/Yg24YuiGAV
         JNqnx4hh9k/Nc8VqDmO6KOO0u7IjpNSwud1dsr2xHytEXHfTXRvnO4kQ2b/DMFWwu1wy
         BlGyAxvpm0bUYVZZ/qE+UgLPPdPAUedNGimDcevMmeXmMzLL/YK7oPnWubjpJZa13gSF
         +Oaptora1czYPsbqBxm2Aam5BFnyHfEI50auh//BaKaMQOXz8qkZ75zRoVSlDSEXVzWP
         u6nHTd9dgdkox2fDPCSDHzTpqb0B+HAM73gFaaK2tff0aVammHaM46dliWz+ikBFf9WP
         ascw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611489; x=1765216289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQAmSf/I/r1AJACdEyDQZKuMSYhZU2RwlU93Oa7O8sU=;
        b=DxxtjwJYhdjq8ncLPIWIeNTiK3ijFx4xnY8wV4E23IMazCC2b8AlZeQxQHOKfsFzOy
         UyJddObkPeAmHf3aSQSL+rch62Mj6GsJm9r5qW5vVlyzMNcodjEV1dUFIiFbdr9H/JJs
         KGPb2vWNO/lqPWpIfE+aakBhnto2S4S1apfL2I23slxvMpJuWszUH4dXBNmxJSM+7wTh
         Z8NhzK/cQv4oMD3ewfkwzHl42KWKKHOvMgZ7AYI8pHOEACkP54VPpZew6f8sB2BkJLdA
         8+vs5edbLIgl9jCX3R71YjavQTBlXq8BZlVq+b5HGuDUrh3U50PQICRFpaADHlE3AzQf
         5weg==
X-Forwarded-Encrypted: i=1; AJvYcCX2bssxpa/LCFfj84wXBg8ZhlTF14kcrukU7YNoQM67S86z3T/ZdPH1Ns1EX1bEdcNXOL7gkC7phQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34OKch1Ly8pwGE+sqyQZZf4QarKOOkrnPBd+reAId3cFhWEWa
	5IT/NJ/9fDsUr8X86e4z3Zg7gHuGDlLPkSuS5qCy5CE+JTQUCq1ST81dH9oVaNKpxdHz3VxNoOY
	mCAiK
X-Gm-Gg: ASbGncuq5iRBPW4Zt0STSVuGVsoVc0ynGEX2RswofYzViD6n16POLKAtoVY/ah/jRsU
	D5qjutNP1fju3ZmZS4lLu+EEhzOD0lF3kF3vw+mTt+JJ/lKKsSS14q5PN03I/zp032GShPf6nyo
	r3ETNCXHlETRMk5aUfbH2FkZ5uQU8htsv71ankBgMOlb3tdJXn8uijJFX/gZHwn1NyfZ9Bffd2r
	lCEg/TFKIaWk4XLkpj1sUDzv7ddmwMFojTahPtVFJU/ms1b9RZY21X3e1+zwxR5a8pXEuATsIyI
	yND6F3mibi1ziKFmdi6TpzPEBXi7KUTmiirRirP7nTBt6AEgD2EpSZu+or712zQB/0X1Rhp1ogE
	8Cp8LaOr2qumgGViaa/fRrzF00EHfzyYOkMdwzoDsAdjQSGURKbcsEa6ceIfUrCTYDyWOA0wKyL
	TaRfv1ZulJoNo7B4o+dCrVnFyyGAl/uG53neV7NBF2GAUWSCvCY70kwecn3dGy
X-Google-Smtp-Source: AGHT+IGJ/2qcLJ93I8tQ9xcZfNdaAnY6D2Sz4qECv7ecbOoK2+SCkO7fr0vpFnxNjafmmj1k2a9cOA==
X-Received: by 2002:a05:6512:104f:b0:593:f74:9088 with SMTP id 2adb3069b0e04-596a3ee5881mr12619568e87.43.1764611488885;
        Mon, 01 Dec 2025 09:51:28 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa48f7bsm3731430e87.85.2025.12.01.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:51:28 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.19
Date: Mon,  1 Dec 2025 18:51:25 +0100
Message-ID: <20251201175125.34284-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain and cpuidle-psci updates for v6.19.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c98c99d5dbdf9fb0063650594edfd7d49b5f4e29:

  pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag (2025-11-24 11:14:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19

for you to fetch changes up to 1f67707fafa598e2338dba08e3de0db3e468afd1:

  pmdomain: Merge branch fixes into next (2025-11-24 11:14:36 +0100)

----------------------------------------------------------------
pmdomain core:
 - Allow power-off for out-of-band wakeup-capable devices
 - Drop the redundant call to dev_pm_domain_detach() for the amba bus
 - Extend the genpd governor for CPUs to account for IPIs

pmdomain providers:
 - bcm: Add support for BCM2712
 - mediatek: Add support for MFlexGraphics power domains
 - mediatek: Add support for MT8196 power domains
 - qcom: Add RPMh power domain support for Kaanapali
 - rockchip: Add support for RV1126B

pmdomain consumers:
 - usb: dwc3: Enable out of band wakeup for i.MX95
 - usb: chipidea: Enable out of band wakeup for i.MX95

----------------------------------------------------------------
AngeloGioacchino Del Regno (5):
      dt-bindings: power: Add support for MT8196 power controllers
      pmdomain: mediatek: Add support for Hardware Voter power domains
      pmdomain: mediatek: Add support for secure HWCCF infra power on
      pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
      pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains

Brian Masney (1):
      pmdomain: mediatek: convert from clk round_rate() to determine_rate()

Claudiu Beznea (1):
      amba: bus: Drop dev_pm_domain_detach() call

Finley Xiao (2):
      dt-bindings: power: rockchip: Add support for RV1126B
      pmdomain: rockchip: Add support for RV1126B

Jishnu Prakash (3):
      dt-bindings: power: qcom,rpmpd: document the Kaanapali RPMh Power Domains
      dt-bindings: power: qcom,rpmpd: add new RPMH levels
      pmdomain: qcom: rpmhpd: Add RPMh power domain support for Kaanapali

Nicolas Frattaroli (3):
      dt-bindings: power: Add MT8196 GPU frequency control binding
      pmdomain: mediatek: Add support for MFlexGraphics
      pmdomain: mediatek: mtk-mfg: select MAILBOX in Kconfig

Peng Fan (4):
      PM: wakeup: Add out-of-band system wakeup support for devices
      pmdomain: core: Allow power-off for out-of-band wakeup-capable devices
      usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
      usb: dwc3: imx8mp: Set out of band wakeup for i.MX95

Stanimir Varbanov (2):
      dt-bindings: soc: bcm: Add bcm2712 compatible
      pmdomain: bcm: bcm2835-power: Prepare to support BCM2712

Thorsten Blum (1):
      cpuidle: psci: Replace deprecated strcpy in psci_idle_init_cpu

Ulf Hansson (5):
      pmdomain: Merge branch dt into next
      pmdomain: mediatek: Fix build-errors
      smp: Introduce a helper function to check for pending IPIs
      pmdomain: Extend the genpd governor for CPUs to account for IPIs
      pmdomain: Merge branch fixes into next

Xu Yang (1):
      usb: chipidea: core: detach power domain for ci_hdrc platform device

 .../bindings/power/mediatek,mt8196-gpufreq.yaml    |  117 +++
 .../bindings/power/mediatek,power-controller.yaml  |    4 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../bindings/power/rockchip,power-controller.yaml  |    2 +
 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml          |   38 +-
 drivers/amba/bus.c                                 |    9 +-
 drivers/base/power/main.c                          |    1 +
 drivers/cpuidle/cpuidle-psci.c                     |    4 +-
 drivers/pmdomain/bcm/bcm2835-power.c               |   17 +-
 drivers/pmdomain/core.c                            |    6 +-
 drivers/pmdomain/governor.c                        |   20 +-
 drivers/pmdomain/mediatek/Kconfig                  |   17 +
 drivers/pmdomain/mediatek/Makefile                 |    1 +
 drivers/pmdomain/mediatek/mt8196-pm-domains.h      |  625 ++++++++++++
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       | 1044 ++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  306 +++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   49 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |   28 +-
 drivers/pmdomain/rockchip/pm-domains.c             |   41 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   11 +-
 drivers/usb/chipidea/core.c                        |    3 +
 drivers/usb/dwc3/dwc3-imx8mp.c                     |    9 +-
 include/dt-bindings/power/mediatek,mt8196-power.h  |   58 ++
 include/dt-bindings/power/qcom,rpmhpd.h            |    3 +
 .../power/rockchip,rv1126b-power-controller.h      |   17 +
 include/linux/pm.h                                 |    1 +
 include/linux/pm_wakeup.h                          |   17 +
 include/linux/smp.h                                |    5 +
 include/linux/usb/chipidea.h                       |    1 +
 kernel/smp.c                                       |   22 +
 30 files changed, 2417 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
 create mode 100644 drivers/pmdomain/mediatek/mt8196-pm-domains.h
 create mode 100644 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
 create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h
 create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power-controller.h

