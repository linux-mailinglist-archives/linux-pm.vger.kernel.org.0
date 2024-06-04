Return-Path: <linux-pm+bounces-8569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9228FB09C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA6BB20AD2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5F145320;
	Tue,  4 Jun 2024 10:55:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8B1420D7;
	Tue,  4 Jun 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498534; cv=none; b=fT4aM0ggkRxZ5nu8ejG59VmV9LhuE3/1ntkc+XE5UlYU2KNa64/PbuIFKHGAhLF0gn96cug3xHzE7YLJ54G9VgiVyFJ6Kg/jSkdXnViOb9qZpARuLl6dY2Jyi1D5Rzx4a7WvtGPZA8M85/q3REZwkCLW/4m5/YlmLCHF6CuLT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498534; c=relaxed/simple;
	bh=IrjdiA7OaHvk1+r0fXbwOcNDCdU3k5R6FBB2dr831vo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W4N2g/pRaLh6YkQw1cZLZzLH1kT3KvrdD/5ZuEeN2hC9nJyjwJm+4FMQQuxY6QJTBvXqhjPmOblaJvwY+tEARfRNbdPhgEOUBh2/Zys9r5+3S2g7yupC0QlUHhj5139IArGSZavKNfBplKqmPgOankbcM2XXwuqwRD/ymQuvxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FBC1042;
	Tue,  4 Jun 2024 03:55:55 -0700 (PDT)
Received: from [10.1.38.30] (e127648.arm.com [10.1.38.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFE73F762;
	Tue,  4 Jun 2024 03:55:30 -0700 (PDT)
Message-ID: <7d999005-4441-4b8a-b159-3d0ebc2ed9d9@arm.com>
Date: Tue, 4 Jun 2024 11:55:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpuidle: menu: Cleanup after loadavg removal
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The performance impact of loadavg was removed with commit a7fe5190c03f
("cpuidle: menu: Remove get_loadavg() from the performance multiplier")
With only iowait remaining the description can be simplified, remove
also the no longer needed includes.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/menu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b96e3da0fedd..783b5d1dacdc 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -14,8 +14,6 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
-#include <linux/sched.h>
-#include <linux/sched/loadavg.h>
 #include <linux/sched/stat.h>
 #include <linux/math64.h>
 
@@ -95,16 +93,11 @@
  * state, and thus the less likely a busy CPU will hit such a deep
  * C state.
  *
- * Two factors are used in determing this multiplier:
- * a value of 10 is added for each point of "per cpu load average" we have.
- * a value of 5 points is added for each process that is waiting for
- * IO on this CPU.
- * (these values are experimentally determined)
- *
- * The load average factor gives a longer term (few seconds) input to the
- * decision, while the iowait value gives a cpu local instantanious input.
- * The iowait factor may look low, but realize that this is also already
- * represented in the system load average.
+ * Currently there is only one value determining the factor:
+ * 10 points are added for each process that is waiting for IO on this CPU.
+ * (This value was experimentally determined.)
+ * Utilization is no longer a factor as it was shown that it never contributed
+ * significantly to the performance multiplier in the first place.
  *
  */
 
-- 
2.34.1

