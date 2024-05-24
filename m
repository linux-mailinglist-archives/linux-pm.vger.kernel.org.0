Return-Path: <linux-pm+bounces-8106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF268CE710
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD51C223B5
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0212C7E8;
	Fri, 24 May 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uODYvmaR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846142AB7
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561119; cv=none; b=PrKxYA3kuYiQNAY9q1AuiiKE1aN9MTCb5nLRw2jFHxTG3F+qZXS/QCYEygKD6E219QRxnNhreFzwitZhH5pHWGWs3DT/1WrlGpg3tuKwY7LesxfZSXtUvyFqfkyX+j8EAj5DlIOqAPf7y0GXL4/JJGl4xWZaoAwpuEUN+iRM4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561119; c=relaxed/simple;
	bh=eii+NoZyNpw84hy2WXOgeXt6oQHQp1jBKy2ascwjxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlHCD3icuAO7JYAsmYsx7Rv8F62echUdF5RXCiEMlYaa6L/ORegT/LZNQU4dIhq5OOHgij+g6pO5Mjp/YASTECCGg+9bqshhycool+8avzM5ywbdG81CONfXYVOscC/3oAg+dc8kh3WQKwEz4I2S9ajptb/I9F3BzV+59adB3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uODYvmaR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-351d309bbecso6160113f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561114; x=1717165914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuS2wqmAAZkhpsH6k38Gnd81bprVdYOR/AWVKTibeV4=;
        b=uODYvmaRBzdSapqXKW2RnYSBHCKL5BszyD8CoWobZnHUiC6/z6JKygsEf2BrCh8wuG
         pCLIYwPEelmqmiePdCzgQvj8kFLoC1KBHoyfzdm2MG4TTIl49iVk7Ux52QOCU6tADg+m
         bQevVJc0oPU4s9DaM8cVkCYE8XdAp/J+j/j8l8JAQQB5l6EDPczIX1eRVkuhZXfnTH4R
         B/OahwhgbjRJzo+TVIOAgtFmkhXHnKpCqG7PJ/50CEhEPRQzcKL5NAoZZgdiUsy5Bs2w
         XMEFYw6xYZi6XD5pPEFYIvf1QUSi0p8CgyAonZj2XJRxota++sad6QbwCvWIlOh8Oarq
         OVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561114; x=1717165914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuS2wqmAAZkhpsH6k38Gnd81bprVdYOR/AWVKTibeV4=;
        b=HUgY7nyqbgOaRzdkDABNWGgB+0m/AL9rnG3hQWe3gLI4cTLFefJFVEKXwkmx/W5X0s
         +O9T4nVFaOqzaxzjwRowo+epnewQvqLEsgeqPcYv0nHRyWecxHP7p5MhFcIxkBrVmZBK
         QueBNoNPIbKqWRkLxlaZJisxPFrZb9PY2Nf1mcRSsuTnNgrUoW9YlqkZpLt7AxnPNbGc
         NOBxpE6Zy/mUCpVqoXglQDB03V6ULUdUsysvd4dUGg3d+21wQkiPy03sH68shgnWTxOe
         aU6PmmswWug8KG6g2+zQvtTsKB39jZn61/nITGz5EZpZuVQeWra4g5s6VmUoDwdLHsfK
         nQeg==
X-Forwarded-Encrypted: i=1; AJvYcCUgR1p3jo3oIf4YFM9bqtMRm1CF2xif5ASVGjgdWkqos56VgaMnuwEPwrBUiysoWYWW0pAcOFThURO734rc/eZ18M6pkHPCm4s=
X-Gm-Message-State: AOJu0Yw3KbLFtQnmRnQLdGBBemB/cKgUoKooMnMgv83jghMxa2mFYZi1
	inTxTPWLbejTE8xkOLpMgzKSyuPldbNVEjGjMlWSmCJ2bDztt70pskkcd9NV1I8=
X-Google-Smtp-Source: AGHT+IEbdJCC5eZIR1rygjjmZd59Z//WDDRE/R79C+N8FU4t05p2Z6OsfVsrR6DQ5hJAV1a4vSOhAQ==
X-Received: by 2002:a5d:5221:0:b0:351:b56e:8bc3 with SMTP id ffacd0b85a97d-3552fe02a52mr1924254f8f.53.1716561114161;
        Fri, 24 May 2024 07:31:54 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:31:53 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 0/6] thermal: Add support of multiple sensors
Date: Fri, 24 May 2024 16:31:44 +0200
Message-ID: <20240524143150.610949-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following this comment [1], this updates thermal_of to support multiple
sensors.

This series intends to add support of thermal aggregation.
One use case for it is using the IPA in the case we have
multiple sensors for one performance domain.

This has been tested on the mt8195 using s-tui.
To test and validate, we heat up the CPU and the heat sink.
At some point, we run benchmark tests with different configurations:
- Mediatek kernel (IPA + their own thermal aggregation)
- Mainline kernel
- Mainline kernel with IPA and aggregation enabled
With the IPA and the aggregation enabled, we get the best performances
with the most stable CPU temperature.

The aggregation is configured and enabled using device tree.
One thermal zone has to be created with a list of sensors.
It will take care of registering a thermal zone for each sensors.
The cooling device will only be registered with the aggregating thermal zone.

There are still something important missing: a way to check that all
aggregated sensors are part of the same performance domain.
So far, I don't see how this should be done. Some recommendations would be
appreciated.

Changes in v2:
- Rebased on 6.7
- Seperated generic multi sensor and dt specfic code
- Simplified the code
- Drop min / max and only do weighted average (seems more adequate for IPA)

Changes in v3:
- Rebased on 6.9
- Reworked the way to register a multi sensor thermal zone
  - Only one thermal zone to define in device tree
- Max has been re-added
- Enabled it on mt8195

[1]: https://patchwork.kernel.org/comment/24723927/

Alexandre Bailon (6):
  dt-bindings: thermal: Restore the thermal-sensors property
  thermal: Add support of multi sensors to thermal_core
  thermal: Add support of multi sensors to thermal_of
  dt-bindings: thermal: Add a property to select the aggregation type
  thermal: of: Parse aggregation property to select the aggegration type
  ARM64: mt8195: Use thermal aggregation for big and little cpu

 .../bindings/thermal/thermal-zones.yaml       |  13 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 212 ++---------
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/thermal_core.h                |  15 +
 drivers/thermal/thermal_multi.c               | 332 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  | 282 ++++++++++++++-
 include/uapi/linux/thermal.h                  |   5 +
 7 files changed, 663 insertions(+), 197 deletions(-)
 create mode 100644 drivers/thermal/thermal_multi.c

-- 
2.44.1


