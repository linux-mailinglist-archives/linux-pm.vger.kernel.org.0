Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F91B4E0B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDVUMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUMY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 16:12:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBCC03C1A9;
        Wed, 22 Apr 2020 13:12:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so2885384ejx.5;
        Wed, 22 Apr 2020 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXxHIljFmLh8soPuXzemAjRAO1AtwvjZf5J7ToWtf8U=;
        b=u1hPBAcyimOPDcc2gD5ogfk1Ot74MUK5tYKviAVgA6IkyMxKKCCEMDVGkxkdEgfdc4
         XM6G1lMg52sPDHfSR7z23W74gApPXHMukxAYl5kis+8QHlS0x/fEsX/8t1om9BQwD0SF
         zBONh7CDl7pC0lDbGxX0+r6Mx5BRBSCcpN5t3El8CZzFJVP5/BkQwG78YlGOE1IMqwoB
         2QzLn6MIaY2guVhELsH5xU78iVVK6knNYDVrbw8Hxsa6ahrEYz4fBv+AaGtT8tCEkK/D
         oNth3+4/Wgo5jZ5hl0TYgD8WWpcfRle8/2Qo8di9i1wol8eczleLtryqxxNH68uWAmTq
         UbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXxHIljFmLh8soPuXzemAjRAO1AtwvjZf5J7ToWtf8U=;
        b=laf8d6tNL8bur27vnOipydfDLZ80L7POLYaBBM//EaxjmxAQ0Fop/zwy7i6haMF1fI
         MdorALb1SQIMTioVRav1fDOQ1wowmZcR7N7XOUjCBcp5R+UKJ0Lr8lWeBgL1JESFT2PG
         WW5l95TTaPWQ0OwW8GYZZ3ZWhpUu/AfFmN7fSCTMNTWSt5Z2Tb7bfzfaWRXQ3vKCO5cZ
         pG2aVCXjXjrdV3gtFWZCeeFjRMSPs6j5cfl4ilQtyUfHj0OW5wodLHXQ9EErILZ6W3JP
         KApIPxrAox04zqlLW8L8R3zJxDjYoJGovV2gAIc1SB5s+FaJoOMycPGYZzTuRlbBaU2h
         HK6A==
X-Gm-Message-State: AGi0PuYpPP9gnN0bI28LgbQcCsYK5ZFLAxVZ6dLbE1pLu00yZA4shlaq
        lpbM8zE+PtVQNghHDNRHB8c=
X-Google-Smtp-Source: APiQypLbfBgCcNY33E1Ne4qeN757gm6FckRRpoa0bnDaomgSbHDVMvWzDe6WgrndkPNb/HjvmjqE/w==
X-Received: by 2002:a17:907:b11:: with SMTP id h17mr55555ejl.371.1587586341762;
        Wed, 22 Apr 2020 13:12:21 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host36-18-dynamic.45-213-r.retail.telecomitalia.it. [213.45.18.36])
        by smtp.googlemail.com with ESMTPSA id q1sm8789ejf.42.2020.04.22.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:12:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] cpufreq: qcom: fix  compatibility issue with old binding
Date:   Wed, 22 Apr 2020 22:12:15 +0200
Message-Id: <20200422201216.10593-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Binding has changed from operating-points-v2-kryo-cpu to
operating-points-v2-qcom-cpu. Also check for old binding in driver
probe.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a1b8238872a2..9e9279162b5b 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -278,6 +278,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
+	if (!ret)
+		ret = of_device_is_compatible(np,
+					      "operating-points-v2-kryo-cpu");
+
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.25.1

