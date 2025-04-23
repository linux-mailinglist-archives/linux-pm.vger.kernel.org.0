Return-Path: <linux-pm+bounces-25986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63161A97C4A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F30189BE05
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A5264A86;
	Wed, 23 Apr 2025 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMAzY9Pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096C264A72;
	Wed, 23 Apr 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372823; cv=none; b=gBzi2hOSsKHr6K1ZQZrPl+EKVkXVvJ9nGP063f4Z0Q5TdNRCkcpWtGCA0EI6Sv8xsBRDVKuJTNV8vsMZ4XKorlnAQ3loHkN99oQiMhhlR4N65AF/x5JTAYgxbz/A3TfH0KwKZq2CfRLEEYxJBjnMPXK3McpXYRs97DGZmgagqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372823; c=relaxed/simple;
	bh=UcQq1FFSIkxtUl0R2B0U9yrBSqRLeyIDteqW0GNuh/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihgn63tLI92mEmxCgcBF/zu6Kzm7qRFu8MgQg4BL0P7cQ18BF/uRHa4012DvKPN6ql1+pvtMP0oIUb46/NnecnfZ38rJSQJDcwMGdM18a4ngdVqPteR/lRvMQaR66avaSxdINkn45t+XJOMHvrPogz9BdJsP+UwqEzuLtrEgT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMAzY9Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B990C4CEED;
	Wed, 23 Apr 2025 01:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372823;
	bh=UcQq1FFSIkxtUl0R2B0U9yrBSqRLeyIDteqW0GNuh/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMAzY9Ppey6y7/HLO4nPRmuCxvZhpD465dwB08aAXptGaY90P/3mPUKK8+zUGMYDK
	 gIhVc3/vzfJxBUSeWzaQ6GzH9RC69vJXzO4eJ7iaC3J5WdTPlZ99TbWLoBUh/EoGMX
	 hq5X5v6g8qCAhBiq4P+FRTnvy06WdVI7hNrbo9rRyssbNHBNFmW286gRjH/zsCGcbx
	 8yLXjlIVVxevh38vTqt+mSovpp4Pj1DTYc2fTAu3JrErDaRK6ceK68qMpTDkI27LWu
	 KisFJrCZt/ExHk59165UxO2MzC1AKJVZUU5g0jgjmuaekWKG85QGmsz9Fo4cuMfVXh
	 POgWn5yfavniA==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER)
Subject: [PATCH v9 03/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Tue, 22 Apr 2025 20:46:21 -0500
Message-ID: <20250423014631.3224338-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423014631.3224338-1-superm1@kernel.org>
References: <20250423014631.3224338-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ac21dc19dde21..0c761033aa714 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -724,6 +724,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


