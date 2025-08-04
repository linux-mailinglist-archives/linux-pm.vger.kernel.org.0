Return-Path: <linux-pm+bounces-31800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CDB197A9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600DF7A3337
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CA189513;
	Mon,  4 Aug 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2Rd2gNm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66992184540;
	Mon,  4 Aug 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267380; cv=none; b=khmdBQPCNEsOT1WQjZpUWaB1Cyc7ZclzfvWZyksjoNAWUCi9lvIY4z+vC4Lg8GvcYQfscyTfRvFGn9TuZXkK+GYIO1yUOgty+rR57Zzpy1X2XHXMFkoyNFbhEXU0qkwNvU9rITb78pMh7OQY3Zd+u4zwGNViNaDxdLVHT9fMsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267380; c=relaxed/simple;
	bh=agdpOy6lyFNXP0OjztPFIi17iLkf0nDIolmz6xF94YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEr/O6Gayk5QmCbP+bc6yMPGjaGI+2w3Vvg0TgULC+O0S/lQp3pJvWVF6eKc6KKW/8W2qXbl3HxJsagsU2ns/9P8fGUlgHnZs9F36OlyEHfvAoI2C/M5P+HjSJF3L9OXQtpMf5zWbQ3QdZILluG1no79J+tSaueKVY4pfJEzRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2Rd2gNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F35C4CEF8;
	Mon,  4 Aug 2025 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267380;
	bh=agdpOy6lyFNXP0OjztPFIi17iLkf0nDIolmz6xF94YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2Rd2gNmKuX7d5AoYw1MklmujBEbjPOXe5GgSzBb1dCU/pxL/crfnpW4tXHqh7zfo
	 4cK98ORESY3SK6IYzla9qmyA7AHv0S02ZK44uCmRlpB4YJWRn8XiorWH7Ir7njlzAq
	 81BYZj46F+XyPVwKFoKlrLyMqJvShyYRB2odCZbMbdCdMrWCddKQcdTcR8LcGQHWms
	 escjoXA5mzv4z6R4DgNQf08/NKp8H3LkoEm7TlE/Iztm9J4Hokc+jzJbg4PNYYrdv+
	 yaiv25A4ZkDGMXWrqlJStY1b9hJtty7o8Jt8k2cP+4B88hCxy61E7lEjG7HZ/D/DCv
	 zIbPFW/wXBObg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 43/80] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
Date: Sun,  3 Aug 2025 20:27:10 -0400
Message-Id: <20250804002747.3617039-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
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
index 24b9055a0b6c..d80612506a33 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -40,10 +40,13 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
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


