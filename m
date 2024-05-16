Return-Path: <linux-pm+bounces-7907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628098C74A3
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A68A28516F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749A14389A;
	Thu, 16 May 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p7GQIrVf"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59A143866;
	Thu, 16 May 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855344; cv=none; b=qJZpvFPNRYh3TLvwyCdnZCyooyN4SjGFP3CadvlhDp78l3MQTdiBH3d2Gtv+tpCKpjImcMkw5ZxsmSMwsEQEaaYg/La24UzF7qsGjtfkBfPQcXV1JvdOdhdOT1bswP2baw4+js2Kz9fZIkmWjlGG6GBa5LCZp3qvxkwhkdHp00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855344; c=relaxed/simple;
	bh=rhWKU/w9EhYtdGU3yXEB9F2o1FFwvXQv9QHzvfSeWm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T95Mkz0psLIJ+91lv/Y9zPy6DkewsfdpXHid1QOmEpl1x9pzBrslQ5eXtyvXvk1FGsPj0lVWbbHUBJ2QmfJU1J7tBBHEA+VPmd9C4YwRmJE218Tzp4BYa4UFX0kXyLGfPaXApzSaa4WtyGmSEZrReo9J+/vo6qPsyIyylU3TIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p7GQIrVf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715855331;
	bh=rhWKU/w9EhYtdGU3yXEB9F2o1FFwvXQv9QHzvfSeWm8=;
	h=From:Date:Subject:To:Cc:From;
	b=p7GQIrVfXT/4YTBAILCAbJv/R+06z/uETHEniJwvS7mLHUItHoFambXxhAba5qizg
	 xk+TWh4InQukHD6QBu5u7NrFL4jIqsSrgPdjIE6gJxXXzUTcFX1FN1y/4BdWu29Z3z
	 mYIhUHIolrhGgUxd8crwlUslX0zO1c/xRRRsUDbQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 May 2024 12:27:58 +0200
Subject: [PATCH RFC] kobject_uevent: notify uevent sysfs file on changes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240516-uevent-sysfs-notify-v1-1-2ebb39930c09@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAK3fRWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0NT3dLUstS8Et3iyuK0Yt28/JLMtEpdk9Qky1RLU2NL87QUJaDOgqL
 UtMwKsKnRSkFuzkqxtbUANjsAumoAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715855331; l=1997;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rhWKU/w9EhYtdGU3yXEB9F2o1FFwvXQv9QHzvfSeWm8=;
 b=LTz1bpDcGQFHz/mOSRq2nXcpsX6XtUet8VwgBaPFE6QIY63XT4/pGmiPw57GoK7UVOIgNNEjN
 qGdjFBZrdOIBOQnLeg6GhMtSOIBtuPmVC2ubITEfRPV1HGf6XVM0hbp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs file "uevent" that exists for each device
contains the same information that is attached to uevents emitted via
netlink (or the usermode helper).
This is useful for userspace which interacts with sysfs directly,
without using (lib)udev.

However it is not possible to actually get notified when the data in
the "uevent" file changes.

Enable these notifications, so that the "uevent" file can be used
together with inotify and friends.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
My original usecase is to get updates for power supplies.
Current charge status and similar.
All this data is exposed via "uevent", and on updates an KOBJ_CHANGED
event is emitted.

To me, a general solution covering all devices looked the best.

Open questions for the RFC:
* Is this a good idea?
* How to handle other actions?
  _ADD and _REMOVE should not call sysfs_notify() in any case, these
  cases can be detected otherwise.
---
 lib/kobject_uevent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 03b427e2707e..74047a79cb13 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -24,6 +24,7 @@
 #include <linux/netlink.h>
 #include <linux/uidgid.h>
 #include <linux/uuid.h>
+#include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -593,6 +594,9 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	retval = kobject_uevent_net_broadcast(kobj, env, action_string,
 					      devpath);
 
+	if (action == KOBJ_CHANGE)
+		sysfs_notify(kobj, NULL, "uevent");
+
 #ifdef CONFIG_UEVENT_HELPER
 	/* call uevent_helper, usually only enabled during early boot */
 	if (uevent_helper[0] && !kobj_usermode_filter(kobj)) {

---
base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
change-id: 20240515-uevent-sysfs-notify-4eb9e95397fd

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


