Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BB25C2FC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgICOmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgICOif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:38:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C3C0619EA
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:31:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so3260232wrr.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v7riCkWqOW12WqwNbdYgi3MhtDbA8fxMcLkKxaVn1Q=;
        b=FxSMag+QeOzVZzZ+W/d4wUZ228qXnTc22tAxz97IrORD8jZ1HYcP+sq2f2Lx6LfZL3
         hCQmI3l6sISeNn78F6Z3VYf7cXFECd9N8RKUZSKARukgkj2KPTDjIQ10GSUQZ2e4kU1i
         5lq3epDjkN01sN0gOs9C3LbtQ6sDJ/49NDuxEpQXTerjREMHIdAX7obuKgHhjQb7KXWQ
         Z2+WlBaT30YpbYgKs+NkWSUG4DKGwNe0EF60dRWyW7HFlwDhxELhqAmCvLa6/kBrW/87
         TrIVqzw/5wBYmDyhC465Zn9R9K5WBAHLQZxAy/QZRgflKb/yJcaMeT2obJzIRa5fJ54F
         x3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v7riCkWqOW12WqwNbdYgi3MhtDbA8fxMcLkKxaVn1Q=;
        b=Yb2dyE3qcMfIyP0AO6lZi+2XVAJhjPqJsrN3zZJTrOzRke36U4yFuG8xN2yhhmM4QI
         ctKIjCLqC0Ysds4/H54avodGObVAlx3Bf3E88OVwWuY3TxzcCHsNqPu6lieV9UwenJJq
         B6ikikbLYvt9QK+atvVaGBT4Mc69aZgSRb0sE/rwOke/ei8iLem5taqd9brKq/EzkRqF
         9O8XqLhqIC6tIAFmFvE20afpfssYPFQNuXB+AJiyFlgHex0vKpr04tKZlD6+3+T8IIfv
         hwPoOLvLcyusUfBLtoARXqdeDhPUKOREtzQDPgv+iifs+T/kStn1YJlYTyARiCLhg5PQ
         p0QQ==
X-Gm-Message-State: AOAM532GoB+h6OPeQZHwjFyWQAR1uMS4fI5Zebie3pEm+ApygrSmzIph
        lr1jP7+VWogsB46+XsxNgwfxwacnRMxTCw==
X-Google-Smtp-Source: ABdhPJy2mm+MBBMVkV5XJikd7HS9L+iWlSQLCxuxQL9VOQRGQ/LByHjHzHNmXzyk4i662snmvdW6GA==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr2485171wrt.211.1599139899481;
        Thu, 03 Sep 2020 06:31:39 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:38 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] dt-bindings: interconnect: Document the support of optional path tag
Date:   Thu,  3 Sep 2020 16:31:29 +0300
Message-Id: <20200903133134.17201-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's document that we now support specifying path tag information in the
arg cells of the 'interconnects' DT property. This information would be
populated when the xlate_extended() callback is used.

Specifying the tag in DT will allow the interconnect framework to do the
aggregation based on the tag automatically. The users can still use the
icc_set_tag() API if/when needed.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..138c544c8c8c 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -19,7 +19,8 @@ directly.
 Required properties:
 - compatible : contains the interconnect provider compatible string
 - #interconnect-cells : number of cells in a interconnect specifier needed to
-			encode the interconnect node id
+			encode the interconnect node id and optionally add a
+			path tag
 
 Example:
 
@@ -44,6 +45,10 @@ components it has to interact with.
 Required properties:
 interconnects : Pairs of phandles and interconnect provider specifier to denote
 	        the edge source and destination ports of the interconnect path.
+		An optional path tag value could specified as additional argument
+		to both endpoints and in such cases, this information will be passed
+		to the interconnect framework to do aggregation based on the attached
+		tag.
 
 Optional properties:
 interconnect-names : List of interconnect path name strings sorted in the same
@@ -62,3 +67,20 @@ Example:
 		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
 		interconnect-names = "sdhc-mem";
 	};
+
+Example with path tags:
+
+	gnoc: interconnect@17900000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	mnoc: interconnect@1380000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	cpu@0 {
+		...
+		interconnects = <&gnoc MASTER_APPSS_PROC 3 &mnoc SLAVE_EBI1 3>;
+	}
