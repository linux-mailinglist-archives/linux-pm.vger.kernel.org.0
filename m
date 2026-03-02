Return-Path: <linux-pm+bounces-43428-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE83GJW3pWkiFQAAu9opvQ
	(envelope-from <linux-pm+bounces-43428-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:15:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F31DC867
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBC03149FAA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7041B344;
	Mon,  2 Mar 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="koUJWiJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290541C0CB;
	Mon,  2 Mar 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466867; cv=none; b=QmkhFplEEDLcsVCRRVLxy6/Q93Ze8Os5zaZkgdW9jYBP5osV3lFNjyqyuFPBOVGX5rxx7jn3+1db3Gi8jmzTb/G5H7VD4sSsoT27f4Nwk4ljRbBA/DRv3bkM9Ss1zjsysCgE7MsZrPEcMovaBGCIYvbI2oDKo4SOHnfpr0QAb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466867; c=relaxed/simple;
	bh=faGDlxTpGgDgf5lft1dr/LUhyCXcbET5nTyAJhZn1rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJ6u/4LuZJq4ZKZHW6zBWkC1nVQjWjpAB/qzBPFRVQbZV035eLp5BroxRBLSP4g8/vFlv7GJitCo0Ziy5YomND+r12dWSTnD+mu1c00x6iQXq5sbSlhw6P59Pkf0mUAlP5i/BSnIw9mnDZPzw1V4tYrRO6OsM9X8P7c24yWbLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=koUJWiJa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MB
	NRmuJe+0PPQ4BIarWTighfyiqD0+gta5zQYlDF/yk=; b=koUJWiJa65TZE3NOiR
	jshin6wHuOBLR9vxA1nAEz5xkJGMjEKyqLYmA/IvDDS6dmz1OdViytSNlKj4uHHA
	bo6BFdRe7s/gdHf1whIG67ejgu4aHoNURc2k2Qhh2X8ASw9GEuBjhhZQB4ITCjh5
	WfTWsOCjCKFOqLd1tshKEhL2Q=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCX1weOsqVpju7dNg--.43634S2;
	Mon, 02 Mar 2026 23:53:51 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: sudeep.holla@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] cpufreq: scmi: Fix of_node use-after-free in scmi_dev_used_by_cpus()
Date: Mon,  2 Mar 2026 23:53:48 +0800
Message-Id: <20260302155348.26374-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX1weOsqVpju7dNg--.43634S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF15tryrGr1xGr4ruw4kZwb_yoW8Xr4rpF
	W3C3yFyry8JFsrJw10vr4UWrWYvan3ZrW5uasxKwnava98XFy5Xryag3WUXr98CF93Xa4Y
	yr1rta4xWayxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUfQiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww+TN2mlso+dEgAA3W
X-Rspamd-Queue-Id: EA8F31DC867
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43428-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,lists.infradead.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[18255117159@163.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In scmi_dev_used_by_cpus(), the code previously released the of_node
reference via of_node_put(np) before checking whether np equals scmi_np.
This could lead to a use-after-free if the node pointer was accessed
after being freed. Reorder the logic to perform the comparison first
and only put the node after the check, or immediately return if they
match. This ensures safe reference counting and avoids potential kernel
crashes.

Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4edb4f7a8aa9..187aeb65e221 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -413,17 +413,19 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 		cpu_np = dev_of_node(cpu_dev);
 
 		np = of_parse_phandle(cpu_np, "clocks", 0);
-		of_node_put(np);
-
-		if (np == scmi_np)
+		if (np == scmi_np) {
+			of_node_put(np);
 			return true;
+		}
+		of_node_put(np);
 
 		idx = of_property_match_string(cpu_np, "power-domain-names", "perf");
 		np = of_parse_phandle(cpu_np, "power-domains", idx);
-		of_node_put(np);
-
-		if (np == scmi_np)
+		if (np == scmi_np) {
+			of_node_put(np);
 			return true;
+		}
+		of_node_put(np);
 	}
 
 	/*
-- 
2.34.1


