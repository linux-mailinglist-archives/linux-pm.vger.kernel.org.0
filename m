Return-Path: <linux-pm+bounces-22325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D916A3A6E7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D281188CD0D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A8270EC2;
	Tue, 18 Feb 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skXq7J+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD726FDAE;
	Tue, 18 Feb 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905734; cv=none; b=ooRQ2ojgmL+ksK/KraQf/2N+K8ZMvObn4/2yr6hz16tMG6U8/3I01FEw3w2g1sdA5dAvbKvjrEVsMbkRAbIVdryzydelq0Ryn9FGSiFjl7Ef06EHXcgTsPsZf6W4jrfiEuyJXkzLsUzfEQtTQWVSCjjNWON8kMaPdmj5DMnJPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905734; c=relaxed/simple;
	bh=9qaXcaBCFsKmd+V7XAdrwxOKh1ZrVcJwI/csElZRrAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyn5oMMYei7JJMwghs9vtsVkuw7u6HArqjz2SScf3P8JNe1w2yKXedzVOpx8+DwyOEUXqV7caufg/ahgVZ5p8tZPoOgvX9421TCTu7eXpNwqBNxjXDC9Ec6jbj3lWnpvaCsEcLRvilD0RaS+YzIf1XnmZrgsNB10o9kMjREKFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skXq7J+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF2C4CEE4;
	Tue, 18 Feb 2025 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905734;
	bh=9qaXcaBCFsKmd+V7XAdrwxOKh1ZrVcJwI/csElZRrAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skXq7J+4D5ECdBf+r2sCIi7s8l85kK9m5GWbJNb9130USnBCV8aohAIP6VDhFV0Yp
	 JLo2R+bdCG9JKJU5DSitQp8p3LJH4M9v10oAF2rBs9OP25+fPRSJDMWspnCyaWhRi6
	 zGwpseTiOgcZ7WXDmZuhYG0lL+pEjv0gXHxj70NRtk/JknuWqA0TF24G2bkhvgHDvC
	 HgoOUrasPQFn87xMuEmUI7fO24/L/nUKE96Xbpuv1loiT8eXFS+2G6nF9uI+VJHT/g
	 mexnB+rADzNK5ehtK+LiYZaaKWxshc7lvcWwKn3CGURxLtMUhC0WaiWLM0WHt2VbhS
	 QHyvumJY1pWvQ==
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
Subject: [PATCH v8 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Tue, 18 Feb 2025 13:08:11 -0600
Message-ID: <20250218190822.1039982-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
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
index efee40ea589f7..2c85c16d82770 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
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


