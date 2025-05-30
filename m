Return-Path: <linux-pm+bounces-27872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC6AC8EC7
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C991502D5D
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B82609EA;
	Fri, 30 May 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT0RjtKO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06A25FA1F;
	Fri, 30 May 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608846; cv=none; b=UcRh0fRdCnf+9fJoGQE4K0XF/T6FP7CR/nZl4IaPEt8+o4iJFIzTqOfz68zXhQTYrBRVTnYe/M7pqkuStIPoezYVkOogKiCKx5J83Hj9pkXKjmNSsqcFQRo45ndr9EaDn8rfCGy4ehEemerc/EQTv63DjADpObF5yMeoh7KE1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608846; c=relaxed/simple;
	bh=FlpeWCnJFPCv86vto1B49MxkeN4OkRESOjSv+/+0ZAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu9lhebX1WVPw4qi2Eq3D9hH+uLIqEJYU3w84A8ARQTMpbu1rqFqgHR4SIoR+YjPaoOmjh6Q8piVtTUNdsKJrp9vZ2hKl4i/Z5ECHXdRGuKtOp3dK1t12BZeO1kFPsKoJJU82VYDH67S7TWs18Ku6RF5TqZUX4IthEp6A4dw5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT0RjtKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D85C4CEEB;
	Fri, 30 May 2025 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608845;
	bh=FlpeWCnJFPCv86vto1B49MxkeN4OkRESOjSv+/+0ZAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hT0RjtKO1YcBliM1vfi/3xNr8vrE0WOlQsqFYf9C9cD6dZtjWu4/xJ1zaKgmvq8LW
	 JNKiSXDxI3NOVujlmxcp+bhLAoWlfrmFViBw09lBYFQU5eLUYES4Ga1Fg/n9ZBloz+
	 Ujotu2+Z4kulD7540BRqnEigLUr5tLGV1plZfgUGjU85d1upVdzjVEhbwS0KpYl7M3
	 IAH3CYlgdOr+xUppXS60oJ/RMRlHQx3QYC+sEShB6YQZdJnW9mhRSYEXj9EMwjmlkM
	 67lGObf2ibp1klvWMaDJTmmpytHJJnfNia0OV1I3+asAR4zfQVIrvnoGWzphL7LrQ/
	 51u8y7+qjMjvg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 25/26] power: supply: max17040: adjust thermal channel scaling
Date: Fri, 30 May 2025 08:40:11 -0400
Message-Id: <20250530124012.2575409-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124012.2575409-1-sashal@kernel.org>
References: <20250530124012.2575409-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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


