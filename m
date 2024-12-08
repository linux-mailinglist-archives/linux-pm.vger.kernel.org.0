Return-Path: <linux-pm+bounces-18773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8EC9E8537
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47582164548
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F26156228;
	Sun,  8 Dec 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M7UavA5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133C15383E;
	Sun,  8 Dec 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662966; cv=none; b=X/s+KMyLHJ3+la8zvdkD/3KdIaMkPTh7va6as/HyCkHhNLJyIURLmqqMz/avygXshUPSBWrv5tKAZ0JOQhm8z0P4COAdzxW68kU/NQ33g0Ko42AIR9xSsWZtQIzQaT6EYeHGg9vtBbdgwxBRQhHAmiDHjIsQqK75kJDs+vTKZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662966; c=relaxed/simple;
	bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyj5+HFscZqo828KwNUYN0Tt4u86WSoOQ93jHzkmvL5Gv62NUOJE28LTTlZSNfcxWP1XnkWKnVBueMbR0HAx8J0qCu0O1g4dXHq4qHOAHRBhP0BoixhUpZYLFE7kgXfeFCO42SCRIHFHYyDsJTulsNtJRqtft9NwCgDcI6QVcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M7UavA5q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662959;
	bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M7UavA5qy1QVu/RdE+YVP3x326BWMddRBIRo1IbW52B414OtIibpJFqMUayht8cV2
	 NaydCyg08xVmFYvEVnL6t6cqnEMi7nwwB6VCw8/0B+6GghZ6e5NyhJjt/XjMIUP6uB
	 CmpFGC/74XX0NR1QXA1hVKYW+2MYN1o8VCmnWcLA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:39 +0100
Subject: [PATCH 07/14] power: supply: core: introduce dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-7-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=1136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4MUBctpjIhutpInrWEdlcQerzbKY4rDQAhCW3psko/c=;
 b=9bC2DRUJnma1H6cYOd5OGnAzZ/kZi++23PXSPscD+kPsui2MgUFNAvIgkL2RfXaXQIZ5dr1BC
 i0PAU5xCYGLCBIrByTHkR09w0aAt8Q83LNb3XSq5FWOhjNJgCQiO43X
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The psy core and drivers currently use dev_get_drvdata() to go from a
'struct device' to its 'struct power_supply'.
This is not typesafe and or documented.

Introduce a new helper to make this pattern explicit.
Instead of using dev_get_drvdata(), use container_of_const() which
also preserves the constness.
Furthermore 'dev' does need to be dereferenced anymore and at some point
the drvdata could be reused for something else.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/power_supply.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3d67f4a6a1c934f387adde12fc96a63a99299923..17fc383785bf5705ef3dbe5fdebf90843684b715 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,6 +318,8 @@ struct power_supply {
 #endif
 };
 
+#define dev_to_psy(__dev)	container_of_const(__dev, struct power_supply, dev)
+
 /*
  * This is recommended structure to specify static power supply parameters.
  * Generic one, parametrizable for different power supplies. Power supply

-- 
2.47.1


