Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02CA2983EB
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419257AbgJYWSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419252AbgJYWSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250ECC0613CE;
        Sun, 25 Oct 2020 15:18:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so7711573ljj.8;
        Sun, 25 Oct 2020 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oT3sPxYlD0f5rXGVTXjyzzDhRaGcEVEDE7YAWGRs3gU=;
        b=JoyKX/QHfqWqa4YyD0X90GcfMoSm/O2cHzBgCzoDNuCH9SMX64wZ402uVy/4f3SHrV
         vUWhZRFhevJ0QofNW9iKCFas2rA4ecV1wPY74mOhtZcwqAD9QwhktH4NPJa+0ufHWAKS
         qtftWzxG/3KG/aQmG062y46nAHz7fRAF04LwFmsKJG3di03ylo7lt2ip4DMv/BCBd9OC
         AdoUaCjIDKtHywK3mQoT9vRSkC51vnrRL0bj5ZhWgINdIauD+pbkzygMaii7qn4QxhIv
         ewgZ3th9fvr9WX+liab1+wzMsDbDB8uYIt1UO24a2hTR1/BtXqZ9ZFLwhPZ8N1CmiPt9
         Wn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oT3sPxYlD0f5rXGVTXjyzzDhRaGcEVEDE7YAWGRs3gU=;
        b=Q5Z0qUQJuQcq6iLLoQMGrs+mkcwMIyMChQih0NwY+lHr3kVFKaBHkS0OlT8xAsDE85
         jCFD6YsSl37D1v+s/FM0S5Wfvebmztsiw2cCLuNnqJUGWERubEMoW0l8ckS+jBkikfZP
         Tea9NDBAhPKM2pEPDOy+is/n3POnFIQUwP9uCRmIUO8FDmieq9oGkULaWLJks93ZDwdG
         N1B/4d/aHGeYNIN8FM5t5rvng1+mOjv+/lmenPWC7RVwwMBKY1l4i/Glud0fahmYMfhK
         sUZklXf0IoLgxIxbj8ZOcHMBtHHZCaNfizuKAKFKTMUM49bO/wRi7ZiRGDU/4j3LA+AA
         QsVg==
X-Gm-Message-State: AOAM533X9bGjaOUjBtIPxECW4gMKnCOXINHh8G+vVJHTuG+aYk67L5rw
        nHK00phVp3xcfYaUzwUDlsE=
X-Google-Smtp-Source: ABdhPJyMT3ti+ZhxL7PMZN9YlmhstodXl+iv7QlqlUkp9W0m/vYM5YJpS2lYW8+Gy8ctqNqgIxUZUw==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr4291302ljj.371.1603664284677;
        Sun, 25 Oct 2020 15:18:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:04 -0700 (PDT)
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
Subject: [PATCH v6 14/52] dt-bindings: memory: tegra124: emc: Document OPP table and voltage regulator
Date:   Mon, 26 Oct 2020 01:16:57 +0300
Message-Id: <20201025221735.3062-15-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new OPP table and voltage regulator properties which are needed
for supporting dynamic voltage-frequency scaling of the memory controller.
Some boards may have a fixed core voltage regulator, hence it's optional
because frequency scaling still may be desired.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra124-emc.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index ac00832ceac1..3f74cd173ba0 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -37,6 +37,15 @@ properties:
     description:
       phandle of the memory controller node
 
+  core-supply:
+    description:
+      Phandle of voltage regulator of the SoC "core" power domain.
+
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -359,6 +368,8 @@ examples:
         clock-names = "emc";
 
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+        core-supply = <&vdd_core>;
 
         #interconnect-cells = <0>;
 
-- 
2.27.0

