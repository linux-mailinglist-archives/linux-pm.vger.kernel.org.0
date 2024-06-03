Return-Path: <linux-pm+bounces-8516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CA8D8040
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE082B21655
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4B82D98;
	Mon,  3 Jun 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1xOC5/uK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB887FBC4
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411862; cv=none; b=fqtnIFmKK0cpa2MOP97OiziRRy0ken4duuTa9GpVc63dHp0gkCQPDatYOlAqAWAjx0iRjfvOxO/HYd09NCPGuAwIaf8DT0ujpdsfr6gurAevCOUcvcuOE1kzL2GOS35JahaeC/UG8vafyRYxF+GZHkbdZwzfiYvx8azxGjHmOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411862; c=relaxed/simple;
	bh=5DVeAMWdqWUXERR27J00cNATFK2F7gYJVhCAomHF6Qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Voddd9kGW9ZOXVXuUI+Tu/gIuCyeBf+5Sb93xNjM+DBD1NTDl4kfwskKK2/MHb/S6AaQq758FjUxyX5LtjVst+E6ETkSvWyF1Fyoh4ttVe6YuPJCI4so/G0P9ycUC+ap3fyp3Mf0n13NQi6rxLku4el2sqSS1PTcuj/9SrVmuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1xOC5/uK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso39836665e9.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2024 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717411858; x=1718016658; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdnKk0U8YIgyphmfdZ5S6P2OG6FjluzorDu+ngQ8lF4=;
        b=1xOC5/uKK561AeGal4BxLbtBiEClk2dZgvYeOtPpkOaSGQ6A6801ofQyb4ZmnGB1WB
         TqwH/7qMHV+XDskaY7VhNAzxBUaD57U4Hcv14MWWNfEQ2s+KQsrXOuJjlPa4g3y7UsCj
         vV3k27qR3Ocj9epZI0bEYHitjQdeq5Xirqgj1lyZgvlfpvFYaS5AziXP3b7sVpMO0E5c
         yXZXW7gEDwRMTl3PWKj1zRXgf5qLs5Twp7i6gyXDb/eFmJZLHmCTJeHt3P5wKVNMD58G
         HFQNAjaObj1zUoVl67HaUmtdJQF2bXzgJNPhn7maYRPctGg4lEEgViGxGvcNVyYjYjur
         Gm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717411858; x=1718016658;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdnKk0U8YIgyphmfdZ5S6P2OG6FjluzorDu+ngQ8lF4=;
        b=TjTzbWT0c5p9l6fboSKgqbbmtRrc+4xmMc73UE7j0qJqX/jtIUT5TSZREPXt/pkIwI
         bdFOOpWYThxKlr/6upeCAJQc9QqSzcSVDyBzn5jm8ieo/d1TMe2vR5Myz9LEWMiyfQ9B
         z1gMSjT1OfYcDNaCH99UaGxt5dqhMD+RfJoVfAeHU/ULfmIrhGKs2u04CsPv9Nn9ce+F
         R4Bz1N/XznGb0/9qKC5X7wsKLuheCIaeItRPcxXNnSXiDR4dLXW7aRnB7E6EZRl0c8dS
         UR2OqvZ6ROK0p1LCyTJUBf+5UMTS5LxKMhEhDcMNG9dbCs4xVchqTnN73cgoVDudrP/B
         bKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2eVBzzWv/lNksVVewe7PKSqqtIPM0IzkQ++x7M3PlWmfbjROf/BRH7Zc5fJ8NxSNWsClcrosp/r/7N0konwnAmV/boeNQkTI=
X-Gm-Message-State: AOJu0Yz++jkOLChp9Ig9+6A1IktxP47RGVu2QJ7qVJOVRLup2A4I8b+O
	D46wIx4oMdcHsdwEFFDZWpSOWu0P17EZrsPLWLnk+HM7KeTEBVFMCnetMtgFJtA=
X-Google-Smtp-Source: AGHT+IFaWoT1e6TvoB0AgmpyT+2utdI+mwIyeAACDTQGOs0bgoK2STYvUX7gmBuqBz+wV3mWSKvPyA==
X-Received: by 2002:a05:600c:511f:b0:41e:3272:6476 with SMTP id 5b1f17b1804b1-4212e049d8dmr81844775e9.10.1717411857652;
        Mon, 03 Jun 2024 03:50:57 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm95372535e9.19.2024.06.03.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:50:57 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v7 0/6] Mediatek thermal sensor driver support for MT8186
 and MT8188
Date: Mon, 03 Jun 2024 12:50:47 +0200
Message-Id: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAegXWYC/3XNSwqDMBCA4auUrJuSxDy76j1KFzGONdRHSUQU8
 e6NQkFK3c0/MN/MKELwENH1NKMAg4++a1Oo8wm5yrZPwL5IjRhhnAhGcNO/cF9BaGydZk31iIs
 +egzOZkqXJpeWoHT9DlD6cZPvj9SVj30Xpu3RwNft16SH5sAxwbmhAFJpTqm75XaqfR7g4roGr
 ewg9hQ/pkSihCy1UEYzAuoPJfeUOaZkoohTlCttjct+qWVZPubgLqFXAQAA
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
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717411855; l=3307;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=5DVeAMWdqWUXERR27J00cNATFK2F7gYJVhCAomHF6Qg=;
 b=NesfOkcMI7jH2us7UExx5sohtZ+j/QjcLttLXw1c0jGe3ZLnWMyVUDrdRjdSDV57lDUh26sOi
 fHX5skCdve7D6y0WGoeYBsNs3MWYJRL/097ekokb7VojvzooFZVV7AN
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations.

Since the patches of v3 were applied except those related to the SoC
device trees, this series includes mainly patches for 'mt8186.dtsi'
and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
trees, the related definitions were also renamed in the dt-bindings and
in the driver.

Because of the GPU thermal zone, this series must be applied on top of [1].

[1] https://lore.kernel.org/all/20240527093908.97574-1-angelogioacchino.delregno@collabora.com/

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v7:
- Change commit message for dt-bindings patches.
- Link to v6: https://lore.kernel.org/r/20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com

Changes in v6:
- Reorganize patches related to thermal zone renaming (dt-bindings + driver).
- Add cooling-cells property to GPU node in 'mt8188.dtsi'
- Link to v5: https://lore.kernel.org/r/20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com

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
      dt-bindings: thermal: mediatek: Fix thermal zone definition for MT8186
      dt-bindings: thermal: mediatek: Fix thermal zone definitions for MT8188

Nicolas Pitre (4):
      arm64: dts: mediatek: mt8186: add lvts definitions
      arm64: dts: mediatek: mt8186: add default thermal zones
      arm64: dts: mediatek: mt8188: add lvts definitions
      arm64: dts: mediatek: mt8188: add default thermal zones

 arch/arm64/boot/dts/mediatek/mt8186.dtsi           | 316 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 482 +++++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c            |  12 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +-
 4 files changed, 810 insertions(+), 12 deletions(-)
---
base-commit: b321abd919e22b240d53329cd726ea7afa8aca98
change-id: 20240520-mtk-thermal-mt818x-dtsi-eca378f9b6a0

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


