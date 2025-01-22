Return-Path: <linux-pm+bounces-20786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD461A18C61
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FB57A0800
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F01A9B4E;
	Wed, 22 Jan 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iugtxsqT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEA1BBBD0;
	Wed, 22 Jan 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528922; cv=none; b=LGdJrcf1zHIb+i+xhhEG7TLHewZOKTi5RvLhTrvIvO7nn2tBmfMpvjup+3tY73e/fwV0FRVyphtKaFoHvgmREuXuojKBktR3bmz6ElraOtvTuNpUXbMdHcQp3kDDjIW7IKaKEA0mdAGUiRi8T5lRqcogL1LyvB6BtunebV/RTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528922; c=relaxed/simple;
	bh=AHqEFtlv7U5Rxy4RQiTz7u4YZ8TTIymBWDxu2ULpOkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ua55okb0pS7m4uMnhjqmapkcuViSwf45znkfDQYvKsLowyvDXLrLnKCPzN7LaOyF7ZWTGF/xTDW+03GdtDGJdJoFXDnbIAM6cwv/dW5APCkxl4zg75ttX4w/t6FwDqIMjikdmTpEgP+WMyw6XXQqZSKMBuWOr1YtldZ8K2vH8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iugtxsqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B9C4CED6;
	Wed, 22 Jan 2025 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737528921;
	bh=AHqEFtlv7U5Rxy4RQiTz7u4YZ8TTIymBWDxu2ULpOkc=;
	h=From:To:Cc:Subject:Date:From;
	b=iugtxsqT8gIK5FqsBUipFXs/HXewv5ViLgeub7blns9wOs71ie9/+LgK8S90W3Dmm
	 UQeD590b+slAULORqMOHRLvboOiqlrOFWMiVELxvH6FLSZrYAHBxeE7QKgrGY5aEBp
	 Ra7YC1ikYDUgZQhJHjgE84awHnO3kh+XXfwwurYgKpjaO/eIubQJEYPAxp9PE57nBQ
	 tpcghyHzUcF7b4wlnnF4FS4clvBlvaalpLOG6yRa2g30rPx4akaGfr30K8W6+S91S6
	 GquLbgRUJqP7gSmGQgxkZGll43jUoTTrpoufrhR9vn8rXBpuJLEWxNUU3F59GC+Xmy
	 NRrS8zap9oTKQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: airoha: add CONFIG_OF dependency
Date: Wed, 22 Jan 2025 07:55:01 +0100
Message-Id: <20250122065516.1483301-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing without CONFIG_OF leads to a harmless build warning:

drivers/cpufreq/airoha-cpufreq.c:109:34: error: 'airoha_cpufreq_match_list' defined but not used [-Werror=unused-const-variable=]
  109 | static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~

It would be possible to mark the variable as __maybe_unused to shut up
that warning, but a Kconfig dependency seems more appropriate as this still
allows build testing in allmodconfig and randconfig builds on all
architectures.

Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 704e84d00639..9e46960f6a86 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -18,6 +18,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 config ARM_AIROHA_SOC_CPUFREQ
 	tristate "Airoha EN7581 SoC CPUFreq support"
 	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
 	select PM_OPP
 	default ARCH_AIROHA
 	help
-- 
2.39.5


