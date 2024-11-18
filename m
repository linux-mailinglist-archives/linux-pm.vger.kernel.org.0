Return-Path: <linux-pm+bounces-17711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F89D0F4A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5DA28151B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE54194C8D;
	Mon, 18 Nov 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lqyd2Vvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ACA143C69
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928299; cv=none; b=aW81E5A3uODbaP31clNy7J4AbwhqzF5tVuRuBUqlrAzY6wh05g07MdxUZqIcGp1Km2+GwuuSyFuQfDLcGkmJW4vZ3olxcfAcBDYDS86YvUtqlPL+Le25npmtQdDItblSmTcJfza1J62TkMaRxFElXqBND+q4FIJWkvMpfoA2F74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928299; c=relaxed/simple;
	bh=UE7HM8qIw6m5M7kf0fE1t9IbYSyWnI3F510f3fD7WTI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OitZA1wLfFS07wmW6wOOwoiP5wlLRyDdGccud9BXZpLjOSUJ5HSlHo2iQ8LuK4x3ow7bZ2cEMV/HJv50bOidQn/Bc+C6vIjfwSlv6XcTBFjob+nOiN5Mg+jbP8ebNCVNvGQRgocqc60ZeuMvJx1yRHE6PK/iRGOW58hCW8gOgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lqyd2Vvo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so24007835e9.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 03:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731928295; x=1732533095; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb1ggr4en4o2/qwiv+JpxUX3YYBI7nDJJo3cF/GVKKA=;
        b=Lqyd2VvoypjEfzC7VS7WtQYj06miOwKA2/eu4DYwFd59W3W3l5w16EtIMNZ82Tvf5a
         ac4eMTdl2w6Gz/GN2RBlI+cQ7kIOV+zYdbQ40ttJXnnh5E3uH+CsHhk8CEIDQoSbR3+p
         12nzlHkiZFU8rN7OJalF3z4ZUwV3HL2fC68oCgxK75U1m6IVXdObYrrGxpJ1WEBSD71t
         qtQvpEqVAR4FhHxO/3SJgrceae8FStn7sqhk2mtiXF5xB4cNrTVGQTFr8rRottPTwydd
         PQABy8RoocW+sCrAngFdwt/FFK2sc0/o+s3Ey+FB2bwd/xPVVmbYvKs9iIQwvEsIUo3A
         KvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928295; x=1732533095;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wb1ggr4en4o2/qwiv+JpxUX3YYBI7nDJJo3cF/GVKKA=;
        b=Pp6w4+rTusU8C18jWta3hXg/54jxBIFRQOIOoCWINGNdmel3wKAiLa1dwooOvyxehl
         QjezKelsHfVX+x2cqP5kQ1BrDx8WJsKsPs/InHlEYCqi/Hl4fcJjkGEbhVzriI/zgqoI
         uR8ckKxQC8pe0KK7eauNjTSGcyNyRCBTAKaSXvVnZpmWefPU0fh7cOiFYUkyasyFV2jo
         n7gdZejVugU7Z4BoCRIo2CwCOXyX1HMM9ZYHdgMsCUMztEryLkcKkmyF+8HGHW8yG5Qj
         2Nmq67nh3EpLjlNcnqJxYGzwojVhGa4O0u9hqnEplKBfa1v3J9BkpNzYDdtY5AjHYJqO
         6kcw==
X-Forwarded-Encrypted: i=1; AJvYcCXEcQm1RjyiW2B93zJuEp6ML6yZJgciPeOfrGCLoeBOJTlqqaliwWHmQufzB20XlghcmJ/LcE/RFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pJhWqG7verVk26WxOT925TMEPHrBNwaoPwaHupFM+EnELvsg
	2XP93SwQH/6slwtPxYERGgGGwFF4ClR6N08M0cf7dee4GLNqdmC5zwPezEg5o54=
X-Google-Smtp-Source: AGHT+IG1Xz2IhZe7QHWMg6pxCixum8asKHby6Xpi95TCslF4vCE1Y0sqRtObq96ny+tDG1a1hJ3GxA==
X-Received: by 2002:a05:600c:4eca:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-432df71e782mr113443855e9.3.1731928295580;
        Mon, 18 Nov 2024 03:11:35 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432da24459bsm158707025e9.6.2024.11.18.03.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:11:34 -0800 (PST)
Message-ID: <2e8771be-3a0d-43d4-8787-41bc69d5287d@linaro.org>
Date: Mon, 18 Nov 2024 12:11:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 zhangjiao2 <zhangjiao2@cmss.chinamobile.com>,
 Rex Nie <rex.nie@jaguarmicro.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers for v6.13-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

please consider the following changes since commit 
c285b11e289dbe8973735ab8dc84210bde417673:

   Merge back thermal control material for 6.13 (2024-11-11 15:20:44 +0100)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.13-rc1

for you to fetch changes up to d303e3dd8d4648f2a1bb19944d4fb1c4a5030354:

   tools/thermal: Fix common realloc mistake (2024-11-15 14:29:03 +0100)

----------------------------------------------------------------
- Add the SAR2130P compatible in the DT bindings for the QCom Tsens
   driver (Dmitry Baryshkov)

- Add the static annotation to the arrays describing the platform
   sensors on the LVTS Mediatek driver (Colin Ian King)

- Switch back to the struct platform_driver::remove() from the
   previous callbacks prototype rework (Uwe Kleine-König)

- Add the MSM8937 compatible in the DT bindings and its support in the
   QCom Tsens driver (Barnabás Czémán)

- Remove a pointless sign test on an unsigned value in
   k3_bgp_read_temp() function on the k3_j72xx_bandgap driver (Rex Nie)

- Fix a pointer reference lost when the call to realloc() fails in the
   thermal library (Zhang Jiao)

----------------------------------------------------------------
Barnabás Czémán (2):
       dt-bindings: thermal: tsens: Add MSM8937
       thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens

Colin Ian King (1):
       thermal/drivers/mediatek/lvts_thermal: Make read-only arrays 
static const

Dmitry Baryshkov (1):
       dt-bindings: thermal: qcom-tsens: Add SAR2130P compatible

Rex Nie (1):
       thermal/drivers/k3_j72xx_bandgap: Simplify code in k3_bgp_read_temp()

Uwe Kleine-König (1):
       thermal: Switch back to struct platform_driver::remove()

zhang jiao (1):
       tools/thermal: Fix common realloc mistake

  .../devicetree/bindings/thermal/qcom-tsens.yaml     |  2 ++
  drivers/thermal/amlogic_thermal.c                   |  2 +-
  drivers/thermal/armada_thermal.c                    |  2 +-
  drivers/thermal/broadcom/bcm2835_thermal.c          |  2 +-
  drivers/thermal/broadcom/ns-thermal.c               |  2 +-
  drivers/thermal/da9062-thermal.c                    |  6 +++---
  drivers/thermal/dove_thermal.c                      |  2 +-
  drivers/thermal/hisi_thermal.c                      |  4 ++--
  drivers/thermal/imx8mm_thermal.c                    |  2 +-
  drivers/thermal/imx_thermal.c                       |  2 +-
  .../thermal/intel/int340x_thermal/int3400_thermal.c |  2 +-
  .../thermal/intel/int340x_thermal/int3401_thermal.c |  2 +-
  .../thermal/intel/int340x_thermal/int3402_thermal.c |  2 +-
  .../thermal/intel/int340x_thermal/int3403_thermal.c |  2 +-
  .../thermal/intel/int340x_thermal/int3406_thermal.c |  2 +-
  drivers/thermal/k3_bandgap.c                        |  2 +-
  drivers/thermal/k3_j72xx_bandgap.c                  |  4 ++--
  drivers/thermal/kirkwood_thermal.c                  |  2 +-
  drivers/thermal/mediatek/lvts_thermal.c             |  6 +++---
  drivers/thermal/qcom/tsens-v1.c                     | 21 
++++++++++++++-------
  drivers/thermal/qcom/tsens.c                        |  5 ++++-
  drivers/thermal/qcom/tsens.h                        |  2 +-
  drivers/thermal/renesas/rcar_gen3_thermal.c         |  2 +-
  drivers/thermal/renesas/rcar_thermal.c              |  2 +-
  drivers/thermal/renesas/rzg2l_thermal.c             |  2 +-
  drivers/thermal/rockchip_thermal.c                  |  2 +-
  drivers/thermal/samsung/exynos_tmu.c                |  2 +-
  drivers/thermal/spear_thermal.c                     |  2 +-
  drivers/thermal/sprd_thermal.c                      |  2 +-
  drivers/thermal/st/st_thermal_memmap.c              |  2 +-
  drivers/thermal/st/stm_thermal.c                    |  2 +-
  drivers/thermal/tegra/soctherm.c                    |  2 +-
  drivers/thermal/tegra/tegra-bpmp-thermal.c          |  2 +-
  drivers/thermal/ti-soc-thermal/ti-bandgap.c         |  2 +-
  drivers/thermal/uniphier_thermal.c                  |  2 +-
  tools/thermal/thermometer/thermometer.c             |  7 ++++---
  36 files changed, 62 insertions(+), 49 deletions(-)


