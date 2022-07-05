Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947955663F4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGEHXy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiGEHXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:23:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E726D8
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:23:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so10679610pgs.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8GOhMLFyDiMe/PWwqzfb33XEJXhUET7VHmLSmkqB8s=;
        b=L1wjsa6UgH7zTZAojwegmxSgqCHiVWRWdgs3esbawqUkkfi4nWvwapbnjMjLJ1AICf
         D+EwLLXJGUihQdkTr5mEwgJFcxeEEAiVJXU7CQ3g5aV97FbueIDyTLDTvr8yUYZKgcgf
         Yl856J8yVy/Vp3GMDRvCnn7HmfieBKxZ4a3RaXu2wq8aeb+tTtb41IGe+0eXx+HqIu5J
         DsmJUE/Oth+px6CzO27VdfHtqREHb+Plbyar6C71xuCIOflsK6aRfjyXke/QLTjwYkHB
         aCzwyGIBb+GNwMi517V+EFqE4HO9M8FTRAKhAJCRIZtyJ8Vnf7YynMI+xSiPF2rGd6zf
         86Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8GOhMLFyDiMe/PWwqzfb33XEJXhUET7VHmLSmkqB8s=;
        b=Y+i5D6OWOdlpApCXHoj1Frxkl0+99lHUDW9o+At7CI1cWJqVcwyQperVWkDqe5U4cp
         HOViou+j63ax/8gihukNQCCsMfL5D3zDSspWZydVPa4re4GIw67SuoJOUR43+v6gBfXV
         +NHaOK+CyvgDSI5PwZASwDM2zzpia1hyOmo4iWGc6OC6brw1ap6u3hwSvaaxx89ApCGC
         GS8o+ifdcxF8v3dzYNTqSaNPKv20wV+h10VdmccxiGP2VzSpUY+VizqL+KvZiXvIrW81
         m4FY7snG8MtaIUsa5tnGQcuzE+/UquAeTfUfNypm6JfbF0k+adUVukGN5OJG4rcAbF1V
         VtEQ==
X-Gm-Message-State: AJIora/i/5k/28ZEUBL0Tc4hEtL7vyRdi39KT/kxNnWn7O/rYGJV23lS
        tNvoVOG5U3Q73pTVH4FyfsjKjA==
X-Google-Smtp-Source: AGRyM1uAoO2xXA3Kt7V8isGhq6D7OZ7jqYR3fjLuhGjdPWtGMc9x6eP5EfumWorOyONQ21IXatfF2w==
X-Received: by 2002:a05:6a00:1592:b0:525:52ca:bee6 with SMTP id u18-20020a056a00159200b0052552cabee6mr39579633pfk.38.1657005831329;
        Tue, 05 Jul 2022 00:23:51 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0050dc76281f0sm22148016pfb.202.2022.07.05.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:23:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: interconnect: Update property for icc-rpm path tag
Date:   Tue,  5 Jul 2022 15:23:32 +0800
Message-Id: <20220705072336.742703-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705072336.742703-1-leo.yan@linaro.org>
References: <20220705072336.742703-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To support path tag in icc-rpm driver, the "#interconnect-cells"
property is updated as enumerate values: 1 or 2.  Setting to 1 means
it is compatible with old DT binding that interconnect path only
contains node id; if set to 2 for "#interconnect-cells" property, then
the second specifier is used as a tag (e.g. vote for which buckets).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 8a676fef8c1d..4b37aa88a375 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -45,7 +45,11 @@ properties:
       - qcom,sdm660-snoc
 
   '#interconnect-cells':
-    const: 1
+    description: |
+      Value: <1> is one cell in an interconnect specifier for the
+      interconnect node id, <2> requires the interconnect node id and an
+      extra path tag.
+    enum: [ 1, 2 ]
 
   clocks:
     minItems: 2
-- 
2.25.1

