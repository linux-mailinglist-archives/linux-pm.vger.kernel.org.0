Return-Path: <linux-pm+bounces-25757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E55A946B1
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D01894BD7
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE612CDBE;
	Sun, 20 Apr 2025 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EvcCqQI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DC524C
	for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745122769; cv=none; b=Tno3WwQYaro+g9XwTq9oMDmP9o8GnNjVYQSiopquqbcq++0npXIHHuy7bKp7MfGN4ksgvsGLerYN06sZq4jYgcNStp9GctPlwiX8MBOjy7dw22dwvioRl3P/XeyuhsxNvZxqn9Uggg5QqscfnQhohFUaQV8AyHM1uQ4ysUxHkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745122769; c=relaxed/simple;
	bh=oJ4ev4gPfUUpOWJJebFfVVipT76kmtJVhyalc4Dz3Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I6LTgTZbOwO7/+8/R3uLz1W9EkbZFsd7oqjEQ28gdLyLKf1KvE2gftn45AyKDnie7piKHpSEPeQFy0tEzRewtGNVCpGC/28UTADCYqiOjoS3PpKBRegqsvmbtNIpuNmNOx7b87chiCwaFaojIReu2krMhW+B5STl0hnZjvKgMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EvcCqQI4; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=tjvSTKhyna1+OrrF4Lw07G232zTaXzdvfLNs8LBa9kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=EvcCqQI4qnr+MVJAadmvHXSgn7dOBeZ8H8BYgFo/2fLigQ2jYPdZ+0fPyR4x7H3Yg
	 leBAU6bpaPzmrw5p2RhaHB/vLlYHzoeDEL47XEkDzHpqKd8MfrSGie9NAShI+RQv8u
	 OVvdFapuZG5/bw7FxAzf9Z8TibrbldOq2a3GWMlILlaFpAKUa28N36z1MGftZ4B1BC
	 fZRGOVFTLx61dbisRFttDGnNfygP5MeipiIfTazzberrHVC/wtIEfPETHUHvSwC0sr
	 NWAdOmBHtA5bGaQ082xRQqPop8lUobat58sCZATqL/4bCI8tXLHhEcrtY0OzVfb8Mr
	 XlGIoiLIlNpMQ==
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPS id 7E5A527942D6;
	Sun, 20 Apr 2025 04:19:26 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 7247927942B8;
	Sun, 20 Apr 2025 04:19:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Apr 2025 12:19:09 +0800
Subject: [PATCH v2] PM: wakeup: Do not expose 4 device wakeup source APIs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-fix_power-v2-1-9b938d2283aa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALx1BGgC/22MwQ7CIBBEf6XZsxigoMaT/2EaY5at3YOlBUVNw
 7+79mzm9GYmb4FMiSnDsVkgUeHMcRSwmwZwuI43UhyEwWrrtbNa9fy+TPFFSQWv97uWHB6sAfl
 PiWRcXedOeOD8iOmzqov5tf8sxSiJ8w57E9C37jQ/GXnELcY7dLXWLySEiIykAAAA
X-Change-ID: 20250420-fix_power-d50763e4c821
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: OdVoQQbM0ELLh_n_LQsqqNTuL6CvSKXC
X-Proofpoint-ORIG-GUID: OdVoQQbM0ELLh_n_LQsqqNTuL6CvSKXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504200033
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following 4 APIs are only used by drivers/base/power/wakeup.c
internally.

- wakeup_source_create()
- wakeup_source_destroy()
- wakeup_source_add()
- wakeup_source_remove()

Do not expose them by making them as static functions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove 3 more APIs, correct tile and commit message.
- Link to v1: https://lore.kernel.org/r/20250420-fix_power-v1-1-1454cf1dc534@quicinc.com
---
 drivers/base/power/wakeup.c | 12 ++++--------
 include/linux/pm_wakeup.h   | 15 ---------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 63bf914a4d4467dcf6c42e50951b91677fb9c46d..27505dea7c1b454e7f124637af1834f558e0d022 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -77,7 +77,7 @@ static DEFINE_IDA(wakeup_ida);
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
  */
-struct wakeup_source *wakeup_source_create(const char *name)
+static struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
 	const char *ws_name;
@@ -106,7 +106,6 @@ struct wakeup_source *wakeup_source_create(const char *name)
 err_ws:
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(wakeup_source_create);
 
 /*
  * Record wakeup_source statistics being deleted into a dummy wakeup_source.
@@ -149,7 +148,7 @@ static void wakeup_source_free(struct wakeup_source *ws)
  *
  * Use only for wakeup source objects created with wakeup_source_create().
  */
-void wakeup_source_destroy(struct wakeup_source *ws)
+static void wakeup_source_destroy(struct wakeup_source *ws)
 {
 	if (!ws)
 		return;
@@ -158,13 +157,12 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 	wakeup_source_record(ws);
 	wakeup_source_free(ws);
 }
-EXPORT_SYMBOL_GPL(wakeup_source_destroy);
 
 /**
  * wakeup_source_add - Add given object to the list of wakeup sources.
  * @ws: Wakeup source object to add to the list.
  */
-void wakeup_source_add(struct wakeup_source *ws)
+static void wakeup_source_add(struct wakeup_source *ws)
 {
 	unsigned long flags;
 
@@ -179,13 +177,12 @@ void wakeup_source_add(struct wakeup_source *ws)
 	list_add_rcu(&ws->entry, &wakeup_sources);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 }
-EXPORT_SYMBOL_GPL(wakeup_source_add);
 
 /**
  * wakeup_source_remove - Remove given object from the wakeup sources list.
  * @ws: Wakeup source object to remove from the list.
  */
-void wakeup_source_remove(struct wakeup_source *ws)
+static void wakeup_source_remove(struct wakeup_source *ws)
 {
 	unsigned long flags;
 
@@ -204,7 +201,6 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	 */
 	ws->timer.function = NULL;
 }
-EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 51e0e8dd5f9e50d928db6efa2e3232a117d7e012..c838b4a30f876ef5a66972d16f461cfba9ff2814 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -95,10 +95,6 @@ static inline void device_set_wakeup_path(struct device *dev)
 }
 
 /* drivers/base/power/wakeup.c */
-extern struct wakeup_source *wakeup_source_create(const char *name);
-extern void wakeup_source_destroy(struct wakeup_source *ws);
-extern void wakeup_source_add(struct wakeup_source *ws);
-extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
 						    const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
@@ -129,17 +125,6 @@ static inline bool device_can_wakeup(struct device *dev)
 	return dev->power.can_wakeup;
 }
 
-static inline struct wakeup_source *wakeup_source_create(const char *name)
-{
-	return NULL;
-}
-
-static inline void wakeup_source_destroy(struct wakeup_source *ws) {}
-
-static inline void wakeup_source_add(struct wakeup_source *ws) {}
-
-static inline void wakeup_source_remove(struct wakeup_source *ws) {}
-
 static inline struct wakeup_source *wakeup_source_register(struct device *dev,
 							   const char *name)
 {

---
base-commit: 8117b017f3826b18a426f22de1e001767bc50fd3
change-id: 20250420-fix_power-d50763e4c821

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


