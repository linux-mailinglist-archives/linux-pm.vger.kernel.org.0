Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEF1779F4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgCCPH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:07:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42353 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgCCPH7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:07:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id t21so1998894lfe.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9Z9RNVVgVoDIqftNG2lvo/XggBGLbBYVP8IgzDMszc=;
        b=BSPGSq+HX2g9M4ZlxaDoemDr8Dz6O+eSQs7Uf1rceEG2bgyvCwbjnVMj4gIZxtkyf2
         Rj0QvE2AGrJz81Nd00mPtfww6yy1l3TXEHbUNwhc5Ui65lz1pGmM3BFAnb/DWXv3fZqD
         TMq0+rA0l/NXxviYxxVo8wGV585FrX0PQWFhAUh4W/kelp4v7YFvcElzWVGq/+rz7KQc
         nHN8hIg2v8t+gRBMErWzfsp9cCrKGtxGhpCeX0d1rYPFJ3H9mQbXdzpsdAWqNK2VDdex
         QPvjOXGLbxOEa0xITt05GwPXoWWMWkWoMQX4U/cQXOLb5t6z7+RIOJpA4o43MFsp9nm0
         OBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9Z9RNVVgVoDIqftNG2lvo/XggBGLbBYVP8IgzDMszc=;
        b=DcccucR0MRdgynca2QE++J7rEhvrqdth9KmkECvDzHs9mGM+GFYeTw8avlu2SWyCho
         XR8UuNlOuUeN5A2ORLDMwsXXK+LDey6KUt40WwjIgi2EzzkD2X9KoeELZtMxW0HBPVtj
         EcoardQty+UxR1K9ihI5i7i+tj31N9KWzd8duuerESmsFLAbx8odTXLuYuu7jHmekefA
         SPgIuJCDelQjaGTeyX1iDmDgxJZu6wSPTtG9w+MG+JJVuKGfg8cCmXmYKWLhb4UKGakn
         4ffihnTIooBeQx9VhHw41sLuDgWs+W0Zzj3mn3ze3xx4FsSIp+uDoxdPaBQJWNjPel7v
         IR9g==
X-Gm-Message-State: ANhLgQ0uQysVJJcEdwCL6mxWvgunH90RuipEDKenCx1u4bQCTP0QprK9
        Hs2BQBFB4BakG58tgEdSa5SKSQ==
X-Google-Smtp-Source: ADFU+vuSEKODHBkzB2d1lf+KfhiTMnwxEHTiiFLZyi65LbNLma9/oxtjmtdonRIpOtHBUTQL8dBbEg==
X-Received: by 2002:ac2:5328:: with SMTP id f8mr3028680lfh.47.1583248077205;
        Tue, 03 Mar 2020 07:07:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:07:56 -0800 (PST)
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
Subject: [PATCH 1/7] dt-bindings: arm: Correct links to idle states definitions
Date:   Tue,  3 Mar 2020 16:07:43 +0100
Message-Id: <20200303150749.30566-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150749.30566-1-ulf.hansson@linaro.org>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The arm,idle-state DT bindings recently got converted to the json-schema,
but some links are still pointing to the old, non-existing, txt file. Let's
update the links to fix this.

Fixes: baac82fe06db ("dt-bindings: arm: Convert arm,idle-state binding to DT schema")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml               | 2 +-
 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt | 2 +-
 Documentation/devicetree/bindings/arm/psci.yaml               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f61a5a13fb42..31b391a24b70 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -226,7 +226,7 @@ properties:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
     description: |
       List of phandles to idle state nodes supported
-      by this cpu (see ./idle-states.txt).
+      by this cpu (see ./idle-states.yaml).
 
   capacity-dmips-mhz:
     $ref: '/schemas/types.yaml#/definitions/uint32'
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
index 06df04cc827a..6ce0b212ec6d 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -81,4 +81,4 @@ Example:
 		};
 	};
 
-[1]. Documentation/devicetree/bindings/arm/idle-states.txt
+[1]. Documentation/devicetree/bindings/arm/idle-states.yaml
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 8ef85420b2ab..f8218e60e3e2 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -100,7 +100,7 @@ properties:
       bindings in [1]) must specify this property.
 
       [1] Kernel documentation - ARM idle states bindings
-        Documentation/devicetree/bindings/arm/idle-states.txt
+        Documentation/devicetree/bindings/arm/idle-states.yaml
 
   "#power-domain-cells":
     description:
-- 
2.20.1

