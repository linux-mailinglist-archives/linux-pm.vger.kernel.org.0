Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D731F3BFA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgFINRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgFINOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:51 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F3C03E97C;
        Tue,  9 Jun 2020 06:14:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u16so12451003lfl.8;
        Tue, 09 Jun 2020 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cD6QbvUalU2rLnxp32Ky1as2vyVdkG0FzQ7kZtLukL0=;
        b=Q3BU6gEN8cA0NMpF2QMR7/ASta55aBJk7I1MDLK4koAixnvzP0ayWGZf3TbVJLF+65
         vId8KuOWkM8U5/Iu7EFpk85VTkAI1Oehc5+09VHXeLIo+3cVsuJq4oGVwhxOfGNsuvbD
         NY1D4HQAhEREDBvmx8hAhNZ0GxixaeV++zeo7LJMnNn7h/CFhkHfaAgF7SCKO1XsKJJY
         0ZyzEXamv8Ak+eCx/bhJHanQn+avSJOXU6PU4tk+eh+cUe2i6S0A4Jt1tYo88dL8dYJC
         s5eTYYMCyCjEBFckuvK4gbtaaU0Yeq9B1wPNhczvvoYJBXYoJl7pPyfH9SzzMzxPj2yF
         LUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cD6QbvUalU2rLnxp32Ky1as2vyVdkG0FzQ7kZtLukL0=;
        b=fhOqmMaU3lhgZeA0kzxjATepFWHp6msRMorZA/1N1nuF2UMWuX7ShUBEh80M6QahxI
         7F1Fl9x0xHXaNQvuyK+2nOlxtmNy9co2PRw6h+ZrbKJzR3M+5PTkxlMgAByWiVdw+bGk
         hA/1cnAq0yJnQHSIXqIyz/5WbDKOseVq+CaNo1KSCwH3N5Fzdze0ojkZC8TLe7+vGOLb
         l6M9MH4I63lIOTCdeTSXZUlLZZlJp+UP1Q3lCIOnZB1X08yjFuDcTvQuIwwXjEnJ6GVf
         WFYTPfrnd7Pk2rCT08l+vXRYWCNw7bHR+FitgwTJCsYwFswEkcFOb9/49DdkxtizF6U7
         1xDg==
X-Gm-Message-State: AOAM533rIxf86hceLB34YOypewxC6xZOkrydje/uiYaXE81YwPNB4vvt
        MBvECA9ULcBiw0p/0YA6l9o=
X-Google-Smtp-Source: ABdhPJy+RmOWQqGmO4euFmKISnOZyzVw/14wPtNZKhpxrmxeb6HuV6Wq/6xWdmnG+KQ6p+Izt7lD/w==
X-Received: by 2002:a19:6a09:: with SMTP id u9mr15434868lfu.65.1591708489649;
        Tue, 09 Jun 2020 06:14:49 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 20/37] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Tue,  9 Jun 2020 16:13:47 +0300
Message-Id: <20200609131404.17523-21-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 84fd57bcf0dc..5436e6d420bc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -57,6 +57,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -120,6 +123,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -135,6 +139,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.26.0

