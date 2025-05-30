Return-Path: <linux-pm+bounces-27863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1537BAC8E2F
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30900A42E3B
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE4239072;
	Fri, 30 May 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlbRNVsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035B238D5A;
	Fri, 30 May 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608772; cv=none; b=rjrrpm/e43nBD9iS1VvELmXKZlKUklFpaiqvTChDSdyk5GT5AhPlxvH7SpUQAzWhN8BdQVHZev2umUtBOc3ocKH7oBQpoTxYtooED8X+p/XAPhT0zmW7zV8y451mrUUcAS3O9VAm/R0hKegMCpN7qWmDEV9Rpa+GWBT0koLeCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608772; c=relaxed/simple;
	bh=FlpeWCnJFPCv86vto1B49MxkeN4OkRESOjSv+/+0ZAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHl8wHJ5s0nJV7TRBD5+/Co0ap3V+18x/wrd1ZGnAhABHelBGg44GthvM3d6upBJxpUC4lYntZRVvojVwzAlLrzfmFBPOD6zE0qcWOD0cILSVy7ghjv6HfbXgFdoHDDmhi9DzGTChAqb19hVFwrjm3aoWa2jRkU/34ILBPjfz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlbRNVsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EDDC4CEEA;
	Fri, 30 May 2025 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608771;
	bh=FlpeWCnJFPCv86vto1B49MxkeN4OkRESOjSv+/+0ZAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlbRNVsLufF+zWoPu8lw4ZO8ECAx7ok+i8NgfZZgRPvtUz/HmrFfqQCIwnFUjFePA
	 b0s3yUq5NAeGCrziATPAzdYnXeCTYwCbddlrfTPJEBGWH12ooaFFLbzCaFqfl+ekjx
	 BfbxOK+gNNX4wFbSzjiTpcAROzZm1JHMdDnU79LaJwx3ntLjafEI19PTEm3vJuztCR
	 dNuwI72nNlqWOfVnzTT3LqpEfQBLkpp72zZ1WRz7Uj016/UCye/oX3IPeAl7gIT+ba
	 zLdwtBqmT8JsgPU42PclYDjU6un8Vmvm7iiCYT5AYu4Wxg87cvSmHOoikhJ8zB6lQH
	 sg+NjTaa93CsA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 29/30] power: supply: max17040: adjust thermal channel scaling
Date: Fri, 30 May 2025 08:38:51 -0400
Message-Id: <20250530123852.2574030-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123852.2574030-1-sashal@kernel.org>
References: <20250530123852.2574030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit d055f51731744243b244aafb1720f793a5b61f7b ]

IIO thermal channel is in millidegree while power supply framework expects
decidegree values. Adjust scaling to get correct readings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20250430060239.12085-2-clamor95@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Code Analysis The commit fixes a **units
conversion bug** in the max17040 power supply driver's temperature
reporting. Specifically: ### The Problem The original code in
`max17040_get_property()` for `POWER_SUPPLY_PROP_TEMP` was: ```c
iio_read_channel_processed_scale(chip->channel_temp, &val->intval, 10);
``` ### The Fix The corrected code is: ```c
iio_read_channel_processed(chip->channel_temp, &val->intval);
val->intval /= 100; /bin /bin.usr-is-merged /boot /dev /etc /home /init
/lib /lib.usr-is-merged /lib64 /lost+found /media /mnt /opt /proc /root
/run /sbin /sbin.usr-is-merged /snap /srv /sys /tmp /usr /var Convert
from milli- to deci-degree model/ prompt/ src/ target/ ``` ### Units
Mismatch Issue According to the power supply class documentation found
in `/home/sasha/linux/Documentation/power/power_supply_class.rst`: >
"All voltages, currents, charges, energies, time and **temperatures** in
µV, µA, µAh, µWh, seconds and **tenths of degree Celsius** unless
otherwise stated." The power supply framework expects temperatures in
**tenths of degree Celsius** (decidegrees), but IIO thermal channels
typically return values in **millidegrees Celsius**. ### Mathematical
Analysis - IIO thermal channel: returns millidegrees (1/1000 °C) - Power
supply framework expects: decidegrees (1/10 °C) - Required conversion:
millidegrees ÷ 100 = decidegrees - Old code: Applied a scale of 10,
which would convert from decidegrees to degrees (wrong direction) - New
code: Divides by 100, correctly converting from millidegrees to
decidegrees ### Confirmation from Kernel Sources Looking at
`max17042_battery.c` (similar chip), line 109 shows the correct pattern:
```c /bin /bin.usr-is-merged /boot /dev /etc /home /init /lib /lib.usr-
is-merged /lib64 /lost+found /media /mnt /opt /proc /root /run /sbin
/sbin.usr-is-merged /snap /srv /sys /tmp /usr /var The value is
converted into deci-centigrade scale model/ prompt/ src/ target/ *temp =
*temp 0001-Fix-Clippy-warnings.patch 0002-Enhance-inference-prompt-to-
utilize-CVEKERNELDIR-whe.patch 0003-Update-to-latest-version-of-
clap.patch Cargo.lock Cargo.toml LICENSE README.md
analyze_merge_commit.sh io_uring_analysis.txt ksmbd_analysis.txt
merge_commit_analysis.txt model prompt src target test_gpio_cleanup.txt
test_patch.txt 10 / 256; ``` This confirms that power supply drivers
should output temperatures in deci-centigrade (decidegrees). ## Backport
Suitability Assessment **1. Bug Fix**: ✅ Yes - This fixes incorrect
temperature readings **2. Small and Contained**: ✅ Yes - Only 3 lines
changed in one function **3. Clear Side Effects**: ✅ No major side
effects - only corrects temperature values **4. Architectural Changes**:
✅ No - Simple unit conversion fix **5. Critical Subsystem**: ✅ Limited
impact - only affects optional temperature reporting **6. Stable Tree
Mention**: ❌ No explicit mention, but meets criteria **7. Stable Tree
Rules**: ✅ Important bugfix with minimal regression risk ## Risk
Assessment - **Regression Risk**: Very low - only affects temperature
readings when IIO thermal channel is present - **User Impact**: High for
affected users - wrong temperature readings could affect thermal
management - **Code Complexity**: Minimal - straightforward arithmetic
fix ## Historical Context The thermal channel support was added in
commit `814755c48f8b` (July 2023), and this scaling bug has been present
since then. The fix addresses a fundamental units mismatch that would
cause incorrect temperature reporting for any system using the IIO
thermal channel feature. This is exactly the type of contained,
important bugfix that stable trees are designed for.

 drivers/power/supply/max17040_battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 51310f6e4803b..c1640bc6accd2 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -410,8 +410,9 @@ static int max17040_get_property(struct power_supply *psy,
 		if (!chip->channel_temp)
 			return -ENODATA;
 
-		iio_read_channel_processed_scale(chip->channel_temp,
-						 &val->intval, 10);
+		iio_read_channel_processed(chip->channel_temp, &val->intval);
+		val->intval /= 100; /* Convert from milli- to deci-degree */
+
 		break;
 	default:
 		return -EINVAL;
-- 
2.39.5


