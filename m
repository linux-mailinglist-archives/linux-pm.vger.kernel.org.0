Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7074EE5B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjGKMUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjGKMUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:20:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9702685
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b700e85950so85732911fa.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077940; x=1691669940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKS2SK0W5nsBINlksNeBQjYUnc/qHbIAD1PYowN4Eok=;
        b=S/X0GGjSJTV+VnLh2tuqcQ5XWvuajVH9p2wY83XhlYPLGsKKo7QULljsbzG88xOClR
         6YFIZyEgQh2NT3hC/2B/n0707tPPoMPVXfESZXDEPOnL6zqeObWTfpaH8KYveX6px+P6
         21TWCr3x4XVqvnhLrvS+mUQ5O8Kabvxr9eqTsZIf8hOmquryWXtxbpDbtwAZr7x1I4gX
         NjqCnE5FawZyNBVRK1SJhi8smkcFSlfkBxAFYGrZFAsch3zO6oy7pABNRAfViwGEO32R
         UkKHPuXMAcF4kEgl9SjC5FIv8ZPj6V0rbkh8G4CyR2F0oiFXzk85qQmOFbDeYXBMmPw9
         x9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077940; x=1691669940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKS2SK0W5nsBINlksNeBQjYUnc/qHbIAD1PYowN4Eok=;
        b=JfRfQ4esljDoDQPsTr0x+RSJaLJsMMb7EsfdIFB+mBMEgA2v4RN9HBLuCS51faNmzK
         MR4J2oH54qk8fU/JHHbqWdCKxLVyBPSAl5//bssQpSfg0dGHhnNkw4hE811gbi14hkh9
         A5v0cdARZGcu5f+jwoIHClub23u5nJpxfn1UUvndpCVQrgjzqp2CRugeMdP9YW46sJjq
         9CThul7jvZ09i7xqoT+ka4fcEuwnWpoSNQuFv4jfsy9S2pDvYwgKsZSVTvZTli4pf0I+
         +xKk+nCHLgy15ZL+6rnmH+rvSnQC2QmBPdDLmSyYZLEAAO96ljJKDyMLxKY/F1J+ejbi
         J36Q==
X-Gm-Message-State: ABy/qLYcNKYlguSoudEz0qwNuZKWZs0RZcSBZAE1J6Kf/BRY+aW87MMP
        mfoAdWMX8WPSp6Nc/wwbOoDJvA==
X-Google-Smtp-Source: APBJJlG8IuuLHE9jv8dBtHVEsSeLt6su5vbR50FA9D2D/+Lc9g2U3TgoBse94+pcxbxyD/nh2VjVIg==
X-Received: by 2002:a2e:9206:0:b0:2b6:ba00:f733 with SMTP id k6-20020a2e9206000000b002b6ba00f733mr12471543ljg.18.1689077940157;
        Tue, 11 Jul 2023 05:19:00 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:24 +0200
Subject: [PATCH 25/53] interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-25-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=963;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4QbqX9qEiwnykOnp3T41q/aNjoSl3d0wkDdtwzmuC9Q=;
 b=KRB7LLVjGAZUDlQ6RmEwKiP2CeNYEuzZIz/3UkIO9aa7zYQPnhOJzN+j7mjNIJXqSehfercoh
 RO54QxvYyekB6AHJF4LoEHDTgGiagtGPZdFwxdVTK3Z7JOtfdppI723
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This helper has no users anymore. Kill it with heavy fire.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index 30b324fcb2ee..62cdee94b5ba 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -12,14 +12,6 @@
 
 #include "icc-rpmh.h"
 
-#define DEFINE_QBCM(_name, _bcmname, _keepalive, ...)			       \
-static struct qcom_icc_bcm _name = {					       \
-	.name = _bcmname,						       \
-	.keepalive = _keepalive,					       \
-	.num_nodes = ARRAY_SIZE(((struct qcom_icc_node *[]){ __VA_ARGS__ })),  \
-	.nodes = { __VA_ARGS__ },					       \
-}
-
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 

-- 
2.41.0

