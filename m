Return-Path: <linux-pm+bounces-22131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C749A36A2E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C713AE158
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DFE198842;
	Sat, 15 Feb 2025 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqx2t+84"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C01953BD;
	Sat, 15 Feb 2025 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580786; cv=none; b=qOgKH7T2IYB1edtHXk0FXespRk6RiM2/514Uan2WwSDTyr6T5rO4oQXujylZIkLDRuJKYbE+oLw5iubCj9IKUEW3cvzEe6blRIMLQQmk/5/rsiASZ4LgxDg/hG2Iesdxdn6kWwhB1MIAFoNKYZnV4iHEzAQF5ZLSXDd2/exHhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580786; c=relaxed/simple;
	bh=tsH7iQQGhpINLZSW9Qy7bTeMX/4pXG4ItP+SfaN3uIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUGmydYip4N281mYNLych0JQTLjcU63hSQ1/E11NflrirWxaJl8H97BfgoBkxRelcyJFQkJou1PRWrY/HvrsFIpLdOuBJEyrmBCKihfkjPxSOskk343ng0pNqAwuP0KSeKeaeFiTwP5sfvgyvRgRoVOkd6NPqlJnQCyo5njjL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqx2t+84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C829C4CED1;
	Sat, 15 Feb 2025 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580785;
	bh=tsH7iQQGhpINLZSW9Qy7bTeMX/4pXG4ItP+SfaN3uIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqx2t+84yRDlkIeoMWSlMItqtCULRsSwqGfDYM6RvviC5KZqm0lkaY01VU6wgU4qh
	 DV9dYtj8vGDr7Uq3zy/oC/CqkKO3wZqK2bWJtwMBamujhAbM973YNEP+GxdTrOaDUL
	 gxMOplY/uJg9eIU8iBnxVXmAbC4nHW5kNh+eKCs/oySF+4d/0EBsFsYXkiDHUY2GxM
	 vpzGyw1BAYUpq5mzYpu+kO+SMTqT1WYtKQKcVsJr+Q5tuMbg5V8J/DM19Dd37MAtTK
	 rbR/tmrCXosHT8nfMVtY41dksCcA3EpzS0EiHjJOg+3mmynlm50/2uZD/NmiEdZ3Ox
	 tvZINfTJLyFJw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 10/17] cpufreq/amd-pstate-ut: Adjust variable scope for amd_pstate_ut_check_freq()
Date: Fri, 14 Feb 2025 18:52:37 -0600
Message-ID: <20250215005244.1212285-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The cpudata variable is only needed in the scope of the for loop. Move it
there.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * new patch

 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index b888a5877ad93..9db20ac357042 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -186,10 +186,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 static int amd_pstate_ut_check_freq(u32 index)
 {
 	int cpu = 0;
-	struct amd_cpudata *cpudata = NULL;
 
 	for_each_possible_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+		struct amd_cpudata *cpudata;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-- 
2.43.0


