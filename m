Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9476F20EE38
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgF3GWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgF3GWl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 02:22:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF11EC061755
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 23:22:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so9471576pgq.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxI0dB1QFgZNIVokC1hI+G+Iqlv6A0nmADwj9+78Tks=;
        b=CdZajyIJHDjOv65E77khrmmw03A7NqdRALdHclmEq43x0A5YERCb9uk8uLW+tX46JL
         zSfex5IBG8VNGN9gNc70Fxurl907/DAYftlHGmLH9BFvsGGy8nIXnFHWNmHXHSpaSCz/
         qDqUQZaZcpY5ijqfUZnFDGCWEx6Lgt2HkKvc8oc/Ao9Z0RLEFiXPgur13RH4msc0NuBO
         7hSiDCK2LgMP9EW7nWsi0kh1ymWFCECLq47QkmJ+3IeZnRZoEHNQl8Zxe/GFOuFd5Q0D
         YXp8LhRkXDNS1eig3k5dfutAxsToJhnqtQW+V4e/4F7uLVYKOPTTAG6CHrxxWGv12DlY
         WthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxI0dB1QFgZNIVokC1hI+G+Iqlv6A0nmADwj9+78Tks=;
        b=JAQ30Bq95jdq1JtniVw2heEifaKYqrJoRpG2W8zrs61ttbA+6dbZSUnt8K8Y8+HDVX
         nsuGehZ1Zf1pNSLmTPJHOZTCY1p/Fs6bTLMNJNAL+l24oa8AftTIsDHIrx5UClOQSiDj
         aTr+2tA5wwZdL26hqYKc1NEYDH/3Mw5bBKFSha5aQxDByuXirM6xZEYbGDvwpZ8dXNvr
         W/PmA8Nni/0LjKynQrqWKQPNLUQZiS0mupmr2Q9w9M0jU0MjvOpnli9+4O9zd3/X+8jH
         OY1rM3kZd/rBa3gRRe/RIrNT9NcTSa0JVu+11AW+CZ5f7yA38A43/kmlZRJmPU4zusgQ
         HESA==
X-Gm-Message-State: AOAM530/kvZd7ny9CzRC9DR4GrLPqSfWckecT42JoSgvvKogMGtjvwTs
        YgwYgzXjRTvnCGnjbPx2kuK/4w==
X-Google-Smtp-Source: ABdhPJwkpX+UqkRhUMU2StSSepg0T7aIZhYVKhSZq4GziMwUla8dN0NFMDLDBH2U3p99v/31HC6nbw==
X-Received: by 2002:aa7:8f08:: with SMTP id x8mr2228098pfr.41.1593498161157;
        Mon, 29 Jun 2020 23:22:41 -0700 (PDT)
Received: from localhost ([103.208.69.16])
        by smtp.gmail.com with ESMTPSA id n37sm1486372pgl.82.2020.06.29.23.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:22:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update Amit Kucheria's email to a single email address
Date:   Tue, 30 Jun 2020 11:52:32 +0530
Message-Id: <8cbb7004a6a9b846a8d827f514f33f1a265dd5d4.1593498024.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Emails currently go to different mailboxes. Switch to the kernel.org
address so I can forward them to a single mailbox.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 +-
 MAINTAINERS                                               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d7be931b42d22..0985e65a9d871 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: QCOM SoC Temperature Sensor (TSENS)
 
 maintainers:
-  - Amit Kucheria <amit.kucheria@linaro.org>
+  - Amit Kucheria <amitk@kernel.org>
 
 description: |
   QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68c..f80cb6185662f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14230,7 +14230,7 @@ F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
 QUALCOMM TSENS THERMAL DRIVER
-M:	Amit Kucheria <amit.kucheria@linaro.org>
+M:	Amit Kucheria <amitk@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
@@ -16930,7 +16930,7 @@ F:	drivers/media/radio/radio-raremono.c
 THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
-R:	Amit Kucheria <amit.kucheria@verdurent.com>
+R:	Amit Kucheria <amitk@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
-- 
2.25.1

