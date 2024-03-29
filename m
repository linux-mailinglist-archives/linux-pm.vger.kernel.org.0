Return-Path: <linux-pm+bounces-5677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35189209D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 16:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396A0B2E5C4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E9146A9F;
	Fri, 29 Mar 2024 14:13:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B914535D;
	Fri, 29 Mar 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721618; cv=none; b=ejgsETFI4q6pgCbyacIeBcX92U+MqgHgzEQJvtzPF7mS0Hx0PkNcW+/GyyY1Va/ZIqG9C0dbk2tRIVA0ZsWVyyTUo/DkBGfz3h0VTn8lw4tcbjfyQY0120jrAsNIWA8KYMrN7sJvWZFPygYadF/SQq2Sj6AYSPspiX5kGekwPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721618; c=relaxed/simple;
	bh=uy4I8W2pojY6PLi7TcK5i89Ba3IrwWBIxIEZzB73pqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cydEiX+KkrrYGZfHQVgygcTfcdIg4pX58fLpwKy7Dsr9VGkdXMNmdlPZYvH2mzUNZW9bI+/cRSHl5ODSGCXqqa4/q4TD5/ynuNhZ9EzOq/PFfilzk6x9QOJPqGZcTgCcGS9/xEukWFVMcKELGcCBHEqtFL6Wyd49zKPxaN15Yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B722715A1;
	Fri, 29 Mar 2024 07:14:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F5843F64C;
	Fri, 29 Mar 2024 07:13:32 -0700 (PDT)
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
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v4 1/8] firmware: smccc: Export revision soc_id function
Date: Fri, 29 Mar 2024 14:13:04 +0000
Message-Id: <20240329141311.27158-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240329141311.27158-1-andre.przywara@arm.com>
References: <20240329141311.27158-1-andre.przywara@arm.com>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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


