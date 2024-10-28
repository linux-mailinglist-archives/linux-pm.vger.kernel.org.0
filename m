Return-Path: <linux-pm+bounces-16570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13E9B2FE0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8741F2245A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7E1D90D7;
	Mon, 28 Oct 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mvapyRVD"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA601D86E8
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117512; cv=none; b=dOT4EuR98cvFbKkFKTBhagZgOGRX3sY6cvRQQyng2qwhoTW/bdZ5aH86xYfYDace/b+korp5qZJtEwkeBRlLloe0Rdf6gQSaGnC8QGve0xWzXEE1sR7ffFqqwhxpYYioOZOkSxfS/g6RXzYexi7DBj/1AulUqTpEHFhUWKiwOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117512; c=relaxed/simple;
	bh=aqNiouNowU0/nT1bh7e513W9iCoKLbT4s+J+T3hJyBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A7GoDv/gSL1OH4I0MTZm5K9Y0RzngSsdDT62nzDLpGw85Nlsi7RiR+JOMrWxnviNCEqqUIgWWnV52zRby1KdMsDS3UAs/hV2cr6JARWI7RuQ3zYWlmLzEw5QYKU5qmaa8rPo0e8zLuhmjr1eQA2A47LZyOG7Hgw2Px8KJexmpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mvapyRVD; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730117510;
	bh=0g82I+it26+TLuelS001Lia4SSmrgncY6oesFfGXKuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=mvapyRVDc86rAgu7e//VBupiPz0scTPM7T6sCzIXIVyKLeBmgyay458r5yUhAkm24
	 f+h8TzOvQ3xSFz0ROFQtDyVbqNBBH7ztPcR7iSqbQV8/PkuR9sP/SFuSkhCLoEPeFX
	 ZemRgrtgMHCV+7RtiRLNnMACTeARsynBXhPkC0HpNswU/J9NDGBgZuZkR0a1wVm/G2
	 RcfDZxj0yOvyPQGSqJIq17rwQmnWOjXnXfaiPXAQRiadBJ0j7J413G4/G0pFsV+wlk
	 K3KkStN5NstuO4kzphHqIAksDosOn/JmeC+vNGNpOXHJnyo3BPs91Ry68NSRP9xV4C
	 Bqm8Uy47mzN8Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 3F7D66801FE;
	Mon, 28 Oct 2024 12:11:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 28 Oct 2024 20:11:11 +0800
Subject: [PATCH] driver core: Put device attribute @wakeup_last_time_ms and
 its show() together
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fix_power_sysfs-v1-1-7b2fbeb14d47@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF5/H2cC/x2MSQqAMAwAvyI5W9AoiH5FpJSaai4qCbgg/bvB4
 8DMvKAkTApD8YLQycr7ZlCXBcQ1bAs5no0BK2yrHhuX+PbHfpF4fTSpo6ZGRGpj6BCsOoRM+Y/
 jlPMHp94XHWEAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: Y2Lp68-d1v-FrdBTADXErByWHl2nHnZY
X-Proofpoint-GUID: Y2Lp68-d1v-FrdBTADXErByWHl2nHnZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410280098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Move location of dpm_sysfs_wakeup_change_owner() a bit to

- Put device attribute @wakeup_last_time_ms and its show() together.
- Put two different instances of dpm_sysfs_wakeup_change_owner() together.

That will make better code layout.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/power/sysfs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..f8163b559bf9 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -509,14 +509,6 @@ static ssize_t wakeup_last_time_ms_show(struct device *dev,
 	return sysfs_emit(buf, "%lld\n", msec);
 }
 
-static inline int dpm_sysfs_wakeup_change_owner(struct device *dev, kuid_t kuid,
-						kgid_t kgid)
-{
-	if (dev->power.wakeup && dev->power.wakeup->dev)
-		return device_change_owner(dev->power.wakeup->dev, kuid, kgid);
-	return 0;
-}
-
 static DEVICE_ATTR_RO(wakeup_last_time_ms);
 
 #ifdef CONFIG_PM_AUTOSLEEP
@@ -541,6 +533,15 @@ static ssize_t wakeup_prevent_sleep_time_ms_show(struct device *dev,
 
 static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
 #endif /* CONFIG_PM_AUTOSLEEP */
+
+static inline int dpm_sysfs_wakeup_change_owner(struct device *dev, kuid_t kuid,
+						kgid_t kgid)
+{
+	if (dev->power.wakeup && dev->power.wakeup->dev)
+		return device_change_owner(dev->power.wakeup->dev, kuid, kgid);
+	return 0;
+}
+
 #else /* CONFIG_PM_SLEEP */
 static inline int dpm_sysfs_wakeup_change_owner(struct device *dev, kuid_t kuid,
 						kgid_t kgid)

---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20240923-fix_power_sysfs-e31222e4ca72

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


