Return-Path: <linux-pm+bounces-14256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7BC978FED
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E875B2366B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43691CE716;
	Sat, 14 Sep 2024 10:25:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2B45025;
	Sat, 14 Sep 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309506; cv=none; b=AbhrILlMevuLZXKw6q0poWBzBWY2mxA8TCkVuR9F8qM1cefAFXNlNDRpjY4oEp83NYRGcqHOrtULIp+zR8oZAThcYI5ux/eDeYjA0tfPdIQcipNFJPeFHQK23F8d1SFB3cBL2vVdVeLTEOZ8H4ZZgEtWeZ04XU4zenzG+U7HBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309506; c=relaxed/simple;
	bh=AtuMd6NKlG+Syp19uppr02ateM9HluJ3Gl9IuBKSOu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcJMGLOTZ17L4a62rXaDEJXw/4NhxcGmFCLpKkonqb+TewuGR9mHUHYwljAA1u75P5nIBqD86v62KrAufsziFeC5WYYFl+SyB50GWL3q4f3B3f86YRqZMOevO5jE6AZFz/J7vCInmoiWXSb5E39x/6VM+vnI1Xb4b4rllpBQMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48EAOesR042876;
	Sat, 14 Sep 2024 18:24:40 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4X5Rtk1Hc1z2Pvl0t;
	Sat, 14 Sep 2024 18:17:18 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sat, 14 Sep 2024 18:24:38 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH V2 1/2] interconnect: Add character pointer initialization
Date: Sat, 14 Sep 2024 18:24:35 +0800
Message-ID: <20240914102435.3879355-1-Yibin.Ding@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48EAOesR042876

From: Yibin Ding <Yibin.ding@unisoc.com>

When accessing a node whose data type is a character pointer and has not
been initialized, a crash will occur due to accessing a null pointer. So
it is necessary to add the operation of initializing the character pointer.
Since the debugfs_write_file_str() function performs a kfree() operation
on the node data, memory is allocated to the node pointer during
initialization will be released when data is written to the node.

Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>
---
 drivers/interconnect/debugfs-client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..a1c99b9d3b9a 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -147,8 +147,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
-	debugfs_create_str("src_node", 0600, client_dir, &src_node);
-	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
+	src_node = kzalloc(sizeof(src_node), GFP_KERNEL);
+	dst_node = kzalloc(sizeof(dst_node), GFP_KERNEL);
+
+	if (src_node)
+		debugfs_create_str("src_node", 0600, client_dir, &src_node);
+	if (dst_node)
+		debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
 	debugfs_create_file("get", 0200, client_dir, NULL, &icc_get_fops);
 	debugfs_create_u32("avg_bw", 0600, client_dir, &avg_bw);
 	debugfs_create_u32("peak_bw", 0600, client_dir, &peak_bw);
-- 
2.25.1


