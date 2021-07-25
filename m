Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB53D4B19
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jul 2021 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGYCXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jul 2021 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGYCXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jul 2021 22:23:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3DC06175F
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a19so6772174oiw.6
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i41MjxNBGnyelNR6Z6r7QRVZ7cIT7dJr7P2wEnNvkN4=;
        b=xUiQueEb0Mm6puORxMN7ixcknmUUW7+ty+PZyzjcQPvpupXPffuQt4ijgFFkrC6QSU
         CCjoELE1Z8Dt7Dg4wncEY04J0XdCaIP3u3QULzICX/fphldn+YvY3I6n1ZqbSg13dMe6
         8msM6VYTW4ammgtJ/Xdrv7E9Zl+Oz+KDtkLPgJEbUlWUcagKP56aoQ6p6bksHvPhUROj
         3QMOtYVKQRnYGLFRPyg5ClvHHbxHrxO829i7B7r2IqoYsPYiI8HRMgUDXaIvbpSFhGpA
         Ya1nyfigcwJtWKnMZPT0MuQeblptluXHEEfh1joHXjyFK4klMbV/bbYksPf2zK0lSrUv
         MN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i41MjxNBGnyelNR6Z6r7QRVZ7cIT7dJr7P2wEnNvkN4=;
        b=lcgFZlupFojWfDzn9HDLfAbov9enYz9P5qY4sph9zquUbY1ZDe9N9nW7r8C4RpbvCK
         ijLzOV999rvLjPbKgsMyUpsjVKsDDbpJ9Z/lzSlor2bTayACbmL0JHaNwvO5dydmPKiZ
         M781C/rQYf8vD9wvyrlWGjSO0v4bLVKN55tTlFsHlrO/Fuwp0BF/2AFTKetyEfuyd2I2
         nIble5EnWyAIu5xELJWHI4AE5tikjl/JiW7WTqCtHtZs17Wh2zYEsw7LfaNScFRss0u6
         Gl2yS3+Givu2NzemjCBxySDTn5iQ3uyS8gTZviOO0FMeAYOrKSy4AmeJO3427ifLQjgg
         umlA==
X-Gm-Message-State: AOAM532N9YrlEHpEPuR1v1HDnDHsJ0awO5nagVhaNrQNJhct1BgtZ0ns
        yc2wmcE93qTkwlxWUE9k+ZhqTw==
X-Google-Smtp-Source: ABdhPJx8yltFDhA0miTyRRKekdr4v45UgoxLBmNRVd7x4VzkGSI+Z0nicX86cSIo7Ajo+Tn+k+xcnQ==
X-Received: by 2002:aca:5c0a:: with SMTP id q10mr5076341oib.11.1627182241092;
        Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w35sm3389048ott.80.2021.07.24.20.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:04:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev
Date:   Sat, 24 Jul 2021 20:02:14 -0700
Message-Id: <20210725030214.3942250-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SC8180x platform uses the qcom-cpufreq-hw driver, so
it in the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bef7528aecd3..9d5a38a91f10 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -139,6 +139,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
+	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
 
 	{ .compatible = "st,stih407", },
-- 
2.29.2

