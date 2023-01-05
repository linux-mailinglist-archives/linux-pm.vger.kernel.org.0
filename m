Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723665E173
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAEAW3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 19:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjAEAW0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 19:22:26 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9543A3C
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 16:22:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v25so5432048lfe.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 16:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce4nWtQTzmJz9V5Gg6kSD4rQYBwczLgo3Cm/X4Z1bnM=;
        b=fNPGDAg8iGnqEaZ91hIwN5lSd4fBxyM61qSNgJ1HV48KBU15MHJYKrvRQmKZZp0qbP
         B00F7ce53KCZb5itXQybmkB8fqQFzH5TzcTE768Sm6cQEUZ/evN1DwfVLHI94slk8AMZ
         +cW4qC53TU930mKHKuk40cZrBKUE+GHr07XreevoHBlTKjLLKH02QD1tZ5L4U6gh2XWM
         mNRJcaNc+I0eP7Ty7xr79MVg2NY/4bhy7cgOUEbyk1JWPBnN1Qorz5jIRLEr5MzkEyc5
         Z/7hxUS6hwzUZ1CMOYvgPQ+ByBPI09sIxlCF0iwal7Ln6gZzA+YjkH2z0IPgsmJX4boD
         ujvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ce4nWtQTzmJz9V5Gg6kSD4rQYBwczLgo3Cm/X4Z1bnM=;
        b=VuNaAeX6UVCBBDd7ZhORmbFgYALYxbrbO3u9sqgjhhv6k5FM6m09pFBPUAu5tUZ3zH
         pMgNPzZsWn/rspsniCNNTbdSKHg7Pq3aSNhF8PuHLfpKyYFioXMaN3dHoij241iEUb1w
         KUyXePf/AfGuS7gOTJcMfjPKJhBxBaiFSxuIH8HuZGL0EFhD+xd0FX4LBDWBqrGyDpoM
         VpBhuas9dnx/L267YnyUeN7UQXPHDnvkRmMFCrhO5FKziLnFpW3mPR7IHGYTY46HGczG
         W/jyUJuZXvEqDFew2o5bxJbgiv/CXhGouJu9VOvhkAer1mQHFNLaUKeiMK54B4d0lx6Q
         B1VA==
X-Gm-Message-State: AFqh2kr/89laP2lhUjiBOh2eaz1ZlWV/XDnLRcDSFI/tq998gaOzMCtc
        p5FBpJ6xpt5YMH5epYm6LzpRuA==
X-Google-Smtp-Source: AMrXdXuo4m6fRH68Gv3wTjgQmGY0TETXWABcNyklOH66bt+kOw3MwvfrXmvu3U0+WeT7Rk3ZJl93wA==
X-Received: by 2002:ac2:5fce:0:b0:4b5:850e:6f4a with SMTP id q14-20020ac25fce000000b004b5850e6f4amr15697082lfg.69.1672878144080;
        Wed, 04 Jan 2023 16:22:24 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020ac241d2000000b004b4cbc942a3sm5291992lfi.127.2023.01.04.16.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:22:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/3] interconnect: qcom: osm-l3: fix icc_onecell_data allocation
Date:   Thu,  5 Jan 2023 02:22:19 +0200
Message-Id: <20230105002221.1416479-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
References: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a struct with a trailing zero-length array of icc_node pointers
but it's allocated as if it were a single array of icc_nodes instead.

Fortunately this overallocates memory rather then allocating less memory
than required.

Fix by replacing devm_kcalloc() with devm_kzalloc() and struct_size()
macro.

Fixes: 5bc9900addaf ("interconnect: qcom: Add OSM L3 interconnect provider support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 5fa171087425..1bc01ff6e02a 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -236,7 +236,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.39.0

