Return-Path: <linux-pm+bounces-35471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8DBA4380
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5877BE4F3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3021D3F0;
	Fri, 26 Sep 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIydO7Am"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B21A444
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896993; cv=none; b=tRkH/1UvRR5ZhMdNlrMiTO3a/H0xMNxpVaSC6yAeAbgMc2uPGH7i/lXxlwJYj2IAG5uKTuHmz5KK4xVHB8fUokYdIHnLYnchxE2MO7wGjauhBnVMCfCExQvX4REHW4xSN79PYN5ijzBi62EKwBKgzxhVbUxHkOflQI0XzdxXxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896993; c=relaxed/simple;
	bh=CUu/3WJEonDkBBLP/tEinwlx7X34nDQKtAmkACOqCBg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=krbrSj66o7z3eRzFDeRcJPd/rXGVZ3m6LzjUoNqktAnoq9O0tFNxacpKsx4S0HbDg2+cKvqYen3QCUxg3kjwSnrv9X/nSIphpZYDfLPr7bXl8DaTiPygE6HCia+/NVqb2Uknv1JahcewaCRH5czSFcHx3vFD+mGJN9lBwKNCBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIydO7Am; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso1861832f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758896989; x=1759501789; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO9AJOP56fvfvlt3zhBLeKODfApKPr5H8iD1XyFk8hE=;
        b=pIydO7Am46MeYJCRLoLV5VIPvQKow1riEYSd0AjGkRCkAvFklMTNpb+7veNmS57hK3
         L8ngq8GlRUZbZOi1vyoeEwSxriZGHcWpAfYPnKsBTBqBZDfz8dlbgmndR0xWbUEDOInb
         qjx/umv3pCPSIXiT3sEO/x/UVSZ2f0ykSgCZu6p/mrcMsLHkMN01eiw1Snhko4KZRPOK
         csDy8zkHYLDjm3HyEXG97LRlgsozRFC8JAAOtXNmW5hWNu97kqWSV2VxZg8umuyzQxI4
         JfWkTFrc4x6BNtyy5UuxARgAoT7ATcUcDGrEumYkORZ5D/Oc+s5JlGBjJekXZgQzkmgU
         fq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896989; x=1759501789;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jO9AJOP56fvfvlt3zhBLeKODfApKPr5H8iD1XyFk8hE=;
        b=HoyzWqITAzzONSOcmc9ytP8XA0Hzj/zc6A88wEPM5lniqjuG0FFhHeharwep3OXaIv
         zk0y8I9WfGu5rfh5YsujE+AX3o+BBMQ+gszgZBjQmxehptxMhHZjh3InsMqg9dG7JBuH
         PklbFw0Xe5FBu7vulKiUPhxgEKg6eRJJ/C3EdMKZuqPjiBkE5X92YHAiuelnZfcg9p72
         Ae9DG5gIR+zX60yOFFokQc9++//y9n9ZCkmG1xSylPfojodFuEXZkoVawgiqTgmRTLny
         jgze0g/o6l6X5pjYcJNrPt+oGWEsPyCqyAVajwtPiJ2iO/BFQEhjAGjXh2YskH1s2OFj
         Rxiw==
X-Gm-Message-State: AOJu0YyqwhZzqDTvgHJcdBHikMDdGw5XMbM+in2+mgYVzJPJMm921IPJ
	xQa11amuMINZskiWCTkEeTR9/iXeXYDqOxWok04JONSmrD3cSiNE879nCFbnLcnrwjm8XSBbc+e
	o+um5
X-Gm-Gg: ASbGnctd0tuMalsGowVL/3z0nN63sUj3BcLs+Uc+DpjG8/VL23wrYP+Wb/+tPrVcAFX
	+weUzCdL/vqFOWbPJyUxFW5tu2t7E8BOTPUnLx/nuwO+jyjW4gNLcIgG+R+plksS9+TboH1ps1x
	ynHtxHObzRr2rh7WbBFJLgOImRb+lYHNyThSVZDqOnJCeUP8g1NXj2jNK7/CgGBBgbP4r+TF05N
	t1mWuKWhQZeanN+22wb99odICaofkQl3jtQUDQ0JDkFbil9TL6PC65Tp8a4mhVgvxExe8rkpqCt
	rn0L2ueawr4YGuslHYmOZP3LhFjWDXDb4x5FbvqlrnK1GfFDI21tIY+z813/sx66TLvrRneMl8x
	gZsFzS7X0eJJnGpGMj2jF+epsKPZiwB6+hACIe5NNqtUtOldqyaR0T+xo8rTgJKYQspVzy6uBm4
	gDFn31tEiAeEnO
X-Google-Smtp-Source: AGHT+IG6f7oSRj+qTmZ8hn0pIcEK+5qow20D5m7BI/IT0oCB3TFSjKdzLEQBnjUhwZ4f5aVdP0ljHg==
X-Received: by 2002:a05:6000:1447:b0:3e8:e52:31c5 with SMTP id ffacd0b85a97d-40e468e626emr7064510f8f.2.1758896989512;
        Fri, 26 Sep 2025 07:29:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb89fb19fsm7419825f8f.21.2025.09.26.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:29:48 -0700 (PDT)
Message-ID: <4868ed10-af6d-455d-b5cb-f301c1e81de1@linaro.org>
Date: Fri, 26 Sep 2025 16:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Gaurav Kohli <quic_gkohli@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumeet Pawnikar <sumeet4linux@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Walle <mwalle@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal driver for v6.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

please consider the following changes since commit 
8f5ae30d69d7543eee0d70083daf4de8fe15d585:

   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.18-rc1

for you to fetch changes up to 79428e60897916401c9ed326f6ada4d7c7c997a3:

   dt-bindings: thermal: qcom-tsens: Document the Glymur temperature 
Sensor (2025-09-26 13:27:44 +0200)

----------------------------------------------------------------
- Add the QCS615 compatible DT bindings for QCom platforms (Gaurav
   Kohli)

- Support fallback trimming values when the fuse is empty in the R-Car
   driver (Marek Vasut)

- Remove unneeded semicolon in the Mediatek LVTS driver (Jiapeng
   Chong)

- Fix the LMH Kconfig option by selecting QCOM_SCM and take the
   opportunity to add the COMPILE_TEST option for the QCom's LMH
   feature (Dmitry Baryshkov)

- Fix the missing includes and incorrect error message in the Qcom's
   LMH driver (Dmitry Baryshkov)

- Fix comment typo and add the documentation in the Kconfig for the
   R-Car Gen3 and Gen4 (Marek Vasut)

- Add Tegra114 SOCTHERM support (Svyatoslav Ryhel)

- Rename the functions name in the driver to be consistent and generic
   with the different R-Car platform variants (Wolfram Sang)

- Register the TI K3 J72xx bandgap sensor as a hwmon sensor too
   (Michael Walle)

- Add and document the thermal sensor unit reporting the junction
   temperature of the RZ/G3S SoC (Claudiu Beznea)

- Support the GRF in the Rockchip driver (Sebastian Reichel)

- Add a temperature IIO sensor channel in the generic thermal ADC
   driver (Svyatoslav Ryhel)

- Document the temperature sensor on the QCOM's Glymur platform (Manaf
   Meethalavalappu)

- Add and document the thermal sensor unit reporting the junction
   temperature of the RZ/G3E SoC (John Madieu)

----------------------------------------------------------------
Claudiu Beznea (2):
       dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
       thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas 
RZ/G3S SoC

Dmitry Baryshkov (2):
       thermal/drivers/qcom: Make LMH select QCOM_SCM
       thermal/drivers/qcom/lmh: Add missing IRQ includes

Gaurav Kohli (1):
       dt-bindings: thermal: tsens: Add QCS615 compatible

Jiapeng Chong (1):
       thermal/drivers/mediatek/lvts_thermal: Remove unneeded semicolon

John Madieu (2):
       dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
       thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas 
RZ/G3E SoC

Manaf Meethalavalappu Pallikunhi (1):
       dt-bindings: thermal: qcom-tsens: Document the Glymur temperature 
Sensor

Marek Vasut (4):
       thermal/drivers/rcar_gen3: Add support for per-SoC default trim 
values
       thermal/drivers/rcar_gen3: Add support for R-Car V4H default trim 
values
       thermal/drivers/rcar_gen3: Fix comment typo
       thermal/drivers/rcar_gen3: Document Gen4 support in Kconfig entry

Michael Walle (1):
       thermal/drivers/k3_j72xx_bandgap: Register sensors with hwmon

Sebastian Reichel (3):
       thermal/drivers/rockchip: Unify struct rockchip_tsadc_chip format
       thermal/drivers/rockchip: Shut up GRF warning
       dt-bindings: thermal: rockchip: Tighten grf requirements

Sumeet Pawnikar (1):
       drivers/thermal/qcom/lmh: Fix incorrect error message

Svyatoslav Ryhel (5):
       dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal 
Management System
       thermal/drivers/tegra/soctherm-fuse: Prepare calibration for 
Tegra114 support
       dt-bindings: thermal: add Tegra114 soctherm header
       thermal/drivers/tegra: Add Tegra114 specific SOCTHERM driver
       thermal/drivers/thermal-generic-adc: Add temperature sensor channel

Wolfram Sang (1):
       thermal/drivers/rcar_gen3: Fix mapping SoCs to generic Gen4 entry

  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
  .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |  93 +++++++
  .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  87 +++++++
  .../bindings/thermal/rockchip-thermal.yaml         |  15 ++
  MAINTAINERS                                        |  14 ++
  drivers/thermal/k3_j72xx_bandgap.c                 |   4 +
  drivers/thermal/mediatek/lvts_thermal.c            |   2 +-
  drivers/thermal/qcom/Kconfig                       |   3 +-
  drivers/thermal/qcom/lmh.c                         |   4 +-
  drivers/thermal/renesas/Kconfig                    |  21 +-
  drivers/thermal/renesas/Makefile                   |   3 +
  drivers/thermal/renesas/rcar_gen3_thermal.c        |  63 +++--
  drivers/thermal/renesas/rzg3s_thermal.c            | 272 
+++++++++++++++++++++
  drivers/thermal/rockchip_thermal.c                 |  50 ++--
  drivers/thermal/tegra/Makefile                     |   1 +
  drivers/thermal/tegra/soctherm-fuse.c              |  18 +-
  drivers/thermal/tegra/soctherm.c                   |  13 +
  drivers/thermal/tegra/soctherm.h                   |  11 +-
  drivers/thermal/tegra/tegra114-soctherm.c          | 209 ++++++++++++++++
  drivers/thermal/tegra/tegra124-soctherm.c          |   4 +
  drivers/thermal/tegra/tegra132-soctherm.c          |   4 +
  drivers/thermal/tegra/tegra210-soctherm.c          |   4 +
  drivers/thermal/thermal-generic-adc.c              |  55 ++++-
  include/dt-bindings/thermal/tegra114-soctherm.h    |  19 ++
  25 files changed, 911 insertions(+), 62 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
  create mode 100644 
Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
  create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c
  create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


