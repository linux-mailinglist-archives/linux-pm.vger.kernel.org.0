Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BD486883
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 18:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiAFRbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbiAFRbo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 12:31:44 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86664C06118A
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 09:31:43 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c10so1263170qte.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgGIgMajEhcXcb+pSiiU8hULLmnW3Ix8+OrCDOiX3Lw=;
        b=Jo6aOpRcqwgI1DHuAffeVnOLWMf0maPodl1wC1IQJq7vARxmfu+Ue9aSJc4yugEI4p
         g/2Bq7w0n9AuMlWZlOOslHlaI8qBSCc0vtrE+g05Dkk7NZnFchZR3i7B6hJoegjpSE18
         wfKSaXEugDx9AQIqP32HpdpeMj8P2f6r0queG+dCI2fjF7K5daJkAZI12QzVKyBE5gFt
         aMr0w98EAqRDp+2CBvDXAUK4CXzdJmkpfve6qvuhPXOV64Vjq27yLAXibZ/3QQQEbQAs
         iVhuJr3wFhiQzI0rpwndBz8ZESpWrmR3Xnmhx6ELhkbgeRY7c1PQ9KsfWeIGGq6suDHO
         XrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgGIgMajEhcXcb+pSiiU8hULLmnW3Ix8+OrCDOiX3Lw=;
        b=Qa+ZyoUmXc1r6JI9VpI+3MfmacmbMchAEzhIs/CLtQzjdZx0aDdcA+0Bvcgsl4FC+V
         MX0cX1TRr4Hy2dgzCb3OhWxod3hHr1fjJr9QjNiBvWnZEQYdb4p8/gej97BrEE61zf35
         S8OziPjX4D8NtSYsVi8hVrBHgDUcjPN3Tt4Pur8SAfMmI3BTAwJOVFhJxFqI7dWLLy7w
         1hdsmk5ROjhufufqKwRT9d5lbFICliQ5+PwevATDZgaI0oXzHVkdmBfq1esduBaxYO12
         MT4/W7ly1J2ICFDESGOJzG/0dto58CYgqQUetTes7oK5VdOKdr6DRQVwm3f4+GEI30A4
         7eFg==
X-Gm-Message-State: AOAM532WKVyhp6BCx3VrzJBRNoPGO5SaHK3zSia4mCX49tfPQ/3RMYvL
        2DAUwtne+ytl5wGRJ7nk45NwoA==
X-Google-Smtp-Source: ABdhPJxV1YhSckhNaETNVUzcFICOYgIeIzL0P7GqkFpNo8sOKp0GrBfISIqDVzY7He5aFMmfCGamtg==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr53231851qtw.242.1641490302620;
        Thu, 06 Jan 2022 09:31:42 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i21sm2126536qti.31.2022.01.06.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:42 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 3/3] dt-bindings: thermal: Add sm8150 compatible string for LMh
Date:   Thu,  6 Jan 2022 12:31:38 -0500
Message-Id: <20220106173138.411097-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106173138.411097-1-thara.gopinath@linaro.org>
References: <20220106173138.411097-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the LMh dt binding document to include compatible string
supporting sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 289e9a845600..a9b7388ca9ac 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-lmh
+      - qcom,sm8150-lmh
 
   reg:
     items:
-- 
2.25.1

