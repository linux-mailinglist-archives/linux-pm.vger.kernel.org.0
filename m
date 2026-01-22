Return-Path: <linux-pm+bounces-41320-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB6MHd1ocmnckQAAu9opvQ
	(envelope-from <linux-pm+bounces-41320-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:13:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F56C215
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7E2730A66B9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00137312825;
	Thu, 22 Jan 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQXnEp90"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6331961B
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104163; cv=none; b=UBEFFg+4fT93IVDSlH3BymsuJDCRqZYdWByGRKJDdwcayFsM2tqO+c4sA+mKBDFQhvlJuiUPW9sV1Bjx9D/NuznoHlec/X54HbhdxsuPVvuTZL8OHPfMbwQsG3GJUrQGdMi+d4S7h3Zdnwms38qbly7FjRT/06J4ek4OME49JKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104163; c=relaxed/simple;
	bh=PPSbiTfVEGExWa8EuuY6a6EN8vMNdxghuY659RvCiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ6hxCG1ywGMcwXOrHSIPMpnGjA1bWFLIg+VWBpq5/AqJbhLXld7cfOCCrGgj5St/8IweUUCV5f0G3QMvhA8N9k5vLWshvvXcz1HGSIEJw3A1HA45Yn4I8r+2kay/v8BCuKu8B3/KWifBqRJCskQ8QwHRu05gSrg3bisUuujydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OQXnEp90; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12460a7caa2so1863484c88.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769104145; x=1769708945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3WbKmVrq7sm/5pwwqVvAut+xxxGLtgFYQpauTPoz70=;
        b=OQXnEp90kPXwTCa2gO7xkl/5bNSZs9gW56JSbAhBCXgNyrTa8fEUdjmcwGvXh5yrgl
         CpJrbsh94R0REe5TcF1qA/S7dc8DicsXjOVUCGQiUlIzsW5Gga0fZxjmeoG3yBUteyYN
         WL+JdjWSDsUgn4Viqg0ISIm+ihWz+B9i+9I0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104145; x=1769708945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WbKmVrq7sm/5pwwqVvAut+xxxGLtgFYQpauTPoz70=;
        b=wiOVbJkKAaCFyNTJYvdJt+szwmBpMkLHThxVSePL1H0bhPxSRzWK/FDtTHehMYtbXg
         AGdM2+PfpzoB3c5CO/2xd/DR8PQyrIJafLyRZIKrcGbJDsBJ2ZzigcxRr83s+2Lq7e4E
         i2MdH3GFkuETS/gWWA4kRbsZmsussFVMDV0n6Mi7DQqdHqFDmzq9FZyK1pllYWfv8c17
         x5cYkdGdxveU/h6chE7ue5fyK3E+aXksL4oDKvyYNd5h/n9vJFopsa55UorP4YvuCyrS
         WUL1KKA7FvQfep2fTOS8w9yZ2b7PaOGEfUp5rulR+XH4Ve9dZchd0VlHWMUWFZNDlk/M
         q18g==
X-Forwarded-Encrypted: i=1; AJvYcCXb36VPIV373EfUUQyvtvbn0RLiuE+KllgHty/+IRGYSsN+rSX5tCutNOi81gCrchYtyiqERi6ExQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9Zvz0sVhuykVIcb/7hib517dKL7PIkZjcZ17JWi7nqrtg6J3
	El3D/PtUVe2HXsNEo45a9klV/R3hjmRvy4SbJ6eHasxhEsdCH5TRKw5+W8MnBGIlhQ==
X-Gm-Gg: AZuq6aJFfV6dFFxNEQNgg2EETxGmxsMAJBw34RXn/I1cWzrAqdI1jPX+kReWt93TNSn
	V9z5qVADcBm7QBY5IuIxdNK1rNGxFvaR5osAuhtOMSFF/0DDd/Ct8BjxONE9cfqXUqyjlsL8wbF
	6A2OrDMU45T/4wL8I7Vyp23qNHiujbNmIAPdp4ySICpXOR86C7vLakkYJ0s2HPEZhcEqibKvJZc
	czYvo4zyxUnLvnFtl9hBe2BKrMZIt+sNDb++jpdOPT5XEnsndgvyTKM0Oj6RmrEGUW+F4VS/EWu
	WfnAuOU0DIBtOlll/dBwiXcxZeiwElyxy2NY9Z+neoJCd33dQ/62SMxSvXhwgU5KRmiu+OJzrXA
	59aXNT/PaQWXbdkqhvKVHeGkcnqdWQoyOC8z91aSeooFqn5oRRAU9/bRfPH+Yhy5iBNkObe3TpA
	c0EdXntuuNF9P3pxkAJCNbsMOIRegwoYBMyT8N5CQ91EbDxauk+w==
X-Received: by 2002:a05:7022:126:b0:123:2d38:928e with SMTP id a92af1059eb24-1247dc082b1mr61654c88.35.1769104144779;
        Thu, 22 Jan 2026 09:49:04 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:f995:553f:5ab5:f684])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d9981a4sm164342c88.9.2026.01.22.09.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:49:04 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are fully initialized
Date: Thu, 22 Jan 2026 09:48:15 -0800
Message-ID: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41320-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: E56F56C215
X-Rspamd-Action: no action

Previously, it was possible for a PCI device to be runtime-suspended before
it was fully initialized. When that happened, the suspend process could
save invalid device state, for example, before BAR assignment. Restoring
the invalid state during resume may leave the device non-functional.

Prevent runtime suspend for PCI devices until they are fully initialized by
deferring pm_runtime_enable().

More details on how exactly this may occur:

  1. PCI device is created by pci_scan_slot() or similar

  2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
     prevents runtime suspend prevented via pm_runtime_forbid()

  3. pci_device_add() adds the underlying 'struct device' via device_add(),
     which means user space can allow runtime suspend, e.g.,

       echo auto > /sys/bus/pci/devices/.../power/control

  4. PCI device receives BAR configuration
     (pci_assign_unassigned_bus_resources(), etc.)

  5. pci_bus_add_device() applies final fixups, saves device state, and
     tries to attach a driver

The device may potentially be suspended between #3 and #5, so this is racy
with user space (udev or similar).

Many PCI devices are enumerated at subsys_initcall time and so will not
race with user space, but devices created later by hotplug or modular
pwrctrl or host controller drivers are susceptible to this race.

More runtime PM details at the first Link: below.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com/

Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Cc: <stable@vger.kernel.org>
---

Changes in v5:
 * Put pm_runtime_set_active() back where it was, to ensure our parent
   can't suspend before we're really ready. (See bug report in 2nd
   "Link:")
 * Add comments
 * Update commit description with Bjorn's rewrite
 * Add Marek's Tested-by

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

 drivers/pci/bus.c | 7 +++++++
 drivers/pci/pci.c | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4383a36fd6ca..90954f81962b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Enable runtime PM (and potentially suspend) only after we've fully
+	 * configured the PCI state.
+	 */
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..07b0d029aa51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
 poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
+	/*
+	 * Mark ourselves active now, to prevent our parent from suspending
+	 * while we finish configuring the PCI device.
+	 */
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.52.0.457.g6b5491de43-goog


