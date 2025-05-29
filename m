Return-Path: <linux-pm+bounces-27781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF372AC74EC
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10714A5ACD
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A11F1B7F4;
	Thu, 29 May 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TGUKc0Ew"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26E17BA9;
	Thu, 29 May 2025 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477684; cv=none; b=aHkW4a4UbAKxgFkuA6EwT7k0QmV2vxBs4XGtJITWdCrZywNlg+texBgHIp/ggk+pw+diE60sFin591/Vt8f7MzT7gjDRfabLxI8jxvJKrK1K7POL1qKk6c0EEb5U1jn6WtOEeX707DQC87+vOi4/ruyF7MD0fJpTqOGerEP2mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477684; c=relaxed/simple;
	bh=X0P8NsBm9MK5saruMk+zNqWtPEhduASS/LBeohCers4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIPOAhpwNHsZqqqlBGZjgzNM7ARt91vXJRNwPqRQkC9CyNn03Zwfe4c6fo4Cuj9tFW91a4z7/mTUAVLlHB7AQK37AgrNE6JilhKMh096H0ox+no4oar6QZuwrc+y0ycI0QrJtzKBEjrVYGx/M+wExuXj+ZhWtk3ZBzmnO/xGWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TGUKc0Ew; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rm5DPgOafYtL2trHXuvux751Nivwif0r+wnhFh4M6Bg=; b=TGUKc0EwwXjQwc6eA/Atqlr4GA
	nIoqo717qqKcHdfsWlkw3IX8p5nlV1PBuY65gJYHLS98G3IxIrRG7AHH6tSfUc939iPU3dG59sORq
	6bG3ZPMEih4H4O3KfqCdnlG52bNGBLbi4SsLSi674vaD2Kyh6tMwqkj/YpOqGvhs5O/Is0VNKKtwU
	0Z8tnQcm1wLlYfW679l4jZZcjCcYh+QkQEtuUlg/Do8cQw4iWHYIdv6zKtdzRCzVNExJrryY2XC6F
	WujDt/tzT0L0b6uVM2Z8Nh+03jD16E57nHDadZa3g65c9Y+k2dwPMry2HrxfPAb64UveRRbUQAE9h
	vvMh/4Ew==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQup-00EZxw-Ny; Thu, 29 May 2025 02:14:36 +0200
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
Subject: [PATCH 10/11] PM: EM: Implement event notification.
Date: Thu, 29 May 2025 09:13:14 +0900
Message-ID: <20250529001315.233492-11-changwoo@igalia.com>
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

Add the event notification infrastructure and implement event
notifications for three events -- when a performance domain is created
(EM_GENL_EVENT_PD_CREATE), deleted (EM_GENL_EVENT_PD_DELETE), or its
energy model is updated (EM_GENL_EVENT_PD_UPDATE).

The event contains the ID of the performance domain (EM_PD_GENL_ATTR_ID),
so the userspace can identify the changed performance domain for further
processing.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 89 +++++++++++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h | 19 +++++++++
 2 files changed, 108 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 5f3d5aaa97d7..85d4077ec1b3 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -30,12 +30,101 @@ static const struct nla_policy em_genl_policy[EM_GENL_ATTR_MAX + 1] = {
 struct param {
 	struct nlattr **attrs;
 	struct sk_buff *msg;
+	int pd_id;
 };
 
 typedef int (*cb_t)(struct param *);
 
 static struct genl_family em_genl_family;
 
+/**************************** Event encoding *********************************/
+static int __em_genl_event_pd_id(struct param *p)
+{
+	if (nla_put_u32(p->msg, EM_PD_GENL_ATTR_ID, p->pd_id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int em_genl_event_pd_create(struct param *p)
+{
+	return __em_genl_event_pd_id(p);
+}
+
+static int em_genl_event_pd_delete(struct param *p)
+{
+	return __em_genl_event_pd_id(p);
+}
+
+static int em_genl_event_pd_update(struct param *p)
+{
+	return __em_genl_event_pd_id(p);
+}
+
+static const cb_t event_cb[] = {
+	[EM_GENL_EVENT_PD_CREATE] = em_genl_event_pd_create,
+	[EM_GENL_EVENT_PD_DELETE] = em_genl_event_pd_delete,
+	[EM_GENL_EVENT_PD_UPDATE] = em_genl_event_pd_update,
+};
+
+static int em_genl_send_event(enum em_genl_event event, struct param *p)
+{
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	if (!genl_has_listeners(&em_genl_family, &init_net, EM_GENL_EVENT_GROUP))
+		return 0;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	p->msg = msg;
+
+	hdr = genlmsg_put(msg, 0, 0, &em_genl_family, 0, event);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = event_cb[event](p);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast(&em_genl_family, msg, 0, EM_GENL_EVENT_GROUP, GFP_KERNEL);
+
+	return 0;
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+int em_notify_pd_create(const struct em_perf_domain *pd)
+{
+	struct param p = { .pd_id = pd->id };
+
+	return em_genl_send_event(EM_GENL_EVENT_PD_CREATE, &p);
+}
+
+
+int em_notify_pd_delete(const struct em_perf_domain *pd)
+{
+	struct param p = { .pd_id = pd->id };
+
+	return em_genl_send_event(EM_GENL_EVENT_PD_DELETE, &p);
+}
+
+int em_notify_pd_update(const struct em_perf_domain *pd)
+{
+	struct param p = { .pd_id = pd->id };
+
+	return em_genl_send_event(EM_GENL_EVENT_PD_UPDATE, &p);
+}
+
 /*************************** Command encoding ********************************/
 
 static int __em_genl_cmd_pd_get_id(struct em_perf_domain *pd, void *data)
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index 8cedc6495916..34d5a98eec72 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -16,6 +16,10 @@ enum em_genl_multicast_groups {
 #ifdef CONFIG_ENERGY_MODEL_NETLINK
 int __init em_netlink_init(void);
 void __init em_netlink_exit(void);
+
+int em_notify_pd_create(const struct em_perf_domain *pd);
+int em_notify_pd_delete(const struct em_perf_domain *pd);
+int em_notify_pd_update(const struct em_perf_domain *pd);
 #else
 static inline int em_netlink_init(void)
 {
@@ -23,4 +27,19 @@ static inline int em_netlink_init(void)
 }
 
 static inline void em_netlink_exit(void) {}
+
+static inline int em_notify_pd_create(const struct em_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int em_notify_pd_delete(const struct em_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int em_notify_pd_update(const struct em_perf_domain *pd)
+{
+	return 0;
+}
 #endif /* CONFIG_ENERGY_MODEL_NETLINK */
-- 
2.49.0


