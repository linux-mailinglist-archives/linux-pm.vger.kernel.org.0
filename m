Return-Path: <linux-pm+bounces-36678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CCBFE442
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D714E61E1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388EB20B7E1;
	Wed, 22 Oct 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RtFQ1ls7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59B84A35
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167728; cv=none; b=YNoRhdgSnIbUR/wljXdU9lfNkf07FgUeE9sFO5FZNtXb7OshysX3FRrFEcHRt4H+e0TAF9qRW13Bz3lE0BixgVd2BeGHnrlJOzzz4oRcKSaysW57ot6b8tbQyN69cRz9SFRwquUztyey/kT6uiIibNHnyqE5vBcvV+mCRBQf9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167728; c=relaxed/simple;
	bh=xVjhQUIb6Uas/h2svp3jW3dFK1WGu1F1BwnNNksk2pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DCAqX+F7ugj/8Gf3+U9JR/ymIe7cWPyhQLguXgw8fv1t4xMHqR8s6E7ktTOrSKQi7wtHvy5cUoZeCAJlfdahJ5GJ6edQaanH0o8jqe86VUYGjhkvT9ojb2tsunTN5Az66Fxw0KydXtTLtuWwWLygRtLOAzPTwNwNZnGb0VNv3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RtFQ1ls7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso61645b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761167726; x=1761772526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaVmqZbGLvb9KAeXi14uqL9ETEZkPe32JZKowUgQxVQ=;
        b=RtFQ1ls7J1bfr82pzzfRpgnDas14E7EF2dTwwVvaG+e4lJuzOmKBJrhGGhgEpTsrN3
         vsG0cNkSlKUnTOEgVAS7GYLpCiYMARf9hujxjSViP7wOCZ+zRNYq2lFhBZ+EpZiUMsZG
         LtUjjlajjhp2LyyCcAg1SXv/NEHY/ra11Kq6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167726; x=1761772526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaVmqZbGLvb9KAeXi14uqL9ETEZkPe32JZKowUgQxVQ=;
        b=g1yxs6wVohixKV5JXKfKJSm1Dc3UqyPhHPbXsrPMqjjElT5OTDAqYDEYcxElZvVyaa
         B019zcAQjjiQaQwkU9SUtIfdoVNhM/DurpV7kHOeU9ePkeRCKW/FXxCjTekNY7+gc7Pz
         4hR660EIuv2WRLvGhSKRVFHsYDsMXnif+Mf9TnZEA7t4zaQujrQQF7o+SJCfFxD5YvS7
         YoRCSan1n91N0/cQVqpd1XgdMsTTnVwWHcpehLk06h7W8pv05CeTMBUI+aT6eUqeJ37U
         9yYmMlVF7AFxU2qGV5BUZjDgOvvSBRLskk9GDeMUzEmefhpwCNI7cxXm41j5OA13IXtw
         ia2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1b+Xj3MIQl4okpIN9OJ8CYi/sTrZH3uL1A1dJudiRFcijPJf5MOOFZY8xRq49QnGVQwPInkXmxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1m4eqz/WinOJtEsFqIxiJRC91RSNkiij0O8xKuVeHUAxSFXJ
	INBEAmTxEWAJrB7lEqUgofLjCzwX7HQhoeygdrZun7AMPJh2dGRi1fEDRItkk4iWpA==
X-Gm-Gg: ASbGncsg6hggbuK2FMXKrE4qZIktXOick2gEzRtcKvcO/dT+8AhISf9gS07MkRjuAye
	gpWxgJ6jws+ntIvN9VMQh5do2RM6+lFMVxIPudMxATgOVsNEZiLkkNXdmjGbV0sI+L1OmGoUnSU
	3+cCrxjE90GUNMIyeI7P1SeJGoAbJbSP2hmE0QSWSokCrf22gzRadBUQfBPGpbxlLcyNS9uhjPU
	unzoKnDyDeFTQFRji6QLZLrnPOTsW96ujTizLRjpP6Vq0GhJuvWYzLOcUgcKJKMEvpZ69fw+z2v
	S+Vqalcg3A+dv0j/ScUFuO5bW9aWiJFDID6Q+PJFfF7C8CMdHVh7/bNHzQLWm5yzLasp1E5UbD2
	eD+ibnIUb8jmzSkqRDKXptrCv8Sex665OGcP0chXTGq0WDw3MaVdPVbKvgM9sVdfHddPJq/zFrj
	glzhy4ExeqBAcEUVJuEg+UW2iORc98BfoCti7IXg==
X-Google-Smtp-Source: AGHT+IEHPmnyfesaqqiIG3TvfRO0+OWa3MeuyGH4Nz3hdkpdY8TKVqBc+BP1r0X04EFXXutlW1RRxQ==
X-Received: by 2002:a05:6a00:9291:b0:781:1f28:eae9 with SMTP id d2e1a72fcca58-7a220a57034mr21397951b3a.3.1761167725791;
        Wed, 22 Oct 2025 14:15:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4874:d890:58d4:a06b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a274a9e580sm200866b3a.17.2025.10.22.14.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 14:15:24 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Wed, 22 Oct 2025 14:14:34 -0700
Message-ID: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
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

Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: <stable@vger.kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---

Changes in v3:
 * Add Link to initial discussion
 * Add Rafael's Reviewed-by
 * Add lengthier footnotes about forbid vs allow vs sysfs

Changes in v2:
 * Update CC list
 * Rework problem description
 * Update solution: defer pm_runtime_enable(), instead of trying to
   get()/put()

 drivers/pci/bus.c | 3 +++
 drivers/pci/pci.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..fc66b6cb3a54 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..f792164fa297 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.51.1.814.gb8fa24458f-goog


