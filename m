Return-Path: <linux-pm+bounces-39951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED0CDEBF4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 14:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1623007C64
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11700314B6F;
	Fri, 26 Dec 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfMQKgpz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2467081A;
	Fri, 26 Dec 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766757062; cv=none; b=gV7KqU/gNoVB318VJPv8iV3Nif2m+1pS+591ATH+uWxH4xtuhLWU5decwBA26U0sLmrJqiaHWQHLoRHCfdyQE9Zr1wheoiKjNofOussa0aUj0Z5JUqc6BS5VGGIsg3Gio0tguVrhDc3B37W85X2f4AlqQhLSQE+vcZrOx3p6Uo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766757062; c=relaxed/simple;
	bh=qJaLrHzR1qlARbbGW+Q9FWuH59m2iT5wrPIchlfSNts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZWnCoULEiRPwvFs+Hp8xtdop7x9J56j0dO0Ow594awucEfDStNQjdKPmomvIco6PpvF+3sFj2M0UvMbSxCh3TYVcnm9Z3nSdK6d8VQ9Tz1a6757Z7WmHAVfESkVIMUcAZpFe48ucIzauhnlxWIB79waRj73YFhC8i4SdEEAp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfMQKgpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB11C4CEF7;
	Fri, 26 Dec 2025 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766757060;
	bh=qJaLrHzR1qlARbbGW+Q9FWuH59m2iT5wrPIchlfSNts=;
	h=From:To:Cc:Subject:Date:From;
	b=dfMQKgpzfAx6rReMb7YMPflRbP8blFixMCBvoWGCdJg3GFGKmCFDyLQTz0Mk8vZaS
	 XPek+q2PG6Qah3CGTjM6QaeEZgbSCbtgDvrMytsAmaXcI9uhaZA88q7V29DnfnsX/o
	 SxgsvqHSgf3nDEMAar895QiQM+6F+ti/5wBIQyxXkAb/n+AwfIGM4VwnxHg3bepicz
	 w2KyZAq3rKDY9jo7ESAtHzBzqy0QzoISGEFS96F7moZLJVWIiT2XCSbLX3p9fUAJtX
	 ANXiFv73lIu3ACjHCXLlPyhAtovNuauzVaMmrWPTTLf+Wjch27W5xVW9apvhSWHbHr
	 xuodvYkNQa1mw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] PM: sleep: Fix suspend_test() at the TEST_CORE level
Date: Fri, 26 Dec 2025 14:50:57 +0100
Message-ID: <6251576.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by
wakeup events") replaced mdelay() in suspend_test() with msleep() which
does not work at the TEST_CORE test level that calls suspend_test()
while running on one CPU with interrupts off.

Address this by making suspend_test() check if the test level is
suitable for using msleep() and use mdelay() otherwise.

Fixes: a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by wakeup events")
Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Closes: https://lore.kernel.org/linux-pm/aUsAk0k1N9hw8IkY@venus/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -349,9 +349,12 @@ static int suspend_test(int level)
 	if (pm_test_level == level) {
 		pr_info("suspend debug: Waiting for %d second(s).\n",
 				pm_test_delay);
-		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
-			msleep(1000);
-
+		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++) {
+			if (level > TEST_CORE)
+				msleep(1000);
+			else
+				mdelay(1000);
+		}
 		return 1;
 	}
 #endif /* !CONFIG_PM_DEBUG */




