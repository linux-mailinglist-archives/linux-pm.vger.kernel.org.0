Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953161F0E47
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFGS5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgFGS5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82532C08C5C3;
        Sun,  7 Jun 2020 11:57:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so8851809lfg.9;
        Sun, 07 Jun 2020 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vef4FqcCqXDmWHyU61FfP5+51JqO6VMkIdhuYGZmgG0=;
        b=TS8fGzYytLtTT/px0GlFwerGCThxAj5OO43kcgyM6cPOY7liUEu2g105G/da5bXHUi
         NrwqxCNx0e7Wn5G1Hdm7NvwcnKMweUospIXopYDf4MzxrSbZ0CpHSO51zEbLAIVzPaop
         6ynkgc+SLMAMgTDYwg+opo1dZbK7bcpnKHl8zDPbFbVJpU6z3pLoNamVRsBgGT9DEaie
         wC+Cg1Tvl0OYWf5bGXn+A/VbHXRFzWCR6OF7+28syjcug3tfQ/z1RnlRyAQ4+97t8of2
         mmGPtvmJJr5SoNPAhOVMafec78lP0SyrlX9b8KIYT8eNDzZ0BVxIzNoAvM2plOWWY4CP
         gs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vef4FqcCqXDmWHyU61FfP5+51JqO6VMkIdhuYGZmgG0=;
        b=FVgplZQFZ/k/pKCiJTsqEWEOm9MWyHPOXrHyWk1qBQM1A382A4URmks6I2I2gg/dsA
         szhcksPxGu7dTipv/V3SVPN3wPHg8CSCDn0gFHw6FvoiEW5TduihymAqfgb6fZPlIf+T
         IgqM0OswQE/lDRKYwNPVdm9O6C6lAgKhYpWyQpAG0hr3lihJ4DM5u8YcgcJRYD/zNgyk
         ukQlttdhX/5FtpwV+MZUqGRRZAPW3SjjqmOEa6dqq2EdqmF5yAcRRcQpvsQKZeFvBTP/
         NxBIBXnMxugd4Tt+Nqh7AdDe0kBQSu6j1r8sFtjNVjLkYSBPjxdzin9ZKdY67340qi0S
         XgDw==
X-Gm-Message-State: AOAM532wjq1LPcvJAnuTj46FkvTkTPQVmLLwSfAC4VfB2TFZ+6/aJWHt
        mdC0MARRY+X494MzBCcumWw=
X-Google-Smtp-Source: ABdhPJyU1ZfwlAOtsF5N+kWpO1lDlq6wJghIBRE9U+gCIClpNOA80FdDiwHkErGm1j28esods9vH1g==
X-Received: by 2002:ac2:5ecc:: with SMTP id d12mr10892740lfq.165.1591556255053;
        Sun, 07 Jun 2020 11:57:35 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:34 -0700 (PDT)
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
Subject: [PATCH v3 19/39] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Sun,  7 Jun 2020 21:55:10 +0300
Message-Id: <20200607185530.18113-20-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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
2.26.0

