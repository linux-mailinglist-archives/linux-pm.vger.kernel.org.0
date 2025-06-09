Return-Path: <linux-pm+bounces-28319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17262AD272E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53561894635
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB24221704;
	Mon,  9 Jun 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnGdVmER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFB221561;
	Mon,  9 Jun 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499530; cv=none; b=FaNiHoTqxS9cJK7zdsrk1QXS9qdqN9FgmN4VX7tBcTlPlY1IIsu3oCSwxj2hK6iVw73IC20RtgY95zKFKXDlrLiaOCgNVZDmNGt5u0rjeqUv3aDF8L4IyjMqgsuI3xHLvTHg06Jt0FV5U0qYQUeHNCiJEsDOYs3qreLJxOyKx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499530; c=relaxed/simple;
	bh=xd0ANTCIAhb5Zjtakv/7sLtRH2DzucNIAXwrLWGgIz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpCmHN+75twoCINswU8DmN4FtAP2lY8xBOdhHrTlxVOwGIFRizwc1S+46OqoDD3vDoF+fmTTxIsJAMfDZJDcvc6fPXM4xW4yJukducAvCo5pKVARt44Lf+xVem1l3JrDbj+mWEq/0xT3rHUYX3rKlSRqJrCLm73Gyxf3YB6GipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnGdVmER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBCC4CEEB;
	Mon,  9 Jun 2025 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499530;
	bh=xd0ANTCIAhb5Zjtakv/7sLtRH2DzucNIAXwrLWGgIz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnGdVmERsc8x5mmlV5akc6NtGvdrQGnXb8o+Vev8SjLffnbAdyTgnhvxJmK9/fJEq
	 1+NABlWeI5H+jE1gN8F2BlZdXoAUB8AsWloFmKfiiAztXTXHed3NJ11C7pEfiw75Mu
	 UpMYmRLjNcTiAyB9WLeTQtuQjk8TIHXIKZqFsgux28poO/FylSJ+txSLH8fUpKrRXd
	 HI4uIM4jKWF8Mat2+mpfxJf0ZI46PjYCz+BgRLPm413ZoZ9tmxihkIYNK2xApz0oR7
	 SN5bQ1rvCDwkmOvIGslqu2UZ71dF9FUx6kMax4U4iE3PC4+50rG8g9CWK3fF1EDfNL
	 SmwPtr0Z8tlAg==
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
Subject: [PATCH v11 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Mon,  9 Jun 2025 15:05:07 -0500
Message-ID: <20250609200518.3616080-3-superm1@kernel.org>
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
index a8da72b0338da..748889bf7af96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1112,6 +1112,15 @@ F:	arch/x86/include/asm/amd/hsmp.h
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


