Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318FA169206
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBVWEs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 17:04:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32915 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVWEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2020 17:04:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so7820279wmc.0;
        Sat, 22 Feb 2020 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WecMb7XC+F71BDVsaL32uLe6ZzntKQ/HmvHZGIxKOJo=;
        b=vaQRLUiXMysRiqAX5vXIJmFxStAF6yVfmi7kTKH6PDgx7XQtA6hIFgpYkLBjVc7dkk
         b246OiYA+c5qNP4lkL0WZFN9Q3/rs5qeIfuyhJnqmAHPTvSb89mC0nK+f0+2yzCdwHEY
         XCRmEOYlLF0u19r0cdKa4w8fShbIQ3J6Gy+/i6lVbPtl/5PMWz16MoSF/AI3cFTRfQBg
         NQ+sWNAucuPhBBexOVEvTIrQ9lbL4O+/5NXAoj0RF3jro7onhpxUgjl/JumoRTDPtKkd
         b+W8cKKUM7/pbC9US5LV/dEoD++R3xcnCGlFxezyIV+P4ZmidMBfqIxtBiSh+6LEP81d
         AOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WecMb7XC+F71BDVsaL32uLe6ZzntKQ/HmvHZGIxKOJo=;
        b=CzNJ+SMIdJbe5umgv9E8SEdPlgIJqayPSVTbNQ6Ft3FAehhB6iI4JZoelRAjtZ0Zaq
         uMd8ymbgAYPmUf0xS1XuJqlKd1MuX3V0jp+6jYrS1UV2ilq+Ss8N/IH68SMTK3ctiMoT
         BDXDwKIUdHtK8h2k0i5nvfvknuzFvsbEpAAcbnsNMNqcwdhh3Kq0zvCT4liMyXO0GFbv
         mvp8tm6Ueo4FgeEPovynwWvUXIr0cAmEtWwCY6sj1cCM7dFZSuu/U0Wpat/RqtPDUkIV
         079eO8vvW2QZ6x7t3adgkwjBDske/eGCrw1I3ZbOo0Ti+VCBZ7069eJyWAfzbZ2gMrp1
         U72A==
X-Gm-Message-State: APjAAAX6EnaPNgQHBx5ZBGEQzBtKUd6nnACwGcF0Z/RHDuomsy8JbfyS
        Jhx8kt4Ov0roMqIkOpDNH6I=
X-Google-Smtp-Source: APXvYqzs7BVHkeHnT7UYxo1FTYom5hTfpobIJ3SJTo2JpyOe1y1s1pwDWzNEu/vAeDHrx55v44VS4w==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr11567948wmc.145.1582409086211;
        Sat, 22 Feb 2020 14:04:46 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q130sm11151738wme.19.2020.02.22.14.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:04:45 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        linux-pm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v3 1/2] dt-bindings: gpu: mali-utgard: Add the #cooling-cells property
Date:   Sat, 22 Feb 2020 23:04:31 +0100
Message-Id: <20200222220432.448115-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200222220432.448115-1-martin.blumenstingl@googlemail.com>
References: <20200222220432.448115-1-martin.blumenstingl@googlemail.com>
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

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index afde81be3c29..33548ca2a759 100644
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
@@ -162,6 +165,7 @@ examples:
       clocks = <&ccu 1>, <&ccu 2>;
       clock-names = "bus", "core";
       resets = <&ccu 1>;
+      #cooling-cells = <2>;
     };
 
 ...
-- 
2.25.1

