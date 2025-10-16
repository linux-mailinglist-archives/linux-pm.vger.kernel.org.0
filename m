Return-Path: <linux-pm+bounces-36308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A2BE5CAC
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 01:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924285843AA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AC2E718F;
	Thu, 16 Oct 2025 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlcTtEqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42C2E62AC
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657298; cv=none; b=RoUQ8isFnpLRVSfJsUYK93xPvPeBexyoYm715DzR+9N9Zdd8dWZgXaE3Ho9lYE+eI/Rb/ZEbM2ujdJJ4aIrmt3HUb4bDFgWHGzcg+2gLjphOziSKOgrWSJ3lL+QAhn+YbiVMIOc/hn2iZsJfKzzCHctKLEV1LCyo1wSCHJ5jmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657298; c=relaxed/simple;
	bh=XJoRXhF6cct+u5hqeBr/GjrKmq9CEKau2+FBHdOwe7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffOE0jCpWfCmm7TzDWClKYmpUbd7+59LYKJ1lfeF647kG8kO0cxqjB7gBhxBmy2S/wzLqXpRrG2Gdl/nRJ+vY+wXNU4RokfE+TgoTDdN48cuWTkKLDcYZX/ifsofxsDsDfTOt8QYWAq569wo7tcEt8j0XInozsWhozFU5eGrfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nlcTtEqO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1265188b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760657294; x=1761262094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=nlcTtEqOnd54qW/ICO8glTxNOt8FmeJe9owrl9qhvsPQpg/B2Mp2KNJrvMtdul+Qc0
         5ZrKRVGXHR9+Sciv6jft3dF9eSOcsgAtHbQadNAfu0F+YCXY0RCAJj29LAAA/rB3arHR
         zik0LCswwZQ/Ug93I4EKLk4SwByaxOXB4G2HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657294; x=1761262094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=SkVXQgRCNZEnbxMak/cT/oP+x8Pc6F8lhY8PlDIOGzrPhlH+/9mFHIkDIxfHixhuXY
         LZbI/deHDpe3KGjxKxSBPvNdkH9S2f/FlR3yl5+7XjlTvy8HD5MQlouRxtEmuY3jHIHF
         P4aI/PC6TTidiKNBhNYo/0E4lZ3rN64x7tjYsFCAkTx2wt39A8iJXyqkiL37aGlDAMWf
         Q8nIYHtvn1wr6Ju95SkhYJPAGoSILY8hNCNDvPEOceQxpSJ7HwDgwoMhpYb3hupjaoHF
         WsJfsiOHzxowSUqEai69iR1HgYjk22DO/daJnCJ4ZtJXxSccL8/4GrCg8LE9GWdAmVgX
         gT5w==
X-Forwarded-Encrypted: i=1; AJvYcCVXycr5cMiy25c4QP2dcIGMapizLcWsgKrp12pxlVPiU4jLll5ZrsqCpGwW5wbGHRHJY8nRghfq5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25md/mAF2hPV5hlQDWe8I1GbFHyDJrFjCH+CFBFxd/bdktDHD
	+vXD/1dWX44QfXdJEAyn2O7lgf3TxeDMTt7J1B9qYXsKeGz1iOhHmRC44U2PHK3tCQ==
X-Gm-Gg: ASbGncubFp8FhA7qPGy68MWh9SNJFSg2uoXux85zF6dw2wv2N93eQ37S3ndHRx+64zn
	dSPjzuPFP6sB24aqB81tLbkQEa4gfPMHQvXkNYhFBvIHISJZ69ASY5hO8ZRwsujo8mEMGqWt2u3
	yTNZxAsHwVXn8UNAq2RMOiUDRhJYm+8MwxkkFOqhFzkztf1+SvQNyAmqX1u6OQPe6ubf+4QO+i4
	bVdlm4tKCY2CEb+9tjgx5+ZOR4hMc6AiAeyRxFu4YAD/tcKQXloEJ/wSv2J8GHBuc43fwwvezRZ
	TxTRNW7md9f9FxhhniOBf3o85f8EBL+Db+p5Z9vXnIpj4EEShLAD10BhDIJhqV5fiKu36BYXbbN
	Aa29k361/88cGRq+NdryPOOBNrxUpkLgb0S5/0He8tqeA/NYWMm4kkk+Z+ct+YTvZz7DU/N/Yit
	lcwOjcbmxvkAT1gMueYhxme34hciI98mtpGfF4MA==
X-Google-Smtp-Source: AGHT+IHptz2Viou3aQb7JTKgXj8lqBa3xVm9ubMw1J3oe5c1h0nSfI0VxDkbrkw3mL1kDx6q4igwAQ==
X-Received: by 2002:a05:6a20:6a28:b0:32d:b925:22ab with SMTP id adf61e73a8af0-334a78fbd98mr2663524637.17.1760657294603;
        Thu, 16 Oct 2025 16:28:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:98f9:84ca:9891:3fd2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992b060b59sm24127004b3a.2.2025.10.16.16.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:28:13 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Thu, 16 Oct 2025 15:53:35 -0700
Message-ID: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI devices are created via pci_scan_slot() and similar, and are
promptly configured for runtime PM (pci_pm_init()). They are initially
prevented from suspending by way of pm_runtime_forbid(); however, it's
expected that user space may override this via sysfs [1].

Now, sometime after initial scan, a PCI device receives its BAR
configuration (pci_assign_unassigned_bus_resources(), etc.).

If a PCI device is allowed to suspend between pci_scan_slot() and
pci_assign_unassigned_bus_resources(), then pci-driver.c will
save/restore incorrect BAR configuration for the device, and the device
may cease to function.

This behavior races with user space, since user space may enable runtime
PM [1] as soon as it sees the device, which may be before BAR
configuration.

Prevent suspending in this intermediate state by holding a runtime PM
reference until the device is fully initialized and ready for probe().

[1] echo auto > /sys/bus/pci/devices/.../power/control

Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/bus.c | 7 +++++++
 drivers/pci/pci.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..227a8898acac 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Now that resources are assigned, drop the reference we grabbed in
+	 * pci_pm_init().
+	 */
+	pm_runtime_put_noidle(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..06a901214f2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
+	/*
+	 * We cannot allow a device to suspend before its resources are
+	 * configured. Otherwise, we may allow saving/restoring unexpected BAR
+	 * configuration.
+	 */
+	pm_runtime_get_noresume(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


