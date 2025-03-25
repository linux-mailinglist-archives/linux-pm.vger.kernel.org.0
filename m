Return-Path: <linux-pm+bounces-24491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D4A6FAD8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 13:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99913A9056
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC72566CC;
	Tue, 25 Mar 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NntCOal8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08071990AF
	for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904900; cv=none; b=QuuxJvzNj0v9hbf9Jc+oYr+I8xJCcWhQRYLWZCaQjAoWt18CLfBo86HIxUHYElKrBDDpn4Rui2aX9DqFwmzXedWSx5VXR8Ot2zYaNItAGa0AOfaLsiYMPZ6jIJApQZjAAaYil/WqV2TyC6Qpi1CKkVATHAgcjWoGr7h9V+XkPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904900; c=relaxed/simple;
	bh=rcM0n3Yjikf6Aw5+A535CuIAAqbNRkpKJmVjrWEM5g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGKI7uo+n5KQmiVwpp4fvrkCqXksgVd1rtdHxyrTNmRZJun2qvtWqu2gdBVgWtwRPRid0rdEHAK2oprMLe4Zr4vUIfkQqGB0A6nrPrO9wNXMzzHTo3fylJUqmNvZMHckIhNgI5SvKOj+FkTniJwGbN48CQ2Z0gTEPEa9RKUu5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NntCOal8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549644ae382so6908280e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742904897; x=1743509697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+lwlbypyNWLM9oS//k+PaCmQcJfM6mkqUtpIKVPe4Q=;
        b=NntCOal8IhiSQHZc/Pl28ih8rYT9oZgfs5IxS8OuEexmj+MZzLAR6y2lRKRk5FIBzO
         au+74ukZZ17Dm72mmZhn8+L9UyNYrJrOVTUMZBF/Dl4VOOckfcoQUjGG7YOaeaSdRJ0l
         Ds4++pYAsMImiOIHw5kMOvuuIShp35DdcX0zY4y9rwVh/o8Wfpo/L5ztcz0Er0LFBpCh
         +pyKkuzaKrtF/J9bzV3tO9+b3l7xHbRKLJkGSRct81zSK78RMXFjmCZevFYpygo+f0uS
         TPrQGGw7q6pL8+A4ByfNfoSs+0H8b9pbcsYJ/nOE4KeOziLm+XlA+vnJFcDzVG9tyVYN
         sOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904897; x=1743509697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+lwlbypyNWLM9oS//k+PaCmQcJfM6mkqUtpIKVPe4Q=;
        b=BlGeJ2phgfD59YV3UO6R0p/VSycA4rw3Xt4Bwj8ieOfAFud0eTfzD9FbInuniSuoxl
         ILH8BcTkVF5ypPWioh94KmgjZ1tUpCl7A5KY7AWD48WnmuaI72zlysyQJc5PjJL4gsbu
         tx3WKPQxgvjnhti/wYjfh4WVLb+e2POOVxZ7ayVM5qIsSIbVdBNq6TEtR0JkoEjqEiEY
         c3swdUVgnVbrmjySx+PUPT2DJTW21ztCkz+LoyS47nNvcNzvyWV8QM2G+/E8x914N3rR
         6uSmQf+EZuLBzP6DlErp6xo7DmzwG+GCe4Dpd0KPhCLxlnE063pKxZZDoDFJU0T8Y09/
         WP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUlRYpbAIRE8ZlzuccScOixM2Db7ea3kFj95y/g5TYqC/wNdzSu8kLJdk2zXKdQg4UyWF+G6oDnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6sMrNmSm6BJdxj4tNOXe2G95mDJwLd6ubsWNUFVtMKh4Ed3N
	n87n257oOAem61/VQbGATyW1N+g1ZQloxOtKmI4nUkOQVB5NHBVERM1w8E8JYgc=
X-Gm-Gg: ASbGncvfSU3sNcF5nuV7crWt93jjuDVI6S1DaTbAdc0rC17+5FHCh9kOxYg1y+BZoS5
	NLjph0+nOfOitlubos5JLNNk89JxxKuI+pjZELHfKz2HTKXS+eWJsHEV526IwKfMvGC6VaHdt91
	DekErUOf3KusSVjzB9KlosJLzV+DVRsGWi6FTUBBnhdkzNnYDJCc0KY46DDCFTXbfDftVyQlOxG
	XwP8NvDEbgGPOmZxqpPdfPzuAArpKe2Ph97wZ2eMnuHDhfGJOqAanSlok4oi5R+jfzR01XISI04
	lLLdlxM7zf+n0hsNLy7Bx8rBqA9hCPHka3evXG4VoB2kcRSmr/nvPYTcXKsf6Cy/1hXmz187/gh
	ZYypSSNMc1gBd5s1UQVOjnLn3o8wJGg==
X-Google-Smtp-Source: AGHT+IGzo1EvbrVCd9ZKmxlnNIRHybsaVGEX6jF84cBerHx8WU6tqQpBpys6UGtNAgMqTeEtrVx5Rw==
X-Received: by 2002:a05:6512:130c:b0:545:b28:2fa2 with SMTP id 2adb3069b0e04-54ad6476fd4mr5231938e87.7.1742904896727;
        Tue, 25 Mar 2025 05:14:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad651211csm1515556e87.227.2025.03.25.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:14:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.15
Date: Tue, 25 Mar 2025 13:14:54 +0100
Message-ID: <20250325121455.36031-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain and cpuidle-psci updates for v6.15.
Details about the highlights are as usual found in the signed tag.

A few additional notes:
*) I have merged an immutable tag/branch from Mark Brown's regulator tree.
*) I made a few typos in some of the merge-commit-headers, sorry!

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ef17b519088ee0c167cf507820609732ec8bad1a:

  pmdomain: amlogic: fix T7 ISP secpower (2025-03-05 15:51:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15

for you to fetch changes up to 51f0b8911ec4355cea07b180f6569cc52f65aaa8:

  firmware: thead: add CONFIG_MAILBOX dependency (2025-03-18 13:13:03 +0100)

----------------------------------------------------------------
pmdomain core:
 - Add dev_pm_genpd_rpm_always_on() to support more fine-grained PM

pmdomain providers:
 - arm: Remove redundant state verification for the SCMI PM domain
 - bcm: Add system-wakeup support for bcm2835 via GENPD_FLAG_ACTIVE_WAKEUP
 - rockchip: Add support for regulators
 - rockchip: Use SMC call to properly inform firmware
 - sunxi: Add V853 ppu support
 - thead: Add support for RISC-V TH1520 power-domains

firmware:
 - Add support for the AON firmware protocol for RISC-V THEAD

cpuidle-psci:
 - Update section in MAINTAINERS for cpuidle-psci
 - Add trace support for PSCI domain-idlestates

----------------------------------------------------------------
Ahmad Fatoum (1):
      pmdomain: imx: gpcv2: use proper helper for property detection

Andras Szemzo (2):
      dt-bindings: power: add V853 ppu bindings
      pmdomain: sunxi: add V853 ppu support

Arnd Bergmann (3):
      pmdomain: rockchip: add regulator dependency
      pmdomain: thead: fix TH1520_AON_PROTOCOL dependency
      firmware: thead: add CONFIG_MAILBOX dependency

Dan Carpenter (1):
      firmware: thead,th1520-aon: Fix use after free in th1520_aon_init()

Geert Uytterhoeven (2):
      pmdomain: ti: Use of_property_present() for non-boolean properties
      pmdomain: renesas: rcar-sysc: Drop fwnode_dev_initialized() call

Keita Morisaki (1):
      cpuidle: psci: Add trace for PSCI domain idle

Luca Weiss (1):
      dt-bindings: power: rpmpd: Fix comment for SM6375

Michal Wilczynski (4):
      dt-bindings: firmware: thead,th1520: Add support for firmware node
      firmware: thead: Add AON firmware protocol driver
      dt-bindings: power: Add TH1520 SoC power domains
      pmdomain: thead: Add power-domain driver for TH1520

Peter Geis (1):
      pmdomain: rockchip: fix rockchip_pd_power error handling

Sebastian Reichel (6):
      regulator: Add (devm_)of_regulator_get()
      dt-bindings: power: rockchip: add regulator support
      pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
      pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
      pmdomain: rockchip: reduce indentation in rockchip_pd_power
      pmdomain: rockchip: add regulator support

Shawn Lin (3):
      soc: rockchip: add header for suspend mode SIP interface
      pmdomain: rockchip: Add smc call to inform firmware
      pmdomain: rockchip: Check if SMC could be handled by TA

Stefan Wahren (1):
      pmdomain: bcm2835-power: set flag GENPD_FLAG_ACTIVE_WAKEUP

Sudeep Holla (1):
      pmdomain: arm: scmi_pm_domain: Remove redundant state verification

Ulf Hansson (11):
      pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
      mdomain: Merge branch rockchip into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch rockchip into next
      MAINTAINERS: Update section for cpuidle-psci
      pmdomain: rockchip: Fix build error
      pmdomain: Merge branch rockchip into next
      pmdomain: Merge tag 'v6.14-rc4' from Linus into next
      pmdomain: Merge tag regulator-devm-of-get into next
      mdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next

 .../bindings/firmware/thead,th1520-aon.yaml        |  53 +++++
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |   1 +
 .../bindings/power/rockchip,power-controller.yaml  |   3 +
 MAINTAINERS                                        |   7 +
 drivers/cpuidle/cpuidle-psci.c                     |   3 +
 drivers/firmware/Kconfig                           |  10 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/thead,th1520-aon.c                | 250 +++++++++++++++++++++
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/arm/scmi_pm_domain.c              |  11 +-
 drivers/pmdomain/bcm/bcm2835-power.c               |   1 +
 drivers/pmdomain/core.c                            |  35 +++
 drivers/pmdomain/imx/gpcv2.c                       |   2 +-
 drivers/pmdomain/renesas/rcar-sysc.c               |   2 -
 drivers/pmdomain/rockchip/Kconfig                  |   2 +
 drivers/pmdomain/rockchip/pm-domains.c             | 205 +++++++++++------
 drivers/pmdomain/sunxi/sun20i-ppu.c                |  15 ++
 drivers/pmdomain/thead/Kconfig                     |  12 +
 drivers/pmdomain/thead/Makefile                    |   2 +
 drivers/pmdomain/thead/th1520-pm-domains.c         | 218 ++++++++++++++++++
 drivers/pmdomain/ti/omap_prm.c                     |   2 +-
 drivers/regulator/devres.c                         |  17 ++
 drivers/regulator/of_regulator.c                   |  21 ++
 .../dt-bindings/power/allwinner,sun8i-v853-ppu.h   |  10 +
 include/dt-bindings/power/qcom-rpmpd.h             |   2 +-
 include/dt-bindings/power/thead,th1520-power.h     |  19 ++
 include/linux/firmware/thead/thead,th1520-aon.h    | 200 +++++++++++++++++
 include/linux/pm_domain.h                          |   7 +
 include/linux/regulator/consumer.h                 |   6 +
 include/soc/rockchip/rockchip_sip.h                |   3 +
 include/trace/events/power.h                       |  37 +++
 32 files changed, 1076 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
 create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

