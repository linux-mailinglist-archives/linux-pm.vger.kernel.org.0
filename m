Return-Path: <linux-pm+bounces-14352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7097ABA1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 08:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D38284D44
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 06:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43C62171;
	Tue, 17 Sep 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WowDyOFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A4136347
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555620; cv=none; b=SpqFMLnVw/qvy/eEB/xXjE6415h6fDBCsP6xUpYaSaWOPFodfUjQgYOcfTAqW06Rw6YASTQoEduKm4U+5EWadn5M61H9qTcVO28DbYQyc0wErAK45HFky8I1VC9NdauUO/hgjtfWfFdAVL6UU2OJj1qlast3vmkWpKMgA8WRHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555620; c=relaxed/simple;
	bh=3qYSaumupE0TiIcflJEfJZ5Ni8Ktwd0CDC3Y6V0vkL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W6K515L8Ia2nV2bDT6yPjJQr5Qs1vG6IyaS0L+yQA76Nb8QuTh0tDWQXMraGC/XjBSkKdZ0Z/c5gc+zg+jPdPMfzY32SSMjCFuWZAYboT3MHbdiqKEVQA/ccln8p/wytA5RDTyF1BJsnfBCvNZa8jVGhPL26AljfBCO3KYRWyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WowDyOFo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso34116261fa.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2024 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726555616; x=1727160416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXTewivgLsmzlJ+30gpbLxMHkptTIEQ1/3gFwAu9U9g=;
        b=WowDyOFo+hhKlPFkxpP4QhDXmjGYiKgx2/vfSmV8ySqRzzW0M2SIliqu+oaOxUNq14
         rqWQyfz9h/oRzH2kP3gcGTA9772NzYLP2ERSUn1cxnMFMuvzjTI2vFKPZ5r51rnRQ0Re
         v7UVPeFxA8Dwf7rNm9T1jBECtX9equGVbUG9eenWxMoMbTTMQkZQz/mJDnczaq2sPHlY
         5d9XAD/NgCLrJ+TwMU7BLln/UGvzm/Luh9f7S8j/gRA4YeIh0qUlcgHy/Xe6zKBOVEVS
         uiREdp0PkLJiqpGSVjWbzvFRn85dk529dOecAaiaRxJnPbObyVfCaJDOk5Qxc3jqszk9
         MtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726555616; x=1727160416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXTewivgLsmzlJ+30gpbLxMHkptTIEQ1/3gFwAu9U9g=;
        b=mfCH7YzKwtGTA+iwp+/p0JFo6y94JjpTM9LtEixezbESwUSZtGb9SS7bMR7uVz/1wi
         wnfrUDlDAjKBkxVJyKCYs0ZgZ7MHw3D0DAj1GjqBhpYwfWZDyAOhB0ZJRjR+oYFV3k1i
         x0clocVOAg4iolMt4QO2VUQyN3h5Wb28FodDaFT+vH8z/67xXQOarD35QPgv2EGCeeY4
         gK+Kt3fY67/Zjepwylk7PMY04oaLOn+LYKugnFdXFvogpJ88QJkpYMv9xXKyAKllFehZ
         sPpPPF6l0dnnJB0tzB9ImdpYmIlY2Gm9D6XoX4syydT4+NmNIlzkX+xhMhlIZYSpQ2C2
         izCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmusfd3wn+aWLW1P1Sp8i5ip2S7oS5yi3wKxDgmI0mVfaU/piimchtOszBnqG8MUBMFPvtKjWdWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VE/CZLBWFeAWCcjiN4kvgBP37SYa2bxTnmLm+3vX1IJnryhM
	6mrAtK7DPA2+exjIzxtCHQRTBVFvN8rltNQY+PVXPerJEttCqH04JWigJN/8ME8=
X-Google-Smtp-Source: AGHT+IEglrlFdhDfUYd/C+Psw6SFttmg3CHticZ+MtCVdGeQeVedABPIgDd5SqDuLTpTdmpAiMUcJA==
X-Received: by 2002:a05:6512:4020:b0:536:533c:c460 with SMTP id 2adb3069b0e04-5367ff295a6mr6115881e87.50.1726555616322;
        Mon, 16 Sep 2024 23:46:56 -0700 (PDT)
Received: from uffe-tuxpro14.. ([2a02:1406:5f:cdf3:9745:768d:3d6:b1bb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096816sm1090542e87.177.2024.09.16.23.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:46:55 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.12
Date: Tue, 17 Sep 2024 08:46:53 +0200
Message-Id: <20240917064653.4226-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the PR with pmdomain and cpuidle-psci updates for v6.12. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9ec87c5957ea9bf68d36f5e098605b585b2571e4:

  OPP: Fix support for required OPPs for multiple PM domains (2024-08-23 11:57:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12

for you to fetch changes up to c6ccb691d484544636bc4a097574c5c135ccccda:

  pmdomain: core: Reduce debug summary table width (2024-09-13 13:41:33 +0200)

----------------------------------------------------------------
pmdomain core:
 - Add support for s2idle for CPU PM domains on PREEMPT_RT
 - Add device managed version of dev_pm_domain_attach|detach_list()
 - Improve layout of the debugfs summary table

pmdomain providers:
 - amlogic: Remove obsolete vpu domain driver
 - bcm: raspberrypi: Add support for devices used as wakeup-sources
 - imx: Fixup clock handling for imx93 at driver remove
 - rockchip: Add gating support for RK3576
 - rockchip: Add support for RK3576 SoC
 - Some OF parsing simplifications
 - Some simplifications by using dev_err_probe() and guard()

pmdomain consumers:
 - qcom/media/venus: Convert to the device managed APIs for PM domains

cpuidle-psci:
 - Add support for s2idle/s2ram for the hierarchical topology on PREEMPT_RT
 - Some OF parsing simplifications

----------------------------------------------------------------
Dario Binacchi (3):
      pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
      pmdomain: imx93-pd: don't unprepare clocks on driver remove
      pmdomain: imx93-pd: drop the context variable "init_off"

Detlev Casanova (2):
      pmdomain: rockchip: Add gating support
      pmdomain: rockchip: Add gating masks for rk3576

Dikshita Agarwal (2):
      PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
      media: venus: use device managed APIs for power domains

Finley Xiao (2):
      dt-bindings: power: Add support for RK3576 SoC
      pmdomain: rockchip: Add support for RK3576 SoC

Geert Uytterhoeven (4):
      pmdomain: core: Harden inter-column space in debug summary
      pmdomain: core: Fix "managed by" alignment in debug summary
      pmdomain: core: Move mode_status_str()
      pmdomain: core: Reduce debug summary table width

Hongbo Li (1):
      pmdomain: mediatek: make use of dev_err_cast_probe()

Jerome Brunet (1):
      pmdomain: amlogic: remove obsolete vpu domain driver

Jinjie Ruan (1):
      pmdomain: apple: Make apple_pmgr_reset_ops static

Krzysztof Kozlowski (11):
      cpuidle: psci: Simplify with scoped for each OF child loop
      cpuidle: dt_idle_genpd: Simplify with scoped for each OF child loop
      pmdomain: rockchip: Simplify with scoped for each OF child loop
      pmdomain: rockchip: Simplify locking with guard()
      pmdomain: imx: gpc: Simplify with scoped for each OF child loop
      pmdomain: imx: gpcv2: Simplify with scoped for each OF child loop
      pmdomain: qcom: cpr: Simplify with dev_err_probe()
      pmdomain: qcom: cpr: Simplify locking with guard()
      pmdomain: qcom: rpmhpd: Simplify locking with guard()
      pmdomain: qcom: rpmpd: Simplify locking with guard()
      pmdomain: rockchip: Simplify dropping OF node reference

Stefan Wahren (3):
      pmdomain: raspberrypi-power: Adjust packet definition
      pmdomain: raspberrypi-power: Add logging to rpi_firmware_set_power
      pmdomain: raspberrypi-power: set flag GENPD_FLAG_ACTIVE_WAKEUP

Ulf Hansson (11):
      pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
      pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
      pmdomain: core: Use dev_name() instead of kobject_get_path() in debugfs
      cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
      cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
      cpuidle: psci: Enable the hierarchical topology for s2ram on PREEMPT_RT
      cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next

Zhang Zekun (2):
      pmdomain: qcom-cpr: Use helper function for_each_available_child_of_node()
      pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.

 .../bindings/power/rockchip,power-controller.yaml  |   1 +
 drivers/base/power/common.c                        |  45 +++
 drivers/cpuidle/cpuidle-psci-domain.c              |  17 +-
 drivers/cpuidle/cpuidle-psci.c                     |  26 +-
 drivers/cpuidle/dt_idle_genpd.c                    |  14 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |   5 +-
 drivers/pmdomain/amlogic/Kconfig                   |  11 -
 drivers/pmdomain/amlogic/Makefile                  |   1 -
 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c       | 380 ---------------------
 drivers/pmdomain/apple/pmgr-pwrstate.c             |   2 +-
 drivers/pmdomain/bcm/raspberrypi-power.c           |  43 ++-
 drivers/pmdomain/core.c                            |  94 +++--
 drivers/pmdomain/imx/gpc.c                         |  14 +-
 drivers/pmdomain/imx/gpcv2.c                       |   8 +-
 drivers/pmdomain/imx/imx93-pd.c                    |  22 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |   6 +-
 drivers/pmdomain/qcom/cpr.c                        |  92 ++---
 drivers/pmdomain/qcom/rpmhpd.c                     |  11 +-
 drivers/pmdomain/qcom/rpmpd.c                      |  20 +-
 drivers/pmdomain/rockchip/pm-domains.c             | 118 +++++--
 include/dt-bindings/power/rockchip,rk3576-power.h  |  30 ++
 include/linux/pm_domain.h                          |  16 +-
 22 files changed, 373 insertions(+), 603 deletions(-)
 delete mode 100644 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

