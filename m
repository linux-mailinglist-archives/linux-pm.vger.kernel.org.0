Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86E1779FD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgCCPIF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:08:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36136 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgCCPIE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:08:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id s1so3065156lfd.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oH2DPw9yOnkNvy1Ktf77A4iViJfMOE/P09y2cJqfUP0=;
        b=mPul6xhaNAuxo8T2+NE+xGn8787mHR5kxItdLJQJgLjWA7RHBJv120FuQ0vlz6JeMi
         L86z/EMCuNHoLke+7BgdQPJLpMsDrJY4PNNIR4KHK/5id2D6YAD4T+9SbyZ/nEvaDU+3
         epDaF59obqiYBlfBmYhFIi5QVk/ZNTprB/WeyY83K/5ILFe5xaQ2Vj9aVWajv4R+iESZ
         JeO21O78P8bErOdDEp5lNIkLGaGrtMc/pQ4/tusG+B/6aOnA0XkiAi90SxaWaztVSOHj
         1sBD75JH05+mvHNLxdeTL1b7Th5uQowbmcuJJDknrkNnHyWmwp8THQeBzYamGO3C+TyE
         o/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oH2DPw9yOnkNvy1Ktf77A4iViJfMOE/P09y2cJqfUP0=;
        b=aPx3TWpBtpOkst85OsWeG4rjesRAtIZkZ/9PMObiAVLN3dOJqj9L827vZfInQjqjm3
         DcYXxl+j2Q7JB7mj5ktG2dh/B+xPClv+9e/bKl8lASQM0EenxpoPgU2zYKOZ8HSephwR
         2lHe0FgXCrLEUyr9huJdbz48GBFa+wTEqtQ6+dGRrit+VcgXlqeBhW2zyG/8WLL3D8JP
         fN3xVdQ9StaWGLvALIGidQWmNVw+PHdJXYQh1yvWpVVxxIo2K7TVYEeIrvoDlTp7QYMQ
         kg2Hppd51IewRAMSadXBhTdoJG9BY7CUvxIWsoubp20sMi6UvULkPt+3acCM3eMltaPz
         zrxw==
X-Gm-Message-State: ANhLgQ051tmtjERWvsFA1IXuFGnWZc8Sss+995dGXGCSUOXFgGtL4vJe
        BtgKeNybcREQkhWqofM67dwAgw==
X-Google-Smtp-Source: ADFU+vvodELrLn3K9Dksie5B3U4dnmjJWJrhxSD42Lo+ggn0ROi0yWlkIY+w/726ufnV7RZRHghSUw==
X-Received: by 2002:ac2:5ca5:: with SMTP id e5mr2984605lfq.122.1583248082142;
        Tue, 03 Mar 2020 07:08:02 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:08:01 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: power: Extend nodename pattern for power-domain providers
Date:   Tue,  3 Mar 2020 16:07:46 +0100
Message-Id: <20200303150749.30566-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150749.30566-1-ulf.hansson@linaro.org>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The existing binding requires the nodename to have a '@', which is a bit
limiting for the wider use case. Therefore, let's extend the pattern to
allow either '@' or '-'.

Additionally, let's update one of the examples to show how the updated
pattern could be used.

Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/power/power-domain.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 207e63ae10f9..dc232759013e 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -25,7 +25,7 @@ description: |+
 
 properties:
   $nodename:
-    pattern: "^(power-controller|power-domain)(@.*)?$"
+    pattern: "^(power-controller|power-domain)([@-].*)?$"
 
   domain-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -71,13 +71,13 @@ required:
 
 examples:
   - |
-    power: power-controller@12340000 {
-        compatible = "foo,power-controller";
+    power: power-domain-foo {
+        compatible = "foo,power-domain";
         reg = <0x12340000 0x1000>;
         #power-domain-cells = <1>;
     };
 
-    // The node above defines a power controller that is a PM domain provider and
+    // The node above defines a power domain that is a PM domain provider and
     // expects one cell as its phandle argument.
 
   - |
-- 
2.20.1

