Return-Path: <linux-pm+bounces-27777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCAAC74E4
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24615015E0
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7178F45;
	Thu, 29 May 2025 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hJEouFOe"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5724642D;
	Thu, 29 May 2025 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477654; cv=none; b=ZxYaW7x1Jo7qZXYnkjHVOnRsibbR5zbtcpp3tU5s9RggIaRrwnALorIWyXatTsPUDD72Av34T8/QPPZ9GxrsLyunORn1dbD9XbHtmXeK8sYaDogknjhLa2iC83IEbUxVZu7X/1LCUdu5/a4DbUbP6WLxUnCJU145L5YJ2RNjN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477654; c=relaxed/simple;
	bh=fPmC+sf7hFuSga3JaCOOR+pbWUeKdP8Mf+qdd4uZBmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfW4sBXfUwYRI+EOR3Zxfr6wyFxlKh2BQHMra9Av1luFKasOi74gZjT7ttjwza1Qkrdc/iEZy9IcI4ATtK7Es1tanx+8uyIRLucp6Ue7npNnhV39AujQbbZ46wYz2yoY8/qO2+nKpO/i1ydbSZUa/t8fSRhq0p3JSta93Gc3mWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hJEouFOe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PyyfjXDDjNfrkft1ylxTCOBf1BYeXJ3sHB4l4H6orC4=; b=hJEouFOekqCXsE3Qdqn+7wJ/ln
	c7lxd7Uq3d3F/3YLN6+EABptRGVujWSosM2fBkZbwc2pulfd2i6YIcrmQ2xgXaD3iuIyoIqQVtrXM
	wj4mtaXBEchgrOk4BV4sY2kuh2a4FSRqUGlSzWHCtAb0tIw034tjwpMmfRLZ3rH/BJNWvDLtg/BDY
	wBir/SvkU4Icii6JgARXmE6bsfw5XkPWYwx1q4auNMf7n1RqpzIAt0X5W9xfFarpOYJv3PicBx7iS
	wcVmnYRqc6irB/2JFx7BL0QhlwdBm+hS4uLQe+gJgMH9CyeH5cJgRGLZw1nBCM0zoBPkKlZMXM6AW
	eenTShQA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQuL-00EZwr-AY; Thu, 29 May 2025 02:14:06 +0200
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
Subject: [PATCH 06/11] PM: EM: Expose the ID of a performance domain via debugfs.
Date: Thu, 29 May 2025 09:13:10 +0900
Message-ID: <20250529001315.233492-7-changwoo@igalia.com>
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

For ease of debugging, let's expose the assigned ID of a performance
domain through debugfs (e.g., /sys/kernel/debug/energy_model/cpu0/id).

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 529f8a63ab3d..f441c9c1b848 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -128,6 +128,16 @@ static int em_debug_flags_show(struct seq_file *s, void *unused)
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
@@ -144,6 +154,8 @@ static void em_debug_create_pd(struct device *dev)
 	debugfs_create_file("flags", 0444, d, dev->em_pd,
 			    &em_debug_flags_fops);
 
+	debugfs_create_file("id", 0444, d, dev->em_pd, &em_debug_id_fops);
+
 	em_dbg = devm_kcalloc(dev, dev->em_pd->nr_perf_states,
 			      sizeof(*em_dbg), GFP_KERNEL);
 	if (!em_dbg)
-- 
2.49.0


