Return-Path: <linux-pm+bounces-28198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E014FAD0123
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 13:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F53AD937
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0628850C;
	Fri,  6 Jun 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZFUs0uXl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07A28750F
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208684; cv=none; b=fAPPqr3FVv4dHrvIJOAyi6MMFQvKnYtEvK14i1qS/dLVP+XAWUDXtYXyubhVi9so1T/V8CSFGL4w0rIqrks/TgoQQpLIpLJSs0YU0PIMqfIZmNUZLCC8F2EqjojnfCMFOFo/ZgCi1UWFIv5jpqCfdfpLhuDkD7a/5zv87OohuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208684; c=relaxed/simple;
	bh=uRPwSngvxa5YmiEZyOy6L4x+QQSwB1jVFtkOLYxQM9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4pT5+edcxqVG9o5YthKPCB4UJqEviWb5ZCMw7FRwkO5PxN+EnOhEEd1PBye6gtSLhmeghMIEPDWWQHG/JEXURN8CspIjlnLGZh9o7HGDSnOR27+y+oMj2vCGpBmA7cg6Teafv1If+JmROj4WWh9E7IhWonTTc5ANUxBhb4xEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZFUs0uXl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-addfe17ec0bso525841566b.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749208680; x=1749813480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DPDo39+4uWiuTs/5TrsHwfdO+Ybs2XhzP0BRvioGpc=;
        b=ZFUs0uXligE5kIFoSIBF3oqhHcZVTIMSAl9M2ZmSrLuQHvztcz5FAF0rEaskinQaI+
         YhxYRW9OnY0tDCVHpHcIt7mlYH/pq9CFT9BOlOvz7AHsYVoXeTBpJS2oQfUsGRXWYyG6
         b8M+FG+IWLhF/hwUAk50Y+ZXv+9HVqY2/hNY/CkHQE9BNkrGy8nW1rSpzxt0ZZAq6tQR
         PFdlYvYoGhZBKrX8Ae5ErMneueeLRg3NozGxVGnf4QJXVhElZfmsF+UPM9Toyb4amw21
         xDXYeIBzuzL7ZHzecoNP6vmzaLuN1SWHs2hEqJIi2kKYgtKtwR99Uk7pVlpFR3jcE9AJ
         jORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749208680; x=1749813480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DPDo39+4uWiuTs/5TrsHwfdO+Ybs2XhzP0BRvioGpc=;
        b=tnSktNkDbVw41iNs/wjNOzcTbviy0cgO44LKIYrhu16j68ExEV/TJKTqdpgQ+F7H2Y
         +9wG5nusrFmmRWN1m+nBtqPnycan9fwO7sTEMaX3ew9HEraWE1l0tp9mfRFHUQksTEgm
         npHm3QgtXMdfOeh8rP0JbE9y9+ZsrB73I78IBJGm4UAp5Cl9HNz7h4EtIsIZIiGKH9Tb
         ENxUlM5+sfp+1FzjW5C9u54U2fjBJP6vCvX5h9oAU7hhkywuM5zQL6efie0jAQSiESiJ
         lSt9eiEYvrI97qwdURcNm8wY+ASYj9fM3vcbW2zy8sEbjZMgi0qkC9NzdolJcy+ZOtQo
         QmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2ScrgiyOn8uZ8bcyBNp4pmXvydXRaM1tM7ni27lY520pGxweWhMPmednVMdrjyqTE6cNrmQP3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4NQ6rNlnltRdtJ2G/b1gdvWnJYwnRAEymZg6gJx/rjQ6sAN5
	eOad5w2QT8lxmmQumQjC6Uf7Ib+mQUolr86aDT5xoTzYlatYiZWP7K3L6FT6jBQ4gPk=
X-Gm-Gg: ASbGnctHLlCb6AHZWdXdabXyrj0q4P9F384P3UdFIYfMEHESlITNav1uzJOSuqv9Anz
	3TnMZszoz5U6n+JhvvOMSB17GvoR3Z7F8RCEPOwrigVf9gL7eensVt+gzIYmP+3H+ARMPE4MhF5
	3pcaiBgPqefdQafgH1mprFah1URucC80IIEreePRjCTvmT7TUMPxxlit1PPewYnOypw6HoIWfou
	lyFijdVDWR59J4bEbJJ4w2OvUngSIFBvKf3+6giSqCwmchvKtEmYYlhbmF0c81s0IsSics+N2pZ
	siYAvf74BWxGJUNUGp0RJmyXtMji+Dd6zmtGLjktkil3gKslXyi4RkonNmB03igJApERYu2lVmQ
	HiNlzzQ==
X-Google-Smtp-Source: AGHT+IHEl1tPJoKtHBu3HfHQ16gw36K9TO7lnz3CJzribBe1iqtYzLhJA23YP6zOaAWmytoJBYRbqg==
X-Received: by 2002:a17:907:3f9f:b0:ad5:6622:114e with SMTP id a640c23a62f3a-ade079048b4mr586268866b.30.1749208680261;
        Fri, 06 Jun 2025 04:18:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b566sm98704566b.164.2025.06.06.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:17:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 2/2] driver core: platform: Use devm_pm_domain_attach()
Date: Fri,  6 Jun 2025 14:17:49 +0300
Message-ID: <20250606111749.3142348-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
clocks are managed through PM domains. These PM domains, registered on
behalf of the clock controller driver, are configured with
GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
clocks are enabled/disabled using runtime PM APIs. The power domains may
also have power_on/power_off support implemented. After the device PM
domain is powered off any CPU accesses to these domains leads to system
aborts.

During probe, devices are attached to the PM domain controlling their
clocks and power. Similarly, during removal, devices are detached from the
PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
	  dev_pm_domain_detach()

During driver unbind, after the device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently invokes
devres_release_all(). This function handles devres resource cleanup.

If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
cleanup process triggers the action or reset function for disabling runtime
PM. This function is pm_runtime_disable_action(), which leads to the
following call stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to resume the device at runtime. However,
at the point it is called, the device is no longer part of a PM domain
(which manages clocks and power states). If the driver implements its own
runtime PM APIs for specific functionalities - such as the rzg2l_adc
driver - while also relying on the power domain subsystem for power
management, rpm_idle() will invoke the driver's runtime PM API. However,
since the device is no longer part of a PM domain at this point, the PM
domain's runtime PM APIs will not be called. This leads to system aborts on
Renesas SoCs.

Another identified case is when a subsystem performs various cleanups
using device_unbind_cleanup(), calling driver-specific APIs in the process.
A known example is the thermal subsystem, which may call driver-specific
APIs to disable the thermal device. The relevant call stack in this case
is:

device_driver_detach() ->
  device_release_driver_internal() ->
    device_unbind_cleanup() ->
      devres_release_all() ->
        devm_thermal_of_zone_release() ->
	  thermal_zone_device_disable() ->
	    thermal_zone_device_set_mode() ->
	      struct thermal_zone_device_ops::change_mode()

At the moment the driver-specific change_mode() API is called, the device
is no longer part of its PM domain. Accessing its registers without proper
power management leads to system aborts.

Use devm_pm_domain_attach(). This ensures that driver-specific devm actions
or reset functions are executed in sequence with PM domain attach
action or reset and the driver will not end up runtime resuming the device
when it is not anymore managed by it's PM domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- adjusted the call to devm_pm_domain_attach() as it now gets
  2 parameters

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

 drivers/base/platform.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..c39d21fc1793 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,15 +1396,12 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = devm_pm_domain_attach(_dev, true);
 	if (ret)
 		goto out;
 
-	if (drv->probe) {
+	if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
 
 out:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1419,6 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.43.0


