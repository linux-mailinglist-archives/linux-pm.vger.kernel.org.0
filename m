Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A32CCA81
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 00:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLBX2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 18:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgLBX2F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 18:28:05 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5ACC0617A6
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 15:27:25 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id y197so480954qkb.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7aljCV+aBW5G6lMmj9SXJiqAnzB6By3HIyFR3aM273U=;
        b=pqGlMAN6fHB/x2jflm3Ved/oC/LuCFSGw9M2xP3HrVaNdGoB72pyQ+2AbeiE2d5q0q
         94ma64Vd72wXGgkrU6RdAogtJWs/m3Jh+MK/1S7YKPoKH7tH8/AmUIt8EPObh8MTFZT+
         CcH7+fJqEy/xkLdpFFBkgjDqEMby5NT0u6/jKc/VnM6Idx39bC8prna+6adq/eMSdONI
         VcqXCGya4Lrz5OAOaKm+BH0E1pc+4eJaYX58mAwZKDCFYR2AzcJmcI4+2E7AOTaR2j70
         51E5jkPFdlyhO0n11ZX7ETTGzUUYF8RQFUm12yOA9ICvEu6yE4qrMv1mNokJyLxZwLc4
         JhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7aljCV+aBW5G6lMmj9SXJiqAnzB6By3HIyFR3aM273U=;
        b=L94sBrTHyJl2cPRDQ1/6tUrCDrwbR/F1W/lGWhS0+2SA6jM0FuiZqyr1A8zLtdmWB8
         MqoJNDlKjcXLx8XmwHSejhbIjiNzgBTn5vIvbBRmA3Kfkja1ON22+MfaIXeJQUh1xGcx
         H6JQ5/PXTxiXOMQg3mnGtp6kH0Q2JCwQS4eQnLdSZIPWoI2Q/ccQOjI/t2HAH6yT680Y
         TsrJCLPDPgrulNdtIY18y9Ekl3QyRncX6ee1PMJ4d8XRcE+kPmwhTk+SrlHkv0rOZVIB
         BhnNxf/Ah59fC/XraAVw7LNDIZ8lD+cj+gM70WQql64CfNch9iNUE7L/1DA9dlnn1GcM
         8YMA==
X-Gm-Message-State: AOAM532xxWhB8l968lfHRtbyo7dAjLPvWUtRcwDldnu//az9KWiReu5O
        kfllLwV2DUgNCLW9o9KmeuY=
X-Google-Smtp-Source: ABdhPJy1MZHb79RNgRUlriSJHBZl4k+uGbihVVCCUROxFd+iaTaSWEeSdj+E58tQ56u3o2BFqcbJ0g==
X-Received: by 2002:ae9:e8d1:: with SMTP id a200mr225603qkg.142.1606951644653;
        Wed, 02 Dec 2020 15:27:24 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id u15sm145079qkj.122.2020.12.02.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:27:23 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] thermal: imx8mm: Print the correct error code
Date:   Wed,  2 Dec 2020 20:24:47 -0300
Message-Id: <20201202232448.2692-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the error message does not print the correct error code.

Fix it by initializing 'ret' to the proper error code. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/thermal/imx8mm_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index a1e4f9bb4cb0..ce7cb6452c52 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -166,10 +166,11 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 							     &tmu->sensors[i],
 							     &tmu_tz_ops);
 		if (IS_ERR(tmu->sensors[i].tzd)) {
+			ret = PTR_ERR(tmu->sensors[i].tzd);
 			dev_err(&pdev->dev,
 				"failed to register thermal zone sensor[%d]: %d\n",
 				i, ret);
-			return PTR_ERR(tmu->sensors[i].tzd);
+			return ret;
 		}
 		tmu->sensors[i].hw_id = i;
 	}
-- 
2.17.1

