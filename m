Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C1443179
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhKBPY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhKBPY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 11:24:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B14C061714;
        Tue,  2 Nov 2021 08:22:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p16so43716325lfa.2;
        Tue, 02 Nov 2021 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRWxCmCFDqIDU/+vKEVCg40RJnSVkH+e7mS2lPOP/bk=;
        b=fgWUWLBDBQzniNNEiyRdZvCnr4uRGHfviNJ3+2wnyobh6kSOAiuVhYKHF9/2qXQCzP
         7ymx2kxOU+SgN+K3ZFlWWqk4WlCotSyY66Ytf/EBFwwfwGxIBV4A1osfZpmis7dhYu0Y
         g0bDGLMdFAT0jYixkeTaq8EmLrXPVlzfo6h/zzXXzLBgx3DDZz4CcGZB+NGFlKonU960
         U2gZC/cnNw8N8ScqxsjYbLjxYY1f3c4rGoc7jL40lqXUpUnKU8yJBnX+oMd8qnfYH6VP
         9zVNc6fhEM4Sk9fst2yyDbuJZUl6p0p3uZyni4cSN6bHigrmG/Qz65SEfm22MwJJWSod
         M1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRWxCmCFDqIDU/+vKEVCg40RJnSVkH+e7mS2lPOP/bk=;
        b=I9kfFgAE84Vy9kC5vybtE8QM9xOJEJMG8d/8cL7fTbWXbMxb1W/qqEmZO6TcQajJiH
         WNAPTs0Sqi0bEWp5viIAzumRGU0YIsYehEwg+Sfi9572XAPSxFnHWZqDRqByAzKwClVM
         s5yKu3ZDaKsfNYwcImyC+w5LxQHjIRHtPTbL7/z2sWaLAf9WmGcr0Bw5r1SReJQ2A1XN
         vXSaW1A24+8JsYjTorzKTzgtpbKzaok7suSBM4KKpy9Qud0vHBFXV5tQ/jbnstrJZwQF
         vliv2aXL4J9JDZwcKMP84kf20QqcXCivYnv5WKjr54vUrGPbRbU9sBo95g+PedBN4BO8
         DYCQ==
X-Gm-Message-State: AOAM531OlyeB+FheN1lG6HwKhpmS6QIgpEnoJmU1HHqo45daWSU5HJv/
        F6RcbQZCA5HV3yMntwKMwHY=
X-Google-Smtp-Source: ABdhPJxcoUG/2HtmFlZpzLf6dL4GqVJEo16yhgjX5bBUu9gkSTJ+URRHbWo/sDJwSqlmJRE6TmgPXw==
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr34927392lfu.524.1635866540364;
        Tue, 02 Nov 2021 08:22:20 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm250952lfr.151.2021.11.02.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:22:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC 1/3] dt-bindings: power: reset: syscon-reboot: use non-deprecated example
Date:   Tue,  2 Nov 2021 16:22:05 +0100
Message-Id: <20211102152207.11891-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102152207.11891-1-zajec5@gmail.com>
References: <20211102152207.11891-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Usage of "regmap" property has been deprecated by the commit
2140d68d69d4 ("dt-bindings: power: reset: Unrequire regmap property in
syscon-reboot node"). Rewrite example to help people using
non-deprecated binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/power/reset/syscon-reboot.yaml        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index da2509724812..ebae55683d39 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -59,9 +59,13 @@ allOf:
 
 examples:
   - |
-    reboot {
-        compatible = "syscon-reboot";
-        regmap = <&regmapnode>;
-        offset = <0x0>;
-        mask = <0x1>;
+    system-controller@12020000 {
+        compatible = "hisilicon,hi3519-sysctrl", "syscon";
+        reg = <0x12020000 0x1000>;
+
+        reboot {
+            compatible = "syscon-reboot";
+            offset = <0x4>;
+            mask = <0xdeadbeef>;
+        };
     };
-- 
2.31.1

