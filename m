Return-Path: <linux-pm+bounces-19452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E99F6DDE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196A018888BA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAE1FC0FD;
	Wed, 18 Dec 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIIVIMKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDC1FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549130; cv=none; b=a1+YED9VR0OYomz8oFNgvgG3CFAYdaV/SIumx5rCINSQW+7s3v9yXtX/UbKlClDUsmNbGQA6R+arorGZjM5CwU7pAO3K1se8+6taLxZPTWgbPtciAbPjZQXMnSNJjpOTkDKnLmvmA0zdY06B7bhNxSoak2o7xoDMXC6mC7uExAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549130; c=relaxed/simple;
	bh=FNAns3HGMMiWJClk3bjmuwwnGyxHx+RxRdEcce09HEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhU+TRVRYHcRXjqN5G0KYgJx36Km6NHsT4LDq8Bz7PrRuCnZQ7GI3iS3u9Nr//shZmgVyonbT7kJvRn6oSrVKn1Q4nWTniVo5m+e0vGMm06Hw8VeaWopsiY4VVgVRGympZinjmPPD6GxrVMOtYmzEZa8OOhbJLJouoo/VyqWAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIIVIMKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A367AC4CED7;
	Wed, 18 Dec 2024 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549130;
	bh=FNAns3HGMMiWJClk3bjmuwwnGyxHx+RxRdEcce09HEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIIVIMKcOBjKJLTcQ9CFKQUzdqe7+qW64kxViY3ltpZhm3/66RLSsAoUq84a4UM1m
	 rMarLkSqLvQb/Urb7yh3vv1v2NMq2gEiDbICgPjX1dYlbhMs2xbPKu7/C1BV2NDxf9
	 OKlxlzz8xOfFZdTD3uy6ZBfY0m5TJ5qGuTMvKIGvgD08vNYoZLPT/CFfqPBFkj79VS
	 cAxzScRso+kxR3Wwr64k47GEMYaLayiAUi/qjWcUkFawQTeN0ZRfQVcrSKUmQeKDd3
	 E+tLY5ODj5c9UV6Hbie+vKipmw0zOQFgEQ0j9e0VhMd0nYgEJ5X2qBv+3f6XZP7Gqv
	 ja39tiK+ASYbA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 6/7] cpupower: Don't fetch maximum latency when EPP is enabled
Date: Wed, 18 Dec 2024 13:09:55 -0600
Message-ID: <20241218191144.3440854-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When EPP has been enabled the hardware will autonomously change
frequencies on it's own and thus there is no latency with changing
from the kernel.

Avoid doing the maximum latency check when EPP is found. This will
apply to both amd-pstate and intel-pstate drivers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index eb9cc0f106342..fc750e127404c 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -445,6 +445,9 @@ static int get_latency(unsigned int cpu, unsigned int human)
 {
 	unsigned long latency = cpufreq_get_transition_latency(cpu);
 
+	if (!get_epp(cpu, false))
+		return -EINVAL;
+
 	printf(_("  maximum transition latency: "));
 	if (!latency || latency == UINT_MAX) {
 		printf(_(" Cannot determine or is not supported.\n"));
-- 
2.43.0


