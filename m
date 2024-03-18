Return-Path: <linux-pm+bounces-5003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D487E181
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 02:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDE1C20CE3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA117753;
	Mon, 18 Mar 2024 01:13:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD112B75;
	Mon, 18 Mar 2024 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724383; cv=none; b=pTTlP5HEXewloq1xIwmmdwM2TrfBZjHkI33/Dvel0PsxCirkEZV5snaWyN/69Fw4gIfuVX74qdiuZs5FFRcqE3up/lJKADRM/5eMIaT8mHJhVq+spF6ina+SI5n4QZbMsRy0B030HvI2xLbJXaYEpXg+4E1Saaz6X7qrkzowkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724383; c=relaxed/simple;
	bh=BwIoY70oqOG7+/PAkOh6PNcsnU44hGt659prk/apR6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TB1xq+EJvdqrC1mk9Y6/GA4fzF3/AlDyUIswInObZ6apESWytQyJ3PPfgSktQcMbg8SA8xg1MfnUqQXQQjMsnAeVkg40Q3O/x0UfXMannE/KZTQuflVKFctzK0LgtbDsWAboSIWKcxdja0LiNVNgvs6tddMcX0GcRPwbUxAsKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7711476;
	Sun, 17 Mar 2024 18:13:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A0F3F23F;
	Sun, 17 Mar 2024 18:12:59 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>
Subject: [PATCH v2 2/8] cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
Date: Mon, 18 Mar 2024 01:12:22 +0000
Message-Id: <20240318011228.2626-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240318011228.2626-1-andre.przywara@arm.com>
References: <20240318011228.2626-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Botka <martin.botka@somainline.org>

The AllWinner H616 SoC will use the (extended) H6 OPP driver, so add
them to the cpufreq-dt blocklist, to not create the device twice.
This also affects the closely related sibling SoCs H618 and H700.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd1e1357cef8e..3f98c4b31647a 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -104,6 +104,9 @@ static const struct of_device_id allowlist[] __initconst = {
  */
 static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
+	{ .compatible = "allwinner,sun50i-h616", },
+	{ .compatible = "allwinner,sun50i-h618", },
+	{ .compatible = "allwinner,sun50i-h700", },
 
 	{ .compatible = "apple,arm-platform", },
 
-- 
2.35.8


