Return-Path: <linux-pm+bounces-81-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D57F4807
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0761C2090F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF556448;
	Wed, 22 Nov 2023 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="xp/xdxve"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696B11A5;
	Wed, 22 Nov 2023 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1700660501;
	bh=YWU5KKna9LF+cw9m3t3tNTIYdzG8MPLSctxria30Q7Q=;
	h=From:To:CC:Subject:Date:From;
	b=xp/xdxvem75my776Lxc2/FpgqkD6OY6JZg/mLbFV/5iX42prIvXoCo81ocDoLPn5K
	 dacD5xhLLmyitNIgpSkyAnPt6dNe1/J4VVGUEVqblLLFqiaPiIE9F7fWa7yuqoB3yp
	 JBAaeb8AeKqePwlppZGeiEUMT9ON40dBkUJCJ17MTfuTNpES594M4ApxkNbHZaUgco
	 QdDXZ2+AJ81T6WpvfVURa+bQtxzMtTUMfpDFpYjTG10p0UuuChupTKcl+8HDVa7aRY
	 MOCNw8/HD/MZQ3NYqeOwMAEZxzDM4LwwKca3hnde5/af3uqspAuAqqjQF83g4rDAKR
	 S1tQc6ln2/1CA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
	Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut
	<marex@denx.de>, Fabio Estevam <festevam@denx.de>, NXP Linux Team
	<linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2] cpufreq: imx6q: Only disabling 792MHz OPP for i.MX6ULL types below 792MHz
Date: Wed, 22 Nov 2023 14:41:13 +0100
Message-ID: <20231122134113.63670-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

For a 900MHz i.MX6ULL CPU the 792MHz OPP is disabled. There is no
convincing reason to disable this OPP. If a CPU can run at 900MHz,
it should also be able to cope with 792MHz. Looking at the voltage
level of 792MHz in [1] (page 24, table 10. "Operating Ranges") the
current defined OPP is above the minimum. So the voltage level
shouldn't be a problem. However in [2] (page 24, table 10.
"Operating Ranges"), it is not mentioned that 792MHz OPP isn't
allowed. Change it to only disable 792MHz OPP for i.MX6ULL types
below 792 MHz.

[1] https://www.nxp.com/docs/en/data-sheet/IMX6ULLIEC.pdf
[2] https://www.nxp.com/docs/en/data-sheet/IMX6ULLCEC.pdf

Fixes: 0aa9abd4c212 ("cpufreq: imx6q: check speed grades for i.MX6ULL")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <festevam@denx.de>
---
V2: - Improve the commit message
    - Add Fixes tag
    - Add Reviewed-by tag
---
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 494d044b9e72..33728c242f66 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -327,7 +327,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
 			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-- 
2.11.0


