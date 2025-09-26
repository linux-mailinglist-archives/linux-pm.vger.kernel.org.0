Return-Path: <linux-pm+bounces-35433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A01BA2440
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BCA7B543B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8374266EE7;
	Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsZEJ6x0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D7266B40
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855269; cv=none; b=a2kAQOs6b3PJTZ3v/nqypWCNhC1Dj3xV/RHv3DrBrcL48bgOXNB1DaQQvBBI4NZEtHYcxhri33TqP4B3hITSFMQD5UErA0+rjtZQi2rDalzJ3cUM2x3azwKTKcCxP0f3DMZLiJjzakMuYFdNwVqSt4stAt59q75doVKTk6lDGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855269; c=relaxed/simple;
	bh=uGJU4z8NmVYkeZj2aZtVvRlSD30DqZgmiScbyJwWTro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJkLDYV1eEMB6NvTPE/dhMTYOArq/vR/KTCfFkAIqZd/POcx1fkVEpNI32WyxMffcM0eFm08zi4DdT4vH7T88kZFIXIzQbStK5Eb90wumHQsxGo1rlrym+ekfLlmOtzjMEZJfL4E98tez1gglhFHlNch76KOdiAePoJK+PWl4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsZEJ6x0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EE4C116B1
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855269;
	bh=uGJU4z8NmVYkeZj2aZtVvRlSD30DqZgmiScbyJwWTro=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=DsZEJ6x0zAVjETPg0UE7AAnJMXi0eyBtKdHmnFA0bktjciAgebBBdOU6XfyIrmV0F
	 isshg6EHf2Oo2MDi1njP/SL7jfDWDEVjpGJBMorg+byZQofKBKlNZ3zD3gnBs7j0NT
	 DsAXjbP9fDCRMRt3CSMSu422v5uOE2GIanN2BG8u50dLr9r90HVS85VHGoCnGRc5me
	 SiNFl+sHho3SGUCd7Q9xD+PHabJZCS9yHMwAz95JHkHvJ55AI7c85MilFKRapfDaJZ
	 RBnkz+pk/VVF43sX4rcjYSSZOg2AJxBCWvvEuVHcVmt1rhfxtBNMpITaoCketTOLxa
	 XopSqunonnouA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 6/7] tools/power x86_energy_perf_policy: Add make snapshot target
Date: Thu, 25 Sep 2025 22:51:08 -0400
Message-ID: <b1a127d979f478a833a7688fcc434a68cfa34305.1758855052.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
References: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

$ make snapshot
creates x86_energy_perf_policy-$(DATE).tar.gz

Which can be transported to a target machine
without needing a kernel tree to build on the target.

Useful for creating debug versions.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../power/x86/x86_energy_perf_policy/Makefile | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index 666b325a62a2..d18284667400 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -1,8 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 CC		= $(CROSS_COMPILE)gcc
-BUILD_OUTPUT    := $(CURDIR)
+BUILD_OUTPUT	:= $(CURDIR)
 PREFIX		:= /usr
 DESTDIR		:=
+DAY		:= $(shell date +%Y.%m.%d)
+SNAPSHOT	= x86_energy_perf_policy-$(DAY)
+
+
 
 ifeq ("$(origin O)", "command line")
 	BUILD_OUTPUT := $(O)
@@ -27,3 +31,26 @@ install : x86_energy_perf_policy
 	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
 	install -m 644 x86_energy_perf_policy.8 $(DESTDIR)$(PREFIX)/share/man/man8
 
+snapshot: x86_energy_perf_policy
+	@rm -rf $(SNAPSHOT)
+	@mkdir $(SNAPSHOT)
+	@cp x86_energy_perf_policy Makefile x86_energy_perf_policy.c x86_energy_perf_policy.8 $(SNAPSHOT)
+
+	@sed -e 's/^#include <linux\/bits.h>/#include "bits.h"/' -e 's/u64/unsigned long long/' ../../../../arch/x86/include/asm/msr-index.h > $(SNAPSHOT)/msr-index.h
+	@echo '#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))' >> $(SNAPSHOT)/msr-index.h
+	@echo "#define BIT(x) (1 << (x))" > $(SNAPSHOT)/bits.h
+	@echo "#define BIT_ULL(nr) (1ULL << (nr))" >> $(SNAPSHOT)/bits.h
+	@echo "#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (sizeof(long) * 8 - 1 - (h))))" >> $(SNAPSHOT)/bits.h
+	@echo "#define GENMASK_ULL(h, l) (((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 - (h))))" >> $(SNAPSHOT)/bits.h
+
+	@echo '#define BUILD_BUG_ON(cond) do { enum { compile_time_check ## __COUNTER__ = 1/(!(cond)) }; } while (0)' > $(SNAPSHOT)/build_bug.h
+	@echo '#define __must_be_array(arr) 0' >> $(SNAPSHOT)/build_bug.h
+
+	@echo PWD=. > $(SNAPSHOT)/Makefile
+	@echo "CFLAGS +=	-DMSRHEADER='\"msr-index.h\"'" >> $(SNAPSHOT)/Makefile
+	@echo "CFLAGS +=	-DBUILD_BUG_HEADER='\"build_bug.h\"'" >> $(SNAPSHOT)/Makefile
+	@sed -e's/.*MSRHEADER.*//' Makefile >> $(SNAPSHOT)/Makefile
+
+	@rm -f $(SNAPSHOT).tar.gz
+	tar cvzf $(SNAPSHOT).tar.gz $(SNAPSHOT)
+
-- 
2.45.2


