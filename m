Return-Path: <linux-pm+bounces-36371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D508BEB608
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF51403813
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBF305E1D;
	Fri, 17 Oct 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0iThYoP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA342E8B81
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728927; cv=none; b=D5Il1dwB1MJukGf4n6k3SSYVq4jYr/cVxUmd27738mdl0ZLWG0jnKE/JmMEHMep3yTDHIT5azOKvLudjUnMZUvBABq/b5+rtuYVeZLoQ45r5hP4EnC3H/yVOfai+SXbWUulJDXnMJxmZ83Jy8rv7pVtMvAs1aBaLyUQk37CK8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728927; c=relaxed/simple;
	bh=zSl/sOQ3KBk7i8ADPKh+1Wp21VP6JAJtCm/h3uQYmao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdVHC3IiCSaO4ct2E++E3Tx8IJDvH4wCw3l5/F3UCa7XLqmIEzUhSyRPRPTLKGSuetWCpoEw3l9VvEMPPPrWXXrsgjy5W1XNgVazNoDbuQmhWcYZgVS0FMPFyVr7WOFfSn3mUy2Kim3HDZtya8W9QjFS9f4t/Ax0rRTHHcORUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0iThYoP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781001e3846so2186908b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728925; x=1761333725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=Z0iThYoPGdm/9OalWx+pvZgYMzSdnMKZaVrz6WG1RY3DE2MdlseR2F8fbjOqIFtCz8
         WmGI071eQBtMl097UEQ6SfOQOQgaA9B4g6J93mU86Vzq5B0cfkasic5q2vgxSVPqsK+S
         GTFUPUakUD519hj7Gum2E3nJe+tchOTOlnLU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728925; x=1761333725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=YCoGsJmomqNsHy4E7fPXNt2e4MdAoxG4ThfeEQjCdjJEUKkKps8027NgolGxRoPhCQ
         K/SIrtnNUSKGaWLPUw7P0vfaCjJc5BZ9qeH4NmbjkZK2nORisYO8aiPmc/xfQxsmm0oE
         yisqG+5aOM0fRUs0+Yp7O3hxPV5AM3mcQQtihG2XrAwiIyHcvcLjaxdf/oydEf1qXTcJ
         LfK+1GjDzXmIVED175Q/Jdb+02IqxQOqvxZmJcWPL/NrKlUd2gP/PyimCE4Ik09sw03O
         iQPqoqJeJGeEpxHJ3OFJhBR6E72aHxlhfvCH55KMtyR5vkTfIge88FSjkht20cM4lkTd
         k5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUvcdi6/b0rNIVh06OyyuMq5HUOrpkhQRg96GrCPFngQN9AGT3L95qc6FSHvH4y0PJIJdVB+gHnfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/tSsCj6gH3Vcf5ac/Rr4CC+2dtLLNj808lcWNgXJ50pzzhKA
	q8kJIqHhhID89JI5E1U2tWp7K7JMbinWdui77f9M8fKV7y7Sy/01KXMKrBk/Caqg8Q==
X-Gm-Gg: ASbGncuJLKiPPpfgP2nTCSklcWsWVgjo7N8d8G404dZBTH5ts5a9EMFxIBfW2DpHnar
	wvN2NBYfSexdN3Zc+3+EFzUWAwb/WKGa15vK2on8pQcHhGT12O4pHGizUS8LEajfn4tVNk8uhT7
	Q6pzrg7nAwhl/tlA1VTR2sqVGej/m77hrIMpfJwU8CfVNmpI94W3wHMoegjL2lQBTC0a5OiB9SF
	jR8/4qJS/EE9iNVcCQQXkWvQ/3e0xbX/I+1rT7EQzPTXVq6f7GSMTXD5P/2+lwvdbBj1voBz/R0
	4DWOcKMoOz9NjCP8t47Ew9yr0pzRKZDxwyXCreFN8aMkQmuRROGQiJV5v2W8Llqosggj9sZR23k
	AaPHPgI2TAdGS0tQofw1bZhfv18ICVfjxOAFkump4D8kc6xIoYzJqddvVlD9NSavpt5obYDh2P6
	hDSvXIkIZAaM6FET6PWBD1/GHCVXoxpKK9tNMEbIHTNULGdr6r
X-Google-Smtp-Source: AGHT+IFAAbkjfr0le6ea1oHImV4kAyDrBstZFai2T458GK8mhda6jZiJODFckP73bHLy/lAnTldVpg==
X-Received: by 2002:a05:6a20:9144:b0:2cc:692a:3a2b with SMTP id adf61e73a8af0-334a85640d4mr6572099637.16.1760728924873;
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6a76b33a27sm511259a12.25.2025.10.17.12.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Fri, 17 Oct 2025 12:21:23 -0700
Message-ID: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
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
design, this can be overridden by user space policy via

  echo auto > /sys/bus/pci/devices/.../power/control

Thus, the above #3/#4 sequence is racy with user space (udev or
similar).

Notably, many PCI devices are enumerated at subsys_initcall time and so
will not race with user space. However, there are several scenarios
where PCI devices are created later on, such as with hotplug or when
drivers (pwrctrl or controller drivers) are built as modules.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: <stable@vger.kernel.org>
---

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
2.51.0.858.gf9c4a03a3a-goog


