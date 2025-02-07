Return-Path: <linux-pm+bounces-21534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA6A2C30A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 13:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC38E188A999
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEC71E5B71;
	Fri,  7 Feb 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iNLakeYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0E1E5B6C;
	Fri,  7 Feb 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932527; cv=none; b=AI+0DhA4WjSXbpPUjqXcb2eWWcRZxwqAc/mB6fvEQsw+yRpxyeOCRR5+u1B8N9qzN4fKV0B/X/52a5HemM6Hyud2UBwUFP0FRvCRfo1RSa3VAtZGmn9IdhmVB+LCwxLoFF8XwhTs5HO9Bqp1gDqlmf4ThFaSC7PZzFAEdSDW4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932527; c=relaxed/simple;
	bh=B583Jt+dZN0idFwnznXbNLEdBMPIyxuJIgGbaof1NUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LSxGFMxjQcxhwvOeDlpIZxjRO0N259489vH3/SYzwJRMTEHPH6Tjhy8sUHYlc1ybkJp086I/5mm9V86D8HZkWLXscxd/2tXRxKe+1NphLPiDt61KH/9ojLEsiHuQ7g2U7jeFKV7MfyT/qyhu4mA1FtAj7aaKeQ3+bqkEyD7Tm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iNLakeYL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 120da5e98b0c8ecc; Fri, 7 Feb 2025 13:48:41 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CF36C6BAA02;
	Fri,  7 Feb 2025 13:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738932521;
	bh=B583Jt+dZN0idFwnznXbNLEdBMPIyxuJIgGbaof1NUQ=;
	h=From:Subject:Date;
	b=iNLakeYLi+BrC5iPPaK53O9ZiJkiYEIu4KKa6Fad8zSOv7dpbXcLofQvJlUBVl5jg
	 iy+ZO9AxrSJ7Av2qQjde30MAUWUUQ8ARufDIjtFQS9HdM+kRNYHnixZ5QGUD1UZkBw
	 ZOv/7NYzfZ8zQ+lP7NiFtcDPOOjJFrD9lX32ZButH3+bgdHRFZNCIuoeilxE+wOIMD
	 LEr85K4qxNpgFVxNZzqmmy15awR/nwcCBN0o4mBo9ujXfmkj8UyqX76LQqStuO5nF+
	 3CMZ+ZVaEsHtjySxNVAQIE4BWt+i4NxuhgyjPBQtrugoXpfH9EBSNIKLz5ox+D3Y08
	 TNlKOW6HQtGXw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Relocate platform preference check
Date: Fri, 07 Feb 2025 13:48:40 +0100
Message-ID: <2776745.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the invocation of intel_pstate_platform_pwr_mgmt_exists() before
checking whether or not HWP is enabled because it does not depend on
any code running before it except for the vendor check and if CPU
performance scaling is going to be carried out by the platform, all of
the code that runs before that function (again, except for the vendor
check) is redundant.

This is not expected to alter any functionality except for the ordering
of messages printed by intel_pstate_init() when it is going to return an
error before attempting to register the driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3688,6 +3688,15 @@
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return -ENODEV;
 
+	/*
+	 * The Intel pstate driver will be ignored if the platform
+	 * firmware has its own power management modes.
+	 */
+	if (intel_pstate_platform_pwr_mgmt_exists()) {
+		pr_info("P-states controlled by the platform\n");
+		return -ENODEV;
+	}
+
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
 		hwp_forced = intel_pstate_hwp_is_enabled();
@@ -3743,15 +3752,6 @@
 		default_driver = &intel_cpufreq;
 
 hwp_cpu_matched:
-	/*
-	 * The Intel pstate driver will be ignored if the platform
-	 * firmware has its own power management modes.
-	 */
-	if (intel_pstate_platform_pwr_mgmt_exists()) {
-		pr_info("P-states controlled by the platform\n");
-		return -ENODEV;
-	}
-
 	if (!hwp_active && hwp_only)
 		return -ENOTSUPP;
 




