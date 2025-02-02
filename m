Return-Path: <linux-pm+bounces-21237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315FA24F24
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145663A50F8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631A1FAC4F;
	Sun,  2 Feb 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkhS3dcR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276A1FAC49
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516398; cv=none; b=kp9/x2KnWJ/TKqSLShS84zXd5bYOL6UbylX8awEGnrDcd3hIpwFz6Y9+KZxQzIZjvYfQJDUm4y5I0a5sx7PCmLwxEvhmYEMTHITKnjoqUvg/x3YIlp6BUl4T2Q9ReZdE9uhEk43Uf4WJcqOzYKQ03B6oPc/duyZJBBcV8OZnsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516398; c=relaxed/simple;
	bh=NXxhaLkNHyjZBr/TAIvYzTDQUP+loMJ8uv5sQozQKow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrWoSQ62OKw6bsBC3Vp0ilGj+K5Vh0XVgDXPdI/5hknvuBjjxSWu2C/TslXO7EkDumI1I+4yEo+zMKbwXOMIrzh8QmGnJkP+LXzt5nyCfaCNNESHrMIPb21L4Jyga95S8WR1R9SWAXt2UA7swuX6SrlimNGhDMANJOMk5JvkT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkhS3dcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA496C4CEE0;
	Sun,  2 Feb 2025 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516396;
	bh=NXxhaLkNHyjZBr/TAIvYzTDQUP+loMJ8uv5sQozQKow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=qkhS3dcRANYumWYfCjNpvqGAZFLkxiUUkOH929W1aerijs8iJ530FOKcs6RYOGieO
	 VSXWAXxohK9mSWhtyDXPRraAGU/n9q7WhE7RxxhKu3+ZNn112FbStwfKLV1QCRGQ7v
	 IHdpw7LV9caNB84wUU+RArTVEylZ84Um6NlYqZxfDj5jZstJTe7mkfnmwxbXTV8ArD
	 kal9KfSp+4J0cMhSCfmU6vcO53cS/AA02QhGniZ7YGVkiPZRdVmR9OOevkgV8np3iL
	 hVuOSSGYSPBX++/O7csMTxoJp4PaA/3pAVzcQzuzuWRi1JErv/TzVbYVmiGUo4XpaS
	 +tCvvfAxDJPYA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/25] tools/power turbostat: Check for non-zero value when MSR probing
Date: Sun,  2 Feb 2025 11:09:30 -0600
Message-ID: <7c6fee25bdf5c8f8a1bcc6fa3566fffb7fe9eb9a.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

For some MSRs, for example, the Platform Energy Counter (RAPL PSYS), it
is required to additionally check for a non-zero value to confirm that
it is present.

From Intel SDM vol. 4:

    Platform Energy Counter (R/O)
    This MSR is valid only if both platform vendor hardware
    implementation and BIOS enablement support it.
    This MSR will read 0 if not valid.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index adcf5f0a0633..6b72b922e2f5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2113,13 +2113,17 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 int probe_msr(int cpu, off_t offset)
 {
 	ssize_t retval;
-	unsigned long long dummy;
+	unsigned long long value;
 
 	assert(!no_msr);
 
-	retval = pread(get_msr_fd(cpu), &dummy, sizeof(dummy), offset);
+	retval = pread(get_msr_fd(cpu), &value, sizeof(value), offset);
 
-	if (retval != sizeof(dummy))
+	/*
+	 * Expect MSRs to accumulate some non-zero value since the system was powered on.
+	 * Treat zero as a read failure.
+	 */
+	if (retval != sizeof(value) || value == 0)
 		return 1;
 
 	return 0;
-- 
2.43.0


