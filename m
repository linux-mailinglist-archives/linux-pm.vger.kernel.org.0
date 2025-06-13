Return-Path: <linux-pm+bounces-28643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A43AD8843
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FE01898E5B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF12C158A;
	Fri, 13 Jun 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jEAbESIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784F248897;
	Fri, 13 Jun 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807908; cv=none; b=TupOTxUFKlwdWEBaDote1wBZuzH2dMjRa7VrDGKDoU/lxHfCp5ntbgh9I99zoWoUSYODtYeehAXQFRBa3SG5GNcxGwl7U9mYbo3zylLmaZ2hrI0Fg4CN7twFbToqszA+LJaCJdq0OMP8QPVceMv3y/4WdV0MDko7KxFiA4vBqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807908; c=relaxed/simple;
	bh=mApQSZiTUQ/ELpTHSc9EIl48oP4L0hvglVuNI+UGnIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G23sSUIjfmEVko3MHQK2CoLKsR1u5fQ2Oi/ZchkDlZNkJt5Kcl6YWIUMWU0G3zpMQ3ny5h5hC48WVitJ4j9trbhs/y8nrEs6UPr+joV2FJ+uaj8SB4cLmKDHSv8dcR55rCFXQZ9X+XzvoUER3gPvjxAWYXwrZR4DSGLK+6GKCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jEAbESIo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hW1hHR6fBTOnl93e+xBqVI6BB1fQLkW/+hpUdzYh7Sk=; b=jEAbESIo67zKrL4bPrRIAoQhMg
	a+XkgaIU3Hem/K5VP3FxCd82oDbhDXxCSMd17GspD/eOV/OsUywMCVTIIWHElpGaviMaRVuz2azuN
	8hF4aX0vs07GLTJTGbXYUb12JhyS4glcABbkFy6FpOsiw7Yd31vEudonscnV5zJCK5pZnFvYbiVR0
	UygAHn3THyDc0uNwYFVfpIyxXkegejV6mK5p3sV2ML1FSqup5J/a7Qy5NIH70G4gBHbu11SNrl+o+
	rCnzMUM9XolFmLlhu5sG0u883ZEYn6qNZrWP7rSSEfuyS9CeJUESVPRHnOGQaO771YNoeds9a1iQD
	rViOaiDQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ0y2-002xde-Rs; Fri, 13 Jun 2025 11:45:00 +0200
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
Subject: [PATCH v2 04/10] PM: EM: Expose the ID of a performance domain via debugfs.
Date: Fri, 13 Jun 2025 18:44:22 +0900
Message-ID: <20250613094428.267791-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613094428.267791-1-changwoo@igalia.com>
References: <20250613094428.267791-1-changwoo@igalia.com>
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
2.49.0


