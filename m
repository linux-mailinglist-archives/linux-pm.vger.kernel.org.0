Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9ED777E07
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbjHJQVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjHJQVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 12:21:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5998926A0
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 09:21:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so1710540e87.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691684489; x=1692289289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMXj/Lnz93iB7j1x0Vu+4dg+k/e9+q1pysssgjaw9gg=;
        b=M/SCj5PmT+zmTGkZ48hQijy9DTj3iq9MLOVJLNpRGqB3+dtckAo28OEoJtcNX0iUW5
         20TKnEEB5+qPyUNbJIOzRdMuZyjigwjecrb5liGMKSRg1RKXduAxxMan7H1Qcxnh06HP
         iHlS8W34xDmtlRCh3bxmllmbOoYKzpSQv1u6LAmGjpcEhsSv+pHWGgcH2dRIyMkTB5K4
         tzg6gtoEbvWfrSllHhfvu4p00MQRLc7Yx7oS4Efm4d+gileaDYfrOMdE4kwosKT8cgL8
         Zrr9n35l6cmfDE30trgVSbdtKlt9AxrQ4wnXWIfP+rk/n5SnfYBs1JmohWWls2RCBvaW
         KgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684489; x=1692289289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMXj/Lnz93iB7j1x0Vu+4dg+k/e9+q1pysssgjaw9gg=;
        b=JoivzKBgtdgapqQ8tUfv5UwPQuaJlH+yLIi297s0heMkaEKGMjtYRGj3XqpbSsHg6T
         Cicj4nUAmUdnWtnGmmcTIGBptD1Jiawy7Zfidpdg2Nk3rzxp9yT4eW7IwUEQQSbkXMuu
         kmKMWVWEokl1HXaJfCMm0hEiU0CxdBmVvP0+hPKnldP6Sr3CV/I5AJTk1kkerwbntLg2
         54fzXQZ7LRQ7uzgMg8niYaqN/IvgHw5Ncd00vJYfVFuOfNN1Gr+9Nu6okT75ocXBdF0G
         7pRImc4xFlwlfIrxEKM47s7sWVPXquwpk4FIeZaz3aVGdtI5Dmv+skj0Pz+8PS4t02xx
         V/Qg==
X-Gm-Message-State: AOJu0Ywc4EcSArTExHOLnw5WJs179wL+4//cJr0MhddxtrJ0AXDBERjV
        LnKTnihbiXZNpausmPbLpGULww==
X-Google-Smtp-Source: AGHT+IET4CC5DBSwwWl3dFp4n4IsMMbtj9HhS141NjAKDZZAORzvOf5uNgE+U38P3d1AegVrEeYTug==
X-Received: by 2002:ac2:46ec:0:b0:4f9:5933:8eea with SMTP id q12-20020ac246ec000000b004f959338eeamr2098187lfo.3.1691684489545;
        Thu, 10 Aug 2023 09:21:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v5-20020a056512048500b004fe48d0aa4dsm340564lfq.144.2023.08.10.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:21:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Peng Fan <peng.fan@nxp.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Michael Shavit <mshavit@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: sleep: Add helpers to allow a device to remain powered-on
Date:   Thu, 10 Aug 2023 18:21:19 +0200
Message-Id: <20230810162119.152589-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some platforms a device and its corresponding PM domain, may need to
remain powered-on during system wide suspend, to support various use cases.
For example, when the console_suspend_enabled flag is unset for a serial
controller, the corresponding device may need to remain powered on. Other
use cases exists too.

In fact, we already have the mechanism in the PM core to deal with these
kind of use cases. However, the current naming of the corresponding
functions/flags clearly suggests these should be use for system wakeup.
See device_wakeup_path(), device_set_wakeup_path and
dev->power.wakeup_path.

As a way to extend the use of the existing mechanism, let's introduce two
new helpers functions, device_awake_path() and device_set_awake_path(). At
this point, let them act as wrappers of the existing functions. Ideally,
when all users have been converted to use the new helpers, we may decide to
drop the old ones and rename the flag.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_wakeup.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 77f4849e3418..6eb9adaef52b 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -194,6 +194,16 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 
 #endif /* !CONFIG_PM_SLEEP */
 
+static inline bool device_awake_path(struct device *dev)
+{
+	return device_wakeup_path(dev);
+}
+
+static inline void device_set_awake_path(struct device *dev)
+{
+	device_set_wakeup_path(dev);
+}
+
 static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
 {
 	return pm_wakeup_ws_event(ws, msec, false);
-- 
2.34.1

