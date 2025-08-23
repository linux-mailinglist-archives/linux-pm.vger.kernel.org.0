Return-Path: <linux-pm+bounces-32931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A5B3283E
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 12:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065F4564310
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339E24113C;
	Sat, 23 Aug 2025 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rhRCxPlV";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="b8pxFERW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2403155C97;
	Sat, 23 Aug 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755945675; cv=pass; b=NFJxjhkcX3qemjdNyQ9bMOy1gpHHE+dCk4YN/d5fal0hQ1nhlMBhcUvR7fvNV+VhowS59tdTNQKXbPz12C8UutJJeerYGDBk0kIvVx6K2D8dtg7w8LDpopB/DyV3Y4PpTwiTWxdajlmGL2iMMU+2S0heOJXPprvtu1Rn5xlQ3DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755945675; c=relaxed/simple;
	bh=MawRy2xEhZLTUtLETTRtWcH1zpG2srMTHg2OXKjI2Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q49BEfjiAcjv1rtZ9YX2GTH5S6uqgOQedHtq0tstjBoo2mscjvNFZrD2nCIf7PnxK2k6jb661WpLt2+LGs0mJ/TYr70ssmRITos4BlDs2I+fXM7By2MaGRAiR9XRyobjRuMNbxU8fLYyJ5eYB8k2Me7mGwC3ElwMajIwEJjGD4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=rhRCxPlV; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=b8pxFERW; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755945306; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ccjL84k9oad73SjXywCEs4JEEcXZjgt+IlXBIw0JZv9hSc1lh8/tXoiiFtR1oGrzIm
    coYlUCM2zgj7LUBmUkA1EbzkZIxkEQmlIj8R4uDZslevNJUQp/W9dwi8JKRvbwmJeRSD
    klOuKvdb92mm6ytPUUL2FNPrQvteGxba3IGhM1ha+MnRQGs3AVtPJfnV6W6HfGabdpt0
    Jpp2MS8/eXdtmjDT+VLpU8Mz3EjcAF91Ud7wVMMaxm2jZxIJnKJG6uYzKPrK2TZIOKkC
    DxyiRctOvaWjKmHjA2hEmr/FQCTlEySqME8VTajIYrIbCHw+c/laFEBUNlQ7VJfRtGnq
    g84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ywSM9/auq97TI3crGKODL5ZEJlO8sLbYmQXUvarBnMQ=;
    b=JIptc8laWgi3qhEXM0PaO0siHJb/QC6VEAz6kLZw+ceCzC4I04mytKjAk/FHUGkpyJ
    ZaCGodhqLo18YCaFiDH8pWYIBvnV4HxagHwTRc2NYl+wnr+kLqzPagfiBZnGK2Fp/U8U
    fHnPAn/Lx6wMGoSUcPJm6WoGwgJKvjb1fgJUTr7h/P6SZ4gQPN09MQq3q4TH0h1YLIOq
    eJHu8FYqQ/P3Bf0adBWF6q9Y11aVVlolDtdaAE5mom0GtwcqkDAryRa3RXsXMk/B6me2
    jyW7h33BlBCYJqqCnUeKBP+dpmqKNE+FMYmtsVkRu39aNlOH5w0a7k2oQ1cddkBDKAZQ
    BWhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ywSM9/auq97TI3crGKODL5ZEJlO8sLbYmQXUvarBnMQ=;
    b=rhRCxPlVdeFNbqhe4vRyxPsUk7eimlotkG8NH4DqJ0MbutL97QaYiuc0jf9kYixWJy
    KUIhLHnAqejN25Khiq8IXmqY88SccjySBD4xVPqpHPHwylnGOzPFob3LRawx2gXwB9Zb
    U52kHfrll7TE8HVLbpJiBnm6ywLaWwPb6wIHPJr3nJmEQ4AjSMv8UJdH+5OCMsLoqc5m
    gMAqRnc14HrokK6DWBMIWdV/Qj2D230oIImcj3ZZM/G0nVzoZFWkbqEymvtLjePrFfZN
    ciXmUvJA9j/T0uzhA6QJjUilmpD2miUvxCxFbu5gwLWrVhXcUpGQKlklPjR0ZgChiFg2
    ApFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755945306;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ywSM9/auq97TI3crGKODL5ZEJlO8sLbYmQXUvarBnMQ=;
    b=b8pxFERWNRh5cg7R2Y9NrvdeUYX/Slxf0usZn5jbb6hmNjDP4Pg7LBCuW5hfWcOIGD
    /ysMa0zpRGMbehaiiAAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ35pZnciHiRbfLxXMND9/QZnI+FEnHoj9hoo="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a417NAZ58w7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 12:35:05 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
	Jerry Lv <Jerry.Lv@axis.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	kernel@pyra-handheld.com,
	andreas@kemnade.info,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/2] power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
Date: Sat, 23 Aug 2025 12:34:56 +0200
Message-ID: <692f79eb6fd541adb397038ea6e750d4de2deddf.1755945297.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755945297.git.hns@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Since commit

	commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")

the console log of some devices with hdq enabled but no bq27000 battery
(like e.g. the Pandaboard) is flooded with messages like:

[   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1

as soon as user-space is finding a /sys entry and trying to read the
"status" property.

It turns out that the offending commit changes the logic to now return the
value of cache.flags if it is <0. This is likely under the assumption that
it is an error number. In normal errors from bq27xxx_read() this is indeed
the case.

But there is special code to detect if no bq27000 is installed or accessible
through hdq/1wire and wants to report this. In that case, the cache.flags
are set historically by

	commit 3dd843e1c26a ("bq27000: report missing device better.")

to constant -1 which did make reading properties return -ENODEV. So everything
appeared to be fine before the return value was passed upwards.

Now the -1 is returned as -EPERM instead of -ENODEV, triggering the error
condition in power_supply_format_property() which then floods the console log.

So we change the detection of missing bq27000 battery to simply set

	cache.flags = -ENODEV

instead of -1.

Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
Cc: Jerry Lv <Jerry.Lv@axis.com>
Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes to v1:
    * improved commit description of main fix

 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index c3616b1c07e6f..dadd8754a73a8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1945,7 +1945,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
+		cache.flags = -ENODEV; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
 
-- 
2.50.1


