Return-Path: <linux-pm+bounces-20185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F5A08A9F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A033A8F01
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60A207E19;
	Fri, 10 Jan 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BHCdFg++"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364920897C;
	Fri, 10 Jan 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498687; cv=none; b=O/Mo1loI0ONT7oKLQWzGIRI0BUBDrsej4r1mxftTpCNS+lG7RhlIb3tlItsHkOgtUUyyzbRqrA7T5yZh3OIRyYUnVH67wP947SjTBqDtmZE/wPTfRZBEf2Gieuihl8d+R4x9roPkISPpZFCVFMFwfLtskZway43rAVaEy6HxVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498687; c=relaxed/simple;
	bh=of+lKH/eioVYAA03UEI/WQvpV+fhPhuHGfBVUKw4xJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRDNuo9nCVjq+4BXg1C12gxX9aiintSVQJXwZjn7KI/KSe7zHOxXGltgkN2lOzWtZWbl8bdcJK+IIn5P9IDRxsVZFrzOPIc7ZgIXMw/jfHBeyRMYyudwk4FIOz7j6QKMv1z2ghRtkQYUF756b9qCHHz9BLrmlkqsSL4H2zE+Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BHCdFg++; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.200.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 110AC3FA7E;
	Fri, 10 Jan 2025 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736498676;
	bh=vTqK5C56T9DHhOQZVrs6YW0Drcz5tM30Ooii9+1QvxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=BHCdFg++sIXf36LYrfAmnrnIBIDq3qUvxKerOUnwgafYqSVL9Vc+B+fklPkQB/YPg
	 1Cx36oPfKe91NpXeXNMwHlOgAQE0luKP06a13lNljN9Z0osH2u9y/iypEzuy3azjLz
	 sj4cNRY7Hiy6puXSCakfl4S3RHYzHEhYV2h9wbrwaBCw8YHItC1moNQgDslypNXJlq
	 kd1sL24i9iLwSiJ6D11ll6g4p5BXBk6dIJhvmq57rvhdpouF1rFsMpa18s2JTJ3KKU
	 kBSujXh4FjIhM5Ck2s9ql5FdlaroWV9mUMQOU+iNE9uVOqSswYzcNvzxAOcfoK5SRG
	 7/3N1wWRGKBSg==
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>,
	stern@rowland.harvard.edu,
	bhelgaas@google.com,
	duanchenghao@kylinos.cn,
	dlemoal@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	hdegoede@redhat.com
Subject: [PATCH] USB: Prevent xhci from resuming root hub during suspend entrance
Date: Fri, 10 Jan 2025 16:44:10 +0800
Message-ID: <20250110084413.80981-1-leo.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit d9b4067aef50 ("USB: Fix the issue of task recovery failure
caused by USB status when S4 wakes up") fixed an issue where if an USB
port change happens during the entering steps of hibernation, xhci driver
would attempt to resume the root hub, making the hibernation fail.

System-wide suspend may fail due to the same reason, but this hasn't been
addressed yet. This has been found on HP ProOne 440[1], as well as on
some newer Dell all-in-one models. When suspend fails due to this reason,
the kernel would show the following messages:

[   74.245058] [165] usbcore:hub_suspend:3961: hub 2-0:1.0: hub_suspend
[   74.245850] [165] usbcore:hcd_bus_suspend:2251: usb usb2: bus suspend, wakeup 0
[   74.250971] [3508] usbcore:usb_port_suspend:3554: usb 1-2: usb suspend, wakeup 1
[   74.263025] [11] usbcore:hub_suspend:3961: hub 1-0:1.0: hub_suspend
[   74.264029] [11] usbcore:hcd_bus_suspend:2251: usb usb1: bus suspend, wakeup 0
[   74.265061] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-14 not suspended
[   74.266020] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-8 not suspended
[   74.266933] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-4 not suspended
[   74.267758] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
[   74.268677] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 6
[   74.269632] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 5
[   74.270448] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 3
[   74.271228] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 0
[   74.271946] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
[   74.272802] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 8
[   74.273533] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 5
[   74.274233] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 0
[   74.274982] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
[   74.275814] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 2 ep 0
[   74.281739] <intr> xhci_hcd:handle_port_status:1992: xhci_hcd 0000:80:14.0: Port change event, 1-8, id 8, portsc: 0x202a0
[   74.282453] <intr> xhci_hcd:handle_port_status:1998: xhci_hcd 0000:80:14.0: resume root hub
[   74.283145] <intr> xhci_hcd:handle_port_status:2109: xhci_hcd 0000:80:14.0: handle_port_status: starting usb1 port polling.
[   74.385425] e1000e: EEE TX LPI TIMER: 00000011
[   74.385543] [3508] pci_acpi:acpi_pci_set_power_state:1119: pcieport 0000:80:1c.0: power state changed by ACPI to D0
[   74.385722] xhci_hcd 0000:80:14.0: PM: pci_pm_suspend(): hcd_pci_suspend returns -16
[   74.385735] xhci_hcd 0000:80:14.0: PM: dpm_run_callback(): pci_pm_suspend returns -16
[   74.385743] xhci_hcd 0000:80:14.0: PM: failed to suspend async: error -16

To address this, extend the fix in that commit also to suspend.

This patch was tested on top of next-20250109, by suspending every 2
minutes consecutively for 300 times on the machine where the above error
messages were found. There's no suspend failure found during the test.

[1] [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
    https://lore.kernel.org/all/20240906053047.459036-1-kai.heng.feng@canonical.com/#t

Signed-off-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 08c37b83fea8..d71347357fb1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -571,7 +571,7 @@ const struct dev_pm_ops name = { \
 
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
 #define PMSG_NO_WAKEUP(msg)	(((msg).event & \
-				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)
+				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE | PM_EVENT_SUSPEND)) != 0)
 /*
  * Device run-time power management status.
  *
-- 
2.43.0


