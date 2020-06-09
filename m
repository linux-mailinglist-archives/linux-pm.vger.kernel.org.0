Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3143F1F3BF8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgFINRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgFINOu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB41C05BD1E;
        Tue,  9 Jun 2020 06:14:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so24997312ljo.0;
        Tue, 09 Jun 2020 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vef4FqcCqXDmWHyU61FfP5+51JqO6VMkIdhuYGZmgG0=;
        b=NuuffknpLSyUN9f4O3nAW/BwHLLuP3isFP/Y+0n/uFpoB7wO+F242cej8FG81mZU53
         /gpHTHEEssaWcp513OWvY2R9GGg3Ye8MU64qC0y/Jh467nELwg6zrl50vLuOjqFOuiXC
         lcJjkJd2PEftOSrVFKksrjOJrd2C3e01OcNnRauB1XcVBwczD5EAY7u/wKHHcLGPcCkC
         UQCpL5fQq92retfRpVKplkgDhS5dsTZkP32S5ErfenKRSjL1uEVDuwMQda8NTnas9C++
         dx8SMjBhiQIYIDT4+O2KWIKIljllH5I6PFXBRFpXZmR+9P3joIfp0/o8C1VwHyRhQ4si
         Kr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vef4FqcCqXDmWHyU61FfP5+51JqO6VMkIdhuYGZmgG0=;
        b=rvmiA5jtih6+fFrpWdU349OVxn4DX+5e0ixdgYB8OoSx2twl1Gt8Lx+1ZgdLxlb2SW
         HO8RZaOfytyIwmvHvs4ypmsFK8j9aee30qQAIvb2tfNZluktsxbUd9lKcDVoMB5inGP1
         fSBzqOqPjZ2hNEA9+mWKAbL9xAfQvmbYdslBwHdk4o7uGr9c5KbXXpy9Ook0esxtUqYF
         JrlcEUWPuBcbVJqUbUkPLEQpKOVXhnSYFPZ1FpbeYAUpCByRTo3T+ypheKiFPiXGiL6u
         Fhfuhm8XW+Wy1J+6v+fap3ueGwMuy+odc/j83AWEgaqPDXqSuzHagRM+14ooqKU3FLgc
         Mppw==
X-Gm-Message-State: AOAM533j1QQIAt1vXxXFTc9daZ7FSnU1TDY9BxamW+6u/v2otxdqA5Gj
        RQlrXAVJnV0cjeiTGKAYz+U=
X-Google-Smtp-Source: ABdhPJx0WeCYBWMps3AlkLTGYLKGv/akNMpWubTzAWIuEwnP6rPbBlRBpCn2dscDwurf8VClf61kGg==
X-Received: by 2002:a2e:9c97:: with SMTP id x23mr7926105lji.36.1591708488531;
        Tue, 09 Jun 2020 06:14:48 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:47 -0700 (PDT)
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
Subject: [PATCH v4 19/37] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Tue,  9 Jun 2020 16:13:46 +0300
Message-Id: <20200609131404.17523-20-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

