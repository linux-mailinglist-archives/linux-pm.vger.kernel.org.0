Return-Path: <linux-pm+bounces-28320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CDAD2732
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B83B2B97
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D93C221F00;
	Mon,  9 Jun 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1SKUd0c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9210221DAD;
	Mon,  9 Jun 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499532; cv=none; b=mUzpzg5mqcDkD95tO9pyYvogwPUlKUfaO/FyhIK9aRmCy/y/MyDv8sd/Pg0aGrl71q2gHBx+51ESwGIhhgS2KQMB0/F0ZPZGWOcmAduRFkI4ai5yda4Ee3t4zNNxPZ18Ny5fhuBmvwgBgiQaN1HrqKrYTgm+jBJPxSAsIrF6Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499532; c=relaxed/simple;
	bh=kkos//V5t0x/UeYtEykftE5VkPNQHr/VJTi0wRGvZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDxdEVANwLW+0OWUOu6fWo9J0LuV9BS/QUeA+PejPJfx1H+unPYI0DNIroItqs34hoF0t0P04ecgrY8UwIO2nge0bdm3VFi5c3bPSCUYdx8MAp+SqSj3oAa3902l1RFBSzqjgwbi9DcIp2/2JK/01NoeIujgGhhm5viJHWRebNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1SKUd0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4600C4CEF5;
	Mon,  9 Jun 2025 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499532;
	bh=kkos//V5t0x/UeYtEykftE5VkPNQHr/VJTi0wRGvZFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1SKUd0c/ka5+i2L/ydwfilabOs63+nyhRdVTEGYJgnB68ivuelSGHY/om2faTWMU
	 8rT7p7cobfFu6Net5OQ8Yl81rdpO77zADqOhzc+ocHFsrly53FbWWrw767F5/Rm4I2
	 pS0VUMguohvZf1MuXZ8VA14xnjg+SUgHaCBKRpE36amNySvFhnTMUVzY2ztF1/koCX
	 BKUBuQ/6gFyGSYqmFt06lOH5F3sbvi0l0Dm5dgbESGr2KyvTOnOlNX7o2/v4n5eKv5
	 LcPzRrx0CNoRhfPZps/tCeNGz+VyElHDT3D3L+m60HEnzwKIeu+1Ju4oDXcrYfrHw1
	 fb2EgGZpXzD9g==
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
Subject: [PATCH v11 03/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Mon,  9 Jun 2025 15:05:08 -0500
Message-ID: <20250609200518.3616080-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
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
v11:
 * Prefix new MSRs with MSR_AMD
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b7dded3c81132..4dbf6dbf4c1da 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -732,6 +732,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
+#define MSR_AMD_WORKLOAD_CLASS_ID		0xc0000501
+#define MSR_AMD_WORKLOAD_HRST			0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


