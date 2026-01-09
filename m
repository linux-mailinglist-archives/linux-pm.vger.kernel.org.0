Return-Path: <linux-pm+bounces-40537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC5D09AA3
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B7E306117D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482533ADB8;
	Fri,  9 Jan 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8eoq/hf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219B1A01C6;
	Fri,  9 Jan 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961553; cv=none; b=tPptZjkRIaF5vkS61adZpAGWA1Ctmc5SmZBR/Q3Y7Uf9P/6i3am981XQLWIEopo6hwVcAqM6Tl2IyN6z8HUSXLXeuJY4hhN7AEuKkbjgz0K68taYx5V3rwJXt4kx5hZiWb7q0RH2xdhtvJTKu+EsytWOJBbqTQycUsxTtUMDVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961553; c=relaxed/simple;
	bh=mqfMweubTjwC6/K1g05RuytgLKSPH1AqfDM8zhFG41Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWqwAw76n4IekEE8ey4i9Hc59AKT3lZti8QYJ0A7tPGlPyTNz6f66pt6mZCdV93g+z0fuzXgSctqGffLYbscFMmP+YtEY7apVGu1GkG+ybrho75oVl9HqLAw77mMTvP/IqyEv8Ua4X9cQzkpT7tSKwGp0jWegSpvd/wc/UplOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8eoq/hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B5C4CEF1;
	Fri,  9 Jan 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767961553;
	bh=mqfMweubTjwC6/K1g05RuytgLKSPH1AqfDM8zhFG41Y=;
	h=From:To:Cc:Subject:Date:From;
	b=e8eoq/hf9kDwJ7heyHx4JD2P+LlvyRjcXzBVKyUmsM4YbvLVyF3o+qkEJZ3Y6O8BQ
	 lTXkypix9VhR8wyaLLW8vbVGpQ4eretrpbjbfsM8nxNAS/VPxXEMAHzQCSdoWqNYBL
	 WnIPyV7IZQyWeHzcxCX6TroUehOaJI52csFCnCYmSRpgjJOTEGmg5t7hAIk6yHKcWz
	 hdiVk9YdwIG/Pca0X7PcifAroWx7nFdlg0GeGFIV/FP7bF49zIcqX/H+uTNgBjt+ok
	 n1kNIHb5GXcxTbeerx9EcjgGOBIoUruQ6Gx3lxRm0HP0v1jI4lixSZt5ktrovkymv/
	 EEPoq7bYUivSg==
From: djakov@kernel.org
To: djakov@kernel.org,
	quic_mdtipton@quicinc.com
Cc: mike.tipton@oss.qualcomm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: debugfs: initialize src_node and dst_node to empty strings
Date: Fri,  9 Jan 2026 14:25:23 +0200
Message-Id: <20260109122523.125843-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Djakov <djakov@kernel.org>

The debugfs_create_str() API assumes that the string pointer is either NULL
or points to valid kmalloc() memory. Leaving the pointer uninitialized can
cause problems.

Initialize src_node and dst_node to empty strings before creating the
debugfs entries to guarantee that reads and writes are safe.

Fixes: 770c69f037c1 ("interconnect: Add debugfs test client")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 drivers/interconnect/debugfs-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 778deeb4a7e8..24d7b5a57794 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -150,6 +150,11 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 		return ret;
 	}
 
+	src_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
+	dst_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
+	if (!src_node || !dst_node)
+		return -ENOMEM;
+
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
 	debugfs_create_str("src_node", 0600, client_dir, &src_node);

