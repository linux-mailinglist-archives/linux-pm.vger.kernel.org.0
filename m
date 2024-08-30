Return-Path: <linux-pm+bounces-13218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD0965F0A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAF61C21AFA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D917C7BE;
	Fri, 30 Aug 2024 10:23:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16D17B4F5;
	Fri, 30 Aug 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013434; cv=none; b=AWVcaKOYsW9cqObQh6DX7UvISOo+Gc3PSjd5hXN3kNCBidvashnWgaEIbH9LDKd6XmrWF4ZqY2gb1MdJn34CQso8YzPoqyytaSzECNOpBkneW0ZaKo9pyMNlCotN5ybl+slISsKmuyB5L8r4LCvwqWQWpqcXXna0W9laJCS6bTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013434; c=relaxed/simple;
	bh=gPn3ocUVhQgAWNFUlaGK72RHnsXD6uEOO6+5lQ9CLRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0QIbG4EUvkjVtnLvm/20uJAVuzhiVCGyowOSAJaiCvnz4vC0u9NuSLRXe0aYECVIEw0+Iq19PjKzp/SRJXsGPK6o4awqAjxMytqvJvgkq1pXA7tWUiXIJ0E2Br15OkW9BPGws2Z9jnvurBT3e6iIhCadC+5QQJ0lgV3GVSpAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47UANJ0U032921;
	Fri, 30 Aug 2024 18:23:19 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WwDZg3DD0z2N5cJc;
	Fri, 30 Aug 2024 18:16:27 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 30 Aug 2024 18:23:17 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH 2/2] debugfs: Fix crash problem caused by accessing uninitialized nodes
Date: Fri, 30 Aug 2024 18:23:14 +0800
Message-ID: <20240830102314.409307-1-Yibin.Ding@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 47UANJ0U032921

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


