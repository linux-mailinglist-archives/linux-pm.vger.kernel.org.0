Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F32C0E65
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgKWPEF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgKWPEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 10:04:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8AC0613CF
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 07:04:04 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so5966977wrr.12
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=iFIqV+YGiYB9aG5CLxzS34LR/Z2KSoGhHjVGp/E5Ez4=;
        b=oj/DD6b5mamV3t1QMmW8d46i900iJmfq981OPhiJmbxVoLymtRX40HrQ2kT6nPNDXQ
         IvblxW2f1MBpC0m7CvlNGlpSiVH4ujD9akWHyHWr0Hn45YgkWczSyjJW7shHg4fWJ2p0
         GHCrSqDV7a6YlsN2lyGdjFJ989RCnoW0y/EiqLWGDYpzoaGklQ5RTYNkhPWi4VGpnHTL
         8rx2HVjG3Q0DN9tGApwmFJorDngov+5frtazxKqukaDgEd+mgmbzpHt9RAJn64ZqLNv3
         KqWp4g0OvtowLRoSO64v7NnKxizwWp4c5VD/DVlLhx6GhRSm0uvos0m/npsfiCH1LW0c
         y2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=iFIqV+YGiYB9aG5CLxzS34LR/Z2KSoGhHjVGp/E5Ez4=;
        b=Sc+vq11emO2TvqcO9x2+Le8BqEfiKRM44tkP6F/b8q3zj60vyt3EHCNx6eBShga4+n
         PUmEzOHWPO7yg7k+ss77JreVUkP9VPfzATYSsHjdywKfjaf5MV0YBdoTDOCkpkYX8nG7
         Az/KJMoXXeLE0FSbbH8mRE+GEopJNONqNzYqLeiQPovDB8UyQ3ngMJqA5rf3FFOe7Cj8
         rJnKSzUTGXLWjOoRR4CVl+ZFW20aO51nzXGnU7lC5qK9u3BVmaat6bZqefNiq47b9u6V
         nQo9Kb1hzacTU3dxe7yWp/9LwULqtZPPrPxKoFkSMYK/dvIKaj/fJfjFh6cXOruMQG60
         sTFg==
X-Gm-Message-State: AOAM532fyqnrto/b25hp6fgkC54NFXQb9ttsb0YiNquen8yMNtVCtJqN
        j2tykDEtOUO7sPlLovhpUzmVyRICgW86QA==
X-Google-Smtp-Source: ABdhPJxyMCsr98uaRGYbMvh8Jm04QR0VWcijLpeDN1AB28hEarB37tCPal5vISCWX3T7+imTTDNBfA==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr24091wrm.259.1606143842980;
        Mon, 23 Nov 2020 07:04:02 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:d1d8:f2e1:2730:2a3a? (p200300ea8f232800d1d8f2e127302a3a.dip0.t-ipconnect.de. [2003:ea:8f23:2800:d1d8:f2e1:2730:2a3a])
        by smtp.googlemail.com with ESMTPSA id a144sm18709469wmd.47.2020.11.23.07.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 07:04:02 -0800 (PST)
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] thermal: core: don't warn in case of ENODATA
Message-ID: <160717f1-4bf1-842a-8c11-9c4d03962d0b@gmail.com>
Date:   Mon, 23 Nov 2020 16:03:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices provide temperature data only in a specific state,
e.g. iwlwifi requires that network device is up (firmware running).
If a device knowingly provides no data, then there's no point in
alerting the user. However the info about the missing data might be
useful in some cases, therefore add a debug message.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/thermal/thermal_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 90e38cc19..19bb6c99c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -454,7 +454,9 @@ static void update_temperature(struct thermal_zone_device *tz)
 
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
-		if (ret != -EAGAIN)
+		if (ret == -ENODATA)
+			dev_dbg(&tz->device, "no temperature data available\n");
+		else if (ret != -EAGAIN)
 			dev_warn(&tz->device,
 				 "failed to read out thermal zone (%d)\n",
 				 ret);
-- 
2.29.2

