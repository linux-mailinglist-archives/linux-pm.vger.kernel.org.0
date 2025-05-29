Return-Path: <linux-pm+bounces-27775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D1AC74E1
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BC81BC7D8F
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A717BA9;
	Thu, 29 May 2025 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QbVhsw1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2BB67A;
	Thu, 29 May 2025 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477642; cv=none; b=ept0c/pZ5LSsI1qsuJbMP9+TGWRGwekLkFrjC+crLvc1rJP8c/gEqnsX7hznT9yYeNn63JarJDu24EhvZzneGct85B3HoZqiOS9OhteqRztKR9hfDj8tWhKX2J5sdXivDsNUW3o4UP0p5NCNvLSAflqbihLQdjBqNooBsU67VQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477642; c=relaxed/simple;
	bh=s55kvL81M6t2dqvawvXlqAz6LmeznoRLQGOWTuBVP7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgEduQlkvpFv/8e05zBHXAAF9PTkqdzpIG7BsGlEkfNeLWJKf54CXIwDFbS3FoSH/Vk0YKDFTyzSDb5orbD17qP4xZIq0T6nUuy73QukPaj2nDczI29qgbqnQx6XVW/8c/mXg+s49tLk7dwRnFtcI3YhbjlUxMFu21p2Qmvqdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QbVhsw1N; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1O+rcdio6J6uZHO+lAjIDTKwuWkhySxmjhn8uaYvZ90=; b=QbVhsw1NVyS553ik4iDulYMNTl
	hp2htG5zbhzNLZ+CYTdkhryFnEYs82rGFSxnu2IxSZ1Mtfjpvp4vxXB2R/wQiPV0uvUG2WpbD6X6e
	ah/6nyxj9+uoC4OwQy5QJoRqHlfb0hgCbMDqycXCapRmdI3v+GMkbhVlKOv1LO/r9P1L1p+EC8/mf
	27BTPAVGIHrIUOXrk0xd6SmSLy6Vtyp5DfBeamd1mYhcupbjfwHTIHb986FBJpXn6ACE0FWTgfhh3
	Qu1fV0FXRq8BYPip0oqblQAfPGNVC3eTCMZzjPBC3hcV5I84Y2Odaav7MqEuowQqJSN6HkE/nALu3
	6ecGNWSg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQu8-00EZwG-Gr; Thu, 29 May 2025 02:13:53 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 04/11] PM: EM: Add the infrastructure for command processing.
Date: Thu, 29 May 2025 09:13:08 +0900
Message-ID: <20250529001315.233492-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The infrastructure for command processing receives a command from a
userspace and calls a callback corresponding to the request command.

Note that the callback functions are just boilerplates in this commit,
and the actual implementations will be provided in the following commits
when a callback for a specific command is implemented.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 30d83fb5a3a8..edbaecebd0b4 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -23,14 +23,65 @@ static const struct genl_multicast_group em_genl_mcgrps[] = {
 static const struct nla_policy em_genl_policy[EM_GENL_ATTR_MAX + 1] = {
 };
 
+struct param {
+	struct nlattr **attrs;
+	struct sk_buff *msg;
+};
+
+typedef int (*cb_t)(struct param *);
+
 static struct genl_family em_genl_family;
 
+/*************************** Command encoding ********************************/
 
-static int em_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+static int em_genl_cmd_pd_get_id(struct param *p)
 {
 	return -ENOTSUPP;
 }
 
+static int em_genl_cmd_pd_get_tbl(struct param *p)
+{
+	return -ENOTSUPP;
+}
+
+static const cb_t cmd_cb[] = {
+	[EM_GENL_CMD_PD_GET_ID]			= em_genl_cmd_pd_get_id,
+	[EM_GENL_CMD_PD_GET_TBL]		= em_genl_cmd_pd_get_tbl,
+};
+
+static int em_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct param p = { .attrs = info->attrs };
+	struct sk_buff *msg;
+	void *hdr;
+	int cmd = info->genlhdr->cmd;
+	int ret = -EMSGSIZE;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	p.msg = msg;
+
+	hdr = genlmsg_put_reply(msg, info, &em_genl_family, 0, cmd);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = cmd_cb[cmd](&p);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
 static const struct genl_small_ops em_genl_ops[] = {
 	{
 		.cmd = EM_GENL_CMD_PD_GET_ID,
-- 
2.49.0


