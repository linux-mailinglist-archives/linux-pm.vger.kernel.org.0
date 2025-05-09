Return-Path: <linux-pm+bounces-26929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F015FAB1450
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8DA9E7913
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7B28EA45;
	Fri,  9 May 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="F0doOWJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1482741A8;
	Fri,  9 May 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795853; cv=none; b=MtAarzN9m8IXwgl9/x+2QMqQgZxEeDurAoK3sxWFI7ZIgjolYWxHcnFvNrfcbEgbH6wEhLfDuzdQlUzozGY3nxTQAzmUxoRim8ZDX3rdNPbGX9qpJd9SlkIfc8+uQZ5iqbXZYElwi3o5W1iHng2fujGeatvV0nhoHaYn2aQODr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795853; c=relaxed/simple;
	bh=n3GbyjqvH6eUEQXmvL7MngGXNkXMiP0nukbieFj06og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdoItQ1R9k7F7HNVQX6kN28GIAE52p5XSSlx/h+QCSuJvsLurfo9CN+FN0CvsgKlZ35COM8GJieIfW7jircgIaWWvEN7TgOMSO6qVXHJpFb8jZQStOi2Y+/JdijlyC+IxMKX2tZA23DejauEAVJyGz5ivCIkxjBybUxUa9/CbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=F0doOWJy; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7A975666CB1;
	Fri,  9 May 2025 15:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746795842;
	bh=n3GbyjqvH6eUEQXmvL7MngGXNkXMiP0nukbieFj06og=;
	h=From:Subject:Date;
	b=F0doOWJydsKRkr6eqs4z5XmMlJLAj/UBisjjuoDhetgXyooixdhHLsqXgrZ11IBQj
	 wHwToovqunsnDJR1iFfYSetcJ+vt46QHyfeq1YvKlQrbYJtvdNKOoLM29IyQVM5cGH
	 IuBmxjAkbr3TE2rVhpg3D2MiDaJNwQnL1uhlsaDEQ4ciWZKRICtn+KV0qIwTceP0i+
	 2VjbZbIeSD/meBIk3NLW8mLtPuyWX5Oz7tWj7C09we9GEoV8kEw4D7+IhNiOWc8PWs
	 CfcnjTj5qj1D75pnv4xJ1cQXmQ/Pg8md1XJNF/qK/NhB8ncfmid6GFc891MV0lwFG0
	 S5TPaPBdQ0TOw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 3/3] PM: sleep: Introduce pm_sleep_transition_in_progress()
Date: Fri, 09 May 2025 15:03:35 +0200
Message-ID: <7820474.EvYhyI6sBW@rjwysocki.net>
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

The "suspend in progress" check in device_wakeup_enable() does not
cover hibernation, but arguably it should do that, so introduce 
pm_sleep_transition_in_progress() covering transitions during both
system suspend and hibernation to use in there and use it also in
pm_debug_messages_should_print().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    2 +-
 include/linux/suspend.h     |    4 ++++
 kernel/power/main.c         |    8 ++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -337,7 +337,7 @@
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;
 
-	if (pm_suspend_in_progress())
+	if (pm_sleep_transition_in_progress())
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
 
 	ws = wakeup_source_register(dev, dev_name(dev));
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -475,6 +475,8 @@
 extern unsigned int lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
 
+extern bool pm_sleep_transition_in_progress(void);
+
 #else /* !CONFIG_PM_SLEEP */
 
 static inline int register_pm_notifier(struct notifier_block *nb)
@@ -503,6 +505,8 @@
 static inline unsigned int lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
 
+static inline bool pm_sleep_transition_in_progress(void) { return false; }
+
 #endif /* !CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -609,12 +609,16 @@
 
 power_attr_ro(pm_wakeup_irq);
 
+bool pm_sleep_transition_in_progress(void)
+{
+	return pm_suspend_in_progress() || hibernation_in_progress();
+}
+
 bool pm_debug_messages_on __read_mostly;
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && (pm_suspend_in_progress() ||
-		hibernation_in_progress());
+	return pm_debug_messages_on && pm_sleep_transition_in_progress();
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 




