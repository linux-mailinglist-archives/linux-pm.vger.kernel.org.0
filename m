Return-Path: <linux-pm+bounces-28323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E3AD273F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D84C7A74DF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA350223705;
	Mon,  9 Jun 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXXGrW+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5452236E1;
	Mon,  9 Jun 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499538; cv=none; b=EoUl8kj3B4n5Ck7MAWkAPGnvCuxMMydA48t/jv8EW54wEb7lmxSw5N6eRK9x1iA4lKCIfvGN2PMM71DB7QS8r+H+46ypZjBVMLsxrmZ64zACaFgmb8TATOVEOf45uusi8JfsnFFHHY6Uxe+LxaVHcQqicJEhiqR6z7zgCcxMayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499538; c=relaxed/simple;
	bh=IeL2jb17nVQNxtQ3Im8moxSVPX9fuLF1EUdc6AVisTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5qdD/Ui/lXWE832XRLRYooK8oYhjKHuMhp/EuUqEzV2kK2F7B3jtnlJjgzSbib9Chv9JkdKWNwb2V4Lh0XV2qMLz2+bmFimduIvC0R31hrVGcx1WhxdCQZz4flPYNcTMRDg8czZpbWShZsJdrhoiz7ykahrDV9GCj4nJGV/JRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXXGrW+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96453C4AF0B;
	Mon,  9 Jun 2025 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499538;
	bh=IeL2jb17nVQNxtQ3Im8moxSVPX9fuLF1EUdc6AVisTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXXGrW+z3QZCjoo7VECEa8hcMZGHdWw9gQS5rd/bfjY44KP6xyo+xdhD9JpN9ney8
	 jorr4Vpn80V9n4trGYV07gmc4JdiYShlKlR75u53qTbaH2Dy8CsRLHwiaFIPzFfujA
	 nzze8sYuMlIxIyoAE+HGD27mP9WthLsvqapvgj5VKBGQDBdfMKCBN+RZ367ryvJJLh
	 ZPP1O546wm1Frwg0PevUibWvz331gDoA1lwcl8ukxKf2rLUdHw21VSagBnI1pF5m1d
	 aMJW/yT+QduPM2G1eB8lRJXcCvtql9DtIo/qI/9lrjFDzEcuIGTHBGsyw+GDS67NYC
	 iLahk8OQpUZUQ==
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
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v11 06/13] platform/x86: hfi: init per-cpu scores for each class
Date: Mon,  9 Jun 2025 15:05:11 -0500
Message-ID: <20250609200518.3616080-7-superm1@kernel.org>
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

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * s,for_each_present_cpu,for_each_possible_cpu,
v7:
 * Drop mutex, move to proper patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 4e991ef1ffb0b..234698696ac0b 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -228,6 +228,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
 }
 
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -310,6 +335,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


