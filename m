Return-Path: <linux-pm+bounces-18978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD79EC1EF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 03:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340D81634E6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E341FAC38;
	Wed, 11 Dec 2024 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O43yX5bU"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B29F4FA;
	Wed, 11 Dec 2024 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882833; cv=none; b=OBgqInNw4MsTC2hNsSGYgVS5Sh+dy2ZilITJPzlE0BwR1CRoAL3YVcldYD+xvkxWwbLpd4WLQ43B7fBrPHmDkAUcX9KHYSvYxIT8pkkizFOWhk+PJPwmaN+pdv+esTvoRGETVgN8c+5UYi7KEmpaug5fwCT4lPydL9O25q1VRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882833; c=relaxed/simple;
	bh=twzvszYnCbMhtuKD1UzQvp2aU9Bu7zCx9+sMc2mfaY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lilgAeFvgfvkc38u6sOBDvzSpcKQCE1fUGl+Ln6QUUiihWSk8B46fxQLtJmIarPEOfTNGsc2SJxNU4ye5jPxzvTLfayTjRfUt8axc/h9DJxheNV4X4QU3NECOtbehqC9RAb2SsySHX+3HqU51CPgy3Cod1g6nsmXCC09KwJErEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O43yX5bU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1ChVn
	l8f/m6aD5qb3TrppzD5dqsuMz3iizwCqQqq/Ak=; b=O43yX5bUxhftSSIuLmU8W
	CIs0KDFP9RragWEJy4SK8Jhh28nTK1vqx4eUCf1Vnt+mIftSDk93SfcUa/k4WhzN
	nx2myxVC400yuXlg6QTp/5pMZ63eCLrlbThiS/fzUwroUxl2fhLxSXNz8CYy7G/9
	Fwqg9giFBZkq9d1ZwTIUNs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnSDy281hnna5yAA--.8093S4;
	Wed, 11 Dec 2024 10:06:50 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] powercap: Check dev_set_name() return value
Date: Wed, 11 Dec 2024 10:06:45 +0800
Message-Id: <20241211020645.2123881-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnSDy281hnna5yAA--.8093S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyUur4fAF1ktryxGF17Wrg_yoWDuFc_X3
	4Iy34a9F4q9w43ArnF9rnavrySkrW3Jr12yF4FqF13tay5WayDXr12vFy7Ar4xW3W5CryD
	Jryav347AFyrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUSdgDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRiyC2dY8tYcJwAAsM

It's possible that dev_set_name() returns -ENOMEM. We could catch and
handle it by adding dev_set_name() return value check.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/powercap/powercap_sys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 52c32dcbf7d8..11db93b10aa5 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -552,9 +552,12 @@ struct powercap_zone *powercap_register_zone(
 	power_zone->dev_attr_groups[0] = &power_zone->dev_zone_attr_group;
 	power_zone->dev_attr_groups[1] = NULL;
 	power_zone->dev.groups = power_zone->dev_attr_groups;
-	dev_set_name(&power_zone->dev, "%s:%x",
+	result = dev_set_name(&power_zone->dev, "%s:%x",
 					dev_name(power_zone->dev.parent),
 					power_zone->id);
+	if (result)
+		goto err_dev_ret;
+
 	result = device_register(&power_zone->dev);
 	if (result) {
 		put_device(&power_zone->dev);
-- 
2.25.1


