Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B82360828
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhDOLV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOLV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 07:21:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF92C061574;
        Thu, 15 Apr 2021 04:21:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u4so26657237ljo.6;
        Thu, 15 Apr 2021 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KUMzHeNomWR2i0eeNj3li1B7DIkesg2mETLVTyl56s=;
        b=PqzCWRGWCX/lM2BiYpaSGAHTaTq3rAjnGFKWQn1zPCLWNXKwwtLDj/wlRv/jBKISak
         Mw2V5Ov7Xg2Gxip6PTjBGZSdMISLgmc4e+KD2lrCVb0HGHjjLQK2Dok8DRjtU9HOOcmZ
         SpTlAvZmgXG0HCmFxnyF9nxs0wHkf1wfLN3uEb/yOWjV4Sn14rhy2z2aKKioOQCs73kh
         gpz9dup8vGiPn9OQl/1F813I0GFMIVhu4pxoEnVqW8fCA+hkkU75Q0Et/QqmPydSNcVe
         5JysurD6ovgTZOx6mB2/vGomoBjCDS2d2HOx7Vqy2X1QdU4gcnmoEGDSLA3rEvX4uL7c
         OaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KUMzHeNomWR2i0eeNj3li1B7DIkesg2mETLVTyl56s=;
        b=Jkr7o38/Ol2j0qV88N3WUOMbZX4qWEiwm+s0bPxmJ7da0EHLxma0o5Jf0aqVcWR+IC
         rpAwNSLos3/igR2+E6MScDci7JZDS/qDQGWpnBGxCB7bCWxuGAhWvxIw68DJXR8/vWKm
         Lhpi6NX82isACjLQhXSqQ1H9gmnVnLXhz1+rOUUp67CUPt4/8iz1lKts7gV4ri4wYDRP
         UUhGwhLoIi/XtKi+kgz7GuPeclXDJ5NVpFjDCnJ/y/dZyJ4I4HRNCzd+29sST/kbKMMs
         mWaVI7bqEbZiS560eOKvZa9LSXEH5Dnaaby52aEnBroBeNGBVuzXR9I44ZSgBHQLU/7R
         FkVg==
X-Gm-Message-State: AOAM531jwbG2nYyz2dBUPHB4mKyMTFUw2vW5sPb1HVq3H487durapiQy
        d40JXV42AT8pncxsFD48yqI=
X-Google-Smtp-Source: ABdhPJyFi2GItQDg7KS+2OJ65/tO40fcA2io8a4Hgrc8Kuw9hKQI6APJx6Orcqql1PwU8PGRLclcdQ==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr1515461ljc.459.1618485690884;
        Thu, 15 Apr 2021 04:21:30 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r6sm629870lfn.27.2021.04.15.04.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:21:30 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: thermal: thermal-sensor: require "#thermal-sensor-cells"
Date:   Thu, 15 Apr 2021 13:21:21 +0200
Message-Id: <20210415112121.4999-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This property is required for every thermal sensor as it's used when
using phandles.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
index 9f747921e851..4bd345c71eb8 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -36,6 +36,9 @@ properties:
       containing several internal sensors.
     enum: [0, 1]
 
+required:
+  - "#thermal-sensor-cells"
+
 additionalProperties: true
 
 examples:
-- 
2.26.2

