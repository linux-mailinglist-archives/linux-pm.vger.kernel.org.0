Return-Path: <linux-pm+bounces-27561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662FAC2430
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF8F4A5C96
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AD293746;
	Fri, 23 May 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BobEldln"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2A4C6C
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007641; cv=none; b=B4TS093h71N2jSwLnr79Y1lEq0kRPv+Uh3Reo8gho6m7XM+kPDpmZx+9BdZdqDC6L8LrG8w4eIEUGI9vwN2I7pX3Xk+r+QHwuoh8wJPBoqNsuAofxmVgXS7t2suEebEeg3f7+Ya+cW0+Xb7hlcEdEJEurQ4yQv3MAFqFC9NTmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007641; c=relaxed/simple;
	bh=0hShcddQUJ+0eOxNUp6ajHVoa9avM9UDQg3ZWcmCiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pg3hBKDsEb8ztO05nem2VLrHJDEUqVGPSPoVlw2GXVW+uRLx9P7RF7xS3MYEP0bnab0oXiBFLkTvbT88IDcRIGJQsbbNf9yFa8/6zVQ+jDGmPjIRCKyqKTmfFhW0JRLnRFjp1LCtaDcILJoiR4S7aEC5pCyJ/SCJ1QYA7fvPqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BobEldln; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-551f00720cfso7705687e87.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007638; x=1748612438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8UsG0Cv+W+SbA3fwsKYtIRZq6NFodm959GZlb0m+LI=;
        b=BobEldlnqiWaTKuDsewJMTFSxNvCYZecB70K8TqP34uetLYnLvKGpyyC5zq3rEkTjI
         eWgCpQfnydq73QFaJp/fcbWDK1oBhT3bJ334USJ4qIiWrpvwh+wRWn02EkGoHXd6fVd/
         uYc5+uccy2XP5jPdrI2h8N8IOKW9Q1V6SmusCbReukNKLkpt7NBUj80aUBKUOeZUNghd
         scJ+c302MIs930wH+XE7LSLJXudgvKO7co5B2XVIXK9NrXRlPmx+SG9x5sJ5Z+RH2ujq
         cj+E3fKiaxmHV/XLs+9VHW8RqG+ioWQ4Q6udMMlbDCvLnNQOp3cNsi9cFib7hWL+Tzv4
         eoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007638; x=1748612438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8UsG0Cv+W+SbA3fwsKYtIRZq6NFodm959GZlb0m+LI=;
        b=spgewcKi7ic8aXj9bGfL/4x5qilX4X6rosu6xjUM79xPbGtxHZdfZTDBYtC/1rmqQQ
         pLC1YV7rBXEQI0z6n64D7+DasIud7o7ru9K04LOnblHNJw4LNsNLQsGbYpefMhbMYgHJ
         WvF4kxS1us1E05q1htOT3K7Yaxwny6S6B/QW8n3bqqw5IPZwBtkM7zgLomKJvsGy0UL/
         D6S+ytDSaynceQ8LJZuHKQEI4lhP4GxNrNvVHg/DK7hWa0nkrc7CTD+RJ5Q/4jmh2R1o
         As0CVTiqk5ND9uE+A5/hyKB1WDFaMvcYCmXqHVO8B6SvMd0khJrYEwNU/OSz7KhMslM6
         5HMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGNaodFDQ+rgcSMj5idl82HhWS7vBXoFrzhDQOomu7ZuHbu5WpB55UsSbfno6mYKsNGWu9AX9Blg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCqorqS9WulJ8i9QHKbXBzYzF7OfoX97ClA5Pw1lQIhH09Bab
	2GFUtuku+W9xK9ZIfWTRfoBfN1pc+SjqIkiKyBWDkbYl3GFSFk4YVvv631vUBcTI+C0=
X-Gm-Gg: ASbGnctmI5tVNa/Uj6WY7g2l03c/3lTXr9l+j1/DRKWBzohXFNNGSQ1zB2U7CMCdgfI
	YSXygmw/grpICGb2UYL3rNmzVhmUYQ+RBOAywjFSKL2aKtnEy017Kpzb5wUq5aZKQdSI9qdlJc8
	RQs5NwYGYREuADS+hTcO3p69gj1Eal8/rhsFae9fn/0Gy0lTLRCsMdtfSXEyeM4V039fOMqqlPA
	iD8frkbIsuBonboW/UzUCTpDuQz27Y0U+iPmFkG4cqSQu+iIia/iFxuOCAINBP0aaar3cp3cVF4
	xy1x3kHqjQsjYS+mhKQK4JZo5Ps+JyWw4ZMlNQU1ll4tJooE8yr9kCiYOYl0GLlZ9V1ifzRQgaK
	WO8sfE+VQof6hI4aykgTqItgFqA==
X-Google-Smtp-Source: AGHT+IHnygsP+tGAk04VZnCfGgEIdN8EfQ0ZCgQ471fg+idaH3A0yfEu5eg6xgFw+xqxxde3XVbpbQ==
X-Received: by 2002:a05:6512:6081:b0:545:6fa:bf5f with SMTP id 2adb3069b0e04-550e7195284mr7962698e87.2.1748007637808;
        Fri, 23 May 2025 06:40:37 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
Date: Fri, 23 May 2025 15:39:57 +0200
Message-ID: <20250523134025.75130-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Well, quite a lot as I discovered various problems when doing
	additional testing of corner-case. I suggest re-review from scratch,
	even if I decided to keep some reviewed-by tags.
	- Added patches to allow some drivers that needs to align or opt-out
	from the new common behaviour in genpd.

If a PM domain (genpd) is powered-on during boot, there is probably a good
reason for it. Therefore it's known to be a bad idea to allow such genpd to be
powered-off before all of its consumer devices have been probed. This series
intends to fix this problem.

We have been discussing these issues at LKML and at various Linux-conferences
in the past. I have therefore tried to include the people I can recall being
involved, but I may have forgotten some (my apologies), feel free to loop them
in.

I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
Let me know if you want me to share this code too.

Please help review and test!
Finally, a big thanks to Saravana for all the support!

Kind regards
Ulf Hansson


Saravana Kannan (1):
  driver core: Add dev_set_drv_sync_state()

Ulf Hansson (20):
  pmdomain: core: Use of_fwnode_handle()
  pmdomain: core: Add a bus and a driver for genpd providers
  pmdomain: core: Add the genpd->dev to the genpd provider bus
  pmdomain: core: Export a common ->sync_state() helper for genpd
    providers
  pmdomain: core: Prepare to add the common ->sync_state() support
  soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
  cpuidle: psci: Opt-out from genpd's common ->sync_state() support
  cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
  pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
  pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
  firmware/pmdomain: xilinx: Move ->sync_state() support to firmware
    driver
  firmware: xilinx: Don't share zynqmp_pm_init_finalize()
  firmware: xilinx: Use of_genpd_sync_state()
  driver core: Export get_dev_from_fwnode()
  pmdomain: core: Add common ->sync_state() support for genpd providers
  pmdomain: core: Default to use of_genpd_sync_state() for genpd
    providers
  pmdomain: core: Leave powered-on genpds on until late_initcall_sync
  pmdomain: core: Leave powered-on genpds on until sync_state
  cpuidle: psci: Drop redundant sync_state support
  cpuidle: riscv-sbi: Drop redundant sync_state support

 drivers/base/core.c                         |   8 +-
 drivers/cpuidle/cpuidle-psci-domain.c       |  14 --
 drivers/cpuidle/cpuidle-riscv-sbi.c         |  14 --
 drivers/firmware/xilinx/zynqmp.c            |  18 +-
 drivers/pmdomain/core.c                     | 239 ++++++++++++++++++--
 drivers/pmdomain/qcom/rpmhpd.c              |   2 +
 drivers/pmdomain/qcom/rpmpd.c               |   2 +
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
 drivers/soc/tegra/pmc.c                     |  26 ++-
 include/linux/device.h                      |  13 ++
 include/linux/firmware/xlnx-zynqmp.h        |   6 -
 include/linux/pm_domain.h                   |  17 ++
 12 files changed, 294 insertions(+), 81 deletions(-)

-- 
2.43.0


