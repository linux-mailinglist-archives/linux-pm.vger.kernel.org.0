Return-Path: <linux-pm+bounces-16171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AA9A94FD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 02:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CF1C2130D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5E3FE55;
	Tue, 22 Oct 2024 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fVd6fasF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CD4A35;
	Tue, 22 Oct 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557125; cv=none; b=KzPWXQdFzQ912gMn62Fv3fgHkeJqyhgRTvRweizCki6ngUNg7/T0/4UIYR7LuFjjc46GDcjoIZFQPZ+dFFu+XKxxC8efGHbW2dls2Hq8jM4BUONkMp1aO97eEyFWhutT3gOQmHxvxMgxJ7qwZ14KiV+RziIvQTpo6gxGFITy3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557125; c=relaxed/simple;
	bh=7e6oi+4Fq3PcPFF3r7xJtORu0Ad5MBHJhdXSLyVy6Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqm6+eBGY4J7PD9FqFf5DnYNLY1scNhg1vZZSB549u/PEr4c0J5rV1AnFw0U3PXMgeccFvOwMp0F3df/XxYZLqC80ef9VhFskFx/GmJrnI/1/uVpzhUXz2cus2Aa1R9pDipJ6pop70retidw6bTaduBSqCLgqmH59YJkZddA11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fVd6fasF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jnHB6wnemLTKkfvg62yRFpueveUHz35ihltSxHEOOyg=; b=fVd6fasFy6Fza6By
	alkxdQnEc1NSqn+jhdd0/aY0zhK+sFrCxAin55xwCTAJ1v6JQzgtYvqewAQrmY8ZauaEiLPjQzrj0
	zn7RRyLZwnBv9WcJd+Xjd8ScXCiyP9PIMZvmpnJCnutCmwQ2va5kr2xknMiwkA/U6kkMvxCi3q5di
	OZTo1McwkXoFfsstmrHbWiR144PMy/VtX/ZqYcW3q7lv/WLufKkslcDFE3BQnMlJgL/TZ0ULMnrit
	RnK2g2NMxPuEuEX9+162jtcnf36IgkTM0Fh/49Oh9e3+EpX6pogD0AMHiTuU8Rw/mEFCuB3dcSS0p
	2hPjzGHOTf9Pvz9oOQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t32oY-00CeTr-19;
	Tue, 22 Oct 2024 00:31:58 +0000
From: linux@treblig.org
To: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PM / devfreq: Remove unused devfreq_event_reset_event
Date: Tue, 22 Oct 2024 01:31:57 +0100
Message-ID: <20241022003157.303127-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

devfreq_event_reset_event() was added in 2015 by
commit f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")

but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/devfreq/devfreq-event.c | 26 --------------------------
 include/linux/devfreq-event.h   |  6 ------
 2 files changed, 32 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 3ebac2496679..a60703374006 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -183,32 +183,6 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
 }
 EXPORT_SYMBOL_GPL(devfreq_event_get_event);
 
-/**
- * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
- * @edev	: the devfreq-event device
- *
- * Note that this function stop all operations of devfreq-event dev and reset
- * the current event data to make the devfreq-event device into initial state.
- */
-int devfreq_event_reset_event(struct devfreq_event_dev *edev)
-{
-	int ret = 0;
-
-	if (!edev || !edev->desc)
-		return -EINVAL;
-
-	if (!devfreq_event_is_enabled(edev))
-		return -EPERM;
-
-	mutex_lock(&edev->lock);
-	if (edev->desc->ops && edev->desc->ops->reset)
-		ret = edev->desc->ops->reset(edev);
-	mutex_unlock(&edev->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
-
 /**
  * devfreq_event_get_edev_by_phandle() - Get the devfreq-event dev from
  *					 devicetree.
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4a50a5c71a5f..461080280de9 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -104,7 +104,6 @@ extern bool devfreq_event_is_enabled(struct devfreq_event_dev *edev);
 extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
 extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
 				struct devfreq_event_data *edata);
-extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
 extern struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
 				struct device *dev,
 				const char *phandle_name,
@@ -149,11 +148,6 @@ static inline int devfreq_event_get_event(struct devfreq_event_dev *edev,
 	return -EINVAL;
 }
 
-static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
-{
-	return -EINVAL;
-}
-
 static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
 					struct device *dev,
 					const char *phandle_name,
-- 
2.47.0


