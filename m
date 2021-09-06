Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9027401AE5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhIFMGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbhIFMGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 08:06:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7BC061575;
        Mon,  6 Sep 2021 05:05:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dm15so9223500edb.10;
        Mon, 06 Sep 2021 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In9AqwxG6kQ9Z2Bk5c/A+CJjxcpZ+YKTzhcivosE+ZI=;
        b=iqO00bcQFNZF13Jj6amSx44PsCVInDTUO87KiRNOIINyFBpjPUn8qfHLCYihpbCjUL
         +vbGecOmdqECGj6DApBtUue8VWyBuR86X8HOW6CNaKgXVlnNtPRD3QVmE80rkukG2Z+A
         XESmlXdDSjXmbupmWU0X3gle/LLd+DhXOLNJ7/wpubYi2yI4zVQEdDOIt59TsSuQJkxW
         hUBysiQ30hWdwxCAQ4XNq5oEnQ2onL6EY6dbsUte14D8HD3eG9oQmult2ymNmu4jS89A
         ECGHW48jNYAdX5yRURa/K96AwqrMRz2EVJiHQhSu6Ag/anSOJhmcE6Mggm6wvDh/7orx
         KgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In9AqwxG6kQ9Z2Bk5c/A+CJjxcpZ+YKTzhcivosE+ZI=;
        b=IsemVauVqvsCAU25JeSRrQmRV7XobkY+pU4ijDM1uFpJDk+sqRNbYVO68QFn1OREWA
         LwK1x721UUhvKWS0zoaxXnBXGkQaZYfnhjC9Q8Rvp3tlzTokAniCb+zUY9AOqSyD7O1Y
         xvKW4D6jfFIpwHXA/nvHOeQlvNTdF4nKUqJtG82vY9ah8uhBGHd1R5zm1Ate1KZJFcOc
         8eQaIiHGKzcBc80XWSofLp82rj7bebxJ/zEIXcO/j1E+UyZWzKlkkeT9iKpGeRplroS0
         NdMbLOafnBCr0JNOQA2xNtjWXAr8AFZufPtHbrMYu3aRZm/2HkGBg5s0OELeaNfJYpky
         JtaA==
X-Gm-Message-State: AOAM533P3tpS3CKkbcWjhUA2BYD6EmrMsz9ginn9m6VOHZdzcBLGyNGn
        2jjhLbyboVebwdmnrb5yYzM=
X-Google-Smtp-Source: ABdhPJxOOCo2ca3Si5A7uvngo7vEXqfO8X5NR5B7TPIdx8OOX7kX/c866e8Lfd4yYReXDI6gp0LmCQ==
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr13285183edu.352.1630929933230;
        Mon, 06 Sep 2021 05:05:33 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b8sm4536954edv.96.2021.09.06.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 05:05:32 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] dt-bindings: thermal: allow more resets for tsadc node in rockchip-thermal.yaml
Date:   Mon,  6 Sep 2021 14:04:01 +0200
Message-Id: <20210906120404.10005-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tsadc node in rk356x.dtsi has more resets defined then currently
allowed by rockchip-thermal.yaml, so fix that in the documentation.
The driver now uses the devm_reset_control_array_get() function,
so reset-names is no longer required, but keep it for legacy reasons.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b96ea277b..ee104e451 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -37,11 +37,16 @@ properties:
       - const: apb_pclk
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
+    deprecated: true
+    minItems: 1
     items:
       - const: tsadc-apb
+      - const: tsadc
+      - const: tsadc-phy
 
   "#thermal-sensor-cells":
     const: 1
@@ -71,7 +76,6 @@ required:
   - clocks
   - clock-names
   - resets
-  - reset-names
   - "#thermal-sensor-cells"
 
 additionalProperties: false
-- 
2.20.1

