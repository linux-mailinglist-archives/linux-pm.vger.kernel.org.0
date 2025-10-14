Return-Path: <linux-pm+bounces-36017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA3BD6D8C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7566C4F8582
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D33398A;
	Tue, 14 Oct 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V8cPcTW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EA14B96E;
	Tue, 14 Oct 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400686; cv=none; b=bm5cLCg5Ebrj/LSIuDUZJGTxaaeIjOZrJIb5fJiYrVETYAaee3yb7HEmdrb1+WEXObTEXsGDmWc4KfbhD7enIVt2tgYyTFVoZHz+K8lj/tOm7x3jLA/MdGjCQpWIwetZWUmSGrYbFRvKzAjMP6DvTX8WuwGnU9btXiah4B2GCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400686; c=relaxed/simple;
	bh=9jbdxG/yYl45/d2BFNEixkOPueLzjLBmv5pZ2mERtM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUKceY1fVUqIV3MEv2FycB9cZ8GSYPLk1LjWWPBCkUUNZcrkMF6/ngKLXDDZ5FAnyPJFn1YjK0A477D46nmIFaPffmdhI4ohHYuMPptAOG9o8Ym9HJ9U2ijzzDLlVC1o2gg+FvWHaVYmW7bDea4/EDu8U4qR2AsGbznrsh9oxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V8cPcTW3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5GE2n1kb1gICkuq1rlxBJhLURqi1QRDOFHOZQlp1fSc=; b=V8cPcTW3tnrWYdCacnhR05mbzX
	5aiXu+CFxvFtH4vahmLz68We70FTNF8yU13QyCKePLdbxxcIIJAmBCEWBqNyg2NOaitIcDRpxentM
	RwR/oLz6MkhrruuFemoXScHhn63qmq08Q4/5nOi68v/agUEDDJpH652nz+Xheqgi4u/MHq8VhSyXl
	Y2PLcsQ3+87J2y0k3MDB6uUYOLFLrJvYMUVaQZown8mVnFJ5uXVYffxFKe7e1UmghaHxJw4I6WYp3
	unaIWv8qOhswIclbrkGK/RlxcbEumSsBwDgp+maVPsy5jW7ChUL2hg1nF+7940Nim6IzwPf78g+zg
	RvZEIyBA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8SdJ-009A0g-IX; Tue, 14 Oct 2025 02:11:18 +0200
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
Subject: [PATCH v5 02/10] PM: EM: Expose the ID of a performance domain via debugfs
Date: Tue, 14 Oct 2025 09:10:47 +0900
Message-ID: <20251014001055.772422-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 2047b546ad11..756debf5406a 100644
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
2.51.0


