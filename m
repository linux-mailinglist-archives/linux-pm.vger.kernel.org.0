Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753626D356
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 08:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQGAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 02:00:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457FC06174A;
        Wed, 16 Sep 2020 23:00:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f1so528261plo.13;
        Wed, 16 Sep 2020 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L+n8O03kRtHAQB8HeA2TekCPJc3BthVlbg+kGkS/U9I=;
        b=i17tH6dAzp+22MDJ6C8x6tK0XY9DBubi96Sywpatf7u6LkqpNF9L0GUZxUVG7pnb8k
         mQUFPINZMKnNMpU+JmkDKjFxryhX/u1dpJcGjLn4WOUAesOM+Wx3wxywDlGuy9u6OOV1
         wG5+qtbr57SZsWTR9toh3/Qj8AbelXQYmRfm7aYdxrI+trc4gDV6SIFSaW7JbWo+vrK+
         tcqVjXH5eL8CnZslGO2RBves/ZeefKbfTCPcYUGL5BC53lR4VYQ8Dj9H4Qbaj2Kk09GK
         IjlIp/3sEQh77JV2Jwv7cKUEObln5bEAFynyZF4bsnVA2C10dML2ct7aBuoWt9lA1fak
         tqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L+n8O03kRtHAQB8HeA2TekCPJc3BthVlbg+kGkS/U9I=;
        b=pp9YgU4PiuCSy4VIESVwKh2y0VGCh6MIlaeMIn7wWuiyc7PecNFk3/k3S9sfSRdGb1
         ajSKj1TFAdKn5qPLsMlkvUTeSf7AbCbtp+EcGFgj3SVWQi2l2+Q2yvOL6J88diPR/DLg
         +OfYRhnqDwJYO7X02qtOEcTJ8NXCpjtq53jtlj67Qv+K1BdsJaavSuKdqxESSqF+gZEn
         8Tgbpux8duaYIViYneta04ScHluhTEDiUr05eX+QJuBaw3uJHMO4Il6/MmSoKl/u2Xko
         ZSSHTXmuANIGoQ3VggbkZyYUNadHSFUYUwEr88qJidGRrOhOuvmkfTEiy1qaheHiPFtH
         wG2g==
X-Gm-Message-State: AOAM530+mpXh9AxyyqcnhhjX8DRQCd+ayY1kK3vwtb/4dDySTFziNn8W
        PzRiBdMiCisT/7cQ2msSbSM=
X-Google-Smtp-Source: ABdhPJxEAwIoMBefG1Bgz2UXHHiaQYa2f/aGNkGF0+FLDpZ0T1rQ4mxuoCF9K8no+MB+Pyzfnzp4xg==
X-Received: by 2002:a17:902:b086:b029:d1:e3bd:48ed with SMTP id p6-20020a170902b086b02900d1e3bd48edmr11189453plr.14.1600322449055;
        Wed, 16 Sep 2020 23:00:49 -0700 (PDT)
Received: from localhost.localdomain ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id d128sm13300167pfc.8.2020.09.16.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:00:48 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state function
Date:   Thu, 17 Sep 2020 14:00:31 +0800
Message-Id: <20200917060031.6566-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

In the function cpuidle_cooling_set_cur_state(), if current_state is
not equal to state and both current_state and state are greater than
0(scene 4 as follows), then maybe it should stop->start or restart
idle_inject.

The scenes changed is as follows,

scene    current_state    state    action
 1              0          >0       start
 2              0          0        do nothing
 3              >0         0        stop
 4        >0 && !=state    >0       stop->start or restart
 5        >0 && ==state    >0       do nothing

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/cpuidle_cooling.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 78e3e8238116..868919ad3dda 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -113,7 +113,7 @@ static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
 /**
  * cpuidle_cooling_set_cur_state - Set the current cooling state
  * @cdev: the thermal cooling device
- * @state: the target state
+ * @state: the target state, max value is 100
  *
  * The function checks first if we are initiating the mitigation which
  * in turn wakes up all the idle injection tasks belonging to the idle
@@ -130,6 +130,9 @@ static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	unsigned long current_state = idle_cdev->state;
 	unsigned int runtime_us, idle_duration_us;
 
+	if (state > 100 || current_state == state)
+		return 0;
+
 	idle_cdev->state = state;
 
 	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
@@ -140,8 +143,11 @@ static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	if (current_state == 0 && state > 0) {
 		idle_inject_start(ii_dev);
-	} else if (current_state > 0 && !state)  {
+	} else if (current_state > 0 && !state) {
 		idle_inject_stop(ii_dev);
+	} else {
+		idle_inject_stop(ii_dev);
+		idle_inject_start(ii_dev);
 	}
 
 	return 0;
-- 
2.17.1

