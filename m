Return-Path: <linux-pm+bounces-27209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D95AB918A
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1BC188E282
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8107928AB0C;
	Thu, 15 May 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcHtWql+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAC28A714;
	Thu, 15 May 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344003; cv=none; b=K8ywEPUFSmhJ7yLenPVe2KRbDwprHkdI0HQMBhvC9MF7gSY9jdSxaHXmvn8sVlFNWEfzZEijYWmr5VHf4H3ZVWJ97z6MJlEHGKfRYVBclcsttPbRhBfbpicPuC6SetnKOkbtHwQ/DTCnXyoFttPnAgAdep391V9+hDlhEOCN7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344003; c=relaxed/simple;
	bh=kSO1RcrRmbpu2jI/kFy9WAUOJT0oJZHI8uzfRcQZa8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxeiDvrF10T9grjuZ54UZ5V9k5F8upBV7nQizWFyaC+UYVjyjb3JLLm2+6VDMEMLAOkFWlxn8tqbI8YZzrBQvZY8paqR7Rs3tZkCHWSCdyGYyEGao4D4QddZeTILn6bIgET/u244RfBGOKypBuxOnjJ730HSmQGi/sPMbqZjExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcHtWql+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0184DC4CEED;
	Thu, 15 May 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344002;
	bh=kSO1RcrRmbpu2jI/kFy9WAUOJT0oJZHI8uzfRcQZa8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcHtWql+EvBBv0tnyG08OSm3xGtJfoBSHayrDhn37wGD5EAbhn6EQl6keiXncLkEw
	 8kPElFjA5B6ZmYArN/p8xrM7LP0nI5F3jo81AmgwehLM1IzW0WL+Y8rM80RxAfaoLl
	 hcy/na+l6wkhgdIb8lpKbWKnzAuHeTNrxJ6nB6YrJKM1wAHXHfV3fj6Ejq2xGSB9+g
	 S+4wUhF/QgnFwpN0argltJhr4CAyGAlOIo/XeBOdE4A/HF44UKQ+3t2gqa5Q88nhB1
	 f2womG/Ekowb7OjVDaYYHbWgQ5dIVCCYvlmUV5KrAGPw/VypC+KKuBtCD6x2mPbKWu
	 wYLWuUnZDsT4A==
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
Subject: [PATCH v10 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Thu, 15 May 2025 16:19:39 -0500
Message-ID: <20250515211950.3102922-3-superm1@kernel.org>
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
index fa54602b59022..6920afed09e8b 100644
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


