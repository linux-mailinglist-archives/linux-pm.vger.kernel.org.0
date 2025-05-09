Return-Path: <linux-pm+bounces-26931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A048AB144D
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FFC50803E
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82429187C;
	Fri,  9 May 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LyJ+D0RW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6826FDB5;
	Fri,  9 May 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795854; cv=none; b=OTH80dLPV8M7eX7VokLk6/AmQt3KAucGx6F5XuW50fDuk0fBori5Ayur7dmg93pGL+Jds1CEo2GCAVvgY0usgLipYK4WakYWyqW1wwGvY83jLHCw5QMZ9IK+y+49Q+o6MjeV6dECoX1KlOtij0EmuWnzoG2mzJ+Olhos8tV6PKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795854; c=relaxed/simple;
	bh=PjBHH2KUqNWE6DEPki8yIeIZxWV/iXhMQDC392jZDRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiGxWtl74TxkddQGvBOrsrQ/iMBD7gvN7Pfl48blTZHDEVEVze1aKYKSlBIaQ3bKnR+2hBvY3sbTHfDGKhYkCCY024apl4ov3+s416pL5RI7YCtCOGubnroEcfovYnmBzFzZOk2z1BZDhW2Tx5hvNKfdif6h9a9U1NG8/fQNybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LyJ+D0RW; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 449E6666CB3;
	Fri,  9 May 2025 15:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746795844;
	bh=PjBHH2KUqNWE6DEPki8yIeIZxWV/iXhMQDC392jZDRI=;
	h=From:Subject:Date;
	b=LyJ+D0RWVM/Tx9n1SifEWTPuaMP4JMRfKr78Ssag1KX2Kxug/ugXc/lF4evnhgehe
	 WJSWSf0r9tvGhchZ8VkO4vdMxClY/2T5c7Sz17VewqJ5V4c2E05dg1uKDFJCiQ2Gwp
	 A2qhOBQjHSBwb6Tis8EqSsWhyMTCujZo3LUqf8zm32M/bKFkSYpJBI2rGf/117DJ5X
	 N+U1pv/zszEAzICI/0vBsJeZumZKC3qnSxVByUu3ORzF0IDsQBZQhihOxQXQIZDP32
	 i3wdHGemtrUE2r7l7Uwg3Ja0XzrIgh+0EbHigwI99kM7zRAFUj2On/rSWFmHy36IXM
	 2/nTlPC04gsfQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 1/3] PM: sleep: Print PM debug messages during hibernation
Date: Fri, 09 May 2025 14:51:47 +0200
Message-ID: <4998903.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <5903743.DvuYhMxLoT@rjwysocki.net>
References: <5903743.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
messages at suspend/resume") caused PM debug messages to only be
printed during system-wide suspend and resume in progress, but it
forgot about hibernation.

Address this by adding a check for hibernation in progress to
pm_debug_messages_should_print().

Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |    5 +++++
 kernel/power/main.c      |    3 ++-
 kernel/power/power.h     |    4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -90,6 +90,11 @@
 	atomic_inc(&hibernate_atomic);
 }
 
+bool hibernation_in_progress(void)
+{
+	return !atomic_read(&hibernate_atomic);
+}
+
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -613,7 +613,8 @@
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
+	return pm_debug_messages_on && (hibernation_in_progress() ||
+		pm_suspend_target_state != PM_SUSPEND_ON);
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -71,10 +71,14 @@
 static inline void enable_restore_image_protection(void) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
+extern bool hibernation_in_progress(void);
+
 #else /* !CONFIG_HIBERNATION */
 
 static inline void hibernate_reserved_size_init(void) {}
 static inline void hibernate_image_size_init(void) {}
+
+static inline bool hibernation_in_progress(void) { return false; }
 #endif /* !CONFIG_HIBERNATION */
 
 #define power_attr(_name) \




