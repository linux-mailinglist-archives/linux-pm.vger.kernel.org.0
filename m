Return-Path: <linux-pm+bounces-26814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57938AAE307
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E051B65F40
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439152557C;
	Wed,  7 May 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JPwArid2"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33814A639;
	Wed,  7 May 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628183; cv=none; b=fyC/oN11LsmG1cfC30egdyddTiY2ahhLZ9pSlvbUyKMCEEui76pvGopsakWCk1PpdDf/y3sY/61cF0HO43no4JV0BzsqAI3w+2JFiq3RFhrRFR0sLy8dzc6MRUtuZX86bfsGgby7XqctzN1HUeWTi8IaTDdtTtrESZ08GKVhYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628183; c=relaxed/simple;
	bh=qV67xcZDnHQZLIjNU7yeKGdQ/jmo1KGT42yGz0krJWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdSvuD+WLpNzLCU9FAtnlKYhan31JGZO4D/jDs7Ft8MVSEOrXf1d4gXmgf03X3IMxm0XcXalGHuwz/FjGPoy+GudAbbXW52cwzEGj3nPpAgJE3qf7siV45hPo1RMKL3bfw8q7Tx4CpkRJn/e30b3uz/idMD9TxJ2RsApnbN2cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JPwArid2; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BBDA7666AF2;
	Wed,  7 May 2025 16:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746628178;
	bh=qV67xcZDnHQZLIjNU7yeKGdQ/jmo1KGT42yGz0krJWg=;
	h=From:Subject:Date;
	b=JPwArid2VK9otRhQdqUNCwYdKod1LVy6MchXyAtP8jVywGt6DI09tKvGz2BKWnkVn
	 aSewvZHM6UUWan75BKg4quCvBZqdOh9/JCPdG0G3368i7QWPPAkgPwfUdttS55kqfa
	 SykIurKh3o6pLC+GfI4pLkbzJctdnCD6GePZrGdxybuMdHpJ22DF2qCjE6dPEbgakI
	 xx7RqrxtN74pT8Aa3cqxAAjLV+wTSjb2Ds38T9JciVmV5TMROPjkwgP3vcw3+gjlT/
	 WPMZM7LHcRaaMMnoJ20FAAmV1+aC+wVDIpPerUcbh7mjUoqnVw88AgeaDM7rBFbLMh
	 ka4yl8AhFq/Jg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1] PM: sysfs: Move debug runtime PM attributes to runtime_attrs[]
Date: Wed, 07 May 2025 16:29:37 +0200
Message-ID: <12677254.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some of the debug sysfs attributes for runtime PM are located
in the power_attrs[] table, so they are exposed even in the
pm_runtime_has_no_callbacks() case, unlike the other non-debug
sysfs attributes for runtime PM, which may be confusing.

Moreover, dev_attr_runtime_status.attr appears in two
places, which effectively causes it to be always exposed if
CONFIG_PM_ADVANCED_DEBUG is set, but otherwise it is exposed
only when pm_runtime_has_no_callbacks() returns 'false'.

Address this by putting all sysfs attributes for runtime PM into
runtime_attrs[].

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/sysfs.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -611,15 +611,9 @@
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
 static struct attribute *power_attrs[] = {
-#ifdef CONFIG_PM_ADVANCED_DEBUG
-#ifdef CONFIG_PM_SLEEP
+#if defined(CONFIG_PM_ADVANCED_DEBUG) && defined(CONFIG_PM_SLEEP)
 	&dev_attr_async.attr,
 #endif
-	&dev_attr_runtime_status.attr,
-	&dev_attr_runtime_usage.attr,
-	&dev_attr_runtime_active_kids.attr,
-	&dev_attr_runtime_enabled.attr,
-#endif /* CONFIG_PM_ADVANCED_DEBUG */
 	NULL,
 };
 static const struct attribute_group pm_attr_group = {
@@ -650,13 +644,16 @@
 };
 
 static struct attribute *runtime_attrs[] = {
-#ifndef CONFIG_PM_ADVANCED_DEBUG
 	&dev_attr_runtime_status.attr,
-#endif
 	&dev_attr_control.attr,
 	&dev_attr_runtime_suspended_time.attr,
 	&dev_attr_runtime_active_time.attr,
 	&dev_attr_autosuspend_delay_ms.attr,
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+	&dev_attr_runtime_usage.attr,
+	&dev_attr_runtime_active_kids.attr,
+	&dev_attr_runtime_enabled.attr,
+#endif
 	NULL,
 };
 static const struct attribute_group pm_runtime_attr_group = {




