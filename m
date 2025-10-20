Return-Path: <linux-pm+bounces-36454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D8BF0030
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 869D14ED984
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D62ECD06;
	Mon, 20 Oct 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DGjWvPCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1B22157E;
	Mon, 20 Oct 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949915; cv=none; b=TS5AyQRjw/d+ISGMOEEnaMn4YDnZ4mTAic6eFzfcu+k4yzJbk/A08tNWwctu2w/pAOGp9sTOSXJToLUREVfh7T8evuM9WJTsqXCJX8uWi14de1+4OgXgxpHLJD7yZeUTRhXFUpfDrmK3WZrnNDXhVPt+2tqPs94E0GO831UdSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949915; c=relaxed/simple;
	bh=4emvamnxeVcZ7PnbszrmZ5Ey1SXW/RPYZYBohuaxU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYcn1cSshpJMBj16bMsJOB4NmRfDd+gN3izkNQbvi5bmQCRaLcqTSbs35fIm06BCBWud1x4J5tfyg/338mmlTwbIWNUg3VPZXtZw06nbK6pXxe/2LcL5RXzWjr/07r30/LapSvddPYe3nwAdP9YgBHx6arSB75a513RMKuMCksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DGjWvPCk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cQ+W9Pz7bUHF75GeykvdTCCj3llsnLUvXgSmSak+v08=; b=DGjWvPCkVHonsBt5WCMgdkSDv5
	egS2lHn/WDWNRoTcTlVO8mYonrNGv8TSTw7nNK1pZW0vxyK+EM0ugghYKsyM0B8Qz+ynlWoAdQXff
	wVQum5jPSkmN+BG9OryOCWot1JZaj4OTMRwlXuh4JhfEjBUYHZ4q2nemHSxVlNTl4Q6bFLKAmEClz
	gfqKp6ruaRqzJqT+vLhBGO1JxKr/bhaxT90ySLo1TpUuyFxkB/+kjYJ70Oe91lbgWnxEkG2D/vcmK
	IvD/NzxIpKOE1d11N5LIXqkr2UepvsqjWaSxvzt1dv2OlpA6rKAOW5xjbf1JIMB9CC2eG3Zxi+MBq
	j6JZfT6A==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAlVm-00C1op-NO; Mon, 20 Oct 2025 10:45:03 +0200
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
	Changwoo Min <changwoo@igalia.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] PM: EM: Include the iterator/accessor code for the performance domain conditionally
Date: Mon, 20 Oct 2025 17:44:29 +0900
Message-ID: <20251020084429.230322-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020084429.230322-1-changwoo@igalia.com>
References: <20251020084429.230322-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_ENERGY_MODEL is set but CONFIG_NET is not set, the following
errors are raised:

>> kernel/power/energy_model.c:1003:5: error: redefinition of
   'for_each_em_perf_domain'

>> kernel/power/energy_model.c:1022:24: error: redefinition of
   'em_perf_domain_get_by_id'

That is because these two functions are defined in em_netlink.h (empty
function body) and energy_model.c (actual implementation).

To avoid the compilation errors, conditionally include the actual function
implementations in energy_model.c when both CONFIG_ENERGY_MODEL and
CONFIG_NET are set.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510151232.UNZ2J7TZ-lkp@intel.com/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 92c12b5983ed..e669d5057fca 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -1006,6 +1006,7 @@ void em_rebuild_sched_domains(void)
 	schedule_work(&rebuild_sd_work);
 }
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 			    void *data)
 {
@@ -1039,3 +1040,4 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
 
 	return NULL;
 }
+#endif
-- 
2.51.1.dirty


