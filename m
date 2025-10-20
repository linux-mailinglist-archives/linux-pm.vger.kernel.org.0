Return-Path: <linux-pm+bounces-36533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07FFBF3DBE
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 00:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5C3A4EDA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D32F3601;
	Mon, 20 Oct 2025 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bmSaXDyL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C62F2607;
	Mon, 20 Oct 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998251; cv=none; b=Ju+DusuKsNJWaqrffW84SrkQcxn1UTPQBDwQqINGSdlT1uUVTgHWyHcwfBHRCi8eo6ABgrZ+8odtFbsgC1qi8e/YOz9EuQX2rBscCd4HDv4gnu0aKPP42fhLTTCnS+JhPD9TmuWipfeT70Pi7geHhOSFc2pdgeLpwEOc17CmcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998251; c=relaxed/simple;
	bh=tcunxmR/zTKqdwN3YVORhwuR8GlaVaLismfGc1cM0B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmnRIDDj+YWvxrQvPhi1/ptNY9C7pwnmcP6k0P+A+KsxGFvAO7KlcsqtvBY8ETLt/gbl1YRexFTy8hPfVwTVB5v0uS5D5e4vxMZgoRc9VtAKXXDvHz04dm0a3IDvfBi3HqZm/seWat1sv30O+MET+FAvvncOvxjM1Pjs1IgE/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bmSaXDyL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=56/qTQOBiUsBEy0hMSobVkKZCW/WismAzMooYPX/0OE=; b=bmSaXDyLj52Kex+84zfVnTY4at
	6iJm4Leifqk96NPdLc9eQsdQyjolq71KObavKtpv8/69pCVsu5v+fa6TRPLJ062sMZ+bLLvueQbCY
	Vwi6anMJXDz5LKV/CX04jNbFRtLa7dlDLbH46vExMqMky2nKImBbfI4WvGNeZxmDYW3QCooAgsGJa
	ENpvlADKia/6TbvhGT8hCXgE0t+cBBWfp4Ouqg2gLbCa4IMCznZvDNQu0+7894UIHagEh7nLNYBPj
	vfET1zHaPI9k+J/P4oxgYAzEimG6A8jF1q8gDIrb9GxsZZMhkuyMoN7XT3LXM4AXCIldTxO/hcPNB
	V9yu97wA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAy5S-00CHan-EC; Tue, 21 Oct 2025 00:10:43 +0200
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
Subject: [PATCH v6 10/10] PM: EM: Notify an event when the performance domain changes
Date: Tue, 21 Oct 2025 07:09:14 +0900
Message-ID: <20251020220914.320832-11-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020220914.320832-1-changwoo@igalia.com>
References: <20251020220914.320832-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send an event to userspace when a performance domain is created or deleted,
or its energy model is updated.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 9e35aba4b113..e669d5057fca 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -352,6 +352,8 @@ int em_dev_update_perf_domain(struct device *dev,
 	em_table_free(old_table);
 
 	mutex_unlock(&em_pd_mutex);
+
+	em_notify_pd_updated(pd);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
@@ -696,6 +698,7 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_created(dev->em_pd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
@@ -718,6 +721,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	list_del_init(&dev->em_pd->node);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_deleted(dev->em_pd);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
-- 
2.51.1.dirty


