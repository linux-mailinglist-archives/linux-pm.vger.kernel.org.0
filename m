Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA444317B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhKBPY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhKBPY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 11:24:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA373C061714;
        Tue,  2 Nov 2021 08:22:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq11so43668246lfb.10;
        Tue, 02 Nov 2021 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YHGtBoC/Q+g9ByAL6ZbJf5/4fBkm5FjpScxQdxcQMM=;
        b=R++1nrZ4CaOf6LVPE0lbPrJI3kBbl3CbDATa5TTus2fbNw3Usfzsg89rWvl06vyZos
         FcIcgyddbbPXHp2AFzeiosRzVHcYizyesoCIPgKPjFGIK68riQCMlx9SpDLzyoJbcU2b
         RRFZWb07QGnYJrV3isc0u79tzUrYhyZyQebmrFcyKJrk2t1+9zAQAqkN3EswkjH1pBHA
         +OOaSl023Ey1jnlhi3uRLc45FS5MgthjpdIMXC1Pp9qIWiJb5CObh4Srro19y94U+cSH
         Y29TB9fPe7b764FAAlG8OLfUbw+xuZ7Lawdt1QX1CBUhcsv+jEbXVo/3dyUvd7CjNrMi
         ua5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YHGtBoC/Q+g9ByAL6ZbJf5/4fBkm5FjpScxQdxcQMM=;
        b=A7bCeIUBreAiSnjt9SB0e1XvHExPMuf8b5y4bZcFdw04qdVzn4sUYqw0apGV0IIX4R
         RrJs5Cz4aqbSja1SYeTasaPH4qC3+sZIV3OxuJ1GgK+a8f4eZRsNXzTqQyLVE0h10JbK
         RmZ1m1lur/FoHqyDN4Fvl3Xrw1MiRGZFphz7kX4u5ptxzz2F5tLGTFSePpybUPyGzngd
         5lwZit0thQTyycZBJZKxoMehhLHn7dlQdWBnY0rhctuVcBNKl3nZZpBO8kgKNKs25MEG
         y0xdei0+bSZXD+XI8aCEdwkkLXiGoJjXVABQ+Ca4cFs7dm+5JGzB/yZ/SeJmRGNuw5T4
         fAvw==
X-Gm-Message-State: AOAM530PZRRUChaEBtPVLwIfi6vsM0hZkVkq6wOlIKAMeANHPlndEuAo
        eBfCuw1+t2PPVRNQ3yDVQV4=
X-Google-Smtp-Source: ABdhPJzBRFPfCAKBDUfg9MFyHjw/HoxlmxsNBG+88qqkYpOAckcI+ET3dyap/DWMWfyKFeXtgsN2VQ==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr34771538lfd.645.1635866542219;
        Tue, 02 Nov 2021 08:22:22 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm250952lfr.151.2021.11.02.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:22:21 -0700 (PDT)
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
Subject: [PATCH RFC 2/3] dt-bindings: power: reset: syscon-reboot: add "reg" property
Date:   Tue,  2 Nov 2021 16:22:06 +0100
Message-Id: <20211102152207.11891-3-zajec5@gmail.com>
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

Reboot node should be a child of mfd/syscon node and should use "reg"
property to specify regmap offset.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/power/reset/syscon-reboot.yaml        | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index ebae55683d39..ddcf6e5dcdfa 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -31,6 +31,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Offset in the register map for the reboot register (in bytes).
 
+  reg:
+    maxItems: 1
+    description: Offset in the register map and size (must be 4 B)
+
   regmap:
     $ref: /schemas/types.yaml#/definitions/phandle
     deprecated: true
@@ -42,12 +46,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The reset value written to the reboot register (32 bit access).
 
-required:
-  - compatible
-  - offset
-
 additionalProperties: false
 
+anyOf:
+  - required:
+      - reg
+  - required:
+      - offset
+
 allOf:
   - if:
       not:
-- 
2.31.1

