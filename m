Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8977FF35
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 22:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354963AbjHQUmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354959AbjHQUmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 16:42:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424002D67
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 13:42:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdbf10333bso1956225ad.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692304938; x=1692909738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJmAzvapOutvPkrb5k8FqNTcJnY32flwAQr4+re3BlM=;
        b=VzXNH3dV5IOgCFbXRiThrdo6uGwH5Ty9rguuRzFYLtZjhPNnNpR3XoUo71zdBOWeio
         /fnXP3FvC7UVlPnoH6DjAhZRoNkE70NTxuzp/DEfQhI5KYUMdoQXPmrFhcPPfg+KZ1x8
         jES41E3dA2rbmNcV/BlKUfrJDiD79PJRbZWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692304938; x=1692909738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJmAzvapOutvPkrb5k8FqNTcJnY32flwAQr4+re3BlM=;
        b=beVFfuTGY3rsAsSIlRB3kMufQF69v7v92N991dhWwOKLiFdZ4TZLJLEWXY5Zvj+p1y
         +RTkmJXjbMPaMVyE+h/XgQ2E9lEh1lk8jYNiAigq7VherwsEPKnsthTjhzxOQolecxiA
         RvwqHkl6Y93XQDpox9/zONBtVu80brKd0HLu96UC1TfQELki6nVm3y0cFHeJC8TitPkQ
         tcJjUoU5qiAS7zS54kUzN+BOqfmLIxLj1fUHva0XSUGAFYWyrIUG/9hjp3bpVGxY+od9
         gS48bVowIiI2+Haia1TpVGIglX9KbnRTHjGqoFl6zR+KNFgup7I9GSLp15el+v6AiDg2
         GaYA==
X-Gm-Message-State: AOJu0YwAr8F/dtb+9d19UL/UUhGAKCGeeHZYCQLtzyqJVQA3jEpdZSu2
        oNn+a6JqtGdbiq9ts9aW1MR5eQ==
X-Google-Smtp-Source: AGHT+IHrogL0Xdsxq0CyyNb4Qufw7ZNxe4F/xPT8gesfxkYm5vRUzu7UKbzv9OQeL/RnSUHmy4YKLw==
X-Received: by 2002:a17:902:e546:b0:1bb:a522:909a with SMTP id n6-20020a170902e54600b001bba522909amr594193plf.37.1692304937693;
        Thu, 17 Aug 2023 13:42:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001bdcc3a09c3sm177279plx.256.2023.08.17.13.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:42:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Annotate struct icc_onecell_data with __counted_by
Date:   Thu, 17 Aug 2023 13:42:15 -0700
Message-Id: <20230817204215.never.916-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AYpdhVDwJu2OwMLTaV1ZMwBOcGX4aSqyJvLvspWtvFw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3oYnMGx9/0oGfe2HMN10NNHiagAkOhbRsVfwM
 Ys/iO2HGTyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6GJwAKCRCJcvTf3G3A
 JuXoD/9ny0KtsXPv8eBrgFAzN2E9KziVmPDkfCMLhIKMVm9FuRbWrR3oO7uqOH33zE4R+E8DxWI
 vzT6ZAjJdKarN8uMYb5eHUUsbuUD/7+XrJoKqCQMGxWBd+AEpClnwhmpeNJc8ZzHEtLHPzfi5WJ
 iUvHSYP2eIiXrT1oXnGj4H1l1B35C+xFvAxgcRODvhlMJpHgzfREgVmAHBJdTrBJMZeA1LMnOkq
 ml0Bp69oEDEjFw+CymU/YELRg/Xkjprjw5z5T3GP/wgEHSmLHDMx2YIYzcBRrJtbvxlHyfylA0k
 ReHqltdFdWPI1MVxFUdj4THgbr9Y9AR6dLlV/55InecBVu8gdFxrIJAoJ5R9OsRWXsMHpueOgi0
 HMmTvGCiaKOwt5pzw6emTq14UVPraxEW8Xz0q9WHanedlDMUxyS0qg8RdJvVqdTEXyEen3AUXlN
 th13YeLFTH4K3jOyofErng0WWDPN096G/ae0fF2ck0hLypgE6zdkSEbAsKJKJMDpzgiYyyUClEm
 gl0WSUFJukJYk+VL2MmtEwwc5hu6TizQW72YO6gptGmTbEpCb38JW2/PPHysfh3QhOfm3S74pyG
 GafjfHCQgLQVnr8kocXTYYj+hhi9jLQ3VVgDRnhEqFXdHnygFu/pILCmvUSvu6Fe97NDDTvoH4v
 fd65EX+ oPRAlh9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct icc_onecell_data.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/interconnect/qcom/icc-rpmh.c  | 3 +--
 drivers/interconnect/qcom/msm8974.c   | 2 +-
 drivers/interconnect/qcom/osm-l3.c    | 2 +-
 include/linux/interconnect-provider.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 8053ec8ab01b..b9f27ce3b607 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -185,6 +185,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	data->num_nodes = num_nodes;
 
 	provider = &qp->provider;
 	provider->dev = dev;
@@ -228,8 +229,6 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		data->nodes[i] = node;
 	}
 
-	data->num_nodes = num_nodes;
-
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index b85cab2f208f..885ca9d6d4ed 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -675,6 +675,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	data->num_nodes = num_nodes;
 
 	qp->bus_clks = devm_kmemdup(dev, msm8974_icc_bus_clocks,
 				    sizeof(msm8974_icc_bus_clocks), GFP_KERNEL);
@@ -721,7 +722,6 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 
 		data->nodes[i] = node;
 	}
-	data->num_nodes = num_nodes;
 
 	ret = icc_provider_register(provider);
 	if (ret)
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 056ac91225c4..dc321bb86d0b 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -232,6 +232,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	data = devm_kzalloc(&pdev->dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	data->num_nodes = num_nodes;
 
 	provider = &qp->provider;
 	provider->dev = &pdev->dev;
@@ -261,7 +262,6 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 		data->nodes[i] = node;
 	}
-	data->num_nodes = num_nodes;
 
 	ret = icc_provider_register(provider);
 	if (ret)
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index e6d8aca6886d..7ba183f221f1 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -33,7 +33,7 @@ struct icc_node_data {
  */
 struct icc_onecell_data {
 	unsigned int num_nodes;
-	struct icc_node *nodes[];
+	struct icc_node *nodes[] __counted_by(num_nodes);
 };
 
 struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
-- 
2.34.1

