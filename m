Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8822A31E3B8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhBRA6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBRA5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CADC06178C;
        Wed, 17 Feb 2021 16:56:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n8so749556wrm.10;
        Wed, 17 Feb 2021 16:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHRJlALi5wYTQnSI8D1LxIgwR3eng98eks4fOrui7gk=;
        b=Od7TlNhLfs/vBierzla2paFgRpv+Cy5jP5ZLyeVpY9thbrnMlJ7k+aPT3IPoMa+TBv
         Zp0f+Frq7JSVymWgXkhwDqhhfjcBa3rnBXk1aZWqxlVZsrc1xjosGFAwD0TTNo/m1eja
         M5cby/7OioDspa35YB7YwNRWGbSBH4x9bmJOpfG58ApQFku0bX26TfxO9uefPuykpN71
         iSIYWLz9pQEguIXEQ2HZmver4jbEv2OvaLgfzgHMhgfoetga3EHkURRhvXvyB2jNwOxC
         /LltgT4XZrwDTzm+QzoIHG5+8XG8NX9Q9oJakaJlBQhGOES/qDVaXilUpBBVI/OTmH4K
         +mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHRJlALi5wYTQnSI8D1LxIgwR3eng98eks4fOrui7gk=;
        b=rmsazZBGsi5fHY7/bzLVGVK56DfcRLX59vfnZUbYRr8+sypgQsjOQ1NBrcLfSnHZFh
         ZldnN/H560v/GKNALliCo66r9Lse9ZreSQMzE5mPPw90QVnSwcqDwq8hHRrBGBnE5rrU
         Ybe5iNLdFYaXsUJV4+/yz1K2Q33WbPKH6MrIoAetVHTCN6XJ8Jh26OeK6xQa6BCASGZZ
         pZAmrR6XedohCiSQbiQ82/vVEe0pEXDaDtLKwD3cOjUKz53v8JQlLMKre/+gfa5Ou8b8
         AABvLhjyqE5R3AyoeI7RJYYVNyYU0sG5ZVoBdyXi/9O5blFUVdEJiZVnKfKFvZHRgKSH
         rr2g==
X-Gm-Message-State: AOAM531MExc+p4GqcFdmtZaoMHv5+sCSneeSNt4+LzhcfBnPsu+M1yUG
        +yfXqcp3dkBoQYa14eLu8sc=
X-Google-Smtp-Source: ABdhPJzejBPgVdo2ZcZm4waTSvAokagkr6yomkp9lqNVYy96a5q08z8oB2em3qahkrIyPySJ8tJtMA==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr1664051wrd.119.1613609792455;
        Wed, 17 Feb 2021 16:56:32 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:32 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 7/8] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Wed, 17 Feb 2021 20:40:09 +0100
Message-Id: <20210217194011.22649-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 842f518fdf84..e14b90ddd0f9 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1001,6 +1001,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.30.0

