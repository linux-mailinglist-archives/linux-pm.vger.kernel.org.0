Return-Path: <linux-pm+bounces-14375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64897B465
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F92C2831DA
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800505D8F0;
	Tue, 17 Sep 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nve/1LG3"
X-Original-To: linux-pm@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FD1E520
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726601989; cv=none; b=XokKC8ql5R9dgVh+HOVIuLY7ctPwYzMmdn5z0PrO3faB/ezN0b0crOlKj7L/8HaEmjD78HPbeKkIRvPqqmVC91jqzADAkMgKZzR8qbhYOnEn06SEpH7i2xxRSS4ZTMszrZeHc3f3gLcumRB9U8ijRyBsrMHKZ5wG3XLrIpuPzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726601989; c=relaxed/simple;
	bh=21CJ2hDrcYajHVG+KWbsXmf3+A2g28wVVru5X3b+FzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Je0JsWcU5tO2Aia6gzzrxXsxKJKjsgZOmrtm6TmQQzlQbfy4tb39iUjJZFF+BmlZKd2l3gWRy5O+ue1gOWMxKaBo2JB/WyEbNinTIKm7VxfL/+Fo24ps/kUg0R8izU5NSRMrz2hkyjjgo+vzl3iWAhcrzPx7eSWWEUCB6YJ6ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nve/1LG3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X7XDF3YFDz6ClSq0;
	Tue, 17 Sep 2024 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1726601979; x=1729193980; bh=GAHc899aRcqvxcYO6I53mPjJ7KUkPxtU++/
	Dsre4QH4=; b=nve/1LG3V7vS6NKfdmcZgErgLQMPx8rfbOR4/vZ8IdITp2ZQw92
	Jt3gcCwkBLWPY+gwJ9E6/08VbfHFxz5n+xt/3LBoovbn3Qxod6GqyEAdoenJ6eSr
	FZySNphyMO9SDkDEO5osblUQi2WYem2BWtk6Fxrzo8K5u1ZIyiFKjARwoJkv0vbH
	WsdOViA0Zt3PtA4UndYrxnbogDdBE/w5jK+3TszD3r8cs6YyxiQkRBPAiTGDc/Ox
	CO0XCicpJsgp0LNtFv+UJqnkVwH25TL913wLi58dbobSOcZM+B+LQdv7oKIZQ9lt
	VSwpaOpLYlxN+j0PXwQjhhe3hTwRcld9FZw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kRCy-x7KGwUw; Tue, 17 Sep 2024 19:39:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X7XD96bxtz6ClYB0;
	Tue, 17 Sep 2024 19:39:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Kyle Tso <kyletso@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] power: supply: core: Remove might_sleep() from power_supply_put()
Date: Tue, 17 Sep 2024 12:39:14 -0700
Message-ID: <20240917193914.47566-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The put_device() call in power_supply_put() may call
power_supply_dev_release(). The latter function does not sleep so
power_supply_put() doesn't sleep either. Hence, remove the might_sleep()
call from power_supply_put(). This patch suppresses false positive
complaints about calling a sleeping function from atomic context if
power_supply_put() is called from atomic context.

Cc: Kyle Tso <kyletso@google.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 1a352462b537 ("power_supply: Add power_supply_put for decrementing=
 device reference counter")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/power/supply/power_supply_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
index 8f6025acd10a..3c493555c5a4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -483,8 +483,6 @@ EXPORT_SYMBOL_GPL(power_supply_get_by_name);
  */
 void power_supply_put(struct power_supply *psy)
 {
-	might_sleep();
-
 	atomic_dec(&psy->use_cnt);
 	put_device(&psy->dev);
 }

