Return-Path: <linux-pm+bounces-39831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6536CD914F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981ED3096232
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7D350A11;
	Tue, 23 Dec 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOAMTf4Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAB350A35;
	Tue, 23 Dec 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484321; cv=none; b=LFRCVPLUPWg5o8nHJRJOerratsKwCeW8FQVFdKkbeMu4RIHBjHWMi7qU+E9qcamuTy70zZdEVwGS7FBg2UuLBEcioGfk9pqjpzo0m6/3VI2fkM/rjmRjzYUaTZhnCna8UL8KSQpNb78V/9cnyjiOce4H2kxzrH227Oyu9k+3WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484321; c=relaxed/simple;
	bh=zYpQJmerG92JR/fkg0qrLPmBRRLwQtv4hZQNF1e7qOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzRJus+0TSFXH4Fz6lcKfv05tCSD552pr8tFAHEjaIOHuG5tl3EMqJ2Q000veyDQdTVMEbeFjDGy8TCkpNdmbhv1zQJ/ajPf0jbtDr4RTX5y1OPpmqZCF1c0iVdlm6BCnD62v5mH0iAODtRJhMfAyZ4S5nBONhlG4QuNvpVKJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOAMTf4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53631C19423;
	Tue, 23 Dec 2025 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766484320;
	bh=zYpQJmerG92JR/fkg0qrLPmBRRLwQtv4hZQNF1e7qOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bOAMTf4ZvS7iRZOqNjiFoxKUg33WWdcT0rlOVYfhfvY/yQJfreoq0XoTD+w4wMjRj
	 6BR+VZ6bKrl0Dal9cO00JzsDQzzDUbnPq9EmNr+zonbD6oVk/LPDOeTWqU8XMtnoBf
	 ZoSq+Ri1jSsEdZmAMasXrGU6zhB+Z9Y525MVh4/SWhEnLDg9dX/W4WmZMQnVaXzDZR
	 VBOCfZQADdKTU6ujBYkRy68CVz9fe6IJ0LnfX1E4jDCVOm2ziu6fF44UkrSVM9oO2z
	 27Ffp2b0nwhHdinFoSaHlF7S9F1L+2rh75iI4csZLvwvkdGwlfCt+OupIF9egatcqH
	 RGmJHiMKwfTDw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sumeet Pawnikar <sumeet4linux@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] powercap: fix sscanf() error return value handling
Date: Tue, 23 Dec 2025 05:05:05 -0500
Message-ID: <20251223100518.2383364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sumeet Pawnikar <sumeet4linux@gmail.com>

[ Upstream commit efc4c35b741af973de90f6826bf35d3b3ac36bf1 ]

Fix inconsistent error handling for sscanf() return value check.

Implicit boolean conversion is used instead of explicit return
value checks. The code checks if (!sscanf(...)) which is incorrect
because:
 1. sscanf returns the number of successfully parsed items
 2. On success, it returns 1 (one item passed)
 3. On failure, it returns 0 or EOF
 4. The check 'if (!sscanf(...))' is wrong because it treats
    success (1) as failure

All occurrences of sscanf() now uses explicit return value check.
With this behavior it returns '-EINVAL' when parsing fails (returns
0 or EOF), and continues when parsing succeeds (returns 1).

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
[ rjw: Subject and changelog edits ]
Link: https://patch.msgid.link/20251207151549.202452-1-sumeet4linux@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Looking at this commit carefully to assess its suitability for stable
backporting.

## Commit Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit fixes incorrect error handling for `sscanf()` return value
checks in the powercap subsystem. The message claims that `if
(!sscanf(...))` is wrong because:
- `sscanf()` returns the number of successfully parsed items
- On success: returns 1
- On failure: returns 0 or EOF (typically -1)

### 2. CODE CHANGE ANALYSIS

Three identical changes in `drivers/powercap/powercap_sys.c`:
```c
// Before:
if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id))

// After:
if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1)
```

Let me trace through the bug:
- When `sscanf()` returns 0 (no match): `!0` = 1 (true) → error path
  taken ✓
- When `sscanf()` returns 1 (success): `!1` = 0 (false) → continues ✓
- When `sscanf()` returns EOF (-1): `!(-1)` = 0 (false) → **error path
  NOT taken** ✗

The critical issue is the EOF case. If `sscanf()` returns EOF (e.g.,
empty string input), the check passes incorrectly and execution
continues with an **uninitialized `id` variable**. This then leads to:
```c
if (id >= power_zone->const_id_cnt)  // garbage comparison
    return -EINVAL;
pconst = &power_zone->constraints[id];  // POTENTIAL OUT-OF-BOUNDS
ACCESS
```

### 3. CLASSIFICATION

This is a **bug fix** that prevents:
- Potential out-of-bounds array access
- Use of uninitialized variable
- Possible kernel crash or memory corruption in edge cases

Not a feature addition, code cleanup, or optimization.

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 3 lines (identical pattern)
- **Files affected**: 1 file
- **Risk**: Extremely low - the change only makes the check stricter and
  more explicit
- **Could break anything?**: No - the new check `!= 1` is strictly more
  conservative than `!`

### 5. USER IMPACT

The powercap subsystem manages:
- Intel RAPL power capping
- Power domain constraints
- Used by tools like powertop, thermald

While the EOF triggering condition is rare (would require malformed
attribute names), the consequence (OOB access) could be severe.

### 6. STABILITY INDICATORS

- Signed-off by Rafael J. Wysocki (Intel power management maintainer)
- Self-contained fix with no dependencies
- The powercap subsystem has existed since kernel 3.13

### 7. DEPENDENCY CHECK

- No dependencies on other commits
- Simple standalone fix
- Code exists in all active stable trees

## Summary

**What it fixes**: Incorrect sscanf error handling that could allow
execution with uninitialized data, potentially leading to out-of-bounds
array access.

**Why it matters for stable**: While the triggering condition (EOF from
sscanf) is rare, the fix prevents a potential memory safety issue. The
change is trivially correct with zero regression risk.

**Meets stable criteria**:
- ✓ Obviously correct (explicit `!= 1` check is cleaner and more robust)
- ✓ Fixes a real bug (uninitialized variable use, potential OOB access)
- ✓ Small and contained (3 identical one-line changes)
- ✓ No new features
- ✓ No dependencies

**Risk vs benefit**: The benefit (preventing potential memory
corruption) outweighs the near-zero risk of regression.

**YES**

 drivers/powercap/powercap_sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index d14b36b75189..1ff369880beb 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -68,7 +68,7 @@ static ssize_t show_constraint_##_attr(struct device *dev, \
 	int id; \
 	struct powercap_zone_constraint *pconst;\
 	\
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1) \
 		return -EINVAL; \
 	if (id >= power_zone->const_id_cnt)	\
 		return -EINVAL; \
@@ -93,7 +93,7 @@ static ssize_t store_constraint_##_attr(struct device *dev,\
 	int id; \
 	struct powercap_zone_constraint *pconst;\
 	\
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1) \
 		return -EINVAL; \
 	if (id >= power_zone->const_id_cnt)	\
 		return -EINVAL; \
@@ -162,7 +162,7 @@ static ssize_t show_constraint_name(struct device *dev,
 	ssize_t len = -ENODATA;
 	struct powercap_zone_constraint *pconst;
 
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id))
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1)
 		return -EINVAL;
 	if (id >= power_zone->const_id_cnt)
 		return -EINVAL;
-- 
2.51.0


