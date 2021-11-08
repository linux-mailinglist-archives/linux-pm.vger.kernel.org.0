Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A09447B6D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhKHH6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 02:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhKHH6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 02:58:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98DC061570;
        Sun,  7 Nov 2021 23:55:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f5so14420511pgc.12;
        Sun, 07 Nov 2021 23:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xqgLvPTDCnKC5hYEuOViZqk0Fgwk6c0mN0Bc2+QXyrw=;
        b=gqPeGL8ecT6H1jLDPsvp2h827qEKtjXfldqCQKdf+lK5L2nPSWHWZ3LMwvW94gd8R8
         7cCSwHIlXsY7hZ9IAXRnEW4oKQh6/bZFlCUn9oLTTzj2nxd0690Ak+J7FlZMdXZQ/SL+
         BE9pVEwZ9sNQBHTJD9KCC4wtSgblJcV7pWcJhXFeDDBrkViwX+nna9z3kOnsWw+/AbMB
         Hz4k3693l4wwk1vP+ywCfLyNhnVbYQRqIpm0eyVWEkioeFGxjJUB0ZAZbphlzIeUTVF2
         PCnZD985ocyCkYjvCPtdiYHNpqTY4AlmGxr8LnwSYPHXdV9QM6kp1fygRqiOybGyK0i4
         2vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xqgLvPTDCnKC5hYEuOViZqk0Fgwk6c0mN0Bc2+QXyrw=;
        b=UQJIBLE5JVOLCKknQb/h6qxK0kjdAasVgM0/iAehL78+cppLwK0BOTHXNuvV8oFFMy
         YdGrviZHIEbsMuRducNnym9Tbqswg8fiOhuW5GUM7ytEl5MtTvrHqh98OwJnJgezlN2i
         E9zkZ+wY5w0O2EVoXVSApJSTGcTZz2yFLOeff9uIxyKSHiuYejfGCbhWT9TVqjyvB1Gu
         /AFxlzFy0uFPuyWjEL6gkg3qvC7VWfYRhGJemNaC9OWOlodATss09jfDg4d22cActyFd
         DWY7trN6Q5tPIE9M09RJN7pWr3CFSO7TLPYCUHWS4Os3zbhcQ8J+/tbxFDnDBrPt2z6N
         mVfQ==
X-Gm-Message-State: AOAM530l1vFUJJs66+S3QDmEYgwRnkVqDgcfP5Bm9hf9Y3j8KI7re2Zp
        JceT1eIZANpydhjbni5i7PY=
X-Google-Smtp-Source: ABdhPJxoOLWFuCaIJ6hxA7CCysVNTy/rRMb3vrZtPRKmeK0AOv79UGtodDDudEUgImTuZ6CUaNkE8A==
X-Received: by 2002:a62:4e87:0:b0:47b:dbbf:c6f0 with SMTP id c129-20020a624e87000000b0047bdbbfc6f0mr79355514pfb.47.1636358119413;
        Sun, 07 Nov 2021 23:55:19 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ep15sm1631150pjb.3.2021.11.07.23.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 23:55:19 -0800 (PST)
From:   Edwin chiu <edwinchiu0505tw@gmail.com>
X-Google-Original-From: Edwin chiu <edwin.chiu@sunplus.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     Edwin chiu <edwin.chiu@sunplus.com>
Subject: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string to sunplus,idle-state.yaml
Date:   Mon,  8 Nov 2021 15:55:09 +0800
Message-Id: <5d2231d33d647d24d2b95c9f652687f7f1dccd2d.1636356928.git.edwin.chiu@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1636356928.git.edwin.chiu@sunplus.com>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
In-Reply-To: <cover.1636356928.git.edwin.chiu@sunplus.com>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatible string for cpuidle state on sp7021

Signed-off-by: Edwin chiu <edwin.chiu@sunplus.com>
---
 .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 55 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
new file mode 100644
index 0000000..649e953
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus/sunplus,idle-state.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus cpuidle state
+
+maintainers:
+  - edwin.chiu <edwin.chiu@sunplus.com>
+
+description: |
+  Sunplus SOC cpuidle state
+
+properties:
+  compatible:
+    const: arm,idle-state
+
+  entry-latency-us:
+    description:
+      Worst case latency in microseconds required to enter the idle state.
+
+  exit-latency-us:
+    description:
+      Worst case latency in microseconds required to exit the idle state.
+      The exit-latency-us duration may be guaranteed only after
+      entry-latency-us has passed.
+
+  min-residency-us:
+    description:
+      Minimum residency duration in microseconds, inclusive of preparation
+      and entry, for this idle state to be considered worthwhile energy wise
+      (refer to section 2 of this document for a complete description).
+
+required:
+  - compatible
+  - entry-latency-us
+  - exit-latency-us
+  - min-residency-us
+
+additionalProperties: true
+
+examples:
+  - |
+    idle-states {
+      CLUSTER_SLEEP_BIG: cluster-sleep-big {
+        compatible = "arm,idle-state";
+        entry-latency-us = <8000>;
+        exit-latency-us = <700>;
+        min-residency-us = <9000>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..52f17ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS CPUIDLE DRIVER
+M:	Edwin Chiu <edwin.chiu@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
+
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

