Return-Path: <linux-pm+bounces-27210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C50AB918F
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26854E62F6
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C028C85D;
	Thu, 15 May 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ams3THYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41628C5DF;
	Thu, 15 May 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344004; cv=none; b=o14G95Kot+RNSEDxBfrVom7H3y7ENaqhCbIQTncYAw9fMn9XvSsb7tmznMsLhqGPEgGVPbgXxjHMfCpjdtHFojSA2aN4URsQC5O7KvhGFxXpn/m/VcDiUihSJGuqcUdCpA7ysSLCaYjnfc8FViHqlXks9gmLUxa9NXjpr41suHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344004; c=relaxed/simple;
	bh=clP7AkFKKUaIpuy0+IvByQA/4XreAJXjxCjAlqwDY4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV7JdM0xfJA9IiHbV1c17OXrB5A3Cztflh/UY9IIcMNMnHkQr1vIpna+kMCl/wcHLU49gAbsGSHM3t09J+xm6h5qAfs/Lz+X+IlFn53YT4yKttXbQyiDyA/n2xonUR/1tTQPs+DJj6qhJjestQCeP29BSCXwkyWGYToAIDUcA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ams3THYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA305C4CEF0;
	Thu, 15 May 2025 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344004;
	bh=clP7AkFKKUaIpuy0+IvByQA/4XreAJXjxCjAlqwDY4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ams3THYIaBVJ3DU9YFQUgzWa48MT/syXawNxgSrvn51seD9NZA9hG39RUPFd/1Ffa
	 TMu+uQajB5lpVP+8RAnWKF8mrJNkzGVHcOtCefdX4almGu34jNJ8y/6pyT7THrcNUR
	 UGvOrPy+PHd3dKK8M1sXFLFJMMIgD/dF4Rg/lWeW1Jv7Nridw398cDv9lLoeazUsqg
	 uvedWPcgMFg0M5RHX8ANCV+dXdw1wE7Olsqs8+B96ksbMqZN/s5/Lt4+EBhoMiyyvv
	 3RKg7favEn7msQJveefPnFk61pXgj620maWLBrra+SDdm2czl+QIWEyFaj1ZGMwRu4
	 RHrPIJGUD8ELQ==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH v10 03/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Thu, 15 May 2025 16:19:40 -0500
Message-ID: <20250515211950.3102922-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515211950.3102922-1-superm1@kernel.org>
References: <20250515211950.3102922-1-superm1@kernel.org>
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
index b7dded3c81132..8e6db9a9f53c0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -732,6 +732,11 @@
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


