Return-Path: <linux-pm+bounces-22329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFEA3A703
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1A316E312
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850327427F;
	Tue, 18 Feb 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY5JCGHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2F274278;
	Tue, 18 Feb 2025 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905743; cv=none; b=YLBrPLTExHdbUuK73rrTnaTqFSvai8xaFii00v6C/4uHEDIPpZuzc+wcOHFd7SkpwF2NkMratAsTH6/Vs7AcxoKszcYpbGhd4YRd1A2E42ev33DyEh8v5O++El8LpJizOeNt+1FpwBYGSd5jXq562UN1Zj/CR8RMYhoS06dPMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905743; c=relaxed/simple;
	bh=JwZzNLB2QqcUOeCrjAAn6dpWhk01EyVf8Q70EMwrqU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJcSrM4Sv2HDfvISlNWiR1GuMlGoT44ZhLENq9DR6Lw2lAeJHxQJh7rjqZ5d1ngkPsVKM3HDApW1bDrghJOP8i2ZNWmpgWkOwaezYDhdfOGzgIY+rO+ukPaUkwbCVGE20rvWs8JJMezzSKrGkwBmKIpa/DDX2XBqwfr4JYWOvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY5JCGHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD25C4CEE8;
	Tue, 18 Feb 2025 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905742;
	bh=JwZzNLB2QqcUOeCrjAAn6dpWhk01EyVf8Q70EMwrqU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IY5JCGHmmWA3mp0uZpN6GVETeo6+fsk4HmwdJFuSQWyc/fgf1+7FlDj5iJ2hDYWUi
	 j0OMeuYxzfqLJZI3SlDPtXguNOeffRdWeTIrvk31ViNw4dRJc7V/eY58oVbNGYsGsl
	 6IoYiK2BrIUa825DjJTRoPOXJZGTXO8yqQvtumapfkv/Im2q7cGS/94X/zHOhQEyZX
	 AtFmvZDPRFKaARt7I5P2FgnEI+oebcSR1N8ufeCKoHDPFYCgtc1oGmn9x234tWpu4v
	 YCxN+6zKjafYalyJB2wcIugXR7vbr1i8m6ShE3YfiDRPhaDbnUV24uh2qGnmnyEBLh
	 dz8r+Uk52bKVQ==
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
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v8 06/13] platform/x86: hfi: init per-cpu scores for each class
Date: Tue, 18 Feb 2025 13:08:15 -0600
Message-ID: <20250218190822.1039982-7-superm1@kernel.org>
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
index 7ab7ae0ec72ca..e1550f4463275 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -225,6 +225,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
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


