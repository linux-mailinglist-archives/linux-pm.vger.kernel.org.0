Return-Path: <linux-pm+bounces-32095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A97B1FB24
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A717908B
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088A274B2F;
	Sun, 10 Aug 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iROwhm/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63088274671;
	Sun, 10 Aug 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844758; cv=none; b=paPSNwovsujWCcKiCbWEidBTTYCoKEvyKWOtZkw/wcQgdEYr8s7ZDKV5dEuE7tYEOX9r7KLYfijEB8q5YMsaRjtGYlYV+4K7rJ0JYik9WpRU38+ZaG951m40fJCAoTZ9HEpcp7ANPPuw3asFseNwI7bGCadgmRd0NBwFP6RR8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844758; c=relaxed/simple;
	bh=aHB3HA7K3wggr9AyGBS4hmBYQjS32W9W6zgZ7uHwisg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAB9qm1IWpYvjkxsSFtds5jd/kcHf8Bn8hQMR3+dd7arIiStkOBV9sLp/+fDxdVMnFUcuFMXZggbnrXa649SImnxmEP2sL77Q1TBgyUgxEk1Lr7GFmSeAEDpcx0X/npqdHsgzKE32mcjQShMgp1zarIRsLmWH998LnPs514v5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iROwhm/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85DBC4CEEB;
	Sun, 10 Aug 2025 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844758;
	bh=aHB3HA7K3wggr9AyGBS4hmBYQjS32W9W6zgZ7uHwisg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iROwhm/jo0/qyUeuKx/Trc5HxH+qmzZj7kXVvLABfTn2qis8uuK/vjoMpdhpKXYFY
	 aCCEfpZ12oJtHLbFkiXQfSPAkweAc2JU9gF4+KsjOSMg0CYsyq32cN1Kv2gJOs5bQQ
	 /NyInfVmOQpeMdGWIRtVRQ1hxpTGYiciZkmxhCRIQ0hCT5PLhqPrg3bQJjaT00w9Yc
	 kwXe8/cLp45WeBf6a+7FLVcnM3vhQhlsGytP7uESDO3iaWaCiPTV/tlU7CVZS0bYuV
	 gKLbTSsEzFcQhLQ0qFR+5n5K/UEiQGk8LgiOqasMcAwQeNTFptGDp7phnbxgiOIHyJ
	 Ct9jqbH2lpVng==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.12] tools/power turbostat: Fix build with musl
Date: Sun, 10 Aug 2025 12:51:54 -0400
Message-Id: <20250810165158.1888206-12-sashal@kernel.org>
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

[ Upstream commit 6ea0ec1b958a84aff9f03fb0ae4613a4d5bed3ea ]

turbostat.c: In function 'parse_int_file':
    turbostat.c:5567:19: error: 'PATH_MAX' undeclared (first use in this function)
     5567 |         char path[PATH_MAX];
          |                   ^~~~~~~~

    turbostat.c: In function 'probe_graphics':
    turbostat.c:6787:19: error: 'PATH_MAX' undeclared (first use in this function)
     6787 |         char path[PATH_MAX];
          |                   ^~~~~~~~

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Clear Build Fix**: This is a straightforward build fix that
   addresses compilation failures when building turbostat with musl
   libc. The error messages in the commit clearly show `PATH_MAX` is
   undeclared, which prevents the tool from compiling.

2. **Minimal and Safe Change**: The fix is extremely minimal - it only
   adds a single include directive (`#include <limits.h>`) at line 70 of
   turbostat.c. This is a standard POSIX header that defines `PATH_MAX`
   and other system limits.

3. **No Functional Changes**: The commit doesn't change any logic or
   behavior - it simply ensures the code compiles correctly by including
   the necessary header file that defines `PATH_MAX`.

4. **Affects User Tools**: While turbostat is a userspace tool (not
   kernel code), it's an important power monitoring utility that's part
   of the kernel source tree. Users building kernel tools with musl libc
   (common in embedded systems, Alpine Linux, etc.) would be unable to
   build this tool without this fix.

5. **Cross-Platform Compatibility**: The issue affects systems using
   musl libc instead of glibc. With glibc, `PATH_MAX` might be defined
   through indirect includes, but musl requires explicit inclusion of
   `<limits.h>`. This fix improves portability.

6. **No Risk of Regression**: Adding the `<limits.h>` include has zero
   risk of breaking existing functionality. The header is standard and
   the constant `PATH_MAX` is used in at least 4 places in the code
   (lines 5641, 6870, 7481, 7537) where character arrays are declared.

7. **Follows Stable Rules**: This perfectly fits the stable kernel
   criteria:
   - Fixes a real bug (build failure)
   - Obviously correct (standard header inclusion)
   - Already tested (has sign-offs and review)
   - Small change (1 line)
   - No new features or architectural changes

The commit is an ideal candidate for stable backporting as it fixes a
concrete build issue with minimal risk and maximum benefit for users of
alternative libc implementations.

 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bf011c2847f2..46ee85216373 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -67,6 +67,7 @@
 #include <stdbool.h>
 #include <assert.h>
 #include <linux/kernel.h>
+#include <limits.h>
 
 #define UNUSED(x) (void)(x)
 
-- 
2.39.5


