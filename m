Return-Path: <linux-pm+bounces-32106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28FB1FD18
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 01:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E382177055
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355F2D63ED;
	Sun, 10 Aug 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HFhmSwnz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9E2D8DDF;
	Sun, 10 Aug 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754868865; cv=none; b=nUIbq287ecP2bjOznw5CDRSgCgIH3hvtteEtUOsf4M6A1sIJUN5X728aN2AzB6R5fu4XP3S5b8G1+nEZSVu6weXFmwkcmnFRLB7deNn2KbO4OGczp4Df/WWt6SIGD1Wa/01Yug81pZeHx/2pcjdvZQpj5plAKwbk8fx/AOpDuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754868865; c=relaxed/simple;
	bh=MvpC6IFbkoVOh8W2BVLWP4cG7B9UcfBApA8Xt5123Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzJlpqGOMDXUDHQl0eTI0P2GzTHgtQh7fi5jOAB5f9VQGop6lGyu2ddN5CPhLl1ci4rPHr2Iuoa+jYciRqiLpxqvoZhgEr6TQ3ewiNBWs8sQ0dtkgDURBAHLfk1QKxdDAL3Kgm4qcfs/aTAUh0MzkqedNPp8xlFOwPg7gVaVpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HFhmSwnz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hxo+NYLiFnADINm6/scBdHgiUPH9N0/lq+OnC1dkE3Q=; b=HFhmSwnzY0xRPVPOVYzLzguQVE
	hYLpfsaUp4pN67xcFIlhajjm0MbP/5rWZUg1aZSkEHq1LhhoGgLmbD7D6UMABnTHm0NdXQ3+PP0R5
	/ecemedL+DupMVPKH59riqnc6dzSUZc+7i0ei6C+din94/qts85U3KRxmYuz5vp5i6PuVzBGRlXqN
	HAkA3sAVQgp/E4q+eSl7lJvCvz8gihAw89h1iE36cJ1yCSThDIg/1oL8ahQuFgJpbcWBZkePgS17r
	/bFq0NN+fdDdIiuaI4s2JIOSms1p7CI2jJFMNFxaINDyqIyv5lb4p4+uV7/A6wJbqxEeCdqc//YkK
	ggZt37uw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulFYO-00CW9n-LF; Mon, 11 Aug 2025 01:34:17 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH RESEND v3 04/10] PM: EM: Expose the ID of a performance domain via debugfs.
Date: Mon, 11 Aug 2025 08:33:41 +0900
Message-ID: <20250810233347.81957-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810233347.81957-1-changwoo@igalia.com>
References: <20250810233347.81957-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ease of debugging, let's expose the assigned ID of a performance
domain through debugfs (e.g., /sys/kernel/debug/energy_model/cpu0/id).

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 58671ac142db..6e5e70dbec88 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -126,6 +126,16 @@ static int em_debug_flags_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 
+static int em_debug_id_show(struct seq_file *s, void *unused)
+{
+	struct em_perf_domain *pd = s->private;
+
+	seq_printf(s, "%d\n", pd->id);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(em_debug_id);
+
 static void em_debug_create_pd(struct device *dev)
 {
 	struct em_dbg_info *em_dbg;
@@ -142,6 +152,8 @@ static void em_debug_create_pd(struct device *dev)
 	debugfs_create_file("flags", 0444, d, dev->em_pd,
 			    &em_debug_flags_fops);
 
+	debugfs_create_file("id", 0444, d, dev->em_pd, &em_debug_id_fops);
+
 	em_dbg = devm_kcalloc(dev, dev->em_pd->nr_perf_states,
 			      sizeof(*em_dbg), GFP_KERNEL);
 	if (!em_dbg)
-- 
2.50.1


