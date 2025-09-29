Return-Path: <linux-pm+bounces-35558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081FBA9192
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDDE3C4C92
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4922EB84D;
	Mon, 29 Sep 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgDkPXvV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684A2EA741
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146420; cv=none; b=uS6P4j8kfMsGloGKVS9T6V14rABtlMDSSqIeMUgaDawh9qQOOYTIvc+JlPLDC4wqMu+QZbhQ9q4FwPdyLw/A+qE4yrHomzaSlVRfGWt6cwK3KyyXRjV+MdpafwBEivZB2+5kO0B+eR/zxE/MeZV18ZyUSWcVKynXnmJ5M2+p2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146420; c=relaxed/simple;
	bh=wNuVMdmmYzdn6WLNE4CyIHqHQVdqeV7aveI2ROAPcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXMN9py7VM4F32PQYrI7cYvjg3+4Ww2pJ3ShhFHMX41x6dolfEEPlKmH9kI+jS30lAlTHNFoaXlIvDGOk74yZG9HDQaA4cbmXKQPHyf4m2Hool55rc2StlNaaR8itBnx7bdX6HZ5JJOpEcNOELHy8McswB1ADic/LtcfNW1Zvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KgDkPXvV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a59124323so4664222e87.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759146417; x=1759751217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iblNyH9RQUiqFDYiroesQvDFASi4C4PHJ77i3ovtxEg=;
        b=KgDkPXvVoAZDECYbp3n1kK4W1bFSrF+YU7EqIsQT0hxvgt/ux3WE3mW4+J/L7qrBkZ
         4JJcvMd7PuI5ksI8LfrvLe8yVuf04Y0SGTbSi36VAWPjjZrRI2mM1md13T+T8Vhk86w5
         U0HT1cjOXw5YSGKq5e00Y+jALhqpZm0OqhUOA0JuY+bIy3jVA/LP9lAYj5LZFZqOVvOA
         52ITo2ol8EBxvE4xxj5OlNQU3VY0AlEZcq/fIs5GKMhVJRxAKZsqFiepThy7JPnQs/ba
         u9QNii/hq7+gzK6hEJMv2kLSNycpniLZHQdwqEJz7CahpWbLY84EK9uOssyELE/9o9gt
         BdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146417; x=1759751217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iblNyH9RQUiqFDYiroesQvDFASi4C4PHJ77i3ovtxEg=;
        b=YbEzDjo9cHFBsP/pw5yWGbEwKDBtXkDfjlz5l3VC1L01us5zeX+tfkRY9rr/TZHM7E
         NUHTeYAs+/qF/vF5Vxk2cXbTSo2BrVDnDX2VX7GZ9T3w/ZDM1CeW8P4PiaRyu/dvtzzm
         WLWA3ufYsJHuRmPt8ArrqdXtpgAaxKOx+Iiym6J1KvL0pUpAit4JkXmoqkSgsEpBC8d1
         LvgmSnh5fEkwPOxChCkY4bHd5S5LhbwVOUPZEjcUsskQMxOndWfnOo81hTdFb9d1LDY+
         DfbmwVLSDQ4sQ0hHsvYsAs8jklztf2pN7cub/3mrR14e2782v00zq6tpGqniRbYrLk2B
         +Qeg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zz2+TJzaG9LGDLHwqcJ/UvP37rULomcsP9bjIwT8chc0RRWBAkNbj3uCC0AVDXG8UfYNU/0Y8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OnP0BXsYjeGDVELDO1NRevSPctzoLhpcIX0fZf2dYn1sygP4
	on+OxxJ+DIaeXyfBWEWUZhfwwrOpYNlphiZ7UjpGhCr9WgbtZbIHYOJSylDaWafn/s4=
X-Gm-Gg: ASbGncsgn/cYz4fs56AGSebO745EWqgxwXr1OCVkP2KBrhgqlywPQPpikrRpTTFUmoK
	F7qG+fCByn13Uz/Xhhbx0PwVdpddKWaDOcMGGiM8JKIkTcRPR9VZefwUSX/hUPsWHaZuj0RU2As
	7nCo6I4QlljGMNSu+15ygsqG0c7H3Vj8H9j8zlxnWHNX2+3OZIKNUqYuMXqIqCkVBK85WooS8x7
	GiOHtcs+8Drz1QzT0ABHIzXKzhpHAo+8I8eqees4qPiafXEbO63lctEoJ/q3wjh2aJnZZPUGbkL
	oXbN+BzrKsxzQDXKo5TzI6S2fieWvAYoUTZXuEApPLwOR6NQ4aNW8wtVGJqpYh0IVxHug2b040C
	VJK0UiwsmE8Gg92Qz97jpniw+4OHX4QLJ1z1R2naIKv1cvSOv2ou9MTUgewm5FYexHvS3TpiU
X-Google-Smtp-Source: AGHT+IH1tc5UyrowpjgG09PaeQoeg5mBDgVtgXBs7JIEjr1VUn4l35hQOfbuJl6g30wFsygaWJEMsA==
X-Received: by 2002:a05:6512:130b:b0:581:d8:a922 with SMTP id 2adb3069b0e04-582d406cfdamr5131282e87.50.1759146416675;
        Mon, 29 Sep 2025 04:46:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656353sm4117319e87.88.2025.09.29.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:46:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.18
Date: Mon, 29 Sep 2025 13:46:35 +0200
Message-ID: <20250929114655.226466-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain updates for v6.18.
More details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5fc4ab3269dea6a0b00c7256cb6f6c0101b6a44b:

  pmdomain: mediatek: set default off flag for MT8195 AUDIO power domain (2025-09-23 16:33:34 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18

for you to fetch changes up to bbc3110823eca23b066e75a920bdc8118adda0d2:

  pmdomain: thead: Fix error pointer vs NULL bug in th1520_pd_reboot_init() (2025-09-26 14:50:20 +0200)

----------------------------------------------------------------
pmdomain providers:
 - amlogic: Add support for S6/S7/S7D power-domains controller
 - imx: Add support for i.MX91 power-domains
 - marvell: Add support for PXA1908 power-domains
 - mediatek: Add support for modem power sequence
 - mediatek: Add support for RTFF Hardware in MT8196/MT6991
 - qcom: Align power-domain definitions for rpmpd
 - rockchip: Default to use power-domain support
 - thead: Create auxiliary device along with a corresponding reset driver
 - ti: Synchronize on/off state with HW-state for ti-sci power-domains

----------------------------------------------------------------
AngeloGioacchino Del Regno (7):
      dt-bindings: power: mediatek: Document access-controllers property
      pmdomain: mediatek: Refactor bus protection regmaps retrieval
      pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
      pmdomain: mediatek: Move ctl sequences out of power_on/off functions
      pmdomain: mediatek: Add support for modem power sequences
      pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
      pmdomain: mediatek: Convert all SoCs to new style regmap retrieval

Brian Masney (1):
      pmdomain: mediatek: airoha: convert from round_rate() to determine_rate()

Dan Carpenter (1):
      pmdomain: thead: Fix error pointer vs NULL bug in th1520_pd_reboot_init()

Dmitry Baryshkov (4):
      dt-bindings: power: qcom-rpmpd: split RPMh domains definitions
      dt-bindings: power: qcom-rpmpd: sort out entries
      dt-bindings: power: qcom-rpmpd: add generic bindings for RPM power domains
      pmdomain: qcom: rpmpd: switch to RPMPD_* indices

Duje Mihanović (2):
      dt-bindings: clock: marvell,pxa1908: Add syscon compatible to apmu
      pmdomain: marvell: Add PXA1908 power domains

Icenowy Zheng (2):
      driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW
      pmdomain: thead: create auxiliary device for rebooting

Joy Zou (3):
      dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
      pmdomain: imx93-blk-ctrl: use ARRAY_SIZE() instead of hardcode number
      pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on i.MX91

Mikko Rapeli (1):
      pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP

Tomi Valkeinen (1):
      pmdomain: ti-sci: Set PD on/off state according to the HW state

Ulf Hansson (7):
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next

Wolfram Sang (1):
      pmdomain: remove unneeded 'fast_io' parameter in regmap_config

hongyu.chen1 (2):
      dt-bindings: power: add Amlogic S6 S7 S7D power domains
      pmdomain: amlogic: Add support for S6 S7 S7D power domains controller

 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  30 +-
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |   3 +
 .../bindings/power/mediatek,power-controller.yaml  |  37 ++
 .../bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml |  59 ++-
 MAINTAINERS                                        |   3 +
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       |  95 +++++
 drivers/pmdomain/imx/gpc.c                         |   1 -
 drivers/pmdomain/imx/imx93-blk-ctrl.c              |  23 +-
 drivers/pmdomain/marvell/Kconfig                   |  18 +
 drivers/pmdomain/marvell/Makefile                  |   3 +
 .../pmdomain/marvell/pxa1908-power-controller.c    | 274 ++++++++++++++
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c    |   8 +-
 drivers/pmdomain/mediatek/mt6795-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8167-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8173-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8183-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8186-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8188-pm-domains.h      |   6 +
 drivers/pmdomain/mediatek/mt8192-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8195-pm-domains.h      |   5 +
 drivers/pmdomain/mediatek/mt8365-pm-domains.h      |  14 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c         | 399 +++++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |  74 +++-
 drivers/pmdomain/qcom/rpmpd.c                      | 112 +++---
 drivers/pmdomain/rockchip/Kconfig                  |   1 +
 drivers/pmdomain/thead/th1520-pm-domains.c         |  16 +
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |  24 +-
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/th1520-aon-reboot.c            |  98 +++++
 include/dt-bindings/power/amlogic,s6-pwrc.h        |  29 ++
 include/dt-bindings/power/amlogic,s7-pwrc.h        |  20 ++
 include/dt-bindings/power/amlogic,s7d-pwrc.h       |  27 ++
 include/dt-bindings/power/marvell,pxa1908-power.h  |  17 +
 include/dt-bindings/power/qcom,rpmhpd.h            | 233 ++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h             | 391 +++++---------------
 38 files changed, 1592 insertions(+), 468 deletions(-)
 create mode 100644 drivers/pmdomain/marvell/Kconfig
 create mode 100644 drivers/pmdomain/marvell/Makefile
 create mode 100644 drivers/pmdomain/marvell/pxa1908-power-controller.c
 create mode 100644 drivers/power/reset/th1520-aon-reboot.c
 create mode 100644 include/dt-bindings/power/amlogic,s6-pwrc.h
 create mode 100644 include/dt-bindings/power/amlogic,s7-pwrc.h
 create mode 100644 include/dt-bindings/power/amlogic,s7d-pwrc.h
 create mode 100644 include/dt-bindings/power/marvell,pxa1908-power.h

