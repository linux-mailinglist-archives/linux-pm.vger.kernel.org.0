Return-Path: <linux-pm+bounces-36836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF7C0A2DD
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 06:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D915118A1C35
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 05:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467F26C3A7;
	Sun, 26 Oct 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwhXphFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D21F418F;
	Sun, 26 Oct 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761455360; cv=none; b=sP6IBw91AkaQpRUonZhy/MkaxreoB9GLKU7YbOdFJGQlyNyFvmaLNMpt0cRX+Bar7Gmnsru39wUD3tFfWclkJp2jRHLd5YbWLjf2Fmk3w+GW+4yMISsqj/YmM3KitYva2LxLsWGzoTezNea2Jja3zi1gKrnpVRXbIFFgbPReTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761455360; c=relaxed/simple;
	bh=6XiZgfsNBocAwOS04/Uuo8bTn1cHIsmxVC1m1SGOQn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+R+rXRBl6fSW/zLdP1dJTlBq0Pj7zsc2AysJ/E5e5ZriFXEQ2GkIgkmNAfbRHvsN4PIwYrS8SzleDoclIcPKSpuKJMPZpc/ykH/HeCFamIVdhKN27rg69VoSsYgII4tDlVqLfhgFIa0FNrRfUQ9lI10YH2ixZVMTl9/Vf8Q1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwhXphFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8B2C116B1;
	Sun, 26 Oct 2025 05:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761455359;
	bh=6XiZgfsNBocAwOS04/Uuo8bTn1cHIsmxVC1m1SGOQn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwhXphFvvpYXyHa990A1SW6cN4jV6dfywRIyP/LpP+FbLL8FSZUoY0UCbNSgBWRFU
	 Im2HJdrBGCb/iMLizmyUGEA9oMWroqOtTv//cTqhuXpzQ2kDDisc+LByt0NgO/eSvT
	 +CEgYmhPQMg70vk4kdPXhihkUXZgfCP+6kcL8GFaZ7bmiCXXpYlVkIyJ4aRf9NyIPr
	 5Fe1iGU/2xK0wld7ehKakQW0RQP6x0L5bOGAX1K97t+dtZuxbN1zkCGzMLT2Kj9MSX
	 HFJ5GlsiF8pjaF4N22HiC3KEYkEH6RELstYKswLZX2UWwpKxzou1tyIvye0VLTo++P
	 dddWYQrFGZqig==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v9 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
Date: Sun, 26 Oct 2025 00:09:05 -0500
Message-ID: <20251026050905.764203-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026050905.764203-1-superm1@kernel.org>
References: <20251026050905.764203-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

suspend_common() passes a PM message indicating what type of event
is occurring.  PMSG_POWEROFF is intended to be used when hibernate
callbacks were utilized for turning off the system.

Add a new callback hcd_pci_poweroff() which will
determine if target state is power off and pass PMSG_POWEROFF as the
message.

suspend_common() doesn't do any special handling with this case at
the moment, so there are no functional changes in this patch.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v9:
 * Reword commit message (Bjorn)
v8:
 * Drop SYSTEM_HALT case
v7:
 * Reword commit mesasge
v6:
 * Fix LKP robot issue without CONFIG_PM_SLEEP
v5:
 * New patch
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/usb/core/hcd-pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index cd223475917ef..959baccfb07d1 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
@@ -531,6 +532,13 @@ static int hcd_pci_freeze(struct device *dev)
 	return suspend_common(dev, PMSG_FREEZE);
 }
 
+static int hcd_pci_poweroff(struct device *dev)
+{
+	if (system_state == SYSTEM_POWER_OFF)
+		return suspend_common(dev, PMSG_POWEROFF);
+	return suspend_common(dev, PMSG_SUSPEND);
+}
+
 static int hcd_pci_suspend_noirq(struct device *dev)
 {
 	struct pci_dev		*pci_dev = to_pci_dev(dev);
@@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
 #define hcd_pci_suspend		NULL
 #define hcd_pci_freeze			NULL
 #define hcd_pci_suspend_noirq	NULL
+#define hcd_pci_poweroff	NULL
 #define hcd_pci_poweroff_late	NULL
 #define hcd_pci_resume_noirq	NULL
 #define hcd_pci_resume		NULL
@@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
 	.thaw		= hcd_pci_resume,
-	.poweroff	= hcd_pci_suspend,
+	.poweroff	= hcd_pci_poweroff,
 	.poweroff_late	= hcd_pci_poweroff_late,
 	.poweroff_noirq	= hcd_pci_suspend_noirq,
 	.restore_noirq	= hcd_pci_resume_noirq,
-- 
2.43.0


