Return-Path: <linux-pm+bounces-11114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5B93172F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363311F22484
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DCB18F2C9;
	Mon, 15 Jul 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+yNZCPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288E18EFE6
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054932; cv=none; b=tUnneiW47XttF1do0T+slrz0pHdRkz8Cgh1o7jaGXkHV36x6Uq3WS5WXKxp5qBU0V3YvAoXv5asyPT5zTsl3iEDq5v6ZnhFXS97oaxR9PvV5nSY9zvZZxZi432pSddv4LKsv2Krm5pinY0btY0/4J8QeSQZhDXeaHzYgjKmlD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054932; c=relaxed/simple;
	bh=mpynuQncTagIAy+uXPPY7HqIFp6FzM0Pf3IEHNAjkAs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GorthJKxoIeE7nLZmNjwTQE1oVLUKZEDZn3ROxt/3sVboiBgAqQ6VWQwII1hpN8H2aNiiSc0hqvqMVQblNBKWyZTx9rZmvnKV3+6I5+RxTuspNCYADZspGrry2354zKUAEMU3w+/cPpvqam+31m3FqyNc5pj8nPiBsJnaoiDMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+yNZCPw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so34220435e9.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721054929; x=1721659729; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0DM0hpkMCV++G5LBwit7+udBH5/skYkvxpVfeja9jg=;
        b=K+yNZCPwPpEiBTHYWiFrCQ2kHOI+ftx4d4LIAjDkRDEkik6UIH4ODQOosbGZViegNd
         qc8ekT6C4YkO4u2lJcCboJ3mtN3F651J4AbnXnB5xscd4lqVzVUHRqb1kZkIWa0eemRA
         PruYDekvDZAlPo6lVYrgz4IOHXPnev6wYKSwXt3FFyZLUAGFJmFlCiY6zQ+FQN62Nzp/
         vHN12Y5bphokL4MNrvWWJ+UmiEHF8f+feRdoHcQ1Lhf5NcESp2s8JK5q5OoY7gffSikU
         q9KzBAyOVf3/ElnVqNFuBoo5U8pQhYl9Amay6bRYGE3xVYci2+re/qdRPHXK45LenC1Z
         I2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054929; x=1721659729;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0DM0hpkMCV++G5LBwit7+udBH5/skYkvxpVfeja9jg=;
        b=Xgfgi/KdUK13lbpA+bWnvrlV7tJhJHscHB7At593Ek3VKY72jFtU7WKKgz47Xlg41E
         nITL2LksMN/lUyFbX2Bzzfef7cuJtOZm+hmHbUapQH+lsnBrsEPo/fOvjHRybghIsIY9
         K+2Y8gl5+w1NzHtb87Uo0hguaLP9Pf1WN7L8c8DlaoLLoAuHjP6ovbjW9R6F2leTfWAo
         ex3UugpjQ/rRrnWP9w9kUAenIaMpCJvFkcrcvPeUfhsBASRPhH6zHWN1PGmAXliWqHHh
         3V8oaHc2eO21mgmVFKz8dL4R8V3VoQ7v1cgZrXqDpeRjRw9zBdKUbZv2bLaud8fBlUcL
         Xx/g==
X-Forwarded-Encrypted: i=1; AJvYcCW41bNqTYMQq6SG0p5ddc/7X/roo1YnHeg3ZYK0zQw0wpAZvd39RNty8oRM2DDrOagwF3zxtUMBOoat6clhzGeGslz9ntJGVH8=
X-Gm-Message-State: AOJu0YxJtqMfFaXpzXnVyhCramvhgRtPGugXqFvHZenu+UXPc4Eh5lkq
	LLBafU/rBA3gr+3t8h8hc20NcrfrQNm5j1U9wQX+9KDJoTE3uFAUyTQu8bFFC48=
X-Google-Smtp-Source: AGHT+IFoVWRbegRhPcGqKKY9i/JCyz8MF2R2tjd6iKPoXnHXt9PN2Fu4NPWwpq4A/gkiVDY/S/o/ZA==
X-Received: by 2002:a5d:45c9:0:b0:367:99fc:238a with SMTP id ffacd0b85a97d-367cea91efbmr15602208f8f.32.1721054928493;
        Mon, 15 Jul 2024 07:48:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e709:abf9:48b3:5079? ([2a05:6e02:1041:c10:e709:abf9:48b3:5079])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427a5edb449sm89615455e9.35.2024.07.15.07.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 07:48:48 -0700 (PDT)
Message-ID: <1f808c0b-2cc4-4372-9296-07817f5b901a@linaro.org>
Date: Mon, 15 Jul 2024 16:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, theo.lebrun@bootlin.com,
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 Abel Vesa <abel.vesa@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers for v6.11-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider the following changes for the thermal drivers.

Thanks in advance

   -- Daniel

The following changes since commit 462be1c353400fa0bdd34c19897cf001ba6a5f60:

   Merge back thermal control material for 6.11. (2024-07-10 13:01:38 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.11-rc1

for you to fetch changes up to e61cc85edbbeb71e53fbf049dc9ec763bc274479:

   thermal/drivers/sti: Cleanup code related to stih416 (2024-07-15 
13:31:41 +0200)

----------------------------------------------------------------
- Group all Renesas drivers inside a dedicated sub directory and add
   the missing dependency to OF (Niklas Söderlund)

- Add suspend/resume support on k3_j72xx_bandgap and take the
   opportunity to remove a unneeded delay in the init time code path
   (Théo Lebrun)

- Fix thermal zone definition for MT8186 and MT8188 (Julien Panis)

- Convert hisilicon-thermal.txt to dt-schema (Abdulrasaq Lawani)

- Add the DT bindings for the X1E80100 temperature sensor (Abel Vesa)

- Fix the thermal zone node name regular expression in the DT schema
   (Krzysztof Kozlowski)

- Take into account some production platforms may not have calibration
   data. Deal with it with a default value instead of failing the
   initialization (Chen-Yu Tsai)

- Fix the sensor cell size on the Exynos platform (Krzysztof Kozlowski)

- Bring the common definition of '#thermal-sensor-cells' property in
   order to simplify the bindings on all the platforms where this
   change makes sense and do some minor cleanups (Krzysztof Kozlowski)

- Fix a race between removal and clock disable on the broadcom driver
   (Krzysztof Kozlowski)

- Drop 'trips' node as required from the thermal zone bindings in
   order to fix the remaining warnings appearing with thermal zone
   whithout trip points defined (Rob Herring)

- Simplify all the drivers where dev_err_probe() can apply (Krzysztof
   Kozlowski)

- Cleanup code related to stih416 as this platform is not described
   anywhere (Raphael Gallais-Pou)

----------------------------------------------------------------
Abdulrasaq Lawani (1):
       dt-bindings: thermal: convert hisilicon-thermal.txt to dt-schema

Abel Vesa (1):
       dt-bindings: thermal: qcom-tsens: Document the X1E80100 
Temperature Sensor

Chen-Yu Tsai (1):
       thermal/drivers/mediatek/lvts_thermal: Provide default 
calibration data

Julien Panis (2):
       dt-bindings: thermal: mediatek: Fix thermal zone definition for 
MT8186
       dt-bindings: thermal: mediatek: Fix thermal zone definitions for 
MT8188

Krzysztof Kozlowski (35):
       dt-bindings: thermal: correct thermal zone node name limit
       dt-bindings: thermal: samsung,exynos: specify cells
       dt-bindings: thermal: amlogic: reference thermal-sensor schema
       dt-bindings: thermal: allwinner,sun8i-a83t-ths: reference 
thermal-sensor schema
       dt-bindings: thermal: brcm,avs-ro: reference thermal-sensor schema
       dt-bindings: thermal: generic-adc: reference thermal-sensor schema
       dt-bindings: thermal: imx8mm: reference thermal-sensor schema
       dt-bindings: thermal: nvidia,tegra186-bpmp: reference 
thermal-sensor schema
       dt-bindings: thermal: nvidia,tegra30-tsensor: reference 
thermal-sensor schema
       dt-bindings: thermal: qcom-spmi-adc-tm-hc: reference 
thermal-sensor schema
       dt-bindings: thermal: qcom-spmi-adc-tm5: reference thermal-sensor 
schema
       dt-bindings: thermal: qcom-tsens: reference thermal-sensor schema
       dt-bindings: thermal: rcar-gen3: reference thermal-sensor schema
       dt-bindings: thermal: rockchip: reference thermal-sensor schema
       dt-bindings: thermal: rzg2l: reference thermal-sensor schema
       dt-bindings: thermal: socionext,uniphier: reference 
thermal-sensor schema
       dt-bindings: thermal: sprd: reference thermal-sensor schema
       dt-bindings: thermal: st,stm32: reference thermal-sensor schema
       dt-bindings: thermal: ti,am654: reference thermal-sensor schema
       dt-bindings: thermal: ti,j72xx: reference thermal-sensor schema
       dt-bindings: thermal: simplify few bindings
       dt-bindings: thermal: cleanup examples indentation
       dt-bindings: thermal: qoriq: reference thermal-sensor schema
       thermal/drivers/broadcom: Fix race between removal and clock disable
       thermal/drivers/broadcom: Simplify probe() with local dev variable
       thermal/drivers/broadcom: Simplify with dev_err_probe()
       thermal/drivers/exynos: Simplify probe() with local dev variable
       thermal/drivers/exynos: Simplify with dev_err_probe()
       thermal/drivers/hisi: Simplify with dev_err_probe()
       thermal/drivers/imx: Simplify probe() with local dev variable
       thermal/drivers/imx: Simplify with dev_err_probe()
       thermal/drivers/qcom-spmi-adc-tm5: Simplify with dev_err_probe()
       thermal/drivers/qcom-tsens: Simplify with dev_err_probe()
       thermal/drivers/generic-adc: Simplify probe() with local dev variable
       thermal/drivers/generic-adc: Simplify with dev_err_probe()

Niklas Söderlund (2):
       thermal/drivers/renesas: Group all renesas thermal drivers together
       thermal/drivers/renesas/rcar: Add dependency on OF

Raphael Gallais-Pou (1):
       thermal/drivers/sti: Cleanup code related to stih416

Rob Herring (Arm) (1):
       dt-bindings: thermal: Drop 'trips' node as required

Théo Lebrun (1):
       thermal/drivers/k3_j72xx_bandgap: Implement suspend/resume support

  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   6 +-
  .../bindings/thermal/amlogic,thermal.yaml          |  22 ++--
  .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  24 ++---
  .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |  17 ++--
  .../bindings/thermal/brcm,bcm2835-thermal.yaml     |   1 -
  .../bindings/thermal/fsl,scu-thermal.yaml          |   1 -
  .../bindings/thermal/generic-adc-thermal.yaml      |   5 +-
  .../bindings/thermal/hisilicon,tsensor.yaml        |  57 +++++++++++
  .../bindings/thermal/hisilicon-thermal.txt         |  32 ------
  .../bindings/thermal/imx8mm-thermal.yaml           |   5 +-
  .../bindings/thermal/loongson,ls2k-thermal.yaml    |   1 -
  .../bindings/thermal/mediatek,lvts-thermal.yaml    |   1 -
  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   1 -
  .../thermal/nvidia,tegra186-bpmp-thermal.yaml      |  12 +--
  .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |   9 +-
  .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |   1 -
  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   8 +-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  97 
+++++++++---------
  .../devicetree/bindings/thermal/qoriq-thermal.yaml |   5 +-
  .../bindings/thermal/rcar-gen3-thermal.yaml        |  71 ++++++-------
  .../devicetree/bindings/thermal/rcar-thermal.yaml  |  64 ++++++------
  .../bindings/thermal/rockchip-thermal.yaml         |   5 +-
  .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  43 ++++----
  .../bindings/thermal/samsung,exynos-thermal.yaml   |   3 +-
  .../thermal/socionext,uniphier-thermal.yaml        |   5 +-
  .../devicetree/bindings/thermal/sprd-thermal.yaml  |  49 ++++-----
  .../bindings/thermal/st,stm32-thermal.yaml         |   5 +-
  .../devicetree/bindings/thermal/thermal-zones.yaml |   6 +-
  .../bindings/thermal/ti,am654-thermal.yaml         |  15 +--
  .../bindings/thermal/ti,j72xx-thermal.yaml         |   5 +-
  MAINTAINERS                                        |   4 +-
  drivers/thermal/Kconfig                            |  28 +-----
  drivers/thermal/Makefile                           |   4 +-
  drivers/thermal/broadcom/bcm2835_thermal.c         |  49 +++------
  drivers/thermal/hisi_thermal.c                     |   9 +-
  drivers/thermal/imx_thermal.c                      |  42 ++++----
  drivers/thermal/k3_j72xx_bandgap.c                 | 111 
+++++++++++++++------
  drivers/thermal/mediatek/lvts_thermal.c            |  46 ++++++---
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   9 +-
  drivers/thermal/qcom/tsens.c                       |   8 +-
  drivers/thermal/renesas/Kconfig                    |  28 ++++++
  drivers/thermal/renesas/Makefile                   |   5 +
  drivers/thermal/{ => renesas}/rcar_gen3_thermal.c  |   2 +-
  drivers/thermal/{ => renesas}/rcar_thermal.c       |   2 +-
  drivers/thermal/{ => renesas}/rzg2l_thermal.c      |   2 +-
  drivers/thermal/samsung/exynos_tmu.c               |  54 +++++-----
  drivers/thermal/st/st_thermal_memmap.c             |  10 --
  drivers/thermal/thermal-generic-adc.c              |  27 +++--
  .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +--
  50 files changed, 531 insertions(+), 505 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/hisilicon,tsensor.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
  create mode 100644 drivers/thermal/renesas/Kconfig
  create mode 100644 drivers/thermal/renesas/Makefile
  rename drivers/thermal/{ => renesas}/rcar_gen3_thermal.c (99%)
  rename drivers/thermal/{ => renesas}/rcar_thermal.c (99%)
  rename drivers/thermal/{ => renesas}/rzg2l_thermal.c (99%)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

