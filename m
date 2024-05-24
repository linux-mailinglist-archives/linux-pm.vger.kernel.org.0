Return-Path: <linux-pm+bounces-8094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F48CE2DF
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A309E1F22882
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD5129A99;
	Fri, 24 May 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WmGquE8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A5127E2A
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541486; cv=none; b=PYgtAEESTvIBCib5e51ZdrmMudfpaYkIfiInrEtaGafufj/ZUF0APB7wg2RCZ/Ks9SVO4ZMUy4JnbgAP6TpiFHcPT0dIpsjHUCKfRARMfehlHTixlQVVJWQAQurJt9RQxczxaGyInGxUTkFZKYrX0UJxsZmLKZHEVHTbcp3o3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541486; c=relaxed/simple;
	bh=mfDmkw0HIx+IomXuMfp9apB/0evtliDnYultANgR4zI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cE0q1zbNEvqLgEEWAdWruFIS4tzrU+fmWer25oozG7/bj6bnFDXjJ3Xq20vohwSlSXRwt64zdYDAZAKXoSecvXdzd6cwlgm0vxdy53S2vGCQS/pa1P2WK5BDAwtpEpl7BsZxEJ13sGr6J/3HR8syoO3VoOr6WcAij2OKKpm6g+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WmGquE8f; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42108822e3cso2862125e9.0
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716541481; x=1717146281; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rV9T03dAOKaYLU4JhJP/yk7xRhqLtFBoRnbRFTh0Cw=;
        b=WmGquE8fKltw+x2EFLPi4WwR6V9pnmstSrnH9gcISG0DF9C/+jsrQshY4SfdwcBc57
         ETQS3KjGAbSK+Db8xYTfnqDjBiOF7lRB+nsdMNrv9kGSFoe/vEhVPdjazFxhv9HvZ0az
         c39Tl0Z1GqYbAeo4l9BkgaqCusmNMN0lqJtiuYYMaHaQRRkdyzGigf3X7VhvSNECiX0H
         1w/AqiRab22Hslz4oc97iw2PFL8FWm7LwTemuTri/cL1haB3c7dT25Swc1cMCTkr3kLo
         zjCw4t5g1wkefgKWVqWJBLuQXASrd+4SrBu1Op6zn8+foacMXMzjjt2XnGAc3LCTGwyN
         Fvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541481; x=1717146281;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rV9T03dAOKaYLU4JhJP/yk7xRhqLtFBoRnbRFTh0Cw=;
        b=dTG3qLMb/K7EzUfpRiUkg80thb7qYbQiLLHrTBihtP2xfpugd0TZZ/U9n2Zjg2V1+C
         ECAPeH39glWwtbmaM6JyppnvLbPZezhzMnyStl1AuotPbieuVau85RcGlGU+wRuP2NNy
         OUcXiHdW0p1GAZmWir6mIjOL+b937QFHUllMDk6SjGfMEQ2wp16UpIaRyzWgO9qwivNT
         CSle3/bWKyII0d0ir3jztekkCLv6gcOZud1nGzMGCnZGuFQgQQG4ch+40aNCWowz9vOh
         TIbZRb31yyl6oHeMaLlhmwGvEm9l9kAHhwFSeJHgOAlMBHVLmb2ivTJp3KOiTHKsHXgs
         bByw==
X-Forwarded-Encrypted: i=1; AJvYcCWPcuUXzwyBr7os2FWtoiedHZrCaTW2MAad0eCvibQek/3uAJmiUZ9AhGqW4ABU6toJdwuRksPRk79HYd95IyY+6JbgbkWi/Y4=
X-Gm-Message-State: AOJu0Yxh3DHvTh9X1pFUILFntw75PqTdLAYvvrNb5trvT+QxxRV/dnI2
	Hg19pKn8OLI8hxOYq7ZEO0FSvEakZDAlXj5DDRlcSqm57jMz6d1gjCWUOt02b/k=
X-Google-Smtp-Source: AGHT+IF7CQjZGEs3LnbK5/SUvoBlO1GBsf01qMc/AU90RdPkZ7/4pI6JpfohZZtS8F0E8KnZ0DDcnA==
X-Received: by 2002:a05:600c:46c8:b0:41f:ae5a:c72f with SMTP id 5b1f17b1804b1-421015a5fc5mr40923795e9.1.1716541481069;
        Fri, 24 May 2024 02:04:41 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm47273045e9.13.2024.05.24.02.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:04:40 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v5 0/6] Mediatek thermal sensor driver support for MT8186
 and MT8188
Date: Fri, 24 May 2024 11:04:33 +0200
Message-Id: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFYUGYC/3WNzQ6CMBCEX4Xs2TUtFiiefA/Doa2LbOTHtA2BE
 N7dSuLR23yTzDcbBPJMAa7ZBp5mDjyNCYpTBq4z45OQH4khF7kSRS5wiC+MHfnB9ClrqRd8xMB
 Izlwq3da2NALS+u2p5eUw35vEHYc4+fU4mtW3/TnlX+esUKCtJVFZaSWlu1mz9mw9nd00QLPv+
 wdkDEJBwQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541478; l=3306;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=mfDmkw0HIx+IomXuMfp9apB/0evtliDnYultANgR4zI=;
 b=hrtC52UcUaT+pplwH+tZsJghD1tr1rDCfrQA55d38kaALKgzhDIy+7+8Eik+Me5NQqxH+Ab/w
 HxQjT4VnR4wD0YPNNGFMWaGIXofHdFhivEgBaTbUyTAYtRe0tozS+xv
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations.

Since the patches of v3 were applied except those related to the SoC
device trees, this series includes mainly patches for 'mt8186.dtsi'
and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
trees, the related definitions were also renamed in the dt-bindings and
in the driver.

[RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNING:
"DT binding docs and includes should be a separate patch." That's why I
split them in this v5. The problem is that the driver can't be compiled
any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
and PATCH 2/6 ?

[NOTE] Before being applied, PATCH 6/6 needs a 'gpu' node in 'mt8188.dtsi',
but this node does not exist yet. A series will be submitted by Angelo to
add this GPU support in MT8188.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v5:
- Rename some thermal zones
  (mfg -> gpu / soc1 -> adsp / soc2 -> vdo / soc3 -> infra).
- Add cooling-device for GPUs.
- Link to v4: https://lore.kernel.org/r/20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com

Changes in v4:
- Fix wrong thermal zone names.
- Lower 'polling-delay-passive' values.
- Set 'hysteresis' value to 0 for 'critical' trips.
- Add a 'hot' trip point in between 'passive' and 'critical' trips.
- Link to v3: https://lore.kernel.org/all/20240402032729.2736685-1-nico@fluxnic.net/

Changes in v3:
- use meaningful name for binding index definitions
- reuse LVTS_COEFF_*_MT7988 on MT8186 per reviewer request
- do similarly for MT8188 that now reuses LVTS_COEFF_*_MT8195
- use thermal zone names the svs driver wants
- adjust some DT node names and iospace length
- remove variable .hw_tshut_temp as it is constant across all SOCs
- Link to v2: https://lore.kernel.org/all/20240318212428.3843952-1-nico@fluxnic.net/

Changes in v2:
- renamed CPU cluster thermal zones in DT
- fixed logic to cope with empty controller slots at the beginning
- isolated bindings to their own patches
- added MT8188 default thermal zones
- Link to v1: https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/

---
Julien Panis (2):
      dt-bindings: thermal: mediatek: Rename thermal zone definitions for MT8186 and MT8188
      thermal/drivers/mediatek/lvts_thermal: Use renamed thermal zone definitions for MT8186 and MT8188

Nicolas Pitre (4):
      arm64: dts: mediatek: mt8186: add lvts definitions
      arm64: dts: mediatek: mt8186: add default thermal zones
      arm64: dts: mediatek: mt8188: add lvts definitions
      arm64: dts: mediatek: mt8188: add default thermal zones

 arch/arm64/boot/dts/mediatek/mt8186.dtsi           | 316 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 481 +++++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c            |  12 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +-
 4 files changed, 809 insertions(+), 12 deletions(-)
---
base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
change-id: 20240520-mtk-thermal-mt818x-dtsi-eca378f9b6a0

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


