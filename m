Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106AC193D60
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 11:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgCZK4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 06:56:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36173 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZK4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 06:56:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so5908918ljj.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zynm4D4OhVzqu5xzlg0LOQ/tgbbw9PIYyorUbwLadTE=;
        b=I14sWrr1bBJtFvP4lIZjyDGCEseVkJH/gEWVc8y7qx0eryItq/r1uhn+cbfmhvtpUr
         HdWyQQO7UZVcpRWTpUOOk1lM1NeZo0sFP6VTJkkk0NDP+7UbV6PbKSoNdtcZvZ2ALwaL
         4rqUnZxXUa2Jn1vLJ6/eomFnizUpThfEDhyrILxDJWfBw74jrO23CMOk0EYEh5mxYwOr
         /vfLsBwYaopOhEuBj9CRzp3zzPpVNyXPVRmXWK9QZVSGup3DSBODGsETnYaP0knbSUh3
         Eq3I1bxdwj7bycZOwd+Vkiakl1/x8reyl9XUc2YqEGlNvs+TRrXA2/9rG8aKIsGHgoC5
         BcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zynm4D4OhVzqu5xzlg0LOQ/tgbbw9PIYyorUbwLadTE=;
        b=e4F20soeGFi9j4Rf5dQsXVFeybESCAGXPrOGrs3kbldRIwT7TH3FgH8EQUal6x+ikP
         3AuKL1EMckZSLpPP+iKpcm94NaIpW3IjbBxuzEuh77/gfeWVF9MPB6SoXluGL2zcb9aO
         oLvIBrJ/6+27nRSK7AfhmEg7dA9txbXwZhYzvJ9+HmJ+nMjY0WeAU6myUk2kOMnyignP
         GHOU/OCgpvkvPa7jqzt5qV5b+po6g2ly9oWPZKhEYsl5Oqt6jXHnD2L7DI7G+qIoj82d
         jnunQ0GR0345rEn8Tay55WIcTK/BArwsP5dYW6U7sb6kpQ88Eu8RWPtu7iiaiV+dkYfg
         c/LQ==
X-Gm-Message-State: ANhLgQ3zjQpTTMLwznCAsJwUGNQqYqCJ1iwS3R0lpLdOXAV4GiL3BSoG
        AjP4RIjzTum8tPekmcWV39ViTQ==
X-Google-Smtp-Source: ADFU+vt/lXP4078IY8NgCcD2BqnTqfFJuO8JESvRGr9AomT5a/4ZEG2Qu0qn9it+6RpSJatr7K9XbQ==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr4792582ljy.23.1585220197358;
        Thu, 26 Mar 2020 03:56:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z17sm1214653ljm.19.2020.03.26.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:56:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: power: Fix example for power-domain
Date:   Thu, 26 Mar 2020 11:56:26 +0100
Message-Id: <20200326105626.6369-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326105626.6369-1-ulf.hansson@linaro.org>
References: <20200326105626.6369-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The change that converted the domain-idle-states DT bindings to the
json-schema, forgot to update the corresponding example for the
power-domain binding. Let's fix it.

Fixes: 3261227d136d ("dt-bindings: power: Convert domain-idle-states bindings to json-schema")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../bindings/power/power-domain.yaml          | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 6047aacd7766..ff5936e4a215 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -114,18 +114,18 @@ examples:
         domain-idle-states = <&DOMAIN_PWR_DN>;
     };
 
-    DOMAIN_RET: state@0 {
-        compatible = "domain-idle-state";
-        reg = <0x0 0x0>;
-        entry-latency-us = <1000>;
-        exit-latency-us = <2000>;
-        min-residency-us = <10000>;
-    };
-
-    DOMAIN_PWR_DN: state@1 {
-        compatible = "domain-idle-state";
-        reg = <0x1 0x0>;
-        entry-latency-us = <5000>;
-        exit-latency-us = <8000>;
-        min-residency-us = <7000>;
+    domain-idle-states {
+        DOMAIN_RET: domain-retention {
+            compatible = "domain-idle-state";
+            entry-latency-us = <1000>;
+            exit-latency-us = <2000>;
+            min-residency-us = <10000>;
+        };
+
+        DOMAIN_PWR_DN: domain-pwr-dn {
+            compatible = "domain-idle-state";
+            entry-latency-us = <5000>;
+            exit-latency-us = <8000>;
+            min-residency-us = <7000>;
+        };
     };
-- 
2.20.1

