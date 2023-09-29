Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BE7B37AD
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjI2QQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjI2QQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 12:16:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65F1B5
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:16:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40566f8a093so112261205e9.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696004211; x=1696609011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MikOgdHnw9Cj1F3F15+YBxnX7Q0cPaNa5HmAcMHbwVs=;
        b=Up6A5L6slPRGd0ev40c2i0B4MtiiT2z2ZzBA5H7gxs141wmsXDs3ev2NNjHO6kfxgB
         1slgibq/awH6SzdmUjG8yQnZJ1YM1yrQVWMtY0UeI+YwJbk1NcrcPOMVCfGpCx/MhQYX
         oDpxTbtKGSOq/xujlqAwcxFgC/YRwuqUV+SCr+TbWBvWvAmEbKS1TqyKTfV55srfzXxk
         znD7pReiYo7x7afeC+RbZ8k1nn34+oQN7Rh7SimBkbXfB2zH/JwA8UY6EBxxOAvjjeTj
         L4RN653xogllCaioSYfuVxSPIONxNwoQMoJIvDMKTyzDqhItXUqlA+3dpk23fBRN/sIB
         PTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004211; x=1696609011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MikOgdHnw9Cj1F3F15+YBxnX7Q0cPaNa5HmAcMHbwVs=;
        b=ho/Bs29IfRgPP0BSD1U+U6elYfo/ONyJ08zseacfrOL4RqlEJYtMYkd8ipNDpmSf3/
         /tRXnkhLIoAyfGBdTLymVUO8nTi2ZTmNexv4le4tCYv3mT7I4xrTL5i6LUPoSGFzspmm
         hkqvUcxg/vI9KAOwMz9irCOLmWUbGQdauCF2XVvl9KXLMDruodY00QV2/ipomNceZ/7G
         KlAIBBSn9j0H7VPxIQC3N4Xp92OlMEOvThmxH3dEuQ57J72Y3h4vDmvVkAdgppEPV8BO
         2LlUYQucqaBpJcCwdhUMI7CCdhRiBtGpZVlr87W5VivioOFCCc/LH4AhwX9I7NIP8zUG
         SFnA==
X-Gm-Message-State: AOJu0YxtBDgZ1gpFxlqkIA+GnB/8q2j+YpcyHriIuhX2IS8v2OhOWVZ7
        /pO5YK/HqMNmgspymNmB+wrOZQ==
X-Google-Smtp-Source: AGHT+IGh9+hHCV8PgonNR9t6AFEVc/cDbuI0Aqd6VW8dFYYBRvr/czuKcfiIKkHf283fsaQY+Cme5Q==
X-Received: by 2002:adf:f5c3:0:b0:314:350a:6912 with SMTP id k3-20020adff5c3000000b00314350a6912mr4034356wrp.36.1696004211549;
        Fri, 29 Sep 2023 09:16:51 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id x15-20020adfcc0f000000b0032330e43590sm10226848wrh.22.2023.09.29.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:16:51 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
Date:   Fri, 29 Sep 2023 17:16:20 +0100
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Qualcomm Cooling Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-caleb-qmi_cooling-v1-4-5aa39d4164a7@linaro.org>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
In-Reply-To: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=874;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lGmSgXW2XFQ/63QULMjMdPqhafuryymoFyIIA0vaTv4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlSxH3k3+Bf291/I99V6oPb+kdyaZ+r2Kh0Zr0ryDjwKT
 X47/eahjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR6aIMf0WmOf4TP2lWzrrO
 Z86kBbf+Pnwx+brP5aM537axFL9jkGRm+B+dkP7m9KzXj94U3tmz1+oo1631m720+J2ksk6djA+
 b4HAfAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add myself as the maintainer for the Qualcomm Cooling
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01dde0acebd3..d92cfa1dd57f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17800,6 +17800,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM QMI (THERMAL MITIGATION DEVICE) COOLING DRIVER
+M:	Caleb Connolly <caleb.connolly@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
+F:	drivers/thermal/qcom/qmi-cooling.*
+
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.42.0

