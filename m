Return-Path: <linux-pm+bounces-42937-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIXlKgtWmGncGQMAu9opvQ
	(envelope-from <linux-pm+bounces-42937-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 13:39:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34871678B1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A753089F70
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995B344D87;
	Fri, 20 Feb 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFMMew1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E663446B7;
	Fri, 20 Feb 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591091; cv=none; b=fcdSHXtmoOMHbVyhAJl7dcnRTx+D1AnNOIJXKgcZtEW+ywUtVQlTFYm7z0T1k3h1kWFs8/z18d5aL+hklDlJvMEf0j9xnAKxDFXl8Y3tSH3oF+QuGbM1KSfbCkJxwcptsRu6W07lT0X4L7nUzbHRlvsAgpWdiBsZ5ftzkBxJORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591091; c=relaxed/simple;
	bh=6xg59RKnatLMK8GVX5ueyxlD/UNx9NrdSSNST8WPIjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAzx7ALh2NYcquOMBQqnMka98t+Q07wJItPWD+lqk27d2e6o2itr+dvXUVNPNBVZxS64uN+pfrdBcLIRzMdmrjI848eWbGu367PYu3nZewiCF2H8qhABca1xL0wWsZ7fbf7V74fZQCt8bhnYldjOlnpg1w8tFHJ2+Zb4ilYfzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFMMew1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156AC2BC86;
	Fri, 20 Feb 2026 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771591091;
	bh=6xg59RKnatLMK8GVX5ueyxlD/UNx9NrdSSNST8WPIjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFMMew1KEhh6eKyGxjVK3Hm17qyKq9T8lj4KIjQW6pifcqn/Wz66ThFWGZC+oKWA7
	 /c2R+TmNZV9gY8lL05KYIG9Lkk3z05lL60GG9+4W0sA0vYmzak2XB/FMjmPD+VmppZ
	 Ds3T5g6/mh7R9eYb3ySg2BZw74mKBm9tZhvq/Ycsx4ebry2ZxequkcVNE70LxX9C4F
	 cPX5KSiaP6o6WIgxQY51K1yZPQW1FZwalCyp0LK77T91U+jbFchXGlwjxEMPH4nc/5
	 XshtVsgyqv4A+fv5pWQXckDWochBJsgyAh/7gyGLnokWzAMjw5tN9nnOj/RhPCUQ9V
	 gKOPlDvGDiQiQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] thermal: int340x: Fix sysfs group leak on DLVR registration failure
Date: Fri, 20 Feb 2026 07:37:52 -0500
Message-ID: <20260220123805.3371698-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220123805.3371698-1-sashal@kernel.org>
References: <20260220123805.3371698-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42937-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: D34871678B1
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 15176b818e048ccf6ef4b96db34eda7b7e98938a ]

When DLVR sysfs group creation fails in proc_thermal_rfim_add(),
the function returns immediately without cleaning up the FIVR group
that may have been created earlier.

Add proper error unwinding to remove the FIVR group before returning
failure.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete understanding of the code. Let me do a final check
on the existing error handling in the DVFS section, which already had
cleanup for FIVR and DLVR (but note: the DVFS section also has a bug -
it returns after removing FIVR but doesn't also remove DLVR, and vice
versa. However, that's a separate issue).

## Analysis

### 1. Commit Message Analysis
The commit message clearly describes a **resource leak bug fix**: when
DLVR sysfs group creation fails, the previously created FIVR sysfs group
is not cleaned up. The fix adds proper error unwinding.

### 2. Code Change Analysis
The bug is straightforward and real:

In `proc_thermal_rfim_add()`:
1. First, the FIVR sysfs group is created (line 447)
2. Then, the DLVR sysfs group is created (line 468)
3. If the DLVR creation fails (line 469), the code returns immediately
   **without** removing the FIVR group

The fix adds a conditional cleanup: if FIVR was created (checked via
`PROC_THERMAL_FEATURE_FIVR` mask) and DLVR creation fails, remove the
FIVR group before returning the error.

Interestingly, the DVFS section (lines 473-482) already had similar
cleanup logic (removing both FIVR and DLVR on DVFS failure), showing the
author's intent was always to have proper unwinding. The DLVR section
was simply missing the same pattern.

### 3. Classification
- **Bug type**: Resource leak (sysfs group leak on error path)
- **Severity**: Low-to-medium. A leaked sysfs group during probe failure
  could lead to:
  - Stale sysfs entries
  - Issues on subsequent probe attempts
  - Resource leak
- **Fix correctness**: Obviously correct. The pattern matches what's
  already done in the DVFS error handling section of the same function.

### 4. Scope and Risk Assessment
- **Change size**: +3 lines changed (adding cleanup in one error path)
- **Files touched**: 1 file
- **Risk**: Very low. The fix only adds cleanup that mirrors existing
  patterns in the same function.
- **Regression potential**: Extremely low - removing a sysfs group that
  was just created in a failure path cannot break anything.

### 5. Stable Kernel Rules Compliance
- **Obviously correct**: Yes, the pattern is identical to existing
  cleanup in the DVFS section
- **Fixes a real bug**: Yes, a sysfs group resource leak on error path
- **Small and contained**: Yes, 3 lines in 1 file
- **No new features**: Correct, pure bug fix
- **Tested**: Acked by the subsystem maintainer (Srinivas Pandruvada)

### 6. Affected Versions
The DLVR feature was introduced in commit 5bc6b1df65c87 (v6.4..v6.5
cycle), so this bug affects kernels v6.5 and later. Current stable trees
that would need this: 6.6.y, 6.12.y (and possibly others depending on
active stable branches).

### Verification
- `git log --oneline` on the file confirmed commit history and that the
  fix is 15176b818e048
- `git show 5bc6b1df65c87` confirmed DLVR support was added in the
  v6.4→v6.5 window, introducing the buggy error path
- Read of `processor_thermal_rfim.c` lines 442-486 confirmed the pre-fix
  code: DLVR error path at line 469-470 returns without FIVR cleanup
- Read confirmed DVFS section (lines 473-482) already had the cleanup
  pattern the DLVR section was missing
- `git tag --contains 5bc6b1df65c87` confirmed affected versions start
  at v6.5 era
- Commit is Acked-by Srinivas Pandruvada (Intel thermal subsystem
  maintainer), confirming correctness

### Conclusion
This is a textbook stable backport candidate: a small, obvious resource
leak fix on an error path, with minimal risk, acked by the subsystem
maintainer, and following an existing pattern in the same function. It
affects Intel thermal driver users on platforms with both FIVR and DLVR
features when DLVR probe fails.

**YES**

 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 589a3a71f0c4c..ba88d878c998d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			break;
 		}
 		ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
-		if (ret)
+		if (ret) {
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+				sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
+		}
 	}
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
-- 
2.51.0


