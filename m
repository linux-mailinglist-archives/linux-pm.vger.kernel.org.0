Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380AC2984A3
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418881AbgJYWWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419228AbgJYWSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A097C0613CE;
        Sun, 25 Oct 2020 15:18:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 134so6685589ljj.3;
        Sun, 25 Oct 2020 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13zJHfR9di8Ydxi+LOybO5H+JCALzXt2g6wK8WiSzjg=;
        b=pi1Sw4iTWdKb3u7G44iN1Cn4RgCnmCKT4Cn7nwd/pzgIhehiAyjKgeZwn8hOqMufC8
         CcxG1AvW1OXc8hMCB/mf069RbwynyIxk3cOnZ75TphnMCqGtMzFr/NNpChu5WHdesqom
         VhoC1QhuKhGgPdVxdSGEc8pSq3os1bBpgOhCmkiL88VH4/TZEDZEkRAzyvN863grCoSk
         jpDODAyRwNcgM374p9+B1XSbDcwgCy42J3AAwmxe1CIz0M+WiTIxWrLkH8+CodCNeY5r
         MH2CAsIMLGx9S+gGicsKZFzrbhyoK4ZNA1rqvRGkz2tIIeOahH6TZNfUeyLasZtTUJ5e
         sO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13zJHfR9di8Ydxi+LOybO5H+JCALzXt2g6wK8WiSzjg=;
        b=LM3B79STDmj4aTbizZIiTQQbqbF1igLmpYRdkYbEOtDkn5faUeyay3ICVpYzgprsvm
         jp5OwH/ulehLFZbd9Ifd8fEl8YUzlwsboR8zIxxtnAy33T0VWt8FUgs68xJJRHOHFeNj
         LsavvWqQe5tGTQlPIVDG2+CcOfWOz1xzxvaspu/AhzknPJDRWxdh/PqK6+1XLc+RGs15
         8kygk9Z+UXiM7gKN2Sa6eBgymQWnVkyty8s3rJyL03KsPdrFEk3PmassPcU/i/65MTMO
         mes9z+TcV2ApuKEVplsSx4PEKJw7aBQ6w0qpvZdCnntvPj6BS2lbme7PJV37NVkJ3wQh
         mkDQ==
X-Gm-Message-State: AOAM530X1LDKCf2Bu0pDGiB4Xobw1bvgdzgS0sAMaJj8GgQZwQoCwqpN
        aML7j4fGzWdPAT6K3uejl7/FnSFS9DI=
X-Google-Smtp-Source: ABdhPJwBZUmmqpaGlJ6JyqCamZD1xU0AZutTv50uc7sLPs/Uo7oOfST7uP7der6j6DDav/QMe22Plg==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr4864460ljk.428.1603664279071;
        Sun, 25 Oct 2020 15:17:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:58 -0700 (PDT)
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
Subject: [PATCH v6 09/52] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:52 +0300
Message-Id: <20201025221735.3062-10-digetx@gmail.com>
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
2.27.0

