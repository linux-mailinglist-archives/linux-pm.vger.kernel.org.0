Return-Path: <linux-pm+bounces-39068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC0C9B82E
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5475134727A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6A2522B6;
	Tue,  2 Dec 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEqTSIoI"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D36D518
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679539; cv=none; b=kGCTUzZOU6fyaQS4za9uNqwVVfFn4q6wAgCwWr7pH+WGW1xoNQrvHC9mo84LZOS+aJ5nYcFvX7mCMNqJfjixCbZOTOdyuRt7DO/TPthMz6lfYA/n6JEPez72OygJ+gDMq5CZkd2ELJUVINjqjlR/6cdeXE9NL2cTel0iDUciPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679539; c=relaxed/simple;
	bh=QvxPTUgn6Ah2jhGlpw/IJRkeNvZ6zrytATxD987tgSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSsaJxmexvOJAmNu76qb2u3IB6aU3MAl2mqrZRNlvzFL68eIyaF8Zt2utGj+5419y/gahIpPJvYxa65BBi4Zw2l8LbTeAbJmjuLCtHWJ5g0ZGMLF2S8oum6jfZj/b4s1ntfES/ReqiiLjUh7aDMf7UfwwJlpc1r5Eb1p1ad4oVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEqTSIoI; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764679535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhwXTuIf2AJ/RF/yCH2U5EKcYR+WCpfYISUflqDshkE=;
	b=gEqTSIoIFbYho/IFjKbPggb3FwwNr3MAVIRRvbZ0ezkAbgDrxTu15CzsNa0JrtoqhSnTNg
	yizv1kUqLF6yVkAS40/Uy4fz0rWP0ocygtT7aWYjftv2T4+8PbpOXMkgB2DXBXix6IxwoW
	VZIlMOYFxbMq3Lb5mGSWKsf5wJWgpzc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Renninger <trenn@suse.de>,
	Borislav Petkov <bp@suse.de>,
	Jacob Shin <jacob.shin@amd.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: amd_freq_sensitivity: Fix sensitivity clamping in amd_powersave_bias_target
Date: Tue,  2 Dec 2025 13:44:28 +0100
Message-ID: <20251202124427.418165-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'sensitivity' was never clamped to 0 or
POWERSAVE_BIAS_MAX because the return value of clamp() was not used. Fix
this by assigning the clamped value back to 'sensitivity'.

Cc: stable@vger.kernel.org
Fixes: 9c5320c8ea8b ("cpufreq: AMD "frequency sensitivity feedback" powersave bias for ondemand governor")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpufreq/amd_freq_sensitivity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 13fed4b9e02b..713ccf24c97d 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -76,7 +76,7 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 	sensitivity = POWERSAVE_BIAS_MAX -
 		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);
 
-	clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
+	sensitivity = clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
 
 	/* this workload is not CPU bound, so choose a lower freq */
 	if (sensitivity < od_tuners->powersave_bias) {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


