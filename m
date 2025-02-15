Return-Path: <linux-pm+bounces-22151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1CA36E67
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006A93B0961
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBF31C84A6;
	Sat, 15 Feb 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Wn4ZBtai"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34171C6FE1
	for <linux-pm@vger.kernel.org>; Sat, 15 Feb 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624942; cv=none; b=GzDqArqAZkAMltHHhRL01OvCn2d8alLmb25CL+qA7vCUPqhi7UNDXcwpN9UxfuvAv5/kxOTpXbrib3UcH2m6C45WbiF7HuHX5hhlWNq7MLUTYdvzv59ulOB6S3uIcVvrSpnsYfjUO9ZsYHagylG8+kfFbs4xB9OO4N9MO3coLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624942; c=relaxed/simple;
	bh=s4htX+F1zzRD0lYov4+9prU+b0yfaEjXX+1u/e48NXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQaBHCtAM4od0O5/hXASnCYqlAILc564fmK47zDjpSYRSVPSK3wxwOq2j8f094v/43y27mycFUCybRaitA2SZNMfv/VTba/iASqnsDtCMprmESX6Wkle9X2TUXD/D2kZ/85Aypw5q31+vH5hRBG08qon/18swmbRGjhhfsWSmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Wn4ZBtai; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso4771455a12.1
        for <linux-pm@vger.kernel.org>; Sat, 15 Feb 2025 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739624938; x=1740229738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPr0RA4sTxfMrblR7pYl2liz/ysOC6e1FaOIdebj5hk=;
        b=Wn4ZBtai/Eh60ePuwzYAWINMvABoAQ60hH8jAxjQoR8qMHg5AiBRj/DAxpIv9UNavu
         KUJgs3jUlD5Ca0oz0LHBhLtjvaK8EldV0sa0ghsXyOaV3S2MDrJgipBGEqHOiFNSgQ5F
         PmTzir/nQeWlJh6TDzlZvX6/v5nPAa4Xtiam+V3He284o2szQgdPqFWOa4RDsIH4BCt/
         09M/DwPcReI+JR0jF+KHlhMfpE67lf/VJWI8vKXYwzYqFA7XfzM4Gx0uO8V1ClJQWicj
         ogSqfnHidEFrHKhbwG6jk7XGvuq+ggiAqxv4lYefh/WPfFVY3DEyP/2ZNZpB7uFpxtoD
         nTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739624938; x=1740229738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPr0RA4sTxfMrblR7pYl2liz/ysOC6e1FaOIdebj5hk=;
        b=lumUMHQkFn6KsCwq4Yi6s41RhFuwVdRHJN6RmLRPEgCVYyRtQtx1PCaEICn7fzgE0c
         mWg/4JxA6inEGm/Ruo0Xr3hOz+oRQTpsJBa9l6mp28SCnVjh50vY1QNDcezUpHrbx393
         9cthyUt57B9sT3LCH3l6lGyeV1OaJOY/Dfmx4zC193Pyt4vhSU9QbGkfW/2VBTDyDwdK
         jJqBhoDfbbW5eeEpnyLdMX7xqKy5VDAfPPRNKKqZB9P4zWPrZHt2eeIcSRIQB2k7Yh0I
         J59tdqcKyNHOOETuTlUlHPtPLrjC3idsz1ujZRW6Sl018kodG+OeYB4A2Eby9xSWQUC1
         xMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVlO0dMRtm5/irn4ObwDTdDNaxr2npNndsoUilvQp6gPPn/zREGE8gQJus5n0t7ASF1NuMRlLH4zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOloMNVhbbP6hLgYgj9hz8Z+OlWE6AK/q+EkesWuQXUeEdbofW
	LK0rmjFo7riXsxKIFznix++A8zL1sFqvhuTyjW3ywN7zo07Cbq+2nNU7mINGFxbp8u56myD2WAg
	w
X-Gm-Gg: ASbGnctRIF9ZR2O2qFG2sSvnkO8YQXF4bMwkvyR4zomliZkUDp13uNajmQkh6UbOpXl
	QKLe6iFqublfSwTBDlShSXBcCBsuaEAFFEHLn31SgcKB/OzIraqEM2gISRZYDb4OoI75d2lZomq
	E0UUdZXmHTTJv5qe4ZwobwbubZUrsE7P+Zz97dVTFahfxtn4m771eiPfZUtYki2B7F+uqKQ6YHD
	OfZ6xdxtdfEQ8etfjd8bYKxXaQIjm35vB4z7SfvWm9s3uoGIaKQzj2gXoGqCpZU6Oll6gdVIJAQ
	mzgico0nLERnS+ri2EJs9QA6DfW541BO1I1pqIV6VNAtBw==
X-Google-Smtp-Source: AGHT+IE2gOOcTHNza2EOhRpbFKVQn95DHRKBHAZlBuKwZYla0cd1eeJ63caSvBI9Z702VIK30UtwcA==
X-Received: by 2002:a05:6402:42ca:b0:5de:cf0c:cb37 with SMTP id 4fb4d7f45d1cf-5e03608d918mr2811400a12.12.1739624937833;
        Sat, 15 Feb 2025 05:08:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3693sm4444316a12.39.2025.02.15.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:08:56 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	jic23@kernel.org,
	ulf.hansson@linaro.org,
	daniel.lezcano@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] driver core: platform: Use devres group to free driver probe resources
Date: Sat, 15 Feb 2025 15:08:49 +0200
Message-ID: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

Open a devres group before calling the driver probe, and close it
immediately after the driver remove function is called and before
dev_pm_domain_detach(). This ensures that driver-specific devm actions or
reset functions are executed immediately after the driver remove function
completes. Additionally, it prevents driver-specific runtime PM APIs from
being called when the device is no longer part of its power domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi,

Although Ulf gave its green light for the approaches on both IIO [1],
[2] and thermal subsystems [3], Jonathan considered unacceptable the
approaches in [1], [2] as he considered it may lead to dificult to
maintain code and code opened to subtle bugs (due to the potential of
mixing devres and non-devres calls). He pointed out a similar approach
that was done for the I2C bus [4], [5].

As the discussions in [1], [2] stopped w/o a clear conclusion, this
patch tries to revive it by proposing a similar approach that was done
for the I2C bus.

Please let me know you input.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20250117114540.289248-2-claudiu.beznea.uj@bp.renesas.com/
[3] https://lore.kernel.org/all/20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com/
[4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L579
[5] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L630

 drivers/base/platform.c         | 10 +++++++++-
 include/linux/platform_device.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c52..1b64c4a44263 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1401,9 +1401,15 @@ static int platform_probe(struct device *_dev)
 		goto out;
 
 	if (drv->probe) {
+		dev->devres_group_id = devres_open_group(&dev->dev, NULL, GFP_KERNEL);
+		if (!dev->devres_group_id)
+			return -ENOMEM;
+
 		ret = drv->probe(dev);
-		if (ret)
+		if (ret) {
+			devres_close_group(&dev->dev, dev->devres_group_id);
 			dev_pm_domain_detach(_dev, true);
+		}
 	}
 
 out:
@@ -1422,6 +1428,8 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
+	if (dev->devres_group_id)
+		devres_release_group(&dev->dev, dev->devres_group_id);
 	dev_pm_domain_detach(_dev, true);
 }
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..e842ad243bef 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -40,6 +40,9 @@ struct platform_device {
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
 
+	/* ID of the probe devres group. */
+	void *devres_group_id;
+
 	/* arch specific additions */
 	struct pdev_archdata	archdata;
 };
-- 
2.43.0


