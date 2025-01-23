Return-Path: <linux-pm+bounces-20876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E2A1A590
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41025160944
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128C211485;
	Thu, 23 Jan 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmOgN8sw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382D2101B5
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641747; cv=none; b=PxCtaz8gJ4ov/uVuJ3GS9IBjDj6mBQHnDwjkXPHXSet9DHHGSpLXKbZTc6cDP4z08OpWP0EpaaEq6n7Aw/Xu7RFA5QD7OXrug5tHnuWKYyoks7FnTBr9DIFMvgcDo7eVmiVsWU49oppHtHx3qP5VMdxIlrT5CfffsxMqNOiNrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641747; c=relaxed/simple;
	bh=2rQgFqOIcnjcZOPLL3KNhK491zzBMXS9Ek94uJnqom0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfMFnHRh45T5s0Vk8+nWaHTdwAEvd7oUQm7GtBGMAEG8pmRfAnuqUPXrbnJtYIUYdoKRGNEKHtnZtveayTYUtLLyoak8jPvGPh8qVfkdTaZN8jPDde5EWFa2ERftNxGve0hYuzSMihy3dvJ5HHyifOCM3QvBBE2jDnPvAdFlIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EmOgN8sw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54024aa9febso1067874e87.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737641744; x=1738246544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1ToMyTjMs2jLgsOp4dn6EsxiilccUPfzThLkca0KWU=;
        b=EmOgN8swlHIGaeKpzjI421KJe27QvLpCMblAAQeu5Kc7TE64x1J8JRC2UYDXz3J1pP
         0Rj1C4nf/th++xEfvf28PNmb9SHF6xFv6vTs+4/tYmgv0GtSHYmYpPrA5Vi8Svvq7uA9
         INMKtbVu2+msROmnjkCoP/zFghl6rPexroMPSLgAY/PahG4QfJ+rxD9s/3cE5Rj+qfJ3
         b6VPLCwLV32vcF9gPv6bt2fsTTjtREtB7B9KM+yUYeTOSef8Wftee9bJ6pmzgT5muy4+
         6Eb6grnFb5Q7iFC9G3Cb6p4bTdCgyOgfKmpeLsD0UtUQSMhtBVbbYIMVYo9pqlX/ETWv
         QiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641744; x=1738246544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1ToMyTjMs2jLgsOp4dn6EsxiilccUPfzThLkca0KWU=;
        b=FKPnvivEQSlwXR80y3Do2IGgy8d9kY+3f1HETFuJ9WTFz+VFB7nNPjy1Ha86X3zGiY
         /4UDSvFNEChRWZA46fggKlubjZUDHZKNkZcun8mkQnsuwsUxznyCA3hRWmAmfCXYoYKM
         tD8Usgv4ypZptO2QDtB+jZwgxLZyO467WW+ZSbNbGHQB2lre1AiO5ZLnSJHBBhAsJNBG
         wx8l8eCbfzQ5y4VZ6cOFFspmjuvoib1bh/2Gigz62uf+QTeGpaDFNNxfgknGHp831eA6
         tsfeyfJy7mSMGNQGDF/txtQqh5CMxIwmylFavYIkLg0wmCSEy2g1VqTouc0xZav5hEsh
         +fjw==
X-Forwarded-Encrypted: i=1; AJvYcCWIkI5pKqNmaE30RbISqGw6CZh5L81DOkoI4u1wCI47an93jnP/DeoF9U3P+vBDgRibIsJrOP4XxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwylCrj6pdN8geS0RhjMh6l91F2KljDw4pNReKEU7ZNU4Wqgt5O
	L533hT2vdAYIzo6R0wXmJbcd8Os+zG4sYCBOnNcu0oPYAc0aHzFcbZcFa9mth+8=
X-Gm-Gg: ASbGnctFIl93O8k97BKRSxeS210sBYDT0os+uKtTkV/uWG3TW0e6PvrVQdAMJfHo/bR
	KqHpUOSU5dO/LYadVsqGvPlxKOeZC3lwcC8pRjcVdNQAlk2c8awR1aHI1YxRDUZh84nSuHZtTWs
	szST5GC3PIXvjB5Eae0ZH+GrRH6itZNPbuGnRwegpuP1rc6IGFYMqtRnIVm16Gq010d+0tH2GSA
	VSm7BFO8DAA+sYV5olOP8Opi1GTmc9grtAHwB1y3XqER4V+XtyHx8G/RioW4znTKmji1uiJg4/k
	vVn+0C2eTC0JM2V1kzv5+dxzH37fs7QrRirZAWR1D3m8R/RMeV2ayjQ=
X-Google-Smtp-Source: AGHT+IHplopuHQYOeHKQxzSgMWlfVO0WOZMzXUZ9QofYSuMY+TN8CSqm5hG6oBjV6GjzjpVF5ldH2g==
X-Received: by 2002:ac2:4195:0:b0:540:3566:985c with SMTP id 2adb3069b0e04-5439c251121mr6875642e87.26.1737641743965;
        Thu, 23 Jan 2025 06:15:43 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543bb6bf5b1sm778726e87.118.2025.01.23.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:15:43 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.14
Date: Thu, 23 Jan 2025 15:15:40 +0100
Message-ID: <20250123141540.265172-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with the pmdomain and cpuidle-psci updates for v6.14.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 726efa92e02b460811e8bc6990dd742f03b645ea:

  pmdomain: imx8mp-blk-ctrl: add missing loop break condition (2025-01-16 16:10:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14

for you to fetch changes up to 885f5669f2abd0db34c9832259f77240d5350e36:

  pmdomain: airoha: Fix compilation error with Clang-20 and Thumb2 mode (2025-01-21 10:45:24 +0100)

----------------------------------------------------------------
pmdomain core:
 - Add support for naming idlestates through DT

pmdomain providers:
 - arm: Explicitly request the current state at init for the SCMI PM domain
 - mediatek: Add Airoha CPU PM Domain support for CPU frequency scaling
 - ti: Add per-device latency constraint management to the ti_sci PM domain

cpuidle-psci:
 - Enable system-wakeup through GENPD_FLAG_ACTIVE_WAKEUP

----------------------------------------------------------------
Christian Marangi (2):
      pmdomain: airoha: Add Airoha CPU PM Domain support
      pmdomain: airoha: Fix compilation error with Clang-20 and Thumb2 mode

Kevin Hilman (3):
      pmdomain: ti_sci: add per-device latency constraint management
      pmdomain: ti_sci: add wakeup constraint management
      pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups

Konrad Dybcio (2):
      dt-bindings: power: domain-idle-state: Allow idle-state-name
      pmdomain: core: Support naming idle states

Patrick Delaunay (1):
      cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with OSI

Peng Fan (2):
      pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs
      pmdomain: imx-gpcv2: Suppress bind attrs

Sudeep Holla (1):
      pmdomain: arm: scmi_pm_domain: Send an explicit request to set the current state

Ulf Hansson (2):
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next

 .../bindings/power/domain-idle-state.yaml          |   5 +
 drivers/cpuidle/cpuidle-psci-domain.c              |   1 +
 drivers/pmdomain/arm/scmi_pm_domain.c              |   8 ++
 drivers/pmdomain/core.c                            |  15 ++-
 drivers/pmdomain/imx/gpcv2.c                       |   2 +
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |   1 +
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             |   1 +
 drivers/pmdomain/mediatek/Kconfig                  |  12 ++
 drivers/pmdomain/mediatek/Makefile                 |   8 ++
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c    | 144 +++++++++++++++++++++
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |  81 ++++++++++++
 include/linux/pm_domain.h                          |   1 +
 12 files changed, 276 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

