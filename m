Return-Path: <linux-pm+bounces-30655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ABAB01069
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CC5A6FF0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143F44C77;
	Fri, 11 Jul 2025 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X/Az6YkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C63C463;
	Fri, 11 Jul 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195231; cv=none; b=ZzStwlENFg8NgAexzaTu3y4KhkWDDHtYQ0+O8SSTDZkOQJBZDSkYgjvi/JhP36TiZ/dnJyWkj93SKiFfAp8kooMy3GdchFWKqlji5PVg0cYNP/ByMSPmJKf02gknJqTQoySMRwxfjXoJnu8Y8S5rEZnRykpUjzn34wIRw59FGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195231; c=relaxed/simple;
	bh=bZFjAqMpNX2Bn1HjMR0wNV/ZWX63RPlUWsVc3P8BUrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBonDQ3UTKOpqWMD0pYbguwiDBt0RoZV7H984FjqFck4+NnhiDiiJEAi7oyR6H79avJHg4FZ8A7hC93Aa0upenBYt0OWLJu45BStxnhg9shldT7LWXoX7tJM+rhL5iiSvbImrlifd+FUKomxHEQuyAGnQ2eNkJX7CaDoaqgCr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X/Az6YkM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EObnO+cc/WgACxN797nf72JFs15byawobYYMIsyjHdw=; b=X/Az6YkMNNcic6hXrX7D+Dd4it
	lnZSzd+WGoZ16RgOf4sCYbCcKfEb5OYstcg5S5RElUe77RSbTnhLhjWOa4DAbPMteuJVnldLCse1D
	9Gv+z0/Q9Ylh1YGqFXyEHKmUFJ/Jq6463Qkvb3dhxwuWSlnhOHEH1uglfFisHbXJnTnqT7xetcWS3
	QCW5i+fMgfvbKz4nMU05lT7ApIIB75pPNaV3YR6I4iONJLeqm2aF5IuqMjDi8A7QB6F5dbEIWdLdY
	FdaarAPDnGuBuFlzrN0gXIYOjepLZqekdzO8cORtju0ks86JleJGkBAGKngGr8ui6tPU5vld+drQZ
	a/ytKRvg==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21G-00FAms-EJ; Fri, 11 Jul 2025 02:53:43 +0200
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
Subject: [PATCH v3 04/10] PM: EM: Expose the ID of a performance domain via debugfs.
Date: Fri, 11 Jul 2025 09:53:04 +0900
Message-ID: <20250711005310.20740-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711005310.20740-1-changwoo@igalia.com>
References: <20250711005310.20740-1-changwoo@igalia.com>
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
2.50.0


