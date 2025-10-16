Return-Path: <linux-pm+bounces-36217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E7BE1B38
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83619C7A0C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2782D3A7B;
	Thu, 16 Oct 2025 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8x+/whe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC92D24B8;
	Thu, 16 Oct 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595846; cv=none; b=PEAHZgEzlXxwSq20X3FWqmh+wtMtdCEjxvib7EyFkji5qjkkkQoqVvyfOzg38uzp6PcQ7HpTfo7yjEXJQaIJbf95YIWA73r+/vc5Tx47leHSIXDD7od0oLxpLcICPeApqxYlhciO2AGHYjgkvjJtBUKWFaD657C2GoHcfWtM7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595846; c=relaxed/simple;
	bh=qMC0IxEb6NTfUfw9jV3WwM+mLfXoaAYouX7oyvcmmqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUEx10hSWOwsfqDkXVKjhXrdGtQTPe1MFl5E3nYXzEWHWDovMbAFcs/kUZkc8rP3/8iBXVkmAeYOeUK0c2ghzI9Vr+XtfITDnZJVBl+WFO1lfxZxS2f+kauzjEI23Da7jvMIMBdLoozEHOkY8f58RAmS/IZv0lQrsJOKoIFcQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8x+/whe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FDBC4CEF1;
	Thu, 16 Oct 2025 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760595845;
	bh=qMC0IxEb6NTfUfw9jV3WwM+mLfXoaAYouX7oyvcmmqg=;
	h=From:To:Cc:Subject:Date:From;
	b=U8x+/wheNLLVgKiDnshOyRa6jCwmy3Yy+kLBrc9dCafwa4lX5WOZqVfIsBz83RoVX
	 eXiT50IFSzjcdSkoL9Pd9xDkQD8wC8GHmP7hJqDMbSZ7F2LZbz3hN9kfEShiTgO91+
	 7rHpNO5BRyzA2CV8AsLLJ8oAeefPip0TdAHTLhWPPtCEdD8TvcGh7UoTpY+5QESJUd
	 0swFsBsen/9n1tTH1eMwlTOIh5uvhvyRriLQf13lduTQfLzvp1tLziRjn+Wxp18m2z
	 N0+4q5O5xJKEn9yuaqVrPxLPNAvP1piB+dC32UhUGL/dUWCEiBqm6u/GGYDI163foC
	 btOMteVUjnxWg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: intel_dc_ti_battery: fix 64bit divisions
Date: Thu, 16 Oct 2025 08:23:57 +0200
Message-ID: <20251016062401.409809-1-jirislaby@kernel.org>
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

Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
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


