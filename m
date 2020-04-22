Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04751B4E0D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgDVUM1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUM1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 16:12:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B909C03C1A9;
        Wed, 22 Apr 2020 13:12:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p16so2525125edm.10;
        Wed, 22 Apr 2020 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zad4RF+05Jwm8qNSsZR+cshHP+59d5C+IsAi9ivYdg=;
        b=YHrSmiNbUSrudYTj8V0jg6aMALMslByD6eV6qHd4bG1jS3BRn2Zuu/3f5RRKT3tUVQ
         P2iBdhGVH7X8QeNZ38IjkPRFTJHHngloK7n5kznqDHhWp/nhR35rtEjKAWWIm3n2D0ay
         Khnu6t6Uh45kTuOG4/4GyeG0t5+lwx+amL2Cp9bJm5yFWY3NckhkyWvtsdWaucnWOmSB
         /Pm/WXmEVxFgg8++m9R0sUnebDTs8UHFYe5Cj4rBY5ndpEVuZ2sdHcHkJbdqBaVU5e6N
         yVCPSemRTb0aN2qdI1AGT4Kne5IP9Y94zs3+pjkPS4vEm6dv/wMD9KCSIRp6nVTc7Xzp
         0Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zad4RF+05Jwm8qNSsZR+cshHP+59d5C+IsAi9ivYdg=;
        b=uR0tbJqqaMk9rY5NRiYRHZ9+GwisPKgFR+twuHlmkOqUl1kJLxhJ6Opr3Epeil60f/
         nGTjBGmeDKETDqnsNfxFdlHQwfoXWLD3+9yQapM7HXXC92Tpo5fHrTqkVav/8o+7bm4l
         UKFyKWgMcqm1fpFcbznZJhmkZZEJbJAKDJSx8nt71CDW6elnCNwK99Gs9Vhe7WPqyb4v
         F/WyzSyG/i9vVcKf04fazbajLgSC8NI8dSQgwMfFVTYqT0zYspfknEb1HQpt6KupE3Fb
         guwy5N/EyFNK0n91NkvInz3qRjKkAqe/aU4yw6q2QvHRe7659SnEuHo17fSp6J6mjDUz
         4gpw==
X-Gm-Message-State: AGi0PuaMlvKA27qgB5MZn39lkEoTYmBCzcCpP4VTBxqesWnRA6BKU7Xv
        z+ChcDY0IC16ZH648eIeI3Y=
X-Google-Smtp-Source: APiQypJ3zy1QxOAJO73zSL3bxLgBBrJrU6Y7TMlbnC5fxwRxv/5wEH80ZSpMgjqfdlGKAOIyxY1DoA==
X-Received: by 2002:a50:cd4e:: with SMTP id d14mr253838edj.223.1587586344059;
        Wed, 22 Apr 2020 13:12:24 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host36-18-dynamic.45-213-r.retail.telecomitalia.it. [213.45.18.36])
        by smtp.googlemail.com with ESMTPSA id q1sm8789ejf.42.2020.04.22.13.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:12:23 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
Date:   Wed, 22 Apr 2020 22:12:16 +0200
Message-Id: <20200422201216.10593-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422201216.10593-1-ansuelsmth@gmail.com>
References: <20200422201216.10593-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update binding to new generic name "operating-points-v2-qcom-cpu"

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 64f07417ecfb..537e1774f589 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -19,7 +19,7 @@ In 'cpu' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
+	- 'operating-points-v2-qcom-cpu' for apq8096, msm8996, msm8974,
 					     apq8064, ipq8064, msm8960 and ipq8074.
 
 Optional properties:
-- 
2.25.1

