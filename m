Return-Path: <linux-pm+bounces-7910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF968C76C4
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 14:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F90282337
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591214601B;
	Thu, 16 May 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luCphtiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE5145FE7
	for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863464; cv=none; b=Y3V/2vMt5NN0W1y7vvT+UK6Gtq5LeE5WURCFKSIVerIiiqWGg1jRVawY2mWIGs73qkbU7wDkz1+ESYSvVxkrAjKYSmHYLfxw1yeYNBRCZulU6KBwsEmUHbOWnhdVoT/CoiJJPQKfYUp5O8oxNaO/LHCxfhaaj21WMywjDxrs7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863464; c=relaxed/simple;
	bh=DPdlgRoCdF0L2a1XWuAKs2nqn/9dMqJpOnVI7NRrzgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxIDmPzHLS0OD/ZzGtDajS15sz52PGf9PU8bDcWU8aZ79Xx+bbGdTopeshfOXuDb+bYrsdTNmfP9wnFRg3yTp3D9bv/dU92afzExzB36xkbN4scKtVzTKC2l2+ctUx/CCH7pXPH1R5PoTZufkOz3uwyJFKuvh6Ro1WzjS5M2nCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luCphtiP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so79617495e9.0
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715863460; x=1716468260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqm/e/NaUplcef5LU+JmSQhz5qfGJpBcDWZFeYnZhSY=;
        b=luCphtiPdF72NK3MiSiyfBwfm7842gZoRYQ3NTceA8E3CXj6YV0N854J08offQbhts
         voQQ5VIIUa+CkvvsX1Fufe5+AGlmQLIgvvijYjRHcT/GN3eCTNNBKjeSBD392IloT9lM
         6ob1MZelCRhhZH88G8zKeC1WXtkLZss0EFveSTPSFjr7Re9Aup6IYLUHPZItseBZMBxO
         8xuYn1KHSUKEYpJW8ZyfOhzHTL3yS4XJDajrHbJah+X1eV3fiSHDC6GLFKl5RROhhONY
         Tir/UMIDVjCEVxvcztty4VIlfT4KCXzWN3ns3R5zGd1YiozF+mw2DJo4q7RciTXPfmuY
         Oj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863460; x=1716468260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqm/e/NaUplcef5LU+JmSQhz5qfGJpBcDWZFeYnZhSY=;
        b=R58VII4qXxeO6d/H0ZZjYqEjc0sE7JJkkT9HZ9P1n3A9NWzQpyXF5RI99RQ+tDp0Yd
         q/qQogdgiCtSvIZvt++Auv9eJ2wwYzKed1nBhuW+7ph0c0JBtAlVOW+WFygM5hTBqxv1
         T8qEG1Pdl1v01zOkhsi1MZ+0bXyqnNnmUcR2Y0ykFneDqR3NJws62MoDusXjAGEF+4Fs
         SlR+cWf+W2hX6g3EvHn1Ol1/h8MgozCCrFQfYOAGtPm/Dc35iiVxyfSAbGkoMWlI82Mk
         4h6/y3/oxdmJ9Pto/YXN+TIj6azOn5+lwm5a/KT2gpbRhXh3NaB8ZnA5C0HLAd1f7ntL
         oLKw==
X-Forwarded-Encrypted: i=1; AJvYcCX9hZ0NeaJ/w4RfexFlSMEQXYCU2HwqqKLnHKC92tisabvIJ/5G+pqAfu/B/YoyhuDM+P8GMQYUNpwJzK20MztnRww0Ru2RDec=
X-Gm-Message-State: AOJu0YzFJFEDnc4T785XTzkoLd20sWRGfj1CJ29PgzMMUMQyBuJbvoGU
	919go69Y6IwLf5LI22O1JS4B1OHqisaM7eXRVYpeU6Ovxad1elIOkPTdRSzRZEhW+TyBgE7p6t8
	/uLY=
X-Google-Smtp-Source: AGHT+IGdOL02otoO6d2EjjoUIFRYH7+G9aMTUYY5zigjMGTBdkse23xtmNLTB+pP7od9PqAjX0C4jQ==
X-Received: by 2002:a1c:4c14:0:b0:415:540e:74e3 with SMTP id 5b1f17b1804b1-41fead6503fmr171301225e9.40.1715863460328;
        Thu, 16 May 2024 05:44:20 -0700 (PDT)
Received: from uffe-tuxpro14.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fdd402518sm253580435e9.27.2024.05.16.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:44:18 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.10
Date: Thu, 16 May 2024 14:44:17 +0200
Message-Id: <20240516124417.22410-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the PR with pmdomain and cpuidle-psci updates for v6.10. When it comes
to cpuidle-psci I intend to continue to funnel those patches via my tree, as
they are often related pmdomain changes.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10

for you to fetch changes up to d88ea30340963d87c267cf1c7ebb2a205ef04e25:

  pmdomain: Merge branch fixes into next (2024-05-03 15:48:21 +0200)

----------------------------------------------------------------
pmdomain core:
 - Don't clear suspended_count at genpd_prepare()
 - Update the rejected/usage counters at system suspend too

pmdomain providers:
 - ti-sci: Fix duplicate PD referrals
 - mediatek: Add MT8188 buck isolation setting
 - renesas: Add R-Car M3-W power-off delay quirk
 - renesas: Split R-Car M3-W and M3-W+ sub-drivers

cpuidle-psci:
 - Update MAINTAINERS to set a git for DT IDLE PM DOMAIN/ARM PSCI PM DOMAIN
 - Update init level to core_initcall()
 - Drop superfluous wrappers psci_dt_attach|detach_cpu()

----------------------------------------------------------------
Geert Uytterhoeven (4):
      pmdomain: renesas: rcar-sysc: Absorb rcar_sysc_ch into rcar_sysc_pd
      pmdomain: renesas: rcar-sysc: Split R-Car M3-W and M3-W+ sub-drivers
      pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper
      pmdomain: renesas: rcar-sysc: Add R-Car M3-W power-off delay quirk

Johnson Wang (1):
      pmdomain: mediatek: Add MT8188 buck isolation setting

Krzysztof Kozlowski (1):
      pmdomain: mediatek: scpsys: drop driver owner assignment

Maulik Shah (1):
      cpuidle: psci: Update init level to core_initcall()

Tomi Valkeinen (1):
      pmdomain: ti-sci: Fix duplicate PD referrals

Ulf Hansson (6):
      cpuidle: psci: Drop superfluous wrappers psci_dt_attach|detach_cpu()
      MAINTAINERS: Add a git for the ARM PSCI PM DOMAIN
      MAINTAINERS: Add a git for the DT IDLE PM DOMAIN
      pmdomain: core: Update the rejected/usage counters at system suspend too
      pmdomain: core: Don't clear suspended_count at genpd_prepare()
      pmdomain: Merge branch fixes into next

 MAINTAINERS                                        |  2 +
 drivers/cpuidle/cpuidle-psci-domain.c              |  3 +-
 drivers/cpuidle/cpuidle-psci.c                     |  5 +-
 drivers/cpuidle/cpuidle-psci.h                     | 20 -------
 drivers/pmdomain/core.c                            | 11 ++--
 drivers/pmdomain/mediatek/mt8188-pm-domains.h      | 14 ++++-
 drivers/pmdomain/mediatek/mtk-scpsys.c             |  1 -
 drivers/pmdomain/renesas/Makefile                  |  4 +-
 drivers/pmdomain/renesas/r8a77960-sysc.c           | 49 +++++++++++++++
 .../renesas/{r8a7796-sysc.c => r8a77961-sysc.c}    | 28 ++-------
 drivers/pmdomain/renesas/rcar-sysc.c               | 70 +++++++++-------------
 drivers/pmdomain/renesas/rcar-sysc.h               |  9 +--
 drivers/pmdomain/ti/ti_sci_pm_domains.c            | 20 ++++++-
 13 files changed, 127 insertions(+), 109 deletions(-)
 create mode 100644 drivers/pmdomain/renesas/r8a77960-sysc.c
 rename drivers/pmdomain/renesas/{r8a7796-sysc.c => r8a77961-sysc.c} (69%)

