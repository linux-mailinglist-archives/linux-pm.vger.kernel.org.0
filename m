Return-Path: <linux-pm+bounces-32094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B9B1FB14
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D86F64E0F22
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496726CE36;
	Sun, 10 Aug 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyMj0IGH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3D18C933;
	Sun, 10 Aug 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844724; cv=none; b=nV0kuv6jhSXp96xhSrITq1VEpQ5P0WsM2jNePsp8fr51bpJVZy9n+BUcjYq9PX+Oxa+Qmzwefh83gK3lpZHGSw9un1SLserA5S+OOkpBHd/394JkE7nLrItackattiPpih3053x4DRgfdinA2Go8d30RpN2VZEBKb7jfXBdUn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844724; c=relaxed/simple;
	bh=0kd2zYwRTda4FihBBRspceYznCtza6GKQbvNmK08HWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaNXCOGn+/bcsxysPO8ai20xpc6n2x3RsUKq0F68HFU7Tj5vqVq0btogreGue6MOnkl1ykHMbkz7IRWt1Crw/jUoxohqV41YP70rHnCsCpS5yIEWvV5ApiqeKw6rCGYz5Q6E4azNyjGA7LqGkIuY0gVGY79JsTP8rVMT7bGwYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyMj0IGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1998C4CEEB;
	Sun, 10 Aug 2025 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844724;
	bh=0kd2zYwRTda4FihBBRspceYznCtza6GKQbvNmK08HWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyMj0IGHtIwROT9KA1i0p6OySYvlcqGnW8mKgGEZ0hfQHuzP191SFoYzXd9lBH55N
	 YcDQkua32NZn6wHlGtc1tdP12CnM6gRS3kJ++xUSu4RyVS6B/eIUOTJjVnT/Ay6UJd
	 GBSgeQ5rMkTd3oYIr+jLfYXM3zLBBCacvVVqFFPmpJgzJJaoRmw2c2zCgKqt8hM5WD
	 NWSb37g3UCoVBsd72iP3e1CGIEFR6LSrrGGzm82F8V4KjNS8Ld3tsYoVOJ2oMCDKT5
	 5lolibOL6o+JxHDR2dJRNHDxEtCFejxZnjwcizdbdv9MYC7hMOr9RN4PJYfp1njPfb
	 9QSNEkqLgQ4mw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.12] tools/power turbostat: Handle non-root legacy-uncore sysfs permissions
Date: Sun, 10 Aug 2025 12:51:44 -0400
Message-Id: <20250810165158.1888206-2-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

[ Upstream commit e60a13bcef206795d3ddf82f130fe8f570176d06 ]

/sys/devices/system/cpu/intel_uncore_frequency/package_X_die_Y/
may be readable by all, but
/sys/devices/system/cpu/intel_uncore_frequency/package_X_die_Y/current_freq_khz
may be readable only by root.

Non-root turbostat users see complaints in this scenario.

Fail probe of the interface if we can't read current_freq_khz.

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Original-patch-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear understanding of the issue and fix. Let me analyze
the code change:

## Backport Status: **YES**

## Extensive Analysis:

This commit should be backported to stable kernel trees for the
following reasons:

### 1. **Bug Fix for Real User Issue**
The commit fixes a specific bug where non-root users of turbostat
encounter errors when the sysfs permissions are inconsistent. As stated
in the commit message:
- The directory
  `/sys/devices/system/cpu/intel_uncore_frequency/package_X_die_Y/` may
  be readable by all users
- But the file `current_freq_khz` within that directory may only be
  readable by root
- This causes turbostat to fail with complaints for non-root users

### 2. **Simple and Contained Fix**
The code change is minimal and focused:
```c
// Before: Only checked if the directory was readable
if (access(path_base, R_OK))
    continue;

// After: Check if the actual file we need (current_freq_khz) is
readable
sprintf(path, "%s/current_freq_khz", path_base);
if (access(path, R_OK))
    continue;
```

The fix simply moves the permission check from the directory to the
actual file that will be read later (line 6763-6765 in the original code
reads `current_freq_khz`).

### 3. **Follows Established Pattern**
Looking at the `probe_intel_uncore_frequency_cluster()` function (line
6776), it already checks the specific file permission:
```c
if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00/curr
ent_freq_khz", R_OK))
    return;
```
This fix makes the legacy function consistent with the cluster
function's approach.

### 4. **No Risk of Regression**
- The change only affects the probing logic - if the file cannot be
  read, the function simply skips that uncore frequency entry
- This is better than the current behavior where it would try to read
  the file anyway and fail with errors
- The fix maintains backward compatibility - systems where the file is
  readable continue to work as before

### 5. **Userspace Tool Fix**
This is a fix for a userspace tool (turbostat) in the tools/ directory,
not kernel code, making it even safer to backport as it cannot cause
kernel instability.

### 6. **Clear Problem and Solution**
- The problem is well-defined and reported by a real user (Artem
  Bityutskiy)
- The solution is straightforward and logical
- The fix prevents error messages that would confuse users running
  turbostat without root privileges

### 7. **Meets Stable Criteria**
According to stable kernel rules, this fix:
- Fixes a real bug that affects users ✓
- Is small and contained (2 line change) ✓
- Has minimal risk of introducing new issues ✓
- Doesn't introduce new features ✓
- Doesn't make architectural changes ✓

The commit improves the robustness of turbostat when dealing with
permission inconsistencies in sysfs, which is a reasonable scenario that
can occur in production systems with specific security configurations.

 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5230e072e414..bf011c2847f2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6740,7 +6740,8 @@ static void probe_intel_uncore_frequency_legacy(void)
 			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d", i,
 				j);
 
-			if (access(path_base, R_OK))
+			sprintf(path, "%s/current_freq_khz", path_base);
+			if (access(path, R_OK))
 				continue;
 
 			BIC_PRESENT(BIC_UNCORE_MHZ);
-- 
2.39.5


