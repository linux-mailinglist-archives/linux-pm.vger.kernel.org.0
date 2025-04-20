Return-Path: <linux-pm+bounces-25756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7900DA9468B
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 05:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956C317518A
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 03:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30D29CE1;
	Sun, 20 Apr 2025 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TGHhw4yf"
X-Original-To: linux-pm@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster6-host1-snip4-10.eps.apple.com [57.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAB200CB
	for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745119103; cv=none; b=FN6b7JiQ5+Ilv6+nydV0nssB4ZNYO4JMij1CzyzZp0Wxl4LzCm6weV8s3S4iB2g9ygEwIni+jgW8GlL88JSNLUHZqS8K8Jvp0kWxBxO/WpWZmP14vIvVydxb37l255KWSq7s8KBPm0BQp6sgKIMrdfghQLv5D+XUeJO7y2Hf4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745119103; c=relaxed/simple;
	bh=czmOxfiQ7Tu/mSdpKDOKMa5nbv+44cvPUlogRQdlUuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EigWr+m22M+M+TzRASzv3JelVHA4DuiaUmEjdT3+sO6K3OB3Ud3EI7jPwwoe6HRkIYxT24FppEYOjoHkQApUQAz4MWTUgwN4r/JazrnV6LLER/6wFgNmXUwXLheZOn2uCEONLlL5QVZmpT3oxz/hIsKfz+q+1nGCEGUuUUmBsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TGHhw4yf; arc=none smtp.client-ip=57.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=zP8gRbrasrVuhIXn2PxV4CCw/YI6If8H1SVTepBuvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=TGHhw4yf3ZM/2/aDQAwdy1eVAFqkmt6yqVgOzRxxm8aTWuSCRJIADYbhiupP3hMi+
	 mJJOrJbs8f/QT+G4HSpQJr+HgGWOC2+yB1O3TQABWIkMVSe+EhhreorKGAAcvHtiBi
	 ixsetfud6OZ8vDV5qu9JvCcp0SIygq4rnBC9k6JFliaSNe+PspF3g0rDqKKOjKpcNt
	 K7aimz4+zXYqzKtGQ2zTVN0sTyrIBMix8Jb1t9VnGq7KxCsak3OfkixEjmO05ePWjV
	 YwtEi1te1KV8Wo3rtTqMPFL9Yw5uymQGjwjY8h5d69kjFzOnjT4JUo5hoAJAkYoVh4
	 bjSYYGtELS9Lw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id C7F401800259;
	Sun, 20 Apr 2025 03:18:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Apr 2025 11:17:50 +0800
Subject: [PATCH] PM: wakeup: Do not expose wakeup_source_create()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-fix_power-v1-1-1454cf1dc534@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF1nBGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMD3bTMiviC/PLUIt0UUwNzM+NUk2QLI0MloPqColSgJNis6NjaWgB
 ZSxQfWwAAAA==
X-Change-ID: 20250420-fix_power-d50763e4c821
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: xKijEZKSrRiE0ugYtaaETNz0Z1fNrhVM
X-Proofpoint-ORIG-GUID: xKijEZKSrRiE0ugYtaaETNz0Z1fNrhVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504200026

From: Zijun Hu <quic_zijuhu@quicinc.com>

wakeup_source_create() is only used by drivers/base/power/wakeup.c
internally.

Do not expose it by making it as static function as its counterpart
wakeup_source_free() does.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/power/wakeup.c | 3 +--
 include/linux/pm_wakeup.h   | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 63bf914a4d4467dcf6c42e50951b91677fb9c46d..bb311c02f5a4754beb1c3d97e61f36d50d474e23 100644
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
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 51e0e8dd5f9e50d928db6efa2e3232a117d7e012..6689e73a3a2d249a6eb3517b0597e737b01248bb 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -95,7 +95,6 @@ static inline void device_set_wakeup_path(struct device *dev)
 }
 
 /* drivers/base/power/wakeup.c */
-extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
@@ -129,11 +128,6 @@ static inline bool device_can_wakeup(struct device *dev)
 	return dev->power.can_wakeup;
 }
 
-static inline struct wakeup_source *wakeup_source_create(const char *name)
-{
-	return NULL;
-}
-
 static inline void wakeup_source_destroy(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_add(struct wakeup_source *ws) {}

---
base-commit: 8117b017f3826b18a426f22de1e001767bc50fd3
change-id: 20250420-fix_power-d50763e4c821

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


