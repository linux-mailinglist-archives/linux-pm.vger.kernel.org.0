Return-Path: <linux-pm+bounces-35291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C6B9B1C0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9943A65E4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519C313295;
	Wed, 24 Sep 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QixLh/Ms"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B72FBE05;
	Wed, 24 Sep 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736219; cv=none; b=kAS2SI6NWrR78/DdZAkqKBQ/LQBcbhxb2JKwhPqdlGtrjwz2GVjafkREhIl5MxEIPr3aMwWprARIQV9CZGQisnRgRM4g0OlqqlH3IEnUDgCUKUyTS3U5mOfquH2Z/ohxJpA2h2xu3Wyu5N3S3EQVOsg5ifEua8rY47iQpdtazT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736219; c=relaxed/simple;
	bh=RZSQgzHalNou2TmX2DVvWqNggX+/vPzil+m6zaYL60A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOb69/NPqfj6mxzJyMzgL+t2w48sc3cOXdLkAQHsf3XRUHulYbS7y0pzgm91/SAyXQLG5+Q0uC2s72r5w8WngQtutnBPAd7rLaT7JizMMdIf0TvffiLXUQjPHz+kiSIxObyVDJz0H2j9jNA2+Wzkvb4yIS6zbOrTm7+HYyNLqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QixLh/Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB6C4CEE7;
	Wed, 24 Sep 2025 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758736219;
	bh=RZSQgzHalNou2TmX2DVvWqNggX+/vPzil+m6zaYL60A=;
	h=From:To:Cc:Subject:Date:From;
	b=QixLh/MsFggy1pHtJynGjUowoIyzuTiOp0JvwoT1eBpSHgJP+PZXyhD/cTTCdeSOH
	 nK5MZMfRRKGTBeD+300GjEMx7Mp6Jwru+W3S4pHnSHdFvZICkPz8lCbqEEjGYZHmy5
	 ySt7o2MYH9TJna9PnIlsb55Rv1xBFstiICkdvGT6ZcsQhB5P9XJZKiDE3Gyt4WW58x
	 tJmFEmm4/twTovrKe/C4CJTjj9r76As6pI6cXlIij0vQThaeg/SBlenvXSjZF0BVRL
	 1/+7a5aB1HZnDsunQvd2T9rjrevG9Rnkhg8BRJIq2aOJ+RISWjJC0RYrK5OgMVluMO
	 PPvsi448tAolA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] cpufreq/amd-pstate: Use sysfs_match_string() for epp
Date: Wed, 24 Sep 2025 12:50:16 -0500
Message-ID: <20250924175016.709957-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than scanning the buffer and manually matching the string
use the sysfs macros.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ba2adea03db1..b8af6cad9e2c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1157,15 +1157,10 @@ static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	char str_preference[21];
 	ssize_t ret;
 	u8 epp;
 
-	ret = sscanf(buf, "%20s", str_preference);
-	if (ret != 1)
-		return -EINVAL;
-
-	ret = match_string(energy_perf_strings, -1, str_preference);
+	ret = sysfs_match_string(energy_perf_strings, buf);
 	if (ret < 0)
 		return -EINVAL;
 
-- 
2.51.0


