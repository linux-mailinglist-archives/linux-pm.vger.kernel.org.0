Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1400C1779F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgCCPIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:08:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40274 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgCCPIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:08:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id p5so3040395lfc.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B30v3NBJ89pTZvCRAyGguiMnt+PH3RI+BA4eDrldRLY=;
        b=k/Z9gXXqNlqfswOQwls9gp/b1woar1i2f5V8G/kc56ZdmRjSnj8PGdrlMoAhZe/J5Y
         K3fnFzs2hsZawrNoqYblo5+8ztsKhuNfmaaKe6W30Yncrf1lUS1bi/qcTsTX+uQTxnZf
         GBWAQSh35JRJkc3KU8ZbmX420ykXl8bYoMw4i9nc0egLBhA/s25pvvJQUb0KcUGUuklf
         uw5itk1tZg8MnPhLaM153kWr6hd9P2c1H7Gbpe+/JRrvEeP3P/kX3HD6eg89gpryUjp7
         pabbouy0baZYlRoExtpecn9l0khYWrqTkAMHIGsEMDkKI9lrpD/5duiHzSScjUnRrWXc
         bUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B30v3NBJ89pTZvCRAyGguiMnt+PH3RI+BA4eDrldRLY=;
        b=Uo5UkFXmPpnr5ic34p5RnVjLyz71b6E/ZMMyGktJuOzJpS8OM28Vc4J8lABbZmslpt
         dfupW1C9tifOP5Pp52gt36YBnXcLtSRZEmpCSjlJZg7+peQeamJxCc4+dO+zbFlOz4k0
         dYwDYt3ybMFcxH1HXgAna+xKfeNR/41WRTPLPWwhb+ni7HACMaZC5OjuYWim+3+kfmqH
         wu9JeoYXFGsvtcTAKwVv1c31yJxCqqx3SG0UCiimXnDifbmmRhm+U9xTDi99PSXz1tHQ
         6UuRqyTjrLK8Ux2P2VPM64YxMC843pGCi9yusrxyMoljK0uelXoEP3GMdzaJtjjXasVi
         577g==
X-Gm-Message-State: ANhLgQ1hzhCnAmZCjnD8bgZYyKkGAfT2aCE1W1nXTyHL3cqeGTaXCRIt
        rpZJA2qRd3QflTb7CQ/Ycbu/vw==
X-Google-Smtp-Source: ADFU+vsNa2Cmu28UnbH+m7iPEgdhqmX6OprzfWRZhA31z6e3MSYvdgClxx8aL3JsLOL6vHbmRtGbDg==
X-Received: by 2002:a05:6512:304c:: with SMTP id b12mr2036672lfb.196.1583248079201;
        Tue, 03 Mar 2020 07:07:59 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:07:58 -0800 (PST)
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
Subject: [PATCH 2/7] dt-bindings: arm: Fix cpu compatibles in the hierarchical example for PSCI
Date:   Tue,  3 Mar 2020 16:07:44 +0100
Message-Id: <20200303150749.30566-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150749.30566-1-ulf.hansson@linaro.org>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index f8218e60e3e2..540211a080d4 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -199,7 +199,7 @@ examples:
 
       CPU0: cpu@0 {
         device_type = "cpu";
-        compatible = "arm,cortex-a53", "arm,armv8";
+        compatible = "arm,cortex-a53";
         reg = <0x0>;
         enable-method = "psci";
         power-domains = <&CPU_PD0>;
@@ -208,7 +208,7 @@ examples:
 
       CPU1: cpu@1 {
         device_type = "cpu";
-        compatible = "arm,cortex-a57", "arm,armv8";
+        compatible = "arm,cortex-a53";
         reg = <0x100>;
         enable-method = "psci";
         power-domains = <&CPU_PD1>;
-- 
2.20.1

