Return-Path: <linux-pm+bounces-34941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A06B82CB9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 05:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F643B6C3F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F624DCEF;
	Thu, 18 Sep 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEG04HfE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6624502C;
	Thu, 18 Sep 2025 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167114; cv=none; b=agRYWTMd6P0TV1zAu/eZMhAORIIj+IVzEbMV+PzsRAD/Veej+XRjUXaWoB2EjhFvya/4aYqY4znxrEyipgU6i80W+SewOjhD7e8u0Qvsk00Ua4XtgqGOreKiw5/450t35YiQjBik6x5gTWyAa4ef+HCXy4b9/i/afhCDzt7L5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167114; c=relaxed/simple;
	bh=Y1c50t1n/Nyn8JrgkMt7QziJt5LCPbY5138Oipv6v80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLLR1xVSPwuMI3n8n/csQ3PxFSFwhqunbFsGVhKV/3rRbDQbB0EGdBXrX6b05XEBF05leTiedyJ+83n5RyyK0fgyuMdesAvcbT24PNwEXze/Zl0jmrvbHFLpucoGY8H6Z8K9HItTLTmfF+pgJvfi1Tcfx//E//mT/j5yZ6JYJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEG04HfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD70C4CEF1;
	Thu, 18 Sep 2025 03:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758167113;
	bh=Y1c50t1n/Nyn8JrgkMt7QziJt5LCPbY5138Oipv6v80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEG04HfEF9HkNC6BXhQWLexrNehtsptQDKrxNsl+DpSp1cP/tI4vomxdbbOF/0VA4
	 1/GammFs+BYibaQmttRrE3bjTTXjvjN1RpIiL4vqJIKp9nhIxUY09UBtBLgYMh2EWU
	 2+kN1r1eRVb0ACx3HD777JrT0xJWGKaDbZFw0wX23tknNc4ao3qfubkiyKUy+cKDpY
	 g3yYrhWLZIlS91dkS7PAGHzwB+I5whtA1AUeu168om9rlyz8quuaKcMWRVuhucMZ1A
	 NlOofbCpgqjhZVlO84vpXDxBXjZcvVyToLcHRa7FtgMfXF4T9yIPan9jRx8t4Z6/bR
	 ZnLRDaUKv54xA==
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
Subject: [PATCH v8 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
Date: Wed, 17 Sep 2025 22:44:27 -0500
Message-ID: <20250918034427.3226217-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918034427.3226217-1-superm1@kernel.org>
References: <20250918034427.3226217-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

suspend_common() passes the a PM message indicating what type of event
is occurring.  Add a new callback hcd_pci_poweroff() which will
determine if target state is power off and pass PMSG_POWEROFF as the
message.  There are no functional changes in this patch.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
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
index cd223475917e..959baccfb07d 100644
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
2.51.0


