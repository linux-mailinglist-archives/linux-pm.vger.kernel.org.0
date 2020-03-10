Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8B1807EF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCJT06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 15:26:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24811 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726582AbgCJT06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 15:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583868416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBBQf8YSJ+Mjo+kqeDTD8Z4+zLQIuCyl3eitu/ifyRg=;
        b=X0NVUlA9F87kMy02qGYC5UyCMzlVKKMrSaMCYTmUciOcXZhA+l6pVUiaZAUCuyqvcz5dut
        uLXAqiVzzmGaKAtF00fEdikzL9nXTUf2OmJQHkRd71a5p+B4Z4k+9mnqDrMCPMll4O1vIv
        6bKhP8tcinOBHQz1vVJZpEs83YKJmmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-_ITrt1ohMu-U5VRy4G7poQ-1; Tue, 10 Mar 2020 15:26:50 -0400
X-MC-Unique: _ITrt1ohMu-U5VRy4G7poQ-1
Received: by mail-wm1-f70.google.com with SMTP id n188so768495wmf.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 12:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBBQf8YSJ+Mjo+kqeDTD8Z4+zLQIuCyl3eitu/ifyRg=;
        b=fVRHUyEP1B65Z1xvbxU8Uq05l2zUlEcOaKLe85pAVICk9TAvo4g2PxdMvul9ZNl/GW
         2eETrogOM7zzekRt0vEUoN9M4c9vSu88wMWmbXwQPNmd1IySWiTbS8+S/om1SGZQ737M
         jL63GdYC9jjcmIVAY67ZudS9fv/6XMs7JaYagF0R1mPTS3T2cdI5tRJgfo8w2Yq4Xt67
         tqbFHUezzMr+xFqiRZWT9SY45d+QoMZe3ARBX3lj7kScxpNn7FJwiBLsNmz47R15VqMI
         4AN08/d64is6v7SzEkf+Kb8tMuE4Gz3u1tkUql9vxq+5O1xn7yPDZuN6cIdr4ULO0+mb
         //NA==
X-Gm-Message-State: ANhLgQ0Gi9I6I94MvfCwEfQ10sgzviPfA3RKoj45cY16PRXEfGw1i2h0
        Ua2tBfNbwPxpGF/6QrkTTYG2lr3aH+xH1ObZUS8nqn1QaWf0X/f2t/KgBPZDgvFP9ZYUShwGZSI
        KPlCV+txxyUw9r03xuug=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr3416616wmi.37.1583868409466;
        Tue, 10 Mar 2020 12:26:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulmI+P5MpROhNKaiKOfzCCxtCMi66TM8UrbbQOxyf42qxjAGtaVwzF6sV60157AZSfFYTJtQ==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr3416586wmi.37.1583868409147;
        Tue, 10 Mar 2020 12:26:49 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:482c:9537:40:83ba])
        by smtp.gmail.com with ESMTPSA id c8sm58633569wru.7.2020.03.10.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:26:48 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v7] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Tue, 10 Mar 2020 20:26:27 +0100
Message-Id: <20200310192627.437947-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.

Depending on the used kernel there might be messages like those in demsg:

"nouveau 0000:01:00.0: Refused to change power state, currently in D3"
"nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
space inaccessible)"
followed by backtraces of kernel crashes or timeouts within nouveau.

It's still unkown why this issue exists, but this is a reliable workaround
and solves a very annoying issue for user having to choose between a
crashing kernel or higher power consumption of their Laptops.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205623
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

---
v2: convert to pci_dev quirk
    put a proper technical explanation of the issue as a in-code comment
v3: disable it only for certain combinations of intel and nvidia hardware
v4: simplify quirk by setting flag on the GPU itself
v5: restructure quirk to make it easier to add new IDs
    fix whitespace issues
    fix potential NULL pointer access
    update the quirk documentation
v6: move quirk into nouveau
v7: fix typos and commit message

 drivers/gpu/drm/nouveau/nouveau_drm.c | 57 +++++++++++++++++++++++++++
 drivers/pci/pci.c                     |  8 ++++
 include/linux/pci.h                   |  1 +
 3 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index b65ae817eabf..2c86f0248305 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -618,6 +618,60 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	kfree(drm);
 }
 
+/*
+ * On some Intel PCIe bridge controllers doing a
+ * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reappear.
+ * Skipping the intermediate D3hot step seems to make it work again. This is
+ * probably caused by not meeting the expectation the involved AML code has
+ * when the GPU is put into D3hot state before invoking it.
+ *
+ * This leads to various manifestations of this issue:
+ *  - AML code execution to power on the GPU hits an infinite loop (as the
+ *    code waits on device memory to change).
+ *  - kernel crashes, as all PCI reads return -1, which most code isn't able
+ *    to handle well enough.
+ *
+ * In all cases dmesg will contain at least one line like this:
+ * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
+ * followed by a lot of nouveau timeouts.
+ *
+ * In the \_SB.PCI0.PEG0.PG00._OFF code deeper down writes bit 0x80 to the not
+ * documented PCI config space register 0x248 of the Intel PCIe bridge
+ * controller (0x1901) in order to change the state of the PCIe link between
+ * the PCIe port and the GPU. There are alternative code paths using other
+ * registers, which seem to work fine (executed pre Windows 8):
+ *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
+ *  - 0xb0 bit 0x10 (link disable)
+ * Changing the conditions inside the firmware by poking into the relevant
+ * addresses does resolve the issue, but it seemed to be ACPI private memory
+ * and not any device accessible memory at all, so there is no portable way of
+ * changing the conditions.
+ * On a XPS 9560 that means bits [0,3] on \CPEX need to be cleared.
+ *
+ * The only systems where this behavior can be seen are hybrid graphics laptops
+ * with a secondary Nvidia Maxwell, Pascal or Turing GPU. It's unclear whether
+ * this issue only occurs in combination with listed Intel PCIe bridge
+ * controllers and the mentioned GPUs or other devices as well.
+ *
+ * documentation on the PCIe bridge controller can be found in the
+ * "7th Generation Intel® Processor Families for H Platforms Datasheet Volume 2"
+ * Section "12 PCI Express* Controller (x16) Registers"
+ */
+
+static void quirk_broken_nv_runpm(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+
+	if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	switch (bridge->device) {
+	case 0x1901:
+		dev->parent_d3cold = 1;
+		break;
+	}
+}
+
 static int nouveau_drm_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *pent)
 {
@@ -699,6 +753,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	if (ret)
 		goto fail_drm_dev_init;
 
+	quirk_broken_nv_runpm(pdev);
 	return 0;
 
 fail_drm_dev_init:
@@ -735,6 +790,8 @@ nouveau_drm_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	/* revert our workaround */
+	pdev->parent_d3cold = false;
 	nouveau_drm_device_remove(dev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..9c4044fc2553 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -861,6 +861,14 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/*
+	 * Power management can be disabled for certain devices as they don't
+	 * come back up later on runtime_resume. We rely on platform means to
+	 * cut power consumption instead (e.g. ACPI).
+	 */
+	if (state != PCI_D0 && dev->parent_d3cold)
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (pmcsr == (u16) ~0) {
 		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..3c01f043519a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -340,6 +340,7 @@ struct pci_dev {
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
+	unsigned int	parent_d3cold:1;	/* Power manage the parent instead */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-- 
2.24.1

