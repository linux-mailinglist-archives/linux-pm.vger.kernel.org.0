Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40A2DB8E7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLPC0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 21:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPC0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 21:26:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B2C0613D6;
        Tue, 15 Dec 2020 18:26:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so15680168pfu.1;
        Tue, 15 Dec 2020 18:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gYObH6SzfJzYvN/tZJTvaC922zw8HcN4tBTG1FyKiJQ=;
        b=mT1BXkiGGkYhmoLOcNHRfMlEEX7kmEYcQWNhPV8zJbSDPFJEbxMRJxL+CZyNg1EiX8
         YRi4LNw5Bw7ukf0xuL4uYiWU4bSl3moc/W4eDQJta61EoRxDISDfZ/ZTLPx3pfEdrfNR
         gxweTWnpGLAG58Oi7r1y2ALAm3uH7WDpF1m3I+39aXIoNsleyhGSerbA7hCX66dIVE0M
         mcIuZo0UReR1w31fUz3ZWqv8IJMxvi774Nrd10Zuy1/7zDsru1BKo7WWPVjeD+DkssHQ
         FZs4iTfENxynV8Y0SJ0hPSwoE6Fg+swjPQHBnHfSamCNmFqdvmMZ1nHUMSkNj7oDGmVA
         GALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gYObH6SzfJzYvN/tZJTvaC922zw8HcN4tBTG1FyKiJQ=;
        b=FRxrvCPY2tmJqfFjLem9WCICK1XwnXIng9vSl+YoGPMniapeEvTWsH1HlqLcHDxtYu
         VA2CRSDA08+4miW6S/enpMFO2faMLFgRfLG1WtJZTtwZAMOq2nMPJSkXccDAK1jtY2x4
         PCD3LyALpHrQf94YUIbcPeqhauMQ/vegw/dXBjcM/kszQY2WLERtKo6mFboajaSs07M7
         jAilyr7FWcAZd8l6hSO+zCvoLG4uePcfueyBlRY7IzDpgh92eeldj4ikp3WXii7oLvdN
         O68SvvAa8d6Me6+/ND2VhnljSZYAVMhd4tscKLg7lYaTcRCidv1VPrTSUDk0R3Lz7a58
         6OOw==
X-Gm-Message-State: AOAM532hB/ltFlan4N/4ml7RZN4pNOdJUmvdtJqq2rgdiawdexTecknA
        sKCOVHQWNvyY5pqc+wCBndtUUMfL4qAfHA==
X-Google-Smtp-Source: ABdhPJzawIw9FCgB/vUdw34Dm3buyNbPbaGHJls9tGKEoVcLbciUQPsM1V8dr+SvKCEi93ufn1I0mQ==
X-Received: by 2002:a62:808d:0:b029:19e:b084:d5b0 with SMTP id j135-20020a62808d0000b029019eb084d5b0mr20039896pfd.80.1608085565418;
        Tue, 15 Dec 2020 18:26:05 -0800 (PST)
Received: from localhost.localdomain ([1.200.107.9])
        by smtp.gmail.com with ESMTPSA id z12sm299505pfn.186.2020.12.15.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 18:26:04 -0800 (PST)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 1/1] PM / devfreq: Replace devfreq->dev.parent as dev in devfreq_add_device
Date:   Wed, 16 Dec 2020 10:25:38 +0800
Message-Id: <20201216022538.7389-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In devfreq_add_device, replace devfreq->dev.parent
as dev to keep code simple.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6aa10de792b3..94cc25fd68da 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -893,13 +893,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_devfreq;
 
 	devfreq->nb_min.notifier_call = qos_min_notifier_call;
-	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
+	err = dev_pm_qos_add_notifier(dev, &devfreq->nb_min,
 				      DEV_PM_QOS_MIN_FREQUENCY);
 	if (err)
 		goto err_devfreq;
 
 	devfreq->nb_max.notifier_call = qos_max_notifier_call;
-	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
+	err = dev_pm_qos_add_notifier(dev, &devfreq->nb_max,
 				      DEV_PM_QOS_MAX_FREQUENCY);
 	if (err)
 		goto err_devfreq;
-- 
2.17.1

