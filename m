Return-Path: <linux-pm+bounces-17729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E319D14FA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9547D1F2353C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC0F1BC077;
	Mon, 18 Nov 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuCy5bZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68104199EBB
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945891; cv=none; b=m3gzb9b4Hpfp6tNbn5a/TQGu/YNH1Q03awilt9dtiFZ8c7YDZAeaC1mP7WCZl3Qr27rYc5AmlGbWcomoEdYmMRD/VpKtT4fevl9my51s81t86tkdIi9mb8aCC9rLS2XQJUgX8j2XS458hs771sWLJOU6sjSPe6GVZ2tkl0pVj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945891; c=relaxed/simple;
	bh=T0v5StaSRjfBhvrabVXlxuCF8Qiemfgf57ndxphCAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWZtJadkF0MoKSB4bXO7+WBXOiBRsqP0iP9SAhCxQ6u4BVojx2BNk4lveFoRfRoN+KtZG65qEWoVcR1IfJZBqbGk8ndZR6OhoRFr48BwOgARpkbMyog1e2ackx0QxBzDtc1cjORVdSGAl1ZYMehCFsp5JTIFOiiB8E4dzY8Eo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuCy5bZs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da22c5863so4726546e87.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731945887; x=1732550687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFCqTpO5hD3gV9Gw4+aN5wSpGMUVExHmp0FBXsCj+e0=;
        b=yuCy5bZseU9YFv72VbruAa1iRn/ulmeWIv5M3Hjgqy294Ak59bsrIoHjN0USFUMG2h
         XPhz9nLk0WkXrA5Wv6GgNeFe/+GIDq3uKknngc09F9/ko4AnmUowAZBeT2a1luakzcj6
         MwgIVIzedyAtwjcXQ0UtcP22DlfBmjlHCFTtbDm8JboqlSMOyATF/TJeqj3reNvC+nFJ
         JelPy2T1oFCls7Ep++QrVUashZMTUoQkDMxJ4flaDEtLLS3cP06rPCzj98atUcaZoV18
         kJu2Y9pfHH5Q+BeFlikkCrxEfM9Ibxw4xCFFC26DT5qle++pq6Xi8nM6olvimkSpA0DH
         DmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945887; x=1732550687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFCqTpO5hD3gV9Gw4+aN5wSpGMUVExHmp0FBXsCj+e0=;
        b=KFjKnKPpo+EXywS8a00Guc4SbF3RlALJMgb4859f3JjRNleZc5rH7CJYw+eGNHyAS1
         AtvuItZL9ugvECxe6DICYrpWi8QIsCVSidhnBWp7oRBfwxAKb2hZuktsAKBHVroQXuhk
         N4RzvoU/oDLsi9VoK+O2LRZIGV2ARWGEZkikfGqd0QKGJXIKdOVHkWRraHOs2EPVHHTw
         TuNptyJVgRuAPYOARyirQRzf5WQs03BS9NxUu2xwjjRy2Qa7hh/JsReOWuR3uOAohLGF
         uaeo8JUVGXrkVoZMiqnU/7t1aMbm6jRyY2HA7UvEQX5Z5tNv9V87CyXJp+U3BrKVSuze
         ETTg==
X-Forwarded-Encrypted: i=1; AJvYcCWXOsOoEPFmkwQ+SAyMLB47u5L6ZcB/K5Z1uMclA01IwNuSn6RjQVnmqIgP1PMrawsrs2VAXL/luQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc62ELC7COvGWI6G5H6c2Tg8nStO7WihifG2qFjuq/rE5xIarW
	RDx3IhMr7uePQHlhUoP30sdZ1BHXvFOu78nIYAexkXeHEh4U1yoD7WiWpxN49US5uuvxfSYSwE+
	6
X-Google-Smtp-Source: AGHT+IGd4eVkYYJwl96txBLQUWoJ/8rW9jwI1uP17ARS3pwojFY5Z+QVuAfMzsRsnsHNz1ibQ9S7Ig==
X-Received: by 2002:a05:6512:39c7:b0:52f:ca2b:1d33 with SMTP id 2adb3069b0e04-53dab29e8e1mr5424291e87.20.1731945887460;
        Mon, 18 Nov 2024 08:04:47 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f9c0dsm1674649e87.35.2024.11.18.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:04:46 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.13
Date: Mon, 18 Nov 2024 17:04:44 +0100
Message-ID: <20241118160444.161917-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with the pmdomain updates for v6.13. Details about
the highlights are as usual found in the signed tag.

Note that, this time there is also a signed-tag that I have pulled from Mark's
regulator tree.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d2fab3fc27cbca7ba65c539a2c5fc7f941231983:

  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag (2024-11-12 19:45:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13

for you to fetch changes up to 5812b95b7ff47d2ccc07b8f050652604ac54cdcf:

  pmdomain: Merge branch fixes into next (2024-11-12 19:46:55 +0100)

----------------------------------------------------------------
pmdomain core:
 - Set the required dev for a required OPP during genpd attach
 - Add support for required OPPs to dev_pm_domain_attach_list()

pmdomain providers:
 - ti: Enable GENPD_FLAG_ACTIVE_WAKEUP flag for ti_sci PM domains
 - mediatek: Add support for MT6735 PM domains
 - mediatek: Use OF-specific regulator API to get power domain supply
 - qcom: Add support for the SM8750/SAR2130P/qcs615/qcs8300 rpmhpds

pmdomain consumers:
 - Convert a couple of consumer drivers to *_pm_domain_attach|detach_list()

opp core:
 - Rework and cleanup some code that manages required OPPs
 - Remove *_opp_attach|detach_genpd()

----------------------------------------------------------------
Chen-Yu Tsai (3):
      regulator: Add of_regulator_get_optional() for pure DT regulator lookup
      regulator: Add devres version of of_regulator_get_optional()
      pmdomain: mediatek: Use OF-specific regulator API to get power domain supply

Dario Binacchi (1):
      pmdomain: imx: gpcv2: replace dev_err() with dev_err_probe()

Dmitry Baryshkov (2):
      dt-bindings: power: rpmpd: Add SAR2130P compatible
      pmdomain: qcom: rpmhpd: add support for SAR2130P

Jishnu Prakash (1):
      pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750

Rob Herring (Arm) (1):
      pmdomain: imx: Use of_property_present() for non-boolean properties

Taniya Das (1):
      dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains

Thomas Richard (1):
      pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP flag for all PM domains

Tingguo Cheng (4):
      dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh power domains
      dt-bindings: power: qcom,rpmpd: document qcs615 RPMh power domains
      pmdomain: qcom: rpmhpd: Add qcs8300 power domains
      pmdomain: qcom: rpmhpd: Add qcs615 power domains

Ulf Hansson (17):
      Merge tag 'regulator-of-get-optional' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      OPP: Rework _set_required_devs() to manage a single device per call
      PM: domains: Support required OPPs in dev_pm_domain_attach_list()
      pmdomain: core: Manage the default required OPP from a separate function
      pmdomain: core: Set the required dev for a required OPP during genpd attach
      OPP: Drop redundant code in _link_required_opps()
      drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
      media: venus: Convert into devm_pm_domain_attach_list() for OPP PM domain
      cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
      OPP: Drop redundant *_opp_attach|detach_genpd()
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next

Yassine Oudjana (2):
      dt-bindings: power: Add binding for MediaTek MT6735 power controller
      pmdomain: mediatek: Add support for MT6735

Zhang Zekun (2):
      pmdomain: ti-sci: Add missing of_node_put() for args.np
      pmdomain: ti-sci: Use scope based of_node_put() to simplify code.

 .../bindings/power/mediatek,power-controller.yaml  |   1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   4 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   1 +
 drivers/base/power/common.c                        |  21 ++-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |  82 +++------
 drivers/gpu/drm/tegra/gr3d.c                       |  39 +---
 drivers/media/platform/qcom/venus/core.c           |   8 +-
 drivers/media/platform/qcom/venus/core.h           |   6 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |  44 ++---
 drivers/opp/core.c                                 | 199 +++++----------------
 drivers/opp/of.c                                   |  39 +---
 drivers/opp/opp.h                                  |   5 +-
 drivers/pmdomain/core.c                            |  76 ++++++--
 drivers/pmdomain/imx/gpc.c                         |   4 +-
 drivers/pmdomain/imx/gpcv2.c                       |   4 +-
 drivers/pmdomain/mediatek/mt6735-pm-domains.h      |  96 ++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  17 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   2 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  87 +++++++++
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |  25 ++-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/devres.c                         |  39 ++++
 drivers/regulator/internal.h                       |  18 +-
 drivers/regulator/of_regulator.c                   |  51 +++++-
 .../power/mediatek,mt6735-power-controller.h       |  14 ++
 include/dt-bindings/power/qcom-rpmpd.h             |   2 +
 include/linux/pm_domain.h                          |   9 +
 include/linux/pm_opp.h                             |  42 +----
 include/linux/regulator/consumer.h                 |  37 ++++
 include/linux/soc/mediatek/infracfg.h              |   5 +
 30 files changed, 569 insertions(+), 412 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt6735-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt6735-power-controller.h

