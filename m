Return-Path: <linux-pm+bounces-31281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E3B0D8E3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC6616CC16
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65FC2E49A3;
	Tue, 22 Jul 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImHw6M2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3422E3B03
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185899; cv=none; b=VaIoO8yDMGZgP04tj6nFAsqQcw3GCQFDQqEDMT0qBp5Q5pgWfqtiGdEwNfyiYoFlIJ2Ics1Yd00tT5KPsO7gsW7HB+UZhb+hyB/Ns4AC7/+g/9Hi5QriUR42F0ZkOlTgGWBbPbeWqI+S3MQeeZKdmlDO0klMIcPz6hkCmHrFxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185899; c=relaxed/simple;
	bh=nbyIpft8djPZrtb8ThK8M3ReonlR2H0hGR8xu4IjR1w=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Fe9wsHqqQqqFQPji/bshCEQCa5IPauYKLyMMXKRk9RASDx9OllsNH+b+9Z1IgBDCt/sCMhK2GsV8TKKMPkIv8fMsu8bohdAdm5wx7NiGsKU2ZQL7yMIQmTlldUbyw2DD71eSj/hUNoxEv9EyLXXK0oLBVvTtxCnJz956c4mS3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImHw6M2L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4561607166aso41935855e9.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753185895; x=1753790695; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpi/p9fCXy5/a0jR7mIeMlMhneDcTDMyjTiv0Pm3Vxc=;
        b=ImHw6M2LB/KreMWIz7c2wwUhGkOnviyJTKkdyTtYjuAi2jT1LMpuisZ/xjNMX7hXab
         lbPOYzW+L6k5OKtULn6pqSQflBAAZTFyr7U8rU15VEX60tbRvInpA6OZ/bf0g33eTaHE
         dTlyQRA3VslwTqqdmaufKsz2CEwKXYAg5sY7FZmFtKH0Bl7we67KqyRcHsXdikWnZdD/
         wXfgSpiMXXJlQrD0jF50Kb59RD1c5np3otq2q059NjKjpi9Om/4WiCaWsxUNA/BydUBp
         SgYFQOk7usQZz3ObuFq+T9bSuJCOiCV18qdk972oveyBS+FbM71WtK55SOGUKRXbDi4U
         fEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185895; x=1753790695;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wpi/p9fCXy5/a0jR7mIeMlMhneDcTDMyjTiv0Pm3Vxc=;
        b=UK7HWz8UKB2WVr5+2qHl9EgC9LTgX7XZLgY0gbmYwDQkRJVwbrUJnLrVo780n8r+Tp
         6LNcs1ENo2EztHQ6ZaFCxwoLUiBMyK1xTxZnVPkamSxkmopvQwUV0boM6OnN/ecv0bO5
         gafipqJhdLA6aVzY0+hupSe9z/ogAaDeZ8Ohw4SvbeNSTJIAs4LMludGjZ2DsRpa9ujJ
         BGgcmUSvmxnUYq4GN5fOTJtix3Brcv6RmoBgt+CbLY1Q87+5cc6XweeMBA95hJx46+ck
         Kk009G9Jy6x8WrXjOheTS4PSaiJhs386nSqnMxVAe/SVBhdUEutbi2TQtPDFwH1+dBSY
         6rFg==
X-Forwarded-Encrypted: i=1; AJvYcCUNy3AMGbNNQg3Oy4lXoNmp8p7bYHkv0aauGCDxveXLZ+Te10Yl/43U+dTB0S1WHgUm2h6zMoOcRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwG0f39pmUkhkbObOJVvb/t0NS8aSsDONmHw7JYiauAyX7Tmpo
	7zftT7c8COvNzX3D+seBQvGUPFNYuRQgJ53jFvcZacbKlGUnVgXFxafjkqaXHLCaF5A=
X-Gm-Gg: ASbGncutlDcIA5jm9fP2c8+YLFMzvT079Dk4l7XagyjKqoM2MLJqvB24CrG96r73yJA
	mwXee5qJRGHdiBq5bYYYEir9tMSWdYI6bcuqF002B6isRCc4+mv+vSGMKVULqFa7klk5LY1ZwL8
	Dk0M7vnL/LKnOB5t6gcCzy3iPfElPSzCz/tSjsuliy0FWb83nNIrtzLnb+5OwASJzowoCpEMHrI
	2UPfLjh8Htc/ektmnxgMdDwAj0T4oF9bJtomNbYzvkETlovenwuiRYooaGxbiGfE8++Af8hs6nA
	9U9j5xGF6QDIwu3oBo+GYWSYae6b9IG/eNGmBcXvY32oh3yVaaSsod+Bdx56fBE5T5/ivSxyOdE
	1SuF8pK5ZMVXbbb+7ELpl7cKDZFrFGMLmg1QSwtsxaLUpGV6d2eQNL+NszqM=
X-Google-Smtp-Source: AGHT+IHKGGQiBGHC/lZvh9QmUqgGiyupYCkQAkEaoPTX8mU+rea8xDmE81eZvOU0q9A8pejyeiN5dQ==
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr142762415e9.33.1753185895103;
        Tue, 22 Jul 2025 05:04:55 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9e2sm13523548f8f.89.2025.07.22.05.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:04:54 -0700 (PDT)
Message-ID: <f8829843-111e-460f-9081-ee46c1f96ebc@linaro.org>
Date: Tue, 22 Jul 2025 14:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Mason Chang <mason-cw.chang@mediatek.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 David Collins <david.collins@oss.qualcomm.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Aaron Kling <webgeek1234@gmail.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thermal drivers for v6.17
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider the following changes since commit 
d7b8f8e20813f0179d8ef519541a3527e7661d3a:

   Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.17-rc1

for you to fetch changes up to 1d264d3a198839c7483580acdce17e1015d0ef91:

   dt-bindings: thermal: tegra: Document Tegra210B01 (2025-07-21 
22:23:39 +0200)

----------------------------------------------------------------
- Enable the stage 2 shutdown and support to more SPMI variants
   (Anjelique Melendez)

- Constify thermal_zone_device_ops structure when possible in the
   different thermal drivers (Christophe Jaillet)

- Use the dev_fwnode() helper instead of of_fwnode_handle() which is
   more adequate wherever is possible in the thermal drivers (Jiri
   Slaby)

- Implement and document One-Time Programmable fuse support for the
   Rockchip driver in order to increase the precision of the
   measurements (Nicolas Frattaroli)

- Change the way the Mediatek LTVS driver stores the initialization
   data sequence to support different sequences regarding the current
   platform. Introduce the mt7988 support with a new initialization
   sequence (Mason Chang)

- Document the QCom TSens Milos Temperature Sensor DT bindings (Luca
   Weiss)

- Add the fallback compatible string for MT7981 and MT8516 DT bindings
   (Aleksander Jan Bajkowski)

- Add the compatible string for Tegra210B01 SOC_THERM driver (Aaron Kling)

----------------------------------------------------------------
Aaron Kling (1):
       dt-bindings: thermal: tegra: Document Tegra210B01

Aleksander Jan Bajkowski (1):
       dt-bindings: thermal: mediatek: Add fallback compatible string 
for MT7981 and MT8516

Anjelique Melendez (4):
       thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct 
based on HW subtype
       thermal/drivers/qcom-spmi-temp-alarm: Prepare to support 
additional Temp Alarm subtypes
       thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 2 
PMIC peripherals
       thermal/drivers/qcom-spmi-temp-alarm: Add support for LITE PMIC 
peripherals

Christophe JAILLET (2):
       thermal/drivers/loongson2: Constify struct thermal_zone_device_ops
       thermal: Constify struct thermal_zone_device_ops

David Collins (1):
       thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown 
when required

Jiri Slaby (SUSE) (1):
       thermal: Use dev_fwnode()

Luca Weiss (1):
       dt-bindings: thermal: qcom-tsens: document the Milos Temperature 
Sensor

Mason Chang (3):
       thermal/drivers/mediatek/lvts_thermal: Change lvts commands array 
to static const
       thermal/drivers/mediatek/lvts_thermal: Add lvts commands and 
their sizes to driver data
       thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

Nicolas Frattaroli (4):
       thermal/drivers/rockchip: Rename rk_tsadcv3_tshut_mode
       dt-bindings: rockchip-thermal: Add RK3576 compatible
       dt-bindings: thermal: rockchip: document otp thermal trim
       thermal/drivers/rockchip: Support reading trim values from OTP

Ye Zhang (1):
       thermal/drivers/rockchip: Support RK3576 SoC in the thermal driver

  .../bindings/thermal/mediatek,thermal.yaml         |  27 +-
  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../bindings/thermal/rockchip-thermal.yaml         |  62 +++
  drivers/thermal/armada_thermal.c                   |   2 +-
  drivers/thermal/da9062-thermal.c                   |   2 +-
  drivers/thermal/dove_thermal.c                     |   2 +-
  drivers/thermal/imx_thermal.c                      |   2 +-
  .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
  drivers/thermal/kirkwood_thermal.c                 |   2 +-
  drivers/thermal/loongson2_thermal.c                |  15 +-
  drivers/thermal/mediatek/lvts_thermal.c            |  76 ++-
  drivers/thermal/qcom/lmh.c                         |   3 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 596 
++++++++++++++++++---
  drivers/thermal/renesas/rcar_thermal.c             |   2 +-
  drivers/thermal/rockchip_thermal.c                 | 251 ++++++++-
  drivers/thermal/spear_thermal.c                    |   2 +-
  drivers/thermal/st/st_thermal.c                    |   2 +-
  drivers/thermal/tegra/soctherm.c                   |  13 +-
  drivers/thermal/testing/zone.c                     |   2 +-
  20 files changed, 921 insertions(+), 145 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


