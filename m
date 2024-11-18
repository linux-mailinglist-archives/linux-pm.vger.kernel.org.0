Return-Path: <linux-pm+bounces-17695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479C9D0DA2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93161F212AF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53E192B79;
	Mon, 18 Nov 2024 10:00:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B917C98;
	Mon, 18 Nov 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924001; cv=none; b=IGlFGni9XhRlPTjzcptyYD0dO2zRYN23q4IFIjssf52o2USFS65RxyzmqbeotpU1tVwk5hs+wrkExeLQZGEm0OPzg9sohvqyYnaVKEZRcI9nftSllgBzcrzLfvZ501LgUKusjt8ySWpjjY1JdFTW35D/4Mu2FKq5d/u9AFpcUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924001; c=relaxed/simple;
	bh=UmysSMKtsHF0NQ3aFx0ERmXjfRBYtWWxIAEpAbk+d2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTHlOIu7h1/zvqthJRYOwax3cJOJy2aIHeOzGhpd/bWFlygSC4H3KU1BhKSXcyh8wKoumfUA020NgPoW1koCFdMJWEJVnGEBzAeGbvzgDcMkL+ssbz5LV/og9HZ9h7ri3GV2aWlBt+WVum5ybMNX5O7w/G3+Q9zHKuLml2N50yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id PMA00044;
        Mon, 18 Nov 2024 17:59:44 +0800
Received: from localhost.localdomain (10.94.9.174) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 18 Nov 2024 17:59:46 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <djakov@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] interconnect: Add NULL check in icc_clk_register
Date: Mon, 18 Nov 2024 17:59:39 +0800
Message-ID: <20241118095939.49612-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20241118175944a7569be702571fc6b44a936c859113e8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in icc_clk_register() is not checked.
Add NULL check in icc_clk_register(), to handle kernel NULL
pointer dereference error.

Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/interconnect/icc-clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index b956e4050f38..e4188cc5b892 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -116,6 +116,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
+		if (!node->name)
+			return -ENOMEM;
+
 		node->data = &qp->clocks[i];
 		icc_node_add(node, provider);
 		/* link to the next node, slave */
@@ -129,6 +132,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
+		if (!node->name)
+			return -ENOMEM;
+
 		/* no data for slave node */
 		icc_node_add(node, provider);
 		onecell->nodes[j++] = node;
-- 
2.31.1


