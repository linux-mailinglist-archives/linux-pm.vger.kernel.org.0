Return-Path: <linux-pm+bounces-24335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52598A6AA69
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247EF484EEF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E501EB1A8;
	Thu, 20 Mar 2025 15:56:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1B1E98EA;
	Thu, 20 Mar 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486170; cv=none; b=XAZRaPqYYCY3+8CGJhBlAFoesncEvJuKBUVN4hfyKaV2nMrRBhIyiJ/YtyH0smHgZjiFPcwj/aex1d0Tuf1Dl35BibpKO1rz8L+vMz/oEdyGb5x8l+V9bgmJ5LY1GioNE26tyM0lWsAsmdZ9CqIZW7hd6HXgy1z3rmNjokbBRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486170; c=relaxed/simple;
	bh=h6Tcpw25xgx4OGNJRXuC8Ivumbn4vEdkkk6QO2pNB4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muvsHwOJns0d+bLniVCgsuyEUVaBF+9ZlHbcsO36Evzy83Yc0YWFOYDr3DeTmezWgk+6CpAidXSw7QyF+n9peNNuH0ZKzx/WGPOuDZxAagyTx/ddhxuN10aQrwZ4FGUWAIX2v84ECg25wwcM2ZQK+bK4DmoYts86pzSaMB576yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FFAD1063;
	Thu, 20 Mar 2025 08:56:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24693F673;
	Thu, 20 Mar 2025 08:56:04 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sun50i: prevent out-of-bounds access
Date: Thu, 20 Mar 2025 15:55:57 +0000
Message-Id: <20250320155557.211211-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A KASAN enabled kernel reports an out-of-bounds access when handling the
nvmem cell in the sun50i cpufreq driver:
==================================================================
BUG: KASAN: slab-out-of-bounds in sun50i_cpufreq_nvmem_probe+0x180/0x3d4
Read of size 4 at addr ffff000006bf31e0 by task kworker/u16:1/38

This is because the DT specifies the nvmem cell as covering only two
bytes, but we use a u32 pointer to read the value. DTs for other SoCs
indeed specify 4 bytes, so we cannot just shorten the variable to a u16.

Fortunately nvmem_cell_read() allows to return the length of the nvmem
cell, in bytes, so we can use that information to only access the valid
portion of the data.
To cover multiple cell sizes, use memcpy() to copy the information into a
zeroed u32 buffer, then also make sure we always read the data in little
endian fashion, as this is how the data is stored in the SID efuses.

Fixes: 6cc4bcceff9a ("cpufreq: sun50i: Refactor speed bin decoding")
Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 17d6a149f580d..c48ed04b82335 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -194,7 +194,9 @@ static int sun50i_cpufreq_get_efuse(void)
 	struct nvmem_cell *speedbin_nvmem;
 	const struct of_device_id *match;
 	struct device *cpu_dev;
-	u32 *speedbin;
+	void *speedbin_ptr;
+	u32 speedbin = 0;
+	size_t len;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -217,14 +219,18 @@ static int sun50i_cpufreq_get_efuse(void)
 		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 				     "Could not get nvmem cell\n");
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
+	speedbin_ptr = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin))
-		return PTR_ERR(speedbin);
+	if (IS_ERR(speedbin_ptr))
+		return PTR_ERR(speedbin_ptr);
 
-	ret = opp_data->efuse_xlate(*speedbin);
+	if (len <= 4)
+		memcpy(&speedbin, speedbin_ptr, len);
+	speedbin = le32_to_cpu(speedbin);
 
-	kfree(speedbin);
+	ret = opp_data->efuse_xlate(speedbin);
+
+	kfree(speedbin_ptr);
 
 	return ret;
 };
-- 
2.46.3


