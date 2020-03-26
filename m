Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC6193D5E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgCZK4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 06:56:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44651 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgCZK4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 06:56:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so5853385lji.11
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuuxQjjiHA1MwNowGgc6IZfr8zLQ9maUJaFARjpxln4=;
        b=hV+MlhyXKY0QLDls81FMrAiwg7WjsXZvFNFQpl2GZ/rfzLdj3av/7+1J0ptLNp+gzl
         QbmKraoSSQviudWxJnYf0uzene7qz/a1lthvBy9lXmwaFz8FGa0P63JCqCUgMPg8TOvw
         sie5B0tgIFW8DTK6G2OSw9IULaAYxRDsqQau3ubnC1FLHieQEEsTQtpeBPvkA10fE1A1
         tNICUqoXP4fOY1uGOw2Nf2rscKjTfD0CEkyNQZrAiCOQUOtOKWd/Zu8Xk/JLwZbdXrDU
         voFxWswR7S7twoZlfFLmDIzPJnPoGOCcEScswPEsOoF3SSexlMpcx2Zq96b5SBtiCJOb
         wnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuuxQjjiHA1MwNowGgc6IZfr8zLQ9maUJaFARjpxln4=;
        b=RVOfh94+3seZK6OSfc6k7bMKKN0KmcduN60E9FaYyxIha7KLNvQuqn+5Mzkdz5tktA
         foiHyrg0hvFkeiszqbPiN6J46xQX6pR/9XXN5NkO2Ji5jzOicBXik1GFkfSj2PYSV6cu
         P64LwCBxVbHqUZwNS3VoNvf4S40V2GxT0HQPuWJuYd5dLD2ZEaS+TGujHWpbZUBR2oG1
         eeuRJiio+rps4aO0R5Lv+4vgswo3yZj40jEEbRbHUd0y3Ke1bfHuG7e7KPwxfgW5Ri+s
         2BPdKM81SGGA+4ehSmv+ExsXoV5L6PQND/jxUxi6FNig+2m/d7yqAGC0/laWbSINm9Pe
         kzQA==
X-Gm-Message-State: ANhLgQ2X5j2Fd5j7KzEFWwJQ00HNUp6r8jMOtONbXl/nRULrugXuoYGN
        tnZxHei7I0Vd6VcsFNuvycK7OA==
X-Google-Smtp-Source: APiQypIh0oKPTy0rPtj3JtcsUXTdtYTXgTC+JrTuULTRNCFGhf6dAq2avCL1mE/6d8eDRPImbNdr2A==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr4933294ljg.101.1585220196103;
        Thu, 26 Mar 2020 03:56:36 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z17sm1214653ljm.19.2020.03.26.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:56:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: Add some constraints for PSCI nodes
Date:   Thu, 26 Mar 2020 11:56:25 +0100
Message-Id: <20200326105626.6369-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326105626.6369-1-ulf.hansson@linaro.org>
References: <20200326105626.6369-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There's no point allowing anything else but "psci" for the corresponding
nodename of the PSCI node, so let's make this an explicit requirement.

Moreover, let's also prevent additional properties, which also allows a
better verification of the "patternProperties" bindings for subnodes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 5e66934455bb..9247b58c26fc 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -32,6 +32,9 @@ description: |+
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
 
 properties:
+  $nodename:
+    const: psci
+
   compatible:
     oneOf:
       - description:
@@ -141,6 +144,8 @@ allOf:
         - cpu_off
         - cpu_on
 
+additionalProperties: false
+
 examples:
   - |+
 
-- 
2.20.1

