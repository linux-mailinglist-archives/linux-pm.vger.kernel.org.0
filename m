Return-Path: <linux-pm+bounces-36808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6136C08758
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 02:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4152D351C1F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A51DDA24;
	Sat, 25 Oct 2025 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGVmnBFx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAD1DA55
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353067; cv=none; b=DLmmH8+NnGR2eLHplmlsEEnLJplHm546nf+XeI7z/4O5xxpnV/vRmIhYen2xMthXBS5wnUaR0GLPa7JgYYTZxB3vPwXVsrALsI2Ec9m/zjpasiY6GeKpZ5fP3hvcmi0r1Bh/Sr3k6mp8jTZr4ikUPtz9aM4/Mev1AVXs2gjPTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353067; c=relaxed/simple;
	bh=Z2NY7aObmeRglNBRvH0ocDVSL6V4PTUODv+6wqmr4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOKTM80XD68NGFFweqVeNqMP6zDv/X1hgNOCHrHsmi36ZWfKoyTWyXlsaoTQDRzzrSBoug6LoqevAhSNn2q7U5U33EfcGgNJpUqg1AMXkwOVGKEJOEdHyWvFvG29j66cu+TBINH3qO63JBsgzDYmym7NyyPqq5z9NIjA2VHhuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGVmnBFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A17C4CEF1;
	Sat, 25 Oct 2025 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761353066;
	bh=Z2NY7aObmeRglNBRvH0ocDVSL6V4PTUODv+6wqmr4ZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OGVmnBFxKJL0oDmSGUdxiiqgHN08C+8qTB/004+s5gW+flbVN+gD6SGrrUm54dUei
	 QSIHZg+rJRC+KnaiBj0P+Wbj6Pu5gDnkcgxRnl8WK3hCwxFwO8GaiE7h3JRG+nuVcc
	 0qXEUFpP4qPZ0NbuHaDl+GHmTCOxiJNfPpepCvJqAL3ediyddfm37wu1R9nQQfA4+u
	 K+KKYMAV/wpbBnYqQvFtRhhZTmm22YfGRgr4W/h+nJdrP1f1XHx1HrQ60bHBfedXDb
	 31hkGweCl6Dr+K7Wwaht+GuxpgSBPhlRU5WfrqeuU+lutpjnXJc2sP0Y0DTbFJnHdW
	 FDhPFfrh2GT4g==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] Documentation: power: Add document on debugging shutdown hangs
Date: Fri, 24 Oct 2025 19:43:34 -0500
Message-ID: <20251025004341.2386868-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the kernel hangs while shutting down ideally a UART log should be
captured to debug the problem.  However if one isn't available users can
use the pstore functionality to retrieve logs.  Add a document explaining
how this works to make it more accessible to users.

Tested-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 Documentation/power/index.rst              |  1 +
 Documentation/power/shutdown-debugging.rst | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/power/shutdown-debugging.rst

diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index a0f5244fb4279..ea70633d9ce6c 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -19,6 +19,7 @@ Power Management
     power_supply_class
     runtime_pm
     s2ram
+    shutdown-debugging
     suspend-and-cpuhotplug
     suspend-and-interrupts
     swsusp-and-swap-files
diff --git a/Documentation/power/shutdown-debugging.rst b/Documentation/power/shutdown-debugging.rst
new file mode 100644
index 0000000000000..cdfa2cd90e5c6
--- /dev/null
+++ b/Documentation/power/shutdown-debugging.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Debugging Kernel Shutdown Hangs with pstore
++++++++++++++++++++++++++++++++++++++++++++
+
+Overview
+========
+If the system hangs while shutting down, the kernel logs may need to be
+retrieved to debug the issue.
+
+On systems that have a UART available, it is best to configure the kernel to use
+this UART for kernel console output.
+
+If a UART isn't available, the ``pstore`` subsystem provides a mechanism to
+persist this data across a system reset, allowing it to be retrieved on the next
+boot.
+
+Kernel Configuration
+====================
+To enable ``pstore`` and enable saving kernel ring buffer logs, set the
+following kernel configuration options:
+
+* ``CONFIG_PSTORE=y``
+* ``CONFIG_PSTORE_CONSOLE=y``
+
+Additionally, enable a backend to store the data. Depending upon your platform
+some options include:
+
+* ``CONFIG_EFI_VARS_PSTORE=y``
+* ``CONFIG_PSTORE_RAM=y``
+* ``CONFIG_PSTORE_FIRMWARE=y``
+* ``CONFIG_PSTORE_BLK=y``
+
+Kernel Command-line Parameters
+==============================
+Add these parameters to your kernel command line:
+
+* ``printk.always_kmsg_dump=Y``
+	* Forces the kernel to dump the entire message buffer to pstore during
+		shutdown
+* ``efi_pstore.pstore_disable=N``
+	* For EFI-based systems, ensures the EFI backend is active
+
+Userspace Interaction and Log Retrieval
+=======================================
+On the next boot after a hang, pstore logs will be available in the pstore
+filesystem (``/sys/fs/pstore``) and can be retrieved by userspace.
+
+On systemd systems, the ``systemd-pstore`` service will help do the following:
+
+#. Locate pstore data in ``/sys/fs/pstore``
+#. Read and save it to ``/var/lib/systemd/pstore``
+#. Clear pstore data for the next event
-- 
2.43.0


