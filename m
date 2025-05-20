Return-Path: <linux-pm+bounces-27424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FDABE1A4
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5086D1BA75C9
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CBB256C77;
	Tue, 20 May 2025 17:10:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34B1FDE22
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761032; cv=none; b=kl+Z2JTkNW66kgImTSMx+w3aiCj2fXrpdbdGkOfqegar9JaLK2nvnZ1Xn/3l25t21ISDpDWeQkHUzbpkkgRN7Wu8edyj/lzixqibglw2Tkt5RDTjqYOK2t81NYtuXlArAizhlz5NerA6z6cOZweAtudSUoD7ntZ3rpWrrJxbQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761032; c=relaxed/simple;
	bh=hnSW2l4jOLrLe4fqNw+NIO9Xwr93nTQ2SggXwW11ePI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9/xNzsJvgHucErlbRkiiEF8nWmCG3EOYp2tIF9FRu2OSGbvG97B8ydfMBxdtF9EVKzm/60JECM3R2uTUQjjQWif2JZjYKS77L1k0fZNlc1+TPEYnEQ1iyVjiNkSxGDBCysM7dTWb7C4ZbJtBcMxzi5WRN+s/tpiQgM49e9KsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370541516;
	Tue, 20 May 2025 10:10:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6CB553F5A1;
	Tue, 20 May 2025 10:10:28 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: ulf.hansson@linaro.org,
	heiko@sntech.de,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] firmware: smccc: Stub out get_conduit()
Date: Tue, 20 May 2025 18:10:16 +0100
Message-Id: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various callers use arm_smccc_1_1_get_conduit() to guard their
arm_smccc_smc() calls - since the latter is already stubbed out to
support optional usage in !HAVE_ARM_SMCCC configs, do the equivalent
for the former as well to make life easier.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/arm-smccc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a3863da1510e..97dc4d47c664 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -315,7 +315,14 @@ enum arm_smccc_conduit {
  *
  * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
  */
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
+#else
+static inline enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
+{
+	return SMCCC_CONDUIT_NONE;
+}
+#endif
 
 /**
  * arm_smccc_get_version()
-- 
2.39.2.101.g768bb238c484.dirty


