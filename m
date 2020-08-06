Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A123DFA0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHFRvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHFQcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13639C02B8C5
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so39517688wrs.8
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=rDkRS6zy1V+kPfp+/a8fkd3XWxVI36H7Hci5dkKNDtqe7glv3N01cuhkrd9149KBrp
         KqkqRLtj4VFf4J5D2yIR5qFHExE+56hq+F86aoeNqR2YTFyg7+29Ftq/JxxICKK+t/uP
         4EPyBAPK3afS2C+RGssubuyDS1X2VmflQyupcqs/imRgPFfht4CL/pZM4ZF4AA1UXQGC
         c8Tnhq57i6SnofcJ0PgQ8/HJ/vTN3fSezs9s2+IHsj1Jk3e9KBmEQ6ODk4hf6J6NNrGc
         oWcMJ/dxevSCE/kW447IzlLPCiXDgDxe91/zr8mttDdVpDTbNrgVWUE09FqwZJr4IOoH
         sT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=NPKvDNlolW5QuSOseLuQwhbdsoG7zviu1aHdnUtUhOVQp4+I5ID1xa1+uLzGfioNnb
         4EWqYbGQ9JUt2M/PwPz0PT/ZAAWFJIMLZq/wbV11xuQkMOJPUNLAvxBgtrauQQIhNB1c
         +AzlTEGFX092uH1oVrb5v3UbZAusliidrFk9d94vqo1jdMVfKffPL9J+nuGHmaAvYvnf
         Pc9qOyCdIcGFvjd9mXfKDAhZrx7UMGv+m+5T/d3fyoPMAWq23ah7t4zbasSmr1c3Kdy2
         b2F6R756xRgUkToXCyeCJJE/cvnUpk0gFL/g3feXWLmylRAKFH+gT2Ae54962eqc1/Ve
         MHxA==
X-Gm-Message-State: AOAM530eb11qRqFngCUzQNoESFsW5zf+1YHfgfAm7zbc2aKy8jwGrE8e
        Tgh4DxRAz2Lz/NbxBsFfMtDJzB40E8w=
X-Google-Smtp-Source: ABdhPJxEWkKxjmYT87kSQKI/wM2IQuf7tTYF26VwCw7rIKhm7CGMFJ0ShTSmBNzBxRiYEhaR4GamdA==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr8195593wrm.275.1596731495462;
        Thu, 06 Aug 2020 09:31:35 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] interconnect: qcom: sdm845: Replace xlate with xlate_extended
Date:   Thu,  6 Aug 2020 19:31:23 +0300
Message-Id: <20200806163126.22667-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..3b81dbb71b0b 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
