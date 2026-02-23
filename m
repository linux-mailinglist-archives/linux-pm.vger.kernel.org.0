Return-Path: <linux-pm+bounces-43003-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEKLAm0DnGkn/AMAu9opvQ
	(envelope-from <linux-pm+bounces-43003-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:36:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1D172C03
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D1A30474E8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11AF4F1;
	Mon, 23 Feb 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NnoME9xj"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01325393B
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832002; cv=none; b=mSvUMKPBf39NK1PcC9znOZ9EGFa7d6rGy6hMi3lV1VvYlecD/BMxgFGZKZQwWNOOmxDVNJ3AoF5Z4cTpWTiZOkTTI3KpdJbidQo3ncrGVUxid5uyPAeN5+5HtIY6OeYGg87A2Ow2RIAyD4I0JxM1LK0xjqdTsFIj192//sQ2YkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832002; c=relaxed/simple;
	bh=7/2HPigpGCQO2AqJXDDdenp9sZBWQNqsF/KbidOOWH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKPhGLzA/CGNhEU0qNrP5+NsxpGbYx1+U9HEMssKhIQpLjuS/mHZ9NyQdNbtOFuPCrx96y5q5rzYWCKTBi9rQRM0/enWOFFTCwceB5rKoX3KvgdyQfQ8TugJWFZ+6pLTNhQ8hOYWOkXPTc7hyfc8doMK1o0cc72kMtPl9H+gYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NnoME9xj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771831989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dsdJ0mPdCvq93RkvuKqz6BdF4skOlq2L4R6MFvOvoQU=;
	b=NnoME9xj/rG7s6s809ik7qfLyQQFkOK+dkItX805dGyzZgQKfXsDYocvr8CjiVi0uWPcjl
	FRp2fUv24lQiMg2VuiPgasoo5Z+x2LmGC/ncJfe1oo1VZgoGV/nfemnuUjVLFJ9ai7zAVH
	e8lV8LAVdhbzQ33xaWqhB747O6zv5fc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: core: Replace sprintf in thermal_bind_cdev_to_trip
Date: Mon, 23 Feb 2026 08:32:45 +0100
Message-ID: <20260223073245.321298-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43003-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ED1D172C03
X-Rspamd-Action: no action

Replace unbounded sprintf() with the safer snprintf(). While the
current code works correctly, snprintf() is safer and follows secure
coding best practices.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643..89dd1666805f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -861,7 +861,7 @@ static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		goto free_mem;
 
 	dev->id = result;
-	sprintf(dev->name, "cdev%d", dev->id);
+	snprintf(dev->name, sizeof(dev->name), "cdev%d", dev->id);
 	result =
 	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
 	if (result)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


