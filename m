Return-Path: <linux-pm+bounces-32096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D9B1FB28
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE08177827
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96826CE36;
	Sun, 10 Aug 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKrRepaY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B06275AF9;
	Sun, 10 Aug 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844764; cv=none; b=X9xMi9C8YGMUblh+HGRCtTYyyYXR9JXUnkXdN+WJvFqZf9r5JT/bDzn0SfIETJ9TpDL8MtCkV+no90qN77m4jUTdIp3pEZBQQUpbeE+MalPfeEUyA8F60n2lj/cp5yjiND5MBFV4il+d6uPr11uEmDuAGLorfKOucZ73lEvQPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844764; c=relaxed/simple;
	bh=OoDRiPRX1BtydS+qR5v4MHwWzstYDTih4ukU7QuiKt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzNXucQ+tnXAqo47tIQjMi/e4Xw/Buj7bXR0sQibIxwn4DYo8kehNH1cA2nUcBGmuSLqpOXAkF5xPL+7uco25TSTAJ/4U5GkhAQxJdkufK9FtZEKtmNiwIInWDOcooKfKPRVhcPfwYJ4Na//v6nEW15vGY9HF0JwTa9ClRZa2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKrRepaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68795C4CEF8;
	Sun, 10 Aug 2025 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844764;
	bh=OoDRiPRX1BtydS+qR5v4MHwWzstYDTih4ukU7QuiKt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKrRepaYl7wnjBma3GWv3KO21KrTsmGTmFYBJZ5QI8Z2Vyu9yD+hK1D2xFy4/so3F
	 e2D44xLPQzA9AIEgtl3O9ReQ8uPM7udxSkfQgaS99F2pe3Y7Wkgwxqonh0uiFEB1oG
	 IAFaCLBgUg8cOPU73umbE/xy3vO/V+Gfl/VOfa2vh/QtAqt0TrruRCqnX+U5z3r4qo
	 5+h1HFlsBExJaRjnMC1ZPVxrXU2d+WdMmhO1pZSDAhjqXsjOgFSQ9gWU5sAhT9bxpe
	 PfrviDxmxsmUYT04KLNknK0sDLFWx0nBYBH1yKtEQdMP4QvYjZsWYOLr/hXUuol+lx
	 Q2eC2ptEyhikw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.12] tools/power turbostat: Handle cap_get_proc() ENOSYS
Date: Sun, 10 Aug 2025 12:51:57 -0400
Message-Id: <20250810165158.1888206-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810165158.1888206-1-sashal@kernel.org>
References: <20250810165158.1888206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Calvin Owens <calvin@wbinvd.org>

[ Upstream commit d34fe509f5f76d9dc36291242d67c6528027ebbd ]

Kernels configured with CONFIG_MULTIUSER=n have no cap_get_proc().
Check for ENOSYS to recognize this case, and continue on to
attempt to access the requested MSRs (such as temperature).

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Bug Fix Nature
The commit fixes a clear bug where turbostat fails to work on kernels
configured with `CONFIG_MULTIUSER=n`. Without this fix, turbostat would
incorrectly fail when `cap_get_proc()` returns NULL with `ENOSYS`,
preventing users from accessing MSRs (like temperature readings) even
when they should be able to.

## Small and Contained Change
The fix is minimal - only 9 lines added, 1 line removed. The change is
entirely contained within the `check_for_cap_sys_rawio()` function in
turbostat.c:
- It adds a check for `errno == ENOSYS` when `cap_get_proc()` returns
  NULL
- Returns 0 (success) in this specific case to allow MSR access attempts
  to proceed
- Preserves the original error handling (return 1) for all other failure
  cases

## No Side Effects or Architectural Changes
The change doesn't introduce any new features or architectural
modifications. It simply adds proper error handling for a specific
configuration scenario that was previously not handled correctly. The
logic flow remains the same for all other cases - only the ENOSYS case
gets special treatment.

## User Impact
This affects real users running embedded or specialized Linux systems
with `CONFIG_MULTIUSER=n` (single-user mode kernels). Without this fix,
turbostat is completely broken on such systems, unable to read MSRs for
temperature monitoring and other power management features.

## Stable Tree Criteria Compliance
The fix meets stable kernel criteria:
- **Fixes a real bug**: turbostat failure on CONFIG_MULTIUSER=n kernels
- **Already upstream**: The commit is in the mainline kernel
- **Minimal risk**: The change only affects the specific error case and
  doesn't alter behavior for normal configurations
- **Clear and obvious**: The fix is straightforward - checking for
  ENOSYS and handling it appropriately

## Tool-Specific Nature
Since this is a userspace tool fix (tools/power/x86/turbostat/), it has
even lower risk of causing kernel regressions while providing immediate
benefit to affected users.

The commit is an ideal candidate for stable backporting as it fixes a
specific, reproducible issue with minimal code changes and no risk to
systems where `CONFIG_MULTIUSER=y` (the common case).

 tools/power/x86/turbostat/turbostat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 46ee85216373..00fdb6589bea 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6573,8 +6573,16 @@ int check_for_cap_sys_rawio(void)
 	int ret = 0;
 
 	caps = cap_get_proc();
-	if (caps == NULL)
+	if (caps == NULL) {
+		/*
+		 * CONFIG_MULTIUSER=n kernels have no cap_get_proc()
+		 * Allow them to continue and attempt to access MSRs
+		 */
+		if (errno == ENOSYS)
+			return 0;
+
 		return 1;
+	}
 
 	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE, &cap_flag_value)) {
 		ret = 1;
-- 
2.39.5


