Return-Path: <linux-pm+bounces-42354-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGi0LffXiWlUCQAAu9opvQ
	(envelope-from <linux-pm+bounces-42354-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 13:49:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1710EFE2
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B68303AF06
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AE234973;
	Mon,  9 Feb 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwXBGwWD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48423373D
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641283; cv=none; b=uQC0bX0bCJpNFLC/0HCBtMdj3CwXT4Mg1OZIoSRlWlhquTSDzQTzLZ4sH0Ql4haqokf+amzBJ2b1bLbVqzC19ZgwMvOOTZalFx9lJwUrP+2+fYLzaF3B8YWqzQ3JpqIFx1fJsyGh5udsv81MKWds4faM6MHy0sPMMRibloaZL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641283; c=relaxed/simple;
	bh=+F9cXjrDCN4wD2HXJ6wTnDQyDW6SNlLEvh6QwBKxyM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCGw8Q/71g7daJ164YbFB6GeOuBldlLmMNnXYudRgGytZqCqTqYgRXZz+IXfC/T6fvfSelc7XctArKeLVzn/5c2lULTc6SgV09NuYbeiLesHRT51t48EIgsG8q8RpdHqPQIx3f2dy/PDSQB+B7QQZ8bEFvnIh6hMb1VIvqCm4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwXBGwWD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e4989dacdso2110698e87.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770641281; x=1771246081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdQQK6HA2N5wcX6J2p0xOEK4xhy0f1zgRy0FKVKyb1w=;
        b=jwXBGwWDDVff/LFw2wMswNZ8qlHnQ3Z3ZOStIH5RwRerUd9qW6yPDo4BY8DBj5LDG8
         piGOPYUO71DH38aNE66uRDgT8sHPLRic3UI/FPq8KarU3LazoU/f24SM8ql4cqMKDGx9
         5OQrU/ka7xWgVW9L0Iw0elEZNSS5PRun1ZxRXpJ8tXfoY6ze6h3+3qmWJh3bYdkao+zS
         GzhY/Re0XxeeJ9YjvCcGUeZylKj32NtjkV5XmOVX+sTiy3w+Ebsei25qhWpmvpNCDsCQ
         i9CVnXlQMSDsNKZ5Gd5B91mmEUIKvpIa4dtni7BuRYjGMdGVU99BLlJgWbfAoW8UggPc
         FlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641281; x=1771246081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdQQK6HA2N5wcX6J2p0xOEK4xhy0f1zgRy0FKVKyb1w=;
        b=DIB8cdks8L1ZpQOuPWDaYjk91KXZNauG6u+1i6134sugKqHqX8zKmEr/w5D/9mfT8D
         oCf67GU+TBUfOmb623ugMEKJdA89y1rEekiI0QYmReJM3aICVQSaiqCwVo6F58oXHH7U
         TJkglpFin4ddNpPlD+iBFqN5voxqpnG6iFlbXr09C0hleCDXF0ctKNnSD0KPtH5lf50u
         SipTzQfNB5LX47V9ciKBryQOoVyDWNzGEqkfjPkQzZmsvOOjkHAz3PFLN8bN46PTAwts
         6oiC9JVXa0hYZex3+vNOgCLDAsWfngy+aSns8/cStNVbDSN3fELY7VlthHwt/dYDRIDv
         E+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMoWzp7gMH/TvqhdfD6ApoEdnteshWciNjjk69hH+xsCd0PHvB90hfdGNwa8VG7EOiL//Ldgziqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvzJlUvL0d3YeJTG4ChV1AOuKgAwoavQLHT33ag18FyPZvvQ8
	9wYNaiENKel/8gUHaxkFRRQHEVZVzFQYkjnUhsr4iL8RKqJbzPOp7A8S2o66dA8Su087qSpCo4V
	ItE0a
X-Gm-Gg: AZuq6aJon9mtWxs9N0320W0vHAcaxpCUwx6yDNUMZ1wjbgpCtnlcaixfgHccTs/2UxQ
	9YaQ6jvHHVneS3632ezlVkBKpg6Jne3XyhW9r/V/0Jasv3kJQA+Ug765nsbcY0Drebkfb8rw8AH
	46WcOQeev4TOijhX+3vTzyrwa8ia2QB4N303Zrw8ezdJFFdY5g2bctNtL5mU7Ql96HHCkDuJPA4
	wxgU89nkSRdDblLbc4/92bI1gvU8rX1M/N7NXhyLA/+IIYZ/C8rOIFxOge4ofgtM09L3bjAgwNX
	FYfqySYeeXXi4dK/C6BCCU30bfAggGU/6h7Qa0HAg2hozpovF0mBYPnwM2yytVQv3QNGDX5Y1YQ
	UqiH8bFy0Vh2LLKYx8cU/lcscOReF2S06y06MhpJ6dw8h7yhAaTSyJX9SbWrhdcuHnNJGiPBZEQ
	zF7k7N6KIWMsV1+MWnmSS7kxfsVllaoiQ=
X-Received: by 2002:a05:6512:3ca1:b0:59d:e7ac:619f with SMTP id 2adb3069b0e04-59e4504c6b8mr3559631e87.18.1770641281237;
        Mon, 09 Feb 2026 04:48:01 -0800 (PST)
Received: from uffe-tuxpro14.. ([2a02:1406:249:f8a3:3249:60bc:db1:48cb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cff6a5sm2622296e87.34.2026.02.09.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 04:48:00 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v7.0
Date: Mon,  9 Feb 2026 13:47:57 +0100
Message-ID: <20260209124757.554032-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42354-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 34E1710EFE2
X-Rspamd-Action: no action

Hi Linus,

Here's the pull-request with pmdomain updates for v7.0. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e2c4c5b2bbd4f688a0f9f6da26cdf6d723c53478:

  pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup (2026-02-05 11:33:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0

for you to fetch changes up to 1fca2a4426aac222a724770a56c71e6bb3cf96f2:

  pmdomain: Merge branch fixes into next (2026-02-05 11:52:19 +0100)

----------------------------------------------------------------
pmdomain core:
 - Extend debugfs support for domain idle states

pmdomain providers:
 - imx: Add suppport for child nodes for imx93-blk-ctrl power domains
 - marvell: Add support for the audio power island for Marvell PXA1908
 - mediatek: Add support for the MT7622 audio power domain
 - mediatek: Expose shader_present as nvmem cell for mt8196-gpufreq
 - mediatek: Add support for the the MT8189 SoC
 - ti: Handle wakeup constraint for out-of-band wakeup for ti_sci domains

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
      pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy driver

Dmitry Baryshkov (1):
      pmdomain: de-constify fields struct dev_pm_domain_attach_data

Felix Gu (2):
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()

Gabor Juhos (1):
      pmdomain: qcom: rpmpd: drop stray semicolon

Irving-CH Lin (3):
      dt-bindings: power: Add MediaTek MT8189 power domain
      pmdomain: mediatek: Add bus protect control flow for MT8189
      pmdomain: mediatek: Add power domain driver for MT8189 SoC

Karel Balej (2):
      dt-bindings: power: define ID for Marvell PXA1908 audio domain
      pmdomain: add audio power island for Marvell PXA1908 SoC

Kendall Willis (1):
      pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup

Krzysztof Kozlowski (1):
      pmdomain: mediatek: Simplify with scoped for each OF child loop

Marco Felsch (3):
      pmdomain: imx93-blk-ctrl: cleanup error path
      pmdomain: imx93-blk-ctrl: convert to devm_* only
      pmdomain: imx93-blk-ctrl: add support for optional subnodes

Nicolas Frattaroli (2):
      dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
      pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell

Rafael J. Wysocki (1):
      pmdomain: imx: gpcv2: Discard pm_runtime_put() return value

Ulf Hansson (13):
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: core: Restructure domain idle states data for genpd in debugfs
      pmdomain: core: Show latency/residency for domain idle states in debugfs
      pmdomain: core: Extend statistics for domain idle states with s2idle data
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch core into next
      pmdomain: Merge branch fixes into next

 .../bindings/power/mediatek,mt8196-gpufreq.yaml    |  13 +
 .../bindings/power/mediatek,power-controller.yaml  |   1 +
 drivers/pmdomain/core.c                            |  59 ++-
 drivers/pmdomain/imx/gpcv2.c                       |   4 +-
 drivers/pmdomain/imx/imx93-blk-ctrl.c              |  77 ++--
 drivers/pmdomain/imx/scu-pd.c                      |   1 +
 .../pmdomain/marvell/pxa1908-power-controller.c    |  39 +-
 drivers/pmdomain/mediatek/mt8189-pm-domains.h      | 485 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       |  59 +++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  44 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   5 +
 drivers/pmdomain/mediatek/mtk-scpsys.c             |  10 +
 drivers/pmdomain/qcom/rpmpd.c                      |   2 +-
 drivers/pmdomain/ti/omap_prm.c                     |   1 +
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |   5 +-
 include/dt-bindings/power/marvell,pxa1908-power.h  |   1 +
 include/dt-bindings/power/mediatek,mt8189-power.h  |  38 ++
 include/dt-bindings/power/mt7622-power.h           |   1 +
 include/linux/pm_domain.h                          |   5 +-
 19 files changed, 779 insertions(+), 71 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

