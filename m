Return-Path: <linux-pm+bounces-13787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1196F2FE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5631C21C70
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B9E1C9EC2;
	Fri,  6 Sep 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HV3/bb3D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267A1C9EAB
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621894; cv=none; b=JiFmhHZvMJ2JElOoJlWQEZydzE1g18wb+m+tvW1y/cy//tqGdvY8BdaEnkKoQtAcfqyTzLLXcv7+J3LVtYoqWsF8oT4OgUYLwE4j8mL6xQxAm0AwmhiS8/tm6bT1QcAfrXERaLbjrgGusf3xIII/7uwWfKwK1csAlRbLi/6g98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621894; c=relaxed/simple;
	bh=ZQH92TpQyFl4gv+OD7v5l1D5rCQFmhiRf28AHtFoQXk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=grleihCFTYS9FyoG8SCYuJZ1/gpGT7NEQv5ZrpvRcxB3rFz0fJOQN4yCnYEOI9RZzijq+z5tkQwIKdnglI9WegxQa9wjx79Djapku1D5goRkb968i3VVwEP7DB0IYgukq7eQ5MWY7AK4Yg8yp5tmLh1mynNkk4bAzq/X6SgnCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HV3/bb3D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ca573fd5aso2763545e9.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725621888; x=1726226688; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYynHc0UzBO2p8b5rM/GQnlMJh3kzhjnj092w1bNgx0=;
        b=HV3/bb3Df5R7rBGgkoSTfxtS+z444QLp6XzmD+VCMiv/OCKBTncLPojSO6HwvAFgTg
         Nh9QFvj7Yb8JBrYu+DUFeKnZiSg6h40lYL96kfWWF3LXIC5wdgOBq1p9VKmhZUw0lGqK
         VrIH1r5u/J86SKW/SL3PPEDNihWFDOHGWtQTu/Ak3bmvYxIUXlw+ldmrmmNVZ2pzshpB
         mWOii25nOZv+Q8RW4EcWAr2zBrx1jOGLcAAEb05QLl6Oue8/6ByK5fCemvApjlfcQ+ch
         C3XhFXnpRiJX5u5s9SREIRac7n/y6vCApAAwh8sg938FizHQsx8pH1WLymbfOyjlyYGQ
         vSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621888; x=1726226688;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MYynHc0UzBO2p8b5rM/GQnlMJh3kzhjnj092w1bNgx0=;
        b=ePzX/ZpQgA3Jm817UXzjR2tQYlSH8eRmpItfGElKNoInI4PnzEFoKjFgWdDD0lrqAe
         N6O7ACPsUfWpq2HFGVGUE3TGJfAtUw960RZN49rFwH/ITfu5dgTq4TxZ/HpArV9S7MEj
         xNPeFcd6TI+o5iqXMErX+Eyivm89vgskpbc+c2XhzQqfnjT9+yf6GLSWnHtWIDSDC8UR
         qoa7+6jwCAXx3eaomU0A/WGPHnPYWG7LmZLGdy5T6Z77A/JGKhjVgiufNapxCS9tR7sq
         5/gz30JtJfKZ9JL3EjeiefTyriYLaQgHDTVn/u0nIIJHdM3FiShzMfQMtcWvNw5GWTsx
         +W6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXodXM/Z33IydYxUg8uLUnKE0MyqMYqg//DpJP1viNAqBPDGq3mMeR4mJMIgYijoI6ZSsC4qAwxYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQ8sXmehEflrfbnJtpS4VRYpYhgKbG2BLX1eqPg/aqWapnp1s
	nQR3+j5HTMyCKh+x4EhEFOlsjD/I93NxeYliFQqisSV9MfTlF5l85mQBesYs+y0=
X-Google-Smtp-Source: AGHT+IE14b7rOn+qEeyShlsYLKxm7ePNnNmthwLTsPtIn7xL+yauvm0pLZ7yQGBxisbgHVdoce4pAQ==
X-Received: by 2002:a05:600c:5125:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-42c9f98467emr16257125e9.14.1725621887156;
        Fri, 06 Sep 2024 04:24:47 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ca05cfa42sm17376815e9.25.2024.09.06.04.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 04:24:46 -0700 (PDT)
Message-ID: <3a7fa69f-9cee-48f0-a932-7362f600b6a6@linaro.org>
Date: Fri, 6 Sep 2024 13:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 George Stark <gnstark@salutedevices.com>, Yan Zhen <yanzhen@vivo.com>,
 Fabio Estevam <festevam@denx.de>, Zhang Zekun <zhangzekun11@huawei.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Lukasz Luba <Lukasz.Luba@arm.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers changes for v6.12-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider pulling the following changes. This cycle has been quite 
quiescent and the changes are mostly related to code cleanups and DT 
bindings.

Thanks


The following changes since commit f5c05974349c8e3d80e125b71bd80695807d8528:

   Merge branch 'thermal-core' (2024-08-29 11:45:08 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.12-rc1

for you to fetch changes up to 7d8abc5f3b5ce0f53d499279d8defc0f72bf7557:

   thermal/drivers/imx_sc_thermal: Use dev_err_probe (2024-09-04 
15:31:29 +0200)

----------------------------------------------------------------
- Add power domain DT bindings for new Amlogic SoCs (Georges Stark)

- Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() in the ST
   driver and add a Kconfig dependency on THERMAL_OF subsystem for the
   STi driver (Raphael Gallais-Pou)

- Simplify with dev_err_probe() the error code path in the probe
   functions for the brcmstb driver (Yan Zhen)

- Remove trailing space after \n newline in the Renesas driver (Colin
   Ian King)

- Add DT binding compatible string for the SA8255p with the tsens
   driver (Nikunj Kela)

- Use the devm_clk_get_enabled() helpers to simplify the init routine
   in the sprd driver (Huan Yang)

- Remove __maybe_unused notations for the functions by using the new
   RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() macros on the IMx and
   Qoriq drivers (Fabio Estevam)

- Remove unused declarations in the header file as the functions were
   removed in a previous change on the ti-soc-thermal driver (Zhang
   Zekun)

- Simplify with dev_err_probe()	the error code path in the probe
   functions for the imx_sc_thermal driver (Alexander Stein)

----------------------------------------------------------------
Alexander Stein (1):
       thermal/drivers/imx_sc_thermal: Use dev_err_probe

Colin Ian King (1):
       thermal/drivers/renesas: Remove trailing space after \n newline

Fabio Estevam (2):
       thermal/drivers/qoriq: Remove __maybe_unused notations
       thermal/drivers/imx: Remove __maybe_unused notations

George Stark (1):
       dt-bindings: thermal: amlogic,thermal: add optional power-domains

Huan Yang (1):
       thermal/drivers/sprd: Use devm_clk_get_enabled() helpers

Nikunj Kela (1):
       dt-bindings: thermal: tsens: document support on SA8255p

Raphael Gallais-Pou (2):
       thermal/drivers/st: Switch from CONFIG_PM_SLEEP guards to 
pm_sleep_ptr()
       thermal/drivers/sti: Depend on THERMAL_OF subsystem

Yan Zhen (1):
       thermal/drivers/brcmstb_thermal: Simplify with dev_err_probe()

Zhang Zekun (1):
       thermal/drivers/ti-soc-thermal: Remove unused declarations

  .../bindings/thermal/amlogic,thermal.yaml          |  3 ++
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  1 +
  drivers/thermal/Kconfig                            |  2 +-
  drivers/thermal/broadcom/brcmstb_thermal.c         | 15 ++++------
  drivers/thermal/imx_sc_thermal.c                   |  3 +-
  drivers/thermal/imx_thermal.c                      | 16 +++++------
  drivers/thermal/qoriq_thermal.c                    | 10 +++----
  drivers/thermal/renesas/rcar_thermal.c             |  2 +-
  drivers/thermal/sprd_thermal.c                     | 14 ++--------
  drivers/thermal/st/st_thermal.c                    | 32 
++++++++--------------
  drivers/thermal/st/st_thermal_memmap.c             |  2 +-
  drivers/thermal/st/stm_thermal.c                   |  8 ++----
  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 ---
  13 files changed, 45 insertions(+), 67 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


