Return-Path: <linux-pm+bounces-20785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FCA18C59
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42D0164CA3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC291AD3E1;
	Wed, 22 Jan 2025 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7MXG8LN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DE19C56C;
	Wed, 22 Jan 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528741; cv=none; b=OUlIGDwWTY797thZcRalFru4fAX20gdOjq3Tkg24Ck6lcUrzE3UZdM7TlAACKtpqVm7CxnzvOGUAdsCn/oGwzPRyYJcEYuEHYO+amtkAgkWUaEDFwj+ugB9dxiTr9aWyRRyfjCDqNn8Pbh22c5nSbJjIVLN3qkMdBMN4DbJuLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528741; c=relaxed/simple;
	bh=OPbsc/iFv+2Ie29vvqz4aZo2VNR5oU66zmiFZJ/qliE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cot0pb6KDzjXxRAEekeH0JmFVNqdCOXRsNcjRByfwJv4vDUU92R5UCMixBScHnpQjmWKEO+2d2Z/vKEJ1IZ42T1OiRfx+ehBE1SQU8ZX6JBUgp8XS9cAviTqdGOGLFYmg1BkgzW9ucR6Rb3dsh1LQA3YwugooNuGkFoBO77re8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7MXG8LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0406FC4CED6;
	Wed, 22 Jan 2025 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737528740;
	bh=OPbsc/iFv+2Ie29vvqz4aZo2VNR5oU66zmiFZJ/qliE=;
	h=From:To:Cc:Subject:Date:From;
	b=g7MXG8LNQQL6ft2UljHLXvXHYXHRqCsOvHdPGACtnPEXsD9ACk2hnVntQ1oltCIcT
	 OGAKLSXmNGDRcU4LSmJBCsLd07rtEYWD+zw/w4MGe7snncwAdDQpJmhWz6Z7fqJgEl
	 C5td6s+M6Tb9MFf7hj17JTo7SAUUmHAikXM5ZsffJ6S5zClVju2Gbckcl1IRs/hoWF
	 s+qefllLgSCQjykcNc9G9FDjhWYWvrYMk5Z9xmYuTLgmCbAVQE7C/+bP8PeyNEF0Br
	 ezBDQwYSCFPWaOdg9LvexShaq2cwy7RQ33zgyytS9u3nbEYcL6loZALs7p6pL+SrTY
	 y3aHNPNFBm4QA==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: s3c64xx: hide unused variable
Date: Wed, 22 Jan 2025 07:52:10 +0100
Message-Id: <20250122065216.1371158-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous compiler warning fix extended an #ifdef block, but that
led to another warning in some builds:

drivers/cpufreq/s3c64xx-cpufreq.c:27:28: error: 's3c64xx_dvfs_table' defined but not used [-Werror=unused-variable]
   27 | static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {

Add yet another #ifdef check around that variable.

Fixes: 76b218721e5f ("cpufreq: s3c64xx: Fix compilation warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I wonder if the driver should instead depend on CONFIG_REGULATOR
and drop the #ifdef checks.
---
 drivers/cpufreq/s3c64xx-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 8fc43a74cefb..9cef71528076 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -24,6 +24,7 @@ struct s3c64xx_dvfs {
 	unsigned int vddarm_max;
 };
 
+#ifdef CONFIG_REGULATOR
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[0] = { 1000000, 1150000 },
 	[1] = { 1050000, 1150000 },
@@ -31,6 +32,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[3] = { 1200000, 1350000 },
 	[4] = { 1300000, 1350000 },
 };
+#endif
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0, 0,  66000 },
-- 
2.39.5


