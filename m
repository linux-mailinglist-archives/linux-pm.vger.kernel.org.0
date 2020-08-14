Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6392441F6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHNAHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgHNAHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB392C061757;
        Thu, 13 Aug 2020 17:07:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so8082661ljg.13;
        Thu, 13 Aug 2020 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGCT3sNWog9i79de3oECaNCIcXqg0vqeqpgOXfgBL2s=;
        b=oTqX2EUnl8HGI3rFllgGCao9PaM5Hs34AwPJeMF9eTiUMjyHYXZtj+/MuAXb+y52t5
         1nr3rx4eILLbhY2W2CXfYI9Osik1Ev1oTRxp+3Qa5v4G+8vMfmNvJP9TKQbs9faYmRKU
         BomDWe9pUNflgvawX/esQ3OoGvt4ui55B5pn61+MgueKcIhiRhuljfn9kEDE9aTEJpjV
         h9lLQ6JllmIeq7/n9ZggMjmht6qiDliS8rIf2Ou8SIbzGF9HL/sixX8AOQsj01s09LIS
         emdPxTSlTXrqx3X+OQUU3Xw6y+uFFDVVQi+l8qsbd4FpX5LLOyP+wQu3BOFYi/KP1VcC
         NpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGCT3sNWog9i79de3oECaNCIcXqg0vqeqpgOXfgBL2s=;
        b=WFsIFqZBD8iNfk/RerDIRo2ljC7moSI7PZiIi5P+2G1FI7QhU2x4kNhOVRMiGnJHvM
         YT8BOyJp9tkHLzF0a/owdGFmnYb/dZ0zhTjyDCZaqNeaOvi/XvGJVWPIOWB+4X6Aatae
         w4/01hc6lQtCJwmHFfwFAVksXkY2kPh4AT2+wTy6zUxkipMAsfhR+mH/kDZHRfQyCbSy
         ea7ImrRxNfY3CAyToctvUpWA7VbcBw4CEmw2sFjRFCVrJhsmZMGxyYXl0Tfb8zMvCnz+
         aqZiQenpfG9vloxmu26UTLitJiRXY3+pNLSbfRQIHaHRSu/ZMIj4FQSyTZywC1e3qngS
         ubag==
X-Gm-Message-State: AOAM530UmXu2J/jK99YgfB+b3wIksS9JeD9kgEC8tC4kO4qg77NlEdDr
        BRJsEaECZVRAlquoG7Lvya8=
X-Google-Smtp-Source: ABdhPJx0a/vfIjLaMytuE/JHr3pwaIdv8cFEDvBL3Mn+6obC4nXwTuYaAYAVzNyWTRpeneXHlaIVGg==
X-Received: by 2002:a2e:b708:: with SMTP id j8mr102010ljo.375.1597363642405;
        Thu, 13 Aug 2020 17:07:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:21 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 19/36] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Fri, 14 Aug 2020 03:06:04 +0300
Message-Id: <20200814000621.8415-20-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
external memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index add95367640b..f51da7662de4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -12,6 +12,7 @@ Properties:
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
+- #interconnect-cells : Should be 0.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
+		#interconnect-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
-- 
2.27.0

