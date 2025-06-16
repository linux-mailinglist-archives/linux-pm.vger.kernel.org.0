Return-Path: <linux-pm+bounces-28831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA75ADB2B8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026337AC025
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F12E06C4;
	Mon, 16 Jun 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oJblHrE0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34182DBF67
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082049; cv=none; b=Bb1Gp/hymlOLk6rgf1szDx6uNCcJsnFObEsNKIzTSxoiOZXkahsghke2k0qFMTfbbqm9Xsjk+4vs8uIeJSVSNxYtmLxS0ciiOWj9ZRJVAN/k/9+FbEV5sl6/52UlLKSTi2WSCUa7uOtfXYqmWaq5kSURYn54sxUb0jESbBcuTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082049; c=relaxed/simple;
	bh=svE4SC3yD2VAnnKLAHEVk4+ObXPQzJ7EyNDf5HiDErA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVuAjKKEB8evujkatk2sLNmFcVUYhbqRA7lbX2pWEOLvdQZDsNsdN6cAQt7xs+GkVwvI54FijUmvLoGqsheF8oygnvvncSgOxi6FhOYuR34M2p660aAM9RDb1KxFJKull20WXxwLZ80Skb/82u++SvyFCqtXi6SUg03CLwOqags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oJblHrE0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad572ba1347so717162566b.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750082046; x=1750686846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAqKBohHrckCHj00ka3d3qdcyCUEgzr5W/g9gAi10Ic=;
        b=oJblHrE0dxDgkvrwuLoUj7MscYK/lN4Wy0ENCc54gNgK8XQqJxDcVBvelrluiB7dDc
         lL1RVX2nw4Yi01NaSZYXPHV/J/9/Ld8WXkpY9ctuAkb9Oe5kuUqwmKrE0lk9R88lXZA0
         yhspxS0R4IXKVjKGpQeHToSAjt4zbQcXLeZ3/8DZ6ISlSlXO9MlnJ9ppjW9WT78b2ELk
         3WDM6Ol4qseltYTMB7S4c+BAp2OtTsqg0uXtc0U8tCcIu55JaUDy+Y0ak/7GPusntSgP
         qxK6zgVYRaRCeeiNpGrTJOYXb+fLDE8Az0jdn7+Pc0hIqttV/7e89V0eqoN7qDZbxmql
         s3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082046; x=1750686846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAqKBohHrckCHj00ka3d3qdcyCUEgzr5W/g9gAi10Ic=;
        b=Hp2aIlBnUdDgGFFRlX5VbsSdwpxXAGhW2Kk6PiYj981qtTEFNud7+TdzPJRR6lPzs/
         nAPe9Xxxpdhj8abV/CspbypM95ZHwLBHcT2X2ubv16PkfKZqd/w8MgbBpEqC6pJO/HB9
         N7CAuuo66mZefSecclpJYsT5C5+nNmASF3EVt/Z011RU7tyNbIDaNZpAUFxXhAqw0oxR
         olcxEpaZpZixdcI0TxacOaEaJv8/zQq8XzvKy7BQzmKB1L4/NAqd1BRy0AhixdNp6Y2I
         IughocBxQFV41u7A4iqM5SPgGJFpeDeW5rYaUzLPTXIUVWjcihpV+3pP8o/k/w7bFSMP
         0RTw==
X-Forwarded-Encrypted: i=1; AJvYcCULfu83JhCSqQAPv4BoJ+Rau/lxaNoUTubz0KBo8amkSJqy/Mn/vNc3rDiiFUXtIfcFSTm1eqEKHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWneerG8dGLnIwsOXvHXkLfo5O546hjbfCVPvWzc9Ga+JHz7X
	kwovSE6Qo2aoAkJ0D5sRZQhvuVf3Ahk/YN0qS8auAVUT3+DGNp779g7iCaAz55ZJxTc=
X-Gm-Gg: ASbGnct2U/XTGaJO1KuCVY7Xg5aaeV57WlUErTNCNf+Ci8YsZUxXuR4D53N42thBRlA
	npY4sJgespSHMM7O1uQIVBvXviqE3I9nxAcFs0g4guWoRd0VY0lUtaahmU/vjvB58wjiP6te7Q7
	dXkXNs3yD2IEHmrXku8GvN5LoZbpDA4NpUPPN2EGI2UpHkD/fOOkruQMlmuoxIGONp2TFdzYS5x
	0UxE04lmaydemDnycG9Mn/FKpZEgf+LOqVRHWT8UQK8UUM2wbnA5SGUzpyImFFo8tVpRCdMAs68
	Zk/wgF22iJIgbd7Bd45TtR1G+lP+rBWKuw5o7Qad0alC6Bx0gX4idaXgXO/yul7CrEiMJPL1zOV
	HB9PkWW7/7YlN6o0+QtGTS0yyQNk=
X-Google-Smtp-Source: AGHT+IFCJHnvPKhcZEL3g4P9u4AcKsSY9xIC+tFOuoZRzGgFqNWr1jYsO6WAV1vgDYbQrUc3qilD/A==
X-Received: by 2002:a17:907:7e8c:b0:ade:4121:8d3d with SMTP id a640c23a62f3a-adfad2a1e75mr997444066b.12.1750082046246;
        Mon, 16 Jun 2025 06:54:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897a70bsm662748966b.154.2025.06.16.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:05 -0700 (PDT)
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
Subject: [PATCH v4 1/2] PM: domains: Detach on device_unbind_cleanup()
Date: Mon, 16 Jun 2025 16:53:56 +0300
Message-ID: <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
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
index 781968a128ff..a8f302ed27a5 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = power_on;
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..dcbe2c1ef59b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -720,6 +720,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


