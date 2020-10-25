Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0529849D
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418887AbgJYWV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419242AbgJYWSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DFC061755;
        Sun, 25 Oct 2020 15:18:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a5so7686194ljj.11;
        Sun, 25 Oct 2020 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWndnYNPQqILNSiWL6iTiqZhdvnXENgisKXO1ZAuXRA=;
        b=D3yF5UWrGIQD6Q6QkzMYFLRBW922gtSyUQwXc87g+6+DHWwRO9e/5vmexGHJ+BTs7R
         A344NC9u3pwugBvx8H65M+GDXcM0MnMfZExfEY60l0kJsJe0sEN/ujsabgxyRJbE3zd2
         yTcqGIJEUsgoaVfYx+1THkPjR85b9Z7YzkawHNcHOd2CO9CZUZEfHvnS2a1TDPuuqbxD
         S3SPnd8Oz5mAtLTYbj9dVikWdbJbdcIyMl4ikcPPCKm+d3GRYL0bpotDxgu3EalYg8gQ
         ij8+y2iNMB+WXhWxcLvtjH/iXuYQY3qUatyRFfsOgZ/NgeNE08mgArkSUKjaNGsDCH+P
         Df2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWndnYNPQqILNSiWL6iTiqZhdvnXENgisKXO1ZAuXRA=;
        b=M12HLX6VJTPpuoYKLuJPlmMydb6LRQ9lMqrGputVAMnQCC3YifjsoysO/4eTkfQA7u
         AUTQbDh04usT6X45z/Xo+aFOO/DkfXQbYTvM8VAmjC5EHP1yko1Zpx/8VKj546hkPE8I
         1RpwxS4Ms9S0EaPQb1l9LR1arPf6gB/olJi7n8QFM1X2bnQykxHB3h/Hlmp4OeSwtto4
         5gI4TCgbG1ba5nJi0lNkmKiG8Pjxa2ia+kDrwoYtzthJcDmmSoA8jQAwWi2PsLGq/c7C
         H4qC60VLWmhY0AcdCpnvhKiWMu0WBR+VEg4d0oLlmUNYF4fIikNcHCWB6iFef+K/ZCac
         txQw==
X-Gm-Message-State: AOAM532VavO8+F2hUSS26HecqzsZNrZkJC7385R68A5czZatDuMjCnbl
        ZA0ivOcB7yNO8zRzGRYROPOANjD1UkY=
X-Google-Smtp-Source: ABdhPJzi0WSxLH2DDzGc0b4e6DF3+sSPvg8oMr3VqgPstg50fpHlDvAVDRrKx78J3l/YaXTc72mrQg==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr4767803ljg.311.1603664282474;
        Sun, 25 Oct 2020 15:18:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:02 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 12/52] dt-bindings: memory: tegra124: mc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:55 +0300
Message-Id: <20201025221735.3062-13-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
External Memory Controller. Document new interconnect property which
turns memory controller into interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 84d0339505b1..7b18b4d11e0a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -40,6 +40,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -104,6 +107,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -119,6 +123,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-3 {
             nvidia,ram-code = <3>;
-- 
2.27.0

