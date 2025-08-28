Return-Path: <linux-pm+bounces-33256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D7B39D88
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521C51C8261A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA103101A6;
	Thu, 28 Aug 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMFoCJHh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A130FC01;
	Thu, 28 Aug 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384856; cv=none; b=AP3+niykbkzYGCkb8fXhieQadRUDsanBz2+Yy3dHekz4UlrTcsWwZcbKadCg69Tpl8YezJV1zvtAKxD74qwUA08SUZVQ0nFI3U5EXzchr1HWgHx9wgLAB+NgAHJmXoHJDu+0pMG2OFJ5mcOFtar5miraEIRhwieXfSeqkFtx5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384856; c=relaxed/simple;
	bh=SYKjW1CPF3qauGasMR5vakecTnZSMkkKlxT4QBDF9ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhOmpBLLydwu1Q62jgiyCvjaLKdzyB4+f3oLdWQkqNyULp1wB3bCbMDZYXF/1JRAKCJvaotP9KWwPBFq1z+mpsVkA30UkWLyoos0DpHur81vkhjZFDb1iYWnWv5DaMS8eG17fYKVK2apFUPhd6ze04aSBtKcpYv0khYFWVW3/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMFoCJHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5ABC4CEF5;
	Thu, 28 Aug 2025 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384855;
	bh=SYKjW1CPF3qauGasMR5vakecTnZSMkkKlxT4QBDF9ao=;
	h=From:To:Cc:Subject:Date:From;
	b=IMFoCJHhkcMKdGmApJu381uY8Wuet4Ba9V6Tvvnv0lXIRIcXO9JumVykISh+fyRYN
	 JZ4eWoL1bu7FVjBaT/9waQLzv+yh2bmsmDuSd9VGLOnsgPb9IK1quX5qLPoQFsKrbR
	 yko4BTIfuPEPzMroqiyn+bcvOWwVJy+ANTdzWpToronW4aalBiqAdJqjTRpdZe0Clq
	 dNm7HHZ5XOaiDtL1A3ld+Z5Rw52Bd9s2yIFO/sLVSC4U8BNMdJ6pKJOqJR2aYtqPzm
	 aMBQ0v+lfRqehJovy+JGyRwk4PZIdFqJ7UcAWiwmbsAV7rlIScAnBxqGLbMtz1fEUH
	 3o8KPZCqoDzYg==
From: Michael Walle <mwalle@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] thermal: k3_j72xx_bandgap: register sensors with hwmon
Date: Thu, 28 Aug 2025 14:40:42 +0200
Message-Id: <20250828124042.1680853-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the sensors available in the hwmon subsystem (if
CONFIG_THERMAL_HWMON is enabled).

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index a36289e61315..d9ec3bf19496 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -20,6 +20,8 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 
+#include "thermal_hwmon.h"
+
 #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
 #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
 #define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
@@ -513,6 +515,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 			ret = PTR_ERR(ti_thermal);
 			goto err_free_ref_table;
 		}
+
+		devm_thermal_add_hwmon_sysfs(bgp->dev, ti_thermal);
 	}
 
 	platform_set_drvdata(pdev, bgp);
-- 
2.39.5


