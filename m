Return-Path: <linux-pm+bounces-22955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF63A456FD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AC171D4D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5A26E622;
	Wed, 26 Feb 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYiki/zG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885226E17B;
	Wed, 26 Feb 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556184; cv=none; b=A9WsftOnN/jhxYagGr3kPRRf/kEuja9SplpgXl/ybKhZs6wZiUd5Y6K10AFIGIkNmERSGYrbCekFd2yAd7XcH/mw3ohOl6kfLIkE7vDXBLd58umrAkQmK2mN6kuGlV4SxeOaDwxWGqvTgsGhwwjExuyQAxaTOI7IbkbnEpxE/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556184; c=relaxed/simple;
	bh=rUUQurfX6uqsZ9IY8GLd9ULbG0hTJFoFjvGUQaHRXMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiEsZY12Tc1a6HWDHekpZ7F3sGy8gdgXASZ/s5xC2lW+MzuIIp0/6aTYPR1FtyTMwelcGdUc7VL4a+4gfch/zaNjeimliPNGFOg4dw4v3jX37uEZdsfDu+96KCoAqBOLXtTXlhZNRp3ZCbAGG14b1Jkq6jUbo8HM1LjLIF2cc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYiki/zG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B8FC4CEE2;
	Wed, 26 Feb 2025 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556184;
	bh=rUUQurfX6uqsZ9IY8GLd9ULbG0hTJFoFjvGUQaHRXMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYiki/zGaGrf9w5yA7PlmRS+3QRoNNzDQ8/DL4UZtp2m8nTTBQQZWvgUsR++BOo8b
	 DNtuwsKpGMtLyFQwrvIyt6jP/3CILWIfhE7hEmqJjw/WTsjh+PAMAFMLJ5MLjps/AS
	 HaWa2I3fi+HQ+1WhSn6ZjMN56mMDuPT0+bPdKSipAASfVDgopEyDuW49cJtnS1d3q6
	 TO9KdCppw5b7OxqNbXwpOqp3/oNN+TQ5MPGJNFW9uR9lml+MnRMx+NppY45EEJdT9+
	 A8+/yeeoWrMT5efUpaxQiAdo2ke0Hf6dAHHo7wZIqbWwNBc99CMkoL3r7MC/lLmdsA
	 +BVgySQHMXDaQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 02/19] cpufreq/amd-pstate: Show a warning when a CPU fails to setup
Date: Wed, 26 Feb 2025 01:49:17 -0600
Message-ID: <20250226074934.1667721-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
populated.  This is an unexpected behavior that is most likely a
BIOS bug. In the event it happens I'd like users to report bugs
to properly root cause and get this fixed.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a093389a8fe3e..1b98f5d76894d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 free_cpudata2:
 	freq_qos_remove_request(&cpudata->req[0]);
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
@@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
-- 
2.43.0


