Return-Path: <linux-pm+bounces-22377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDFA3B059
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AC017383A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB731A3BD7;
	Wed, 19 Feb 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ERLBN7Rz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1F1A314B
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939267; cv=none; b=kTl4SeOMu/CHsg/jbhLH+SgLiSTbg8hM4JXFYDW07VTxtCKmJkUr/M6Hw48Am+gkzIMZ+YeNXhowbj40DybCGM55lFhZhjwYIkPphoRdSV/LIpJ4s64VPnpIJ6/autq5nx15opfUyo54LOLQcglMvCeoYxmB9VOc/N0R44NZ+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939267; c=relaxed/simple;
	bh=G2NwGRTOprg7c0C/ims+5RyQneEgxXW2xCqC3xouj9Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MW8TezgkC6pL6vYyueS2g5AVDsAEufxkC3EXGW3fs51VHmkHlzp4NB2b3YuhBWvEJ9h28iE7mfZd+JfKoksut1IVLwe6gJmwPfnLGqFV6E4f3kswOajjEbUEJ+6/QTMnTfHAzEBAy05Vo3BtK3uVaFZ9ZCpN2tBMsDyNMVwLkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ERLBN7Rz; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id b774aefb;
	Wed, 19 Feb 2025 08:58:23 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
Date: Wed, 19 Feb 2025 08:58:09 +0800
Message-Id: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tMGVYdSx0ZTBpKHxgaGRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a951bb68d1609cckunmb774aefb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6HAw6GjITCSoUHygfLgEX
	QhAKFDJVSlVKTEhCQklNTEtPSUNLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPS0o3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ERLBN7Rz3H2DSPSW/m0wV8JSeC8MviFnWIwNscccKqCu66EQcwUWByOo1tU5rMQFE40XiIgB5cpPQWYFAOB/tB2pYW9CWW+gOh67EWd/05a50bGDNxsEf+T0XBWUgWfzwPwXybSZnsBRUTnMXgxYqhxnFQ9y+3VnthRN2mKbJT4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/L+rxxDdxBVSEg2Gbb6eyXH3WgN6VmGddD0kTepWZjE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Non-existent trusted-firmware could lead smcc calls into some
unset location which breaks the system.

Reported-by: Steven Price <steven.price@arm.com>
Cc: Steven Price <steven.price@arm.com>
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Fixes: 58ebba35ddab ("pmdomain: rockchip: Add smc call to inform firmware")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Hi Ulf, this's a follow-up patch fixing the issue Steven saw.

 drivers/pmdomain/rockchip/pm-domains.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 49842f1..27a5c68 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -572,9 +572,10 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 	}
 
 	/* Inform firmware to keep this pd on or off */
-	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
-			pmu->info->pwr_offset + pd_pwr_offset,
-			pd->info->pwr_mask, on, 0, 0, 0, &res);
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE)
+		arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
+				pmu->info->pwr_offset + pd_pwr_offset,
+				pd->info->pwr_mask, on, 0, 0, 0, &res);
 }
 
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
-- 
2.7.4


