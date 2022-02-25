Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA84C3CC4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 04:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiBYDzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 22:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBYDzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 22:55:39 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E663E3388
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 19:55:08 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so2810517otn.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 19:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T81mSR+1Zj6dq+bi59Tjjq785xia/vTXg7pvxWMZP5Q=;
        b=o16kuWGDe1xIM6p5Qh4ZTO0litiSY/rbImF0+oFdMVX2+yt9qmuK9zz0xXULvLnsKu
         uptVQyLcN7CsYjkhMJbTHp3tYAjsBAGgRlZZK5MgwDj0sL15yRTzpXzL7xwTuZ83rj2K
         4WGob+PVQsLpPRsz4hIyu0qj8R3vsghgczYgxVJ0JVsQMnN5boCGKwvGOBiEip+pbKJK
         Z9lFo+nzSrgq5cfV5NRUiK5dwiW4bzbY2YGpS+4jZJPs5PKaj11kQN15EdZP/GIsmR6X
         74JnHDIzTmj4C+RHUWjPcr2mqLJKKzR4C2ZKol5FhjC7jpjnJSX2gbpIzSoXC1cGXOvm
         VV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T81mSR+1Zj6dq+bi59Tjjq785xia/vTXg7pvxWMZP5Q=;
        b=exV2ymFlZQiFbJjwerC15yYkKwKp0tWIfHqz3Vc+zIXGEw+pK6ZlbSVm/3wjK1+ioV
         496dERo6EONLEhv9VL+tfTaXcqFgEx83v2+bREpSYvxjwVODpqqulGsqS8V0b0kq38ma
         EY4u2agoRXJA4WxHhlnPCWnoxVmO6QD3p8RyxOOvfKBHietqOc0AjbO0ynH3ychZmQ1A
         KvmskvnI1tiWUjHO38t/dA7NLhQDa/BWtLWriszgmJCH1W48nH9+N99ajHgZolnNLKhm
         Jx3rJFB4SgCeiqsufSGqAjapIkIPBL58Iw8tlJN0rl0IbGFZdfAA9yvCFenyUHnxzxmn
         1URw==
X-Gm-Message-State: AOAM533FnbeUsefm85NxcFeQoaaL89/avZNEvPdayTzZGfJYIs2rx+iH
        SnRQ6wHopl6sWgxI6NaRGdmj3g==
X-Google-Smtp-Source: ABdhPJwjiRwYy0dfCxWbhMkzKq6Ypu051JtDF3urnqLidlyDli33zRyaG/hBtJccsM7+t70CD5R+XA==
X-Received: by 2002:a05:6830:154b:b0:5ad:3e5b:4356 with SMTP id l11-20020a056830154b00b005ad3e5b4356mr2071041otp.176.1645761307715;
        Thu, 24 Feb 2022 19:55:07 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d57c6000000b005ad5a1edd4csm595170oti.22.2022.02.24.19.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 19:55:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] cpufreq: blocklist Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev
Date:   Thu, 24 Feb 2022 19:57:06 -0800
Message-Id: <20220225035706.2294842-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm sc8280xp and sa8540p platforms also uses the
qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
blocklist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 6b808f805eab..96de1536e1cb 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -139,9 +139,11 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sa8155p" },
+	{ .compatible = "qcom,sa8540p" },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
+	{ .compatible = "qcom,sc8280xp", },
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm8150", },
-- 
2.33.1

