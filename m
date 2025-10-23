Return-Path: <linux-pm+bounces-36762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0EC037FD
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2741B19C8435
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418B277CAF;
	Thu, 23 Oct 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EI5hLpta"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750F2749C4
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253778; cv=none; b=NOGOdNUpeDl2mh2s1/1ABIYirPA27/CAd5jHLUtEMIgGP/ujJ0NH2/76CuVLpGi3kdW7ej/FApUtV1n1XF21mxDy9rEI0xJxM7ehoodVUrhzXUwEpZBKSP7CkVpycxj4nsgC1cAZz6BbAUR1ws66lZiqVKloMXCWikTx4TvaJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253778; c=relaxed/simple;
	bh=xFNUDuxlgYBQnBFlQVlz64sKz0GbaTPUJzILgMe5A4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qM1MIyJF9ZpMyc6h0CEpXHy4prr4Ub+OLG5l5/XderZtf0xjSaFxUtCvutJ5L2LMWtYLUTQRaEsLZrIXd/aYh/TjY5hhH7T8E65iZHRUMRJKikhsb5D/5L+iVoefi025k6BPeMZcrjOMw8ccXYmiD2GbmIBKA7H2SsO9dI223lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EI5hLpta; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a226a0798cso1086084b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761253776; x=1761858576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5YU3fkImwOk5m1OUm42Cx7Ih1OV3rU+ewOPMoP49t0=;
        b=EI5hLpta77PMqDSHxDTFL3ENmXdCr934vAIrzqXIliXUn6MLIzUYAPnGfBEDfZHRsv
         HgC8m+n5SObZzCEo2WBzOB4DM4G2YdffqrZ6lznpT8qKBarfUjCDIwQBPvuuMm9rUZXG
         vQNkJcmRUlOVQnA61JsT9D5jxK5F1yc7GnAIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253776; x=1761858576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5YU3fkImwOk5m1OUm42Cx7Ih1OV3rU+ewOPMoP49t0=;
        b=GHw2TZDbPR7SzKbS9hOB2uRE9YrgAQ+7Uhuzip9xvnoMtyUEr2J9eJ/QFp415+KLE0
         FKe7nUcGa9141v5XWwdbBOmHC6w3j4PKwLaOyPBpHu1gYM7DDoSNoVHZ0OJYDjsa+DJm
         /Ms0Q84YVLgEcxJOXPNAtL4LnliCr31mErepyIwhX9WoOTmGVjPY40W+axEyG04q1Oph
         FJkS1b/Pi9l4Qnbvu47IIqfT8tLOzWK8FuGDmubWJGPqAzvSotRuVL8hgpQjUJtzP3Kl
         Xrdt5u/3oORVwZbNmdYxGskq+sYvyXvzfDewGQZ9GfXGpD8u3pRIfpx9pnX8OLUBMq6p
         hYsg==
X-Forwarded-Encrypted: i=1; AJvYcCX5JVe/3vphq1TeSTCf5/CytaGhvdfXoOUO9ueLO7a8QcIU7v91ddTxyNYxMmqb+lMAv+0t5p+6WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAY+SpsCPrJ+isNOaQoeyBmHxA5fDJFe91mPLXDbKwijLkp7zL
	SNQvckrDfPamWlc23qI895lJaDTW75xGCkQOQTmqcJ0d0rnFiSMxX6l4eTfrS06qsQ==
X-Gm-Gg: ASbGncs8yuiHB9Bjyso57hxMeGmtRNtT76KV8yhF+QPdOfASUtthtrO2MpuRC9Sp1qz
	nthWb/Yzt/ITo9edebnOxGQsHjNMlj5Md7LnZau5XwXSLQMAJGl9WDSqAuzWScEmsDbVQQpLadw
	ZLJ1eeUF2KoLZRIETY/qdznFGp9QbHTVSYEAB1hD/nws9FVAQR5vJl9ymAmBKzFaZu/euh4la/q
	48Q1+p6jVFHq+Ej1mmYyjsY0OWx3yq22kcmVMw1hE95LuMRan+C/9FTans36rRgPpHJBZJ511lz
	PCI4SNKI2pRMpy7xp2dnNyW5QEz8ok+Ioc7KtDRiCVEnmL8bXVNCBkhi1wb+rgVrot04Uy7Udfk
	bQEyGEgvg4jY0KosvR7Bj2ccIFMaHqOF4eBm/AhSuihCENFYBJzP1xRfOv1DSxQGHHc5euWb6nw
	xWamOj4BAzh9OO5HJCx+SvWCdSp7/qC6LwMyGw/nc71C4uZ5rr
X-Google-Smtp-Source: AGHT+IH4cOtgwgDTRA9Hx5ecopi6nNJX76Z4NKaJ+kI0YK4nfHiy9626S+MkwrmKPyX9hlSOHsb5Tg==
X-Received: by 2002:a05:6a21:71ca:b0:33b:2c70:78e5 with SMTP id adf61e73a8af0-33b2c7fe045mr7751993637.6.1761253776000;
        Thu, 23 Oct 2025 14:09:36 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6cf4e349b8sm2991626a12.35.2025.10.23.14.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 14:09:35 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Thu, 23 Oct 2025 14:09:01 -0700
Message-ID: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Today, it's possible for a PCI device to be created and
runtime-suspended before it is fully initialized. When that happens, the
device will remain in D0, but the suspend process may save an
intermediate version of that device's state -- for example, without
appropriate BAR configuration. When the device later resumes, we'll
restore invalid PCI state and the device may not function.

Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
until we've fully initialized the device.

More details on how exactly this may occur:

1. PCI device is created by pci_scan_slot() or similar
2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
   device starts "active" and we initially prevent (pm_runtime_forbid())
   suspend -- but see [*] footnote
3. Underlying 'struct device' is added to the system (device_add());
   runtime PM can now be configured by user space
4. PCI device receives BAR configuration
   (pci_assign_unassigned_bus_resources(), etc.)
5. PCI device is added to the system in pci_bus_add_device()

The device may potentially suspend between #3 and #4.

[*] By default, pm_runtime_forbid() prevents suspending a device; but by
design [**], this can be overridden by user space policy via

  echo auto > /sys/bus/pci/devices/.../power/control

Thus, the above #3/#4 sequence is racy with user space (udev or
similar).

Notably, many PCI devices are enumerated at subsys_initcall time and so
will not race with user space. However, there are several scenarios
where PCI devices are created later on, such as with hotplug or when
drivers (pwrctrl or controller drivers) are built as modules.

  ---

[**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
/sys/.../power/control, and the runtime PM usage counter can be subtle.
It appears that the intention of pm_runtime_forbid() /
pm_runtime_allow() is twofold:

1. Allow the user to disable runtime_pm (force device to always be
   powered on) through sysfs.
2. Allow the driver to start with runtime_pm disabled (device forced
   on) and user space could later enable runtime_pm.

This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
specifically the section starting "The user space can effectively
disallow".

This means that while pm_runtime_forbid() does technically increase the
runtime PM usage counter, this usage counter is not a guarantee of
functional correctness, because sysfs can decrease that count again.

  ---

Note that we also move pm_runtime_set_active(), but leave
pm_runtime_forbid() in place earlier in the initialization sequence, to
avoid confusing user space. From Documentation/power/runtime_pm.rst:

  "It should be noted, however, that if the user space has already
  intentionally changed the value of /sys/devices/.../power/control to
  "auto" to allow the driver to power manage the device at run time, the
  driver may confuse it by using pm_runtime_forbid() this way."

Thus, we should ensure pm_runtime_forbid() is called before the device
is available to user space.

Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: <stable@vger.kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---

Changes in v4:
 * Move pm_runtime_set_active() too

Changes in v3:
 * Add Link to initial discussion
 * Add Rafael's Reviewed-by
 * Add lengthier footnotes about forbid vs allow vs sysfs

Changes in v2:
 * Update CC list
 * Rework problem description
 * Update solution: defer pm_runtime_enable(), instead of trying to
   get()/put()

 drivers/pci/bus.c | 4 ++++
 drivers/pci/pci.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..40ff954f416f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,9 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	pm_runtime_set_active(&dev->dev);
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..234bf3608569 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3225,8 +3225,6 @@ void pci_pm_init(struct pci_dev *dev)
 poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
-	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.51.1.821.gb6fe4d2222-goog


