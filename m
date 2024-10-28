Return-Path: <linux-pm+bounces-16549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F69B22A0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61A71F20C1A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3E16CD35;
	Mon, 28 Oct 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fu++dFLr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1F433C9;
	Mon, 28 Oct 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081629; cv=none; b=PYhNUuALmpXvYC7OE84729Ctglz2XoF90mdrYjjXvRs62ByJutLXyZpT5aEAnSzyLgkTfAZnUperI+2/CxYjEWRdO38rNM/Q2GWKYG4YiFIKQ+455NGS19ZSGGY35cJU+kmtJffw9DC8cBlEh7+Pa30GJryCuc5848d1paNIXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081629; c=relaxed/simple;
	bh=RzryBS3fID5qc7n1ivVr7QqgbBsfgbgzendf2Lx790g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRvUX0sd4LrnfUjPH9cGhUcZ/QXtr510LCAljyKX1W3s6Gtto19Yt/8o8QM4qjiXIm76poFxHd/j2xDEIEDk4KK2hy7keITb5Zd7qm3njT1XQE4Hqi9FU0+0e5pWSgqwK/tbMOc8SLgDDaZoN6Fa1X1Hm41bRxTq4f6OhYhTMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fu++dFLr; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=KSdcimq2trn5l0mRol4HQ+OdRXdKfPtZqrz8Yc0nn9Y=; b=fu++dFLr7BD3+YNq
	QQMY2RVYqRoD8zMZrX9S/F1WmwJDPGRpjuAD7qfhqxcQCD6OPc27/U8hgpmxL0rAIlhJQ8F9Z9vlG
	q0bgtNpwx/z+ElH1tqSU6hTvmRVSRU0uYKtE9PP9Z6qeOfJQDHmEzcy2m3SZx4TOXyG++H7utNTGi
	Nrq3XVFEzDIdQuUGtK5596MKTsSZd0yVtvrA+nP+FGAqVRjVt5DghjAZJz2fzZ8FAcf0PGSE++MaF
	TbVXqS94ltDjH7rQoq11l+VXtmpJGMoRrb1tNRaSyZ8B46lu5LEJtVFXznvcmWp5lDw/IMnW6QJPc
	GF80aEgr3eBJF44SSQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5FGL-00DpzR-0K;
	Mon, 28 Oct 2024 02:13:45 +0000
From: linux@treblig.org
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PM / devfreq: Remove unused devm_devfreq_(un)register_notifier
Date: Mon, 28 Oct 2024 02:13:44 +0000
Message-ID: <20241028021344.477984-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

devm_devfreq_register_notifier() and devm_devfreq_unregister_notifier()
have been unused since 2019's
commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers")

Remove them, and the helpers they used.

Note, devm_devfreq_register_notifier() is still used as an example
in Documentation/doc-guide/contributing.rst but that's just
an example of an old doc bug rather than anything about the function
itself.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/devfreq/devfreq.c | 67 ---------------------------------------
 include/linux/devfreq.h   | 23 --------------
 2 files changed, 90 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..6c3b241b4458 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -2224,70 +2224,3 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_unregister_notifier);
-
-struct devfreq_notifier_devres {
-	struct devfreq *devfreq;
-	struct notifier_block *nb;
-	unsigned int list;
-};
-
-static void devm_devfreq_notifier_release(struct device *dev, void *res)
-{
-	struct devfreq_notifier_devres *this = res;
-
-	devfreq_unregister_notifier(this->devfreq, this->nb, this->list);
-}
-
-/**
- * devm_devfreq_register_notifier()
- *	- Resource-managed devfreq_register_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- * @nb:		The notifier block to be unregistered.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
- */
-int devm_devfreq_register_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
-{
-	struct devfreq_notifier_devres *ptr;
-	int ret;
-
-	ptr = devres_alloc(devm_devfreq_notifier_release, sizeof(*ptr),
-				GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	ret = devfreq_register_notifier(devfreq, nb, list);
-	if (ret) {
-		devres_free(ptr);
-		return ret;
-	}
-
-	ptr->devfreq = devfreq;
-	ptr->nb = nb;
-	ptr->list = list;
-	devres_add(dev, ptr);
-
-	return 0;
-}
-EXPORT_SYMBOL(devm_devfreq_register_notifier);
-
-/**
- * devm_devfreq_unregister_notifier()
- *	- Resource-managed devfreq_unregister_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- * @nb:		The notifier block to be unregistered.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
- */
-void devm_devfreq_unregister_notifier(struct device *dev,
-				      struct devfreq *devfreq,
-				      struct notifier_block *nb,
-				      unsigned int list)
-{
-	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
-			       devm_devfreq_dev_match, devfreq));
-}
-EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d312ffbac4dd..ea161657ebc6 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -263,14 +263,6 @@ int devfreq_register_notifier(struct devfreq *devfreq,
 int devfreq_unregister_notifier(struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
-int devm_devfreq_register_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list);
-void devm_devfreq_unregister_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list);
 struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
 struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 				const char *phandle_name, int index);
@@ -420,21 +412,6 @@ static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
 	return 0;
 }
 
-static inline int devm_devfreq_register_notifier(struct device *dev,
-					struct devfreq *devfreq,
-					struct notifier_block *nb,
-					unsigned int list)
-{
-	return 0;
-}
-
-static inline void devm_devfreq_unregister_notifier(struct device *dev,
-					struct devfreq *devfreq,
-					struct notifier_block *nb,
-					unsigned int list)
-{
-}
-
 static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.47.0


