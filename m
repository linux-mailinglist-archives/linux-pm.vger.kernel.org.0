Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB21A52FA
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDKQ52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 12:57:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDKQ52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 12:57:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id j2so5585342wrs.9;
        Sat, 11 Apr 2020 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHtQD/meuXaYe8UaCWq5ou0S7rpgnlSgQuuCrxXrgqE=;
        b=RWrw26nqS4KT9PlkFPDn2JxIpRqcyPHhXMFaV2xV/LRA5u0k8ivXmdSjtFyCEqZfs/
         w6d951CQrL1mkIvQKsxH9o9MjSCclbzSWvG8mH72tmFcKpKfRqa3g1YP8QzUIoSPuWRl
         VfC7wxNrZMh142P0OaR5q4xJ3A8rcTAIzhZSXShlqTSlELXp0V+oV4zQjnrmXwL8gBp7
         8Iy1gSh8L065we/ErvRTUYKpFeXymglr0A96fJfQmniKcFkQnfRxAr6e07HealZfhgrm
         H0r7FiZGM1Np9CXQUXmq3rMU4WLM/x6xnx8oh3NXwpxvXewCfyiF5eM6LzfF1sZdS2hU
         IflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHtQD/meuXaYe8UaCWq5ou0S7rpgnlSgQuuCrxXrgqE=;
        b=B08y4nEzMqW8RnKlM8UrFWHR+2Efmip+ZmFSg5uHWDprshvZdvwOgWEKyRnc0RIFNb
         WOOTWUy58VrcdkN7vK4XCUQBCYINJa/UTyDg/KsLEgyVgI2Wbi940Tq+3sajt69j2sp/
         Hge7k7xKdwS6WwDoGQQWczo6hEMJPN1K/SU+4rMzRUs85ElfNywrSgJe78FvxgmJ4DmU
         igPH4tMPA9r006YdU0vwGEwI5+Nre/2CNY9DNF+fvlSGDVM4mBITfwxQAeRL6zbJ3uIv
         miyRCtHi+9jVMqtGPyDGZEOIusFD7Po4P0BRlw49gnzCxJ7D+JesJFML4lL7E80DEyZX
         i4FQ==
X-Gm-Message-State: AGi0PuZE8iAcFoTH8dq0OzNcCrSqX21NRkH4v9GqGg2nce9mOKCoJOvR
        F0Rz2AMQJhY83UnjOg5CliE=
X-Google-Smtp-Source: APiQypI831li2YGPKN/VZUe6xPsQn9Sks+evd0nSUfRQDu+keljhtZbYvFFAXX996GgtLV3jKygrbA==
X-Received: by 2002:adf:80af:: with SMTP id 44mr10792605wrl.241.1586624246453;
        Sat, 11 Apr 2020 09:57:26 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id z11sm7781992wrv.58.2020.04.11.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 09:57:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v5] dt-bindings: gpu: mali-utgard: Add the #cooling-cells property
Date:   Sat, 11 Apr 2020 18:57:00 +0200
Message-Id: <20200411165700.1576314-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GPU can be one of the big heat sources on a SoC. Allow the
"#cooling-cells" property to be specified for ARM Mali Utgard GPUs so
the GPU clock speeds (and voltages) can be reduced to prevent a SoC from
overheating.

Reviewed-by: Qiang Yu <yuq825@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v4 at [0]:
- Added Qiang's Reviewed-by (many thanks)
- re-send because I missed the devicetree mailing list in v4


[0] https://patchwork.kernel.org/patch/11448013/


 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index f5401cc8de4a..4869258daadb 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -107,6 +107,9 @@ properties:
 
   operating-points-v2: true
 
+  "#cooling-cells":
+    const: 2
+
 required:
   - compatible
   - reg
@@ -164,6 +167,7 @@ examples:
       clocks = <&ccu 1>, <&ccu 2>;
       clock-names = "bus", "core";
       resets = <&ccu 1>;
+      #cooling-cells = <2>;
     };
 
 ...
-- 
2.26.0

