Return-Path: <linux-pm+bounces-33437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1FAB3C38B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609C91CC413D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DA22068F;
	Fri, 29 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upw+IZAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D121C16A;
	Fri, 29 Aug 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497700; cv=none; b=uTc2ItwcbmK/orwYZlKHXbQdSwIdvDMcFytARGJsbx+6mhRyMnLVFiKREX1F73sQZyAmXDLaRyF1r4Y3IOfIX0QeCXjHk0I5SlmuDPYX78A+7ouZ00O8iNFtgNPRfCEBiViy+60a2aWJZqEGkadkCnlf9Ky2iDXWne11uopBotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497700; c=relaxed/simple;
	bh=xLaLGvpCBWPAS7+YawoNMoagZhEWwzZiPc48GDfEsXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hNf9LAyObwMS54CN6Xhi4FZrW1Gyr8Bsx/lTyK70HAsvsCAvg7CiODeRFpVi4hm8GJAFJyRpocfTVXRv4q6Yvj0rI2eKtQA0L7tMfV1jOv+MI5MYkgbDEPpd4piz4ZGcBRh58gATwYzCZAIoYW5T67+7Hqpt0+Cdu6T2HxVn4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upw+IZAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49018C4CEF0;
	Fri, 29 Aug 2025 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756497698;
	bh=xLaLGvpCBWPAS7+YawoNMoagZhEWwzZiPc48GDfEsXg=;
	h=From:To:Cc:Subject:Date:From;
	b=upw+IZAztXMSLwOlk7m+e0G61R8unozQ0PquOZrLrOgfJXa6jvwCI6Ngc2F057xOP
	 ujMHyzdjgfQJcoxafIkefebIJOK2U+j9bZMvaZzsVXwRMGM1Qqa8sggVC/neqlyLgM
	 /z/4GQ8lOtw6cGBY8iS+unjY76yYJsG1U5wca4FbDWeBpVdiuE1B7x3Qe8e8MBRmMK
	 QpJ0oz5fuDljEunpW7SJ4x6a17V05AMHPQ0Wr22R9vuhNqfCMyzY+UT5Y9qhyY9TCH
	 22IRBWLlXi766woVIVhAZ85Is0YLWENoQs/gT2z6GtJHuvbr+bF01tUfjYWFJ0VJIV
	 Pv6RFoOxdG8ZQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
Date: Fri, 29 Aug 2025 22:01:32 +0200
Message-ID: <12740505.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Christian has reported that commit a430c11f4015 ("intel_idle: Rescan
"dead" SMT siblings during initialization") broke the use case in
which both nosmt and maxcpus were added to the kernel command line
because it caused CPUs that were not SMT siblings to be brought
online during the intel_idle driver initialization in violation of the
maxcpus limit.

The underlying reason for this is a missing topology_is_primary_thread()
check in cpuhp_smt_enable() which causes that function to put online
more CPUs than just the SMT siblings that it is supposed to handle.

Add the missing check to address the issue.

Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initialization")
Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during initialization")
Closes: https://lore.kernel.org/linux-pm/724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com/
Reported-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/cpu.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2710,6 +2710,12 @@
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
+		/*
+		 * Avoid accidentally onlining primary thread CPUs that have
+		 * been taken offline.
+		 */
+		if (topology_is_primary_thread(cpu))
+			continue;
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
 			continue;




