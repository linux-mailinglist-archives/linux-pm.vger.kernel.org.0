Return-Path: <linux-pm+bounces-13715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583E96DF82
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36C6B255F3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481741A01D0;
	Thu,  5 Sep 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUDR3iSQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201221A00F3;
	Thu,  5 Sep 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553437; cv=none; b=Qt9zCR8PoUk2CLqdr5GE1fmN+NocnmMgtYhzBu6cnIYQz0xasMd0sRV7j6wi+Ukyysl9JZ5eWDZwKFuNh8eCx59TbiSSHp2HzADf77udtKYkZx+LxNd3psw53hqgEzjOAV1b5rJakAUpTwkY+NFjBA2QOT/DfQd9nPuZi2X0/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553437; c=relaxed/simple;
	bh=Z3fYQhSzMGh4bomqD58tfJu1KD2iYehN+DZHksXLCls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKsaQdPJUF0nZQBIEQm6UjTjzmEqwDOh/U/uOFyHI+3k4xiIPAMZRuICr5vPlwOzhrFEZS/SGrkZ0QLbcUZaWDIL0bD5Nf5VYWacz9iRvwNNRSA6VswjXntOtHxT74H9nrbEJnJidpil067B9/FF/iqrkdFPoDTIqK5zZtGt2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUDR3iSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156B1C4CEC5;
	Thu,  5 Sep 2024 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553436;
	bh=Z3fYQhSzMGh4bomqD58tfJu1KD2iYehN+DZHksXLCls=;
	h=From:To:Cc:Subject:Date:From;
	b=oUDR3iSQBy+fA6D2FhSNRDOcUD3VCRx4KJ+brtTB44X5t67MYMZB++ODUO/XTXS7h
	 EGV01fIE2fj0Bz8NPTYkqon5CEq7ojJs749OFSb6PzD7io63jNOKxFKpkzaRuRGtXX
	 a478AFm0FIVSytqv1PrCdNeYXHrYkY6759YrWBug6FDmPjNPlvZ1iSX4ukTsJrH0CY
	 YjzIPU0zoPAwBYCxECAlk4Gd3yM10oM8RhjXuEHHLu47kXFwE+xN0eudjXg7lzOG3h
	 DCPOjERdDSpdjqe+LWU/vFg1G3RSUPoRxk4PzKJPK1OKTtcoXoC0nBhr9zp063KJps
	 IkotNr/Eu0ADA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix non kerneldoc comment
Date: Thu,  5 Sep 2024 11:23:51 -0500
Message-ID: <20240905162351.1345560-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The comment for amd_cppc_supported() isn't meant to be kernel doc.

Fixes: cb817ec6673b7 ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * New patch
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9312d4e40994f..19372a077ecc9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1746,7 +1746,7 @@ static int __init amd_pstate_set_driver(int mode_idx)
 	return -EINVAL;
 }
 
-/**
+/*
  * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
  * show the debug message that helps to check if the CPU has CPPC support for loading issue.
  */
-- 
2.43.0


