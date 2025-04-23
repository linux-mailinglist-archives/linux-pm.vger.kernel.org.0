Return-Path: <linux-pm+bounces-25985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FEA97C45
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273C27A6210
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1628F2641E8;
	Wed, 23 Apr 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvhKnBTL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BB2641C3;
	Wed, 23 Apr 2025 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372822; cv=none; b=ZssI5fKyFJztJ/U4MARDkiWos5jOmrU00wBkJgjzBOzVOmSKIZZSnq3Q7Y5RGvgMD8ZvjNIsS7BLHLGCtm1qXqPW+xRq1wmr90KRXmUAVSIYMRGostcdk1SSnMn4cR0HxxgrqCzqmTQkDpEX9fqKVAyVidTMMC6RwaJ+eDHJphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372822; c=relaxed/simple;
	bh=GDLiMFYJVSSB/nPwMPmk17jdAFYMoX1EZVp8wXOz79I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj8RJwwKgV8ab+EA+fwmdwyIDyJHklGUN2nZDouHhhE6yJrUpEcBmaFgjTXsi3sBRTcV6pNe1ejN/29Tc9QHrEydaAW8ckfMgQBbj+Pscy4CP2BWV74kLRYTs0PqeFCFfIPFfYYs0UAFI4WJod+xrKTiedl4gPwenmDOt1+8ycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvhKnBTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F473C4CEF1;
	Wed, 23 Apr 2025 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372821;
	bh=GDLiMFYJVSSB/nPwMPmk17jdAFYMoX1EZVp8wXOz79I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvhKnBTLXIfOUW2ErBCCRlq2ahUoFUQdMF7I921v2Wz37faHnFfAZ98muH9UTOYMi
	 fOe52ZROhJd7OGgs0YO20hVPLFwCoIeQ33aTV+SwH6UCvjYiGAJ96l/anyr2W/Sjwu
	 FpYowurIg6G/LStGfRxRW5L/ebtX5KDSnicQi/wpleyTTrO0kBWKSZyXGicOGlwoaS
	 igW3aEdVqAKZx50FW9VQXlTG6AMKu58enXqf0K/dDQd8uGuQWOnU2gZvku9ZO9loYM
	 IqkgM1K8tFwf9Wja70FyAQnQC1i7wjQd/8onZb3/PGkODP2Ole8Ofs195AngQauDs+
	 PxNYHbaptxH2w==
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
Subject: [PATCH v9 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Tue, 22 Apr 2025 20:46:20 -0500
Message-ID: <20250423014631.3224338-3-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74667f36b013f..ad7c9c9d5cb38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1101,6 +1101,15 @@ F:	arch/x86/include/asm/amd/hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp/
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.43.0


