Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9565B998
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 04:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjACDMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 22:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbjACDMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 22:12:05 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B617663
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 19:12:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y25so43952724lfa.9
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 19:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCjiEmXUYnbjFVfiSeM2EsCcdRG3Q61lkX+E+R/5tlc=;
        b=TVZmtCJKkqjW8xB3xCSXqnNRDgW8fSGsWi9OdBfs9G2AsCifpPghDZnWsTteFZ3D4i
         iR8P4lIEMOQ5UxKkuPJ7Cx5yYj+URW+4XY2w8DD5bIQmcTjWMNowld1KL8RKrwjUmeEC
         jAkWhvYag+z2zdCKTkTb1ywyB66F/7bxMRoFAKA8CeA3G3xHjnfv/3HD07uo5y6OFH2Q
         s8//LjuvOzAVhNFT/ybqr7SSC96/LXhyqe1Rhh9qB2p+A3yfZbqMyCWLUjzxJ1onvSuq
         BcFEV/BKGulL90kZ0s3D90vAcwfWh9yNODeiwyjakZSt8ueTQwzTn0Rj3bTJbNeucSqd
         0/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCjiEmXUYnbjFVfiSeM2EsCcdRG3Q61lkX+E+R/5tlc=;
        b=nFV37hProC5bmnwtv9npSHlaafSXegGcZ8oCZcQVe+zIrlBW1SznIQLdVQiXIcfB7d
         rkERWxuob8N8e4crJZI65oJ7ZNAnQprLMn6HaHPCe1Rr49Q9OkUrSrVCikB7N0mmVSuo
         OLOsBZVkSQj8mJLQApuXm6vKxjsItkuFNqm+oX/GXAvmdDc1v8LueVwTEwN35VSCszpO
         zyt+hQ+FCWSnIKHUg64owwzBo8YcFQ9+Cf3CxbJwOYHbXeacYzUwp2ILJrrbG1nPEVH7
         +DJ24m7EIwz5ksHaTeV44MkWfsLjK1FO1IW1Rfax6XXuHCxqagCAU2XIXKeArXxx2nL0
         An6A==
X-Gm-Message-State: AFqh2kqfE/XkqPRD5lJtUCTFrMqgT9SU8TSatYZw+m+x6n/BDrHO1B3T
        pNdv1aXyoWwO3+F889+p/peE/g==
X-Google-Smtp-Source: AMrXdXtIQRGMqv4A/BKs2WEewXDuC6PEnpbRmvXREgkD3BQ3PDisvGDgPbjuufOrB94PChQi1lwQgA==
X-Received: by 2002:a05:6512:2255:b0:4a4:68b8:c2ad with SMTP id i21-20020a056512225500b004a468b8c2admr13040415lfu.4.1672715521387;
        Mon, 02 Jan 2023 19:12:01 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a14-20020a19f80e000000b004b384ae61absm4671890lff.198.2023.01.02.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 19:12:00 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: osm-l3: drop unuserd header inclusion
Date:   Tue,  3 Jan 2023 05:11:59 +0200
Message-Id: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 4529992c9474 ("interconnect: qcom: osm-l3: Use
platform-independent node ids") made osm-l3 driver use
platform-independent IDs, removing the need to include platform headers.

Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 5fa171087425..0c907765783e 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -14,13 +14,6 @@
 
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 
-#include "sc7180.h"
-#include "sc7280.h"
-#include "sc8180x.h"
-#include "sdm845.h"
-#include "sm8150.h"
-#include "sm8250.h"
-
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
 #define LUT_L_VAL			GENMASK(7, 0)
-- 
2.39.0

