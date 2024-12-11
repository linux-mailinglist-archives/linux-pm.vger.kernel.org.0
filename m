Return-Path: <linux-pm+bounces-18980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336519EC312
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 04:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A17F166837
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760020C025;
	Wed, 11 Dec 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bjDDTZVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C79F9E6;
	Wed, 11 Dec 2024 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887127; cv=none; b=sDm/CBdbUJYxPRDvld2pEfaM/z2odRu6WVExMccl6o2WXCJN1geouigBw0TAYCKBTU3B2syhCLhvZ5IZlWnPE6zLzS70r8Szv4yxow48xH+jddn02QLQGnPGk1BuwQTrNChK8KdG2a2f2BLHQiWRENbu0AGFm3cy3/4IKX+4vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887127; c=relaxed/simple;
	bh=XWda4h/btwJ1DODEtfN5zffH7Qs4btUKqnrT1HRzVUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRLokx6cpi517oD9F+ebECEHkkhWTQeK+5ZbZNi0OIGgzjEGFh/zgjJJlO7Gltupg4jQAl/4jGMosd5q3OtxIRK1CwkxWaKTVHeOmLra54Lead0QHeZDM3T2PgksgZytPcFpbzS6pajtzIZ6psOjMMBiYBl4bYsyvCXjXjcxqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bjDDTZVh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=suV+Y
	2LyplkrM4yJD+/idz7EJyig+caiaQbacZ5Gacs=; b=bjDDTZVh5zHtw4QlKERZp
	FIVMt5nag+JvWABID/TLRKvit42umxs8aD4/VrgQgO18nzehP/a6Ufv05wFFsVcl
	OVA+8vhN8u8Fo8oevjgtZAPArp8tttjJCJsowotstHIcL3Mhdkzd2zCb/I8mljy4
	7R/rewr4VjJTEmIHzs9F/c=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnN4eHBFlnUgaDAA--.11961S4;
	Wed, 11 Dec 2024 11:18:37 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PM / devfreq: Check dev_set_name() return value
Date: Wed, 11 Dec 2024 11:18:29 +0800
Message-Id: <20241211031829.2257107-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN4eHBFlnUgaDAA--.11961S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8CryrJFW3ury7Aw45trb_yoWkGrX_Ca
	n7ZF97GrykKwsIyry5CrsIvry2ka1xtFsYgr1aq393XrWruF1DAr12qryDAFZruw4Uur1q
	kr1DWFsrZr4rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRE6RRDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizQmyC2dY-AfqwAAAsT

It's possible that dev_set_name() returns -ENOMEM. We could catch and
handle it by adding dev_set_name() return value check.

Cc: stable@vger.kernel.org
Fixes: 775fa8c3aa22 ("PM / devfreq: Simplify the sysfs name of devfreq-event device")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/devfreq/devfreq-event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 3ebac2496679..9479fbe71eda 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -328,7 +328,10 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->dev.class = devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
-	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
+	ret = dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
+	if (ret)
+		return ERR_PTR(-ENOMEM);
+
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-- 
2.25.1


