Return-Path: <linux-pm+bounces-36219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E037EBE1B81
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB493B6BF5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211A2D46B2;
	Thu, 16 Oct 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6GOhv+x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4702D46AF;
	Thu, 16 Oct 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596054; cv=none; b=WlvqwOzzFiXtDq9fLtejFzMEQG6NROklpe7uShqlthFJK0Jfkn4prBFnLSYCBY8IZsotsxBNvcpOp4T89z9Ahc3XlAB9ULDms3o5W+QXih8x5UPm7XekhbmcFARXO7WqEjF839fMyKJRk5YR+FOCkvcfhp1aMKKylgrMaA9JuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596054; c=relaxed/simple;
	bh=mGPBdelhM3gXcggLmh6h0OB5fVrJkh0JfbWrRDxLTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+eCO4da1X15CYaUU7cAZ7uw9dqSe/VTCBhgZ4C14qAow4dtbHZJmHkAqjlocM+C2UVb04y1f4/YWUy/1C0bVoLcSCl++AtI76OCpdsv1PiRQeO9Y15wm6U62gXbxb/mhDnvcpjpMVY9xK7VXvnbVjAdpBAZMPc6PsGGNVnHcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6GOhv+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA19C4CEF1;
	Thu, 16 Oct 2025 06:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760596054;
	bh=mGPBdelhM3gXcggLmh6h0OB5fVrJkh0JfbWrRDxLTLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=m6GOhv+xBVa7D1lhSCmvy0Kx8RYA+OShq2vidKd4BDrFoenys0C5J9ceKZ16+dg9g
	 Z8Ia/zdwxfZv31Sx+tUSIQFnsdIzOOo+P6PCz5v4/bPbjCAfuqy+LfJyW9WoMjpfQK
	 lEB4LyUYsaScy9ixT0Pr4r6vsnV2S7s7lOI7K41t4+gC02euE+vZteN7/dXpobC5Bb
	 92X6CiJ8cPfL6pen6l8H9MJpzgbX3DDVnfXWokG5OjYCP9lL/lGGFVufbxmYwUqxEz
	 cDr78Op1J/VfaBNeidZPZR4Rx3pvWL8LWaFNNPtiLsAEEu9KhIaVybO1g+Vow+e3TN
	 F0D+GvBO6/WzQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2] power: supply: intel_dc_ti_battery: fix 64bit divisions
Date: Thu, 16 Oct 2025 08:27:29 +0200
Message-ID: <20251016062730.410281-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 32bit builds, I get:
ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko] undefined!

This is due to 64bit ktime divisions. Fix both by using div_u64().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>

[v2] added Signed-off-by.
---
 drivers/power/supply/intel_dc_ti_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
index 56b0c92e9d28..3d38106b638b 100644
--- a/drivers/power/supply/intel_dc_ti_battery.c
+++ b/drivers/power/supply/intel_dc_ti_battery.c
@@ -141,7 +141,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
 	if (ret)
 		goto out_err;
 
-	cnt_start_usec = ktime_get_ns() / NSEC_PER_USEC;
+	cnt_start_usec = div_u64(ktime_get_ns(), NSEC_PER_USEC);
 
 	/* Read Vbat, convert IIO mV to power-supply ųV */
 	ret = iio_read_channel_processed_scale(chip->vbat_channel, volt, 1000);
@@ -149,7 +149,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
 		goto out_err;
 
 	/* Sleep at least 3 sample-times + slack to get 3+ CC samples */
-	now_usec = ktime_get_ns() / NSEC_PER_USEC;
+	now_usec = div_u64(ktime_get_ns(), NSEC_PER_USEC);
 	sleep_usec = 3 * SMPL_INTVL_US + SLEEP_SLACK_US - (now_usec - cnt_start_usec);
 	if (sleep_usec > 0 && sleep_usec < 1000000)
 		usleep_range(sleep_usec, sleep_usec + SLEEP_SLACK_US);
-- 
2.51.0


