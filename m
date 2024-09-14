Return-Path: <linux-pm+bounces-14257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC44978FEF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EABB23B53
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C501CE70E;
	Sat, 14 Sep 2024 10:25:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411511CEAA9;
	Sat, 14 Sep 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309523; cv=none; b=uwWYjIgfdxBYsLTPv/Gq0PvIfS87dKGyL9q7Pz/R6SvulwXrMiOE3cshi4F3OTs0pd0nONjHmuB9xYhgbpNe9edWEgE3wSZP3DS2yLyPAKhiPBI5srdLbqac/G8Hwn/76iP2kKq+rEDJyxE5OXmlAXW7/cz9I+E42WiY2QB7iWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309523; c=relaxed/simple;
	bh=gPn3ocUVhQgAWNFUlaGK72RHnsXD6uEOO6+5lQ9CLRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nqi/w6Ex/xZzE6dg9jbMDp3hJE5yBUGf7rqXyUj6xWb7VnRqP5cNgqjrXaQWVDMBcM+A+yHudqzgAuGvy77dz7hlfbmRc4jzAlwhOtMtC7VRVqu6ac20s3K0qlh1eRnFpPm4vUx0qYJxJF+IxykAKTz6pZ2MIB6+eoTnGUFyeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48EAOwcT043365;
	Sat, 14 Sep 2024 18:24:58 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4X5Rv36B3rz2PTj3C;
	Sat, 14 Sep 2024 18:17:35 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sat, 14 Sep 2024 18:24:56 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH V2 2/2] debugfs: Fix crash problem caused by accessing uninitialized nodes
Date: Sat, 14 Sep 2024 18:24:53 +0800
Message-ID: <20240914102453.3879527-1-Yibin.Ding@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 48EAOwcT043365

From: Yibin Ding <Yibin.ding@unisoc.com>

For uninitialized nodes such as
/sys/kernel/debug/interconnect/test_client/dst_node, if the cat operation
is performed directly without writing content to the node, it will cause
a crash due to accessing a null pointer. So it is necessary to add a null
pointer check in the debugfs_read_file_str() function.

Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>
---
 fs/debugfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c6f4a9a98b85..8bbe7df6dfd1 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -970,6 +970,10 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 		return ret;
 
 	str = *(char **)file->private_data;
+	if (!str) {
+		debugfs_file_put(dentry);
+		return -EINVAL;
+	}
 	len = strlen(str) + 1;
 	copy = kmalloc(len, GFP_KERNEL);
 	if (!copy) {
-- 
2.25.1


