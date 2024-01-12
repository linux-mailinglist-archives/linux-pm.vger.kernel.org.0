Return-Path: <linux-pm+bounces-2155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9B82BF4A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB2AB23281
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813E67E8C;
	Fri, 12 Jan 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL6cXz5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6164CFF
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2cd81b09e83so25424631fa.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705059325; x=1705664125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLLLZtRWRR9zlGYQC39xa+xg/K5MiiV69+VuvJLo81M=;
        b=PL6cXz5GZZoHW7YNz4scm+5QcwRkM4e3irj+N6PPo1SjuqjajtOC9fSGJf2I+SSpVK
         9oMTA2Gf755kR0Id5DsKXyb4JnijksNjm//HidcI9uYhaDajk3gpPWXSmVWpJ/Jwhobk
         XpMzxzFRoSXxwPEEOfHWxthv7iHDpO7yFyU+Jay7nMu2SoC8ZRdKga+VjVl6XjfVeuRi
         SXsM0bWrAngviqwk9LjroGATb6Aj9dre/SKzgSM/utFMQdmnRP9pQZmH6g7nVh6Zdh9X
         A9DWRw36zlbNKmBgWGASKGNeBTbJTxg/oFtldU/NdD5OHvv65eIcNsGnP6Kf7DOOCNEG
         2sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705059325; x=1705664125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLLLZtRWRR9zlGYQC39xa+xg/K5MiiV69+VuvJLo81M=;
        b=HbHlVuZT8O+1+7HJYBlAEYQQN5g8h1lc7G6ezvmgrn6d4vR/Yy003s2hOlB4RfgkQV
         D8wpLqjd5aPYNsk54W0ICDSQF65VQf1402VtFvZr/7rjMovXfI+2xtfNDn+sgeo9NFrj
         Wb1YUNuC/wXy95fLhlagQYyVqytuPR3oQbVVEI/A+JKMokmp4hi3zTRbLCJDs9VLrh6Z
         VFaPTvtMyXWsbqgSNTk+jKYoUevPIZUecLwi1YZsBqcvqvLhLxOH9eAhsRBC0EkcsE+b
         ILDyNKni6waeKWfN43k905i/9Gt4zzTr+BAEOnXvTey8ZAwLW9slr+52SFJQZs9um/Fe
         RyQg==
X-Gm-Message-State: AOJu0Yzlg2cYyRC68UpJTHns8E6ac6n/HVvKDjfX95t4mgtVUQ98XI6i
	iMMxSWcigK3BhVGW3muw07Epr0zdT8mf+bEhtIMga823rryxNsNa
X-Google-Smtp-Source: AGHT+IHhJdTRptmTseXNxOVJdsEd4oAiOFk5i380OeV8nJeJ0AJhyeocMNNQ0NNUeDgyE90Dancmew==
X-Received: by 2002:ac2:58fa:0:b0:50e:4e1c:26a6 with SMTP id v26-20020ac258fa000000b0050e4e1c26a6mr282329lfo.104.1705059324669;
        Fri, 12 Jan 2024 03:35:24 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id bp7-20020a056512158700b0050e902ce211sm467911lfb.276.2024.01.12.03.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:35:24 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.8
Date: Fri, 12 Jan 2024 12:35:23 +0100
Message-Id: <20240112113523.44456-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain updates for v6.8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0cb19e50a911aaadf49eed120392e429d6e1fa0c:

  pmdomain: arm: Avoid polling for scmi_perf_domain (2023-11-27 16:28:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8

for you to fetch changes up to d6948c13b663a284574cb9e502dd663e70d910e8:

  PM: domains: Move genpd and its governor to the pmdomain subsystem (2023-12-18 12:49:48 +0100)

----------------------------------------------------------------
Core:
 - Move the generic PM domain and its governor to the pmdomain subsystem
 - Drop the unused pm_genpd_opp_to_performance_state()

Providers:
 - Convert some providers to let the ->remove() callback return void
 - amlogic: Add support for G12A ISP power domain
 - arm: Move the SCPI power-domain driver to the pmdomain subsystem
 - arm: Move Kconfig options to the pmdomain subsystem
 - qcom: Update part number to X1E80100 for the rpmhpd

----------------------------------------------------------------
Neil Armstrong (2):
      dt-bindings: power: meson-g12a-power: document ISP power domain
      pmdomain: amlogic: meson-ee-pwrc: add support for G12A ISP power domain

Randy Dunlap (1):
      PM: domains: fix domain_governor kernel-doc warnings

Sibi Sankar (2):
      dt-bindings: power: rpmpd: Update part number to X1E80100
      pmdomain: qcom: rpmhpd: Update part number to X1E80100

Sudeep Holla (2):
      pmdomain: arm_scmi: Move Kconfig options to the pmdomain subsystem
      firmware: arm_scpi: Move power-domain driver to the pmdomain dir

Ulf Hansson (5):
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
      PM: domains: Drop redundant header for genpd
      PM: domains: Move genpd and its governor to the pmdomain subsystem

Uwe Kleine-König (9):
      pmdomain: imx-pgc: Convert to platform remove callback returning void
      pmdomain: imx-gpc: Convert to platform remove callback returning void
      pmdomain: imx-gpcv2: Convert to platform remove callback returning void
      pmdomain: imx8m-blk-ctrl: Convert to platform remove callback returning void
      pmdomain: imx8mp-blk-ctrl: Convert to platform remove callback returning void
      pmdomain: imx93-blk-ctrl: Convert to platform remove callback returning void
      pmdomain: imx93-pd: Convert to platform remove callback returning void
      pmdomain: qcom-cpr: Convert to platform remove callback returning void
      pmdomain: xilinx/zynqmp: Convert to platform remove callback returning void

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  2 +-
 MAINTAINERS                                        | 10 +-----
 drivers/base/power/Makefile                        |  1 -
 drivers/firmware/Kconfig                           |  9 ------
 drivers/firmware/Makefile                          |  1 -
 drivers/firmware/arm_scmi/Kconfig                  | 25 ---------------
 drivers/pmdomain/Kconfig                           |  1 +
 drivers/pmdomain/Makefile                          |  1 +
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           | 16 ++++++++++
 drivers/pmdomain/arm/Kconfig                       | 37 ++++++++++++++++++++++
 drivers/pmdomain/arm/Makefile                      |  1 +
 .../{firmware => pmdomain/arm}/scpi_pm_domain.c    |  0
 drivers/{base/power/domain.c => pmdomain/core.c}   | 34 --------------------
 .../domain_governor.c => pmdomain/governor.c}      |  8 +++--
 drivers/pmdomain/imx/gpc.c                         | 28 ++++++++--------
 drivers/pmdomain/imx/gpcv2.c                       |  6 ++--
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |  6 ++--
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             |  6 ++--
 drivers/pmdomain/imx/imx93-blk-ctrl.c              |  6 ++--
 drivers/pmdomain/imx/imx93-pd.c                    |  6 ++--
 drivers/pmdomain/qcom/cpr.c                        |  6 ++--
 drivers/pmdomain/qcom/rpmhpd.c                     | 12 +++----
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c        |  6 ++--
 include/dt-bindings/power/meson-g12a-power.h       |  1 +
 include/linux/pm_domain.h                          | 12 -------
 25 files changed, 100 insertions(+), 141 deletions(-)
 create mode 100644 drivers/pmdomain/arm/Kconfig
 rename drivers/{firmware => pmdomain/arm}/scpi_pm_domain.c (100%)
 rename drivers/{base/power/domain.c => pmdomain/core.c} (98%)
 rename drivers/{base/power/domain_governor.c => pmdomain/governor.c} (98%)

