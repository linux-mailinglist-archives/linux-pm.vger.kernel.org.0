Return-Path: <linux-pm+bounces-5002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4687E180
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 02:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B81C20C2A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446117545;
	Mon, 18 Mar 2024 01:13:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70591643D;
	Mon, 18 Mar 2024 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724381; cv=none; b=RiTVZ54MAR9CZsIelm7opR5VoPah2nHIv7oRB57FC56jnDvxdmeNi9G5pHome3fUW255/DgTYjRTIKsgow+qxujmp0w01/hQCK6czrKDiM1tXhn+D7kCJezD3jI+7Z//cMv6I3UOpD89E8Xtbxji5tRB7ueK2FGe9etfYAyIu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724381; c=relaxed/simple;
	bh=/G51sJ1Ifv054jfwisKVsOOLUq4t4F7Vg+QvQBQyD7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPeZV/hksE21DbFFB7BJr2dGpzKK9xTR4fRSRjfqRvDf5D6b9TFiqKQ2a6MIwiQqz1MogMPZh/M0JA4mGzJveCL0Cg/LiJBYpmH/vgKu5J1WEf1ytTbaawEBpZMRpuEVGSjNGWeeUS5ag12I9FR1plt3XGOVdx5Bw9jDUivP56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9097143D;
	Sun, 17 Mar 2024 18:13:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9393F23F;
	Sun, 17 Mar 2024 18:12:56 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>
Subject: [PATCH v2 1/8] firmware: smccc: Export revision soc_id function
Date: Mon, 18 Mar 2024 01:12:21 +0000
Message-Id: <20240318011228.2626-2-andre.przywara@arm.com>
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

The "SoC ID revision" as provided via the SMCCC SOCID interface can be
valuable information for drivers, when certain functionality depends
on a die revision, for instance.
One example is the sun50i-cpufreq-nvmem driver, which needs this
information to determine the speed bin of the SoC.

Export the arm_smccc_get_soc_id_revision() function so that it can be
called by any driver.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/firmware/smccc/smccc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index db818f9dcb8ee..d670635914ecb 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -69,6 +69,7 @@ s32 arm_smccc_get_soc_id_revision(void)
 {
 	return smccc_soc_id_revision;
 }
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
 static int __init smccc_devices_init(void)
 {
-- 
2.35.8


