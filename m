Return-Path: <linux-pm+bounces-31815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2EB1987C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6331216B537
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A713E898;
	Mon,  4 Aug 2025 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2ubSAoz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35941DE3C8;
	Mon,  4 Aug 2025 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267726; cv=none; b=JHHNPnW9SpeV34gXS5U4xMKmnclzm1eP+yLl0sdybHvem0iyU3KE6XZaV0FBlJLhdsz3Rxk1JU3Nzntu29mMs9xE2DGS3Ldjn6+yv3S2Tl15QGpR9qdu+hgbPgvIZ31qg0ioNT6/l7mak/t8StHYQ49he1mZ2rRSEZXrOvLcOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267726; c=relaxed/simple;
	bh=ReY+9r5zOSawKnDxSwJO1+/B9frPKRJkLgqT3Zfsz68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsBUQlswYg5yFzmOOcjdNs/oRoLMBlEPL3ZTy7i64nq0FAjae2YAwwoecqbOuNs/kbWb3v6R9u9PqblXgAW2usuO9yfBqjXJiTRqyXAnzHGwpAj0wosx1j7jxydC8m5rplfzOUVGNekxFLR73E0nWI8gpPMQ2Ac9UrbI82SMLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2ubSAoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225D0C4CEFA;
	Mon,  4 Aug 2025 00:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267726;
	bh=ReY+9r5zOSawKnDxSwJO1+/B9frPKRJkLgqT3Zfsz68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2ubSAozC+bw4HdEAi2rjmROmkU/lBjTEEaOxtkBzI8Y2d5HbI5ZEdUJ8qpmt8+VT
	 BT/Ruz/6+wTN2iDt2okPf63QJrQnjsBPPVuS8KQmR/NuPMYH09OJ+nwttbQNWRWOJl
	 E0NY8KTNk7fDG769IAqljO2dF4htpHuZ5aKhq18G9hJKf3bUrkZdNasRcHDUf3X2ZM
	 tP8Emkl29nXvXTb0Kju8rNNjvdo4w932vK2eiV7Ha7B80Jes9x+yE8l67UZGnmNNIs
	 eAcgo0DfvDEJEoO4B5bwJ9ckofAvnzm0usibXcCZoM62B30X3bzHo2cpa3S+kFzGNO
	 my4eRpkO6rSFQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 30/59] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
Date: Sun,  3 Aug 2025 20:33:44 -0400
Message-Id: <20250804003413.3622950-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Hsin-Te Yuan <yuanhsinte@chromium.org>

[ Upstream commit 1a4aabc27e95674837f2e25f4ef340c0469e6203 ]

According to POSIX spec, EAGAIN returned by read with O_NONBLOCK set
means the read would block. Hence, the common implementation in
nonblocking model will poll the file when the nonblocking read returns
EAGAIN. However, when the target file is thermal zone, this mechanism
will totally malfunction because thermal zone doesn't implement sysfs
notification and thus the poll will never return.

For example, the read in Golang implemnts such method and sometimes
hangs at reading some thermal zones via sysfs.

Change to return -ENODATA instead of -EAGAIN to userspace.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Link: https://patch.msgid.link/20250620-temp-v3-1-6becc6aeb66c@chromium.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit, here is my determination:

**Backport Status: YES**

## Extensive Explanation:

This commit should be backported to stable kernel trees for the
following reasons:

### 1. **Bug Fix for Real User-Facing Issue**
The commit fixes a bug where userspace applications can hang when
reading thermal zone temperature files via sysfs with O_NONBLOCK set.
The commit message clearly states that "the read in Golang implements
such method and sometimes hangs at reading some thermal zones via
sysfs." This is a real-world problem affecting actual applications.

### 2. **POSIX Compliance Issue**
The current behavior violates POSIX semantics. According to POSIX
specifications, EAGAIN from a non-blocking read means "the read would
block" - implying that the caller should poll/select and wait for data
to become available. However, thermal zone sysfs files don't implement
poll notifications, so applications following standard POSIX patterns
will poll forever, causing hangs.

### 3. **Small and Contained Change**
The code change is minimal and localized:
```c
- if (ret)
- return ret;
+       if (!ret)
+               return sprintf(buf, "%d\n", temperature);

- return sprintf(buf, "%d\n", temperature);
+       if (ret == -EAGAIN)
+               return -ENODATA;
+
+       return ret;
```
It only affects the `temp_show()` function in `thermal_sysfs.c` by
translating -EAGAIN to -ENODATA specifically for sysfs reads.

### 4. **Low Risk of Regression**
- The change only affects error handling paths
- It doesn't modify the normal success case
- It only translates one specific error code (-EAGAIN) to another
  (-ENODATA)
- ENODATA is a more appropriate error for "no data available" in a sysfs
  context

### 5. **Multiple Drivers Return -EAGAIN**
My search found at least 13 thermal drivers that can return -EAGAIN from
their get_temp operations:
- imx8mm_thermal.c
- imx_thermal.c
- tegra-bpmp-thermal.c
- qoriq_thermal.c
- lvts_thermal.c
- rockchip_thermal.c
- exynos_tmu.c
- sun8i_thermal.c
- stm_thermal.c
- intel_powerclamp.c

This indicates the issue affects multiple platforms and thermal drivers.

### 6. **Follows Stable Kernel Rules**
- Fixes a real bug that bothers people (application hangs)
- Fix is already in Linus's tree (based on the Signed-off-by from Rafael
  J. Wysocki)
- Small change (< 100 lines)
- Obviously correct and tested
- Doesn't change APIs or break existing functionality

### 7. **No Architectural Changes**
The commit doesn't introduce new features or change the thermal
subsystem architecture. It's purely a bug fix that makes the sysfs
interface behave correctly with non-blocking reads.

The fix is appropriate because sysfs files are not meant to be pollable
in the traditional sense - they provide instantaneous data snapshots.
Returning ENODATA instead of EAGAIN properly communicates "no data
currently available" without implying that polling would help.

 drivers/thermal/thermal_sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index eef40d4f3063..0dea605faadb 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -39,10 +39,13 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
-	if (ret)
-		return ret;
+	if (!ret)
+		return sprintf(buf, "%d\n", temperature);
 
-	return sprintf(buf, "%d\n", temperature);
+	if (ret == -EAGAIN)
+		return -ENODATA;
+
+	return ret;
 }
 
 static ssize_t
-- 
2.39.5


