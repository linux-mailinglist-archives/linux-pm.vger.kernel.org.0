Return-Path: <linux-pm+bounces-29890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E0AEF704
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCED44138D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4626B2A6;
	Tue,  1 Jul 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH7fCI/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E914242D86
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370468; cv=none; b=LtXOmFI9/XbJGBoNUUIiWvrsjD0LCOh3vy/wBv7gV9m+xpftjBHlD3hOP2EOmzXK65wJRvRBVKS8KNLrI/LHuRugQhDLONJzjwRX0HrY1XTTqhs0v8X2MDJH7hc/OCASmkVmm24+VWHSCyhb5QUz+A6Uz5TGouzMkq0gJLZlKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370468; c=relaxed/simple;
	bh=RE4tQl1bLw4Bdz6vsD8Am1PSure6jPJf0Xnvxh4XDDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJiFJFqx/Y2N8Njxn7w7YsHXH1Op0TwZrMSnSDssgwj3XByP4tlUsjYjcqEP6HJ9+WzVJaRCitqtgj2p3doepGT6CLsBbMkntwcTEczJPtwan8Y9pHDZXqrw6QsdKbiHXuih9vO0MvrcpiiLvHAPaZ44mE39PkzJi2pkTdKad5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FH7fCI/9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5551a770828so2416019e87.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370464; x=1751975264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoOnZ3Y5OuCPaJSe04VL4I/hU24z8+Cw4G4Ln/A/Lw8=;
        b=FH7fCI/9/tdce4NJS75lYM78SS3W6Mdu7rFeaaqrZQ4uZ6sqzL3j4GWF+6qzoaBL0I
         9ME2hs+zVtJBwP2m+ocTzhJGzJcCpVu1RuJ1KfPYTXPL5eyLVr9mpLmgoPQjBnfGB90b
         nOVWQs253jSw2V2aSF2hJLQA3zGGAUG2H1yiqo1mDM1H9r+n9ky9pc8D7uLrEO/gdaLD
         CEsY+0687RgJSYnKfp1R0Jk0NA6xSNQipInDUCVFjvdq0VrqF7Biu/KRH7DBkf882eR1
         q3x5+GOiZzLXVScmzzasUQifWZ2TXLf7ixIf2RKgX1xnZynbd1bkox8SF8twdpArbyUF
         omPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370464; x=1751975264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoOnZ3Y5OuCPaJSe04VL4I/hU24z8+Cw4G4Ln/A/Lw8=;
        b=dKSbt7en5epiI1/eldZLUPvfaIXQXU7YbJ/jibQ6hX7q1ucELMK+uJSH2HVkWw4Y6n
         p28FKWFcinlryY4sLxoK950Ea1+bAhq3Gvur9vif4vt4Ytmc/ABxGsXuE40fJN+Bwyda
         mUvFldPaEnlakHgR5JFlV2pBtyU84K/9e3XSDijMcFuOnn0XcSlEIkOCt/cyaybl8/xx
         iPc5UlAAhr5vKzk3WdZhvXpSqyceBn5tUsoMSmmyxJLjZH8S4MgqkCXRyMFS9XkfP4yi
         ImPd0+FZ40aHJuWCvMoznix2kDSnt2Ob83wYI6noMuYI0omaJ0vaEXazNLDWeeibCvXZ
         CbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVpISyS1ztmtliQDGavZGmm17ehEUshytP/SW5Z/Km2cZRHZw4A3IRm/bJu45AXoVKnmZHAeK+7Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjC2PX0Nh9JEY92F1s5DMxVA8KB89YgHptSE5n0dJoWe6WXvUZ
	sD8gDgFFw/jrY9g1WiZmwcbJaMyFYbZ7H/GAL6KdOl9znJA4ZYYwqeQ8zvz87E7pEqE=
X-Gm-Gg: ASbGncv3hnEDcoXThsasa0/srseO/VN9JOgYgbseP3iZKWdKcEZbQzfl4Im5/L8wPj/
	Qit+GJv//j6LCPqZb9C2PL6RYgd3OzyU1HXpDYDV7xttkC//b+JMSqOwuWL8rvvgFntksKTeUcM
	rbFWlowi51RCEravCihcfeV0dP0P/umQSCXV+i2kM3x8GNSpnOauxXDQ3f8sAjh+9WSurBm+g89
	UuOgJnmq/eNhk4sCcgvspqyJk55S5xK7plL3llpKmqD29hBOp4OaJQRz0PER5Y74/KW2eeUQ9zt
	8KrSpJAPMfl4fzE8geLuGcIYeeblz+8og4/y4neAV7QPW3rGYjxiC1Ax9+GWUqxTCL9eX5ZduwK
	XT016b/sgVfX5DU6H1O4KJCsBjHJjcKz+vFlZ
X-Google-Smtp-Source: AGHT+IFEnI8edSGqM0HnhUhPwpSZ3r1Gp9Zq3NgqwGOKGx5afReOxMS/S22NLgTkPgvFIWV29dureQ==
X-Received: by 2002:a05:6512:b86:b0:553:5429:bb87 with SMTP id 2adb3069b0e04-5550b9eedfdmr4938325e87.36.1751370464185;
        Tue, 01 Jul 2025 04:47:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:43 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
Date: Tue,  1 Jul 2025 13:47:02 +0200
Message-ID: <20250701114733.636510-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
	- Added a couple of patches to adress problems on some Renesas
	platforms. Thanks Geert and Tomi for helping out!
	- Adressed a few comments from Saravanna and Konrad.
	- Added some tested-by tags.

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

Ulf Hansson (23):
  pmdomain: renesas: rcar-sysc: Add genpd OF provider at
    postcore_initcall
  pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
  pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
  pmdomain: core: Prevent registering devices before the bus
  pmdomain: core: Add a bus and a driver for genpd providers
  pmdomain: core: Add the genpd->dev to the genpd provider bus
  pmdomain: core: Export a common ->sync_state() helper for genpd
    providers
  pmdomain: core: Prepare to add the common ->sync_state() support
  soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
  cpuidle: psci: Opt-out from genpd's common ->sync_state() support
  cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
  pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
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
 drivers/pmdomain/core.c                     | 211 ++++++++++++++++++--
 drivers/pmdomain/qcom/rpmhpd.c              |   2 +
 drivers/pmdomain/qcom/rpmpd.c               |   2 +
 drivers/pmdomain/renesas/rcar-gen4-sysc.c   |   2 +-
 drivers/pmdomain/renesas/rcar-sysc.c        |  19 +-
 drivers/pmdomain/renesas/rmobile-sysc.c     |   3 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
 drivers/soc/tegra/pmc.c                     |  26 ++-
 include/linux/device.h                      |  13 ++
 include/linux/firmware/xlnx-zynqmp.h        |   6 -
 include/linux/pm_domain.h                   |  17 ++
 15 files changed, 291 insertions(+), 80 deletions(-)

-- 
2.43.0


