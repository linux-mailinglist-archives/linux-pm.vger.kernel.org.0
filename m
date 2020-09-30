Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235427E10C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 08:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgI3G0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 02:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgI3G0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 02:26:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACDC0613D0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 23:26:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t13so386137plb.10
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mgYJJXMxx+kcf4ZUk0gqNRlrVT2JY/xh1hHfRqfpR6c=;
        b=iV9wRNOyNqLQTpCmly2y0p5KAla4essxwJFuzVjXokwsylwuKarknbAh34ukHphfOY
         D61kyLdAmE06aqn4Bj1dLlXxOSw/HOHe8UdSuypzadrznPtgrW1kDGNlc2YZzfsTWO8c
         3D5nmsrqtLGxG4budOtuiqwZW9y5WEQm0sF+x0wuxpn4mQki1ZRXA1du5N74JmchQfRB
         7A+pN6cBEI5luSOYB0mEA+VZCF/BOdSUAekw26fh6v6GC09UDPWOU9HOtSr7TQCFtCBx
         BVwm15FyByvbG/14gS611hbbG9Rpdz0FuK/1+aS4KX51j/c7buFIYGu7Gvz5BBZwwth5
         YsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mgYJJXMxx+kcf4ZUk0gqNRlrVT2JY/xh1hHfRqfpR6c=;
        b=mG2S7uiuSif9l/nsdODXOhypscN0V943GLHcD33tczRS0CNPjTEgJglHV24Hr2qZaB
         pKCy8I8P8DEo+kdO80e7ZL0RY0dm3s4zPNQChwQleOV4syzSvC4yArryKgzT2+SozydX
         GxCWzgrNkQtuSt0SYR+wh1fACgSI5lA4wOPKHXNH/pY++6Q62pduPw7QbhkDfCRcVqwx
         UpRvvRPdjQcvZzUT17nR+QJWqAZV3N9nXz1sqlQD4lEGNU4UO47BfJDBTQTYeL35+Fgb
         uAsk++Xo7Uzy9Hl3J6EFNUm6fVxRk85NI3FtiREqbS7gq653Ct7r5nQqYIrl20GC2LBA
         6SMA==
X-Gm-Message-State: AOAM533e3MJ1UDll+Qow1W7+daycR0h0hm+G4p6VovqFFaYsziL7xOWR
        yGABX1CXyCH09DdAxiE54e9hMw==
X-Google-Smtp-Source: ABdhPJwnOj3kFy4/iMi9jsDq8fZlirpwCYqqynpn+DSeeIvV6IdzYX9kphWeqn9Y4MtaumgKFHgrDA==
X-Received: by 2002:a17:902:be0f:b029:d2:83e9:5d6b with SMTP id r15-20020a170902be0fb02900d283e95d6bmr1161775pls.75.1601447202685;
        Tue, 29 Sep 2020 23:26:42 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id t5sm772462pgs.74.2020.09.29.23.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:26:42 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     nks@flawful.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 1/3] cpufreq: qcom: Add support for msm8939
Date:   Wed, 30 Sep 2020 14:26:01 +0800
Message-Id: <20200930062603.29009-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930062603.29009-1-jun.nie@linaro.org>
References: <20200930062603.29009-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add qcom-cpufreq-nvmem support for msm8939.
Also add msm8939 to cpufreq-dt-platdev blacklist to avoid
conflict.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7d01df7bfa6c..b6eeb8ef9c11 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -130,6 +130,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "nvidia,tegra210", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,msm8939", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sc7180", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index d06b37822c3d..d88060330497 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -458,6 +458,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
+	{ .compatible = "qcom,msm8939", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-- 
2.17.1

