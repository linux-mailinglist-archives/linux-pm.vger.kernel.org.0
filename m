Return-Path: <linux-pm+bounces-4829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641987841A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A4A1C21AEB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CA44C7C;
	Mon, 11 Mar 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS/07v87"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB744C6A
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171970; cv=none; b=Ag2JNtZCu5g6IbmTlVqjOr4UCOCM7OsYY3rKo7nlwhdcZpQ9vSOCeULW4Iy36GPvtTx2tMbTqWlNreo93egq5vu8w+zvPoMYGBh05CaAqfup3kM54Q+gu/lgotJ1UZFvcMz0Bo36+xqwSNJEjVkaJrIFFamKl+fFeQmgTY6NoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171970; c=relaxed/simple;
	bh=gFDUuj57lYr4wG8krVTq8NkfsBL43/jiGP8AhQV7/DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dysluN0pKkI0iX5rqCgYCZLItm2koN/QdsQYQOTSdvPaY3YQzmg3A2Q0wC68ewt2unl95vmbgC85JFii90PWGEauAoAzVSfqrYgVli1LZUV2HY5QZN9s4Yc8aWHYLwxagAoMOzcjkPCPdoN3DoFOKs/YrbC4w4jDSaYAzmihPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KS/07v87; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512e39226efso4411498e87.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710171966; x=1710776766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUYX9uojUp5ax4gJj/GFoNZKgIJDaBka6QZETxo7B58=;
        b=KS/07v87cYTpm/t7Nw+c9hSe9R+/PeY9WBpNoy+Pz/Q2YYLpDmJ5V8tLwv7leUdvtP
         FPyanVTn4Z5+wdyC4wPc3xpUIrprDnBJGfpxaOHzdd/6jRla6qa1kopfHo90vfAWEwgd
         MAfiboOg1ymSMKfyndoMmyAyvj2BjAw5JwEW6xpC/TDfwG4jpqliwItZQo52MTUzLh/x
         UOOLSlJVJoBPrS51yYOoA7VvDG/FNDBJA7FCCkY324YGbYbWewWkkwLmTxAp0evITZBd
         Gc6zB+qk5fNP0dRLK3GrnCODStrtnCVoc8QjBeKXQTws/g7q/A6BEXGgRmMYXm5GqYA6
         BiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171966; x=1710776766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUYX9uojUp5ax4gJj/GFoNZKgIJDaBka6QZETxo7B58=;
        b=W5turcCNb3WncMncoa2VpkhwPTv9nKwFvMZFleH8ZDP5TnXMpjrJY5XJkoKEWt1cWS
         0wJ60ndfkDuajBgCEcbJ1tejKwWRkgKgQwfi9wVy/ipv5D05zhBE30+I8V2/dKWJpoQ8
         a3oLcXlgySrlxcV+EnLcHbHvA9l/cAifoZzJM8K7prYJsYwwUXtpHZ4u3PBNkVQTepPK
         02801Lx+Tl8tFLd5h/2HxCgiOnLm5QhrdJB7+uxgH6jHGGTGvQpUXkFuXiHGhxE5Lmuh
         T4z6ZznFqDAwQw7PIvTvy/DC0iiRZayPHs4Lc5lXjNvFVY9SShfuJNJo3e3FjmuiwWGG
         ZB1w==
X-Forwarded-Encrypted: i=1; AJvYcCWRGvtA1ZOoniWQNLaM32aBoK62/URKnPtMlNAphnKeHoLO3dI8XWdnDDUrqW7jAfeSG2lpFvOnaras87k2meJ+Gso/IedhmjA=
X-Gm-Message-State: AOJu0YwxjjIfBGzs+sjnYjTqh9kKVWX3hwv1jCA+TpBCpTO8tDGDMxzp
	kNaz8w8UuZSfNjCTxQhKk6ivdvk5mkkntrEZYmyGQWmpgCnaUHQSJB4uMGF9xjg=
X-Google-Smtp-Source: AGHT+IEeuLmyBO0IoJnRxGN0zIrcN/c5KYRHmU2IUoV8gW/Levqp24JcR5bSBb/CjJ9TNJswcTmDjA==
X-Received: by 2002:a05:6512:31c7:b0:512:e00b:8da4 with SMTP id j7-20020a05651231c700b00512e00b8da4mr6101963lfe.53.1710171966223;
        Mon, 11 Mar 2024 08:46:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b005131544fc6fsm1154454lfg.291.2024.03.11.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:46:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.9
Date: Mon, 11 Mar 2024 16:46:04 +0100
Message-Id: <20240311154604.3069122-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain updates for v6.9. Details about the
highlights are as usual found in the signed tag.

Please note that, there are a couple remoteproc drivers and a media driver
changed here as well, ack-ed of course. Potentially those may cause some merge
conflicts, but just let me know if there are some issues.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2a93c6cbd5a703d44c414a3c3945a87ce11430ba:

  pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation (2024-02-28 16:31:45 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.9

for you to fetch changes up to ccabbb6768fc72d6cb0223324925c93658d91e63:

  pmdomain: renesas: rcar-gen4-sysc: Reduce atomic delays (2024-03-06 11:25:27 +0100)

----------------------------------------------------------------
Core:
 - Log a message when unused PM domains gets disabled
 - Scale down parent/child performance states in the reverse order

Providers:
 - qcom: rpmpd: Add power domains support for MSM8974, MSM8974PRO, PMA8084
   and PM8841
 - renesas: rcar-gen4-sysc: Reduce atomic delays
 - renesas: rcar-sysc: Adjust the waiting time to cover the worst case
 - renesas: r8a779h0-sysc: Add support for the r8a779h0 PM domains
 - imx: imx8mp-blk-ctrl: Add the fdcc clock to the hdmimix domains
 - imx: imx8mp-blk-ctrl: Error out if domains are missing in DT

Improve support for multiple PM domains:
 - Add two helper functions to attach/detach multiple PM domains
 - Convert a couple of drivers to use the new helper functions

----------------------------------------------------------------
Adam Ford (2):
      dt-bindings: soc: imx: add missing clock and power-domains to imx8mp-hdmi-blk-ctrl
      pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain

Dien Pham (1):
      pmdomain: renesas: Adjust the waiting time to cover the worst case

Duy Nguyen (3):
      dt-bindings: power: renesas,rcar-sysc: Document R-Car V4M support
      dt-bindings: power: Add r8a779h0 SYSC power domain definitions
      pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support

Geert Uytterhoeven (2):
      pmdomain: renesas: rcar-gen4-sysc: Remove unneeded includes
      pmdomain: renesas: rcar-gen4-sysc: Reduce atomic delays

Konrad Dybcio (2):
      pmdomain: qcom: rpmpd: Keep one RPM handle for all RPMPDs
      pmdomain: core: Print a message when unused power domains are disabled

Krzysztof Kozlowski (2):
      pmdomain: core: constify of_phandle_args in xlate
      pmdomain: core: constify of_phandle_args in add device and subdomain

Kunwu Chan (1):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Luca Weiss (3):
      dt-bindings: power: rpmpd: Add MSM8974 power domains
      pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power domains
      pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power domains

Marek Vasut (1):
      pmdomain: imx8mp-blk-ctrl: Error out if domains are missing in DT

Markus Elfring (1):
      pmdomain: mediatek: Use devm_platform_ioremap_resource() in init_scp()

Stephan Gerhold (1):
      pmdomain: core: Scale down parent/child performance states in reverse order

Ulf Hansson (8):
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      PM: domains: Add helper functions to attach/detach multiple PM domains
      remoteproc: imx_dsp_rproc: Convert to dev_pm_domain_attach|detach_list()
      remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
      remoteproc: qcom_q6v5_adsp: Convert to dev_pm_domain_attach|detach_list()
      media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec
      pmdomain: Merge branch fixes into next

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 .../bindings/power/renesas,rcar-sysc.yaml          |   1 +
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml |  22 +--
 drivers/base/power/common.c                        | 134 +++++++++++++++++
 drivers/media/platform/qcom/venus/core.c           |  12 +-
 drivers/media/platform/qcom/venus/core.h           |   7 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |  48 +++----
 drivers/pmdomain/core.c                            | 141 +++++++++++-------
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |   9 +-
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             |  19 +--
 drivers/pmdomain/imx/scu-pd.c                      |   2 +-
 drivers/pmdomain/mediatek/mtk-scpsys.c             |   4 +-
 drivers/pmdomain/qcom/rpmpd.c                      |  96 ++++++++++++-
 drivers/pmdomain/renesas/Kconfig                   |   4 +
 drivers/pmdomain/renesas/Makefile                  |   1 +
 drivers/pmdomain/renesas/r8a779a0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779f0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779g0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779h0-sysc.c           |  54 +++++++
 drivers/pmdomain/renesas/rcar-gen4-sysc.c          |  17 ++-
 drivers/pmdomain/renesas/rcar-gen4-sysc.h          |   1 +
 drivers/pmdomain/renesas/rcar-sysc.c               |   4 +-
 drivers/pmdomain/tegra/powergate-bpmp.c            |   2 +-
 drivers/pmdomain/ti/omap_prm.c                     |   2 +
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |   2 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c        |   2 +-
 drivers/remoteproc/imx_dsp_rproc.c                 |  82 ++---------
 drivers/remoteproc/imx_rproc.c                     |  73 ++--------
 drivers/remoteproc/qcom_q6v5_adsp.c                | 160 ++++++++++-----------
 include/dt-bindings/power/qcom-rpmpd.h             |   7 +
 include/dt-bindings/power/renesas,r8a779h0-sysc.h  |  49 +++++++
 include/linux/pm_domain.h                          |  60 ++++++--
 32 files changed, 644 insertions(+), 409 deletions(-)
 create mode 100644 drivers/pmdomain/renesas/r8a779h0-sysc.c
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h

