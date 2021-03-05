Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CE32DF2F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 02:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEBoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 20:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 20:44:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D001C061574;
        Thu,  4 Mar 2021 17:44:16 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id t1so262986qvj.8;
        Thu, 04 Mar 2021 17:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MjUaZQCInKDGPbWxrCzBz9fm0ryt3uxbg3kBPCzuuU=;
        b=HLPMDZPdEgzJEvEJ6BcBwu0tYjX3m6wYobFpfgnl/7d2qFkjP4fWUD+2uhm8DheWys
         5beNZ4/GcQxmeG32D+0pgO7DUmBa9hsxcx4D3fNY8wW/rTdkEotc6KAJ/V1S7drmtU1a
         U32xRK8C7PUwkxh7bDJwKvu8vVlEoLstCGkHMEhM2GP8Fv0utWQPPSuiWB0UbZcjemBB
         XMnpxv0VChD8OD5AYI+jVhfAMbs33Wa2NTbzYtEIOyznuv/3udN4cgyKphkkBsCBCiAP
         45MsTAhRZl2SakQTPgonTisD0R7CLCcvTLZgrStvKsm9SG9nZ8p50lmJ/BhkNzKhhQY1
         CVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MjUaZQCInKDGPbWxrCzBz9fm0ryt3uxbg3kBPCzuuU=;
        b=ft4MnEMCGKmVAcRmlaSsaAU4ebVCh3WC54ORryGzPaDIBERFiEAvJ3ktLo4vLPGC2J
         jdRFoNi8WZSI+pjVMOM1bNoJqbdx2ZFOIxwWmsQgucuthm9fddnVR1SwsSPFPtIgpOWO
         qI6Gmu2A58uvdlehLyeag2l3bOuru+PvjfygEO0QI8B2aZypNSiDfE/XYN9bdSY4vkbz
         fH6u1J+7eHSIvb2PlRLDwnEfVaw2U1ifIJRjbCTbsRJZdd1cHSXoH/3Drccgky7kMZM5
         +hpfeoCaRhw7iQJJfrt89nYSQ8rv9wXFXeXtO7VOmjcFyTgzBycmpHgv0eqdvux1RxQs
         Voqw==
X-Gm-Message-State: AOAM532rzcCcqQdacJdDXBWQSxs+L/VOERbk+H0glFz4cd9IRq90lJex
        8soiMT4483KgZM6Gl1NYALPSqWhIB5BDlS7F
X-Google-Smtp-Source: ABdhPJw5wxTGXpXk9AhCPiC75gGd/9TUQu5os2/HAXdHLdRTxMRFSu2ffNJgSPux19ledDzwk184nw==
X-Received: by 2002:a05:6214:7cd:: with SMTP id bb13mr6758645qvb.7.1614908655415;
        Thu, 04 Mar 2021 17:44:15 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.138])
        by smtp.gmail.com with ESMTPSA id a34sm941410qtc.97.2021.03.04.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 17:44:14 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] thermal: Fix couple of spellos in the file sun8i_thermal.c
Date:   Fri,  5 Mar 2021 07:13:48 +0530
Message-Id: <20210305014348.17412-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



s/calibartion/calibration/
s/undocummented/undocumented/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 8c80bd06dd9f..d9cd23cbb671 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -300,7 +300,7 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 		 * or 0x8xx, so they won't be away from the default value
 		 * for a lot.
 		 *
-		 * So here we do not return error if the calibartion data is
+		 * So here we do not return error if the calibration data is
 		 * not available, except the probe needs deferring.
 		 */
 		goto out;
@@ -418,7 +418,7 @@ static int sun8i_h3_thermal_init(struct ths_device *tmdev)
 }

 /*
- * Without this undocummented value, the returned temperatures would
+ * Without this undocumented value, the returned temperatures would
  * be higher than real ones by about 20C.
  */
 #define SUN50I_H6_CTRL0_UNK 0x0000002f
--
2.30.1

