Return-Path: <linux-pm+bounces-43394-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLG/L69tpWlXAgYAu9opvQ
	(envelope-from <linux-pm+bounces-43394-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 11:59:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15C1D7148
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05077301014F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E333DEE2;
	Mon,  2 Mar 2026 10:55:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96430FC39;
	Mon,  2 Mar 2026 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448913; cv=none; b=JxBIlh2Hh0i4cOuJbkl28u3HlYrR6CRmlN3zD1PVo2GFbJ+upUBuFcXHPjWKIIxBrHiQlv/GWhtzqmXQiY0DZ3idDwnKGeU/BaZGYqayfBenpYNXwGbNy9xqDd1BkM4EVmNDesi3vIuS86QkJMyhRrdm8PA76Wi7rDEkqIZ06fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448913; c=relaxed/simple;
	bh=ddqXMSFfud6XjB/FC/89ZuiA6zllHaYaucxU2fBI2fw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u881IqcFkOuGy4xdQhtoKecyHZCVqCW2N8eAPfYuMkLdBcJgdDFwX9bzs8yC9TShCuD8Eb5fi1JD01UJSDiXHqmZk1ZG2zcDc7aPbxdtuqNbwuVNuqsF1Nvi9QTwREZfC2yexPj9b9SYRLYR5b8/H6tNCtROmlwgde004ayy5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABnTOOHbKVpc0euCQ--.9165S2;
	Mon, 02 Mar 2026 18:55:05 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
Date: Mon,  2 Mar 2026 10:54:56 +0000
Message-Id: <20260302105456.4134882-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnTOOHbKVpc0euCQ--.9165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13ZF1UAw17KFWkZw1rtFb_yoW8uF47pa
	n8Gay5Cay8Xr4IgFWjva1kCFy5ZayfA3s3JFyUC3sY9anIq395tFy5tFWYy345JrW8uF4I
	vFy7try8u3ZrCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0iiSUUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43394-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.873];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isrc.iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 1F15C1D7148
X-Rspamd-Action: no action

The helper function to_device() is used to convert a list_head structure
(specifically from dev->power.entry) back to the corresponding struct
device. Currently, this function is only available when CONFIG_PM_SLEEP
is enabled. However, some generic power management code may need to iterate
through the device list even if sleep states (suspend/hibernate) are not
supported.

There are currently two approaches for moving the function.The first one:
judging from the current conditions where the function is called, all calls
are not wrapped by any macros, so it is appropriate to move the function
definition to the global scope.The second one: if the compilation of the
files where the function is called is controlled by CONFIG_PM, it is more
appropriate to move the function definition into CONFIG_PM.

To ensure that the availability of the function is consistent with its
usage scenarios and to avoid undefined reference compilation errors, the
first approach is adopted.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
 drivers/base/power/power.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 922ed457d..0a40bb546 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -106,10 +106,6 @@ extern int pm_async_enabled;
 /* drivers/base/power/main.c */
 extern struct list_head dpm_list;	/* The active device list */
 
-static inline struct device *to_device(struct list_head *entry)
-{
-	return container_of(entry, struct device, power.entry);
-}
 
 extern void device_pm_sleep_init(struct device *dev);
 extern void device_pm_add(struct device *);
@@ -162,6 +158,11 @@ static inline int pm_wakeup_source_sysfs_add(struct device *parent)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+static inline struct device *to_device(struct list_head *entry)
+{
+	return container_of(entry, struct device, power.entry);
+}
+
 static inline void device_pm_init(struct device *dev)
 {
 	device_pm_init_common(dev);
-- 
2.25.1


