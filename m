Return-Path: <linux-pm+bounces-13220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391C965F11
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4019628E6D2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9018FC67;
	Fri, 30 Aug 2024 10:24:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1218F2C3;
	Fri, 30 Aug 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013477; cv=none; b=salSplvbBEvEynAEpeJcr0lV8Z9s5BvtYvggW5dF99PXeu0j0LGCeXfYvZgrEX204zkdoSOCvMOB1XizUWx2q+TCJuW7c92UbYg3HtFqSiIqTisXRPy6r0KhDhZN55INOdBzeTyIirmn2OfYu1V30Zm+M4BNMWfDN5ys/AL1aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013477; c=relaxed/simple;
	bh=Y5AZNuvvj1CyJkOhIAY6s+QK+ZUYCcxTrKP89Vs3CGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSfd6rPSTWBS2Y3w2qpUgkZOLs+Q+HJZzsxKlMCa4H7BSp2WulmbJ5sArYKt5vD6XF9iQVVeZqdizPSCW+eOCxZ38Ji2zyHinFihqv3U4nJtJG3Li1oNxRXERqOldrszGDeCCOuJnTva1ahWdewXKy0SCqr7anSkz2CuVh/h7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47UAMm7u031638;
	Fri, 30 Aug 2024 18:22:48 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WwDZ36m2wz2N5cJc;
	Fri, 30 Aug 2024 18:15:55 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 30 Aug 2024 18:22:46 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH 1/2] interconnect: Add character pointer initialization
Date: Fri, 30 Aug 2024 18:22:44 +0800
Message-ID: <20240830102244.409058-1-Yibin.Ding@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 47UAMm7u031638

From: Yibin Ding <Yibin.ding@unisoc.com>

When accessing a node whose data type is a character pointer and has not
been initialized, a crash will occur due to accessing a null pointer. So
it is necessary to add the operation of initializing the character pointer.
Since the debugfs_write_file_str() function performs a kfree() operation
on the node data, memory is allocated to the node pointer during
initialization will be released when data is written to the node.

Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>
---
 drivers/interconnect/debugfs-client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..d62ba56b7bbe 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -16,6 +16,7 @@
 #undef INTERCONNECT_ALLOW_WRITE_DEBUGFS
 
 #if defined(INTERCONNECT_ALLOW_WRITE_DEBUGFS) && defined(CONFIG_DEBUG_FS)
+#define INITNODE_SIZE 1
 
 static LIST_HEAD(debugfs_paths);
 static DEFINE_MUTEX(debugfs_lock);
@@ -147,8 +148,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
-	debugfs_create_str("src_node", 0600, client_dir, &src_node);
-	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
+	src_node = kzalloc(INITNODE_SIZE, GFP_KERNEL);
+	dst_node = kzalloc(INITNODE_SIZE, GFP_KERNEL);
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


