Return-Path: <linux-pm+bounces-27785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC217AC75C7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7139E4E7D1E
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50E243374;
	Thu, 29 May 2025 02:16:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783819B3EC;
	Thu, 29 May 2025 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485002; cv=none; b=MpdE19/hI37efbfeayl1ajIt8b0THAytEaeQXsIxPxkhgTi5y5rVLBYUhfnpFSbc+VZz1WqQx6Y3IEGT8cttIgVNCeldBAa0wo17EIOTFShupwWAVQ1J/iwUYQYJk1Aioa0RhGOv96E8zBYSWNvzx6Ead5eySisWtddRCrq0tcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485002; c=relaxed/simple;
	bh=SvmnQ9uRbX3vQrPan2LiljtAydLj9OgPgyjQaDI+0QU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=qmRYSGnHOg4uf8intgc0qvFQYnjEqtjUfKF34mqplF0RP5+VyrV1kCMwDUYdFSsm2GVE5kZumYIPQ68Cml5Jxwf4AHpF7N/U+6YmzZFgYu8CGP3r5drpyWNQ8lINYMKPQFSXC6AiiqL+oPjf1x3vA5btGD0sTLtznt77VaF47YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b793G2LQgz8R044;
	Thu, 29 May 2025 10:16:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 54T2GG2H029125;
	Thu, 29 May 2025 10:16:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 May 2025 10:16:17 +0800 (CST)
Date: Thu, 29 May 2025 10:16:17 +0800 (CST)
X-Zmail-TransId: 2afa6837c3712a5-4a972
X-Mailer: Zmail v1.0
Message-ID: <20250529101617844lQtR4fOKHch_xIBWSgzgX@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ulf.hansson@linaro.org>
Cc: <heiko@sntech.de>, <sebastian.reichel@collabora.com>,
        <detlev.casanova@collabora.com>, <krzysztof.kozlowski@linaro.org>,
        <finley.xiao@rock-chips.com>, <shawn.lin@rock-chips.com>,
        <pgwipeout@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?cG1kb21haW46IHJvY2tjaGlwOiBVc2Ugc3RyX29uX29mZigpIGhlbHBlciBpbsKgcm9ja2NoaXBfZG9fcG11X3NldF9wb3dlcl9kb21haW4oKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54T2GG2H029125
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6837C37A.000/4b793G2LQgz8R044

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pmdomain/rockchip/pm-domains.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 4cce407bb1eb..0681c763f843 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
+#include <linux/string_choices.h>
 #include <soc/rockchip/pm_domains.h>
 #include <soc/rockchip/rockchip_sip.h>
 #include <dt-bindings/power/px30-power.h>
@@ -595,7 +596,7 @@ static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 					is_on == on, 0, 10000);
 	if (ret) {
 		dev_err(pmu->dev, "failed to set domain '%s' %s, val=%d\n",
-			genpd->name, on ? "on" : "off", is_on);
+			genpd->name, str_on_off(on), is_on);
 		return ret;
 	}

-- 
2.25.1

