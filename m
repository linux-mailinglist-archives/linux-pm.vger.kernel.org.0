Return-Path: <linux-pm+bounces-30035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80756AF722F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF773BEB6F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E02E612E;
	Thu,  3 Jul 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NWaPrfeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E12E49AF
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542074; cv=none; b=g+7/Uv59Iseg23ytup8x+0IofeTeGi5RfVezds9PeL7/E3UXxuK7qPwoA/uFvY3Gcm3h+3t7rXRrQR1eMK2O0gU5uNpkvmBHDcIStCWSFcw1PVF8XbQwWfNuSCxqkYfONhB047FjfOad2KD/iVVJdcl4c0fOf/h/FYIT/SgXXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542074; c=relaxed/simple;
	bh=X1Oyr9vFTxLX3A2BuvfxXazNPEQYM31gD4YJTucU+Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLa1EVPzPzIDlfZ6YE5nzrkO85/Llykwz79hfXIhmhFFgXfBxAHlSn4HV7kEOV1vv8IhtDBQpag6i2ue/NXI6JdsUWCffXREghDYZWq6Q77KYXm2BRgi5UDXUWzEVlb17GXCe6pmaI29BWyYrAAUgGrJ8/8Hgu0fsHnowpeKVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NWaPrfeM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adfb562266cso1249036866b.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751542070; x=1752146870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=NWaPrfeMNu6lzcL6odLfZsNPLmYpVaPVg30El2x0eGSaccOcXkGqo1EdMEBm1zC5GI
         UWaqm6d88selempizMTQdl90luJ/o+HoxhIRBcnWkeaVoOAWZ5OPgM2yecuG97Pr3HJk
         qS96Ys4Ra3HzmYQX/1A68bF3kcz0O6hpK2bGHsmMkmPhgrbC18rNVDAvvopGIFVsu/1D
         LZHIOwrOvbHodHlqKABBqMCqB/qUr4Ndf25U9wWhGVeY6W8qK6Zb1JmladgI6A9GLm8M
         hHIviZwE4iTBFIbTFTNuii2SNcEwqd8Jb01yMnVWxLifPGewD6MrP5QTZ1wX5YqjBED6
         GrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542070; x=1752146870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=SasdHlEbLhnsUEs02A8O6XFcI+eV4QXLG1grNbTT+wEvmjvB1Ie5G3M87RUXoRjjz1
         frObUZ/35iXuAvVKlx2Du9QjUnviYGbpqPZ0m2qkBvcI+lAF7+yUg6b52+OFMgBgYABM
         Y0PUNu8nJCfyh9cn3QusDkzOkeTW4rTt7PjXIaRcgel3cIYBu3XQcp1MG1HsaSI2PlyG
         ywbvO8AaQMc8u9y0728dd6eaU+urXoQ5zPmRPBMGWpPtAEAiY5VgSir7BX/9gfCcGXvk
         ezAhzXHHK/Pwy3xnrczSxGs3HRCBq8PnOcq3JNDF6QBQLao/ErslSBeB9X961HYNN9hG
         42Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+nJq+19I563hiEyCTP/x88493dovWmGtdYGS/3Hk5UAKJx/3WOSOA01V5o6FbGpVL84No1bBQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gmvSlBiSYF32MH0jxOCByDgb5ONhliL0I1oh647KRHkxO+WS
	qnjO8Ygrh/ZmGNgYNYJhnYfcwhWwL4WbedKVKXU1N1PlAk1L6v8pAtXcF8Z7sqDvomg=
X-Gm-Gg: ASbGnctRxBxYgx1IaPj/IuCcGsNqpYxLg/OYcmHvtk1rjxkU5RKQBd0bAKPqsHnQYFK
	wGoQlLBFutVAECGmrjogSryLryD2pthjY+cGxV0FHbQ7x0FuanktXkH3l3+LqwflsXF6E8V5aua
	lDwVum5sv9dGuJl3zmNq0xPMKPKSDgVFJJ3nNfrAsCg+gkYuiP9VY/CXaOf2T7Y55IiVgdorcfU
	aHAGw6mtj5rv+SHZoneQ7MBaZBCExNX2hHTUSBLyuc94ZLyIuhSSfufA22wxGF225fZvpBLFKan
	l/4bNrWpNgLjuWO2AM4EavCY4/ZuElBG1i4weKOZrIUETxz6hNQnjr/+BN+gXIm/cbLbgQMd6c2
	VOEWkDULn5SgZ9dU=
X-Google-Smtp-Source: AGHT+IFkYQwbGErnKmAXbXp56IWazGm9DvxurIRdNCD1GAvBXxqd+zW8SE1e2XD1WudHDmEIZdYoAw==
X-Received: by 2002:a17:907:1ca7:b0:ae3:6b52:f7dd with SMTP id a640c23a62f3a-ae3c2d69de4mr612468566b.46.1751542069470;
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1247016966b.67.2025.07.03.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	robh@kernel.org,
	jirislaby@kernel.org,
	saravanak@google.com,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 2/3] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  3 Jul 2025 14:27:07 +0300
Message-ID: <20250703112708.1621607-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The dev_pm_domain_attach() function is typically used in bus code alongside
dev_pm_domain_detach(), often following patterns like:

static int bus_probe(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);
    int ret;

    // ...

    ret = dev_pm_domain_attach(_dev, true);
    if (ret)
        return ret;

    if (drv->probe)
        ret = drv->probe(dev);

    // ...
}

static void bus_remove(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);

    if (drv->remove)
        drv->remove(dev);
    dev_pm_domain_detach(_dev);
}

When the driver's probe function uses devres-managed resources that depend
on the power domain state, those resources are released later during
device_unbind_cleanup().

Releasing devres-managed resources that depend on the power domain state
after detaching the device from its PM domain can cause failures.

For example, if the driver uses devm_pm_runtime_enable() in its probe
function, and the device's clocks are managed by the PM domain, then
during removal the runtime PM is disabled in device_unbind_cleanup() after
the clocks have been removed from the PM domain. It may happen that the
devm_pm_runtime_enable() action causes the device to be runtime-resumed.
If the driver specific runtime PM APIs access registers directly, this
will lead to accessing device registers without clocks being enabled.
Similar issues may occur with other devres actions that access device
registers.

Add detach_power_off member to struct dev_pm_info, to be used later in
device_unbind_cleanup() as the power_off argument for
dev_pm_domain_detach(). This is a preparatory step toward removing
dev_pm_domain_detach() calls from bus remove functions. Since the current
PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
already set dev->pm_domain = NULL, there should be no issues with bus
drivers that still call dev_pm_domain_detach() in their remove functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- added flags argument to dev_pm_domain_attach_attach()
- added description for struct dev_pm_info::detach_power_off;
  @Rafael: I kept the detach_power_off flag outside of CONFIG_PM as it
  is used unconditionally in device_unbind_cleanup()

Changes in v4:
- save dev->power.detach_power_off in dev_pm_domain_attach() and use
  it in device_unbind_cleanup() when detaching
- adjusted patch description

Changes in v3:
- dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
  and use a single function devm_pm_domain_detach()

Changes in v2:
- none; this patch is new

 drivers/base/dd.c           | 2 ++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..13ab98e033ea 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index fecb85fa85ac..6ecf9ce4a4e6 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, u32 flags)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..be824dfc8577 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -720,6 +720,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


