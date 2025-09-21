Return-Path: <linux-pm+bounces-35104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6BB8D420
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 05:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D73BACDE
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2224729C;
	Sun, 21 Sep 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PClitsM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0723ABB6;
	Sun, 21 Sep 2025 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424803; cv=none; b=nEpQYFul9cOccHB4ae3NWccXkPGH+Qbm6SApNjKRMyz16wO36aSMRsdFg/ERjuJzlPt2n/3DuAtV6J22mr9bL3YMJHJjpy54isyQXU5S+w5BjfMe2ART79e7L4QDrqrcPNxq6SzgJJ7dZ69HqOQtoJpekNxAy8bLGeFlqSmXURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424803; c=relaxed/simple;
	bh=vzPToS00sAaSlBa/zWzdMB+aZcRjUHkgd92unQhEelA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awEuJh1OFKBxShdBFLI+UpBoX00xXeN3bYjkgSSVrtGvzpCnQurQJShcHb3jAbSPherpMHvnyQsGpTUGAdFhEUCMeCXUrATKG/AP/JGzUPoOzWjmj8wCBWY8Kp2dQVhpIpduR8OpfsN9QDcV1l1qdQPrKos6wBA+dJ82iSzKyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PClitsM0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8CJZftMR/Gj0POFf8Bpzi7R4sOx8MiU/XCx/07J/Ugg=; b=PClitsM0i4zfF7NIOJV6pdGGnd
	5n0flr0GIK0yJT3gz9BmkAgLnCdMlBHWw2spwRVdvjV0ADet7RAxMepwFxvgMxh9Tgfl7ur28UsHd
	l4coD1JAX0fNBu68ntoZaqZbtumbIxcqosZOcRNyl+28S5LESicabRKMBxyLHwb29iC1L0jXaSAYa
	e5vG5jvS8VdTsGAy3cnSYGHZrztgV+YHvoRY3kVKSovr5dUxImbdTjxISuLlB+AXLmYso+pNp/FXf
	pBsprKQHF4rvyItBhQkYjdqridM2PyGgjDkUsG9SIKj09LNiF77pah/wWL7cWwLn4auqRUIeQqagM
	nVBaMVjg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0Ac7-00EcgN-FA; Sun, 21 Sep 2025 05:19:48 +0200
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
Subject: [PATCH RESEND v4 02/10] PM: EM: Expose the ID of a performance domain via debugfs
Date: Sun, 21 Sep 2025 12:19:20 +0900
Message-ID: <20250921031928.205869-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921031928.205869-1-changwoo@igalia.com>
References: <20250921031928.205869-1-changwoo@igalia.com>
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
index 3fe562b6230e..8998a7f4910a 100644
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


