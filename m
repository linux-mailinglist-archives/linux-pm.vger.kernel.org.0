Return-Path: <linux-pm+bounces-12690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9F95AA80
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 03:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ED91C225B4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD5101E2;
	Thu, 22 Aug 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HLOjF/iB"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954BBA45;
	Thu, 22 Aug 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290150; cv=none; b=bUgqhQbjYeLdpZwYDBjfbBHvpsGATeVQXIRYlVYmONV08WOuXKsX4hLGOwNA1D3pgDSeWhp6sS6GdPvtvKYyf1JsDKQPcRcWek6pccSyp659GIF4InLoQW13K/RpUF4mKsBMQNbLwAMm01xmpKbWx5jTJZXOKIyPjBrNORbp7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290150; c=relaxed/simple;
	bh=bOQrbXWwAx6pa63J2zycppIZJs5NUxIYiDE0P4G3dHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6FtzIgzpiKMBLR/ubywfSNEuHtYaMZbqASU6oVQrDqVY8irv3ISYBOvUvsEyZIANNPPIpTnHNG/PX2tjoVOVvKEd427TdkssB+0HP6y2rMq3pl9oFg2ShQJ+jpd7E+uwkM2sOkHSY504iPmTIeABwwL/bE2hu5i0D3LXfNzs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HLOjF/iB; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724290145; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8Oi/65dFH9uR3YfJW75M/LrdessR81lmABm2FiEzrF8=;
	b=HLOjF/iBFrC/Gf8QazSnF4sgAvQNiB5zJavbzyB28Tmkj8aKlHmr0tARWivzPLJSnc4tknRHAHHZ1IbD+C5gyn7WveCk9K5IH0oKd40Jbk4rjxXTyOXSfnbNp9sWaorKhLfphpuDi3XdJOICV58d+p2egF0pQQnxh/7VuCvb8KM=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WDNHaLA_1724290144)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 09:29:04 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] thermal: Correct typo in thermal zone documentation
Date: Thu, 22 Aug 2024 09:29:03 +0800
Message-Id: <20240822012903.57986-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The term '@refcont' was corrected to '@refcount', ensuring clarity and
accuracy in the code comments.
Additionally, an obsolete comment regarding '@tt_zone' was removed, as
it was commented out in the code.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9797
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thermal/testing/zone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
index fcee12b152da..173d86bcc4e2 100644
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -35,7 +35,7 @@
  * @temp: Temperature value.
  * @tz_temp: Current thermal zone temperature (after registration).
  * @num_trips: Number of trip points in the @trips list.
- * @refcont: Reference counter for usage and removal synchronization.
+ * @refcount: Reference counter for usage and removal synchronization.
  */
 struct tt_thermal_zone {
 	struct list_head list_node;
@@ -60,7 +60,6 @@ DEFINE_GUARD(tt_zone, struct tt_thermal_zone *, mutex_lock(&_T->lock), mutex_unl
  * during the registration of a thermal zone based on a given zone template.
  *
  * @list_node: Node in the list of all trip template in @tt_zone.
- * @tt_zone: Zone template this trip template belongs to.
  * @trip: Trip point data to use for thernal zone registration.
  * @id: The ID of this trip template for the debugfs interface.
  */
-- 
2.32.0.3.g01195cf9f


